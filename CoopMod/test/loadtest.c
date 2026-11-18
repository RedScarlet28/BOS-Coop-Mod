/*
 * Offline check for the proxy, run by build.ps1. Usage: loadtest.exe <dir>
 * <dir> must hold the proxy as Bos.dll plus the original as Bos_core.dll.
 *
 * Verifies that every Export* name the engine asks for resolves, that the
 * proxy can load Bos_core.dll and forward a call, and (via coop_proxy.log,
 * written next to this exe) that every hook matched its expected bytes.
 */
#include <windows.h>
#include <stdio.h>
#include "../proxy/exports_gen_names.h"

typedef const char *(__cdecl *fn_str)(void);
/* thiscall methods called as fastcall with a dummy EDX: same registers, same stack */
typedef void (__fastcall *fn_upd0)(void *self, void *edx);
typedef DWORD (__fastcall *fn_upd1)(void *self, void *edx, DWORD a1);
typedef BYTE (__fastcall *fn_ready)(void *self, void *edx, DWORD flags);

static BYTE fake[0x400];

int main(int argc, char **argv)
{
    char path[MAX_PATH];
    HMODULE h;
    BYTE *core;
    fn_str version, build;
    int i, missing = 0;
    (void)g_export_per_frame;

    if (argc < 2) {
        fprintf(stderr, "usage: loadtest <dir>\n");
        return 2;
    }
    /* In the game KT_Game.dll owns 0x10000000, so Bos_core.dll is always
       relocated. Reserve that range so the test exercises the same path. */
    if (!VirtualAlloc((void *)0x10000000, 0x29A000, MEM_RESERVE, PAGE_NOACCESS))
        printf("note: could not reserve 0x10000000; Bos_core may load at its preferred base\n");
    /* load the engine too (as the game does before Bos.dll) so the proxy's
       KT_Game.dll hooks get their byte checks exercised */
    _snprintf(path, sizeof(path), "%s\\KT_Game.dll", argv[1]);
    printf("KT_Game.dll  : %s\n", LoadLibraryA(path) ? "loaded" : "not loaded (engine hooks will be skipped)");
    _snprintf(path, sizeof(path), "%s\\Bos.dll", argv[1]);
    h = LoadLibraryA(path);
    if (!h) {
        printf("FAIL: LoadLibrary(%s) error %lu\n", path, GetLastError());
        return 1;
    }
    version = (fn_str)GetProcAddress(h, "CoopMod_Version");
    printf("proxy        : %s\n", version ? version() : "(no CoopMod_Version export - not the proxy?)");

    for (i = 0; i < NUM_EXPORTS; i++) {
        if (!GetProcAddress(h, g_export_names[i])) {
            printf("FAIL: export %s missing\n", g_export_names[i]);
            missing++;
        }
    }
    printf("exports      : %d/%d resolve\n", NUM_EXPORTS - missing, NUM_EXPORTS);

    /* first export call triggers Bos_core.dll load + hook installation */
    build = (fn_str)GetProcAddress(h, "ExportGetModBuildVersion");
    printf("mod build    : %s (forwarded call into Bos_core.dll)\n", build ? build() : "?");
    core = (BYTE *)GetModuleHandleA("Bos_core.dll");
    printf("Bos_core.dll : %s at %p%s\n", core ? "loaded" : "NOT loaded", core,
           core && core != (BYTE *)0x10000000 ? " (relocated, as in the game)" : "");
    if (missing || !version || !core)
        return 1;

    /*
     * Drive the two guard hooks the way the engine does, with zeroed fake
     * objects. Without the proxy both calls fault exactly like the in-game
     * crashes (Bos+0x60639 and Bos+0x85F90).
     */
    memset(fake, 0, sizeof(fake));
    {
        /* SINGLE_RIGID_BODY::Update: actor (+0x74) NULL -> straight to the guarded call */
        fn_upd0 rb_update = (fn_upd0)(core + (0x10062090 - 0x10000000));
        rb_update(fake, 0);
        printf("rigid body   : Update() on a body with no model returned (guard works)\n");
    }
    {
        /* PICKUP::Update through its (patched) vtable slot; there is no local character */
        void **vt = (void **)(core + (0x1020171C - 0x10000000));
        fn_upd1 pickup_update = (fn_upd1)vt[3];
        pickup_update(fake, 0, 0);
        printf("pickup       : Update() with no local character returned (guard works)\n");
    }
    {
        /* BeginPlay readiness wrapper: DYNAMIC_LIGHT slot 18 (0x1005C2B0) answers
           "ready" for an object with nothing attached; the wrapper must pass it through */
        void **vt = (void **)(core + (0x101FA254 - 0x10000000));
        fn_ready ready = (fn_ready)vt[18];
        BYTE r;
        if ((BYTE *)ready == core + (0x1005C2B0 - 0x10000000)) {
            printf("readiness    : FAIL - DYNAMIC_LIGHT slot 18 is not wrapped\n");
            return 1;
        }
        r = ready(fake, 0, 9);
        printf("readiness    : wrapped DYNAMIC_LIGHT readiness returned %u (expected 1)\n", r);
        if (r != 1)
            return 1;
    }

    {
        /* engine loader log detour: call KT_Game's SAVE_MANAGER logger (cdecl) with a
           manager whose own logging is off; the message must still reach our log */
        typedef void (__cdecl *fn_log)(void *mgr, const char *fmt, ...);
        BYTE *kt = (BYTE *)GetModuleHandleA("KT_Game.dll");
        if (kt) {
            ((fn_log)(kt + (0x1008B1F0 - 0x10000000)))(fake, "loadtest message %d of type \"%s\"", 42, "PICKUP");
            printf("engine log   : logger detour returned (message should appear below)\n");
        }
    }

    /* negative control: the same call on an unhooked copy of the original must fault */
    _snprintf(path, sizeof(path), "%s\\Bos_control.dll", argv[1]);
    {
        BYTE *ctl = (BYTE *)LoadLibraryA(path);
        DWORD fault = 0;
        if (!ctl) {
            printf("control      : could not load %s (skipped)\n", path);
            return 0;
        }
        __try {
            ((fn_upd0)(ctl + (0x10062090 - 0x10000000)))(fake, 0);
        } __except (fault = (DWORD)(GetExceptionInformation())->ExceptionRecord->ExceptionAddress,
                    EXCEPTION_EXECUTE_HANDLER) {
        }
        if (fault)
            printf("control      : unpatched original faults at +0x%X (the in-game crash was +0x60639)\n",
                   fault - (DWORD)ctl);
        else
            printf("control      : unpatched original did NOT fault - test is not meaningful\n");
        return fault == (DWORD)ctl + 0x60639 ? 0 : 1;
    }
}
