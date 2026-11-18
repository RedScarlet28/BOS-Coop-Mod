/*
 * CoopMod proxy for Bet On Soldier's mod DLL.
 *
 * The engine (KT_Game.dll) does LoadLibraryA("Bos.dll") and resolves all 64
 * Export* entry points by name; a single missing one aborts mod loading. This
 * DLL takes Bos.dll's place, loads the original (renamed Bos_core.dll) and
 * exports a stub for every entry point. Each stub logs the call and jumps to
 * the original with every register and the stack untouched, so calling
 * conventions never matter.
 *
 * On the first export call it also installs a small set of hooks into
 * Bos_core.dll. Every hook checks the exact original bytes first and refuses
 * to patch anything else, so a different Bos.dll build is left alone.
 *
 * Addresses below are Bos.dll virtual addresses at its preferred base
 * (0x10000000), exactly as they appear in a disassembly listing. Bos_core.dll
 * is always relocated at runtime (KT_Game.dll owns 0x10000000), so every
 * address goes through VA().
 *
 * Output: coop_logs\<exe>_<timestamp>.log next to the executable, one per
 * run; coop_proxy.log names the most recent one.
 */

#include <windows.h>
#include <winsock.h>     /* types and constants only; ws2_32 functions are looked up at run time */
#include <intrin.h>
#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <math.h>

#define COOPMOD_VERSION "CoopMod proxy 0.76"
#define BOS_PREFERRED_BASE 0x10000000u

static HMODULE g_self;
static HMODULE g_core;
static BYTE   *g_core_base;
static DWORD   g_core_size;
static FARPROC g_real[64];
static int     g_idx_before_loading = -1;   /* index of ExportModOnBeforeLoadingLevel */
static int     g_idx_update_sim = -1;       /* index of ExportUpdateSimulationMod */
static int     g_idx_movie_start = -1, g_idx_movie_stop = -1;   /* ExportStart/StopPlayingMovie */
static int     g_idx_render = -1;           /* index of ExportUpdateRenderModAfterAll (every frame, even when paused) */
static int     g_npc_equipment = 1;         /* coop_config.ini [proxy] npc_equipment */
static int     g_coop_save = 0;             /* coop_config.ini [proxy] coop_save */
static char    g_test_lua[MAX_PATH];        /* coop_config.ini [proxy] test_lua (file run before InitLevel) */
static char    g_coop_lua[MAX_PATH] = "coop_mission.lua"; /* coop_config.ini [proxy] coop_lua (co-op layer, run before InitLevel) */
static int     g_coop_lua_loaded;
static DWORD   g_coop_tick_at;
#define MAX_HUMANS 16
static char g_human_names[MAX_HUMANS][64];   /* MP players who connected (their characters' names) */
static int g_nhumans;
static DWORD g_human_conn[MAX_HUMANS];    /* their connection ids (chat sender match) */
static char    g_game_dir[MAX_PATH];        /* folder of this DLL, with trailing backslash */
static volatile LONG g_spawn_report_pending;  /* set when a level begins play */
static int g_run_mission_scripts = 1;          /* coop_config.ini [proxy] run_mission_scripts */
static volatile LONG g_mission_pending, g_mission_started, g_mission_armed;
static DWORD g_mission_armed_at, g_mission_pending_at;
static DWORD g_census_due;
static const char *nw_state_name(void);
static void install_lua_capture(void);
static void admin_on_print(const char *msg);
static int t_rng_priv_fwd(int d);
static DWORD   g_t0;

static BYTE   *g_kt_base;                    /* KT_Game.dll (engine), also preferred base 0x10000000 */

#define VA(x)  (g_core_base + ((DWORD)(x) - BOS_PREFERRED_BASE))
#define KVA(x) (g_kt_base + ((DWORD)(x) - BOS_PREFERRED_BASE))

/* ------------------------------------------------------------------------ */
/* logging                                                                  */
/* ------------------------------------------------------------------------ */

static CRITICAL_SECTION g_log_cs;
static HANDLE g_log = INVALID_HANDLE_VALUE;

/*
 * One log per run: coop_logs\<exe>_<yyyymmdd_hhmmss>.log next to the
 * executable, so a solo baseline and several multiplayer attempts can be
 * compared afterwards. coop_proxy.log always holds a copy of the latest run's
 * path for convenience.
 */
static void log_open(void)
{
    char dir[MAX_PATH], path[MAX_PATH], exe[MAX_PATH], *slash, *dot;
    SYSTEMTIME t;
    DWORD w;
    HANDLE latest;

    GetModuleFileNameA(NULL, dir, MAX_PATH);
    slash = strrchr(dir, '\\');
    strcpy(exe, slash ? slash + 1 : dir);
    dot = strrchr(exe, '.');
    if (dot) *dot = 0;
    if (slash) slash[1] = 0; else dir[0] = 0;

    _snprintf(path, sizeof(path), "%scoop_logs", dir);
    CreateDirectoryA(path, NULL);
    GetLocalTime(&t);
    _snprintf(path, sizeof(path), "%scoop_logs\\%s_%04u%02u%02u_%02u%02u%02u.log", dir, exe,
              t.wYear, t.wMonth, t.wDay, t.wHour, t.wMinute, t.wSecond);
    path[sizeof(path) - 1] = 0;
    g_log = CreateFileA(path, GENERIC_WRITE, FILE_SHARE_READ, NULL, CREATE_ALWAYS,
                        FILE_ATTRIBUTE_NORMAL, NULL);

    strcat(dir, "coop_proxy.log");
    latest = CreateFileA(dir, GENERIC_WRITE, FILE_SHARE_READ, NULL, CREATE_ALWAYS,
                         FILE_ATTRIBUTE_NORMAL, NULL);
    if (latest != INVALID_HANDLE_VALUE) {
        WriteFile(latest, path, (DWORD)strlen(path), &w, NULL);
        WriteFile(latest, "\r\n", 2, &w, NULL);
        CloseHandle(latest);
    }
}

static void plog(const char *fmt, ...)
{
    char buf[1024];
    int n;
    DWORD w;
    va_list ap;
    if (g_log == INVALID_HANDLE_VALUE) return;
    n = _snprintf(buf, sizeof(buf), "[%7.3f] ", (GetTickCount() - g_t0) / 1000.0);
    va_start(ap, fmt);
    n += _vsnprintf(buf + n, sizeof(buf) - n - 2, fmt, ap);
    va_end(ap);
    if (n < 0 || n > (int)sizeof(buf) - 2) n = sizeof(buf) - 2;
    buf[n++] = '\r';
    buf[n++] = '\n';
    EnterCriticalSection(&g_log_cs);
    WriteFile(g_log, buf, n, &w, NULL);
    LeaveCriticalSection(&g_log_cs);
}

/* "Bos_core.dll+0x62268" style names for addresses in interesting modules */
static void addr_name(DWORD a, char *out, size_t outsz)
{
    HMODULE m = NULL;
    char path[MAX_PATH], *base;
    if (GetModuleHandleExA(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS |
                           GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT, (LPCSTR)a, &m) && m) {
        GetModuleFileNameA(m, path, MAX_PATH);
        base = strrchr(path, '\\');
        base = base ? base + 1 : path;
        if (m == g_core)
            _snprintf(out, outsz, "Bos+0x%X (VA %08X)", a - (DWORD)m, a - (DWORD)m + BOS_PREFERRED_BASE);
        else
            _snprintf(out, outsz, "%s+0x%X", base, a - (DWORD)m);
    } else {
        _snprintf(out, outsz, "%08X", a);
    }
    out[outsz - 1] = 0;
}

/* ------------------------------------------------------------------------ */
/* memory patching                                                          */
/* ------------------------------------------------------------------------ */

static int write_code(void *dst, const void *src, size_t n)
{
    DWORD old;
    if (!VirtualProtect(dst, n, PAGE_EXECUTE_READWRITE, &old)) return 0;
    memcpy(dst, src, n);
    VirtualProtect(dst, n, old, &old);
    FlushInstructionCache(GetCurrentProcess(), dst, n);
    return 1;
}

static void hexbytes(const BYTE *p, size_t n, char *out)
{
    size_t i;
    for (i = 0; i < n; i++) sprintf(out + i * 3, "%02X ", p[i]);
    if (n) out[n * 3 - 1] = 0; else out[0] = 0;
}

/*
 * Redirect a 5-byte "call rel32" at site_va (which must currently call
 * expect_target_va) to hook. Returns the original target, or NULL if the
 * bytes did not match.
 */
static void *hook_call_site_in(BYTE *base, const char *name, DWORD site_va, DWORD expect_target_va, void *hook)
{
    BYTE *site = base + (site_va - BOS_PREFERRED_BASE);
    BYTE *target = base + (expect_target_va - BOS_PREFERRED_BASE);
    BYTE patch[5];
    INT32 rel;
    char found[32];
    if (site[0] != 0xE8) {
        hexbytes(site, 5, found);
        plog("[hook] %-26s site %08X: expected CALL, found %s - NOT installed", name, site_va, found);
        return NULL;
    }
    rel = *(INT32 *)(site + 1);
    if (site + 5 + rel != target) {
        plog("[hook] %-26s site %08X: call target mismatch - NOT installed", name, site_va);
        return NULL;
    }
    patch[0] = 0xE8;
    *(INT32 *)(patch + 1) = (INT32)((BYTE *)hook - (site + 5));
    if (!write_code(site, patch, 5)) {
        plog("[hook] %-26s site %08X: VirtualProtect failed (%lu)", name, site_va, GetLastError());
        return NULL;
    }
    plog("[hook] %-26s site %08X -> ok", name, site_va);
    return target;
}

#define hook_call_site(name, site, target, hook)    hook_call_site_in(g_core_base, name, site, target, hook)
#define hook_kt_call_site(name, site, target, hook) hook_call_site_in(g_kt_base, name, site, target, hook)

/*
 * Replace one vtable slot. vtable_va/slot identify it; the slot must
 * currently hold expect_fn_va (relocated). Returns the original function.
 */
static void *hook_vtable_in(BYTE *base, const char *name, DWORD vtable_va, int slot, DWORD expect_fn_va, void *hook)
{
    void **p = (void **)(base + (vtable_va - BOS_PREFERRED_BASE)) + slot;
    void *orig = *p;
    void *expect = base + (expect_fn_va - BOS_PREFERRED_BASE);
    if (orig != expect) {
        plog("[hook] %-26s vtable %08X[%d]: holds %p, expected %p - NOT installed",
             name, vtable_va, slot, orig, expect);
        return NULL;
    }
    if (!write_code(p, &hook, sizeof(hook))) {
        plog("[hook] %-26s vtable %08X[%d]: VirtualProtect failed", name, vtable_va, slot);
        return NULL;
    }
    plog("[hook] %-26s vtable %08X[%d] -> ok", name, vtable_va, slot);
    return orig;
}

#define hook_vtable(name, vt, slot, fn, hook)    hook_vtable_in(g_core_base, name, vt, slot, fn, hook)
#define hook_kt_vtable(name, vt, slot, fn, hook) hook_vtable_in(g_kt_base, name, vt, slot, fn, hook)

/* ------------------------------------------------------------------------ */
/* game state helpers (Bos.dll layout, verified by disassembly)            */
/* ------------------------------------------------------------------------ */

/*
 * Bos.dll keeps its game object as a lazily created singleton at
 * VA 0x1025DA74 (getter at 0x10004010). SetLocalPlayer (0x10110D30) stores:
 *   +0x0  local player entity id
 *   +0x4  local player's CHARACTER object   (from the player's "Character" var)
 *   +0x8  local player's EXOSKELETON object (from its "Exoskeleton" var)
 * In multiplayer +0x4 stays NULL until the local player has spawned; campaign
 * entities written for solo assume it never is.
 */
#define VA_BOSGAME_PTR 0x1025DA74u

static BYTE *bos_game(void)
{
    return *(BYTE **)VA(VA_BOSGAME_PTR);
}

static void *local_character(void)
{
    BYTE *g = bos_game();
    return g ? *(void **)(g + 4) : NULL;
}

/* ------------------------------------------------------------------------ */
/* hook 1: SINGLE_RIGID_BODY collision-centre tick                          */
/* ------------------------------------------------------------------------ */
/*
 * SINGLE_RIGID_BODY::Update (vtable 0x101FE91C slot 4, 0x10062090) ends with
 * an unconditional call to 0x10060630, which dereferences this+0x54 - the
 * "collision_center" node of the body's model. The model, its
 * "collision_mesh" node (+0x50) and the physics actor (+0x74) are created by
 * the vars-changed handler (slot 1, 0x10060EC0 -> loader 0x10060250). When
 * that never ran, +0x54 is NULL and the call faults at Bos+0x60639 (the
 * COOP_5 and COOP_8 crash). 0x10060630 is void, takes no stack arguments and
 * has exactly one caller (0x10062263), so skipping it is stack-safe.
 */
typedef void (__fastcall *fn_this)(BYTE *self);
/* var object vfunc 0x1C: copy the value out */
typedef void (__fastcall *fn_var_get)(BYTE *self, void *edx, void *out, DWORD a2);
static fn_this o_rb_tick;
static volatile LONG g_rb_skips;

static void __fastcall hook_rb_tick(BYTE *self)
{
    if (*(void **)(self + 0x54) == NULL) {
        LONG n = InterlockedIncrement(&g_rb_skips);
        if (n <= 5)
            plog("[rigid] skip collision tick: this=%p actor(+74)=%p model(+48)=%p mesh(+50)=%p tuning(+D0)=%p",
                 self, *(void **)(self + 0x74), *(void **)(self + 0x48),
                 *(void **)(self + 0x50), *(void **)(self + 0xD0));
        return;
    }
    o_rb_tick(self);
}

/* ------------------------------------------------------------------------ */
/* hook 2: SINGLE_RIGID_BODY vars-changed (diagnostic only)                 */
/* ------------------------------------------------------------------------ */
/*
 * Slot 1 (0x10060EC0) loads the model only if the type var at +0x88 reports a
 * change and the rigid-body type enum is non-empty. Logging the fields before
 * and after tells us which of those failed in multiplayer.
 */
static fn_this o_rb_vars;
static volatile LONG g_rb_vars_calls;

static int g_coop_remove_props = 1;       /* coop_config.ini [proxy] coop_remove_props (0.49) */
static volatile LONG g_rb_loads_skipped;
static void __fastcall hook_rb_vars(BYTE *self)
{
    LONG n;
    if (g_coop_remove_props) {
        if (InterlockedIncrement(&g_rb_loads_skipped) == 1)
            plog("[props] physics props are removed in co-op: model and body loading skipped (coop_remove_props=1)");
        return;
    }
    n = InterlockedIncrement(&g_rb_vars_calls);
    void *m0 = *(void **)(self + 0x48);
    o_rb_vars(self);
    if (n <= 8)
        plog("[rigid] vars-changed #%ld this=%p model(+48) %p->%p collision_center(+54)=%p actor(+74)=%p tuning(+D0)=%p",
             n, self, m0, *(void **)(self + 0x48), *(void **)(self + 0x54),
             *(void **)(self + 0x74), *(void **)(self + 0xD0));
}

/*
 * 0.50: slot 2 (0x10061D20, thiscall, no stack args, plain ret) is the client/render-side loader:
 * when the type var at +0x88 reports a change it builds the sound/effect objects from the tuning
 * data at +0xD0 (0x10061190 reads [+0xD0]+0xEC unguarded). With slot 1 skipped +0xD0 stays NULL and
 * the change flag stays set, so this faulted at Bos+0x611B6 right at mission start - only in a game
 * with a renderer, the dedicated server never calls it. Skip it whenever there is no tuning data.
 */
static fn_this o_rb_client_load;
static volatile LONG g_rb_client_skips;
static void __fastcall hook_rb_client_load(BYTE *self)
{
    if (*(void **)(self + 0xD0) == NULL) {
        if (InterlockedIncrement(&g_rb_client_skips) == 1)
            plog("[props] client-side prop loading skipped (no tuning data) this=%p", self);
        return;
    }
    o_rb_client_load(self);
}

/*
 * 0.51: a removed prop must be fully inert. Slot 3 (0x10061070, thiscall, 1 stack arg, ret 4) always
 * calls 0x10060A30, the gas-leak effect of a damaged canister: once its amount var (+0x8C) is > 0 it
 * reads the collision mesh (+0x50) and tuning data (+0xD0) unguarded - the host crash at Bos+0x1281F
 * two minutes in. Slot 4 (Update, 0x10062090, no stack args) holds the damage/break logic that starts
 * it. Both are skipped for props without tuning data (never loaded, coop_remove_props=1).
 */
typedef DWORD (__fastcall *fn_rb_this_1)(BYTE *self, void *edx, DWORD a1);
static fn_rb_this_1 o_rb_slot3;
static fn_this o_rb_update;
static volatile LONG g_rb_inert_skips;
static int rb_is_removed(BYTE *self)
{
    if (*(void **)(self + 0xD0) != NULL) return 0;
    if (InterlockedIncrement(&g_rb_inert_skips) == 1)
        plog("[props] removed props are inert: per-frame prop code skipped (this=%p)", self);
    return 1;
}
static DWORD __fastcall hook_rb_slot3(BYTE *self, void *edx, DWORD a1)
{
    if (rb_is_removed(self)) return 0;
    return o_rb_slot3(self, edx, a1);
}
static void __fastcall hook_rb_update(BYTE *self)
{
    if (rb_is_removed(self)) return;
    o_rb_update(self);
}

/* 0.54: DESTRUCTIBLE_OBJECT update (vtable 0x10200E24 slot 1, 0x10080580, thiscall, no args) calls
   through [this+0x44] unguarded; that object was NULL on the dedicated server (COOP_Alaska_*:
   Bos+0x80589). Without it there is nothing to update. */
typedef DWORD (__fastcall *fn_dobj_update)(BYTE *self, void *edx);
static fn_dobj_update o_dobj_update;
static volatile LONG g_dobj_skips;
static DWORD __fastcall hook_dobj_update(BYTE *self, void *edx)
{
    if (*(void **)(self + 0x44) == NULL) {
        if (InterlockedIncrement(&g_dobj_skips) == 1)
            plog("[props] destructible object without its +0x44 object: update skipped (this=%p handle=%08X)",
                 self, *(DWORD *)(self + 0x1C));
        return 0;
    }
    return o_dobj_update(self, edx);
}

/* 0.54: a method on a destructible (0x10108FD0, the only vtable entry at 0x1020A8D8, thiscall, 1 arg,
   ret 4, returns a bool; its own early-out answers 0) uses the destructible at [this+0x20] and calls
   through its +0x68 and +0x6C objects unguarded; NULL on the dedicated server (Cargo_Bay_1, Convoy,
   Good_Choice, Alaska_1: Bos+0x7E644, then Bos+0x10900D). Without them it answers 0. */
typedef BYTE (__fastcall *fn_dobj_method)(BYTE *self, void *edx, DWORD a1);
static fn_dobj_method o_dobj_method;
static volatile LONG g_dobj_method_skips;
static BYTE __fastcall hook_dobj_method(BYTE *self, void *edx, DWORD a1)
{
    BYTE *d = self ? *(BYTE **)(self + 0x20) : NULL;
    if (!d || *(void **)(d + 0x68) == NULL || *(void **)(d + 0x6C) == NULL) {
        if (InterlockedIncrement(&g_dobj_method_skips) == 1)
            plog("[props] destructible without its +0x68/+0x6C objects - method 0x10108FD0 answered 0 (this=%p)", self);
        return 0;
    }
    return o_dobj_method(self, edx, a1);
}

/* 0.54: EXO_RELOAD_STATION update (vtable 0x10202054 slot 3, 0x1008D840, thiscall, 1 arg, ret 4)
   reads [[BosGame+0]+0x44] (the HUD side) unguarded: NULL on the dedicated server (Bos+0x8D84E,
   Cargo_Bay_2/3, Eradication_1, Hold_that_Point_2/3, Resistance_1, Tanks_3/4). A fault skips it. */
typedef DWORD (__fastcall *fn_exo_update)(BYTE *self, void *edx, DWORD a1);
static fn_exo_update o_exo_station_update;
static volatile LONG g_exo_station_faults;
static DWORD __fastcall hook_exo_station_update(BYTE *self, void *edx, DWORD a1)
{
    __try { return o_exo_station_update(self, edx, a1); }
    __except (EXCEPTION_EXECUTE_HANDLER) {
        if (InterlockedIncrement(&g_exo_station_faults) == 1)
            plog("[props] exo reload station update faulted (no HUD?) - skipped (this=%p)", self);
        return 0;
    }
}

/* ------------------------------------------------------------------------ */
/* hook 3: PICKUP update needs a local character                            */
/* ------------------------------------------------------------------------ */
/*
 * PICKUP::Update (vtable 0x1020171C slot 3, 0x10085F50, thiscall, 1 stack
 * arg, ret 4) reads the local player's character (BosGame+4) to measure the
 * pickup distance. In multiplayer that is NULL until the player spawns, which
 * faulted at Bos+0x85F90 (COOP_3 / COOP_4). The engine ignores the return
 * value (checked at KT_Game+0xAE54D).
 */
typedef DWORD (__fastcall *fn_this_1)(BYTE *self, void *edx, DWORD a1);
static fn_this_1 o_pickup_update;
static volatile LONG g_pickup_skips;

static DWORD __fastcall hook_pickup_update(BYTE *self, void *edx, DWORD a1)
{
    if (local_character() == NULL) {
        if (InterlockedIncrement(&g_pickup_skips) == 1)
            plog("[pickup] skipping pickup updates while there is no local character");
        return 0;
    }
    return o_pickup_update(self, edx, a1);
}

/*
 * PICKUP light update (0x100864C0, thiscall, no args, void; callers
 * 0x10086641 and 0x10086784) calls through this+0x9C, a light object that
 * PICKUP slot 7 (0x100867D0) creates through the renderer interface. A
 * dedicated server has no renderer, so it stays NULL there and the update
 * faulted at Bos+0x86520. Stock MP maps contain no pickups.
 */
static fn_this o_pickup_light;
static volatile LONG g_pickup_light_skips;

static void __fastcall hook_pickup_light(BYTE *self)
{
    if (*(void **)(self + 0x9C) == NULL) {
        if (InterlockedIncrement(&g_pickup_light_skips) == 1)
            plog("[pickup] pickup has no light object (no renderer?) - skipping its light update");
        return;
    }
    o_pickup_light(self);
}

/* ------------------------------------------------------------------------ */
/* hook 4: SetLocalPlayer (diagnostic only)                                 */
/* ------------------------------------------------------------------------ */
static fn_this_1 o_set_local_player;

static DWORD __fastcall hook_set_local_player(BYTE *self, void *edx, DWORD id)
{
    char from[96];
    DWORD r;
    addr_name((DWORD)_ReturnAddress(), from, sizeof(from));
    r = o_set_local_player(self, edx, id);
    plog("[player] SetLocalPlayer(id=%08X) from %s -> character=%p exoskeleton=%p",
         id, from, *(void **)(self + 4), *(void **)(self + 8));
    if (g_run_mission_scripts && !g_mission_started && !g_mission_armed && *(void **)(self + 4) &&
        strcmp(nw_state_name(), "MASTER") == 0) {
        g_mission_armed = 1;             /* camera_watch starts the mission once the host has spawned */
        g_mission_armed_at = GetTickCount();
        plog("[mission] host connected - the mission starts when the host has spawned");
    }
    return r;
}

/* ------------------------------------------------------------------------ */
/* hook 5: PLAYER multiplayer status needs the BOS_RULES entity             */
/* ------------------------------------------------------------------------ */
/*
 * PLAYER::Update (vtable 0x101FE0DC slot 3) calls 0x1005A6D0 when the engine
 * runs as MP master. That reads the rules entity from the MP manager
 * singleton (VA 0x1025DD30, field +0), which is created by
 * BosGame::BeginPlayLevel (0x10113780 -> 0x1019CEC0: BOS_RULES at handle
 * 0x80320000, plus a BET entity). When BeginPlayLevel has not run, the field
 * is NULL and the read faults at Bos+0x5A710 (COOP_6 / COOP_8 on 2026-10-14).
 * 0x1005A6D0 is void, takes no stack args, and has one caller (0x1005AE1E).
 */
#define VA_MPMANAGER_PTR 0x1025DD30u
static fn_this o_player_mp_status;
static volatile LONG g_player_mp_skips;

static void __fastcall hook_player_mp_status(BYTE *self)
{
    BYTE *mgr = *(BYTE **)VA(VA_MPMANAGER_PTR);
    if (mgr == NULL || *(void **)mgr == NULL) {
        if (InterlockedIncrement(&g_player_mp_skips) == 1)
            plog("[player] no BOS_RULES entity yet (BeginPlayLevel has not run) - skipping PLAYER MP status updates");
        return;
    }
    o_player_mp_status(self);
}

/* ------------------------------------------------------------------------ */
/* hook 6: BeginPlay readiness of every entity                              */
/* ------------------------------------------------------------------------ */
/*
 * Before the engine starts a level (KT_Game Level::BeginPlay 0x10029D60 ->
 * 0x1000C2C0 -> 0x10028A50) it calls vtable slot 18 (+0x48) and, unless it is
 * a dedicated server, slot 19 (+0x4C) on EVERY entity with the readiness
 * flags. One "false" and the mod's BeginPlayLevel is never called; the check
 * runs once when loading finishes (0x1002BAC0) and on a few network events,
 * not every frame. In MP, a campaign scene leaves BeginPlayLevel uncalled.
 *
 * Each non-trivial readiness slot (ready_hooks_gen.h) is wrapped: entities
 * answering "not ready" are logged once with their handle (this+0x1C, map it
 * to a name with the .kts), and with force_begin_play=1 the wrapper answers
 * "ready" on their behalf so the level can start.
 */
typedef struct { DWORD vt, slot, fn; const char *cls; } READY_SLOT;
#include "ready_hooks_gen.h"

typedef BYTE (__fastcall *fn_ready)(BYTE *self, void *edx, DWORD flags);
static fn_ready g_ready_orig[64];
static int g_force_ready = 1;
static BYTE *g_ready_logged[512];
static volatile LONG g_ready_nlogged, g_ready_forced;

static volatile LONG g_ready_calls;

static BYTE ready_common(int i, BYTE *self, void *edx, DWORD flags)
{
    BYTE r = 0;
    LONG k, n;
    static volatile LONG faults;
    /* 0.54: DESTRUCTIBLE_OBJECT's readiness (0x1007F0A0 -> 0x1007EF70) reads its model [+0x5C]
       unguarded; without one (dedicated server, COOP_Alaska_*) it faulted while the level began.
       A faulting answer counts as "ready". */
    __try { r = g_ready_orig[i](self, edx, flags); }
    __except (EXCEPTION_EXECUTE_HANDLER) {
        if (InterlockedIncrement(&faults) <= 5)
            plog("[ready] %s (slot %lu) readiness faulted this=%p handle=%08X - counted as ready",
                 g_ready_slots[i].cls, g_ready_slots[i].slot, self, *(DWORD *)(self + 0x1C));
        return 1;
    }
    InterlockedIncrement(&g_ready_calls);
    if (r) return r;
    n = g_ready_nlogged;
    for (k = 0; k < n && k < 512; k++)
        if (g_ready_logged[k] == self) break;
    if (k == n && n < 512) {
        g_ready_logged[InterlockedIncrement(&g_ready_nlogged) - 1] = self;
        plog("[ready] NOT READY: %s (slot %lu) this=%p handle=%08X flags=%08X%s",
             g_ready_slots[i].cls, g_ready_slots[i].slot, self, *(DWORD *)(self + 0x1C), flags,
             g_force_ready ? "  -> forcing ready" : "");
    }
    if (g_force_ready) {
        InterlockedIncrement(&g_ready_forced);
        return 1;
    }
    return 0;
}

#define READY_WRAP(i) \
    static BYTE __fastcall ready_wrap_##i(BYTE *self, void *edx, DWORD flags) { return ready_common(i, self, edx, flags); }
READY_WRAP(0)  READY_WRAP(1)  READY_WRAP(2)  READY_WRAP(3)  READY_WRAP(4)  READY_WRAP(5)  READY_WRAP(6)  READY_WRAP(7)
READY_WRAP(8)  READY_WRAP(9)  READY_WRAP(10) READY_WRAP(11) READY_WRAP(12) READY_WRAP(13) READY_WRAP(14) READY_WRAP(15)
READY_WRAP(16) READY_WRAP(17) READY_WRAP(18) READY_WRAP(19) READY_WRAP(20) READY_WRAP(21) READY_WRAP(22) READY_WRAP(23)
READY_WRAP(24) READY_WRAP(25) READY_WRAP(26) READY_WRAP(27) READY_WRAP(28) READY_WRAP(29) READY_WRAP(30) READY_WRAP(31)
READY_WRAP(32) READY_WRAP(33) READY_WRAP(34) READY_WRAP(35) READY_WRAP(36) READY_WRAP(37) READY_WRAP(38) READY_WRAP(39)
READY_WRAP(40) READY_WRAP(41) READY_WRAP(42) READY_WRAP(43) READY_WRAP(44) READY_WRAP(45) READY_WRAP(46) READY_WRAP(47)
READY_WRAP(48) READY_WRAP(49) READY_WRAP(50) READY_WRAP(51) READY_WRAP(52) READY_WRAP(53) READY_WRAP(54) READY_WRAP(55)
READY_WRAP(56) READY_WRAP(57) READY_WRAP(58) READY_WRAP(59) READY_WRAP(60) READY_WRAP(61) READY_WRAP(62) READY_WRAP(63)

static fn_ready const g_ready_wraps[64] = {
    ready_wrap_0,  ready_wrap_1,  ready_wrap_2,  ready_wrap_3,  ready_wrap_4,  ready_wrap_5,  ready_wrap_6,  ready_wrap_7,
    ready_wrap_8,  ready_wrap_9,  ready_wrap_10, ready_wrap_11, ready_wrap_12, ready_wrap_13, ready_wrap_14, ready_wrap_15,
    ready_wrap_16, ready_wrap_17, ready_wrap_18, ready_wrap_19, ready_wrap_20, ready_wrap_21, ready_wrap_22, ready_wrap_23,
    ready_wrap_24, ready_wrap_25, ready_wrap_26, ready_wrap_27, ready_wrap_28, ready_wrap_29, ready_wrap_30, ready_wrap_31,
    ready_wrap_32, ready_wrap_33, ready_wrap_34, ready_wrap_35, ready_wrap_36, ready_wrap_37, ready_wrap_38, ready_wrap_39,
    ready_wrap_40, ready_wrap_41, ready_wrap_42, ready_wrap_43, ready_wrap_44, ready_wrap_45, ready_wrap_46, ready_wrap_47,
    ready_wrap_48, ready_wrap_49, ready_wrap_50, ready_wrap_51, ready_wrap_52, ready_wrap_53, ready_wrap_54, ready_wrap_55,
    ready_wrap_56, ready_wrap_57, ready_wrap_58, ready_wrap_59, ready_wrap_60, ready_wrap_61, ready_wrap_62, ready_wrap_63,
};

static void install_ready_hooks(void)
{
    char name[64];
    int i, ok = 0;
    if (NUM_READY_SLOTS > 64) {
        plog("[hook] ready table has %u entries, only 64 wrappers - extend READY_WRAP", (unsigned)NUM_READY_SLOTS);
        return;
    }
    for (i = 0; i < (int)NUM_READY_SLOTS; i++) {
        const READY_SLOT *s = &g_ready_slots[i];
        void **p = (void **)VA(s->vt) + s->slot;
        void *hook = (void *)g_ready_wraps[i];
        if (*p != VA(s->fn)) {
            _snprintf(name, sizeof(name), "ready %s[%lu]", s->cls, s->slot);
            plog("[hook] %-26s vtable %08X: holds %p, expected %p - NOT installed", name, s->vt, *p, VA(s->fn));
            continue;
        }
        g_ready_orig[i] = (fn_ready)*p;
        if (write_code(p, &hook, sizeof(hook))) ok++;
    }
    plog("[hook] begin_play_readiness       %d/%u entity slots wrapped (force_begin_play=%d)",
         ok, (unsigned)NUM_READY_SLOTS, g_force_ready);
}

/* ------------------------------------------------------------------------ */
/* engine network state (KT_Game.dll, read only)                            */
/* ------------------------------------------------------------------------ */
/*
 * KT_Game's network object is a singleton at VA 0x10185344; its byte at
 * +0xDA4 is 1 = MASTER, 0 = SLAVE, 2 = SOLO (engine vfunc 0x1C0 "IsSolo"
 * tests it). KT_Game.dll normally loads at 0x10000000 but is rebased anyway.
 */
static const char *nw_state_name(void)
{
    static BYTE *kt;
    BYTE *nw;
    if (!kt) kt = (BYTE *)GetModuleHandleA("KT_Game.dll");
    if (!kt) return "?";
    nw = *(BYTE **)(kt + (0x10185344u - 0x10000000u));
    if (!nw) return "none";
    switch (nw[0xDA4]) {
    case 0: return "SLAVE";
    case 1: return "MASTER";
    case 2: return "SOLO";
    default: return "?";
    }
}

/* ------------------------------------------------------------------------ */
/* hook 7: the engine's level-start sequence (KT_Game.dll, diagnostic)      */
/* ------------------------------------------------------------------------ */
/*
 * Level::BeginPlay(flags)        0x10029D60  thiscall, ret 4, returns al
 *   callers: 0x1002BD0E (end of level load), 0x1008E0EF and 0x1008E2FA (network)
 *   -> game::CanBeginPlay(flags) 0x1000C2C0  (call site 0x10029D7C)
 *      -> readiness(flags, mode) 0x10028A50 on the network object's KTServer
 *         part (vtable 0x1014DB44 slot 7) and on the Client (0x101419C4 slot 7);
 *         this is the loop that asks every entity (hook 6)
 *   -> mod ExportModOnBeginPlayLevel
 * In MP no entity said "not ready" (2026-10-18) yet BeginPlayLevel never ran,
 * so log every step of this sequence.
 */
typedef BYTE (__fastcall *fn_bool_1)(BYTE *self, void *edx, DWORD a1);
typedef BYTE (__fastcall *fn_bool_2)(BYTE *self, void *edx, DWORD a1, DWORD a2);
static fn_bool_1 o_level_begin_play, o_can_begin_play;
static fn_bool_2 o_ready_server, o_ready_client;
static volatile LONG g_engine_logs;

#define ENGINE_LOG_CAP 60

/*
 * 0.73: mission-honest class kits. The MP class pick stays the UI, but on a co-op level its kits come
 * from Tuning\Multiplayer\Coop\Equipments_<level>.cfg (CoopMod\tools\make_coop_kits.py: only the
 * weapons / armour the solo mission allows, Missions.cfg). The tuning databases load once at start
 * (BosGame init 0x10111030): equipment = [0x10266E98] (loader 0x101995B0, thiscall(path), clears
 * first), classes = [0x10266E94] (0x10197930) - a class keeps raw pointers to its equipment
 * (0x10197ED0 -> class+0x48), so the classes are reloaded after it, and the teams [0x1025DD34]
 * (0x10198DE0) after them, the same order as at start. Done on every PC right before the level begins
 * play (no character of the level is equipped yet); the same files on both PCs = the same kits.
 * [proxy] coop_kits=1.
 */
static void kits_reload(void);
static void kits_char_dump(BYTE *e);
static void kits_dump(void);

static BYTE __fastcall hook_level_begin_play(BYTE *self, void *edx, DWORD flags)
{
    char from[96];
    BYTE playing = self[0x62], r;
    addr_name((DWORD)_ReturnAddress(), from, sizeof(from));
    if (!playing) kits_reload();
    r = o_level_begin_play(self, edx, flags);
    if (!playing && self[0x62]) {
        g_spawn_report_pending = 1;          /* report on the next simulation frame */
        if (g_run_mission_scripts == 2 && !g_mission_started) {
            /* test mode: start the mission without a player, 3 s in - after the first entity
               updates, as with a real host (GROUPs learn their members only then) */
            g_mission_pending_at = GetTickCount() + 3000;
            g_mission_pending = 1;
        }
    }
    if (InterlockedIncrement(&g_engine_logs) <= ENGINE_LOG_CAP)
        plog("[begin] Level::BeginPlay(flags=%08X) from %s: already playing=%u -> %u, playing now=%u",
             flags, from, playing, r, self[0x62]);
    return r;
}

static BYTE __fastcall hook_can_begin_play(BYTE *self, void *edx, DWORD flags)
{
    BYTE r = o_can_begin_play(self, edx, flags);
    if (InterlockedIncrement(&g_engine_logs) <= ENGINE_LOG_CAP)
        plog("[begin]   CanBeginPlay(flags=%08X) -> %u", flags, r);
    return r;
}

static BYTE ready_check(fn_bool_2 orig, const char *who, BYTE *self, void *edx, DWORD flags, DWORD mode)
{
    LONG before = g_ready_calls;
    BYTE r = orig(self, edx, flags, mode);
    if (InterlockedIncrement(&g_engine_logs) <= ENGINE_LOG_CAP)
        plog("[begin]     %s readiness(flags=%08X, mode=%lu) -> %u  (%ld wrapped entity answers)",
             who, flags, mode, r, g_ready_calls - before);
    return r;
}

static BYTE __fastcall hook_ready_server(BYTE *self, void *edx, DWORD flags, DWORD mode)
{
    return ready_check(o_ready_server, "server", self, edx, flags, mode);
}

static BYTE __fastcall hook_ready_client(BYTE *self, void *edx, DWORD flags, DWORD mode)
{
    return ready_check(o_ready_client, "client", self, edx, flags, mode);
}

/*
 * The engine's save/scene loader reports problems through SAVE_MANAGER's
 * logger (0x1008B1F0, cdecl: (manager, fmt, ...)), which only writes when its
 * own logging is switched on - so messages such as
 *   'Failed to Acquire a "%s" entity'   (aborts the scene load, see below)
 * are normally lost. A 6-byte detour copies every message into our log and
 * then runs the original unchanged.
 *
 * Scene load: Level load end (0x1002BAC0) -> 0x1008E350 -> 0x1008DDB0 loads
 * <level>.kts chunk by chunk and stops at the first failing chunk; on failure
 * BeginPlay is skipped. Entity chunks (SVEN server, CLEN client) go through
 * 0x1008D720 (thiscall, 2 args, ret 8).
 */
static BYTE *g_save_log_tramp;
static volatile LONG g_save_log_lines;

void __cdecl save_log_capture(DWORD *sp)
{
    char buf[700], *c;
    const char *fmt = (const char *)sp[2];
    if (InterlockedIncrement(&g_save_log_lines) > 300) return;
    __try {
        _vsnprintf(buf, sizeof(buf) - 1, fmt, (va_list)&sp[3]);
        buf[sizeof(buf) - 1] = 0;
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        _snprintf(buf, sizeof(buf), "(unformattable message, format at %p)", fmt);
    }
    for (c = buf; *c; c++)
        if (*c == '\r' || *c == '\n') *c = ' ';
    plog("[engine] %s", buf);
}

__declspec(naked) static void save_log_stub(void)
{
    __asm pushad
    __asm lea eax, [esp + 32]
    __asm push eax
    __asm call save_log_capture
    __asm add esp, 4
    __asm popad
    __asm jmp dword ptr [g_save_log_tramp]
}

static void install_save_log_capture(void)
{
    static const BYTE expect[6] = { 0x81, 0xEC, 0x04, 0x04, 0x00, 0x00 };   /* sub esp, 404h */
    BYTE *fn = KVA(0x1008B1F0), patch[6];
    char found[24];
    if (memcmp(fn, expect, 6) != 0) {
        hexbytes(fn, 6, found);
        plog("[hook] %-26s found %s - NOT installed", "engine_loader_log", found);
        return;
    }
    g_save_log_tramp = (BYTE *)VirtualAlloc(NULL, 16, MEM_COMMIT | MEM_RESERVE, PAGE_EXECUTE_READWRITE);
    if (!g_save_log_tramp) return;
    memcpy(g_save_log_tramp, expect, 6);                           /* the instruction we overwrite */
    g_save_log_tramp[6] = 0xE9;                                    /* jmp back to fn+6 */
    *(INT32 *)(g_save_log_tramp + 7) = (INT32)((fn + 6) - (g_save_log_tramp + 11));
    patch[0] = 0xE9;
    *(INT32 *)(patch + 1) = (INT32)((BYTE *)save_log_stub - (fn + 5));
    patch[5] = 0x90;
    if (write_code(fn, patch, 6))
        plog("[hook] %-26s detour at 1008B1F0 -> ok", "engine_loader_log");
}

typedef BYTE (__fastcall *fn_bool_2b)(BYTE *self, void *edx, DWORD a1, DWORD a2);
static fn_bool_2b o_load_entities_chunk, o_load_scene_file;

static BYTE __fastcall hook_load_entities_chunk(BYTE *self, void *edx, DWORD a1, DWORD a2)
{
    BYTE r = o_load_entities_chunk(self, edx, a1, a2);
    plog("[load] entity chunk (%s) -> %s",
         (DWORD)_ReturnAddress() == (DWORD)KVA(0x1008E026) ? "SVEN, server entities" : "CLEN, client entities",
         r ? "ok" : "FAILED - scene load stops here and BeginPlay will not run");
    return r;
}

/*
 * Per-entity load (0x1008CD80, thiscall, 3 args, ret 0Ch), called at
 * 0x1008D8BD for every ENTI chunk. It opens the entity's chunk first
 * ([reader+0x70]), which already moves the parent reader past the entity, so
 * after a failure the loop can continue with the next entity. Returning
 * "loaded" for a failed entity therefore skips just that entity instead of
 * aborting the whole scene (and with it BeginPlay). The engine's own message
 * just before says why it failed.
 */
typedef BYTE (__fastcall *fn_bool_3)(BYTE *self, void *edx, DWORD a1, DWORD a2, DWORD a3);
static fn_bool_3 o_load_entity;
static int g_skip_failed_entities = 1;
static volatile LONG g_entities_skipped;

static BYTE __fastcall hook_load_entity(BYTE *self, void *edx, DWORD a1, DWORD a2, DWORD a3)
{
    BYTE r = o_load_entity(self, edx, a1, a2, a3);
    if (!r) {
        LONG n = InterlockedIncrement(&g_entities_skipped);
        if (n <= 40)
            plog("[load] entity failed to load%s", g_skip_failed_entities ? " - skipping it, scene load continues" : "");
        if (g_skip_failed_entities)
            return 1;
    }
    return r;
}

/* 0.56: the campaign's story movies (Mods\Bos\Movies\<language>\*.ktm, Ogg Theora, played by
   Script\ManageLevels.lua between missions) at the start of the co-op level that follows them, on
   every PC, before the player spawns: coop_config.ini [movies] <level>=<movie>[,<movie>...] plays
   when <level> loads (once per game session - a restart after a failed mission does not replay it),
   [movies_after] <level>=... when the next level loads after leaving <level> (the endings).
   They go through the engine's own PlayMovie (KT_Game 0x1002FD60) in the level's script state; each
   movie's callback starts the next one. Off with [proxy] coop_movies=0; never on the dedicated server. */
static int g_coop_movies = 1;            /* coop_config.ini [proxy] coop_movies */
static char g_config_path[MAX_PATH];
static int lua_run(const char *what, const char *code, int quiet);
static char g_cur_level[64], g_prev_level[64];
static char g_movies_shown[1024];        /* ";COOP_A;COOP_B;" */
static int g_movie_due;                  /* level loaded, its movies not played yet */
static DWORD g_movie_fp_at;              /* when this PC's player was first seen in first person */
static int g_movie_active, g_movie_pre_mode = -1, g_movie_pre_state;
static DWORD g_movie_check_at;           /* after a movie ended: put the camera back if the movie left it */
static void movie_note_level(const char *path)
{
    const char *b = strrchr(path, '\\'), *b2 = strrchr(path, '/');
    char name[64];
    size_t n;
    if (b2 && (!b || b2 > b)) b = b2;
    b = b ? b + 1 : path;
    n = strcspn(b, ".");
    if (n == 0 || n >= sizeof(name)) return;
    memcpy(name, b, n); name[n] = 0;
    if (_stricmp(name, g_cur_level) != 0) {
        strcpy(g_prev_level, g_cur_level);
        strcpy(g_cur_level, name);
    }
    g_movie_due = 1;
    g_movie_fp_at = 0; g_movie_active = 0; g_movie_check_at = 0;
}
static int movie_add(char *lua, size_t cap, int count, const char *list, const char *why)
{
    char buf[512], *tok, *ctx = NULL, path[MAX_PATH];
    strncpy(buf, list, sizeof(buf) - 1); buf[sizeof(buf) - 1] = 0;
    for (tok = strtok_s(buf, ", ", &ctx); tok; tok = strtok_s(NULL, ", ", &ctx)) {
        if (strpbrk(tok, "\"\\")) continue;
        _snprintf(path, sizeof(path), "%sMods%sBos%sMovies%sEN%s%s", g_game_dir, "\\", "\\", "\\", "\\", tok);
        path[sizeof(path) - 1] = 0;
        if (GetFileAttributesA(path) == INVALID_FILE_ATTRIBUTES) {
            plog("[movie] %s: %s not found in Movies%sEN - skipped", why, tok, "\\");
            continue;
        }
        if (strlen(lua) + strlen(tok) + 8 >= cap) break;
        strcat(lua, count ? ", \"" : "\"");
        strcat(lua, tok);
        strcat(lua, "\"");
        count++;
        plog("[movie] %s: %s", why, tok);
    }
    return count;
}
static void movie_on_level_start(void)
{
    char list[512], key[80], lua[2048];
    int n = 0;
    g_movie_due = 0;
    if (!g_coop_movies || !g_cur_level[0]) return;
    strcpy(lua, "Coop_MovieQueue = { ");
    if (g_prev_level[0] && _stricmp(g_prev_level, g_cur_level) != 0) {
        GetPrivateProfileStringA("movies_after", g_prev_level, "", list, sizeof(list), g_config_path);
        if (list[0]) {
            char why[128];
            _snprintf(why, sizeof(why), "after %s", g_prev_level); why[sizeof(why) - 1] = 0;
            n = movie_add(lua, sizeof(lua) - 600, n, list, why);
        }
    }
    _snprintf(key, sizeof(key), ";%s;", g_cur_level); key[sizeof(key) - 1] = 0;
    if (!strstr(g_movies_shown, key)) {
        GetPrivateProfileStringA("movies", g_cur_level, "", list, sizeof(list), g_config_path);
        if (list[0]) {
            char why[128];
            _snprintf(why, sizeof(why), "start of %s", g_cur_level); why[sizeof(why) - 1] = 0;
            n = movie_add(lua, sizeof(lua) - 600, n, list, why);
            if (strlen(g_movies_shown) + strlen(key) < sizeof(g_movies_shown)) {
                if (!g_movies_shown[0]) strcpy(g_movies_shown, ";");
                strcat(g_movies_shown, key + 1);
            }
        }
    }
    g_prev_level[0] = 0;                 /* an ending plays once, on the first level after it */
    if (!n) return;
    if (GetModuleHandleA("Dedicated_Server.exe")) { plog("[movie] dedicated server: %d movie(s) not played", n); return; }
    strcat(lua, " } Coop_MovieIndex = 0 "
        "function Coop_MovieNext() "
        "Coop_MovieIndex = Coop_MovieIndex + 1 "
        "local m = Coop_MovieQueue[Coop_MovieIndex] "
        "if m == nil then PrintDebug(\"[movie] done\") return end "
        "PrintDebug(\"[movie] playing \" .. m) "
        "PlayMovie(m, \"Coop_MovieNext\") end "
        "Coop_MovieNext()");
    lua_run("story movie", lua, 0);
}

static BYTE __fastcall hook_load_scene_file(BYTE *self, void *edx, DWORD path, DWORD flag)
{
    BYTE r;
    char p[260] = "?";
    __try { strncpy(p, (const char *)path, sizeof(p) - 1); } __except (EXCEPTION_EXECUTE_HANDLER) {}
    p[sizeof(p) - 1] = 0;
    plog("[load] scene file %s ...", p);
    movie_note_level(p);
    r = o_load_scene_file(self, edx, path, flag);
    plog("[load] scene file -> %s  (%ld entities skipped)", r ? "ok" : "FAILED (BeginPlay skipped)", g_entities_skipped);
    return r;
}

static void install_engine_hooks(void)
{
    g_kt_base = (BYTE *)GetModuleHandleA("KT_Game.dll");
    if (!g_kt_base) {
        plog("[hook] KT_Game.dll not loaded - engine hooks skipped (offline test?)");
        return;
    }
    o_level_begin_play = (fn_bool_1)hook_kt_call_site("level_begin_play_log#1", 0x1002BD0E, 0x10029D60, (void *)hook_level_begin_play);
    hook_kt_call_site("level_begin_play_log#2", 0x1008E0EF, 0x10029D60, (void *)hook_level_begin_play);
    hook_kt_call_site("level_begin_play_log#3", 0x1008E2FA, 0x10029D60, (void *)hook_level_begin_play);
    o_can_begin_play = (fn_bool_1)hook_kt_call_site("can_begin_play_log", 0x10029D7C, 0x1000C2C0, (void *)hook_can_begin_play);
    o_ready_server = (fn_bool_2)hook_kt_vtable("readiness_server_log", 0x1014DB44, 7, 0x10028A50, (void *)hook_ready_server);
    o_ready_client = (fn_bool_2)hook_kt_vtable("readiness_client_log", 0x101419C4, 7, 0x10028A50, (void *)hook_ready_client);
    install_save_log_capture();
    install_lua_capture();
    o_load_entities_chunk = (fn_bool_2b)hook_kt_call_site("load_entities_chunk_log#1", 0x1008DFCD, 0x1008D720, (void *)hook_load_entities_chunk);
    hook_kt_call_site("load_entities_chunk_log#2", 0x1008E021, 0x1008D720, (void *)hook_load_entities_chunk);
    o_load_scene_file = (fn_bool_2b)hook_kt_call_site("load_scene_file_log", 0x1008E357, 0x1008DDB0, (void *)hook_load_scene_file);
    o_load_entity = (fn_bool_3)hook_kt_call_site("load_entity_skip_failed", 0x1008D8BD, 0x1008CD80, (void *)hook_load_entity);
    plog("[hook] skip_failed_entities=%d run_mission_scripts=%d npc_equipment=%d coop_save=%d test_lua=%s",
         g_skip_failed_entities, g_run_mission_scripts, g_npc_equipment, g_coop_save,
         g_test_lua[0] ? g_test_lua : "(none)");
}

/* ------------------------------------------------------------------------ */
/* hook 8: MP spawn camera picker with no camera points                     */
/* ------------------------------------------------------------------------ */
/*
 * 0x1019CA30 (MP manager method, thiscall, no stack args) picks a random
 * MULTI_IDLE_CAMPOINT: rand() % GetNbrEntities(type 0x40). With none it
 * divides by zero at Bos+0x19CA63 (COOP_7; COOP_6/COOP_8 on 2026-10-18).
 * Nothing is modified before the division, and both callers (0x1019D1BB,
 * 0x1007414C) pass the result to 0x1009B4A0, which accepts NULL, so a
 * division fault is turned into "no camera".
 */
typedef void *(__fastcall *fn_ptr_this)(BYTE *self);
static fn_ptr_this o_pick_idle_cam;
static volatile LONG g_idle_cam_fails;

static void *__fastcall hook_pick_idle_cam(BYTE *self)
{
    __try {
        return o_pick_idle_cam(self);
    } __except (GetExceptionCode() == EXCEPTION_INT_DIVIDE_BY_ZERO ? EXCEPTION_EXECUTE_HANDLER
                                                                     : EXCEPTION_CONTINUE_SEARCH) {
        if (InterlockedIncrement(&g_idle_cam_fails) <= 3)
            plog("[camera] no MULTI_IDLE_CAMPOINT available (count 0) - using no spawn camera");
        return NULL;
    }
}

/* ------------------------------------------------------------------------ */
/* spawn diagnostics (read only)                                            */
/* ------------------------------------------------------------------------ */
/*
 * MP spawning walks the SPAWN_AREA entities (type 0x33, PLAYER method
 * 0x10059EB0): an area qualifies if its Team matches the player's
 * (0x100778D0) and its sector check passes (0x10077730: the sector var at
 * area+0x58 must resolve; the sector is a SECT volume of the level's
 * Events.kt3, looked up by name). Once per level, right after play begins,
 * list every area and spawn point with that check, using the same engine
 * iterator the game uses (engine interface: vfunc 0x4B0 creates an iterator
 * for (type, flag), 0x4B8 returns the next entity or NULL, 0x4B4 releases it;
 * see 0x1019CA30). Entity names are an MSVC 7.1 std::string at entity+0x20.
 */
#define VA_ENGINE_IFACE 0x1025DECCu
typedef DWORD (__fastcall *fn_iter)(BYTE *self, void *edx, DWORD a1, DWORD a2);
typedef BYTE (__fastcall *fn_bool_0)(BYTE *self, void *edx);

static const char *entity_name(BYTE *e)
{
    BYTE *s = e + 0x20;
    return *(DWORD *)(s + 0x18) >= 16 ? *(const char **)(s + 4) : (const char *)(s + 4);
}

/*
 * world: 1 = server (authoritative) entities, 0 = client entities. Iterators come from a fixed
 * per-world pool (KT 0x1000F8D0 hands out a slot, 0x1000F9E0 returns it; 0x1001E5B0 / 0x1001E600
 * pick the pool by the world flag), so the release must name the same world, and must happen
 * even if fn faults. Up to 0.12 the release always named world 0: every server-world loop leaked
 * a slot until the pool ran dry and the engine's own loop wrote through slot -1 (KT+0xF9FF crash,
 * then "pure virtual function call").
 */
static int for_each_entity(BYTE *iface, DWORD type, DWORD world, void (*fn)(BYTE *e, void *ctx), void *ctx)
{
    void **vt = *(void ***)iface;
    DWORD it = ((fn_iter)vt[0x4B0 / 4])(iface, 0, type, world);
    BYTE *e;
    int n = 0;
    if (it == 0xFFFFFFFFu) return 0;
    __try {
        while ((e = (BYTE *)((fn_iter)vt[0x4B8 / 4])(iface, 0, it, world)) != NULL && n < 1024) {
            if (fn) fn(e, ctx);
            n++;
        }
    } __finally {
        ((fn_iter)vt[0x4B4 / 4])(iface, 0, it, world);
    }
    return n;
}

static void report_area(BYTE *e, void *ctx)
{
    BYTE r = ((fn_bool_0)VA(0x10077730))(e, 0);
    *(int *)ctx += r != 0;
    plog("[spawn] SPAWN_AREA %-24s state flag (0x10077730) = %u", entity_name(e), r);
}

/*
 * Entity census. The iterator's second argument selects the world: 1 = server
 * (authoritative), 0 = client (what this machine renders) - the spawn code uses
 * 1 for SPAWN_AREA, the camera picker 0 for client-only camera points. A
 * campaign NPC that exists on the server but not in the client world is not
 * being replicated to players.
 */
static void entity_census(const char *when)
{
    static const struct { DWORD type; const char *name; } t[] = {
        { 5, "CHARACTER" }, { 7, "CHARACTER_AI" }, { 9, "GROUP_AI" }, { 2, "PLAYER" },
        { 0, "SINGLE_RIGID_BODY" }, { 54, "DOOR" }, { 10, "AI_ORDER_LIST" }, { 12, "AI_ORDER_GOTO_WAYPOINT" },
        { 28, "WAYPOINT" },
    };
    BYTE *iface = *(BYTE **)VA(VA_ENGINE_IFACE);
    char line[400];
    int i, n = 0;
    if (!iface) return;
    __try {
        for (i = 0; i < (int)(sizeof(t) / sizeof(t[0])); i++)
            n += _snprintf(line + n, sizeof(line) - n, " %s server=%d client=%d", t[i].name,
                           for_each_entity(iface, t[i].type, 1, NULL, NULL),
                           for_each_entity(iface, t[i].type, 0, NULL, NULL));
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[census] failed (exception %08X)", GetExceptionCode());
        return;
    }
    plog("[census] %s:%s", when, line);
}

static void spawn_report(void)
{
    BYTE *iface = *(BYTE **)VA(VA_ENGINE_IFACE);
    int areas, ok = 0, points;
    if (!iface) return;
    __try {
        areas = for_each_entity(iface, 0x33, 1, report_area, &ok);
        points = for_each_entity(iface, 0x2D, 1, NULL, NULL);
        plog("[spawn] %d spawn areas, %d spawn points in the live world", areas, points);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[spawn] report failed (exception %08X)", GetExceptionCode());
    }
}

/* ------------------------------------------------------------------------ */
/* Lua output capture (KT_Game.dll)                                         */
/* ------------------------------------------------------------------------ */
/*
 * The engine registers C functions as Lua globals at startup (0x10033080):
 *   _ERRORMSG  0x10031D00  pcall error handler for every script call (runtime errors)
 *   _ALERT     0x10031F10  compile errors ("SCRIPT COMPILATION ERROR")
 *   PrintDebug 0x1002EE20  the scripts' debug print
 * Each is a lua_CFunction (cdecl, lua_State*), message at stack index 1.
 * Detours copy the message into our log (lua_tostring = 0x100CC310) and then
 * run the original. Identical consecutive messages are collapsed.
 */
typedef const char *(__cdecl *fn_lua_tostring)(void *L, int idx);
static BYTE *g_tramp_errormsg, *g_tramp_alert, *g_tramp_printdebug;
static char g_lua_last[3][256];
static LONG g_lua_repeat[3];
static volatile LONG g_lua_lines;

void __cdecl lua_capture(int kind, DWORD *sp)
{
    static const char *tag[3] = { "[lua error]", "[lua compile]", "[lua print]" };
    char msg[256], *c;
    const char *s = NULL;
    __try {
        s = ((fn_lua_tostring)KVA(0x100CC310))((void *)sp[1], 1);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        s = NULL;
    }
    _snprintf(msg, sizeof(msg) - 1, "%s", s ? s : "(no message)");
    msg[sizeof(msg) - 1] = 0;
    for (c = msg; *c; c++)
        if (*c == '\r' || *c == '\n') *c = ' ';
    if (kind == 2) admin_on_print(msg);
    if (strcmp(msg, g_lua_last[kind]) == 0) {
        g_lua_repeat[kind]++;
        return;
    }
    if (g_lua_repeat[kind])
        plog("%s   (previous message repeated %ld more times)", tag[kind], g_lua_repeat[kind]);
    g_lua_repeat[kind] = 0;
    strcpy(g_lua_last[kind], msg);
    if (InterlockedIncrement(&g_lua_lines) <= 2000)
        plog("%s %s", tag[kind], msg);
}

#define LUA_STUB(name, kind, tramp)                                  \
    __declspec(naked) static void name(void)                         \
    {                                                                \
        __asm pushad                                                 \
        __asm lea eax, [esp + 32]                                    \
        __asm push eax                                               \
        __asm push kind                                              \
        __asm call lua_capture                                       \
        __asm add esp, 8                                             \
        __asm popad                                                  \
        __asm jmp dword ptr [tramp]                                  \
    }
LUA_STUB(stub_errormsg, 0, g_tramp_errormsg)
LUA_STUB(stub_alert, 1, g_tramp_alert)
LUA_STUB(stub_printdebug, 2, g_tramp_printdebug)

/* Overwrite the first n bytes of fn (whole, position-independent instructions,
   checked against expect) with a jmp to stub; returns a trampoline that runs
   them and continues at fn+n. */
static BYTE *detour_kt(const char *name, DWORD fn_va, const BYTE *expect, int n, void *stub)
{
    BYTE *fn = KVA(fn_va), patch[16], *t;
    char found[64];
    if (memcmp(fn, expect, n) != 0) {
        hexbytes(fn, n, found);
        plog("[hook] %-26s found %s - NOT installed", name, found);
        return NULL;
    }
    t = (BYTE *)VirtualAlloc(NULL, 32, MEM_COMMIT | MEM_RESERVE, PAGE_EXECUTE_READWRITE);
    if (!t) return NULL;
    memcpy(t, fn, n);
    t[n] = 0xE9;
    *(INT32 *)(t + n + 1) = (INT32)((fn + n) - (t + n + 5));
    memset(patch, 0x90, sizeof(patch));
    patch[0] = 0xE9;
    *(INT32 *)(patch + 1) = (INT32)((BYTE *)stub - (fn + 5));
    if (!write_code(fn, patch, n)) return NULL;
    plog("[hook] %-26s detour at %08X -> ok", name, fn_va);
    return t;
}

static void install_lua_capture(void)
{
    /* push 0FFFFFFFFh; push imm32 (SEH frame setup). The imm32 is an absolute address
       (rebased with the DLL), so only the opcodes are checked and the live bytes copied. */
    BYTE e1[7] = { 0x6A, 0xFF, 0x68 }, e2[7] = { 0x6A, 0xFF, 0x68 };
    static const BYTE e3[6] = { 0x51, 0x56, 0x8B, 0x74, 0x24, 0x0C };   /* push ecx; push esi; mov esi,[esp+0Ch] */
    memcpy(e1 + 3, KVA(0x10031D03), 4);
    memcpy(e2 + 3, KVA(0x10031F13), 4);
    g_tramp_errormsg = detour_kt("lua_errormsg_log", 0x10031D00, e1, 7, (void *)stub_errormsg);
    g_tramp_alert = detour_kt("lua_alert_log", 0x10031F10, e2, 7, (void *)stub_alert);
    g_tramp_printdebug = detour_kt("lua_printdebug_log", 0x1002EE20, e3, 6, (void *)stub_printdebug);
}

/* ------------------------------------------------------------------------ */
/* mission bootstrap for multiplayer (host only)                            */
/* ------------------------------------------------------------------------ */
/*
 * In SOLO the engine calls the level script's InitLevel when loading ends
 * (KT_Game 0x1002BE43: only if IsSolo), and BosGame::BeginPlayLevel
 * (0x10113780, solo game types only) raises BosGame+0x1A, which makes
 * BosGame::UpdateSimulation (0x10110350) call the script's OnMissionBegins
 * (intro cut-scene, mercenaries). In MP neither happens, yet the engine still
 * runs UpdateLevel every frame (0x1000D706: game+0x85 && game+0x89) - so
 * mission scripts ran without ever being initialised.
 *
 * Once the host is in the world (camera_watch: first-person camera after
 * connecting as MP master), we call InitLevel through the engine interface
 * (the same calls the mod uses: vfunc 0x4E0 exists, 0x4E4 call) and raise
 * BosGame+0x1A, so the mod itself calls OnMissionBegins in that frame, as in
 * solo where the player is already in the world. Starting at connect time
 * (v0.6) ran the intro while the host was still on the spawn screen and left
 * the camera there. Clients (SLAVE) do not run mission logic.
 */
typedef BYTE (__fastcall *fn_script_exists)(BYTE *self, void *edx, const char *name);
typedef BYTE (__fastcall *fn_script_call)(BYTE *self, void *edx, const char *name, DWORD nargs, DWORD nres);

/*
 * Running Lua text in the level's script state. The engine keeps one Lua 5.0
 * instance for level scripts behind KT_Game 0x10185318 (getter 0x10001330,
 * used by the script-call vfuncs 0x4E0 / 0x4E4): a wrapper whose first field
 * is the LUA_INSTANCE, whose first field is the lua_State. 0x100CD260 is
 * lua_dostring (cdecl L, text; -> lua_dobuffer 0x100CD200), the call the
 * engine itself uses to disable io functions (KT 0x10031B85). Errors reach
 * _ALERT, which lua_capture logs as [lua compile] / [lua error].
 *
 * test_lua (coop_config.ini) names a file next to the executable that is run
 * this way right before InitLevel - used to drive mission scripts on the
 * dedicated server, which has no local player, animations or sound.
 */
typedef int (__cdecl *fn_lua_dostring)(void *L, const char *s);

static int lua_run(const char *what, const char *code, int quiet)
{
    /* mov edx,[esp+8]; mov eax,edx; push esi; lea esi,[eax+1] */
    static const BYTE expect[] = { 0x8B, 0x54, 0x24, 0x08, 0x8B, 0xC2, 0x56, 0x8D, 0x70, 0x01 };
    BYTE *wrap;
    void *L = NULL;
    int r = -1;
    if (!g_kt_base || memcmp(KVA(0x100CD260), expect, sizeof(expect)) != 0) {
        plog("[lua run] %s: lua_dostring not found at KT_Game 0x100CD260 - not run", what);
        return -1;
    }
    __try {
        wrap = *(BYTE **)KVA(0x10185318);
        if (wrap && *(void ***)wrap) L = **(void ***)wrap;
        if (L) r = ((fn_lua_dostring)KVA(0x100CD260))(L, code);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[lua run] %s: exception %08X", what, GetExceptionCode());
        return -1;
    }
    if (!L) plog("[lua run] %s: no level script state yet - not run", what);
    else if (!quiet || r) plog("[lua run] %s -> %d%s", what, r, r ? " (failed, see the [lua] lines above)" : "");
    return r;
}

/* runs <game folder>
ame in the level's script state; returns lua_dostring's result or -1 */
static int run_lua_file(const char *key, const char *name)
{
    char path[MAX_PATH], *buf;
    HANDLE f;
    DWORD size, got = 0;
    int r = -1;
    _snprintf(path, sizeof(path), "%s%s", g_game_dir, name);
    path[sizeof(path) - 1] = 0;
    f = CreateFileA(path, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);
    if (f == INVALID_HANDLE_VALUE) {
        plog("[lua run] %s %s: cannot open (error %lu)", key, path, GetLastError());
        return -1;
    }
    size = GetFileSize(f, NULL);
    buf = (char *)HeapAlloc(GetProcessHeap(), 0, size + 1);
    if (buf && ReadFile(f, buf, size, &got, NULL)) {
        buf[got] = 0;
        r = lua_run(name, buf, 0);
    }
    if (buf) HeapFree(GetProcessHeap(), 0, buf);
    CloseHandle(f);
    return r;
}

/*
 * NPC AI in multiplayer. BosGame::BeginPlayLevel (0x10113780) runs its
 * campaign block only for solo game types (game-type flag 8, 0x10113930):
 * 0x10112F10 gives the campaign "Player" character a new PLAYER, 0x10113090
 * creates the solo singleton entity of type 0x3F, and 0x101128F0 builds the
 * AI world - a new AI manager (0x1010F3A0 -> VA 0x1025DA64), the level's
 * Kynapse data (<level>\AI\<level>*.pdl ..., checked by 0x100ABAA0), the
 * local character as the AI's "Player" agent (0x100A82A0) and a BOT_ENTITY
 * agent for each NPC (0x100A87A0). BosGame::UpdateSimulation updates the AI
 * only while that manager exists (0x10110479 -> 0x100A3890), and
 * BosGame::EndPlayLevel destroys it in every mode (0x101127BA).
 *
 * In MP none of this runs: NPCs stand where they were placed, their AI orders
 * (goto waypoint, follow, patrol, attack) are never evaluated and their
 * ScriptedExpiration functions are never called (dedicated test 2026-10-21).
 * A cut-scene that waits for an NPC to walk somewhere therefore never ends
 * (COOP_Patrol after the save station: General Solberg never arrives).
 *
 * With ai_init=1 the host runs 0x101128F0 (thiscall on BosGame) when the
 * mission starts, after InitLevel and before OnMissionBegins, as in solo. It
 * needs a local character (BosGame+4); the dedicated server has none, so for
 * tests ai_player names a character to stand in for it during the call.
 */
#define VA_AI_MANAGER_PTR 0x1025DA64u
static int g_ai_init = 1;                 /* coop_config.ini [proxy] ai_init */
static int g_ai_kernel_on_sim;            /* coop_config.ini [proxy] ai_kernel_on_sim (dedicated-server tests) */
static char g_ai_player[64];              /* coop_config.ini [proxy] ai_player (tests only) */
static BYTE *g_found_entity;

static void find_named(BYTE *e, void *name)
{
    if (!g_found_entity && strcmp(entity_name(e), (const char *)name) == 0)
        g_found_entity = e;
}

/* The AI setup checks the level's AI files with fopen(path, "rb") (Bos import
   slot 0x101F5194, msvcr71); while it runs, the slot points here so the log
   shows every file it looked for. */
#define VA_IMP_FOPEN 0x101F5194u
typedef void *(__cdecl *fn_fopen)(const char *path, const char *mode);
static fn_fopen g_real_fopen;

static void *__cdecl ai_fopen_log(const char *path, const char *mode)
{
    void *f = g_real_fopen(path, mode);
    plog("[ai]   %s %s", f ? "found  " : "MISSING", path ? path : "(null)");
    return f;
}

/* CHARACTER +0x58: its AI agent (set by 0x100A8350); agent +0x6C: in the AI world */
typedef struct { int chars, agents, active, moved; char none[160]; } AI_CENSUS;

/* last known position per character (for the "moved" count), by entity pointer */
#define AI_POS_SLOTS 256
static BYTE *g_ai_pos_ent[AI_POS_SLOTS];
static float g_ai_pos[AI_POS_SLOTS][3];

/* a CHARACTER's position: +0x174/+0x178/+0x17C, as the character update uses it (0x10001B40,
   0x10013990). (Reading the "Position" var through the engine interface returned 0,0,0 for
   every character, so the "moved" counts before proxy 0.10 were always 0.) */
static int entity_position(BYTE *e, float out[3])
{
    out[0] = *(float *)(e + 0x174); out[1] = *(float *)(e + 0x178); out[2] = *(float *)(e + 0x17C);
    return 1;
}

/* 1 if the character moved more than 0.5 units since the last census */
static int ai_moved(BYTE *e)
{
    float p[3], dx, dy, dz;
    int i, free_slot = -1;
    if (!entity_position(e, p)) return 0;
    for (i = 0; i < AI_POS_SLOTS; i++) {
        if (g_ai_pos_ent[i] == e) {
            dx = p[0] - g_ai_pos[i][0]; dy = p[1] - g_ai_pos[i][1]; dz = p[2] - g_ai_pos[i][2];
            g_ai_pos[i][0] = p[0]; g_ai_pos[i][1] = p[1]; g_ai_pos[i][2] = p[2];
            return dx * dx + dy * dy + dz * dz > 0.25f;
        }
        if (!g_ai_pos_ent[i] && free_slot < 0) free_slot = i;
    }
    if (free_slot >= 0) {
        g_ai_pos_ent[free_slot] = e;
        g_ai_pos[free_slot][0] = p[0]; g_ai_pos[free_slot][1] = p[1]; g_ai_pos[free_slot][2] = p[2];
    }
    return 0;
}

static void count_agent(BYTE *e, void *ctx)
{
    AI_CENSUS *c = (AI_CENSUS *)ctx;
    BYTE *agent = *(BYTE **)(e + 0x58);
    c->chars++;
    if (!agent) {
        if (strlen(c->none) < sizeof(c->none) - 40) {
            strcat(c->none, " ");
            strncat(c->none, entity_name(e), 32);
        }
        return;
    }
    c->agents++;
    if (agent[0x6C]) {
        /* BOT_ENTITY update (0x100B0F50): brain = agent+0x18, skipped if brain->vf1() == 0x1025EF00;
           else the order manager brain+0x40 walks its lists at +0x0C and +0x40 (0x100FE770) */
        static int dumped;
        BYTE *brain = *(BYTE **)(agent + 0x18), *om, *l1, *l2;
        DWORD id = 0;
        c->active++;
        c->moved += ai_moved(e);
        if (dumped < 6 && brain) {
            dumped++;
            id = ((DWORD (__fastcall *)(BYTE *, void *))(*(void ***)brain)[1])(brain, 0);
            om = id == (DWORD)VA(0x1025EF00) ? NULL : *(BYTE **)(brain + 0x40);   /* player brains have none */
            l1 = om ? *(BYTE **)(om + 0x0C) : NULL;
            l2 = om ? *(BYTE **)(om + 0x40) : NULL;
            plog("[ai]   active agent %s: agent vt %08X, brain vt %08X class %08X%s, orders %s / %s",
                 entity_name(e), (DWORD)(*(BYTE **)agent - g_core_base) + BOS_PREFERRED_BASE,
                 (DWORD)(*(BYTE **)brain - g_core_base) + BOS_PREFERRED_BASE,
                 id - (DWORD)g_core_base + BOS_PREFERRED_BASE,
                 id == (DWORD)VA(0x1025EF00) ? " (= player brain, no orders)" : "",
                 !l1 ? "-" : (*(BYTE **)l1 == l1 ? "empty" : "some"),
                 !l2 ? "-" : (*(BYTE **)l2 == l2 ? "empty" : "some"));
        }
    }
}

static void ai_census(const char *when)
{
    BYTE *iface = *(BYTE **)VA(VA_ENGINE_IFACE);
    AI_CENSUS c;
    memset(&c, 0, sizeof(c));
    if (!iface) return;
    __try {
        for_each_entity(iface, 5, 1, count_agent, &c);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[ai] census failed (exception %08X)", GetExceptionCode());
        return;
    }
    plog("[ai] %s: %d characters, %d with an AI agent, %d of them active (not frozen), %d of those moved since the last report; without:%s",
         when, c.chars, c.agents, c.active, c.moved, c.none[0] ? c.none : " -");
}

static void coop_ai_init(void)
{
    BYTE *game = bos_game(), *iface = *(BYTE **)VA(VA_ENGINE_IFACE);
    void *own = game ? *(void **)(game + 4) : NULL, *before, *hook = (void *)ai_fopen_log;
    /* sub esp,0E8h; mov eax,[__security_cookie] */
    static const BYTE expect[] = { 0x81, 0xEC, 0xE8, 0x00, 0x00, 0x00, 0xA1 };
    if (!game || !iface) return;
    if (memcmp(VA(0x101128F0), expect, sizeof(expect)) != 0) {
        plog("[ai] BosGame AI setup not found at 0x101128F0 - NPC AI stays off");
        return;
    }
    if (!own && g_ai_player[0]) {
        g_found_entity = NULL;
        __try {
            for_each_entity(iface, 5, 1, find_named, g_ai_player);
        } __except (EXCEPTION_EXECUTE_HANDLER) {
            g_found_entity = NULL;
        }
        if (g_found_entity) {
            *(void **)(game + 4) = g_found_entity;
            plog("[ai] no local character: \"%s\" stands in for the AI's player (ai_player)", g_ai_player);
        }
    }
    if (!*(void **)(game + 4)) {
        plog("[ai] no local character - NPC AI not started");
        return;
    }
    before = *(void **)VA(VA_AI_MANAGER_PTR);
    g_real_fopen = *(fn_fopen *)VA(VA_IMP_FOPEN);
    if (!write_code(VA(VA_IMP_FOPEN), &hook, sizeof(hook))) g_real_fopen = NULL;
    __try {
        ((fn_this)VA(0x101128F0))(game);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[ai] AI setup failed (exception %08X)", GetExceptionCode());
    }
    if (g_real_fopen) write_code(VA(VA_IMP_FOPEN), &g_real_fopen, sizeof(g_real_fopen));
    if (!own) *(void **)(game + 4) = NULL;
    plog("[ai] AI world %s (AI manager %p, before %p)",
         *(void **)VA(VA_AI_MANAGER_PTR) ? "started - NPCs think now" :
         "NOT started (the level's AI data did not load?)", *(void **)VA(VA_AI_MANAGER_PTR), before);
    if (*(void **)VA(VA_AI_MANAGER_PTR)) ai_census("after AI setup");
}

/*
 * AI activity counters (diagnostic), reported every 10 s once the mission ran:
 *   tick     BosGame::UpdateSimulation -> AI manager update (call site 0x10110489 -> 0x100A3890)
 *   brain    BOT_ENTITY update, one per active NPC agent (vtable 0x102063C8 slot 8, 0x100B0F50)
 *   think    BOT_BRAIN::Think (vtable 0x1020640C slot 5, 0x100B3480), run by the AI kernel (0x100A5730)
 *   service  AI_ORDER_BRAIN_SERVICE update (vtable 0x10209C44 slot 5, 0x100FF3B0): builds the
 *            NPC's orders from its CharacterOrderList (0x100D64A0)
 *   orders   scripted-order expiry checks (call sites 0x100FE783 / 0x100FE79B -> 0x100CEEF0)
 * plus, per report, how many active NPCs moved (ai_census).
 */
static fn_this o_ai_tick, o_bot_update, o_order_check, o_brain_think, o_order_service;
static volatile LONG g_ai_ticks, g_bot_updates, g_order_checks, g_brain_thinks, g_order_services;
static volatile LONG g_ai_tick_insim, g_ai_tick_paused;
static DWORD g_ai_report_at;

static void __fastcall hook_ai_tick(BYTE *self)
{
    /* 0x100A3890 advances the Kynapse world only if the engine is inside a simulation step
       (vfunc 0x3F8 = KT game+0x88) and the AI manager's +0x10 is 0 */
    BYTE *g = g_kt_base ? *(BYTE **)KVA(0x10185350u) : NULL;
    InterlockedIncrement(&g_ai_ticks);
    if (g && g[0x88]) InterlockedIncrement(&g_ai_tick_insim);
    if (*(DWORD *)(self + 0x10)) InterlockedIncrement(&g_ai_tick_paused);
    t_rng_priv_fwd(1);
    o_ai_tick(self);
    t_rng_priv_fwd(-1);
}
static void __fastcall hook_bot_update(BYTE *self) { InterlockedIncrement(&g_bot_updates); t_rng_priv_fwd(1); o_bot_update(self); t_rng_priv_fwd(-1); }
static void __fastcall hook_order_check(BYTE *self) { InterlockedIncrement(&g_order_checks); t_rng_priv_fwd(1); o_order_check(self); t_rng_priv_fwd(-1); }
static void __fastcall hook_brain_think(BYTE *self) { InterlockedIncrement(&g_brain_thinks); t_rng_priv_fwd(1); o_brain_think(self); t_rng_priv_fwd(-1); }
static void __fastcall hook_order_service(BYTE *self) { InterlockedIncrement(&g_order_services); t_rng_priv_fwd(1); o_order_service(self); t_rng_priv_fwd(-1); }

/*
 * Shared random numbers (0.33). Both PCs simulate the same frames, so every random number the
 * simulation draws must be the same on both. The engine's generator (KT 0x10018920: 64-entry
 * additive table, re-seeded by the netcode each frame) is reached through the engine interface
 * (KT vtable 0x10142724 slot 0x428 = random float * max, 0x42C = random int; 12 call sites in
 * Bos_core). Code that runs only on the host - the AI manager update, the bots' brains and order
 * services, the AI kernel, and the AI drive the proxy calls for NPCs - drew from it too, so on the
 * host the later draws of the same frame (bullet spread, ...) came out different: 0.32's only
 * remaining differences were bullets' Position/Direction, from every shooter. Inside those
 * host-only paths the proxy now hands out numbers from a private generator, leaving the shared
 * sequence exactly as the client sees it. [proxy] net_rng_private=1 (0 = off). Every 10 s both
 * PCs log the draws per caller ("[rng] ...") so a remaining host-only caller shows up by name.
 */
static int g_net_rng_private = 1;
static __declspec(thread) int t_rng_priv;
static DWORD g_rng_seed = 0x1234567;
typedef float (__fastcall *fn_rng_float)(void *t, void *edx, float max);
typedef int (__fastcall *fn_rng_int)(void *t, void *edx);
static fn_rng_float o_rng_float;
static fn_rng_int o_rng_int;
#define RNG_CALLERS 64
static struct { DWORD ret; volatile LONG shared, priv; } g_rng_by[RNG_CALLERS];
static volatile LONG g_rng_lock;

static void rng_count(DWORD ret, int priv)
{
    int i, h = (int)((ret >> 2) % RNG_CALLERS);
    while (InterlockedExchange(&g_rng_lock, 1)) Sleep(0);
    for (i = 0; i < RNG_CALLERS; i++, h = (h + 1) % RNG_CALLERS)
        if (g_rng_by[h].ret == ret || g_rng_by[h].ret == 0) {
            g_rng_by[h].ret = ret;
            if (priv) g_rng_by[h].priv++; else g_rng_by[h].shared++;
            break;
        }
    InterlockedExchange(&g_rng_lock, 0);
}

static int rng_private_next(void)
{
    g_rng_seed = g_rng_seed * 214013u + 2531011u;
    return (int)((g_rng_seed >> 16) & 0x7FFF);
}

/* 0.34, see hook_reseed below: KT 0x1000B1E0 = the RNG (+0 base table, +0x100 working table,
   +0x200 id & 63, +0x202 frame % 55, +0x204 (frame + id) & 63; draw 0x10018920). A reseed copies
   the base table over the working one, so working == base means no draw since the last reseed.
   15 inlined reseeds besides the two calls (0x10018968 .. 0x100E85B1) take the frame from
   net+0x14 or from their caller; at the first draw after any of them, inside Simulate(F), the two
   frame indices are set to F (no change when the seed already used F). */
static __declspec(thread) int t_sim_set, t_sim_frame;
static int g_net_rng_frame = 1;          /* coop_config.ini [proxy] net_rng_frame */
static volatile LONG g_draw_fixed, g_draw_fresh_ok, g_draw_in_sim, g_draw_outside;
/* 0.34 session: on the client every Simulate(frame) call was at net+0x14 and every weapon draw
   happened outside Simulate - the prediction passes run the character updates directly (0.32 trace:
   k-th update of a character under one net+0x14 label = host frame label+k). 0.35: hook_ai_drive
   records that pass frame (sim_frame) per thread; at the first draw after a reseed on a client, if
   the RNG was seeded with net+0x14 (+0x202 == label % 55) while the pass simulates another frame,
   the two frame indices are set to that frame. Seeds already at the pass frame are left alone. */
static __declspec(thread) int t_pass_set, t_pass_frame, t_pass_label;
static volatile LONG g_draw_nopass, g_draw_other;
static BYTE *kt_net(void);
static void rng_seed_frame_fix(void)
{
    BYTE *r, *net;
    WORD b, c;
    int label, f;
    if (t_sim_set) InterlockedIncrement(&g_draw_in_sim); else InterlockedIncrement(&g_draw_outside);
    __try {
        net = kt_net();
        if (!net || net[0xDA4] == 1) return;                 /* the master's seeds are the reference */
        r = ((BYTE *(__cdecl *)(void))KVA(0x1000B1E0))();
        if (!r || memcmp(r + 0x100, r, 0x100) != 0) return;  /* not the first draw after a reseed */
        label = *(int *)(net + 0x14);
        if (!t_pass_set || t_pass_label != label) { InterlockedIncrement(&g_draw_nopass); return; }
        f = t_pass_frame < 0 ? 0 : t_pass_frame;
        b = *(WORD *)(r + 0x202);
        if (b == (WORD)(f % 55)) { InterlockedIncrement(&g_draw_fresh_ok); return; }
        if (f == label || b != (WORD)((label < 0 ? 0 : label) % 55)) { InterlockedIncrement(&g_draw_other); return; }
        c = (WORD)((f + *(WORD *)(r + 0x200)) & 0x3F);
        InterlockedIncrement(&g_draw_fixed);
        if (g_net_rng_frame) { *(WORD *)(r + 0x202) = (WORD)(f % 55); *(WORD *)(r + 0x204) = c; }
    } __except (EXCEPTION_EXECUTE_HANDLER) {
    }
}

static float __fastcall hook_rng_float(void *t, void *edx, float max)
{
    DWORD ret = (DWORD)_ReturnAddress();
    if (!t_rng_priv) rng_seed_frame_fix();
    if (t_rng_priv && g_net_rng_private) {
        rng_count(ret, 1);
        return (float)rng_private_next() * *(float *)KVA(0x101416B0) * max;
    }
    rng_count(ret, 0);
    return o_rng_float(t, edx, max);
}

static int __fastcall hook_rng_int(void *t, void *edx)
{
    DWORD ret = (DWORD)_ReturnAddress();
    if (!t_rng_priv) rng_seed_frame_fix();
    if (t_rng_priv && g_net_rng_private) {
        rng_count(ret, 1);
        return rng_private_next();
    }
    rng_count(ret, 0);
    return o_rng_int(t, edx);
}

static void rng_report(void)
{
    char line[900];
    int i, n = 0, k;
    LONG s, p, ts = 0, tp = 0;
    if (!o_rng_float && !o_rng_int) return;
    k = _snprintf(line, sizeof(line), "[rng] last 10 s random draws by caller (shared/private):");
    while (InterlockedExchange(&g_rng_lock, 1)) Sleep(0);
    for (i = 0; i < RNG_CALLERS; i++) {
        DWORD r = g_rng_by[i].ret;
        if (!r) continue;
        s = g_rng_by[i].shared; p = g_rng_by[i].priv;
        g_rng_by[i].shared = g_rng_by[i].priv = 0;
        ts += s; tp += p;
        if ((s || p) && k > 0 && k < (int)sizeof(line) - 48) {
            if (g_core_base && r >= (DWORD)g_core_base && r < (DWORD)g_core_base + 0x400000)
                k += _snprintf(line + k, sizeof(line) - k, " Bos:%08lX=%ld/%ld", r - (DWORD)g_core_base + BOS_PREFERRED_BASE, s, p);
            else if (g_kt_base && r >= (DWORD)g_kt_base && r < (DWORD)g_kt_base + 0x400000)
                k += _snprintf(line + k, sizeof(line) - k, " KT:%08lX=%ld/%ld", r - (DWORD)g_kt_base + BOS_PREFERRED_BASE, s, p);
            else
                k += _snprintf(line + k, sizeof(line) - k, " %08lX=%ld/%ld", r, s, p);
            n++;
        }
    }
    InterlockedExchange(&g_rng_lock, 0);
    if (n) plog("%s  (total %ld shared, %ld private)", line, ts, tp);
}

/*
 * Random seed of an entity update (0.34). The engine RNG is reseeded before every entity update
 * from (entity id & 0xFFFF, frame) (KT 0x10007920, thiscall(rng, id, frame), ret 8), so a weapon's
 * spread (Bos 0x1018BF19/36) and recoil (0x1001E31D/4D) are the same on every PC for the same
 * entity in the same frame. Simulate(frame) (KT 0x10028630, slot 2 of SimulationEngine 0x10143F38,
 * Client 0x101419C4 and KTServer 0x1014DB44) seeds each entity with its frame argument, but the
 * update it then calls (0x1000DB70 -> 0x1000DBA5; 0x1000C350 -> 0x100AE1D0 -> 0x100AE1FA) seeds
 * it again with net+0x14 (0x1003ACC0). On the master that is the same frame. A client predicting
 * frames N+1, N+2 ... still has N there, so every predicted shot got the spread of frame N: the
 * bullets (type 31 Position/Direction) were the only entities still differing in 0.32/0.33, for
 * every shooter. Both reseed calls now use the frame Simulate was called with.
 */
typedef void (__fastcall *fn_sim)(BYTE *self, void *edx, int frame);
typedef void (__fastcall *fn_reseed)(void *rng, void *edx, int id, int frame);
static fn_sim o_simulate;
static fn_reseed o_reseed;
static volatile LONG g_seed_moved, g_seed_same, g_seed_outside, g_simf_agree, g_simf_differ, g_sim_calls, g_sim_ahead;

static BYTE *kt_net(void);
static void __fastcall hook_simulate(BYTE *self, void *edx, int frame)
{
    int ps = t_sim_set, pf = t_sim_frame;
    BYTE *net = kt_net();
    InterlockedIncrement(&g_sim_calls);
    if (net && frame != *(int *)(net + 0x14)) InterlockedIncrement(&g_sim_ahead);
    t_sim_set = 1;
    t_sim_frame = frame;
    o_simulate(self, edx, frame);
    t_sim_set = ps;
    t_sim_frame = pf;
}

static void __fastcall hook_reseed(void *rng, void *edx, int id, int frame)
{
    if (t_sim_set) {
        if (t_sim_frame != frame) {
            InterlockedIncrement(&g_seed_moved);
            if (g_net_rng_frame) frame = t_sim_frame;
        } else {
            InterlockedIncrement(&g_seed_same);
        }
    } else {
        InterlockedIncrement(&g_seed_outside);
    }
    o_reseed(rng, edx, id, frame);
}

static void seed_report(void)
{
    LONG m = InterlockedExchange(&g_seed_moved, 0), s = InterlockedExchange(&g_seed_same, 0);
    LONG o = InterlockedExchange(&g_seed_outside, 0), a = InterlockedExchange(&g_simf_agree, 0);
    LONG d = InterlockedExchange(&g_simf_differ, 0);
    LONG df = InterlockedExchange(&g_draw_fixed, 0), dk = InterlockedExchange(&g_draw_fresh_ok, 0);
    LONG di = InterlockedExchange(&g_draw_in_sim, 0), dd = InterlockedExchange(&g_draw_outside, 0);
    LONG sc = InterlockedExchange(&g_sim_calls, 0), sa = InterlockedExchange(&g_sim_ahead, 0);
    LONG dn = InterlockedExchange(&g_draw_nopass, 0), dx = InterlockedExchange(&g_draw_other, 0);
    if (!o_reseed || !(m || s || o || di || dd || sc)) return;
    plog("[rng] last 10 s: %ld Simulate(frame) calls, %ld of them not at net+0x14; draws %ld inside Simulate, %ld outside; client first draws after a reseed: %ld seeded with "
         "net+0x14 in a predicted pass (%s), %ld already at the pass frame, %ld other seed, %ld with no pass frame. Reseed calls: %ld at a predicted frame, %ld at the simulated "
         "frame, %ld outside Simulate. NPC frame count vs Simulate frame: %ld agree, %ld differ",
         sc, sa, di, dd, df, g_net_rng_frame ? "set to the pass frame" : "left, net_rng_frame=0", dk, dx, dn, m, s, o, a, d);
}

static void install_seed_hooks(void)
{
    static const DWORD vt[3] = { 0x10143F38, 0x101419C4, 0x1014DB44 };
    static const char *nm[3] = { "simulate_frame#engine", "simulate_frame#client", "simulate_frame#server" };
    int i;
    void *o;
    if (!g_kt_base) return;
    for (i = 0; i < 3; i++) {
        o = hook_kt_vtable(nm[i], vt[i], 2, 0x10028630, (void *)hook_simulate);
        if (o && !o_simulate) o_simulate = (fn_sim)o;
    }
    o_reseed = (fn_reseed)hook_kt_call_site("entity_reseed#1", 0x1000DBA5, 0x10007920, (void *)hook_reseed);
    o = hook_kt_call_site("entity_reseed#2", 0x100AE1FA, 0x10007920, (void *)hook_reseed);
    if (!o_reseed) o_reseed = (fn_reseed)o;
    plog("[rng] entity reseeds use the simulated frame (net_rng_frame=%d)", g_net_rng_frame);
}

static int t_rng_priv_fwd(int d) { t_rng_priv += d; return t_rng_priv; }
static fn_this o_ai_kernel1, o_ai_kernel2;
static void __fastcall hook_ai_kernel1(BYTE *self) { t_rng_priv++; o_ai_kernel1(self); t_rng_priv--; }
static void __fastcall hook_ai_kernel2(BYTE *self) { t_rng_priv++; o_ai_kernel2(self); t_rng_priv--; }

static void install_rng_hooks(void)
{
    if (!g_kt_base) {
        plog("[rng] KT_Game.dll not loaded - random-number hooks skipped");
        return;
    }
    o_rng_float = (fn_rng_float)hook_kt_vtable("rng_float", 0x10142724, 0x428 / 4, 0x1001E570, (void *)hook_rng_float);
    o_rng_int = (fn_rng_int)hook_kt_vtable("rng_int", 0x10142724, 0x42C / 4, 0x1001E5A0, (void *)hook_rng_int);
    o_ai_kernel1 = (fn_this)hook_call_site("ai_kernel_rng#1", 0x10110451, 0x100A5730, (void *)hook_ai_kernel1);
    o_ai_kernel2 = (fn_this)hook_call_site("ai_kernel_rng#2", 0x101105D4, 0x100A5730, (void *)hook_ai_kernel2);
    plog("[rng] host-only AI code draws from a private generator (net_rng_private=%d)", g_net_rng_private);
    install_seed_hooks();
}

/*
 * NPC movement (2026-10-29: in the user's 0.9 test NPCs thought and talked but none moved).
 * PLAYER update (vtable 0x101FE0DC slot 3, 0x1005AEF0, thiscall, 1 arg = input command or
 * NULL): with a command it copies it into its character's pending command (+0x144/+0x148/
 * +0x154/+0x158, 0x1005A860); in MP with the PLAYER's +0x4C var 0 it clears that pending
 * command instead (0x1005AE3A -> 0x10001410). Every scene NPC has a PLAYER in MP. Counted
 * here: calls with a command, for human and NPC PLAYERs; npc_input_block=1 drops the command
 * for NPC PLAYERs so it cannot overwrite what the AI wants.
 * CHARACTER fields the AI drives (0x10005200, run in the character update for characters with
 * an agent): +0x5C8 AI speed, +0x5CC, +0x1C0 move flags (bits 8/16 walk/run); +0x12C..+0x140
 * current command, +0x144..+0x158 pending command (copied to current in 0x10013990).
 */
static int g_npc_input_block = 1;         /* coop_config.ini [proxy] npc_input_block */
static volatile LONG g_npc_cmd_applied;   /* NPC commands with axes/buttons applied (both PCs) */
static int npc_frame_command(BYTE *player, DWORD *buf11, DWORD **out);   /* NPC commands, both PCs */
static void frz_register(BYTE *ch);                                     /* 0.47 NPC Freeze sync */
static void hfz_note(void *var, BYTE *ch);                              /* 0.66 player Freeze guard */
static void hfz_watch(void);
static void frz_apply(BYTE *ch, int frame);
static fn_this_1 o_player_update;
static volatile LONG g_pl_cmd_human, g_pl_cmd_npc, g_pl_nocmd, g_pl_blocked;
static int is_human_character(BYTE *ch);
static int is_human_player(BYTE *player, BYTE *ch);
static void rv_tp_apply(BYTE *pl, BYTE *ch);

/*
 * 2026-10-29 (0.11). What is known:
 * - the only code that writes a character's pending command is 0x1005A860 (PLAYER update with
 *   a command); the character update moves and fires from the current command (+0x13C bits
 *   1/2 strafe, 4/8 forward/back, 0x10 run, +0x140 more buttons; facing +0x19C/+0x1A0), for AI
 *   characters too (0x10014295: only the speed limits differ);
 * - the engine (KT 0x1000B940) builds a command only for the local player; in MP the server's
 *   per-frame list (KT 0x100B62F0, filled from the network, 0x100B0200) also holds one for every
 *   NPC PLAYER, all buttons/axes zero (logged in 0.10);
 * - in MP the PLAYER update, with the PLAYER's +0x4C var == 0, clears its character's pending
 *   command instead of copying (0x1005AE3A); solo skips that check.
 * Not known: who supplies NPC commands in solo. So for NPC PLAYERs: an empty command (axes and
 * buttons zero) is dropped as in 0.10; one that carries something is passed on with IsSolo
 * forced for the call, so the +0x4C check cannot clear it. Every NPC PLAYER update is counted
 * by caller (return address) so one solo run shows where solo NPC commands come from.
 */
static fn_bool_0 o_is_solo;               /* defined with the NPC equipment hooks below */
static DWORD g_force_solo_tid;
#define PL_SOURCES 8
static struct { DWORD ret; LONG with_cmd, empty, without; } g_pl_src[PL_SOURCES];
static volatile LONG g_pl_passed;

static void pl_count_source(DWORD ret, int kind)
{
    int i;
    for (i = 0; i < PL_SOURCES; i++) {
        if (g_pl_src[i].ret == ret || (!g_pl_src[i].ret && InterlockedCompareExchange((LONG *)&g_pl_src[i].ret, (LONG)ret, 0) == 0)) {
            if (g_pl_src[i].ret != ret) continue;
            InterlockedIncrement(kind == 0 ? &g_pl_src[i].without : kind == 1 ? &g_pl_src[i].empty : &g_pl_src[i].with_cmd);
            return;
        }
    }
}

static void pl_describe(DWORD addr, char *out, int size)
{
    HMODULE m = NULL;
    char mod[MAX_PATH] = "?";
    GetModuleHandleExA(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS | GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT,
                       (LPCSTR)addr, &m);
    if (m) GetModuleFileNameA(m, mod, sizeof(mod));
    _snprintf(out, size, "%s+0x%X", strrchr(mod, '\\') ? strrchr(mod, '\\') + 1 : mod, m ? addr - (DWORD)m : addr);
    out[size - 1] = 0;
}

static DWORD __fastcall hook_player_update(BYTE *self, void *edx, DWORD cmd)
{
    BYTE *ch = NULL;
    DWORD *c = (DWORD *)cmd, ret = (DWORD)_ReturnAddress(), r;
    int empty;
    __try {
        ch = (BYTE *)((DWORD (__fastcall *)(BYTE *, void *))VA(0x10058D00))(self, 0);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        ch = NULL;
    }
    if (!ch || is_human_player(self, ch)) {
        InterlockedIncrement(cmd ? &g_pl_cmd_human : &g_pl_nocmd);
        if (ch) __try { void *fv = *(void **)(ch + 0x164); if (fv) hfz_note(fv, ch); } __except (EXCEPTION_EXECUTE_HANDLER) {}
        if (ch) rv_tp_apply(self, ch);
        return o_player_update(self, edx, cmd);
    }
    frz_register(ch);
    {
        /* both PCs: the NPC gets exactly the command the frame table gives it in this frame, or none */
        DWORD host_cmd[11], *hc;
        if (npc_frame_command(self, host_cmd, &hc)) {
            cmd = (DWORD)hc;
            c = hc;
        }
    }
    if (!cmd) {
        pl_count_source(ret, 0);
        return o_player_update(self, edx, cmd);
    }
    InterlockedIncrement(&g_pl_cmd_npc);
    /* +0x18/+0x1C axes, +0x20/+0x24 buttons; a client's predicted NPC command has axes -0.0 */
    empty = !(c[6] & 0x7FFFFFFF) && !(c[7] & 0x7FFFFFFF) && !c[8] && !c[9];
    if (!empty) InterlockedIncrement(&g_npc_cmd_applied);
    pl_count_source(ret, empty ? 1 : 2);
    if (!empty) {
        static volatile LONG logged;
        char src[96];
        if (InterlockedIncrement(&logged) <= 10) {
            pl_describe(ret, src, sizeof(src));
            plog("[ai] NPC PLAYER of %s gets a real command from %s: axes %08X %08X buttons %08X %08X",
                 entity_name(ch), src, c[6], c[7], c[8], c[9]);
        }
    }
    if (!g_npc_input_block)
        return o_player_update(self, edx, cmd);
    if (empty) {
        InterlockedIncrement(&g_pl_blocked);
        return o_player_update(self, edx, 0);
    }
    InterlockedIncrement(&g_pl_passed);
    if (!o_is_solo || g_force_solo_tid)
        return o_player_update(self, edx, cmd);
    g_force_solo_tid = GetCurrentThreadId();
    __try {
        r = o_player_update(self, edx, cmd);
    } __finally {
        g_force_solo_tid = 0;
    }
    return r;
}

/*
 * Enemies target only characters the AI knows as a "Player": 0x100A82A0 (thiscall on the AI
 * manager, 1 arg = character) creates that agent and stores it at character +0x58. The AI
 * setup does it once, for the host's character. Once a second (MP host) every human character
 * without an agent gets one: clients that joined, and anyone who respawned (a new CHARACTER).
 */
static void ai_bind_human(BYTE *e, void *ctx)
{
    BYTE *mgr = (BYTE *)ctx;
    if (*(void **)(e + 0x58) || !is_human_character(e)) return;
    __try {
        ((void (__fastcall *)(BYTE *, void *, BYTE *))VA(0x100A82A0))(mgr, 0, e);
        plog("[ai] %s is now a target for the AI (agent %p)", entity_name(e), *(void **)(e + 0x58));
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        static int once;
        if (!once++) plog("[ai] registering %s with the AI failed (exception %08X)", entity_name(e), GetExceptionCode());
    }
}

/*
 * Sides. Friend or foe is the CHARACTER "Team" var (enum None, WRF, UAN, SYNDICATE, RESISTANCE;
 * defined at 0x1000CE47, var at +0x248, value cached at +0x24C, read by 0x100036E0). The AI
 * compares it (e.g. 0x1003FA0D, 0x1013EBA1): equal and not None = friend. A character spawned by
 * MP gets its MP team, not the campaign's, so friendly NPCs shot the players. Every human
 * character gets the Team of the scene's campaign player character ("Player", coop_team_from),
 * through the game's own SetVarValue so the var and the cached value agree.
 */
static char g_team_from[64] = "Player";  /* coop_config.ini [proxy] coop_team_from; empty = off */
static char g_team_test[64];             /* [proxy] team_test: also treat this NPC as a player (test) */
static const char *const k_team_names[] = { "None", "WRF", "UAN", "SYNDICATE", "RESISTANCE" };

static const char *team_name(int t)
{
    return t >= 0 && t < (int)(sizeof(k_team_names) / sizeof(k_team_names[0])) ? k_team_names[t] : "?";
}

#define TEAM_FIX_MAX 8
struct team_fix { int team, n; BYTE *ch[TEAM_FIX_MAX]; };

static void team_collect(BYTE *e, void *ctx)
{
    struct team_fix *f = (struct team_fix *)ctx;
    if (f->n < TEAM_FIX_MAX && *(int *)(e + 0x24C) != f->team &&
        (is_human_character(e) || (g_team_test[0] && strcmp(entity_name(e), g_team_test) == 0)))
        f->ch[f->n++] = e;
}

static void coop_team_fix(BYTE *iface)
{
    static int logged_from, logged;
    struct team_fix f;
    char code[256];
    const char *n;
    int i, before;
    if (!g_team_from[0]) return;
    g_found_entity = NULL;
    for_each_entity(iface, 5, 1, find_named, g_team_from);
    if (!g_found_entity) return;
    f.team = *(int *)(g_found_entity + 0x24C);
    f.n = 0;
    if (!logged_from++) plog("[team] campaign side: %s is %s (%d)", g_team_from, team_name(f.team), f.team);
    if (f.team <= 0 || f.team >= (int)(sizeof(k_team_names) / sizeof(k_team_names[0]))) return;
    for_each_entity(iface, 5, 1, team_collect, &f);
    for (i = 0; i < f.n; i++) {
        n = entity_name(f.ch[i]);
        if (strchr(n, ']')) {
            plog("[team] %s: name can't be passed to Lua - side not changed", n);
            continue;
        }
        if (logged >= 20) continue;   /* the set did not stick: stop retrying, the log says so */
        before = *(int *)(f.ch[i] + 0x24C);
        _snprintf(code, sizeof(code), "SetVarValue(GetCharacterID([[%s]]),\"Team\",\"%s\")", n, team_name(f.team));
        code[sizeof(code) - 1] = 0;
        lua_run("coop_team", code, 1);
        logged++;
        plog("[team] %s: %s (%d) -> %s, now %s (%d)", n, team_name(before), before, team_name(f.team),
             team_name(*(int *)(f.ch[i] + 0x24C)), *(int *)(f.ch[i] + 0x24C));
    }
}

/* 0.36: ai_humans=0 leaves the humans without the host-only AI agent. The 0.35 checksum diff had the two
   human characters (and the mercenaries following them) as the most frequent differences, and only the
   host's copy of a human has an agent - the client's never does, so the same character is updated
   by different engine paths on the two PCs. The campaign Team is still set. */
static int g_ai_humans = 1;              /* coop_config.ini [proxy] ai_humans */
static void ai_bind_humans(void)
{
    static DWORD next;
    BYTE *mgr = *(BYTE **)VA(VA_AI_MANAGER_PTR), *iface = *(BYTE **)VA(VA_ENGINE_IFACE);
    if (!mgr || !iface || GetTickCount() < next) return;
    next = GetTickCount() + 1000;
    if (strcmp(nw_state_name(), "MASTER") != 0) return;
    __try {
        if (g_ai_humans) for_each_entity(iface, 5, 1, ai_bind_human, mgr);
        coop_team_fix(iface);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
    }
}

static void pl_report(void)
{
    int i;
    char src[96];
    plog("[ai]   PLAYER updates: %ld with a command for humans, %ld for NPCs (%ld empty dropped, %ld real passed), %ld humans without",
         InterlockedExchange(&g_pl_cmd_human, 0), InterlockedExchange(&g_pl_cmd_npc, 0),
         InterlockedExchange(&g_pl_blocked, 0), InterlockedExchange(&g_pl_passed, 0),
         InterlockedExchange(&g_pl_nocmd, 0));
    for (i = 0; i < PL_SOURCES && g_pl_src[i].ret; i++) {
        LONG w = InterlockedExchange(&g_pl_src[i].with_cmd, 0), e = InterlockedExchange(&g_pl_src[i].empty, 0),
             n = InterlockedExchange(&g_pl_src[i].without, 0);
        if (!w && !e && !n) continue;
        pl_describe(g_pl_src[i].ret, src, sizeof(src));
        plog("[ai]     NPC PLAYER updates from %s: %ld with a real command, %ld empty, %ld without", src, w, e, n);
    }
}

/* the first active NPC agents: what the AI asks of their character */
static void ai_probe_char(BYTE *e, void *ctx)
{
    int *n = (int *)ctx;
    BYTE *agent = *(BYTE **)(e + 0x58), *brain;
    float p[3] = { 0 };
    if (*n >= 4 || !agent || !agent[0x6C] || is_human_character(e)) return;
    brain = *(BYTE **)(agent + 0x18);
    if (!brain || ((DWORD (__fastcall *)(BYTE *, void *))(*(void ***)brain)[1])(brain, 0) == (DWORD)VA(0x1025EF00))
        return;
    (*n)++;
    entity_position(e, p);
    plog("[ai]   %s at (%.1f, %.1f, %.1f): AI speed %.2f, +5CC %d, +5CD %d, flags +1C0 %08X, "
         "pending cmd %08X %08X %08X/%08X, current cmd %08X %08X %08X/%08X",
         entity_name(e), p[0], p[1], p[2], *(float *)(e + 0x5C8), e[0x5CC], e[0x5CD], *(DWORD *)(e + 0x1C0),
         *(DWORD *)(e + 0x144), *(DWORD *)(e + 0x148), *(DWORD *)(e + 0x154), *(DWORD *)(e + 0x158),
         *(DWORD *)(e + 0x12C), *(DWORD *)(e + 0x130), *(DWORD *)(e + 0x13C), *(DWORD *)(e + 0x140));
}

/* diagnostic: GROUP vars-changed (vtable 0x101FC2EC slot 1, 0x1003D6F0) copies its "Character"
   var (var object +0x64) into the member slots +0x68 when that var reports a change (vfunc 0x8C).
   FreezeAll (0x1003E050 -> 0x1003D350) reaches the members only through those slots; the first
   entity update after BeginPlay fills them, so a FreezeAll before that does nothing (2026-10-21). */
static fn_this o_group_vars;
static volatile LONG g_group_vars_logs;

static void __fastcall hook_group_vars(BYTE *self)
{
    BYTE *var = *(BYTE **)(self + 0x64);
    BYTE changed = var ? ((fn_bool_0)(*(void ***)var)[0x8C / 4])(var, 0) : 0;
    o_group_vars(self);
    if (changed && *(DWORD *)(self + 0x68) == 0xFFFFFFFFu && InterlockedIncrement(&g_group_vars_logs) <= 10)
        plog("[group] %s: Character var applied but the group has no member - FreezeAll on it does nothing",
             entity_name(self));
}

static void install_ai_hooks(void)
{
    o_group_vars = (fn_this)hook_vtable("group_vars_log", 0x101FC2EC, 1, 0x1003D6F0, (void *)hook_group_vars);
    o_ai_tick = (fn_this)hook_call_site("ai_tick_count", 0x10110489, 0x100A3890, (void *)hook_ai_tick);
    o_bot_update = (fn_this)hook_vtable("ai_brain_count", 0x102063C8, 8, 0x100B0F50, (void *)hook_bot_update);
    o_brain_think = (fn_this)hook_vtable("ai_think_count", 0x1020640C, 5, 0x100B3480, (void *)hook_brain_think);
    o_order_service = (fn_this)hook_vtable("ai_order_service_count", 0x10209C44, 5, 0x100FF3B0, (void *)hook_order_service);
    o_order_check = (fn_this)hook_call_site("ai_order_count#1", 0x100FE783, 0x100CEEF0, (void *)hook_order_check);
    hook_call_site("ai_order_count#2", 0x100FE79B, 0x100CEEF0, (void *)hook_order_check);
    o_player_update = (fn_this_1)hook_vtable("npc_player_input", 0x101FE0DC, 3, 0x1005AEF0, (void *)hook_player_update);
}

/* free entity-iterator slots per world (pool +0xC4; server pool: [KT 0x10185344]+0x50 -> +4,
 * client pool: [KT 0x10185348] -> +4, as in 0x1001E5B0). A falling count is a leak. */
static int iter_free_slots(DWORD world)
{
    BYTE *w, *pool;
    __try {
        w = *(BYTE **)KVA(world ? 0x10185344 : 0x10185348);
        if (!w) return -1;
        pool = *(BYTE **)(w + (world ? 0x54 : 0x04));
        return pool ? *(int *)(pool + 0xC4) : -1;
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        return -2;
    }
}

static void ai_report(void)
{
    LONG ticks, insim, paused, bots, thinks, services, orders;
    void *mgr = *(void **)VA(VA_AI_MANAGER_PTR);
    /* also in solo (no co-op mission start there): whenever an AI world exists */
    if ((!g_mission_started && !mgr) || GetTickCount() < g_ai_report_at) return;
    g_ai_report_at = GetTickCount() + 10000;
    ticks = InterlockedExchange(&g_ai_ticks, 0);
    insim = InterlockedExchange(&g_ai_tick_insim, 0);
    paused = InterlockedExchange(&g_ai_tick_paused, 0);
    bots = InterlockedExchange(&g_bot_updates, 0);
    thinks = InterlockedExchange(&g_brain_thinks, 0);
    services = InterlockedExchange(&g_order_services, 0);
    orders = InterlockedExchange(&g_order_checks, 0);
    if (!mgr && !ticks && !bots && !thinks) return;      /* no AI world (coop_ai_init said why) */
    plog("[iter] free entity iterators: server world %d, client world %d", iter_free_slots(1), iter_free_slots(0));
    plog("[ai] last 10 s: %ld AI ticks (%ld in a sim step, %ld with manager+0x10 set), %ld NPC brain updates, %ld thinks, %ld order-service runs, %ld order checks (AI manager %p)",
         ticks, insim, paused, bots, thinks, services, orders, mgr);
    pl_report();
    if (mgr) {
        BYTE *iface = *(BYTE **)VA(VA_ENGINE_IFACE);
        int n = 0;
        ai_census("now");
        __try {
            if (iface) for_each_entity(iface, 5, 1, ai_probe_char, &n);
        } __except (EXCEPTION_EXECUTE_HANDLER) {
            plog("[ai] NPC probe failed (exception %08X)", GetExceptionCode());
        }
    }
}

/*
 * The AI kernel (brains think, order services turn order lists into orders)
 * is updated by 0x100A5730, which BosGame calls from the render export
 * ExportUpdateRenderModAfterAll (0x101105D4: if BosGame+0x51 && !BosGame+0x28
 * && AI manager). The dedicated server renders nothing, so it never runs
 * there; ai_kernel_on_sim=1 calls it once per simulation frame instead, for
 * tests on the dedicated server only.
 */
static void ai_kernel_on_sim(void)
{
    BYTE *game = bos_game(), *mgr = *(BYTE **)VA(VA_AI_MANAGER_PTR);
    if (!game || !mgr || !game[0x51] || *(DWORD *)(game + 0x28)) return;
    __try {
        ((fn_this)VA(0x100A5730))(mgr);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        static int once;
        if (!once++) plog("[ai] AI kernel update failed (exception %08X)", GetExceptionCode());
    }
}

/* once a second while the mission runs: the co-op layer's cut-scene safety net (coop_mission.lua) */
static void coop_restart_tick(void);
/* 0.55: squad commands (solo F1-F4) on the co-op host. BosGame's update (0x101104A0) reads the
   actions SwitchMerc1Follow / SwitchMerc2Follow / Merc1Action / Merc2Action and calls the
   mercenary manager (0x10003E40): set follow 0x100A90D0(i, on), set "come here" 0x100A9100(i, on),
   following? 0x100A9120(i), coming? 0x100A9140(i) - F1/F2: coming -> follow again, else toggle
   follow/hold; F3/F4: toggle "come here". The keys come from Binding.cfg; on a press the state is
   logged, and if the game's own handler did not change it two frames later the proxy applies the
   solo rule itself. Host only: the mercenaries' AI runs there. */
typedef void (__fastcall *fn_merc_set)(void *ecx, void *edx, int i, int on);
typedef BYTE (__fastcall *fn_merc_get)(void *ecx, void *edx, int i);
static int g_merc_vk[4] = { -1, -1, -1, -1 };   /* SwitchMerc1Follow, SwitchMerc2Follow, Merc1Action, Merc2Action */
static int g_merc_keys_read;
static int vk_from_control(const char *c)
{
    if (strncmp(c, "KEYBOARD_", 9) != 0) return -1;
    c += 9;
    if (c[0] == 'F' && c[1] >= '1' && c[1] <= '9') { int n = atoi(c + 1); if (n >= 1 && n <= 12) return VK_F1 + n - 1; }
    if (c[1] == 0 && ((c[0] >= 'A' && c[0] <= 'Z') || (c[0] >= '0' && c[0] <= '9'))) return c[0];
    if (strncmp(c, "NUMPAD", 6) == 0 && c[6] >= '0' && c[6] <= '9' && !c[7]) return VK_NUMPAD0 + c[6] - '0';
    return -1;
}
static void merc_read_keys(void)
{
    static const char *act[4] = { "SwitchMerc1Follow", "SwitchMerc2Follow", "Merc1Action", "Merc2Action" };
    char line[256], want[64];
    FILE *f = fopen("Mods/Bos/Settings/Binding.cfg", "r");
    int i;
    g_merc_keys_read = 1;
    if (!f) { plog("[squad] Binding.cfg not found - squad keys F1-F4"); }
    for (i = 0; i < 4; i++) g_merc_vk[i] = VK_F1 + i;
    if (!f) return;
    while (fgets(line, sizeof line, f)) {
        for (i = 0; i < 4; i++) {
            char *q;
            _snprintf(want, sizeof want, "%s[\"control1\"] = \"", act[i]);
            if (strncmp(line, want, strlen(want)) == 0) {
                q = strchr(line + strlen(want), '"');
                if (q) { int vk; *q = 0; vk = vk_from_control(line + strlen(want));
                    if (vk > 0) g_merc_vk[i] = vk;
                    else plog("[squad] %s bound to %s - not a key the proxy reads, keeping F%d", act[i], line + strlen(want), i + 1); }
            }
        }
    }
    fclose(f);
    plog("[squad] keys: merc 1 follow/hold %02X, merc 2 follow/hold %02X, merc 1 come here %02X, merc 2 come here %02X",
         g_merc_vk[0], g_merc_vk[1], g_merc_vk[2], g_merc_vk[3]);
}
static int merc_state(int i, BYTE *fol, BYTE *come)
{
    void *mgr;
    __try {
        mgr = ((void *(__cdecl *)(void))VA(0x10003E40))();
        if (!mgr) return 0;
        *fol = ((fn_merc_get)VA(0x100A9120))(mgr, NULL, i);
        *come = ((fn_merc_get)VA(0x100A9140))(mgr, NULL, i);
        return 1;
    } __except (EXCEPTION_EXECUTE_HANDLER) { return 0; }
}
static void merc_apply(int key)
{
    int i = key & 1;
    BYTE fol, come;
    void *mgr;
    if (!merc_state(i, &fol, &come)) return;
    __try {
        mgr = ((void *(__cdecl *)(void))VA(0x10003E40))();
        if (key < 2) {
            if (come) { ((fn_merc_set)VA(0x100A90D0))(mgr, NULL, i, 1); ((fn_merc_set)VA(0x100A9100))(mgr, NULL, i, 0); }
            else ((fn_merc_set)VA(0x100A90D0))(mgr, NULL, i, fol ? 0 : 1);
        } else
            ((fn_merc_set)VA(0x100A9100))(mgr, NULL, i, come ? 0 : 1);
    } __except (EXCEPTION_EXECUTE_HANDLER) { plog("[squad] command faulted (%08X)", GetExceptionCode()); }
}
static int g_run_flags;                  /* run_state_watch: bit 0 window active, bit 1 menu mouse */
static void merc_watch(void)
{
    static int down[4], pending = -1, wait;
    static BYTE before_f, before_c;
    static const char *what[4] = { "merc 1 follow/hold", "merc 2 follow/hold", "merc 1 come here", "merc 2 come here" };
    int k;
    BYTE f, c;
    if (!g_mission_started || strcmp(nw_state_name(), "MASTER") != 0) { pending = -1; return; }
    if (!g_merc_keys_read) merc_read_keys();
    if (pending >= 0 && --wait <= 0) {
        if (merc_state(pending & 1, &f, &c)) {
            if (f == before_f && c == before_c) {
                merc_apply(pending);
                merc_state(pending & 1, &f, &c);
                plog("[squad] %s: the game did not act - applied by the proxy -> following %d, come here %d", what[pending], f, c);
            } else
                plog("[squad] %s: done by the game -> following %d, come here %d", what[pending], f, c);
        }
        pending = -1;
    }
    for (k = 0; k < 4; k++) {
        int now = (g_merc_vk[k] > 0) && (GetAsyncKeyState(g_merc_vk[k]) & 0x8000) && (g_run_flags & 3) == 1;
        if (now && !down[k] && pending < 0) {
            if (merc_state(k & 1, &before_f, &before_c)) {
                plog("[squad] %s pressed (following %d, come here %d)", what[k], before_f, before_c);
                pending = k; wait = 2;
            } else plog("[squad] %s pressed - no mercenary manager", what[k]);
        }
        down[k] = now;
    }
}

static void lives_tick(void);
static void lives_reset(void);
static void coop_tick(void)
{
    BYTE *game = bos_game(), *cam;
    char code[64], list[600];
    int i, n;
    coop_restart_tick();
    if (g_mission_started) lives_tick();
    if (!g_coop_lua_loaded || !g_mission_started || GetTickCount() < g_coop_tick_at) return;
    g_coop_tick_at = GetTickCount() + 1000;
    /* Coop_Humans: the human players' character names (= player names), for scripts that must
       move or check every player (the champion fight's arena) */
    n = _snprintf(list, sizeof(list), "Coop_Humans = {");
    for (i = 0; i < g_nhumans && n > 0 && n < (int)sizeof(list) - 80; i++)
        if (!strstr(g_human_names[i], "]]"))
            n += _snprintf(list + n, sizeof(list) - n, "[[%s]],", g_human_names[i]);
    if (n > 0 && n < (int)sizeof(list) - 2) {
        strcpy(list + n, "}");
        lua_run("Coop_Humans", list, 1);
    }
    cam = game ? *(BYTE **)(game + 0x14) : NULL;
    _snprintf(code, sizeof(code), "if Coop_Tick then Coop_Tick(%d) end", cam ? *(int *)(cam + 0x90) : -1);
    lua_run("Coop_Tick", code, 1);
}

/* ------------------------------------------------------------------------ */
/* solo mission screens (briefing / BOS / mercenaries / weapons) in co-op    */
/* ------------------------------------------------------------------------ */
/*
 * Solo: the world map's Launch enters "prep mode" (BosGame 0x10110970: BosGame+0x19 = 1, locks
 * the player's input groups; pauses only in solo) and loads the level. At the end of the solo
 * branch of BeginPlayLevel (0x1011398B -> 0x10143830) the mod sends game message 5 if +0x19 is
 * set; its executor (0x1013FC40) opens the mission screens on the loaded level (GUI vfunc 0x430,
 * screen object 0x1013FA00). Their Launch button checks champion / armor / firearm / grenade, then
 * sends message 6 (0x10141BD0); its executor (0x1013FC70) closes the screens (GUI 0x434), leaves
 * prep mode (0x10110A10) and tells the BOS manager (0x10184210).
 * Game messages: table at 0x10251B28, 12 bytes each (flags, executor at +4, check at +8).
 * The BOS manager ([0x1025DD38], getter 0x100595C0) is deleted by MP BeginPlayLevel; the
 * champion check reads its +8 without a NULL test, so like solo (0x10113960) it is set up with
 * 0x101854A0 first.
 * coop_shop=1: the host gets these screens when the co-op mission starts. Experimental.
 */
static BYTE *char_arsenal(BYTE *ch);
static void coop_equip_host(void);
static void coop_camera_on_host(void);
static int g_coop_shop = 1;              /* coop_config.ini [proxy] coop_shop */
static int g_coop_menus;                 /* coop_config.ini [proxy] coop_menus (0 = 0.13 behaviour) */
typedef void (__cdecl *fn_msg_exec)(void *msg);
static fn_msg_exec o_msg5_exec, o_msg6_exec;
static volatile LONG g_shop_open;
static int g_begins_after_shop;
static DWORD g_shop_deadline;            /* mission starts anyway if no Launch by then */

static void __cdecl hook_msg5_exec(void *msg)
{
    plog("[shop] message 5: mission screens open");
    o_msg5_exec(msg);
}

static void __cdecl hook_msg6_exec(void *msg)
{
    int ok = 1;
    plog("[shop] message 6 (Launch): closing the mission screens, leaving prep mode");
    __try {
        o_msg6_exec(msg);     /* also runs OnMissionBegins (BOS manager 0x10184210) */
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        ok = 0;
        plog("[shop] message 6 failed (exception %08X)", GetExceptionCode());
    }
    InterlockedExchange(&g_shop_open, 0);
    coop_equip_host();
    coop_camera_on_host();
    if (ok) g_begins_after_shop = 0;    /* Launch started the mission itself */
    if (g_begins_after_shop && bos_game()) {
        g_begins_after_shop = 0;
        bos_game()[0x1A] = 1;
        plog("[mission] OnMissionBegins requested (BosGame+0x1A) after the mission screens");
    }
    lua_run("coop_shop_done", "if Coop_ShopDone then Coop_ShopDone() end", 1);
}

static void hook_msg_table(void)
{
    void **e5 = (void **)VA(0x10251B28 + 5 * 12 + 4), **e6 = (void **)VA(0x10251B28 + 6 * 12 + 4);
    DWORD old;
    if (*e5 != VA(0x1013FC40) || *e6 != VA(0x1013FC70)) {
        plog("[hook] %-26s message table %08X: unexpected entries %p %p - NOT hooked", "shop_messages",
             0x10251B28, *e5, *e6);
        return;
    }
    if (!VirtualProtect(e5, 32, PAGE_READWRITE, &old)) return;
    o_msg5_exec = (fn_msg_exec)*e5;
    o_msg6_exec = (fn_msg_exec)*e6;
    *e5 = (void *)hook_msg5_exec;
    *e6 = (void *)hook_msg6_exec;
    VirtualProtect(e5, 32, old, &old);
    plog("[hook] %-26s message table %08X[5,6] -> ok", "shop_messages", 0x10251B28);
}

static int coop_open_shop(void)
{
    BYTE *game = bos_game(), *bos;
    if (!g_coop_shop || !game || !local_character() || strcmp(nw_state_name(), "MASTER") != 0) return 0;
    bos = NULL;
    __try {
        bos = ((BYTE *(__cdecl *)(void))VA(0x100595C0))();
    } __except (EXCEPTION_EXECUTE_HANDLER) {
    }
    if (!char_arsenal((BYTE *)local_character()) || !bos || !*(void **)(bos + 8)) {
        plog("[shop] mission screens not opened: host arsenal %p, BOS mission %p (both needed)",
             char_arsenal((BYTE *)local_character()), bos ? *(void **)(bos + 8) : NULL);
        return 0;
    }
    __try {
        ((void (__fastcall *)(BYTE *, void *))VA(0x10110970))(game, 0);       /* prep mode */
        InterlockedExchange(&g_shop_open, 1);
        ((void (__cdecl *)(void))VA(0x1013FC40))();                             /* message 5 executor */
        plog("[shop] mission screens requested for the host (prep mode %d)", game[0x19]);
        return 1;
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[shop] opening the mission screens failed (exception %08X)", GetExceptionCode());
        InterlockedExchange(&g_shop_open, 0);
        return 0;
    }
}

/* ------------------------------------------------------------------------ */
/* single-player career in co-op                                            */
/* ------------------------------------------------------------------------ */
/*
 * The solo career (world-map progress, money and gear, BOS league and champions, mercenary
 * roster, ...) is the MODD block of a save file (e.g. Saves\WorldMap_1.sav: no level entities,
 * only MODD). The engine's save loader (KT 0x1008DDB0) reads the whole file into memory, builds a
 * chunk reader over it (operator new 0x28, KT 0x1008EA30(buffer, _)) and walks the top-level
 * chunks: vfunc 0x50 = at end, 0x64 = chunk id, 0x70 = enter (returns a child reader, owned by
 * the parent), 0x74 = skip. For MODD it calls the mod's ExportModOnLoadingGame (0x10113B50),
 * which hands the same child reader to each loader in save order:
 *   0x10059630 -> 0x10143C10  WMAP, CFTE (world map)
 *   0x10093BF0 -> 0x10117FF0  BOSS (player / character / arsenal vars), MISS (BOS manager:
 *                             mercs, champion, bets), BOXS, CSMC, CAML, AI
 *   0x10069510 -> 0x1017D8C0  BOCM
 *   0x100040F0 -> 0x1012BDC0  HUDD
 *   0x10004240 -> 0x10127270  FPIM
 * 0x10113B50 itself also re-runs the solo player / AI setup when a level is loaded, so the co-op
 * loader calls only these five. coop_career=<file in Saves> (default: newest WorldMap_*.sav).
 */
static char g_career_save[MAX_PATH];     /* coop_config.ini [proxy] coop_career; "-" = off */
static int g_career_loaded;

typedef DWORD (__fastcall *fn_rd0)(void *self, void *edx);
typedef void (__fastcall *fn_load)(void *self, void *edx, void *reader);

static int career_find_save(char *path, int n)
{
    char pat[MAX_PATH], best[MAX_PATH] = "";
    WIN32_FIND_DATAA fd;
    FILETIME bt = { 0, 0 };
    HANDLE h;
    if (g_career_save[0] == '-') return 0;
    if (g_career_save[0]) {
        _snprintf(path, n, "%sMods\\bos\\Saves\\%s", g_game_dir, g_career_save);
        path[n - 1] = 0;
        return GetFileAttributesA(path) != INVALID_FILE_ATTRIBUTES;
    }
    _snprintf(pat, sizeof(pat), "%sMods\\bos\\Saves\\WorldMap_*.sav", g_game_dir);
    h = FindFirstFileA(pat, &fd);
    if (h == INVALID_HANDLE_VALUE) return 0;
    do {
        if (CompareFileTime(&fd.ftLastWriteTime, &bt) > 0) {
            bt = fd.ftLastWriteTime;
            strncpy(best, fd.cFileName, sizeof(best) - 1);
        }
    } while (FindNextFileA(h, &fd));
    FindClose(h);
    if (!best[0]) return 0;
    _snprintf(path, n, "%sMods\\bos\\Saves\\%s", g_game_dir, best);
    path[n - 1] = 0;
    return 1;
}

/* a fresh reader over the save, entered into MODD and skipped forward to chunk <tag>; NULL if absent.
 * *owner receives the top reader (delete with vfunc 0 when done; it owns its children). */
static void *career_reader_at(BYTE *buf, DWORD *size, DWORD tag, void **owner)
{
    BYTE *rd = ((BYTE *(__cdecl *)(DWORD))KVA(0x10135280))(0x28);
    void **vt, *child = NULL, **cvt;
    int n = 0;
    *owner = rd;
    if (!rd) return NULL;
    ((void *(__fastcall *)(BYTE *, void *, void *, void *))KVA(0x1008EA30))(rd, 0, buf, size);
    vt = *(void ***)rd;
    while (!((BYTE (__fastcall *)(void *, void *))vt[0x50 / 4])(rd, 0) && n++ < 64) {
        if (((fn_rd0)vt[0x64 / 4])(rd, 0) == 0x44444F4D) {          /* 'MODD' */
            child = ((void *(__fastcall *)(void *, void *))vt[0x70 / 4])(rd, 0);
            break;
        }
        ((fn_rd0)vt[0x74 / 4])(rd, 0);
    }
    if (!child) return NULL;
    cvt = *(void ***)child;
    for (n = 0; n < 64 && !((BYTE (__fastcall *)(void *, void *))cvt[0x50 / 4])(child, 0); n++) {
        if (((fn_rd0)cvt[0x64 / 4])(child, 0) == tag) return child;
        ((fn_rd0)cvt[0x74 / 4])(child, 0);
    }
    return NULL;
}

static int g_career_fpim;               /* coop_config.ini [proxy] coop_career_fpim */
static void career_load_modd(BYTE *buf, DWORD size)
{
    static const struct { DWORD tag, get, load; const char *what; } k[] = {
        { 0x50414D57, 0x10059630, 0x10143C10, "WMAP world map" },
        { 0x53534F42, 0x10093BF0, 0x10117FF0, "BOSS career (player, arsenal; then MISS BOS / mercenaries, BOXS, CSMC, CAML)" },
        { 0x4D434F42, 0x10069510, 0x1017D8C0, "BOCM" },
        { 0x44445548, 0x100040F0, 0x1012BDC0, "HUDD" },
        { 0x4D495046, 0x10004240, 0x10127270, "FPIM" },
    };
    int i;
    for (i = 0; i < (int)(sizeof(k) / sizeof(k[0])); i++) {
        void *owner = NULL, *rd;
        if (k[i].tag == 0x4D495046 && !g_career_fpim) {
            /* FPIM = first-person view state (arms model / animation, 0x10127270). The solo state
               over the MP one left stretched first-person arms in front of the camera (0.16-0.19). */
            plog("[career]   FPIM first-person view state: skipped (coop_career_fpim=0)");
            continue;
        }
        __try {
            rd = career_reader_at(buf, &size, k[i].tag, &owner);
            if (!rd) {
                plog("[career]   %s: not in this save", k[i].what);
            } else {
                void *obj = ((void *(__cdecl *)(void))VA(k[i].get))();
                ((fn_load)VA(k[i].load))(obj, 0, rd);
                plog("[career]   %s loaded", k[i].what);
            }
        } __except (EXCEPTION_EXECUTE_HANDLER) {
            plog("[career]   %s: exception %08X", k[i].what, GetExceptionCode());
        }
        __try {
            if (owner) ((void (__fastcall *)(void *, void *, int))(*(void ***)owner)[0])(owner, 0, 1);
        } __except (EXCEPTION_EXECUTE_HANDLER) {
        }
    }
}

static void coop_load_career(void)
{
    char path[MAX_PATH];
    HANDLE f;
    DWORD size, got = 0;
    BYTE *buf = NULL, *bos;
    if (g_career_loaded) return;
    g_career_loaded = 1;
    if (!career_find_save(path, sizeof(path))) {
        plog("[career] no single-player career save found (coop_career=%s)", g_career_save);
        return;
    }
    f = CreateFileA(path, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);
    if (f == INVALID_HANDLE_VALUE) return;
    size = GetFileSize(f, NULL);
    if (size > 8 && size < 64 * 1024 * 1024) buf = (BYTE *)HeapAlloc(GetProcessHeap(), 0, size + 16);
    if (buf) ReadFile(f, buf, size, &got, NULL);
    CloseHandle(f);
    if (!buf || got != size || memcmp(buf, "RIFF", 4) != 0) {
        plog("[career] %s: not a save file", path);
        if (buf) HeapFree(GetProcessHeap(), 0, buf);
        return;
    }
    plog("[career] loading the single-player career from %s", path);
    __try {
        /* BosGame init (0x101112E8) loads the solo databases only when engine vfunc 0x3D8 says
         * there is a renderer; the dedicated-server test gets them here the same way */
        BYTE *iface = *(BYTE **)VA(VA_ENGINE_IFACE);
        if (iface && ((BYTE (__fastcall *)(BYTE *, void *))(*(void ***)iface)[0x3D8 / 4])(iface, 0)) {
            typedef void (__fastcall *fn_db_load)(void *self, void *edx, const char *file);
            ((fn_db_load)VA(0x1018E8B0))(((void *(__cdecl *)(void))VA(0x1010F660))(), 0, (const char *)VA(0x1020AF70));
            ((fn_db_load)VA(0x10192240))(((void *(__cdecl *)(void))VA(0x1010F6D0))(), 0, (const char *)VA(0x1020AF58));
            ((fn_db_load)VA(0x10190780))(((void *(__cdecl *)(void))VA(0x1010F740))(), 0, (const char *)VA(0x1020AF14));
            plog("[career] no renderer: solo Champions / Mercs / Missions databases loaded for the test");
        }

        bos = ((BYTE *(__cdecl *)(void))VA(0x100595C0))();
        plog("[career] before: BOS manager %p, league data %p", bos, bos ? *(void **)(bos + 8) : NULL);
        career_load_modd(buf, size);
        bos = ((BYTE *(__cdecl *)(void))VA(0x100595C0))();
        plog("[career] after: BOS manager %p, league data %p", bos, bos ? *(void **)(bos + 8) : NULL);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[career] loading failed (exception %08X)", GetExceptionCode());
    }
    HeapFree(GetProcessHeap(), 0, buf);
}

/* MSVC 7.1 std::string: buffer at +4 (inline while capacity +0x18 < 16), length at +0x14 */
static const char *std_str(BYTE *s)
{
    return *(DWORD *)(s + 0x18) >= 16 ? *(const char **)(s + 4) : (const char *)(s + 4);
}

/*
 * The current mission. Solo: the world map's Launch opens the LOADING_SCREEN (0x101592E0) with
 * the mission (Missions DB 0x1010F740: +0x14/+0x18 vector of missions; a mission's +0xCC/+0xD0
 * vector of loads, each starting with its level name as a std::string, +0x20 its champion
 * groups). Its close calls BOS manager 0x101854D0(mission): +8 = mission, +4 = load 0, hired
 * mercs (+0x40) cleared, 0x10185290, then the engine loads the first level. After the level
 * is up, solo BeginPlayLevel calls 0x101841D0(flags): champions for the current load
 * (0x101839E0) and, unless flags & 2, spawns them (0x10183390: "AutoGeneratedBet" entities) -
 * the BOS fights that open parts of the level.
 * Co-op does the same minus the level load: the solo level comes from the co-op level's
 * Level.def ("<solo level>\<file>.Kt3"), mission and load index from the Missions DB.
 */
static int coop_solo_level(char *out, int n)
{
    BYTE *iface = *(BYTE **)VA(VA_ENGINE_IFACE);
    const char *lvl;
    char path[MAX_PATH], text[4096], *p, *e;
    HANDLE f;
    DWORD got = 0;
    if (!iface) return 0;
    lvl = ((const char *(__fastcall *)(BYTE *, void *))(*(void ***)iface)[0x74 / 4])(iface, 0);
    if (!lvl || !lvl[0]) return 0;
    _snprintf(path, sizeof(path), "%sMods\\bos\\levels\\Multi\\BOS\\%s\\Level.def", g_game_dir, lvl);
    path[sizeof(path) - 1] = 0;
    f = CreateFileA(path, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);
    if (f == INVALID_HANDLE_VALUE) return 0;
    ReadFile(f, text, sizeof(text) - 1, &got, NULL);
    CloseHandle(f);
    text[got] = 0;
    p = strstr(text, "DEF_GetSubLevelFiles");
    p = p ? strstr(p, "return \"") : NULL;
    if (!p) return 0;
    p += 8;
    e = strchr(p, '\\');
    if (!e || e - p >= n) return 0;
    memcpy(out, p, e - p);
    out[e - p] = 0;
    return 1;
}

static void coop_start_mission(void)
{
    char solo[64];
    BYTE *db, *bos, **m, **mend, **ld, **lend;
    int found = 0, idx = 0;
    if (!coop_solo_level(solo, sizeof(solo))) {
        plog("[career] this level has no solo level in its Level.def - no BOS mission");
        return;
    }
    __try {
        db = ((BYTE *(__cdecl *)(void))VA(0x1010F740))();
        for (m = *(BYTE ***)(db + 0x14), mend = *(BYTE ***)(db + 0x18); m && m < mend && !found; m++) {
            ld = *(BYTE ***)(*m + 0xCC);
            lend = *(BYTE ***)(*m + 0xD0);
            for (idx = 0; ld && ld + idx < lend; idx++)
                if (_stricmp(std_str(ld[idx]), solo) == 0) { found = 1; break; }
        }
        if (!found) {
            plog("[career] solo level %s is in no mission of Tuning\\Solo\\Missions.cfg", solo);
            return;
        }
        m--;
        bos = ((BYTE *(__cdecl *)(void))VA(0x100595C0))();
        /* 0x101854D0 without the level load */
        *(BYTE **)(bos + 8) = *m;
        *(int *)(bos + 4) = idx;
        if (*(void **)(bos + 0x40)) ((void (__cdecl *)(void *))VA(0x101E2BB2))(*(void **)(bos + 0x40));
        *(void **)(bos + 0x40) = *(void **)(bos + 0x44) = *(void **)(bos + 0x48) = NULL;
        ((void (__fastcall *)(BYTE *, void *))VA(0x10185290))(bos, 0);
        plog("[career] mission %p, load %d (%s) is the current BOS mission", *m, idx, solo);
        /* 0x101841D0(0), split so the HUD part cannot stop the champions */
        ((void (__fastcall *)(BYTE *, void *))VA(0x101839E0))(bos, 0);
        ((void (__fastcall *)(BYTE *, void *))VA(0x10183390))(bos, 0);
        plog("[career] BOS champions for this load: %d, bets spawned: %d",
             *(void **)(bos + 0x20) ? (int)((*(BYTE **)(bos + 0x24) - *(BYTE **)(bos + 0x20)) / 4) : 0,
             for_each_entity(*(BYTE **)VA(VA_ENGINE_IFACE), 0x2A, 1, NULL, NULL));
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[career] starting the BOS mission failed (exception %08X)", GetExceptionCode());
        return;
    }
    __try {
        ((void (__fastcall *)(void *, void *))VA(0x1012CDA0))(((void *(__cdecl *)(void))VA(0x100040F0))(), 0);
        ((void (__fastcall *)(void *, void *, DWORD))VA(0x1012BC90))(((void *(__cdecl *)(void))VA(0x100040F0))(), 0, 1);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[career] BOS HUD update failed (exception %08X; expected on the dedicated server)", GetExceptionCode());
    }
}

/* camera on the body the host's PLAYER controls (0x10059CC0), first person */
static BYTE *g_retired_body;
static int g_keep_mp_model = 1;         /* coop_config.ini [proxy] coop_keep_mp_model */

static void coop_camera_on_host(void)
{
    BYTE *game = bos_game(), *cam, *target;
    __try {
        if (!game || !*(BYTE **)game) return;
        cam = *(BYTE **)(game + 0x14);
        target = ((BYTE *(__fastcall *)(BYTE *, void *))VA(0x10059CC0))(*(BYTE **)game, 0);
        if (!cam || !target) return;
        *(BYTE **)(cam + 0x98) = target;
        *(int *)(cam + 0x90) = 4;
        plog("[career] camera on the host's body %p (%s), first person", target, entity_name(target));
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[career] camera fix failed (exception %08X)", GetExceptionCode());
    }
}

/* the ARSENAL entity of a character (Arsenal var +0x2F4, as 0x1001E380), or NULL */
static BYTE *char_arsenal(BYTE *ch)
{
    __try {
        return ch ? ((BYTE *(__fastcall *)(BYTE *, void *))VA(0x1001E380))(ch, 0) : NULL;
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        return NULL;
    }
}

/*
 * Solo BeginPlayLevel restores the player from the career every level (career object 0x10093BF0
 * -> 0x10117500: PLAYER vars incl. Money from PLVR, the character from CHVR, its arsenal from
 * ARVR via 0x10118660, which creates character / ARSENAL entities when missing; position and
 * facing are kept). It returns at once when engine vfunc 0x4DC is true (KT game object +0x86,
 * multiplayer). For the co-op host that flag is cleared around the call.
 */
static int g_player_restored;

/* The career restore renames the host's MP character to "Player" (CHVR) but leaves the level's
   own "Player" NPC body standing at the spawn, right in front of the host's camera: every other
   character named "Player" is frozen (its PLAYER gets no AI moves) and sunk under the map. */
static BYTE *g_scene_players[4];
static int g_scene_player_n;
static void collect_other_players(BYTE *e, void *local)
{
    if (e != (BYTE *)local && g_scene_player_n < 4 && strcmp(entity_name(e), "Player") == 0)
        g_scene_players[g_scene_player_n++] = e;
}

static void coop_retire_scene_player(void)
{
    BYTE *iface = *(BYTE **)VA(VA_ENGINE_IFACE), *local = (BYTE *)local_character();
    int i;
    if (!iface || !local) return;
    g_scene_player_n = 0;
    for_each_entity(iface, 5, 1, collect_other_players, local);
    for (i = 0; i < g_scene_player_n; i++) {
        BYTE *e = g_scene_players[i];
        __try {
            float x = *(float *)(e + 0x174), y = *(float *)(e + 0x178), z = *(float *)(e + 0x17C);
            *(float *)(e + 0x17C) = z - 2000.f;
            g_retired_body = e;
            plog("[career] level's own Player body %p at (%.1f, %.1f, %.1f) moved under the map (host is %p)", e, x, y, z, local);
        } __except (EXCEPTION_EXECUTE_HANDLER) {
            plog("[career] moving the level's Player body %p failed", e);
        }
    }
    if (!g_scene_player_n) plog("[career] no second Player body in the level");
}

static void coop_restore_player(void)
{
    BYTE *eng, *ch = (BYTE *)local_character(), *old_ch = ch;
    BYTE was;
    if (!ch) return;
    plog("[career] host character %s: arsenal %p before the career restore", entity_name(ch), char_arsenal(ch));
    if (g_keep_mp_model && !strchr(entity_name(ch), ']')) {
        /* CHVR swaps Body/Head/EyeModel for the solo ones and those are drawn in first person
           (camera inside the head): remember the MP models and put them back afterwards */
        char code[400];
        _snprintf(code, sizeof(code),
                  "_coopHost=GetCharacterID([[%s]]) if _coopHost then _coopBM=GetVarValue(_coopHost,\"BodyModel\") "
                  "_coopHM=GetVarValue(_coopHost,\"HeadModel\") _coopEM=GetVarValue(_coopHost,\"EyeModel\") end",
                  entity_name(ch));
        code[sizeof(code) - 1] = 0;
        lua_run("coop_keep_model", code, 0);
    }
    __try {
        eng = ((BYTE *(__cdecl *)(void))KVA(0x100019C0))();
        was = eng[0x86];
        eng[0x86] = 0;
        __try {
            ((void (__fastcall *)(void *, void *))VA(0x10117500))(((void *(__cdecl *)(void))VA(0x10093BF0))(), 0);
        } __finally {
            eng[0x86] = was;
        }
        ch = (BYTE *)local_character();
        g_player_restored = char_arsenal(ch) != NULL;
        plog("[career] player restored from the career (engine flag +0x86 was %d): character %s at (%.1f, %.1f, %.1f), arsenal %p",
             was, ch ? entity_name(ch) : "-", ch ? *(float *)(ch + 0x174) : 0.f, ch ? *(float *)(ch + 0x178) : 0.f,
             ch ? *(float *)(ch + 0x17C) : 0.f, char_arsenal(ch));
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[career] restoring the player from the career failed (exception %08X)", GetExceptionCode());
        return;
    }
    __try {
        /* solo BeginPlayLevel 0x10113943: BosGame+0xC (type 0x3F entity); Launch reads it */
        BYTE *game = bos_game();
        if (game && !*(void **)(game + 0xC)) {
            ((void (__fastcall *)(BYTE *, void *))VA(0x10113090))(game, 0);
            plog("[career] BosGame+0xC set up as in solo: %p", *(void **)(game + 0xC));
        }
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[career] BosGame+0xC setup failed (exception %08X)", GetExceptionCode());
    }
    if (old_ch && old_ch != (BYTE *)local_character()) {
        /* the restore moved the host's PLAYER onto the campaign Player body: put the MP body away */
        char code[200];
        const char *n = entity_name(old_ch);
        g_retired_body = old_ch;
        if (!strchr(n, ']')) {
            _snprintf(code, sizeof(code), "SetVarValue(GetCharacterID([[%s]]),\"Freeze\",true)", n);
            code[sizeof(code) - 1] = 0;
            lua_run("coop_retire_body", code, 0);
        }
        __try {
            *(float *)(old_ch + 0x17C) -= 2000.f;
        } __except (EXCEPTION_EXECUTE_HANDLER) {
        }
        plog("[career] old multiplayer body %s frozen and moved under the map", n);
    }
    coop_retire_scene_player();
    if (g_keep_mp_model) {
        lua_run("coop_keep_model2",
                "if _coopHost and _coopBM then SetVarValue(_coopHost,\"BodyModel\",_coopBM) "
                "SetVarValue(_coopHost,\"HeadModel\",_coopHM) SetVarValue(_coopHost,\"EyeModel\",_coopEM) end", 0);
        plog("[career] multiplayer Body/Head/EyeModel put back on the host (coop_keep_mp_model=1)");
    }
    coop_camera_on_host();
}

/* after the mission screens: equipment from the (edited) arsenal, as at a solo level start */
static void coop_equip_host(void)
{
    BYTE *ch = (BYTE *)local_character();
    if (!ch) return;
    g_force_solo_tid = GetCurrentThreadId();
    __try {
        ((fn_this)VA(0x10011C40))(ch);      /* CHARACTER slot 1: arsenal / armor (solo only) */
        ((fn_this)VA(0x10010440))(ch);      /* CHARACTER slot 2: weapon inventory (solo only) */
        plog("[shop] %s equipped from its arsenal (inventory %p)", entity_name(ch), *(void **)(ch + 0x44));
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[shop] equipping %s failed (exception %08X)", entity_name(ch), GetExceptionCode());
    }
    g_force_solo_tid = 0;
}

static void shop_watch(void)
{
    BYTE *game = bos_game();
    if (!g_begins_after_shop || !game || GetTickCount() < g_shop_deadline) return;
    g_begins_after_shop = 0;
    game[0x1A] = 1;
    plog("[shop] no Launch from the mission screens after 180 s - mission started anyway (prep mode %d)", game[0x19]);
}

/* Solo BeginPlayLevel (0x1011395B): a level started without a BOS mission (no world map) runs
   the BOS manager's debug start 0x101854A0: mercenaries from Debug_GetSelectedMercenaries(Name)
   (0x10184630), champions from Debug_GetSelectedChampions (0x10184FD0: champion character per
   arena -> manager +0x20, its BOS bet -> +0x30). GetChampionFromArea / LaunchBOS (the champion
   fight) and GetMercenary(Count) read exactly that, and MP never runs it. The level's Debug.lua
   picks: COOP_Patrol_2 -> Master Loa, mercs Char_Merc_0/1_Debug; COOP_Patrol -> Char_Merc_0/3. */
static int g_coop_bos_start = 1;         /* coop_config.ini [proxy] coop_bos_start */
static void coop_bos_debug_start(void)
{
    BYTE *bos;
    int n_ch = 0, n_bet = 0, n_merc = 0, i;
    __try {
        bos = ((BYTE *(__cdecl *)(void))VA(0x100595C0))();
        if (!bos) return;
        if (*(void **)(bos + 8)) {
            plog("[bos] a BOS mission is set (%p) - debug start not needed", *(void **)(bos + 8));
            return;
        }
        ((fn_this)VA(0x101854A0))(bos);
        if (*(BYTE **)(bos + 0x20)) n_ch = (int)((*(BYTE **)(bos + 0x24) - *(BYTE **)(bos + 0x20)) / 4);
        if (*(BYTE **)(bos + 0x30)) n_bet = (int)((*(BYTE **)(bos + 0x34) - *(BYTE **)(bos + 0x30)) / 4);
        if (*(BYTE **)(bos + 0x40)) n_merc = (int)((*(BYTE **)(bos + 0x44) - *(BYTE **)(bos + 0x40)) / 12);
        plog("[bos] solo debug start (no BOS mission): %d champion arena(s), %d bet(s), %d mercenary(ies)", n_ch, n_bet, n_merc);
        for (i = 0; i < n_ch && i < 4; i++) {
            BYTE *c = (*(BYTE ***)(bos + 0x20))[i];
            plog("[bos]   arena %d: champion %s, bet %08X", i, c ? entity_name(c) : "(none)",
                 i < n_bet ? (*(DWORD **)(bos + 0x30))[i] : 0xFFFFFFFFu);
        }
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[bos] solo debug start failed (exception %08X)", GetExceptionCode());
    }
}

/* BOS cinematic manager (getter 0x10069510, class with ctor 0x1017DF70): the champion fight's
   intro (LaunchBOS -> phases BOS_CINEMATIC_PHASE_ZOOM_IN ...) films with its own camera rig at
   +0x48 CAM_TRANSITION (type 0x31) and +0x50 / +0x58 CAMPOINTs (type 0x30), ids at +0x44/4C/54.
   Solo BeginPlayLevel builds the rig in 0x1011399C -> 0x1017BF70(flags): only with game-type flag
   8 (new level -> 0x1017BE20 creates the three entities; loaded save -> 0x1017B870 looks them up).
   MP has no flag 8, so the pointers stay NULL (EndPlayLevel 0x10112756 -> 0x1017D850 clears them)
   and the first phase reads camera+0x60 at Bos+0x6FC0E: the host crashed when Master Loa's intro
   started (0.33 session 2026-11-11). The host now builds the rig itself, as solo does. */
static int g_coop_bos_camera = 1;        /* coop_config.ini [proxy] coop_bos_camera */
static void coop_bos_camera_rig(void)
{
    BYTE *bocm;
    __try {
        bocm = ((BYTE *(__cdecl *)(void))VA(0x10069510))();
        if (!bocm) { plog("[bos] no BOS cinematic manager"); return; }
        if (*(void **)(bocm + 0x48) && *(void **)(bocm + 0x50) && *(void **)(bocm + 0x58)) {
            plog("[bos] champion intro camera rig already there");
            return;
        }
        if (strcmp(nw_state_name(), "MASTER") != 0) {
            plog("[bos] champion intro camera rig missing here (the host films the intro)");
            return;
        }
        ((fn_this)VA(0x1017BE20))(bocm);
        plog("[bos] champion intro camera rig created: transition %p, camera points %p %p",
             *(void **)(bocm + 0x48), *(void **)(bocm + 0x50), *(void **)(bocm + 0x58));
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[bos] champion intro camera rig failed (exception %08X)", GetExceptionCode());
    }
}

/* MP manager ([0x1025DD30], getter 0x100594E0) +4 = the level's BOS_ARENA (type 0x35), found by
   0x1019CAE0 (thiscall, no args) when BeginPlayLevel builds the manager (0x1019CEC0). The fight
   start (0x1006A050, run from the NPC PLAYER update when the countdown ends) reads arena+0x48
   without a NULL test: in the 0.34 session it was NULL on the host and the game crashed at
   Bos+0x6A16F. Checked every sim step on every PC; it only sets that pointer. */
static void bos_arena_watch(void)
{
    static int logged;
    BYTE *mpm;
    __try {
        mpm = *(BYTE **)VA(VA_MPMANAGER_PTR);
        if (!mpm) return;
        if (*(void **)(mpm + 4)) { logged = 0; return; }
        ((fn_this)VA(0x1019CAE0))(mpm);
        if (*(void **)(mpm + 4) || !logged)
            plog("[bos] MP manager had no BOS arena: %s", *(void **)(mpm + 4) ? "linked to the level's BOS_ARENA" : "the level has none (yet)");
        logged = 1;
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[bos] arena link failed (exception %08X)", GetExceptionCode());
        logged = 1;
    }
}

static void frz_map_clear(const char *why);
/*
 * 0.49: physics props removed in co-op. The 144 SINGLE_RIGID_BODY props (crates, barrels) are
 * simulated by PhysX, which does not give the same result on two PCs; once touched they end up in
 * different places, and characters standing on them (host 1.1 m higher on the host than on the
 * client, 0.48 trace frames 768-771), bullets hitting them, grenades bouncing off them and their
 * destruction all diverge -> resyncs. Stock MP maps have none (0 resyncs after join).
 * 0x1005EDF0 (thiscall) is the prop's own physics/model release: body id +0x70 destroyed through
 * the physics layer (slot 0x3C) and set to -1, body data +0x74 freed, models +0x4C/+0x48 released.
 * Both PCs strip every prop at mission start, the client again after each resync (the resync
 * re-creates them from the host's world), and a pass each step catches new ones. The loader that
 * creates model + body (slot 1 "vars changed", 0x10060EC0) is skipped while coop_remove_props is
 * on (hook_rb_vars), so they never come back; Update (slot 4) already runs without them (dedicated
 * server, rigid_body_tick_guard). The entities stay (scripts). 0.49 first build skipped slots 6/7
 * instead - slot 6 (0x1005ECE0) is the initialisation: crashed the dedicated server at start.
 */
static volatile LONG g_rb_stripped;
static void rb_strip_one(BYTE *e, void *ctx)
{
    (void)ctx;
    __try {
        if (*(void **)e != (void *)VA(0x101FE91C)) return;          /* SINGLE_RIGID_BODY only */
        if (*(int *)(e + 0x70) == -1 && !*(void **)(e + 0x4C)) return;
        ((fn_this)VA(0x1005EDF0))(e);
        InterlockedIncrement(&g_rb_stripped);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
    }
}
/*
 * 0.52: removed props must also be invisible to the game's own entity loops. Shots and explosions
 * walk every SINGLE_RIGID_BODY near the impact (0x10012760 from the character's fire code,
 * 0x1009DCB0 explosions, 0x1005A16D, ...) through the engine iterator (iface vfunc 0x4B8 = next)
 * and read the prop's collision-centre node [+0x54] unguarded: the host crashes at Bos+0x1281F
 * and Bos+0x9DD43 "while shooting". The engine interface's next-entity function is wrapped: for a
 * caller inside Bos_core it steps over props that were never loaded (+0xD0 NULL). KT_Game's own
 * callers (world serialisation, resync) and this proxy still see every entity.
 */
static fn_iter o_iter_next;
static volatile LONG g_iter_hidden;
static DWORD __fastcall hook_iter_next(BYTE *self, void *edx, DWORD it, DWORD world)
{
    DWORD ra = (DWORD)_ReturnAddress();
    DWORD e = o_iter_next(self, edx, it, world);
    if (!g_coop_remove_props || ra < (DWORD)g_core_base || ra >= (DWORD)g_core_base + (DWORD)g_core_size) return e;
    while (e) {
        BYTE *p = (BYTE *)e;
        int removed = 0;
        __try { removed = *(void **)p == (void *)VA(0x101FE91C) && *(void **)(p + 0xD0) == NULL; }
        __except (EXCEPTION_EXECUTE_HANDLER) {}
        if (!removed) break;
        if (InterlockedIncrement(&g_iter_hidden) == 1)
            plog("[props] removed props hidden from the game's entity loops (shots/explosions) - first from Bos+0x%X",
                 ra - (DWORD)g_core_base);
        e = o_iter_next(self, edx, it, world);
    }
    return e;
}
static void install_iter_filter(BYTE *iface)
{
    void **slot = &(*(void ***)iface)[0x4B8 / 4];
    DWORD old;
    if (o_iter_next || !iface) return;
    if (!VirtualProtect(slot, sizeof(void *), PAGE_EXECUTE_READWRITE, &old)) {
        plog("[props] entity iterator filter: VirtualProtect failed (%lu)", GetLastError());
        return;
    }
    o_iter_next = (fn_iter)*slot;
    *slot = (void *)hook_iter_next;
    VirtualProtect(slot, sizeof(void *), old, &old);
    plog("[hook] engine iterator next (iface vtable %p slot 0x4B8, was %p) -> removed props hidden from Bos_core loops",
         *(void **)iface, (void *)o_iter_next);
}

static void rb_strip_all(const char *why)
{
    BYTE *iface = *(BYTE **)VA(VA_ENGINE_IFACE);
    LONG before = g_rb_stripped;
    if (!g_coop_remove_props || !iface) return;
    if (!o_iter_next) install_iter_filter(iface);
    __try { for_each_entity(iface, 0, 1, rb_strip_one, NULL); } __except (EXCEPTION_EXECUTE_HANDLER) {}
    if (why && g_rb_stripped != before) plog("[props] %ld physics prop(s) removed (%s)", g_rb_stripped - before, why);
}
static void mission_bootstrap(void)
{
    BYTE *iface = *(BYTE **)VA(VA_ENGINE_IFACE), *game = bos_game();
    void **vt;
    BYTE exists, r = 0;
    if (!iface || !game) return;
    vt = *(void ***)iface;
    if (strcmp(nw_state_name(), "MASTER") == 0 && g_career_save[0] != '-') {
        /* before InitLevel: the scripts' _idPlayer (GetLocalCharacterID) is the restored body */
        coop_load_career();
        coop_start_mission();
        coop_restore_player();
    }
    if (strcmp(nw_state_name(), "MASTER") == 0 && g_coop_bos_start && g_career_save[0] == '-')
        coop_bos_debug_start();          /* before InitLevel: Patrol_2 reads GetChampionFromArea there */
    if (g_coop_bos_camera) coop_bos_camera_rig();
    frz_map_clear("mission start");
    rb_strip_all("mission start");
    /* 0.54: the dedicated server has no HUD; these script calls write into it unguarded (Bos+0x133490
       MiniMapTrack, Bos+0x13AC8D ShowNewObjective) and ended most dedicated load tests at InitLevel. */
    if (GetModuleHandleA("Dedicated_Server.exe"))
        lua_run("dedicated: no HUD",
                "function MiniMapTrack() end function MiniMapPing() end function ShowNewObjective() end function ShowNewSubObjective() end function ShowObjectiveDone() end", 0);
    if (g_test_lua[0]) run_lua_file("test_lua", g_test_lua);
    g_coop_lua_loaded = g_coop_lua[0] && run_lua_file("coop_lua", g_coop_lua) == 0;
    g_coop_tick_at = GetTickCount() + 1000;
    __try {
        exists = ((fn_script_exists)vt[0x4E0 / 4])(iface, 0, "InitLevel");
        if (exists)
            r = ((fn_script_call)vt[0x4E4 / 4])(iface, 0, "InitLevel", 0, 0);
        plog("[mission] InitLevel %s%s", exists ? "called" : "not defined by this level",
             exists ? (r ? " -> ok" : " -> returned false (see [lua error] lines)") : "");
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[mission] InitLevel failed (exception %08X)", GetExceptionCode());
    }
    if (g_ai_init) coop_ai_init();
    __try {
        if (((fn_script_exists)vt[0x4E0 / 4])(iface, 0, "OnMissionBegins")) {
            /* solo pauses during the mission screens; here the mission waits for their Launch */
            if (coop_open_shop()) {
                g_begins_after_shop = 1;
                g_shop_deadline = GetTickCount() + 180000;
                plog("[mission] OnMissionBegins waits for the mission screens' Launch");
            } else {
                game[0x1A] = 1;    /* the mod calls OnMissionBegins in this frame's UpdateSimulation */
                plog("[mission] OnMissionBegins requested (BosGame+0x1A)");
            }
        }
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[mission] bootstrap failed (exception %08X)", GetExceptionCode());
    }
}

/* ------------------------------------------------------------------------ */
/* camera manager: cut-scenes in multiplayer                                */
/* ------------------------------------------------------------------------ */
/*
 * BosGame+0x14 is the camera manager (update 0x1009C3C0, called by
 * BosGame::UpdateSimulation):
 *   +0x40  camera position (row 3 of the matrix at +0x10)
 *   +0x90  mode: 4 first person on the target (the HUD shows only in this
 *          mode, 0x1011050B), 6 camera transition (cut-scene), 7 MP spawn
 *          camera (MULTI_IDLE_CAMPOINT at +0xD4), 3 none (MP default while
 *          there is no target); 0/1/2/5 solo and debug cameras
 *   +0x98  target (the player's controlled entity, 0x10059CC0). While it is
 *          NULL the update forces the mode to 0 (solo) / 3 (MP) every frame.
 *   +0xD0  active CAM_TRANSITION, +0xD4 spawn camera point
 * LaunchCameraTransition (0x1006EBC0 -> 0x1006EA70) saves the current mode in
 * the transition's PreviousCamMode var and switches to mode 6; when it ends
 * (0x1006EF02) the mode is set back to PreviousCamMode.
 *
 * Multiplayer differs in two ways:
 *  - mode 6 is drawn only if IsSolo (0x1009C44C), so a cut-scene never moved
 *    the camera. cutscene_camera_mp turns that check off (je -> nops).
 *  - the host connects in mode 7 (spawn camera, 0x1019D1A5) and gets mode 4
 *    only when it spawns. A cut-scene started before that put the camera back
 *    on the spawn camera when it ended (2026-10-20 test). The mission now
 *    starts once the host is in first person, and a transition that still
 *    ends on the spawn camera (or no camera) is sent back to first person.
 */
static int patch_code(const char *name, DWORD check_va, const BYTE *expect, int n,
                      DWORD patch_va, const BYTE *repl, int m)
{
    BYTE *p = VA(check_va);
    char found[64];
    if (memcmp(p, expect, n) != 0) {
        hexbytes(p, n, found);
        plog("[hook] %-26s at %08X: unexpected bytes %s - NOT patched", name, check_va, found);
        return 0;
    }
    if (!write_code(VA(patch_va), repl, m)) {
        plog("[hook] %-26s at %08X: VirtualProtect failed (%lu)", name, patch_va, GetLastError());
        return 0;
    }
    plog("[hook] %-26s at %08X -> ok", name, patch_va);
    return 1;
}

static int g_coop_bos_countdown = 1;   /* coop_config.ini [proxy] coop_bos_countdown */
static void install_camera_patches(void)
{
    /* call [edx+1C0h] (IsSolo); test al,al; je 0x1009C488; mov eax,[esi+0D0h] */
    static const BYTE expect[] = { 0xFF, 0x92, 0xC0, 0x01, 0x00, 0x00, 0x84, 0xC0, 0x74, 0x24, 0x8B, 0x86, 0xD0, 0x00, 0x00, 0x00 };
    static const BYTE nops[] = { 0x90, 0x90 };
    patch_code("cutscene_camera_mp", 0x1009C45A, expect, sizeof(expect), 0x1009C462, nops, sizeof(nops));
    /* 0.35: the champion fight's countdown state (0x1006BA70, run from the PLAYER update when
       the warm-up ends). Solo: IsSolo -> BOS cinematic manager 0x1017DB30 (-> CombatBOS). MP: the
       MP BOS game mode's round start 0x1006B440 -> 0x1006A050, which reads the MP manager's
       BOS_ARENA (+4); campaign maps have none (solo builds none either), so the host crashed at
       Bos+0x6A16F when Master Loa's countdown ended (0.34 session). The solo branch is taken. */
    if (g_coop_bos_countdown) {
        static const BYTE expect2[] = { 0xFF, 0x92, 0xC0, 0x01, 0x00, 0x00, 0x84, 0xC0, 0x74, 0x1A, 0x8B, 0x46, 0x70 };
        patch_code("bos_countdown_solo", 0x1006BACC, expect2, sizeof(expect2), 0x1006BAD4, nops, sizeof(nops));
        /* 0.36: when the timer runs out (0x1006BB3B) the same function asks IsSolo again and passes it
           to 0x1006B440 as its flag; false -> 0x1006A050 (the arena crash, still in the 0.35 session).
           call [edx+1C0h] -> mov al,1 (true: 0x1006B79A, the solo start: script callback, BOCM 0x1017BDE0). */
        {
            static const BYTE expect3[] = { 0x8B, 0x10, 0x8B, 0xC8, 0xFF, 0x92, 0xC0, 0x01, 0x00, 0x00, 0x8B, 0xCE, 0x50 };
            static const BYTE solo1[] = { 0xB0, 0x01, 0x90, 0x90, 0x90, 0x90 };
            patch_code("bos_countdown_end_solo", 0x1006BB51, expect3, sizeof(expect3), 0x1006BB55, solo1, sizeof(solo1));
        }
        /* 0.42: the rest of the champion fight runs the solo way too. The user's 0.41 run: Loa died
           ("Bots actifs" 3 -> 2) but BOS_End never ran, the arena doors stayed locked and the next
           task never started. Every IsSolo (engine vfunc 0x1C0) in the PLAYER's BOS fight state code
           picks between the solo cinematic flow and the MP BOS game mode: death event 0x1006BC20 ->
           0x1006BB70 (0x1006BBAB) / 0x1006B0A0 (0x1006B0B4, flag 0x1006B150 -> 0x1006AA60: solo =
           BOCM sequence 0x1017D520, MP = MP manager 0x1019D870), fight timer 0x1006B270 (0x1006B2AA,
           flag 0x1006B2E4 -> time-out 0x1006ACC0: MP = 0x1019DA10), 0x1006B300 (flag 0x1006B325 ->
           0x1006A7A0: solo = BOCM 0x1017B850), timers 0x1006A4FB/0x1006A523, 0x1006AD6C/AE52/AFC6;
           and the BOS cinematic manager's delayed script callback (0x1017CF29) and 0x1017D271.
           call [edx+1C0h] -> mov al,1 at each (all consumers read only al / a byte). */
        {
            /* 0.43: only the death -> win path. 0.42 forced all 13 and crashed in the intro: 0x1006B300 runs
               every frame from the BOCM update (0x1017D429), and its solo branch (0x1006A7A0) reads
               [0x10004010()+0xC]+0x9C - solo-only data, NULL in MP (Bos+0x6A81C). The other unchecked
               +0xC readers are the time-out handler (0x1006ADBE) and 0x1006B913..B98F, so the time-out
               and per-frame checks keep their MP answer (as in 0.41, where intro and fight worked). */
            static const DWORD site[] = { 0x1006BBAB, 0x1006AFC6, 0x1006B0B4, 0x1006B150, 0x1017CF29 };
            static const BYTE call1c0[] = { 0xFF, 0x92, 0xC0, 0x01, 0x00, 0x00 };
            static const BYTE solo1b[] = { 0xB0, 0x01, 0x90, 0x90, 0x90, 0x90 };
            char nm[40];
            int k, ok = 0;
            for (k = 0; k < (int)(sizeof(site) / sizeof(site[0])); k++) {
                _snprintf(nm, sizeof(nm), "bos_fight_solo@%08lX", site[k]);
                nm[sizeof(nm) - 1] = 0;
                ok += patch_code(nm, site[k], call1c0, sizeof(call1c0), site[k], solo1b, sizeof(solo1b));
            }
            plog("[bos] champion fight: %d of %d IsSolo checks now answer solo", ok, (int)(sizeof(site) / sizeof(site[0])));
        }
    }
}

/* PLAYER "State" var (+0x44, bound at 0x100597C7): bit 0 = controls its character, bit 1 = its exoskeleton */
static int player_state(BYTE *player)
{
    DWORD v[4] = { 0 };
    BYTE *var;
    if (!player) return -1;
    __try {
        var = *(BYTE **)(player + 0x44);
        if (!var) return -1;
        ((fn_var_get)(*(void ***)var)[0x1C / 4])(var, 0, v, 0);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        return -2;
    }
    return (int)v[0];
}

static const char *cam_mode_name(int m)
{
    switch (m) {
    case 3: return "none";
    case 4: return "first person";
    case 6: return "cut-scene";
    case 7: return "spawn camera";
    default: return "other";
    }
}

static int g_cam_mode = -1, g_cam_state = -99;
static void *g_cam_target, *g_cam_trans, *g_cam_idle;
static LONG g_cam_logs;

/*
 * 0.53: the client stayed in the Loa cut-scene for good (camera mode 6, no control). The camera
 * manager points at the CAM_TRANSITION entity (+0xD0) and only that entity's update ends the
 * cut-scene (0x1006EF02 -> PreviousCamMode). A resync during the ~25 s cut-scene rebuilds the
 * client's world from the host's: the transition is re-created at a new address and the camera is
 * left on the freed one, which never ends. Each frame in mode 6 the transition is looked up among
 * the live CAM_TRANSITIONs (type 0x31); if it is gone the camera is moved to the re-created one of
 * the same name (it carries the host's progress, so the cut-scene ends with the host's), else back
 * to first person. Also: mode 6 with no transition, or a cut-scene longer than 90 s -> first person.
 */
struct cam_find { void *want; const char *name; BYTE *same; BYTE *by_name; };
static void cam_find_cb(BYTE *e, void *ctx)
{
    struct cam_find *f = (struct cam_find *)ctx;
    const char *nm;
    if (e == f->want) f->same = e;
    if (f->name && f->name[0] && !f->by_name) {
        __try { nm = entity_name(e); if (nm && !strcmp(nm, f->name)) f->by_name = e; }
        __except (EXCEPTION_EXECUTE_HANDLER) {}
    }
}
static char g_cam_trans_name[64];
static DWORD g_cam6_since;
static void camera_cutscene_guard(BYTE *cam, int *mode, void **trans)
{
    BYTE *iface = *(BYTE **)VA(VA_ENGINE_IFACE);
    struct cam_find f;
    if (*mode != 6) { g_cam6_since = 0; return; }
    if (!g_cam6_since) g_cam6_since = GetTickCount();
    if (!*trans || GetTickCount() - g_cam6_since > 90000) {
        plog("[camera] cut-scene %s - back to first person", *trans ? "longer than 90 s" : "without a transition");
        *(void **)(cam + 0xD0) = NULL; *(int *)(cam + 0x90) = 4;
        *trans = NULL; *mode = 4; g_cam6_since = 0;
        return;
    }
    if (!iface) return;
    memset(&f, 0, sizeof(f));
    f.want = *trans; f.name = g_cam_trans_name;
    __try {
        for_each_entity(iface, 0x31, 1, cam_find_cb, &f);
        if (!f.same) for_each_entity(iface, 0x31, 0, cam_find_cb, &f);
    } __except (EXCEPTION_EXECUTE_HANDLER) { return; }
    if (f.same) return;
    if (f.by_name) {
        plog("[camera] cut-scene transition %s was re-created (resync): camera moved to the new one %p", g_cam_trans_name, f.by_name);
        *(void **)(cam + 0xD0) = f.by_name; *trans = f.by_name;
    } else {
        plog("[camera] cut-scene transition %p (%s) no longer exists - back to first person", *trans, g_cam_trans_name);
        *(void **)(cam + 0xD0) = NULL; *(int *)(cam + 0x90) = 4;
        *trans = NULL; *mode = 4; g_cam6_since = 0;
    }
}

/*
 * 0.53: the client's mouse sensitivity changed when he joined. The options menu's apply
 * (0x101A71A0) turns the MouseSensitivity slider (0..32000, Options.cfg) into the look scale
 * v / 32000 * 0.0145 + 0.0005 and sets it with 0x10128160 (thiscall on 0x10093B10(), float, ret 4;
 * clamps to 0.0005..0.015 and marks the input settings changed). Joining rebuilds the input from
 * other data, so when a PC enters first person the proxy applies its own Options.cfg value again.
 */
typedef void *(__cdecl *fn_get_ptr)(void);
typedef void (__fastcall *fn_set_float)(void *self, void *edx, float v);
static void apply_mouse_sensitivity(void)
{
    char path[MAX_PATH], line[256], *slash;
    FILE *f;
    double v = -1;
    void *in;
    GetModuleFileNameA(NULL, path, MAX_PATH);
    slash = strrchr(path, '\\');
    if (slash) slash[1] = 0; else path[0] = 0;
    strcat(path, "Mods\\Bos\\Settings\\Options.cfg");
    f = fopen(path, "r");
    if (!f) return;
    while (fgets(line, sizeof(line), f)) {
        char *p = strstr(line, "MouseSensitivity");
        if (p && (p = strchr(p, '=')) != NULL) { v = atof(p + 1); break; }
    }
    fclose(f);
    if (v < 0 || v > 32000) return;
    __try {
        float now, want = (float)(v / 32000.0 * 0.0145 + 0.0005);
        in = ((fn_get_ptr)VA(0x10093B10))();
        if (!in) return;
        now = *(float *)((BYTE *)in + 4);
        ((fn_set_float)VA(0x10128160))(in, 0, want);
        plog("[input] mouse sensitivity %.0f from Options.cfg applied: look scale %.5f (was %.5f)", v, want, now);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[input] applying the mouse sensitivity faulted");
    }
}

/*
 * 0.63: the client lost all control when the champion fight's countdown ended (2026-11-13, Patrol_2:
 * camera fixed, no move/fire, chat would not open) while its game kept running (render ~270 fps,
 * 16 simulation frames/s, resyncs applied). One engine state explains all three: KT's input mode.
 * The input manager (KT 0x10001B10()+0x28: vfunc 0x58 = mode, 0x24 = set) is in mode 1 while playing
 * and mode 0 while a GUI screen or the chat line has the keyboard: the GUI interface's ShowScreen
 * (0x430 -> 0x10066300, screen kept at GUI manager 0x10007B10()+0x3C) and the chat's open (Bos
 * 0x10158560 -> GUI 0x454(0) -> 0x100659C0) switch to 0; the chat's close (0x10157A50 -> GUI 0x458
 * -> 0x10065A10) back to 1. In mode 0 the game reads no controls, and Bos's HUD opens the chat only
 * from a control (0x10144222: chat not already open, not solo, not editing). So: mode 0 with no
 * screen and the chat closed is a dead end nothing leaves. Both PCs check it each simulation frame;
 * after 1 s it is switched back exactly the way the chat's close does. Changes of mode / screen /
 * chat are logged (with the screen's class), so a screen that grabs the keyboard shows up by name.
 * Ctrl+F4 (any PC): unstick by hand - game input mode and first-person camera.
 */
typedef BYTE *(__cdecl *fn_kt_obj)(void);
typedef int (__fastcall *fn_kt_int0)(void *self, void *edx);
typedef void (__fastcall *fn_kt_void)(void *self, void *edx);
static int g_input_fix = 1;               /* [proxy] input_fix */
static int g_in_mode = -1, g_in_chat = -1, g_in_logs;
static void *g_in_screen = (void *)-1;
static DWORD g_in_dead_since;

static const char *rtti_name(void *obj, char *out, int n)
{
    __try {
        BYTE *vt = *(BYTE **)obj, *col = *(BYTE **)(vt - 4), *td = *(BYTE **)(col + 12);
        const char *nm = (const char *)(td + 8);
        if (IsBadStringPtrA(nm, 80)) return "?";
        _snprintf(out, n, "%s", nm[0] == '.' && nm[1] == '?' && nm[2] == 'A' ? nm + 4 : nm);
        out[n - 1] = 0;
        return out;
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        return "?";
    }
}

static BYTE *input_mgr(void)
{
    BYTE *o = ((fn_kt_obj)KVA(0x10001B10))();
    return o ? *(BYTE **)(o + 0x28) : NULL;
}

/* back to the game's input, like the chat's close (GUI 0x458 -> 0x10065A10) */
static void input_to_game(const char *why)
{
    __try {
        BYTE *gui = ((fn_kt_obj)KVA(0x10007B10))();
        ((fn_kt_void)KVA(0x10065A10))(gui, 0);
        plog("[input] keyboard/mouse given back to the game (%s)", why);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[input] giving the input back faulted (%08X)", GetExceptionCode());
    }
}

static void controls_repair(BYTE *game, BYTE *cam, const char *why);
static void input_watch(BYTE *cam, int mode_cam)
{
    BYTE *im, *gui, *chat;
    int mode, chat_open;
    void *screen;
    static int key_down;
    int k;
    if (!g_input_fix || !g_kt_base) return;
    __try {
        if (!(im = input_mgr())) return;
        mode = ((fn_kt_int0)(*(void ***)im)[0x58 / 4])(im, 0);
        gui = ((fn_kt_obj)KVA(0x10007B10))();
        screen = gui ? *(void **)(gui + 0x3C) : NULL;
        chat = *(BYTE **)VA(0x10266FC0);
        chat_open = chat ? chat[0x20] : 0;
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        return;
    }
    if ((mode != g_in_mode || screen != g_in_screen || chat_open != g_in_chat) && g_in_logs++ < 200) {
        char nm[96];
        plog("[input] mode %d (%s), screen %p%s%s, chat %s, camera mode %d", mode, mode == 1 ? "game" : mode == 0 ? "GUI" : "?",
             screen, screen ? " " : "", screen ? rtti_name(screen, nm, sizeof(nm)) : "", chat_open ? "open" : "closed", mode_cam);
    }
    g_in_mode = mode; g_in_screen = screen; g_in_chat = chat_open;
    if (mode == 0 && !screen && !chat_open && local_character()) {
        if (!g_in_dead_since) g_in_dead_since = GetTickCount() | 1;
        else if (GetTickCount() - g_in_dead_since > 1000) {
            input_to_game("GUI input mode with no screen and no chat for 1 s");
            g_in_dead_since = 0;
        }
    } else {
        g_in_dead_since = 0;
    }
    /* Ctrl+F4: unstick by hand */
    {
        DWORD pid = 0;
        HWND fg = GetForegroundWindow();
        if (fg) GetWindowThreadProcessId(fg, &pid);
        k = pid == GetCurrentProcessId() && (GetAsyncKeyState(VK_CONTROL) & 0x8000) && (GetAsyncKeyState(VK_F4) & 0x8000);
        if (k && !key_down) {
            char nm[96];
            plog("[input] Ctrl+F4 unstick: input mode %d, screen %p %s, chat %s, camera mode %d", mode, screen,
                 screen ? rtti_name(screen, nm, sizeof(nm)) : "", chat_open ? "open" : "closed", mode_cam);
            input_to_game("Ctrl+F4");
            if (bos_game()) controls_repair(bos_game(), cam, "Ctrl+F4");
        }
        key_down = k;
    }
}

/*
 * 0.64: the client's camera froze for good the first time it entered a cut-scene (champion intro,
 * 2026-11-13 and 2026-11-15 sessions: camera position never changed again from the first mode 6
 * until a reconnect; the client's character got only the confirmed-frame updates, its predicted
 * ones stopped; input mode stayed "game" and the chat flag still opened). On the client a cut-scene
 * only starts when a resync re-imports an active CAM_TRANSITION, whose vars-changed handler
 * (0x1006ED10) hands it to the camera manager's SetTransition (0x1009B480: +0xD0 = transition,
 * +0x90 = 6). [proxy] client_cutscenes=0 (default): on a client SetTransition only accepts NULL,
 * so the camera never leaves the player (the handler's end path checks +0xD0 == itself, no-op).
 */
static int g_client_cutscenes = 0;        /* [proxy] client_cutscenes */
static volatile LONG g_cut_refused;
static void __fastcall hook_set_transition(BYTE *cam, void *edx, void *trans)
{
    BYTE *net = kt_net();
    if (trans && !g_client_cutscenes && net && net[0xDA4] == 0) {
        if (InterlockedIncrement(&g_cut_refused) <= 20) {
            const char *nm = "?";
            __try { nm = entity_name((BYTE *)trans); } __except (EXCEPTION_EXECUTE_HANDLER) {}
            plog("[camera] client: cut-scene %s runs without taking the view (client_cutscenes=0)", nm ? nm : "?");
        }
        /* 0.66: the transition stays the camera manager's (so it runs and ends exactly as on the
           host - 0.64/0.65 left it unattached, it never ended on the client: a resync every ~3.9 s),
           only the view is not switched to it */
        *(void **)(cam + 0xD0) = trans;
        if (*(int *)(cam + 0x90) == 6) *(int *)(cam + 0x90) = 4;
        return;
    }
    *(void **)(cam + 0xD0) = trans;
    if (trans) *(int *)(cam + 0x90) = 6;
}
static void install_set_transition_hook(void)
{
    static const BYTE expect[] = { 0x8B, 0x44, 0x24, 0x04, 0x85, 0xC0, 0x89, 0x81, 0xD0, 0x00, 0x00, 0x00 };
    BYTE jmp[5], *p = VA(0x1009B480);
    DWORD rel;
    if (memcmp(p, expect, sizeof(expect)) != 0) { plog("[hook] %-26s at 1009B480: bytes differ - skipped", "client_no_cutscenes"); return; }
    rel = (DWORD)((BYTE *)hook_set_transition - (p + 5));
    jmp[0] = 0xE9; memcpy(jmp + 1, &rel, 4);
    if (write_code(p, jmp, 5)) plog("[hook] %-26s at 1009B480 -> ok (client cut-scenes %s)", "client_no_cutscenes", g_client_cutscenes ? "shown" : "skipped");
}

/*
 * 0.64: what the client's controls depend on, watched every simulation frame on both PCs and
 * logged on change: Bos game +0x50 (Bos builds player commands only while set, 0x10129CC3),
 * KT pause flag (app 0x100019C0()+0x7B: interface 0x3BC; the camera update 0x1009C3C0 does nothing
 * while it is set; setter 0x3C0 also switches the input off), the camera target vs the local
 * character, and whether the camera still follows the character. Stuck for 2 s -> repaired; Ctrl+F4
 * repairs at once.
 */
typedef void (__fastcall *fn_kt_set_bool)(void *self, void *edx, BYTE v);
static int g_ctl_g50 = -1, g_ctl_pause = -1, g_ctl_tgt = -1, g_ctl_logs;
static float g_ctl_cam[3], g_ctl_chr[3];
static DWORD g_ctl_cam_still, g_ctl_bad_since;
static void controls_repair(BYTE *game, BYTE *cam, const char *why)
{
    BYTE *app, *iface = *(BYTE **)VA(VA_ENGINE_IFACE);
    void *ch = local_character();
    __try {
        if (!game[0x50]) game[0x50] = 1;
        app = ((fn_kt_obj)KVA(0x100019C0))();
        if (app && app[0x7B] && iface)
            ((fn_kt_set_bool)(*(void ***)iface)[0x3C0 / 4])(iface, 0, 0);
        if (cam && ch) {
            if (!*(void **)(cam + 0x98)) *(void **)(cam + 0x98) = ch;
            *(void **)(cam + 0xD0) = NULL;
            *(int *)(cam + 0x90) = 4;
        }
        { static int n; if (n++ < 50) plog("[controls] repaired (%s): commands on, pause off, camera on the player in first person", why); }
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[controls] repair faulted (%08X)", GetExceptionCode());
    }
}
static void controls_watch(BYTE *game, BYTE *cam, int mode)
{
    BYTE *app;
    int g50, pause, tgt, bad;
    void *ch = local_character();
    float cp[3], hp[3];
    DWORD now = GetTickCount();
    __try {
        app = ((fn_kt_obj)KVA(0x100019C0))();
        g50 = game[0x50];
        pause = app ? app[0x7B] : -1;
        tgt = !ch ? -1 : *(void **)(cam + 0x98) == ch ? 1 : 0;
        memcpy(cp, cam + 0x40, sizeof(cp));
        if (ch) entity_position((BYTE *)ch, hp); else memset(hp, 0, sizeof(hp));
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        return;
    }
    if ((g50 != g_ctl_g50 || pause != g_ctl_pause || tgt != g_ctl_tgt) && g_ctl_logs++ < 200)
        plog("[controls] commands %s, pause %d, camera target %s, camera mode %d", g50 ? "on" : "OFF", pause,
             tgt == 1 ? "= local character" : tgt == 0 ? "NOT the local character" : "(no local character)", mode);
    g_ctl_g50 = g50; g_ctl_pause = pause; g_ctl_tgt = tgt;
    /* camera not following: character moved > 1 m in 3 s, camera did not move at all */
    if (ch && mode == 4) {
        float dc = (cp[0]-g_ctl_cam[0])*(cp[0]-g_ctl_cam[0]) + (cp[1]-g_ctl_cam[1])*(cp[1]-g_ctl_cam[1]) + (cp[2]-g_ctl_cam[2])*(cp[2]-g_ctl_cam[2]);
        if (dc > 1e-6f || !g_ctl_cam_still) { memcpy(g_ctl_cam, cp, sizeof(cp)); memcpy(g_ctl_chr, hp, sizeof(hp)); g_ctl_cam_still = now | 1; }
        else if (now - g_ctl_cam_still > 3000) {
            float dh = (hp[0]-g_ctl_chr[0])*(hp[0]-g_ctl_chr[0]) + (hp[1]-g_ctl_chr[1])*(hp[1]-g_ctl_chr[1]) + (hp[2]-g_ctl_chr[2])*(hp[2]-g_ctl_chr[2]);
            if (dh > 1.0f && g_ctl_logs++ < 200)
                plog("[controls] camera frozen at (%.1f, %.1f, %.1f) while the character moved to (%.1f, %.1f, %.1f): target %p, character %p, transition %p",
                     cp[0], cp[1], cp[2], hp[0], hp[1], hp[2], *(void **)(cam + 0x98), ch, *(void **)(cam + 0xD0));
            g_ctl_cam_still = now | 1; memcpy(g_ctl_chr, hp, sizeof(hp));
        }
    } else g_ctl_cam_still = 0;
    bad = ch && (mode == 4 || mode == 6) && (!g50 || pause == 1 || tgt == 0);
    if (!bad) g_ctl_bad_since = 0;
    else if (!g_ctl_bad_since) g_ctl_bad_since = now | 1;
    else if (g_input_fix && now - g_ctl_bad_since > 2000) {
        controls_repair(game, cam, "stuck for 2 s");
        g_ctl_bad_since = 0;
    }
}

/*
 * 0.64: the client's look scale was 0.005 when he joined (not his Options.cfg value) and he had to
 * set it again in the options. The proxy keeps the PC's own value: from Options.cfg (re-read when the
 * file changes), and from the options menu (whatever the look scale is when the OPTIONS screen
 * closes). If anything else changes it, it is put back and logged.
 */
static float g_sens_want = -1.0f;
static FILETIME g_sens_ft;
static int g_sens_in_menu, g_sens_logs;
static DWORD g_sens_next;
static void *input_settings(void) { return ((fn_get_ptr)VA(0x10093B10))(); }
static void sens_keep(int menu_open)
{
    DWORD now = GetTickCount();
    void *in;
    float cur;
    if (now < g_sens_next) return;
    g_sens_next = now + 500;
    __try {
        if (!(in = input_settings())) return;
        cur = *(float *)((BYTE *)in + 4);
        if (menu_open) { g_sens_in_menu = 1; return; }
        if (g_sens_in_menu) {
            g_sens_in_menu = 0;
            if (cur != g_sens_want) plog("[input] look scale %.5f set in the options menu - kept from now on", cur);
            g_sens_want = cur;
            return;
        }
        {   /* Options.cfg changed on disk? */
            char path[MAX_PATH], *slash;
            WIN32_FILE_ATTRIBUTE_DATA fa;
            GetModuleFileNameA(NULL, path, MAX_PATH);
            slash = strrchr(path, '\\'); if (slash) slash[1] = 0; else path[0] = 0;
            strcat(path, "Mods\\Bos\\Settings\\Options.cfg");
            if (GetFileAttributesExA(path, GetFileExInfoStandard, &fa) && CompareFileTime(&fa.ftLastWriteTime, &g_sens_ft) != 0) {
                g_sens_ft = fa.ftLastWriteTime;
                apply_mouse_sensitivity();
                g_sens_want = *(float *)((BYTE *)in + 4);
                return;
            }
        }
        if (g_sens_want > 0 && fabs(cur - g_sens_want) > 1e-6) {
            if (g_sens_logs++ < 20) plog("[input] look scale changed to %.5f by the game - put back to %.5f", cur, g_sens_want);
            ((fn_set_float)VA(0x10128160))(in, 0, g_sens_want);
        }
    } __except (EXCEPTION_EXECUTE_HANDLER) {}
}

/*
 * 0.65: script teleports on the client. The champion set-up teleports every player
 * (TeleportCharacter -> Bos 0x10019280 -> CHARACTER 0x10006F00, thiscall(pos*, rot*), ret 8). That
 * method writes the Position/Rotation vars AND the character's own copies: +0x268 / +0x2AC (the
 * movement code's position), head angles +0x2A4/+0x2A8/+0x2BC, the view matrix (0x10001A30 ->
 * +0x4F0, what the first-person camera shows, 0x1009B600). The script runs only on the host; the
 * client gets the teleport through a resync, which copies vars only. Its character kept moving
 * from the old internal position, wrote that back, differed from the host -> resync -> same again
 * (client 2026-11-15: a resync every ~3.9 s from the teleport on, camera frozen at the old spot,
 * "camera frozen at (-2268, 1486) while the character moved to (-2867, 1284)"); a reconnect rebuilt
 * the character from its vars and fixed it. On a client, every simulation frame: a character whose
 * internal position is more than 30 m from its Position var is re-placed with 0x10006F00 and its own
 * var values, as the host did. The two flag vars the method also sets (+0x1C8 |= 3, +0x1D8 = 0) are
 * put back to the synced values so the client's world stays equal to the host's.
 */
typedef void (__fastcall *fn_char_tp)(BYTE *ch, void *edx, float *pos, float *rot);
typedef void (__fastcall *fn_var_put)(void *var, void *edx, void *val, DWORD a2);
static int g_tp_fix = 0;                  /* [proxy] client_teleport_fix (0.65b: off - it re-placed NPCs and the host, did not help) */
static volatile LONG g_tp_fixed;
static void tp_fix_cb(BYTE *e, void *ctx)
{
    float *v = (float *)(e + 0x174), *in = (float *)(e + 0x268);
    float dx = v[0] - in[0], dy = v[1] - in[1], dz = v[2] - in[2], d2 = dx * dx + dy * dy + dz * dz;
    float pos[4], rot[4], old[3];
    DWORD f1c8, f1d8;
    BYTE *var1c4, *var1d4;
    (void)ctx;
    if (!(d2 > 900.0f) || d2 > 1e12f) return;           /* also skips NaN */
    {   /* a character fixed 3 times within 10 s keeps its own position for a reason: leave it 60 s */
        static struct { BYTE *e; DWORD first, hold; int n; } h[16];
        DWORD now = GetTickCount();
        int i, k = -1;
        for (i = 0; i < 16; i++) if (h[i].e == e) { k = i; break; }
        if (k < 0) { for (i = 0; i < 16; i++) if (!h[i].e || now - h[i].first > 70000) { k = i; break; } if (k < 0) k = 0;
                     h[k].e = e; h[k].first = now; h[k].n = 0; h[k].hold = 0; }
        if (h[k].hold && now - h[k].hold < 60000) return;
        if (now - h[k].first > 10000) { h[k].first = now; h[k].n = 0; h[k].hold = 0; }
        if (++h[k].n > 3) {
            h[k].hold = now | 1;
            plog("[teleport] client: %p re-placed 3 times in 10 s - left alone for 60 s", e);
            return;
        }
    }
    memcpy(pos, e + 0x174, 16); memcpy(rot, e + 0x198, 16); memcpy(old, in, 12);
    f1c8 = *(DWORD *)(e + 0x1C8); f1d8 = *(DWORD *)(e + 0x1D8);
    var1c4 = *(BYTE **)(e + 0x1C4); var1d4 = *(BYTE **)(e + 0x1D4);
    ((fn_char_tp)VA(0x10006F00))(e, 0, pos, rot);
    if (var1c4) { *(DWORD *)(e + 0x1C8) = f1c8; ((fn_var_put)(*(void ***)var1c4)[0x48 / 4])(var1c4, 0, e + 0x1C8, 0); }
    if (var1d4) { *(DWORD *)(e + 0x1D8) = f1d8; ((fn_var_put)(*(void ***)var1d4)[0x44 / 4])(var1d4, 0, e + 0x1D8, 0); }
    if (InterlockedIncrement(&g_tp_fixed) <= 60) {
        const char *nm = "?";
        __try { nm = entity_name(e); } __except (EXCEPTION_EXECUTE_HANDLER) {}
        plog("[teleport] client: %s was %.0f m from its synced position (internal %.1f, %.1f, %.1f -> %.1f, %.1f, %.1f) - re-placed the way the host's teleport did%s",
             nm ? nm : "?", sqrt(d2), old[0], old[1], old[2], pos[0], pos[1], pos[2], (void *)e == local_character() ? " (this PC's player)" : "");
    }
}
static void tp_fix_scan(void)
{
    BYTE *net = kt_net(), *iface = *(BYTE **)VA(VA_ENGINE_IFACE);
    if (!g_tp_fix || !net || net[0xDA4] != 0 || !iface) return;
    __try { for_each_entity(iface, 5, 1, tp_fix_cb, NULL); }
    __except (EXCEPTION_EXECUTE_HANDLER) {
        static int n; if (n++ < 5) plog("[teleport] client re-place scan faulted (%08X)", GetExceptionCode());
    }
}

static void rv_tick(void);
/* once per simulation frame, before the mod's UpdateSimulation (both PCs since 0.53; mission start host only) */
static void camera_watch(void)
{
    BYTE *game = bos_game(), *cam;
    int mode, state, master;
    void *target, *trans, *idle;
    float *pos;
    tp_fix_scan();
    hfz_watch();
    rv_tick();
    if (!game) return;
    master = strcmp(nw_state_name(), "MASTER") == 0;
    cam = *(BYTE **)(game + 0x14);
    if (!cam) return;
    mode = *(int *)(cam + 0x90);
    target = *(void **)(cam + 0x98);
    trans = *(void **)(cam + 0xD0);
    idle = *(void **)(cam + 0xD4);
    state = player_state(*(BYTE **)game);
    pos = (float *)(cam + 0x40);
    if (trans && trans != g_cam_trans) {
        g_cam_trans_name[0] = 0;
        __try { const char *nm = entity_name((BYTE *)trans); if (nm) { strncpy(g_cam_trans_name, nm, 63); g_cam_trans_name[63] = 0; } }
        __except (EXCEPTION_EXECUTE_HANDLER) {}
    }
    camera_cutscene_guard(cam, &mode, &trans);
    input_watch(cam, mode);
    controls_watch(game, cam, mode);
    {
        int opt = 0;
        __try {
            BYTE *gui = ((fn_kt_obj)KVA(0x10007B10))();
            void *scr = gui ? *(void **)(gui + 0x3C) : NULL;
            char nm[96];
            if (scr && strstr(rtti_name(scr, nm, sizeof(nm)), "OPTIONS")) opt = 1;
        } __except (EXCEPTION_EXECUTE_HANDLER) {}
        if (local_character()) sens_keep(opt);
    }

    if (g_cam_trans && !trans && (mode == 7 || mode == 3) && target && local_character()) {
        plog("[camera] cut-scene ended in mode %d (%s) - back to first person", mode, cam_mode_name(mode));
        *(int *)(cam + 0x90) = 4;
        mode = 4;
    }
    if ((mode != g_cam_mode || target != g_cam_target || trans != g_cam_trans || idle != g_cam_idle ||
         state != g_cam_state) && InterlockedIncrement(&g_cam_logs) <= 300)
        plog("[camera] mode %d (%s) target=%p transition=%p spawn-cam=%p player State=%d  pos=(%.1f, %.1f, %.1f)",
             mode, cam_mode_name(mode), target, trans, idle, state, pos[0], pos[1], pos[2]);
    if (mode == 4 && g_cam_mode != 4 && g_cam_mode != 6) {   /* spawned / joined */
        apply_mouse_sensitivity();
        __try { void *in = input_settings(); if (in) g_sens_want = *(float *)((BYTE *)in + 4); } __except (EXCEPTION_EXECUTE_HANDLER) {}
    }
    g_cam_mode = mode;
    g_cam_target = target;
    g_cam_trans = trans;
    g_cam_idle = idle;
    g_cam_state = state;

    /* story movies (0.57): only once this PC's player is in the world. Started at level load
       (0.56) the movie hid the spawn screen and nobody could spawn after it. */
    if (g_movie_due && !g_movie_active && mode == 4 && !trans && local_character()) {
        if (!g_movie_fp_at) g_movie_fp_at = GetTickCount() | 1;
        else if (GetTickCount() - g_movie_fp_at > 2000) movie_on_level_start();
    }
    if (g_movie_check_at && !g_movie_active && GetTickCount() >= g_movie_check_at) {
        g_movie_check_at = 0;
        if (g_movie_pre_mode == 4 && mode != 4 && mode != 6 && !trans && local_character() && state == g_movie_pre_state) {
            plog("[movie] camera left in mode %d (%s) after the movie - back to first person", mode, cam_mode_name(mode));
            *(int *)(cam + 0x90) = 4;
            g_cam_mode = 4;
        }
    }
    if (master && g_mission_armed && !g_mission_started && !trans && local_character()) {
        if (mode == 4) {
            g_mission_armed = 0;
            g_mission_pending = 1;
            plog("[mission] host is in the world (first-person camera) - starting the mission");
        } else if (GetTickCount() - g_mission_armed_at > 120000) {
            g_mission_armed = 0;
            g_mission_pending = 1;
            plog("[mission] no first-person camera 120 s after connecting (mode %d, State %d) - starting anyway",
                 mode, state);
        }
    }
}

/* ------------------------------------------------------------------------ */
/* NPC equipment: arsenal weapons and armor are applied only in solo        */
/* ------------------------------------------------------------------------ */
/*
 * CHARACTER vars-changed (vtable 0x101F6714 slot 1, 0x10011C40, thiscall, no
 * stack args - called as mov ecx,entity / call [edx+4] at KT 0x10028951) creates a character's weapons from its "Arsenal" var
 * (0x10011D30: if IsSolo -> 0x10020AB0 / 0x10020970, CurrentSlot -> 0x10021EF0)
 * and its armor from "Armor" (0x100120FE: if IsSolo -> 0x10003350). In MP
 * players are equipped by the class system instead, so every campaign NPC
 * stood there unarmed and without armor (2026-10-20 test). Its third IsSolo
 * check (0x10012224) guards the MP-only code for a character that belongs to
 * a PLAYER.
 *
 * In MP, for characters that are not a human player's, we answer
 * IsSolo = true for the duration of that call: the engine interface's IsSolo
 * (KT vtable 0x10142724 slot 112, 0x1001A240) is wrapped and returns true
 * only on the thread that is inside the NPC's call. Player characters keep
 * the multiplayer behaviour.
 */
static volatile LONG g_npc_equip_logs;

static BYTE __fastcall hook_is_solo(BYTE *self, void *edx)
{
    if (g_force_solo_tid && g_force_solo_tid == GetCurrentThreadId())
        return 1;
    return o_is_solo(self, edx);
}

static fn_this o_char_vars;

/*
 * Human players' characters. In MP every scene character also gets a PLAYER
 * (handles 0x800200FF downwards, created at load), so "has a PLAYER" does not
 * mean human. A human's PLAYER and CHARACTER are created by the MP connect
 * routine 0x1019CFB0 (thiscall, 2 stack args: name, connection; only caller
 * 0x101403EE), which names the character after the player (0x1019D00E).
 * We remember those names.
 */

typedef DWORD (__fastcall *fn_connect)(BYTE *self, void *edx, const char *name, DWORD conn);
static fn_connect o_connect;

static DWORD __fastcall hook_connect(BYTE *self, void *edx, const char *name, DWORD conn)
{
    int i;
    __try {
        for (i = 0; i < g_nhumans && strcmp(g_human_names[i], name) != 0; i++)
            ;
        if (i == g_nhumans && g_nhumans < MAX_HUMANS) {
            g_human_conn[g_nhumans] = conn;
            strncpy(g_human_names[g_nhumans], name, 63);
            g_human_names[g_nhumans][63] = 0;
            g_nhumans++;
        }
        plog("[player] connect: \"%s\" (connection %08X) - a human player", name, conn);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
    }
    return o_connect(self, edx, name, conn);
}

/*
 * 0.29: the connect names are not enough - a client only sees its own connect, so on the
 * client the host's character counted as an NPC (solo equipment = the host's armor invisible
 * there, and "the host's NPC command" = none = the host's character frozen there). The engine's
 * own test, the same on every PC: the PLAYER's +0x4C var (MultiTeam), read like the MP PLAYER
 * update does at 0x1005AE23 (vtable +0x1C Get(&out, 0); 0 = not a player: command cleared).
 * World dumps 2026-11-10: humans' PLAYERs 1 on both PCs, all scene (NPC) PLAYERs 0. A
 * CHARACTER's PLAYER is its var +0x418 (0x100013D0, used by the engine the same way).
 */
static BYTE *char_player(BYTE *ch)
{
    BYTE *pl = NULL;
    __try {
        pl = ((BYTE *(__fastcall *)(BYTE *, void *))VA(0x100013D0))(ch, 0);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        pl = NULL;
    }
    return pl;
}

/* 1 = a human player's PLAYER, 0 = not, -1 = unreadable */
static int player_human_flag(BYTE *pl)
{
    DWORD v[4] = { 0 };
    BYTE *var;
    if (!pl) return -1;
    __try {
        var = *(BYTE **)(pl + 0x4C);
        if (!var) return -1;
        ((void (__fastcall *)(BYTE *, void *, DWORD *, int))(*(void ***)var)[7])(var, 0, v, 0);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        return -1;
    }
    return v[0] != 0;
}

#define HUMAN_SEEN 16
static BYTE *g_human_seen[HUMAN_SEEN];    /* characters already logged as human */
static BYTE *g_solo_equipped[256];          /* characters hook_char_vars gave solo equipment */
static volatile LONG g_solo_equipped_n;

static int is_human_player(BYTE *pl, BYTE *ch)
{
    const char *n;
    int i, flag, named = 0, human;
    if (ch == (BYTE *)local_character()) return 1;
    flag = player_human_flag(pl);
    if (flag != 1) {
        n = entity_name(ch);
        for (i = 0; i < g_nhumans && !named; i++)
            if (strcmp(g_human_names[i], n) == 0) named = 1;
    }
    human = flag == 1 || named;
    if (human) {
        for (i = 0; i < HUMAN_SEEN && g_human_seen[i] && g_human_seen[i] != ch; i++)
            ;
        if (i < HUMAN_SEEN && !g_human_seen[i]) {
            int k, early = 0;
            g_human_seen[i] = ch;
            for (k = 0; k < 256 && k < g_solo_equipped_n; k++)
                if (g_solo_equipped[k] == ch) early = 1;
            plog("[human] %s (handle %08X) is a human player's character: PLAYER flag %d, connect name %d%s",
                 entity_name(ch), *(DWORD *)(ch + 0x1C), flag, named,
                 early ? " - IT ALREADY GOT SOLO EQUIPMENT (classified before its PLAYER was set)" : "");
        }
    }
    return human;
}

static int is_human_character(BYTE *ch)
{
    if (ch == (BYTE *)local_character()) return 1;
    return is_human_player(char_player(ch), ch);
}

static void __fastcall hook_char_vars(BYTE *self)
{
    static volatile LONG seen;
    const char *st;
    int force = 0;
    if (g_npc_equipment && o_is_solo && !g_force_solo_tid) {
        st = nw_state_name();
        if (strcmp(st, "MASTER") == 0 || strcmp(st, "SLAVE") == 0) {
            force = !is_human_character(self);
            if (!force && InterlockedIncrement(&seen) <= 4)
                plog("[npc] %s is a human player's character - multiplayer equipment", entity_name(self));
        }
    }
    if (!force) {
        o_char_vars(self);
        return;
    }
    if (InterlockedIncrement(&g_npc_equip_logs) <= 3)
        plog("[npc] %s: arsenal / armor applied as in solo", entity_name(self));
    {
        LONG k = InterlockedIncrement(&g_solo_equipped_n) - 1;
        if (k < 256) g_solo_equipped[k] = self;
    }
    g_force_solo_tid = GetCurrentThreadId();
    __try {
        o_char_vars(self);
    } __finally {
        g_force_solo_tid = 0;
    }
}

/*
 * The weapons in hand come from a second step: CHARACTER slot 2 (0x10010440, thiscall, no
 * args) rebuilds the weapon inventory (+0x44) from the arsenal slots (+0x300) when the
 * Arsenal var changed - 0x1001E7A0 deletes the old one, 0x10020290 builds the new one - but
 * only if IsSolo (0x100105E5). In MP NPCs had their arsenal but no inventory: no gun
 * (user's 0.9 test, 2026-10-29). Same treatment as slot 1.
 */
static fn_this o_char_post_vars;

static void __fastcall hook_char_post_vars(BYTE *self)
{
    const char *st;
    if (!g_npc_equipment || !o_is_solo || g_force_solo_tid) {
        o_char_post_vars(self);
        return;
    }
    st = nw_state_name();
    if ((strcmp(st, "MASTER") != 0 && strcmp(st, "SLAVE") != 0) || is_human_character(self)) {
        o_char_post_vars(self);
        return;
    }
    g_force_solo_tid = GetCurrentThreadId();
    __try {
        o_char_post_vars(self);
    } __finally {
        g_force_solo_tid = 0;
    }
    {
        static volatile LONG logs;
        if (InterlockedIncrement(&logs) <= 3)
            plog("[npc] %s: weapon inventory built as in solo (inventory %p)", entity_name(self),
                 *(void **)(self + 0x44));
    }
}

/*
 * Saves in co-op. A solo death reloads the last save: something in the mod queues "load game"
 * (engine vfunc 0x5C -> KT 0x1002AD10; the queue is processed by KT 0x1002BE92 -> 0x1008E140:
 * unload, read the save, BeginPlayLevel). In the MP session that loaded a solo save over the
 * running co-op level and crashed in BeginPlayLevel (KT+0x1DE00). coop_block_load=1 refuses the
 * request in an MP session (the player respawns the MP way); every request and "load level"
 * (0x68, mission end) is logged with its caller.
 */
typedef void (__fastcall *fn_eng_name)(BYTE *self, void *edx, const char *name);
static fn_eng_name o_eng_load_game, o_eng_load_level;
static int g_coop_block_load = 1;        /* coop_config.ini [proxy] coop_block_load */

static void __fastcall hook_eng_load_game(BYTE *self, void *edx, const char *name)
{
    char src[96];
    const char *st = nw_state_name();
    pl_describe((DWORD)_ReturnAddress(), src, sizeof(src));
    if (g_coop_block_load && (strcmp(st, "MASTER") == 0 || strcmp(st, "SLAVE") == 0)) {
        plog("[save] load game \"%s\" requested by %s - refused in the co-op session", name ? name : "?", src);
        return;
    }
    plog("[save] load game \"%s\" requested by %s", name ? name : "?", src);
    o_eng_load_game(self, edx, name);
}

static void __fastcall hook_eng_load_level(BYTE *self, void *edx, const char *name)
{
    char src[96];
    pl_describe((DWORD)_ReturnAddress(), src, sizeof(src));
    plog("[save] load level \"%s\" requested by %s (network %s)", name ? name : "?", src, nw_state_name());
    o_eng_load_level(self, edx, name);
}

/* The mission screens' Launch writes the solo mission save (engine vfunc 0x58 -> KT 0x1002AD90).
   In the MP session the simulation then stopped (0.17 logs: no sim steps for 54 s; once the window
   lost focus the D3D device reset crashed in kte_dx9+0x886A). coop_block_save=1 refuses saves in
   an MP session; the career is read from WorldMap_*.sav, the mission save is not needed. */
static fn_eng_name o_eng_save_game;
static int g_coop_block_save = 1;        /* coop_config.ini [proxy] coop_block_save */
static void __fastcall hook_eng_save_game(BYTE *self, void *edx, const char *name)
{
    char src[96];
    const char *st = nw_state_name();
    pl_describe((DWORD)_ReturnAddress(), src, sizeof(src));
    if (g_coop_block_save && (strcmp(st, "MASTER") == 0 || strcmp(st, "SLAVE") == 0)) {
        plog("[save] save game \"%s\" requested by %s - skipped in the co-op session", name ? name : "?", src);
        return;
    }
    plog("[save] save game \"%s\" requested by %s", name ? name : "?", src);
    o_eng_save_game(self, edx, name);
}

/* Engine 0x70 (KT 0x10019B10 -> 0x1002AE80) queues request type 4 = end the level (unload,
   0x1000C630); an MP round end and the Lua EndOfLevel without a BOS mission both use it.
   Engine 0x80 (KT 0x10019B50 -> 0x10066300) is called by EndOfLevel right after it. Logged
   with the caller to tell a round end from a mission end. */
typedef void (__fastcall *fn_eng_void)(BYTE *self, void *edx);
static fn_eng_void o_eng_end_level, o_eng_slot80;
static int g_coop_next_level = 1;       /* coop_config.ini [proxy] coop_next_level */
/* The co-op level that follows a finished one (coop_config.ini [next_level] <level>=<next>,
   built-in: COOP_Patrol -> COOP_Patrol_2). The LEVEL_CYCLE_MANAGER's "next map" (KT vtable
   0x1014F9AC slot 5, 0x100C98A0) returns it once, at the master restart after the mission end. */
static char g_next_level[64], g_next_ret[64];
static void coop_pick_next_level(const char *lvl)
{
    static const char *k_next[][2] = { { "COOP_Patrol", "COOP_Patrol_2" } };
    int i;
    g_next_level[0] = 0;
    if (!lvl) return;
    for (i = 0; i < (int)(sizeof(k_next) / sizeof(k_next[0])); i++)
        if (_stricmp(lvl, k_next[i][0]) == 0) strcpy(g_next_level, k_next[i][1]);
    GetPrivateProfileStringA("next_level", lvl, g_next_level, g_next_level, sizeof(g_next_level), g_config_path);
    if (strcmp(g_next_level, "-") == 0) g_next_level[0] = 0;
}

typedef const char *(__fastcall *fn_cycle_next)(BYTE *self, void *edx);
static fn_cycle_next o_cycle_next;
static const char *__fastcall hook_cycle_next(BYTE *self, void *edx)
{
    const char *r = o_cycle_next(self, edx);
    if (g_next_level[0]) {
        plog("[level] next map: the cycle says \"%s\", the co-op campaign goes on with \"%s\"", r ? r : "-", g_next_level);
        strcpy(g_next_ret, g_next_level);   /* stays valid; only this one restart is redirected */
        g_next_level[0] = 0;
        r = g_next_ret;
    } else {
        plog("[level] next map from the server's cycle: \"%s\"", r ? r : "-");
    }
    return r;
}

static void __fastcall hook_eng_end_level(BYTE *self, void *edx)
{
    char src[96];
    pl_describe((DWORD)_ReturnAddress(), src, sizeof(src));
    if (g_coop_next_level && strcmp(nw_state_name(), "MASTER") == 0 &&
        (DWORD)_ReturnAddress() == (DWORD)VA(0x10183DFF)) {
        /* Lua EndOfLevel without a BOS mission (0x10183DB0) unloads the level and the server stops.
           An MP round end calls engine 0x57C instead (BOS_RULES 0x10074D73 -> KT 0x100AFE50:
           "Master restart" - clients are told, then the server hosts the next map of the cycle).
           Do the same, so everyone moves on to the next co-op level together. */
        const char *lvl = NULL;
        __try {
            lvl = ((const char *(__fastcall *)(BYTE *, void *))(*(void ***)self)[0x74 / 4])(self, 0);
        } __except (EXCEPTION_EXECUTE_HANDLER) {
            lvl = NULL;
        }
        coop_pick_next_level(lvl);
        plog("[level] mission end in the co-op session (%s): master restart (engine 0x57C) instead of unloading; next level %s",
             lvl ? lvl : "?", g_next_level[0] ? g_next_level : "= the next map of the server's cycle");
        ((fn_eng_void)(*(void ***)self)[0x57C / 4])(self, 0);
        return;
    }
    plog("[level] end level (engine 0x70, request 4) requested by %s (network %s)", src, nw_state_name());
    o_eng_end_level(self, edx);
}
static void __fastcall hook_eng_slot80(BYTE *self, void *edx)
{
    char src[96];
    pl_describe((DWORD)_ReturnAddress(), src, sizeof(src));
    if (g_coop_next_level && (strcmp(nw_state_name(), "MASTER") == 0 || strcmp(nw_state_name(), "SLAVE") == 0)) {
        /* after EndOfLevel's unload this stopped the server from loading the next map of the cycle */
        plog("[level] engine 0x80 (KT 0x10066300) called by %s - skipped in the co-op session, the map cycle goes on", src);
        return;
    }
    plog("[level] engine 0x80 (KT 0x10066300) called by %s (network %s)", src, nw_state_name());
    o_eng_slot80(self, edx);
}

/* Hosting an MP level (KT 0x100B0310) first checksums its files (0x1002B2D0: Level.def, sub-level
   geometry, every DEF_GetLevelScriptFiles script, the .kts); one missing file and the master never
   starts (the network layer then crashes at KT+0xFBF67). Every file and its result is logged. */
typedef char (__fastcall *fn_file_crc)(BYTE *self, void *edx, const char *path, DWORD *crc);
static fn_file_crc o_file_crc;
static char __fastcall hook_file_crc(BYTE *self, void *edx, const char *path, DWORD *crc)
{
    char r = o_file_crc(self, edx, path, crc);
    plog("[level] checksum %s: %s", path ? path : "?", r ? "ok" : "FAILED (missing or unreadable)");
    return r;
}

/* Mission failed in the co-op session (Lua MissionFailed -> DisplayMissionFailed, e.g. BOS_Lost when
   the champion fight is lost): solo then offers to load a save, which the co-op session cannot do
   (coop_block_load). The failure is shown as usual and coop_fail_restart seconds later the server
   restarts the same level for everyone (master restart, as at the mission end). 0 = off. */
static int g_coop_fail_restart = 8;      /* coop_config.ini [proxy] coop_fail_restart (seconds) */
static DWORD g_fail_restart_at;
static void __cdecl hook_display_mission_failed(void)
{
    plog("[level] mission failed (DisplayMissionFailed), network %s", nw_state_name());
    __try {
        ((void (__cdecl *)(void))VA(0x10165100))();
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[level] the mission-failed screen faulted (exception %08X)", GetExceptionCode());
    }
    if (g_coop_fail_restart > 0 && strcmp(nw_state_name(), "MASTER") == 0 && !g_fail_restart_at) {
        g_fail_restart_at = GetTickCount() + (DWORD)g_coop_fail_restart * 1000;
        plog("[level] the co-op session restarts this level in %d s", g_coop_fail_restart);
    }
}

static void coop_restart_tick(void)
{
    BYTE *iface;
    const char *lvl = NULL;
    if (!g_fail_restart_at || GetTickCount() < g_fail_restart_at) return;
    g_fail_restart_at = 0;
    iface = *(BYTE **)VA(VA_ENGINE_IFACE);
    if (!iface) return;
    __try {
        lvl = ((const char *(__fastcall *)(BYTE *, void *))(*(void ***)iface)[0x74 / 4])(iface, 0);
        if (lvl && strlen(lvl) < sizeof(g_next_level)) strcpy(g_next_level, lvl);
        plog("[level] restarting %s after the mission failed (master restart)", lvl ? lvl : "?");
        lives_reset();                                   /* 0.70: the party's lives refill with the restart */
        ((fn_eng_void)(*(void ***)iface)[0x57C / 4])(iface, 0);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[level] restart failed (exception %08X)", GetExceptionCode());
    }
}

static void install_mission_failed_hook(void)
{
    BYTE *p = VA(0x10094904);       /* push DisplayMissionFailed (Lua function registration) */
    DWORD fn = (DWORD)hook_display_mission_failed;
    if (p[0] != 0x68 || *(DWORD *)(p + 1) != (DWORD)VA(0x10165100)) {
        plog("[hook] %-26s at 10094904: unexpected bytes - NOT installed", "coop_fail_restart");
        return;
    }
    if (write_code(p + 1, (BYTE *)&fn, 4))
        plog("[hook] %-26s Lua DisplayMissionFailed -> ok", "coop_fail_restart");
}

static void install_npc_equipment_hooks(void)
{
    if (!g_kt_base) return;
    o_is_solo = (fn_bool_0)hook_kt_vtable("engine_is_solo_wrap", 0x10142724, 112, 0x1001A240, (void *)hook_is_solo);
    o_eng_load_game = (fn_eng_name)hook_kt_vtable("coop_block_load", 0x10142724, 0x5C / 4, 0x10019A70, (void *)hook_eng_load_game);
    o_eng_save_game = (fn_eng_name)hook_kt_vtable("coop_block_save", 0x10142724, 0x58 / 4, 0x10019A50, (void *)hook_eng_save_game);
    o_eng_end_level = (fn_eng_void)hook_kt_vtable("end_level_log", 0x10142724, 0x70 / 4, 0x10019B10, (void *)hook_eng_end_level);
    o_cycle_next = (fn_cycle_next)hook_kt_vtable("coop_next_level", 0x1014F9AC, 5, 0x100C98A0, (void *)hook_cycle_next);
    o_file_crc = (fn_file_crc)hook_kt_call_site("level_checksum_log#1", 0x1002B456, 0x100C5240, (void *)hook_file_crc);
    hook_kt_call_site("level_checksum_log#2", 0x1002B531, 0x100C5240, (void *)hook_file_crc);
    hook_kt_call_site("level_checksum_log#3", 0x1002B6C2, 0x100C5240, (void *)hook_file_crc);
    hook_kt_call_site("level_checksum_log#4", 0x1002B753, 0x100C5240, (void *)hook_file_crc);
    o_eng_slot80 = (fn_eng_void)hook_kt_vtable("engine_80_log", 0x10142724, 0x80 / 4, 0x10019B50, (void *)hook_eng_slot80);
    o_eng_load_level = (fn_eng_name)hook_kt_vtable("load_level_log", 0x10142724, 0x68 / 4, 0x10019AD0, (void *)hook_eng_load_level);
    o_connect = (fn_connect)hook_call_site("human_player_names", 0x101403EE, 0x1019CFB0, (void *)hook_connect);
    if (o_is_solo && o_connect) {
        o_char_vars = (fn_this)hook_vtable("npc_equipment", 0x101F6714, 1, 0x10011C40, (void *)hook_char_vars);
        o_char_post_vars = (fn_this)hook_vtable("npc_weapons", 0x101F6714, 2, 0x10010440, (void *)hook_char_post_vars);
    }
}

/* ------------------------------------------------------------------------ */
/* save station in co-op                                                    */
/* ------------------------------------------------------------------------ */
/*
 * The save station's "save?" dialog confirm handler (0x10089E10) calls the
 * engine's SaveGame (interface vfunc 0x58 at 0x10089F29), then takes the
 * price, counts the save and closes the dialog. Saving a multiplayer session
 * stopped the simulation (no UpdateSimulation for 150 s after
 * ExportModOnSavingGame; 2026-10-20 test) - controls appeared locked - and a
 * co-op session could not be loaded back as co-op anyway. In MP we skip just
 * the engine call (coop_save=0); the station is still used up, so mission
 * objectives that wait for a save continue.
 * Patched bytes 0x10089F26: push eax / mov ecx,esi / call [ebp+58h] (6 bytes)
 * -> call save_call_stub / nop.
 */
static int __cdecl save_allowed(void)
{
    const char *st = nw_state_name();
    if (g_coop_save || (strcmp(st, "MASTER") != 0 && strcmp(st, "SLAVE") != 0))
        return 1;
    plog("[save] co-op session: save station used, game not saved (coop_save=0)");
    return 0;
}

__declspec(naked) static void save_call_stub(void)
{
    __asm {
        pushad
        call save_allowed
        test eax, eax
        popad                       /* popad leaves the flags alone */
        jz skip
        push eax                    /* the original: SaveGame(name) on the engine interface */
        mov ecx, esi
        call dword ptr [ebp + 58h]
    skip:
        ret
    }
}

static void install_save_patch(void)
{
    static const BYTE expect[] = { 0x50, 0x8B, 0xCE, 0xFF, 0x55, 0x58, 0x8B, 0x4C, 0x24, 0x44 };
    BYTE patch[6];
    patch[0] = 0xE8;
    *(INT32 *)(patch + 1) = (INT32)((BYTE *)save_call_stub - (VA(0x10089F26) + 5));
    patch[5] = 0x90;
    patch_code("coop_save_station", 0x10089F26, expect, sizeof(expect), 0x10089F26, patch, sizeof(patch));
}

/* ------------------------------------------------------------------------ */
/* engine run state (diagnostic)                                            */
/* ------------------------------------------------------------------------ */
/*
 * KT_Game's game object (singleton at KT 0x10185350): +0x7A application
 * active (ExportSetApplicationActivity; input is polled only while set,
 * 0x1000D261), +0x7B windows mouse mode, +0x85 simulation running
 * (ExportEnableUpdateSimulation, SetPause 0x1000BC40, network state changes),
 * +0x8A paused. Logged on change from the per-frame render export, which
 * keeps running while the simulation is stopped.
 */
#define KVA_GAME_PTR 0x10185350u
static int g_run_flags = -1;

static void run_state_watch(void)
{
    BYTE *g;
    int f;
    if (!g_kt_base) return;
    g = *(BYTE **)KVA(KVA_GAME_PTR);
    if (!g) return;
    f = (g[0x7A] ? 1 : 0) | (g[0x7B] ? 2 : 0) | (g[0x85] ? 4 : 0) | (g[0x8A] ? 8 : 0);
    if (f != g_run_flags) {
        if (g_run_flags != -1)
            plog("[run] window active=%d mouse-mode=%d simulation=%d paused=%d",
                 f & 1, (f >> 1) & 1, (f >> 2) & 1, (f >> 3) & 1);
        g_run_flags = f;
    }
}

/* the multiplayer map being hosted, from Settings\Options.cfg (saved right before loading) */
static void log_selected_map(void)
{
    char path[MAX_PATH], line[256], *slash;
    FILE *f;
    GetModuleFileNameA(NULL, path, MAX_PATH);
    slash = strrchr(path, '\\');
    if (slash) slash[1] = 0; else path[0] = 0;
    strcat(path, "Mods\\Bos\\Settings\\Options.cfg");
    f = fopen(path, "r");
    if (!f) return;
    while (fgets(line, sizeof(line), f)) {
        if (strncmp(line, "Cycle_SelectedMaps[", 19) == 0) {
            line[strcspn(line, "\r\n")] = 0;
            plog("[level] Options.cfg: %s", line);
        }
    }
    fclose(f);
}

/* ------------------------------------------------------------------------ */
/* crash reporting                                                          */
/* ------------------------------------------------------------------------ */

static int is_code_addr(DWORD a)
{
    MEMORY_BASIC_INFORMATION mbi;
    if (a < 0x10000 || !VirtualQuery((void *)a, &mbi, sizeof(mbi))) return 0;
    return mbi.State == MEM_COMMIT && mbi.Type == MEM_IMAGE &&
           (mbi.Protect & (PAGE_EXECUTE | PAGE_EXECUTE_READ | PAGE_EXECUTE_READWRITE | PAGE_EXECUTE_WRITECOPY));
}

/* true if the bytes before a look like a call instruction returning to a */
static int follows_call(DWORD a)
{
    const BYTE *p = (const BYTE *)a;
    if (!is_code_addr(a - 7)) return 0;
    return p[-5] == 0xE8 || (p[-2] == 0xFF && (p[-1] & 0x38) == 0x10) ||
           (p[-3] == 0xFF && (p[-2] & 0x38) == 0x10) || (p[-6] == 0xFF && (p[-5] & 0x38) == 0x10) ||
           (p[-7] == 0xFF && (p[-6] & 0x38) == 0x10);
}

static volatile LONG g_crashes_logged;

/* only faults inside the game's own modules are interesting; drivers and
   system DLLs raise harmless first-chance exceptions that would use up the cap */
static int in_game_module(DWORD a)
{
    HMODULE m = NULL;
    char path[MAX_PATH];
    if (!GetModuleHandleExA(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS |
                            GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT, (LPCSTR)a, &m) || !m)
        return 0;
    GetModuleFileNameA(m, path, MAX_PATH);
    return _strnicmp(path, g_game_dir, strlen(g_game_dir)) == 0;
}

static LONG CALLBACK crash_handler(EXCEPTION_POINTERS *ep)
{
    DWORD code = ep->ExceptionRecord->ExceptionCode;
    CONTEXT *c = ep->ContextRecord;
    char where[96], frame[96];
    NT_TIB *tib;
    DWORD sp, top;
    int shown = 0;

    if (code != EXCEPTION_ACCESS_VIOLATION && code != EXCEPTION_INT_DIVIDE_BY_ZERO &&
        code != EXCEPTION_ILLEGAL_INSTRUCTION && code != EXCEPTION_PRIV_INSTRUCTION &&
        code != EXCEPTION_STACK_OVERFLOW)
        return EXCEPTION_CONTINUE_SEARCH;
    if (!in_game_module(c->Eip))
        return EXCEPTION_CONTINUE_SEARCH;
    if (InterlockedIncrement(&g_crashes_logged) > 32)
        return EXCEPTION_CONTINUE_SEARCH;

    addr_name(c->Eip, where, sizeof(where));
    plog("[crash] exception %08X at %s (first chance; the game may still handle it)", code, where);
    if (code == EXCEPTION_ACCESS_VIOLATION)
        plog("[crash]   %s of address %08X",
             ep->ExceptionRecord->ExceptionInformation[0] == 1 ? "write" :
             ep->ExceptionRecord->ExceptionInformation[0] == 8 ? "execute" : "read",
             (DWORD)ep->ExceptionRecord->ExceptionInformation[1]);
    plog("[crash]   eax=%08X ebx=%08X ecx=%08X edx=%08X esi=%08X edi=%08X ebp=%08X esp=%08X",
         c->Eax, c->Ebx, c->Ecx, c->Edx, c->Esi, c->Edi, c->Ebp, c->Esp);
    if (code == EXCEPTION_STACK_OVERFLOW)
        return EXCEPTION_CONTINUE_SEARCH;

    tib = (NT_TIB *)NtCurrentTeb();
    top = (DWORD)tib->StackBase;
    for (sp = c->Esp; sp + 4 <= top && sp < c->Esp + 0x1000 && shown < 20; sp += 4) {
        DWORD v = *(DWORD *)sp;
        if (is_code_addr(v) && follows_call(v)) {
            addr_name(v, frame, sizeof(frame));
            plog("[crash]   esp+%03X  %s", sp - c->Esp, frame);
            shown++;
        }
    }
    return EXCEPTION_CONTINUE_SEARCH;
}

/*
 * Hang watchdog: the render export runs every frame, even in menus (the
 * dedicated server has only the simulation one). If the game thread stops
 * calling them for 5 s, sample where it is. While the thread
 * is suspended we only copy its registers and stack (it may hold the log or
 * loader lock); the addresses are resolved after it has been resumed.
 */
static DWORD g_main_tid;
static volatile DWORD g_last_frame_tick;

static DWORD WINAPI watchdog_thread(void *param)
{
    static DWORD stack[0x400];
    CONTEXT c;
    HANDLE th;
    DWORD n, i, since;
    int samples = 0, shown;
    char where[96], frame[96];
    MEMORY_BASIC_INFORMATION mbi;
    (void)param;
    for (;;) {
        Sleep(1000);
        if (!g_main_tid || !g_last_frame_tick) continue;
        since = GetTickCount() - g_last_frame_tick;
        if (since < 5000 || samples >= 8) continue;
        th = OpenThread(THREAD_SUSPEND_RESUME | THREAD_GET_CONTEXT, FALSE, g_main_tid);
        if (!th) continue;
        n = 0;
        if (SuspendThread(th) != (DWORD)-1) {
            c.ContextFlags = CONTEXT_CONTROL | CONTEXT_INTEGER;
            if (GetThreadContext(th, &c) && VirtualQuery((void *)c.Esp, &mbi, sizeof(mbi))) {
                n = (DWORD)((BYTE *)mbi.BaseAddress + mbi.RegionSize - (BYTE *)c.Esp) / 4;
                if (n > 0x400) n = 0x400;
                __try { memcpy(stack, (void *)c.Esp, n * 4); } __except (EXCEPTION_EXECUTE_HANDLER) { n = 0; }
            }
            ResumeThread(th);
        }
        CloseHandle(th);
        samples++;
        addr_name(c.Eip, where, sizeof(where));
        plog("[hang] game thread has not run a frame for %lu s - it is at %s", since / 1000, where);
        for (i = 0, shown = 0; i < n && shown < 16; i++)
            if (is_code_addr(stack[i]) && follows_call(stack[i])) {
                addr_name(stack[i], frame, sizeof(frame));
                plog("[hang]   esp+%03X  %s", i * 4, frame);
                shown++;
            }
        Sleep(4000);
    }
    return 0;
}

/* ------------------------------------------------------------------------ */
/* initialisation                                                           */
/* ------------------------------------------------------------------------ */

#include "exports_gen_names.h"

/* KT 0x1002AE80 queues request 4 (end the level). Who calls it at an MP round end (not through the
   engine vtable)? Logged with a short stack scan. */
static BYTE *g_tramp_end_req;
static void __cdecl end_req_log(DWORD *sp)
{
    char frame[96];
    DWORD *p;
    int shown = 0;
    plog("[level] end-level request (KT 0x1002AE80), network %s; callers:", nw_state_name());
    for (p = sp; p < sp + 160 && shown < 10; p++) {
        __try {
            if (is_code_addr(*p) && follows_call(*p)) {
                addr_name(*p, frame, sizeof(frame));
                plog("[level]   esp+%03X  %s", (int)((BYTE *)p - (BYTE *)sp), frame);
                shown++;
            }
        } __except (EXCEPTION_EXECUTE_HANDLER) {
            break;
        }
    }
}
__declspec(naked) static void stub_end_req(void)
{
    __asm pushad
    __asm lea eax, [esp + 32]
    __asm push eax
    __asm call end_req_log
    __asm add esp, 4
    __asm popad
    __asm jmp dword ptr [g_tramp_end_req]
}
static void install_end_req_log(void)
{
    BYTE e[7] = { 0x6A, 0xFF, 0x68 };
    if (!g_kt_base) return;
    memcpy(e + 3, KVA(0x1002AE83), 4);
    g_tramp_end_req = detour_kt("end_level_request_log", 0x1002AE80, e, 7, (void *)stub_end_req);
}

/* ------------------------------------------------------------------------ */
/* network throughput (LAN)                                                 */
/* ------------------------------------------------------------------------ */
/*
 * The engine's per-connection send (KT 0x101106F0, "SendAllDatagramm") packs at most 5 normal
 * datagrams and ONE datagram of fragments (1400 bytes) per call. A world-state update larger
 * than a datagram is split into fragments, so a campaign level (90+ characters, 140+ rigid
 * bodies, vs. a 16-player MP map) reaches the client one 1.4 KB fragment per send call: the
 * client falls behind and the master then sends full updates, which are bigger still.
 * net_datagrams / net_fragments raise both limits (engine: 5 / 1); net_sockbuf enlarges the
 * UDP socket buffers so the bigger bursts are not dropped by the receiver. The [net] report
 * logs the traffic every 10 s. Applies on host and clients (both send).
 */
static int g_net_datagrams = 64;          /* coop_config.ini [proxy] net_datagrams (engine 5, 0 = keep) */
static int g_net_fragments = 64;          /* [proxy] net_fragments (engine 1, 0 = keep) */
static int g_net_sockbuf = 8 << 20;       /* [proxy] net_sockbuf (bytes, 0 = keep) */
static volatile LONG g_net_tx_bytes, g_net_tx_pkts, g_net_rx_bytes, g_net_rx_pkts, g_net_calls, g_net_fail;
static volatile LONG g_pass_max_pkts, g_pass_max_bytes, g_pass_big, g_pass_max_ms;
static volatile LONG g_net_report_at;

typedef SOCKET (WINAPI *fn_socket)(int, int, int);
typedef int (WINAPI *fn_sendto)(SOCKET, const char *, int, int, const struct sockaddr *, int);
typedef int (WINAPI *fn_recvfrom)(SOCKET, char *, int, int, struct sockaddr *, int *);
typedef int (WINAPI *fn_setsockopt)(SOCKET, int, int, const char *, int);
typedef int (WINAPI *fn_getsockopt)(SOCKET, int, int, char *, int *);
static fn_socket o_socket;
static fn_sendto o_sendto;
static fn_recvfrom o_recvfrom;
static fn_setsockopt p_setsockopt;
static fn_getsockopt p_getsockopt;
typedef void (WINAPI *fn_wsasetlasterror)(int);
static fn_wsasetlasterror p_wsasetlasterror;
typedef char (__fastcall *fn_send_all)(void *self, void *edx, void *a, void *b);
static fn_send_all o_send_all;

/*
 * Resync (client side). BoS multiplayer is predict-and-rollback: the client simulates the world
 * itself from the players' inputs and must stay identical to the host. The slave's check
 * (KT 0x100B0A50, run each frame) waits until 60 frames (cmp ecx,3Ch at 0x100B0B52) have passed
 * since the last resync, then compares the host's checksum with its own each frame; the first
 * mismatch asks for a resync (call 0x10017A80 at 0x100B0C67; prediction > 150 frames: 0x100B0CB4)
 * and the host's full world state replaces the client's (handled in 0x100B1A40, calls at
 * 0x100B1B89 / 0x100B1D11). A campaign level never stays identical (the AI and the mission
 * scripts run on the host only), so the client was corrected once per 60 frames + resync time
 * (~3.9 s): the "slow refresh". net_resync_after lowers the 60 so the client is corrected after
 * a few frames; the [net] report shows resyncs per reason and how long they take.
 */
static int g_net_resync_after = 60;       /* [proxy] net_resync_after (frames, engine 60, 0 = keep) */
static volatile LONG g_rs_checksum, g_rs_predict, g_rs_done, g_rs_ms_sum, g_rs_ms_max;
static DWORD g_rs_asked_at;
/* 0.39: what a resync costs on the client: datagrams/bytes received while it is pending (all traffic,
   so the normal stream is included), the largest datagram, ask -> first datagram, ask -> applied. */
static volatile LONG g_rs_win_bytes, g_rs_win_pkts, g_rs_win_big, g_rs_win_first, g_rs_win_last, g_rs_sum_last, g_rs_sum_total, g_rs_win_fbig, g_rs_sum_fbig;
static volatile LONG g_rs_sum_bytes, g_rs_sum_pkts, g_rs_max_bytes, g_rs_max_big, g_rs_sum_first, g_rs_n;
typedef void (__fastcall *fn_rs_ask)(void *self, void *edx);
typedef DWORD (__fastcall *fn_rs_apply)(void *self, void *edx);
static fn_rs_ask o_rs_ask;
static fn_rs_apply o_rs_apply;

/*
 * 0.38: minimum gap between checksum resyncs (net_resync_gap seconds, 0 = engine). Each resync stops
 * the client while the host's whole world comes over (net+0xBAA "pending" blocks the sim:
 * 0x1000B92B, 0x100B0853; cleared in 0x100B1B43) - 270-310 ms in co-op, the snap. A stock MP game
 * (MP_CargoBay, 2026-11-11) had 1 resync at join and none after; co-op asked at nearly every
 * check (1-3 per 10 s, the 60-frame hold-off allows ~2.7) for small differences (a bullet, what it
 * hit). Within the gap the request is dropped: the flag and the engine's counter (+0xDF8) are put
 * back and the check simply runs again next frame. "Too far ahead" (>150 frames) is never held.
 */
static int g_net_resync_gap = 0;          /* [proxy] net_resync_gap (s), 0 = off */
static int g_net_resync_early = 1;        /* [proxy] net_resync_early */
/* 0.40: 0.38 dropped the local ask (0x10017A80) only - the mismatch had already been reported to the
   host (0x100EAEB0(frame) at 0x100B0C4E), which kept sending world states: 0.39 session client got
   6-9 resyncs per 10 s while asking 0, NPCs vanished. Now the whole check (0x100B0A50, hooked at
   0x100A9999) is skipped within the gap; before the report it only reads checksums, and its hold-off
   counts from net+0xCA4, which the resync sets. Untested - off by default. */
static DWORD g_rs_last_done;
static volatile LONG g_rs_held;
static BYTE *kt_net(void);
static void __fastcall hook_rs_ask_checksum(void *self, void *edx)
{
    InterlockedIncrement(&g_rs_checksum);
    if (!g_rs_asked_at) { g_rs_win_bytes = g_rs_win_pkts = g_rs_win_big = g_rs_win_last = 0; g_rs_win_first = g_rs_win_fbig = -1; g_rs_asked_at = GetTickCount(); }
    o_rs_ask(self, edx);
}

static void __fastcall hook_rs_ask_predict(void *self, void *edx)
{
    InterlockedIncrement(&g_rs_predict);
    if (!g_rs_asked_at) { g_rs_win_bytes = g_rs_win_pkts = g_rs_win_big = g_rs_win_last = 0; g_rs_win_first = g_rs_win_fbig = -1; g_rs_asked_at = GetTickCount(); }
    o_rs_ask(self, edx);
}

static void rb_strip_all(const char *why);
static DWORD __fastcall hook_rs_apply(void *self, void *edx)
{
    DWORD r = o_rs_apply(self, edx);
    if (r & 0xFF) {
        InterlockedIncrement(&g_rs_done);
        g_rs_last_done = GetTickCount();
        frz_map_clear(NULL);                         /* the world was rebuilt: all value objects are new */
        rb_strip_all(NULL);                          /* ... and the props came back with bodies */
        if (g_rs_asked_at) {
            LONG ms = (LONG)(GetTickCount() - g_rs_asked_at);
            InterlockedExchangeAdd(&g_rs_ms_sum, ms);
            if (ms > g_rs_ms_max) g_rs_ms_max = ms;
            InterlockedExchangeAdd(&g_rs_sum_bytes, g_rs_win_bytes);
            InterlockedExchangeAdd(&g_rs_sum_pkts, g_rs_win_pkts);
            InterlockedExchangeAdd(&g_rs_sum_first, g_rs_win_first);
            InterlockedExchangeAdd(&g_rs_sum_last, g_rs_win_last);
            InterlockedExchangeAdd(&g_rs_sum_fbig, g_rs_win_fbig < 0 ? 0 : g_rs_win_fbig);
            InterlockedExchangeAdd(&g_rs_sum_total, ms);
            InterlockedIncrement(&g_rs_n);
            if (g_rs_win_bytes > g_rs_max_bytes) g_rs_max_bytes = g_rs_win_bytes;
            if (g_rs_win_big > g_rs_max_big) g_rs_max_big = g_rs_win_big;
            g_rs_win_bytes = g_rs_win_pkts = g_rs_win_big = 0;
            g_rs_win_first = -1;
            g_rs_win_last = 0;
            g_rs_win_fbig = -1;
            g_rs_asked_at = 0;
        }
    }
    return r;
}

/*
 * World-state dumps, to find what differs between host and client (net_dump_ws=1). The engine's
 * own desync report writer (KT 0x100D9790: ws id, frame, std::string file name; used by the
 * slave check when NW_LOG_DESYNC is set) writes every entity and its vars for one frame. The host
 * dumps each frame divisible by 128 once it is complete; the client dumps the same frame numbers
 * when its desync check runs (that frame is then final on the client too). Files:
 * coop_logs\ws\host_<frame>.txt / client_<frame>.txt, at most net_dump_ws_max per run.
 */
static int g_net_dump_ws = 1;             /* [proxy] net_dump_ws */
static int g_net_dump_ws_max = 10;        /* [proxy] net_dump_ws_max */
static int g_ws_dumped[2], g_ws_last_frame = -1;
typedef void (__fastcall *fn_ws_dump)(void *ecx, void *edx, int ws, int frame, void *name);
typedef void (__fastcall *fn_desync_check)(void *self, void *edx);
static fn_desync_check o_desync_check;

struct vc71_string { DWORD alval; union { char buf[16]; char *ptr; } bx; DWORD size, res; };

static BYTE *kt_net(void)
{
    return g_kt_base ? *(BYTE **)KVA(0x10185344) : NULL;
}

static void ws_dump(BYTE *net, int frame, const char *who)
{
    static char path[MAX_PATH];
    char dir[MAX_PATH], *slash;
    struct vc71_string s;
    if (!g_net_dump_ws || g_ws_dumped[who[0] == 'c'] >= g_net_dump_ws_max || frame == g_ws_last_frame || !net) return;
    GetModuleFileNameA(NULL, dir, sizeof(dir));
    slash = strrchr(dir, '\\');
    if (slash) slash[1] = 0;
    _snprintf(path, sizeof(path), "%scoop_logs\\ws", dir);
    CreateDirectoryA(path, NULL);
    _snprintf(path, sizeof(path), "%scoop_logs\\ws\\%s_%06d.txt", dir, who, frame);
    path[sizeof(path) - 1] = 0;
    memset(&s, 0, sizeof(s));
    s.bx.ptr = path;
    s.size = (DWORD)strlen(path);
    s.res = s.size < 16 ? 16 : s.size;
    g_ws_last_frame = frame;
    g_ws_dumped[who[0] == 'c']++;
    __try {
        ((fn_ws_dump)KVA(0x100D9790))(NULL, NULL, *(int *)(net + 0x128), frame, &s);
        plog("[net] world state of frame %d written to %s", frame, path);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[net] world-state dump of frame %d failed (exception %08X) - dumps off", frame, GetExceptionCode());
        g_net_dump_ws = 0;
    }
}

/* host: once per simulation frame */
static int coop_mp_session(void);
static void ws_dump_host_tick(void)
{
    BYTE *net = kt_net();
    int frame;
    if (!g_net_dump_ws || !net || net[0xDA4] != 1) return;
    frame = *(int *)(net + 0x14) - 1;
    if (frame > 0 && (frame & 1023) == 0 && coop_mp_session()) ws_dump(net, frame, "host");
}

/* client: the slave desync check (0x100B0A50, call at 0x100A9999) compares frame (current - 1) */
static void __fastcall hook_desync_check(void *self, void *edx)
{
    BYTE *net = (BYTE *)self;
    int frame = *(int *)(net + 0x14) - 1;
    if (g_net_dump_ws && frame > 0 && (frame & 1023) == 0) ws_dump(net, frame, "client");
    if (g_net_resync_gap > 0 && g_rs_last_done && GetTickCount() - g_rs_last_done < (DWORD)g_net_resync_gap * 1000u) {
        InterlockedIncrement(&g_rs_held);
        return;
    }
    o_desync_check(self, edx);
}

/*
 * 0.67: resync patience (net_resync_patience frames, 0 = engine). The check at 0x100B0A50 compares
 * the host's checksum of the frame (0x100D9A90 -> 0x1018BF5C) with the client's own (0x100D9810,
 * call at 0x100B0B97 -> 0x1018BF58) and asks for a whole-world resync at the first difference.
 * Most differences left are corrected by the host's per-frame state (NPCs, timers, objectives) a
 * frame later, so the client now waits: while a mismatch has lasted fewer than N checks in a row,
 * its own value is reported as the host's (the check passes, nothing is asked or reported). Only a
 * difference that is still there after N frames (16 per second) gets a resync. "Too far ahead"
 * (> 150 predicted frames) is not touched.
 */
static int g_net_resync_patience = 32;    /* [proxy] net_resync_patience (frames) */
static int g_mm_run, g_mm_run_max;
static volatile LONG g_mm_hidden, g_mm_healed, g_mm_passed;
typedef void (__fastcall *fn_ws_csum)(void *t, void *edx, int ws, int frame, DWORD *out);
static fn_ws_csum o_ws_csum_check;
static void __fastcall hook_ws_csum_check(void *t, void *edx, int ws, int frame, DWORD *out)
{
    DWORD host;
    o_ws_csum_check(t, edx, ws, frame, out);
    if (g_net_resync_patience <= 0 || !out) return;
    __try {
        host = *(DWORD *)KVA(0x1018BF5C);
        if (*out == host) {
            if (g_mm_run) InterlockedIncrement(&g_mm_healed);
            g_mm_run = 0;
            return;
        }
        if (!host) return;                                   /* no host checksum: engine decides */
        g_mm_run++;
        if (g_mm_run > g_mm_run_max) g_mm_run_max = g_mm_run;
        if (g_mm_run <= g_net_resync_patience) {
            *out = host;
            InterlockedIncrement(&g_mm_hidden);
        } else {
            g_mm_run = 0;
            InterlockedIncrement(&g_mm_passed);
        }
    } __except (EXCEPTION_EXECUTE_HANDLER) {
    }
}

/*
 * NPC commands and AI drive values to the clients (net_npc_commands=1, net_npc_drive=1).
 *
 * The AI drives NPCs like players: one command per NPC PLAYER per frame (axes +0x18/+0x1C,
 * buttons +0x20/+0x24, PLAYER id +0x28 = PLAYER entity +0x1C; 0x2C bytes), handed to the engine
 * through engine-interface vtable 0x10142724 slot 305 = KT 0x1001D7D0 (&b24, &b20, &a18, &a1C,
 * &id; ret 14h). That only pushes it on the master's local list for the current frame
 * (0x100B6230), so clients never got any: their NPCs stood still and never fired, the worlds
 * never matched, and every check (each ~4 s) ended in a full resync that snapped the client back.
 *
 * Writing them into the world state does not work: 0x100AB860 sends a command through the
 * master's own connection (0x100F1C40 ignores the frame, 0x100FCAB0 sends), where it is scheduled
 * per connection (0.26: client got none; 0.27 queued them before the frame's list build at
 * 0x1000D62E - then even the host's NPCs got nothing).
 *
 * 0.28: a side channel on the game's own UDP socket (no new port, no firewall change). Worked
 * (client: every frame's commands arrived in time), but the 2-PC dumps still differed:
 *  - the client took the host's character for an NPC (human test by connect names, and a
 *    client only sees its own connect) and gave it "the host's NPC command" = none: the host's
 *    character stood still on the client (velocity 0, 20-60 units off) and got solo equipment
 *    (the client could not see the host's armor);
 *  - the character update (0x10013990) drives a character with an AI agent (+0x58, host only)
 *    differently: 0x10005200 (call 0x1001405E) sets the AI gait (+0x1C0 bits 8/0x10), speed
 *    +0x5C8 and +0x5CC, the agent sets +0x5CD (0x100B3840, read at 0x10014107), and the "AI"
 *    flag at 0x1001406A (agent and name != "Player") switches the movement physics. Clients
 *    have no agents, so every active NPC moved differently there; the humans the host gave
 *    agents (AI targeting) got AI gait on the host only.
 *
 * 0.29: one frame table on both PCs.
 *  - master: at each step start (0x1000D62E, after the original) what the AI decided since the
 *    last step (slot 305 commands, and the drive values the character updates produced) is
 *    stamped "frame net+0x14 + 2", stored in the master's own table and sent to every client
 *    that said hello (CMN1 commands, CMD1 drive values; empty frames are sent too);
 *  - both: in the PLAYER update every NPC PLAYER gets exactly the command its frame-table entry
 *    for frame net+0x14 holds, or none (the engine's own lookup uses net+0x14 the same way,
 *    KT 0x100AE230), and in the character update every NPC gets the table's drive values and AI
 *    flag (or "no agent" ones); humans always get the "no agent" ones, on both PCs.
 * So the host no longer pushes NPC commands into the engine's list and both PCs apply the
 * same values in the same frame by construction, 2-3 frames (125-190 ms) after the AI decided.
 * Client: says hello to the address its game traffic goes to (every 2 s); hook_recvfrom takes
 * the packets out of the stream (returns -1 = nothing to read, which the engine's
 * select+recvfrom loops skip). net_trace=1 logs every character at the same point of the same
 * frames on both PCs (coop_logs\trace_host.txt / trace_client.txt) to compare them exactly.
 */
static void net_report(void);
static int g_net_npc_commands = 1;        /* [proxy] net_npc_commands */
static int g_net_npc_drive = 1;           /* [proxy] net_npc_drive */
static int g_net_trace = 1;               /* [proxy] net_trace */
typedef void (__fastcall *fn_add_cmd)(void *self, void *edx, DWORD *b24, DWORD *b20, DWORD *a18, DWORD *a1c, DWORD *id);
typedef void (__fastcall *fn_read_frame_cmds)(void *net, void *edx, int frame);
static fn_add_cmd o_add_cmd;
static fn_read_frame_cmds o_read_frame_cmds;
static void *g_engine_iface;              /* `this` of slot 305 */

#define NPC_MAGIC_CMD   0x314E4D43u       /* "CMN1" master -> client: commands of one frame */
#define NPC_MAGIC_DRV   0x31444D43u       /* "CMD1" master -> client: AI drive values of one frame */
#define NPC_MAGIC_HELLO 0x31484D43u       /* "CMH1" client -> master: send me the frame table */
#define NPC_PER_PACKET  64
#define DRV_PER_PACKET  100
#define NPC_PER_FRAME   256
struct npc_cmd { DWORD a18, a1c, b20, b24, id; };
struct npc_pkt { DWORD magic; int frame; WORD n, last; struct npc_cmd c[NPC_PER_PACKET]; };
/* what 0x10005200 and the agent leave on a character (id = CHARACTER handle, entity +0x1C) */
#define DRV_GAIT_SET 1                    /* 0x10005200 took the AI path: +0x1C0 bits 8/0x10 = gait */
#define DRV_AGENT    2                    /* the character has an AI agent: AI movement rules */
struct drv_rec { DWORD id; float speed; BYTE gait, cc, cd, flags; };
struct drv_pkt { DWORD magic; int frame; WORD n, last; struct drv_rec r[DRV_PER_PACKET]; };
/* 0.47: Freeze changes of NPC characters (scripts' FreezeAll / Freeze / SetVarValue, the engine's own) */
#define NPC_MAGIC_STATE 0x31534D43u       /* "CMS1" (0.62, see ns_*) */
static int g_net_npc_state;
static int g_net_csum_npcs;
static __declspec(thread) int t_cs_npc;
static volatile LONG g_cs_npc_skipped;
static void ns_on_packet(const BYTE *buf, int len);
#define NPC_MAGIC_FRZ   0x315A4D43u       /* "CMZ1" master -> client: Freeze changes of one frame */
#define FRZ_PER_FRAME   64
struct frz_rec { DWORD id; DWORD v; };
struct frz_pkt { DWORD magic; int frame; WORD n, last; struct frz_rec r[FRZ_PER_FRAME]; };
/* 0.71 revive: "put character id at x y z" in its PLAYER update of the stamped frame (both PCs) */
#define NPC_MAGIC_TP     0x31544D43u      /* "CMT1" master -> client: revive teleports of one frame */
#define NPC_MAGIC_GIVEUP 0x31474D43u      /* "CMG1" client -> master: <name> gives up (respawn now) */
#define TP_PER_FRAME 8
struct tp_rec { DWORD id; float x, y, z; };
struct tp_pkt { DWORD magic; int frame; WORD n, last; struct tp_rec r[TP_PER_FRAME]; };
struct giveup_pkt { DWORD magic; char name[60]; };
#define NPC_MAGIC_DIFF   0x31564D43u      /* "CMV1" master -> client: difficulty level (0.75) */
static int g_difficulty;
static volatile LONG g_diff_rx = -1;
static void rv_giveup_push(const char *name);
static void rv_client_note(DWORD id);

static CRITICAL_SECTION g_npc_cs;
/* master: decided since the last step */
static struct npc_cmd g_npc_new[NPC_PER_FRAME];
static struct drv_rec g_drv_new[NPC_PER_FRAME];
static int g_npc_new_n, g_drv_new_n, g_ft_last_stamp = -1;
static DWORD g_ft_master_at;              /* tick of the last master step (channel active) */
#define NPC_PEERS 8
static struct { struct sockaddr_in addr; SOCKET s; DWORD seen; } g_npc_peer[NPC_PEERS];
/* both: the frame table (master: filled when stamping; client: from the packets) */
#define NPC_RING 128
static struct ft_frame {
    int frame, ncmd, ndrv, cmd_done, drv_done, nfz, fz_done, ntp;
    struct npc_cmd c[NPC_PER_FRAME];
    struct drv_rec d[NPC_PER_FRAME];
    struct frz_rec z[FRZ_PER_FRAME];
    struct tp_rec t[TP_PER_FRAME];
} g_ft[NPC_RING];
static struct frz_rec g_fz_new[FRZ_PER_FRAME];
static int g_fz_new_n;
static struct tp_rec g_tp_new[TP_PER_FRAME];
static int g_tp_new_n;
static volatile LONG g_fz_queued, g_fz_dropped, g_fz_applied, g_fz_rx, g_fz_missing;
static DWORD g_npc_rx_at;                 /* client: tick of the last table packet */
static SOCKET g_npc_master_s = INVALID_SOCKET;
static struct sockaddr_in g_npc_master;
static DWORD g_npc_hello_at;
static volatile LONG g_npc_cmd_sent, g_npc_pkt_sent, g_npc_rx_cmds, g_npc_rx_frames, g_npc_missing,
                     g_npc_overflow, g_npc_hellos, g_npc_logged, g_drv_captured, g_drv_applied,
                     g_drv_missing, g_drv_rx, g_drv_human, g_ft_frames;

static int npc_is_real(const struct npc_cmd *c)
{
    return (c->a18 & 0x7FFFFFFF) || (c->a1c & 0x7FFFFFFF) || c->b20 || c->b24;
}

/* 1 = this PC applies the frame table (master in a co-op step, or a client receiving it) */
static int ft_active(BYTE *net)
{
    if (!g_net_npc_commands || !net) return 0;
    if (net[0xDA4] == 1) return g_ft_master_at && GetTickCount() - g_ft_master_at < 2000;
    if (net[0xDA4] == 0) return g_npc_rx_at && GetTickCount() - g_npc_rx_at < 5000;
    return 0;
}

/* inside g_npc_cs: the table slot for `frame`, emptied if it held another frame */
static struct ft_frame *ft_slot(int frame)
{
    struct ft_frame *f = &g_ft[frame & (NPC_RING - 1)];
    if (f->frame != frame) {
        f->frame = frame;
        f->ncmd = f->ndrv = f->nfz = f->ntp = 0;
        f->cmd_done = f->drv_done = f->fz_done = 0;
    }
    return f;
}

/* inside g_npc_cs: the table entry for `frame`, or NULL */
static struct ft_frame *ft_get(int frame)
{
    struct ft_frame *f = &g_ft[frame & (NPC_RING - 1)];
    return f->frame == frame ? f : NULL;
}

static void __fastcall hook_add_cmd(void *self, void *edx, DWORD *b24, DWORD *b20, DWORD *a18, DWORD *a1c, DWORD *id)
{
    BYTE *net;
    struct npc_cmd c;
    if (!g_net_npc_commands || !o_read_frame_cmds || !(net = kt_net()) || net[0xDA4] != 1 || !ft_active(net)) {
        o_add_cmd(self, edx, b24, b20, a18, a1c, id);
        return;
    }
    g_engine_iface = self;
    __try {
        c.a18 = *a18; c.a1c = *a1c; c.b20 = *b20; c.b24 = *b24; c.id = *id;
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        o_add_cmd(self, edx, b24, b20, a18, a1c, id);
        return;
    }
    if (!npc_is_real(&c)) return;
    EnterCriticalSection(&g_npc_cs);
    if (g_npc_new_n < NPC_PER_FRAME) g_npc_new[g_npc_new_n++] = c;
    else InterlockedIncrement(&g_npc_overflow);
    LeaveCriticalSection(&g_npc_cs);
}

static void npc_send_packet(const void *p, int len)
{
    DWORD now = GetTickCount();
    int i;
    if (!o_sendto) return;
    for (i = 0; i < NPC_PEERS; i++) {
        if (!g_npc_peer[i].seen || now - g_npc_peer[i].seen > 10000) continue;
        if (o_sendto(g_npc_peer[i].s, (const char *)p, len, 0,
                     (const struct sockaddr *)&g_npc_peer[i].addr, sizeof(g_npc_peer[i].addr)) > 0)
            InterlockedIncrement(&g_npc_pkt_sent);
    }
}

static void npc_send_frame(int frame, const struct npc_cmd *c, int n)
{
    struct npc_pkt p;
    int k, off = 0;
    do {
        k = n - off > NPC_PER_PACKET ? NPC_PER_PACKET : n - off;
        p.magic = NPC_MAGIC_CMD; p.frame = frame; p.n = (WORD)k; p.last = (WORD)(off + k >= n);
        memcpy(p.c, c + off, k * sizeof(*c));
        npc_send_packet(&p, 12 + k * (int)sizeof(*c));
        off += k;
    } while (off < n);
    InterlockedExchangeAdd(&g_npc_cmd_sent, n);
}

static void drv_send_frame(int frame, const struct drv_rec *r, int n)
{
    struct drv_pkt p;
    int k, off = 0;
    do {
        k = n - off > DRV_PER_PACKET ? DRV_PER_PACKET : n - off;
        p.magic = NPC_MAGIC_DRV; p.frame = frame; p.n = (WORD)k; p.last = (WORD)(off + k >= n);
        memcpy(p.r, r + off, k * sizeof(*r));
        npc_send_packet(&p, 12 + k * (int)sizeof(*r));
        off += k;
    } while (off < n);
}

static void frz_send_frame(int frame, const struct frz_rec *r, int n)
{
    struct frz_pkt p;
    if (n > FRZ_PER_FRAME) n = FRZ_PER_FRAME;
    p.magic = NPC_MAGIC_FRZ; p.frame = frame; p.n = (WORD)n; p.last = 1;
    memcpy(p.r, r, n * sizeof(*r));
    npc_send_packet(&p, 12 + n * (int)sizeof(*r));
}

/* master, KT 0x1000D62E: 0x100B0200(net, frame) builds the frame's command list (step start) */
static void __fastcall hook_read_frame_cmds(void *netp, void *edx, int frame)
{
    static struct npc_cmd sc[NPC_PER_FRAME];
    static struct drv_rec sd[NPC_PER_FRAME];
    static struct frz_rec sz[FRZ_PER_FRAME];
    BYTE *net = (BYTE *)netp;
    struct ft_frame *f;
    static struct tp_rec st[TP_PER_FRAME];
    int nc, nd, nz, nt, cur, stamp;
    o_read_frame_cmds(netp, edx, frame);
    if (!g_net_npc_commands || !net || net[0xDA4] != 1 || strcmp(nw_state_name(), "MASTER") != 0) return;
    g_ft_master_at = GetTickCount();
    cur = *(int *)(net + 0x14);
    stamp = (frame > cur ? frame : cur) + 2;
    if (g_ft_last_stamp >= 0 && (stamp < g_ft_last_stamp - 32 || stamp > g_ft_last_stamp + 4096)) {
        /* the net frame restarted (level restart / next map): 0.29/0.30 kept counting from the old
           level, so every table was stamped ~1000s of frames ahead and no NPC ever got a command */
        plog("[net] frame table: net frame went from %d to %d (new level), stamps restart", g_ft_last_stamp, stamp);
        g_ft_last_stamp = -1;
        EnterCriticalSection(&g_npc_cs);
        {
            int i;
            for (i = 0; i < NPC_RING; i++) {
                g_ft[i].frame = -1;
                g_ft[i].ncmd = g_ft[i].ndrv = g_ft[i].cmd_done = g_ft[i].drv_done = 0;
                g_ft[i].nfz = g_ft[i].fz_done = g_ft[i].ntp = 0;
            }
        }
        LeaveCriticalSection(&g_npc_cs);
    }
    if (stamp <= g_ft_last_stamp) stamp = g_ft_last_stamp + 1;   /* never stamp a frame twice */
    if (g_ft_last_stamp >= 0 && stamp > g_ft_last_stamp + 1 && stamp - g_ft_last_stamp < 64) {
        /* a gap: give the skipped frames empty tables (sent too), so both PCs apply nothing */
        int g;
        for (g = g_ft_last_stamp + 1; g < stamp; g++) {
            EnterCriticalSection(&g_npc_cs);
            f = ft_slot(g); f->cmd_done = f->drv_done = f->fz_done = 1;
            LeaveCriticalSection(&g_npc_cs);
            npc_send_frame(g, sc, 0);
            drv_send_frame(g, sd, 0);
            frz_send_frame(g, sz, 0);
        }
    }
    g_ft_last_stamp = stamp;
    EnterCriticalSection(&g_npc_cs);
    nc = g_npc_new_n; memcpy(sc, g_npc_new, nc * sizeof(sc[0])); g_npc_new_n = 0;
    nd = g_drv_new_n; memcpy(sd, g_drv_new, nd * sizeof(sd[0])); g_drv_new_n = 0;
    nz = g_fz_new_n; memcpy(sz, g_fz_new, nz * sizeof(sz[0])); g_fz_new_n = 0;
    nt = g_tp_new_n; memcpy(st, g_tp_new, nt * sizeof(st[0])); g_tp_new_n = 0;
    f = ft_slot(stamp);
    memcpy(f->z, sz, nz * sizeof(sz[0])); f->nfz = nz; f->fz_done = 1;
    memcpy(f->t, st, nt * sizeof(st[0])); f->ntp = nt;
    memcpy(f->c, sc, nc * sizeof(sc[0])); f->ncmd = nc; f->cmd_done = 1;
    memcpy(f->d, sd, nd * sizeof(sd[0])); f->ndrv = nd; f->drv_done = 1;
    LeaveCriticalSection(&g_npc_cs);
    InterlockedIncrement(&g_ft_frames);
    npc_send_frame(stamp, sc, nc);                    /* always sent, even empty: "frame known" */
    drv_send_frame(stamp, sd, nd);
    frz_send_frame(stamp, sz, nz);
    if (nt) {
        /* a lost teleport would leave the client's player at the spawn point: sent 3 times */
        struct tp_pkt p;
        int k;
        p.magic = NPC_MAGIC_TP; p.frame = stamp; p.n = (WORD)nt; p.last = 1;
        memcpy(p.r, st, nt * sizeof(st[0]));
        for (k = 0; k < 3; k++) npc_send_packet(&p, 12 + nt * (int)sizeof(st[0]));
        plog("[revive] frame %d: %d revive teleport(s) stamped for frame %d (applied there on both PCs)", cur, nt, stamp);
    }
    if (nz) plog("[net] frame %d: %d NPC Freeze change(s) stamped for frame %d (applied there on both PCs)", cur, nz, stamp);
    if (InterlockedIncrement(&g_npc_logged) <= 3)
        plog("[net] step for frame %d (net frame %d): %d NPC commands and %d drive values stamped for frame %d",
             frame, cur, nc, nd, stamp);
    net_report();                                     /* also without game traffic (rate-limited) */
}

/* hook_recvfrom: 1 = the packet was ours (swallowed) */
static int npc_on_packet(SOCKET s, const char *buf, int len, const struct sockaddr *from)
{
    BYTE *net;
    DWORD magic, now;
    int i, free_i = -1, oldest = 0;
    if (len < 4) return 0;
    magic = *(const DWORD *)buf;
    if (magic != NPC_MAGIC_CMD && magic != NPC_MAGIC_DRV && magic != NPC_MAGIC_HELLO && magic != NPC_MAGIC_FRZ &&
        magic != NPC_MAGIC_STATE && magic != NPC_MAGIC_TP && magic != NPC_MAGIC_GIVEUP && magic != NPC_MAGIC_DIFF) return 0;
    if (!g_net_npc_commands || !(net = kt_net())) return 1;
    now = GetTickCount();
    if (magic == NPC_MAGIC_DIFF) {
        if (net[0xDA4] == 0 && len >= 8) InterlockedExchange(&g_diff_rx, *(const LONG *)(buf + 4));
        return 1;
    }
    if (magic == NPC_MAGIC_GIVEUP) {
        char nm[61];
        if (net[0xDA4] != 1 || len < 8) return 1;
        memcpy(nm, buf + 4, len - 4 > 60 ? 60 : len - 4);
        nm[len - 4 > 60 ? 60 : len - 4] = 0;
        rv_giveup_push(nm);
        return 1;
    }
    if (magic == NPC_MAGIC_TP) {
        const struct tp_pkt *p = (const struct tp_pkt *)buf;
        struct ft_frame *f;
        int n = p->n, k;
        if (net[0xDA4] != 0 || n > TP_PER_FRAME || len < 12 + n * (int)sizeof(struct tp_rec)) return 1;
        EnterCriticalSection(&g_npc_cs);
        f = ft_slot(p->frame);
        for (i = 0; i < n; i++) {
            for (k = 0; k < f->ntp && f->t[k].id != p->r[i].id; k++) {}
            if (k == f->ntp && f->ntp < TP_PER_FRAME) f->ntp++;       /* the 3 copies land once */
            if (k < TP_PER_FRAME) f->t[k] = p->r[i];
        }
        LeaveCriticalSection(&g_npc_cs);
        for (i = 0; i < n; i++) rv_client_note(p->r[i].id);
        return 1;
    }
    if (magic == NPC_MAGIC_HELLO) {
        const struct sockaddr_in *a = (const struct sockaddr_in *)from;
        if (net[0xDA4] != 1 || !a || a->sin_family != AF_INET) return 1;
        EnterCriticalSection(&g_npc_cs);
        for (i = 0; i < NPC_PEERS; i++) {
            if (g_npc_peer[i].seen && g_npc_peer[i].addr.sin_addr.s_addr == a->sin_addr.s_addr &&
                g_npc_peer[i].addr.sin_port == a->sin_port) break;
            if (!g_npc_peer[i].seen || now - g_npc_peer[i].seen > 10000) { if (free_i < 0) free_i = i; }
            else if (g_npc_peer[i].seen < g_npc_peer[oldest].seen) oldest = i;
        }
        if (i == NPC_PEERS) {
            i = free_i >= 0 ? free_i : oldest;
            g_npc_peer[i].addr = *a;
            plog("[net] client %u.%u.%u.%u:%u runs the co-op proxy - sending it the NPC frame table",
                 a->sin_addr.S_un.S_un_b.s_b1, a->sin_addr.S_un.S_un_b.s_b2, a->sin_addr.S_un.S_un_b.s_b3,
                 a->sin_addr.S_un.S_un_b.s_b4, (WORD)((a->sin_port >> 8) | (a->sin_port << 8)));
        }
        g_npc_peer[i].s = s;
        g_npc_peer[i].seen = now;
        LeaveCriticalSection(&g_npc_cs);
        InterlockedIncrement(&g_npc_hellos);
        return 1;
    }
    if (net[0xDA4] != 0 || len < 12) return 1;
    if (magic == NPC_MAGIC_STATE) {
        if (g_net_npc_state) ns_on_packet((const BYTE *)buf, len);
        return 1;
    }
    if (magic == NPC_MAGIC_FRZ) {
        const struct frz_pkt *p = (const struct frz_pkt *)buf;
        struct ft_frame *f;
        int n = p->n;
        if (n > FRZ_PER_FRAME || len < 12 + n * (int)sizeof(struct frz_rec)) return 1;
        EnterCriticalSection(&g_npc_cs);
        f = ft_slot(p->frame);
        for (i = 0; i < n && f->nfz < FRZ_PER_FRAME; i++) f->z[f->nfz++] = p->r[i];
        f->fz_done = 1;
        g_npc_rx_at = now;
        LeaveCriticalSection(&g_npc_cs);
        InterlockedExchangeAdd(&g_fz_rx, n);
        return 1;
    }
    if (magic == NPC_MAGIC_CMD) {
        const struct npc_pkt *p = (const struct npc_pkt *)buf;
        struct ft_frame *f;
        int n = p->n;
        if (n > NPC_PER_PACKET || len < 12 + n * (int)sizeof(struct npc_cmd)) return 1;
        EnterCriticalSection(&g_npc_cs);
        f = ft_slot(p->frame);
        for (i = 0; i < n && f->ncmd < NPC_PER_FRAME; i++) f->c[f->ncmd++] = p->c[i];
        if (p->last) f->cmd_done = 1;
        g_npc_rx_at = now;
        LeaveCriticalSection(&g_npc_cs);
        InterlockedExchangeAdd(&g_npc_rx_cmds, n);
        if (p->last) InterlockedIncrement(&g_npc_rx_frames);
    } else {
        const struct drv_pkt *p = (const struct drv_pkt *)buf;
        struct ft_frame *f;
        int n = p->n;
        if (n > DRV_PER_PACKET || len < 12 + n * (int)sizeof(struct drv_rec)) return 1;
        EnterCriticalSection(&g_npc_cs);
        f = ft_slot(p->frame);
        for (i = 0; i < n && f->ndrv < NPC_PER_FRAME; i++) f->d[f->ndrv++] = p->r[i];
        if (p->last) f->drv_done = 1;
        g_npc_rx_at = now;
        LeaveCriticalSection(&g_npc_cs);
        InterlockedExchangeAdd(&g_drv_rx, n);
    }
    return 1;
}

/* hook_sendto (client): remember where the game traffic goes = the master */
static void npc_on_send(SOCKET s, const struct sockaddr *to)
{
    const struct sockaddr_in *a = (const struct sockaddr_in *)to;
    BYTE *net;
    DWORD now, magic = NPC_MAGIC_HELLO;
    if (!g_net_npc_commands || !a || a->sin_family != AF_INET || !(net = kt_net()) || net[0xDA4] != 0) return;
    if (a->sin_addr.s_addr == 0xFFFFFFFFu || a->sin_addr.S_un.S_un_b.s_b4 == 255) return;   /* broadcast */
    g_npc_master_s = s;
    g_npc_master = *a;
    now = GetTickCount();
    if (now - g_npc_hello_at < 2000) return;
    g_npc_hello_at = now;
    o_sendto(s, (const char *)&magic, 4, 0, (const struct sockaddr *)a, sizeof(*a));
}

/*
 * The frame an entity update is simulating (0.32). The master simulates each frame once, at
 * net+0x14. A client (rollback netcode) re-simulates the last confirmed frame N and then predicts
 * N+1, N+2 ... in the same tick while net+0x14 still reads N (0.31 trace: the k-th update of a
 * character under one net+0x14 value matched the host's frame N+k, k = 0..3). 0.29-0.31 looked the
 * NPC frame table up at net+0x14 for every pass, so a predicted step got the previous frame's
 * commands: every NPC command ran in two different steps on the client (2x applied vs received),
 * extra grenades/shots only there and a resync almost every check.
 */
static int sim_frame(BYTE *net, DWORD handle)
{
    static struct { DWORD h; int label, n; } t[1024];
    int label = *(int *)(net + 0x14), i;
    if (net[0xDA4] == 1) return label;
    i = (int)((handle ^ (handle >> 16)) & 1023);
    if (t[i].h != handle || t[i].label != label) { t[i].h = handle; t[i].label = label; t[i].n = 0; }
    else if (t[i].n < 64) t[i].n++;
    if (t_sim_set) InterlockedIncrement(t_sim_frame == label + t[i].n ? &g_simf_agree : &g_simf_differ);
    return label + t[i].n;
}

/*
 * hook_player_update (NPC PLAYER, both PCs): the command the frame table gives this PLAYER in
 * the frame being simulated. Returns 1 if the table is in use (then *out is the command or NULL).
 */
/*
 * 0.47: NPC Freeze through the frame table. The level's trigger scripts wake NPC groups
 * (FreezeAll(group, false), Camp_2.lua ...) on the host only: the host's NPCs started moving at
 * frame X, the client's stayed frozen until the next resync (0.46 checksum diff: Freeze, State,
 * PhysicState, Position of Char_UAN_Camp_2_03_1/2 and their Group's Freeze). A character's Freeze
 * value object is at +0x164 (bound by 0x100075D0); FreezeAll (0x1003D350) sets a member with
 * vfunc 0x40(&byte, 0), get = vfunc 0x1C(&out, 0). All bool values share that vtable.
 * While the frame table runs: on the host a Freeze write to an NPC character from anywhere but the
 * table is held back and stamped (like an AI command) for the table frame; on the client it is
 * dropped (the host's version comes with the table). Both PCs set it in that NPC's PLAYER update
 * of the stamped frame (npc_frame_command) - the same point of the same frame, re-simulation too.
 */
static int g_net_sync_freeze = 1;         /* coop_config.ini [proxy] net_sync_freeze */
typedef char (__fastcall *fn_bool_set)(void *var, void *edx, void *val, DWORD flag);
static fn_bool_set o_bool_set;
static void **g_bool_vt;
static __declspec(thread) int t_fz_apply;
#define FZ_MAP 2048
static struct { void *var; DWORD id; BYTE *ch; } g_fz_map[FZ_MAP];
static int is_human_character(BYTE *ch);

static void frz_map_put(void *var, DWORD id, BYTE *ch)
{
    int i = (int)(((DWORD)var >> 4) & (FZ_MAP - 1)), k;
    for (k = 0; k < 16; k++, i = (i + 1) & (FZ_MAP - 1)) {
        if (g_fz_map[i].var == var || !g_fz_map[i].var) {
            g_fz_map[i].id = id; g_fz_map[i].ch = ch; g_fz_map[i].var = var;
            return;
        }
    }
}

/* 0.48: a resync rebuilds the client's world - every entity and value object is new, and an old
   address can then belong to anything (0.47: the client's own camera / character writes were
   dropped, his view came loose). Only a verified live NPC character's own Freeze counts:
   ch+0x164 is this object, ch+0x1C the id, not a human. Anything else: entry removed, passed on. */
static DWORD frz_map_get(void *var)
{
    int i = (int)(((DWORD)var >> 4) & (FZ_MAP - 1)), k;
    for (k = 0; k < 16; k++, i = (i + 1) & (FZ_MAP - 1)) {
        if (g_fz_map[i].var == var) {
            BYTE *ch = g_fz_map[i].ch;
            DWORD id = g_fz_map[i].id;
            int ok = 0;
            __try {
                ok = ch && *(void **)(ch + 0x164) == var && *(DWORD *)(ch + 0x1C) == id && !is_human_character(ch);
            } __except (EXCEPTION_EXECUTE_HANDLER) {
                ok = 0;
            }
            if (!ok) { g_fz_map[i].ch = NULL; g_fz_map[i].id = 0; return 0; }   /* keep the slot: probe chains */
            return id;
        }
        if (!g_fz_map[i].var) return 0;
    }
    return 0;
}

static void frz_map_clear(const char *why)
{
    memset(g_fz_map, 0, sizeof(g_fz_map));
    if (why) plog("[net] NPC Freeze sync: map cleared (%s)", why);
}

/*
 * 0.66: the client stayed stuck at every champion fight (also without any teleport). The per-entity
 * checksum dumps of 2026-11-15 18:00 showed why: when the champion set-up ran, the host's world set
 * the CLIENT's character's Freeze var to true and never back (the host's own character was not
 * frozen), and the client copies the host's world. Campaign scripts and the solo BOS code only know
 * "the player" (the host), so a freeze that reaches another human player's character is never meant
 * for it. On the host such writes (Freeze = true on a human character that is not the host's own and
 * has been in the world for 5 s) are dropped and logged with the caller. [proxy] guard_player_freeze.
 */
static int g_guard_pfreeze = 1;
static struct { void *var; BYTE *ch; DWORD seen; } g_hfz[8];
static void hfz_note(void *var, BYTE *ch)
{
    int i, k = -1;
    for (i = 0; i < 8; i++) { if (g_hfz[i].var == var) { g_hfz[i].ch = ch; return; } if (!g_hfz[i].var && k < 0) k = i; }
    if (k < 0) { k = 0; for (i = 1; i < 8; i++) if (g_hfz[i].seen < g_hfz[k].seen) k = i; }
    g_hfz[k].var = var; g_hfz[k].ch = ch; g_hfz[k].seen = GetTickCount();
}
static BYTE *hfz_char(void *var, DWORD *seen)
{
    int i;
    for (i = 0; i < 8; i++) if (g_hfz[i].var == var) { *seen = g_hfz[i].seen; return g_hfz[i].ch; }
    return NULL;
}
/* host, every simulation frame: a non-host player character still frozen after 2 s (any route) is unfrozen */
static void hfz_watch(void)
{
    static DWORD since[8];
    BYTE *net = kt_net();
    int i;
    if (!g_guard_pfreeze || !net || net[0xDA4] != 1 || !o_bool_set) return;
    for (i = 0; i < 8; i++) {
        BYTE v[16] = { 0 };
        BYTE *ch = g_hfz[i].ch;
        void *var = g_hfz[i].var;
        if (!var || !ch || (void *)ch == local_character() || GetTickCount() - g_hfz[i].seen < 5000) { since[i] = 0; continue; }
        __try { ((fn_var_get)(*(void ***)var)[0x1C / 4])((BYTE *)var, 0, v, 0); } __except (EXCEPTION_EXECUTE_HANDLER) { g_hfz[i].var = NULL; continue; }
        if (!(v[0] & 1)) { since[i] = 0; continue; }
        if (!since[i]) { since[i] = GetTickCount() | 1; continue; }
        if (GetTickCount() - since[i] > 2000) {
            BYTE f = 0;
            const char *nm = "?";
            __try { o_bool_set(var, 0, &f, 0); nm = entity_name(ch); } __except (EXCEPTION_EXECUTE_HANDLER) {}
            plog("[freeze] host: player character %s was frozen for 2 s - unfrozen", nm ? nm : "?");
            since[i] = 0;
        }
    }
}

static char __fastcall hook_bool_set(void *var, void *edx, void *val, DWORD flag)
{
    BYTE *net;
    DWORD id;
    if (g_guard_pfreeze && !t_fz_apply) {
        DWORD seen = 0;
        BYTE *ch = hfz_char(var, &seen);
        if (ch && (net = kt_net()) && net[0xDA4] == 1 && (void *)ch != local_character() && GetTickCount() - seen > 5000) {
            BYTE v = 0;
            __try { v = *(BYTE *)val; } __except (EXCEPTION_EXECUTE_HANDLER) { v = 0; }
            if (v & 1) {
                static int n;
                if (n++ < 40) {
                    char a[64], b[64];
                    DWORD *fp = (DWORD *)_AddressOfReturnAddress();
                    const char *nm = "?";
                    addr_name((DWORD)_ReturnAddress(), a, sizeof(a));
                    __try { addr_name(fp[4], b, sizeof(b)); nm = entity_name(ch); } __except (EXCEPTION_EXECUTE_HANDLER) { strcpy(b, "?"); }
                    plog("[freeze] host: Freeze on player character %s blocked (other players are never frozen) - from %s / %s", nm ? nm : "?", a, b);
                }
                return 1;
            }
        }
    }
    if (t_fz_apply || !g_net_sync_freeze || !(id = frz_map_get(var)) || !(net = kt_net()) || !ft_active(net))
        return o_bool_set(var, edx, val, flag);
    if (net[0xDA4] == 1) {
        BYTE v = 0;
        __try { v = *(BYTE *)val; } __except (EXCEPTION_EXECUTE_HANDLER) { return o_bool_set(var, edx, val, flag); }
        EnterCriticalSection(&g_npc_cs);
        {
            int i;
            for (i = 0; i < g_fz_new_n; i++) if (g_fz_new[i].id == id) break;   /* last write wins */
            if (i < FRZ_PER_FRAME) { g_fz_new[i].id = id; g_fz_new[i].v = v & 1; if (i == g_fz_new_n) g_fz_new_n++; }
        }
        LeaveCriticalSection(&g_npc_cs);
        InterlockedIncrement(&g_fz_queued);
    } else {
        InterlockedIncrement(&g_fz_dropped);
    }
    return 1;
}

/* every NPC PLAYER update: remember which bool value object is that character's Freeze */
static void frz_register(BYTE *ch)
{
    void *var, **vt;
    if (!g_net_sync_freeze) return;
    __try {
        var = *(void **)(ch + 0x164);
        if (!var) return;
        vt = *(void ***)var;
        if (!g_bool_vt) {
            void *slot = vt[0x40 / 4];
            void *hook = (void *)hook_bool_set;
            if (!write_code(&vt[0x40 / 4], &hook, sizeof(hook))) { g_net_sync_freeze = 0; return; }
            o_bool_set = (fn_bool_set)slot;
            g_bool_vt = vt;
            plog("[net] NPC Freeze sync on: bool value vtable %p slot 16 hooked (was %p)", (void *)vt, slot);
        } else if (vt != g_bool_vt) {
            return;                                   /* not the bool class (should not happen) */
        }
        if (!is_human_character(ch)) frz_map_put(var, *(DWORD *)(ch + 0x1C), ch);
        else hfz_note(var, ch);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
    }
}

/* both PCs, in the NPC's PLAYER update of `frame`: set the Freeze value the table has for it */
static void frz_apply(BYTE *ch, int frame)
{
    struct ft_frame *f;
    DWORD id = *(DWORD *)(ch + 0x1C);
    int i, have = 0;
    BYTE v = 0;
    if (!g_net_sync_freeze || !o_bool_set) return;
    EnterCriticalSection(&g_npc_cs);
    f = ft_get(frame);
    if (f && f->fz_done) {
        for (i = 0; i < f->nfz; i++) {
            if (f->z[i].id == id) { v = (BYTE)f->z[i].v; have = 1; }
        }
    } else {
        InterlockedIncrement(&g_fz_missing);
    }
    LeaveCriticalSection(&g_npc_cs);
    if (!have) return;
    t_fz_apply = 1;
    __try { o_bool_set(*(void **)(ch + 0x164), 0, &v, 0); } __except (EXCEPTION_EXECUTE_HANDLER) {}
    t_fz_apply = 0;
    InterlockedIncrement(&g_fz_applied);
}

static void frz_report(void)
{
    LONG q = InterlockedExchange(&g_fz_queued, 0), d = InterlockedExchange(&g_fz_dropped, 0),
         a = InterlockedExchange(&g_fz_applied, 0), r = InterlockedExchange(&g_fz_rx, 0);
    InterlockedExchange(&g_fz_missing, 0);
    if (q || d || a || r)
        plog("[net] last 10 s NPC Freeze sync: %ld writes held for the table (host), %ld local writes dropped (client), "
             "%ld received, %ld applied in their frame", q, d, r, a);
}

static int npc_frame_command(BYTE *player, DWORD *buf11, DWORD **out)
{
    BYTE *net = kt_net();
    struct ft_frame *f;
    int frame, i, found = 0;
    DWORD id;
    if (!ft_active(net)) return 0;
    id = *(DWORD *)(player + 0x1C);
    frame = sim_frame(net, id);
    *out = NULL;
    __try {
        BYTE *ch = (BYTE *)((DWORD (__fastcall *)(BYTE *, void *))VA(0x10058D00))(player, 0);
        if (ch) frz_apply(ch, frame);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
    }
    EnterCriticalSection(&g_npc_cs);
    f = ft_get(frame);
    if (!f || !f->cmd_done) {
        found = -1;
    } else {
        for (i = 0; i < f->ncmd; i++) {
            const struct npc_cmd *c = &f->c[i];
            if (c->id != id) continue;
            memset(buf11, 0, 11 * sizeof(DWORD));
            buf11[6] = c->a18; buf11[7] = c->a1c; buf11[8] = c->b20; buf11[9] = c->b24; buf11[10] = c->id;
            *out = buf11;
            found = 1;
            break;
        }
    }
    LeaveCriticalSection(&g_npc_cs);
    if (found < 0) InterlockedIncrement(&g_npc_missing);
    return 1;
}

/* per-frame trace of every character at the drive step (same point of the same frame on both PCs) */
/* coop_logs\<base>_host.txt / _client.txt; one file per role per run (a client may host first) */
static FILE *coop_role_file(FILE **files, BYTE *net, const char *base, const char *header)
{
    int role = net[0xDA4] == 1 ? 0 : 1;
    if (!files[role]) {
        char dir[MAX_PATH], path[MAX_PATH], *slash;
        GetModuleFileNameA(NULL, dir, sizeof(dir));
        slash = strrchr(dir, '\\');
        if (slash) slash[1] = 0;
        _snprintf(path, sizeof(path), "%scoop_logs\\%s_%s.txt", dir, base, role ? "client" : "host");
        path[sizeof(path) - 1] = 0;
        files[role] = fopen(path, "w");
        if (!files[role]) return NULL;
        fprintf(files[role], "# %s %s\n", COOPMOD_VERSION, header);
        plog("[net] writing %s", path);
    }
    return files[role];
}

static int coop_mp_session(void)
{
    const char *st = nw_state_name();
    return strcmp(st, "MASTER") == 0 || strcmp(st, "SLAVE") == 0;
}

/* per-frame trace of every character at the drive step (same point of the same frame on both PCs) */
static FILE *g_trace_f[2];
static int g_trace_lines;

static void trace_char(BYTE *net, BYTE *ch, int frame, int human, int ai, int have)
{
    float p[3] = { 0 };
    FILE *f;
    if (!g_net_trace || g_trace_lines >= 60000 || frame <= 0 || (frame & 255) >= 4 || !coop_mp_session()) return;
    f = coop_role_file(g_trace_f, net, "trace",
                       "frame handle human ai table x y z flags1C0 cur13C cur140 speed5C8 cc cd name");
    if (!f) return;
    {
        static int last;
        if (frame != last) { fflush(f); last = frame; }
    }
    entity_position(ch, p);
    fprintf(f, "%d %08X %d %d %d %.3f %.3f %.3f %08X %08X %08X %.4f %d %d %s\n", frame, *(DWORD *)(ch + 0x1C),
            human, ai, have, p[0], p[1], p[2], *(DWORD *)(ch + 0x1C0), *(DWORD *)(ch + 0x13C), *(DWORD *)(ch + 0x140),
            *(float *)(ch + 0x5C8), ch[0x5CC], ch[0x5CD], entity_name(ch));
    g_trace_lines++;
}

/*
 * World-state checksum contributions (net_csum=1). The client's desync check (KT 0x100B0A50)
 * compares the host's checksum for a frame with its own (0x100D9810 -> stored when the frame's
 * world state is made, 0x100DE9C0 -> exporter 0x100E3250). The exporter's checksum (+0x0C) is a
 * plain sum: 0x100E3180 exports each networked entity with 0x100E2FB0 (record: +0x1C handle,
 * +0x1E type), which calls one of ten var exporters per checksummed var (0x100E2640... all
 * thiscall, 3 stack args), each adding its var's part. Every 64th frame both PCs log, per entity,
 * its handle, type, total part and the part of every var (var names once per type), the first
 * time that frame's world state is made. tools\csumdiff.py names what differs.
 */
static int g_net_csum = 1;               /* [proxy] net_csum (logging) */
/*
 * [proxy] net_csum_physics=0 (default): the continuous physics vars of SINGLE_RIGID_BODY props
 * (entity type 0: Position, Rotation, MatrixRow0-2, Linear/AngularVelocity, WakeUpCounter) are
 * left out of the world-state checksum on both PCs. 0.30's logs: every sampled frame, all
 * 144 props of COOP_Patrol_2 differed in exactly these vars (resting bodies jitter by ~0.001
 * differently on each PC; the physics engine's contact/sleep state is not in the world state, so
 * a resync cannot make them agree) while characters matched - each mismatch was a full resync
 * that snapped the client's player = the rubber-banding. Their State/Health/gas vars still count.
 */
static int g_net_csum_physics = 0;
static __declspec(thread) int t_cs_type = -1;   /* type of the entity being exported, this thread */
/*
 * 0.67: entity types that only the host's mission scripts and AI change. 0.66 session csum dumps
 * (client site 0 = its confirmed frame): 9 of 51 sampled frames differed, and apart from the join
 * and the champion set-up all of them were such types - mission timers (type 40 CurrentValue: the
 * client's copy runs 3 frames behind the host's restart), the AI's throw-grenade retry (type 7),
 * objectives (43), the champion fight (42), the cut-scene cameras (48/49), AI orders (11-24, one
 * only on the host), a rocket (32). Each was a whole-world resync (~100 KB, 150-190 ms stop).
 * Classified by var names (the registry order is fixed, but names say what a type is):
 *   CS_PUSH   - out of the checksum; numeric vars sent from the host every frame (CMS1, like NPCs)
 *   CS_HOST   - out of the checksum only (AI profiles/orders, cut-scene cameras - never pushed:
 *               the camera vars' change handlers are what took the client's view before)
 *   CS_PROJ   - projectiles (FiredByWeapon), with the bullets rule
 */
#define CS_TYPES 512
enum { CS_UNKNOWN = 0, CS_NORMAL, CS_PUSH, CS_HOST, CS_PROJ };
static BYTE g_cs_tclass[CS_TYPES];
static int g_net_csum_script = 0;        /* [proxy] net_csum_script (1 = check those types again) */
static int g_net_script_state = 1;       /* [proxy] net_script_state (0 = do not push timers/objectives/fight) */
static volatile LONG g_cs_script_skipped;
static __declspec(thread) int t_cs_cls;
static int cs_type_class(int type);
static struct { void *desc; int skip; } g_cs_vcache[64];
static volatile LONG g_cs_skipped;
static FILE *g_cs_f[2];
static FILE *g_cs_cur;
static int g_cs_last[2][2] = { { -1, -1 }, { -1, -1 } }, g_cs_samples[2], g_cs_site;
static DWORD g_cs_tid;
static BYTE g_cs_named[2][4096];          /* types whose var names this file already has */
static char g_cs_vals[8192], g_cs_names[8192];
static int g_cs_vlen, g_cs_nlen, g_cs_naming;

typedef int (__fastcall *fn_ws_build)(void *t, void *edx, void *a1, void *a2, void *a3, DWORD a4, DWORD a5, void *a6);
typedef void (__fastcall *fn_cs_entity)(void *t, void *edx, DWORD *rec, void *ws);
typedef void (__fastcall *fn_cs_var)(void *t, void *edx, void *a, void *b, void *c);
static fn_ws_build o_ws_build;
static fn_cs_entity o_cs_entity;

static int __fastcall hook_ws_build(void *t, void *edx, void *a1, void *a2, void *a3, DWORD a4, DWORD a5, void *a6)
{
    BYTE *net = kt_net();
    int frame, role, r, on = 0;
    __try {
        static volatile LONG seen;
        frame = (int)a3;                         /* 0x100DE9C0 passes its frame here */
        if (InterlockedIncrement(&seen) <= 4 || (g_cs_site && seen < 40))
            plog("[net] world state made (site %d): frame %d, net frame %d, state %s", g_cs_site, frame,
                 net ? *(int *)(net + 0x14) : -1, nw_state_name());
        if (g_net_csum && net && frame > 0 && (frame & 63) == 0 && !g_cs_cur && coop_mp_session()) {
            role = net[0xDA4] == 1 ? 0 : 1;
            if (frame < g_cs_last[role][g_cs_site] - 256) g_cs_last[role][g_cs_site] = -1;   /* new level */
            if (frame > g_cs_last[role][g_cs_site] && g_cs_samples[role] < 160) {
                g_cs_cur = coop_role_file(g_cs_f, net, "csum",
                                          "F frame site / T type varnames / E handle type part varparts / S total");
                if (g_cs_cur) {
                    g_cs_last[role][g_cs_site] = frame;
                    g_cs_samples[role]++;
                    g_cs_tid = GetCurrentThreadId();
                    fprintf(g_cs_cur, "F %d %d\n", frame, g_cs_site);
                    on = 1;
                }
            }
        }
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        g_net_csum = 0;
    }
    r = o_ws_build(t, edx, a1, a2, a3, a4, a5, a6);
    if (on) {
        fprintf(g_cs_cur, "S %08X\n", *(DWORD *)((BYTE *)t + 0xC));
        fflush(g_cs_cur);
        g_cs_cur = NULL;
    }
    return r;
}

/* 0x100DED0E: the other world-state build (0x100DEC70) */
static int __fastcall hook_ws_build2(void *t, void *edx, void *a1, void *a2, void *a3, DWORD a4, DWORD a5, void *a6)
{
    int r;
    g_cs_site = 1;
    r = hook_ws_build(t, edx, a1, a2, a3, a4, a5, a6);
    g_cs_site = 0;
    return r;
}

static void __fastcall hook_cs_entity(void *t, void *edx, DWORD *rec, void *ws)
{
    DWORD before, type;
    int role, prev = t_cs_type;
    type = *(WORD *)((BYTE *)rec + 0x1E) & 0x7FFF;
    t_cs_npc = 0;
    t_cs_cls = cs_type_class((int)type);
    if (type == 5 && !g_net_csum_npcs && g_net_npc_state) {
        __try { t_cs_npc = !is_human_character((BYTE *)rec); } __except (EXCEPTION_EXECUTE_HANDLER) { t_cs_npc = 0; }
    }
    if (!g_cs_cur || GetCurrentThreadId() != g_cs_tid) {
        t_cs_type = (int)type;
        o_cs_entity(t, edx, rec, ws);
        t_cs_type = prev; t_cs_cls = 0;
        t_cs_npc = 0;
        return;
    }
    role = kt_net()[0xDA4] == 1 ? 0 : 1;
    g_cs_vlen = g_cs_nlen = 0;
    g_cs_vals[0] = g_cs_names[0] = 0;
    g_cs_naming = type < 4096 * 8 && !(g_cs_named[role][type >> 3] & (1 << (type & 7)));
    before = *(DWORD *)((BYTE *)t + 0xC);
    t_cs_type = (int)type;
    o_cs_entity(t, edx, rec, ws);
    t_cs_type = prev; t_cs_cls = 0;
    t_cs_npc = 0;
    if (g_cs_naming) {
        g_cs_named[role][type >> 3] |= (BYTE)(1 << (type & 7));
        fprintf(g_cs_cur, "T %lu %s\n", type, g_cs_names);
    }
    g_cs_naming = 0;
    fprintf(g_cs_cur, "E %08X %lu %08X %s\n", rec[7], type, *(DWORD *)((BYTE *)t + 0xC) - before, g_cs_vals);
}

/* 1 = this var of a type-0 entity stays out of the checksum (see g_net_csum_physics) */
static int cs_skip_var(void *desc)
{
    static const char *const phys[] = { "Position", "Rotation", "MatrixRow0", "MatrixRow1", "MatrixRow2",
                                        "LinearVelocity", "AngularVelocity", "WakeUpCounter" };
    int i, h = (int)(((DWORD)desc >> 4) & 63), skip = 0;
    if (g_cs_vcache[h].desc == desc) return g_cs_vcache[h].skip;
    __try {
        struct vc71_string *s = (struct vc71_string *)desc;
        const char *n = s->res >= 16 ? s->bx.ptr : s->bx.buf;
        if (n && !IsBadStringPtrA(n, 64))
            for (i = 0; i < (int)(sizeof(phys) / sizeof(phys[0])); i++)
                if (strcmp(n, phys[i]) == 0) skip = 1;
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        skip = 0;
    }
    g_cs_vcache[h].skip = skip;
    g_cs_vcache[h].desc = desc;
    return skip;
}

/* 0.37: bullets (type 31) and projectiles (type 30) in flight are left out of the checksum too.
   The 0.36 tests (no AI at all, no AI agents on humans) changed nothing: the remaining differences
   were almost only type 31 Position/Direction (10 of 16 sampled frames identical, props equal).
   A bullet lives under a second; what it does on impact (Health, hit points, ...) is still checked. */
static int g_net_csum_bullets = 0;       /* coop_config.ini [proxy] net_csum_bullets */
static volatile LONG g_cs_bullet_skipped;
/* 0.47: also out of the check: props' gas-leak point and attribution (GazLocalPosition/Normal,
   GazShooter, LastShooter - where a bullet hit a gas canister, cosmetic; Health stays), and a
   Group's own Freeze flag (type 6; its members' Freeze is synced through the frame table). */
static struct { void *desc; int kind; } g_cs_vcache2[256];
static int cs_var_kind(void *desc)
{
    static const char *const cos[] = { "GazLocalPosition", "GazLocalNormal", "GazShooter", "LastShooter" };
    int i, h = (int)(((DWORD)desc >> 4) & 255), kind = 0;
    if (g_cs_vcache2[h].desc == desc) return g_cs_vcache2[h].kind;
    __try {
        struct vc71_string *st = (struct vc71_string *)desc;
        const char *n = st->res >= 16 ? st->bx.ptr : st->bx.buf;
        if (n && !IsBadStringPtrA(n, 64)) {
            for (i = 0; i < (int)(sizeof(cos) / sizeof(cos[0])); i++) if (strcmp(n, cos[i]) == 0) kind = 1;
            if (strcmp(n, "Freeze") == 0) kind = 2;
        }
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        kind = 0;
    }
    g_cs_vcache2[h].kind = kind;
    g_cs_vcache2[h].desc = desc;
    return kind;
}
static int g_net_csum_cosmetic = 0;      /* coop_config.ini [proxy] net_csum_cosmetic (1 = check them again) */

static void cs_var_part(void *t, DWORD before, void *desc)
{
    if (!g_net_csum_cosmetic && (t_cs_type == 0 || t_cs_type == 6)) {
        int k = cs_var_kind(desc);
        if ((t_cs_type == 0 && k == 1) || (t_cs_type == 6 && k == 2)) {
            *(DWORD *)((BYTE *)t + 0xC) = before;
            InterlockedIncrement(&g_cs_skipped);
        }
    }
    if (t_cs_npc) {
        *(DWORD *)((BYTE *)t + 0xC) = before;         /* 0.62: NPC characters come from the host every frame */
        InterlockedIncrement(&g_cs_npc_skipped);
    } else if (!g_net_csum_script && (t_cs_cls == CS_PUSH || t_cs_cls == CS_HOST)) {
        *(DWORD *)((BYTE *)t + 0xC) = before;         /* 0.67: host scripts / AI only */
        InterlockedIncrement(&g_cs_script_skipped);
    } else if (!g_net_csum_bullets && (t_cs_type == 31 || t_cs_type == 30 || t_cs_type == 39 || t_cs_cls == CS_PROJ)) {
        *(DWORD *)((BYTE *)t + 0xC) = before;
        InterlockedIncrement(&g_cs_bullet_skipped);
    } else if (!g_net_csum_physics && t_cs_type == 0 && cs_skip_var(desc)) {
        *(DWORD *)((BYTE *)t + 0xC) = before;         /* same on both PCs: both run this proxy */
        InterlockedIncrement(&g_cs_skipped);
    }
    if (!g_cs_cur || GetCurrentThreadId() != g_cs_tid) return;
    if (g_cs_vlen < (int)sizeof(g_cs_vals) - 12)
        g_cs_vlen += _snprintf(g_cs_vals + g_cs_vlen, sizeof(g_cs_vals) - g_cs_vlen, "%X,",
                               *(DWORD *)((BYTE *)t + 0xC) - before);
    if (g_cs_naming && g_cs_nlen < (int)sizeof(g_cs_names) - 70) {
        const char *n = "?";
        __try {
            struct vc71_string *s = (struct vc71_string *)desc;
            n = s->res >= 16 ? s->bx.ptr : s->bx.buf;
            if (!n || IsBadStringPtrA(n, 64)) n = "?";
            g_cs_nlen += _snprintf(g_cs_names + g_cs_nlen, sizeof(g_cs_names) - g_cs_nlen, "%.60s,", n);
        } __except (EXCEPTION_EXECUTE_HANDLER) {
        }
    }
}

#define CS_VAR_HOOK(i)                                                                        \
    static fn_cs_var o_cs_var##i;                                                             \
    static void __fastcall hook_cs_var##i(void *t, void *edx, void *a, void *b, void *c)      \
    {                                                                                         \
        DWORD before = *(DWORD *)((BYTE *)t + 0xC);                                           \
        o_cs_var##i(t, edx, a, b, c);                                                         \
        cs_var_part(t, before, b);                                                            \
    }
CS_VAR_HOOK(0) CS_VAR_HOOK(1) CS_VAR_HOOK(2) CS_VAR_HOOK(3) CS_VAR_HOOK(4)
CS_VAR_HOOK(5) CS_VAR_HOOK(6) CS_VAR_HOOK(7) CS_VAR_HOOK(8) CS_VAR_HOOK(9)

static void install_csum_hooks(void)
{
    static const DWORD site[10] = { 0x100E3095, 0x100E30A6, 0x100E30B4, 0x100E30C2, 0x100E30D0,
                                    0x100E30E4, 0x100E30F2, 0x100E3100, 0x100E310E, 0x100E311C };
    static const DWORD target[10] = { 0x100E2640, 0x100E26E0, 0x100E27A0, 0x100E2850, 0x100E2A10,
                                      0x100E2EB0, 0x100E2F30, 0x100E2C50, 0x100E2CE0, 0x100E2E30 };
    void *hooks[10] = { (void *)hook_cs_var0, (void *)hook_cs_var1, (void *)hook_cs_var2, (void *)hook_cs_var3,
                        (void *)hook_cs_var4, (void *)hook_cs_var5, (void *)hook_cs_var6, (void *)hook_cs_var7,
                        (void *)hook_cs_var8, (void *)hook_cs_var9 };
    fn_cs_var *orig[10] = { &o_cs_var0, &o_cs_var1, &o_cs_var2, &o_cs_var3, &o_cs_var4,
                            &o_cs_var5, &o_cs_var6, &o_cs_var7, &o_cs_var8, &o_cs_var9 };
    int i;
    char name[32];
    if (!g_net_csum && g_net_csum_physics) {
        plog("[hook] net_csum                   off (net_csum=0, net_csum_physics=1)");
        return;
    }
    if (!g_net_csum_physics) plog("[net] checksum leaves out the rigid bodies' physics vars (net_csum_physics=0)");
    for (i = 0; i < 10; i++) {
        _snprintf(name, sizeof(name), "net_csum_var#%d", i);
        name[sizeof(name) - 1] = 0;
        *orig[i] = (fn_cs_var)hook_kt_call_site(name, site[i], target[i], hooks[i]);
        if (!*orig[i]) { g_net_csum = 0; g_net_csum_physics = 1; return; }   /* never half-installed */
    }
    o_cs_entity = (fn_cs_entity)hook_kt_call_site("net_csum_entity", 0x100E31FB, 0x100E2FB0, (void *)hook_cs_entity);
    if (!o_cs_entity) { g_net_csum = 0; g_net_csum_physics = 1; return; }
    o_ws_build = (fn_ws_build)hook_kt_call_site("net_csum_ws_make", 0x100DEAC4, 0x100E3250, (void *)hook_ws_build);
    if (!o_ws_build) { g_net_csum = 0; return; }
    hook_kt_call_site("net_csum_ws_make#2", 0x100DED0E, 0x100E3250, (void *)hook_ws_build2);
}

/*
 * Character update, call 0x1001405E -> 0x10005200 (thiscall, no args): AI gait/speed.
 * Master: runs the original for NPCs only to capture what it produces (and +0x5CD the agent set
 * since the last update), then puts the old values back. Both: apply the frame table's values
 * (or the "no agent" ones: +0x5C8 0, +0x5CC 1, +0x5CD 0, gait bits untouched); humans always
 * get those. The AI flag for 0x1001406A is left in g_drv_last_*.
 */
static fn_this o_ai_drive;
static BYTE *g_drv_last_ch;
static int g_drv_last_ai;

static void __fastcall hook_ai_drive(BYTE *ch)
{
    BYTE *net = kt_net();
    struct ft_frame *f;
    struct drv_rec r, got;
    int master, human, frame, i, have = 0, found = 0, ai = 0;
    DWORD id;
    g_drv_last_ch = NULL;
    if (!g_net_npc_drive || !ft_active(net)) {
        o_ai_drive(ch);
        return;
    }
    master = net[0xDA4] == 1;
    frame = sim_frame(net, *(DWORD *)(ch + 0x1C));
    t_pass_set = 1; t_pass_frame = frame; t_pass_label = *(int *)(net + 0x14);
    __try {
        human = is_human_character(ch);
        id = *(DWORD *)(ch + 0x1C);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        o_ai_drive(ch);
        return;
    }
    if (master && !human) {
        DWORD bits0 = *(DWORD *)(ch + 0x1C0), after;
        float sp0 = *(float *)(ch + 0x5C8);
        BYTE cc0 = ch[0x5CC];
        r.cd = ch[0x5CD];
        *(DWORD *)(ch + 0x1C0) = bits0 | 0x18;   /* both set: no AI gait gives that */
        t_rng_priv_fwd(1);                       /* host-only: must not move the shared random sequence */
        o_ai_drive(ch);
        t_rng_priv_fwd(-1);
        after = *(DWORD *)(ch + 0x1C0);
        r.id = id;
        r.speed = *(float *)(ch + 0x5C8);
        r.cc = ch[0x5CC];
        r.gait = (BYTE)(after & 0x18);
        r.flags = (BYTE)(((after & 0x18) != 0x18 ? DRV_GAIT_SET : 0) | (*(void **)(ch + 0x58) ? DRV_AGENT : 0));
        if (!(r.flags & DRV_GAIT_SET)) r.gait = (BYTE)(bits0 & 0x18);
        *(DWORD *)(ch + 0x1C0) = (after & ~0x18u) | (bits0 & 0x18u);
        *(float *)(ch + 0x5C8) = sp0;
        ch[0x5CC] = cc0;
        if (r.flags || r.cd || r.speed != 0.0f || r.cc != 1) {
            EnterCriticalSection(&g_npc_cs);
            if (g_drv_new_n < NPC_PER_FRAME) g_drv_new[g_drv_new_n++] = r;
            else InterlockedIncrement(&g_npc_overflow);
            LeaveCriticalSection(&g_npc_cs);
            InterlockedIncrement(&g_drv_captured);
        }
    }
    if (!human) {
        EnterCriticalSection(&g_npc_cs);
        f = ft_get(frame);
        if (f && f->drv_done) {
            have = 1;
            for (i = 0; i < f->ndrv; i++)
                if (f->d[i].id == id) { got = f->d[i]; found = 1; break; }
        }
        LeaveCriticalSection(&g_npc_cs);
        if (!have) InterlockedIncrement(&g_drv_missing);
    } else {
        InterlockedIncrement(&g_drv_human);
    }
    if (found) {
        if (got.flags & DRV_GAIT_SET) *(DWORD *)(ch + 0x1C0) = (*(DWORD *)(ch + 0x1C0) & ~0x18u) | (got.gait & 0x18u);
        *(float *)(ch + 0x5C8) = got.speed;
        ch[0x5CC] = got.cc;
        ch[0x5CD] = got.cd;
        ai = (got.flags & DRV_AGENT) != 0;
        InterlockedIncrement(&g_drv_applied);
    } else {
        *(float *)(ch + 0x5C8) = 0.0f;
        ch[0x5CC] = 1;
        ch[0x5CD] = 0;
    }
    g_drv_last_ch = ch;
    g_drv_last_ai = ai;
    trace_char(net, ch, frame, human, ai, have);
}

/* 0x1001406A: "mov eax,[ebp+58h]; test eax,eax" (then je = not AI) -> call stub_is_ai */
static int __cdecl drive_is_ai(BYTE *ch)
{
    if (ch == g_drv_last_ch) return g_drv_last_ai;
    return *(void **)(ch + 0x58) != NULL;
}

static __declspec(naked) void stub_is_ai(void)
{
    __asm {
        push ebp
        call drive_is_ai
        add esp, 4
        test eax, eax
        ret
    }
}

static void install_drive_hooks(void)
{
    static const BYTE expect[] = { 0x8B, 0x45, 0x58, 0x85, 0xC0, 0x74, 0x20 };
    BYTE call[5];
    if (!g_net_npc_drive) {
        plog("[hook] npc_drive                  off (net_npc_drive=0)");
        return;
    }
    o_ai_drive = (fn_this)hook_call_site("npc_drive", 0x1001405E, 0x10005200, (void *)hook_ai_drive);
    if (!o_ai_drive) { g_net_npc_drive = 0; return; }
    call[0] = 0xE8;
    *(INT32 *)(call + 1) = (INT32)((BYTE *)stub_is_ai - (VA(0x1001406A) + 5));
    if (!patch_code("npc_drive_ai_flag", 0x1001406A, expect, sizeof(expect), 0x1001406A, call, sizeof(call)))
        plog("[hook] npc_drive: AI flag not patched - movement rules may still differ between PCs");
}

/*
 * 0.62: NPC state from the host (net_npc_state=1) + NPC characters out of the checksum (net_csum_npcs=0).
 *
 * 0.61 session (2026-11-13, csum logs of both PCs): still 1-3 resyncs per 10 s, ~93 KB each. Of 25
 * mismatched sampled frames almost all were NPC characters in fights (Position, MoveAccuracy,
 * Velocity, hit points), a few the humans. Commands, drive values, random numbers and Freeze already
 * reach the client per frame; what is left is how a fight plays out (which bullet hits what) - and
 * one hit's difference grows until the next resync rebuilds the whole world.
 *
 * Engine facts (KT): a networked entity's state is its VAR objects (entity +0x18 -> vector of VAR*,
 * descriptors from the type registry *(0x10185360)+4 [type]: std::string name at +0, flags +0x78
 * (bit 2 = not networked), kind +0x64). VAR: +4 kind, +0xC element count, +0x10 changed flag, +0x14 data.
 * The world-state import the rollback and the resync use (0x100E7E30 -> 0x100E78A0...) does nothing
 * more than copy each element raw into +0x14 and, if it differed, call vfunc 0x94 (= set +0x10 to 1).
 * Element sizes: kinds 0,1,8,9 4 bytes; 2 1 byte; 3 12 bytes (stride 16, w untouched); 4 16 bytes.
 * Between two client steps the client's world is the confirmed state of its last frame F (0x100B3E50
 * restores it after the prediction passes); the step for F+1 starts with net frame F+1
 * (net vfunc 0 at the top of the step) and builds that frame's commands at 0x1000D68A (0x100B2230).
 *
 * So: the host, at the end of its step for frame F (0x1000D7F3, just before 0x100B00D0 sends the
 * frame), copies the networked vars of every NPC character that changed (plus 1/16 of the others,
 * round robin) and sends them ("CMS1", frame F). The client, at 0x1000D68A of its step F+1, writes
 * those values into its NPCs exactly the way the engine's own import does. Frame F+1 then starts from
 * the host's NPCs, so the drift of one frame never adds up. Since what is left is at most one frame's
 * worth, both PCs also leave NPC characters' vars out of the world checksum (humans still count).
 */
static int g_net_npc_state = 1;           /* [proxy] net_npc_state (declared above) */
#define NS_MAXVARS 128
#define NS_PKT 1200
#define NS_RING 8
#define NS_FRAMEBUF 65536
#define NS_SLOTS 12
#define NS_MAP 2048
static volatile LONG g_ns_ents_sent, g_ns_bytes_sent, g_ns_pkts_sent, g_ns_frames_sent,
                     g_ns_rx_pkts, g_ns_rx_ents, g_ns_applied_frames, g_ns_ents_fixed, g_ns_vars_fixed,
                     g_ns_missing, g_ns_late, g_ns_no_entity, g_ns_bad, g_ns_logged,
                     g_ns_script_sent, g_ns_script_fixed;
static struct { WORD type; int n, pos; signed char ok[NS_MAXVARS]; char hashed[NS_MAXVARS]; } g_ns_layout[NS_SLOTS];
static struct { DWORD h; DWORD hash; } g_ns_sent[4096];
static struct ns_rx { int frame, len; BYTE buf[NS_FRAMEBUF]; } g_ns_rx[NS_RING];
static float g_ns_pos_err_max;
static char g_ns_worst[64];

static const char *ns_desc_name(BYTE *desc)
{
    struct vc71_string *s = (struct vc71_string *)desc;
    const char *n = s->res >= 16 ? s->bx.ptr : s->bx.buf;
    return (n && !IsBadStringPtrA(n, 64)) ? n : "?";
}

/* descriptor vector of an entity type (0x10015580 on the registry 0x10001B80 makes) */
static BYTE **ns_descs(WORD type, int *n)
{
    BYTE *reg = *(BYTE **)KVA(0x10185360), *td;
    *n = 0;
    if (!reg) return NULL;
    td = (*(BYTE ***)(reg + 4))[type];
    if (!td || !*(BYTE ***)(td + 4)) return NULL;
    *n = (int)(*(BYTE ***)(td + 8) - *(BYTE ***)(td + 4));
    return *(BYTE ***)(td + 4);
}

/* 0.67: see CS_PUSH above. Names from the 0.66 dumps (type numbers there in brackets). */
static int g_cs_push_types[16], g_cs_push_n;
static int cs_type_class(int type)
{
    static const char *const push[] = { "TriggerFunction" /* timer 40 */, "Sub-Objectives" /* objective 43 */,
                                        "PreparationDuration" /* champion fight 42 */, "Linked Door" /* door 54 */ };
    static const char *const host[] = { "PreviousCamMode" /* 49 */, "ScriptedExpiration" /* AI orders 11-24 */,
                                        "ThrowGrenadeRetryTime" /* AI profile 7 */, "ExoLife" /* exo AI profile 8 */,
                                        "CombatTurtle" /* group AI 9 */ };
    BYTE **d;
    int n = 0, i, k, c = CS_NORMAL, fov = 0;
    if (type < 0 || type >= CS_TYPES) return CS_NORMAL;
    if (g_cs_tclass[type]) return g_cs_tclass[type];
    __try {
        d = ns_descs((WORD)type, &n);
        for (i = 0; d && i < n && i < NS_MAXVARS; i++) {
            const char *nm = ns_desc_name(d[i]);
            if (!strcmp(nm, "FiredByWeapon") && c == CS_NORMAL) c = CS_PROJ;
            if (!strcmp(nm, "FOV")) fov = 1;
            for (k = 0; k < (int)(sizeof(push) / sizeof(push[0])); k++) if (!strcmp(nm, push[k])) c = CS_PUSH;
            for (k = 0; k < (int)(sizeof(host) / sizeof(host[0])); k++) if (!strcmp(nm, host[k])) c = CS_HOST;
        }
        if (fov && n <= 6 && c == CS_NORMAL) c = CS_HOST;     /* CAMPOINT (48): Position, Rotation, FOV (+ unnetworked) */
        if (n == 1 && d && !strcmp(ns_desc_name(d[0]), "Order")) c = CS_HOST;   /* AI order list (10) */
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        c = CS_NORMAL;
    }
    if (!n) return CS_NORMAL;                                   /* registry not ready - ask again later */
    g_cs_tclass[type] = (BYTE)c;
    if (c == CS_PUSH && g_cs_push_n < (int)(sizeof(g_cs_push_types) / sizeof(g_cs_push_types[0])))
        g_cs_push_types[g_cs_push_n++] = type;
    if (c != CS_NORMAL)
        plog("[net] entity type %d (%d vars, first %s): %s", type, n, n ? ns_desc_name(ns_descs((WORD)type, &k)[0]) : "-",
             c == CS_PUSH ? (g_net_csum_script ? "checked; host state sent each frame" : "out of the checksum; host state sent each frame")
             : c == CS_HOST ? (g_net_csum_script ? "checked (host scripts/AI only)" : "out of the checksum (host scripts/AI only)")
             : (g_net_csum_bullets ? "projectile, checked" : "projectile, out of the checksum"));
    return c;
}

/* both PCs, once per level start or so: classify every registered type (fills g_cs_push_types) */
static void cs_classify_all(void)
{
    BYTE *reg = *(BYTE **)KVA(0x10185360);
    int n, i;
    static int done;
    if (done || !reg) return;
    __try {
        n = (int)(*(BYTE ***)(reg + 8) - *(BYTE ***)(reg + 4));
        if (n <= 0 || n > CS_TYPES) return;
        for (i = 0; i < n; i++) if ((*(BYTE ***)(reg + 4))[i]) cs_type_class(i);
        done = 1;
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        done = 1;
    }
}

/* which vars of this type travel (1), which also count for "changed" (hashed) */
/* 0.67d: key = entity type, | NS_HUMAN for the human players' characters (only g_ns_human_vars travel:
   their State flags - stance / special-action bits - came out different on the client and nothing
   corrected them, so each one ended in a full resync; position and movement stay client-simulated) */
#define NS_HUMAN 0x8000
static int g_net_human_state = 1;          /* [proxy] net_human_state */
static volatile LONG g_ns_human_sent, g_ns_human_fixed;
static int ns_layout(WORD key)
{
    static const char *const human[] = { "State", "MoveAccuracy", "WeaponAccuracy", "EffectAccFlash", "EffectAccHallu",
                                         "EffectAccFire", "EffectAccAcid", "ShakeAcc",
                                         "SpecialAction", "SpecialActionTimer" };   /* 0.70: + these two */
    WORD type = (WORD)(key & 0x7FFF);
    static const char *const skip[] = { "Freeze", "Player", "CharacterAI", "CharacterOrderList", "ExoskeletonAI",
                                        "ExoskeletonOrderList", "Arsenal", "Name", "Team" };
    static const char *const unhashed[] = { "MainTime", "Timer", "Timer2", "Timer3", "Timer4", "SpecialActionTimer",
                                            "FallTime", "ShakeAcc", "MoveAccuracy", "WeaponAccuracy",
                                            "CurrentValue" };   /* 0.67: a running timer is sent 1/16 frames */
    int i, k, n, slot = -1;
    BYTE **d;
    for (i = 0; i < NS_SLOTS; i++) if (g_ns_layout[i].n && g_ns_layout[i].type == key) return i;
    for (i = 0; i < NS_SLOTS; i++) if (!g_ns_layout[i].n) { slot = i; break; }
    if (slot < 0 || !(d = ns_descs(type, &n)) || n <= 0 || n > NS_MAXVARS) return -1;
    for (i = 0; i < n; i++) {
        short kind = *(short *)(d[i] + 0x64);
        const char *nm = ns_desc_name(d[i]);
        int ok = !(d[i][0x78] & 2) && (kind == 0 || kind == 1 || kind == 2 || kind == 3 || kind == 4 || kind == 8 || kind == 9);
        for (k = 0; ok && k < (int)(sizeof(skip) / sizeof(skip[0])); k++) if (!strcmp(nm, skip[k])) ok = 0;
        if (key & NS_HUMAN) {
            int in = 0;
            for (k = 0; k < (int)(sizeof(human) / sizeof(human[0])); k++) if (!strcmp(nm, human[k])) in = 1;
            ok = ok && in;
        }
        g_ns_layout[slot].ok[i] = (signed char)ok;
        g_ns_layout[slot].hashed[i] = (char)ok;
        for (k = 0; ok && k < (int)(sizeof(unhashed) / sizeof(unhashed[0])); k++) if (!strcmp(nm, unhashed[k])) g_ns_layout[slot].hashed[i] = 0;
    }
    g_ns_layout[slot].pos = -1;
    for (i = 0; i < n; i++) if (g_ns_layout[slot].ok[i] && !strcmp(ns_desc_name(d[i]), "Position")) g_ns_layout[slot].pos = i;
    if (key & NS_HUMAN) g_ns_layout[slot].pos = -1;
    g_ns_layout[slot].type = key;
    g_ns_layout[slot].n = n;
    {
        char names[1024]; int len = 0;
        names[0] = 0;
        for (i = 0; i < n && len < (int)sizeof(names) - 40; i++)
            if (g_ns_layout[slot].ok[i]) len += _snprintf(names + len, sizeof(names) - len, "%s,", ns_desc_name(d[i]));
        plog("[nstate] type %u%s: %d vars, sent: %s", type, (key & NS_HUMAN) ? " (human players)" : "", n, names);
    }
    return slot;
}

static int ns_esize(int kind) { return kind == 2 ? 1 : kind == 3 ? 12 : kind == 4 ? 16 : 4; }
static int ns_stride(int kind) { return kind == 2 ? 1 : (kind == 3 || kind == 4) ? 16 : 4; }

/* serialize ent's travelling vars into out (count byte + elements per var); returns bytes, -1 = no fit */
static int ns_pack(BYTE *ent, int slot, BYTE *out, int cap, DWORD *hash)
{
    BYTE *vl = *(BYTE **)(ent + 0x18), **v, **ve;
    int i, len = 0, e;
    DWORD h = 2166136261u;
    if (!vl) return -1;
    v = *(BYTE ***)(vl + 4); ve = *(BYTE ***)(vl + 8);
    if (!v || ve - v != g_ns_layout[slot].n) return -1;
    for (i = 0; i < g_ns_layout[slot].n; i++) {
        BYTE *var = v[i], *data;
        int kind, cnt, es, st;
        if (!g_ns_layout[slot].ok[i]) continue;
        kind = *(int *)(var + 4); cnt = *(int *)(var + 0xC); data = *(BYTE **)(var + 0x14);
        if (cnt < 0 || cnt > 64 || !data) cnt = 0;
        es = ns_esize(kind); st = ns_stride(kind);
        if (len + 1 + cnt * es > cap) return -1;
        out[len++] = (BYTE)cnt;
        for (e = 0; e < cnt; e++) {
            memcpy(out + len, data + e * st, es);
            if (g_ns_layout[slot].hashed[i]) { int b; for (b = 0; b < es; b++) h = (h ^ out[len + b]) * 16777619u; }
            len += es;
        }
    }
    *hash = h;
    return len;
}

struct ns_ctx { int frame; BYTE pkt[NS_PKT]; int plen, nrec, ents; };

static void ns_flush(struct ns_ctx *c, int last)
{
    if (!c->nrec && !last) return;
    *(DWORD *)c->pkt = NPC_MAGIC_STATE;
    *(int *)(c->pkt + 4) = c->frame;
    *(WORD *)(c->pkt + 8) = (WORD)c->nrec;
    *(WORD *)(c->pkt + 10) = (WORD)last;
    npc_send_packet(c->pkt, c->plen);
    InterlockedIncrement(&g_ns_pkts_sent);
    InterlockedExchangeAdd(&g_ns_bytes_sent, c->plen);
    c->plen = 12; c->nrec = 0;
}

static void ns_capture_one(BYTE *e, void *ctx)
{
    struct ns_ctx *c = (struct ns_ctx *)ctx;
    BYTE rec[NS_PKT];
    DWORD h, id, hash;
    int slot, len, i;
    __try {
        WORD key;
        id = *(DWORD *)(e + 0x1C);
        key = (WORD)((id >> 16) & 0x7FFF);
        if (key == 5 && is_human_character(e)) {
            if (!g_net_human_state) return;
            key |= NS_HUMAN;
        }
        if ((slot = ns_layout(key)) < 0) return;
        len = ns_pack(e, slot, rec + 8, sizeof(rec) - 8 - 12, &hash);
        if (len < 0) { InterlockedIncrement(&g_ns_bad); return; }
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        InterlockedIncrement(&g_ns_bad);
        return;
    }
    i = (int)((id ^ (id >> 13)) & 4095);
    h = id;
    if (g_ns_sent[i].h == h && g_ns_sent[i].hash == hash && ((id ^ c->frame) & 15) != 0) return;   /* unchanged */
    g_ns_sent[i].h = h; g_ns_sent[i].hash = hash;
    *(DWORD *)rec = id;
    *(WORD *)(rec + 4) = (WORD)len;
    *(WORD *)(rec + 6) = (WORD)(g_ns_layout[slot].n | (g_ns_layout[slot].type & NS_HUMAN));
    if (g_ns_layout[slot].type & NS_HUMAN) InterlockedIncrement(&g_ns_human_sent);
    if (c->plen + 8 + len > NS_PKT) ns_flush(c, 0);
    memcpy(c->pkt + c->plen, rec, 8 + len);
    c->plen += 8 + len;
    c->nrec++;
    c->ents++;
}

/* master, 0x1000D7F3: the frame (net+0x14) is simulated and captured; the engine sends it next */
typedef void (__fastcall *fn_net_this)(void *net, void *edx);
static fn_net_this o_frame_send;
static void __fastcall hook_frame_send(void *netp, void *edx)
{
    BYTE *net = (BYTE *)netp;
    if (g_net_npc_state && net && net[0xDA4] == 1 && ft_active(net)) {
        static struct ns_ctx c;
        BYTE *iface = *(BYTE **)VA(VA_ENGINE_IFACE);
        c.frame = *(int *)(net + 0x14);
        c.plen = 12; c.nrec = 0; c.ents = 0;
        if (iface) {
            __try { for_each_entity(iface, 5, 1, ns_capture_one, &c); } __except (EXCEPTION_EXECUTE_HANDLER) {}
            if (g_net_script_state) {                    /* 0.67: mission timers, objectives, champion fight */
                int k;
                cs_classify_all();
                for (k = 0; k < g_cs_push_n; k++) {
                    int before = c.ents;
                    __try { for_each_entity(iface, (DWORD)g_cs_push_types[k], 1, ns_capture_one, &c); } __except (EXCEPTION_EXECUTE_HANDLER) {}
                    InterlockedExchangeAdd(&g_ns_script_sent, c.ents - before);
                }
            }
            ns_flush(&c, 1);
            InterlockedExchangeAdd(&g_ns_ents_sent, c.ents);
            InterlockedIncrement(&g_ns_frames_sent);
            if (InterlockedIncrement(&g_ns_logged) <= 3)
                plog("[nstate] host: frame %d, %d NPC character(s) sent", c.frame, c.ents);
        }
    }
    o_frame_send(netp, edx);
}

/* hook_recvfrom (client) */
static void ns_on_packet(const BYTE *buf, int len)
{
    int frame, n, i, off = 12;
    struct ns_rx *r;
    if (len < 12) return;
    frame = *(const int *)(buf + 4);
    n = *(const WORD *)(buf + 8);
    InterlockedIncrement(&g_ns_rx_pkts);
    EnterCriticalSection(&g_npc_cs);
    r = &g_ns_rx[frame & (NS_RING - 1)];
    if (r->frame != frame) { r->frame = frame; r->len = 0; }
    for (i = 0; i < n && off + 8 <= len; i++) {
        int rl = 8 + *(const WORD *)(buf + off + 4);
        if (off + rl > len || r->len + rl > NS_FRAMEBUF) break;
        memcpy(r->buf + r->len, buf + off, rl);
        r->len += rl; off += rl;
        InterlockedIncrement(&g_ns_rx_ents);
    }
    LeaveCriticalSection(&g_npc_cs);
}

static BYTE *g_ns_map_e[NS_MAP];
static DWORD g_ns_map_id[NS_MAP];
static void ns_map_cb(BYTE *e, void *ctx)
{
    DWORD id = *(DWORD *)(e + 0x1C);
    int i = (int)((id ^ (id >> 11)) & (NS_MAP - 1)), k;
    for (k = 0; k < NS_MAP; k++, i = (i + 1) & (NS_MAP - 1))
        if (!g_ns_map_e[i]) { g_ns_map_e[i] = e; g_ns_map_id[i] = id; return; }
}
static BYTE *ns_map_get(DWORD id)
{
    int i = (int)((id ^ (id >> 11)) & (NS_MAP - 1)), k;
    for (k = 0; k < NS_MAP && g_ns_map_e[i]; k++, i = (i + 1) & (NS_MAP - 1))
        if (g_ns_map_id[i] == id) return g_ns_map_e[i];
    return NULL;
}

/* write one record into the client's entity the way the engine's import does; returns vars changed */
static int ns_apply_one(BYTE *e, const BYTE *data, int len, int nvars)
{
    BYTE *vl = *(BYTE **)(e + 0x18), **v, **ve;
    int slot, i, off = 0, changed = 0, el;
    DWORD id = *(DWORD *)(e + 0x1C);
    WORD key = (WORD)(((id >> 16) & 0x7FFF) | (nvars & NS_HUMAN));
    nvars &= 0x7FFF;
    if (!vl || (slot = ns_layout(key)) < 0 || g_ns_layout[slot].n != nvars) return -1;
    v = *(BYTE ***)(vl + 4); ve = *(BYTE ***)(vl + 8);
    if (!v || ve - v != nvars) return -1;
    for (i = 0; i < nvars; i++) {
        BYTE *var = v[i], *dst;
        int kind, cnt, es, st, hc, diff = 0;
        if (!g_ns_layout[slot].ok[i]) continue;
        if (off >= len) return -1;
        hc = data[off++];
        kind = *(int *)(var + 4); cnt = *(int *)(var + 0xC); dst = *(BYTE **)(var + 0x14);
        es = ns_esize(kind); st = ns_stride(kind);
        if (off + hc * es > len) return -1;
        if (hc == cnt && dst) {
            for (el = 0; el < cnt; el++) {
                if (memcmp(dst + el * st, data + off + el * es, es) != 0) {
                    if (i == g_ns_layout[slot].pos) {
                        const float *a = (const float *)(dst + el * st), *b = (const float *)(data + off + el * es);
                        float dx = a[0] - b[0], dy = a[1] - b[1], dz = a[2] - b[2], d2 = dx * dx + dy * dy + dz * dz;
                        if (d2 > g_ns_pos_err_max * g_ns_pos_err_max) {
                            g_ns_pos_err_max = (float)sqrt(d2);
                            _snprintf(g_ns_worst, sizeof(g_ns_worst), "%s", entity_name(e));
                            g_ns_worst[sizeof(g_ns_worst) - 1] = 0;
                        }
                    }
                    memcpy(dst + el * st, data + off + el * es, es);
                    diff = 1;
                }
            }
            if (diff) { var[0x10] = 1; changed++; }       /* vfunc 0x94 of every VAR class */
        }
        off += hc * es;
    }
    return changed;
}

/* client, 0x1000D68A: the step for net frame F+1 starts from the confirmed world of frame F */
typedef DWORD (__fastcall *fn_net_frame)(void *net, void *edx, int frame);
static fn_net_frame o_frame_cmds_client;
static DWORD __fastcall hook_frame_cmds_client(void *netp, void *edx, int frame)
{
    BYTE *net = (BYTE *)netp;
    if (g_net_npc_state && net && net[0xDA4] == 0 && g_npc_rx_at && GetTickCount() - g_npc_rx_at < 5000) {
        static BYTE buf[NS_FRAMEBUF];
        int want = *(int *)(net + 0x14) - 1, len = 0, off = 0, have = 0, newest = -1, i;
        EnterCriticalSection(&g_npc_cs);
        for (i = 0; i < NS_RING; i++) if (g_ns_rx[i].frame > newest) newest = g_ns_rx[i].frame;
        if (g_ns_rx[want & (NS_RING - 1)].frame == want) {
            len = g_ns_rx[want & (NS_RING - 1)].len;
            memcpy(buf, g_ns_rx[want & (NS_RING - 1)].buf, len);
            have = 1;
        }
        LeaveCriticalSection(&g_npc_cs);
        if (!have) {
            InterlockedIncrement(newest >= 0 && newest < want ? &g_ns_late : &g_ns_missing);
        } else {
            BYTE *iface = *(BYTE **)VA(VA_ENGINE_IFACE);
            memset(g_ns_map_e, 0, sizeof(g_ns_map_e));
            if (iface) { __try { for_each_entity(iface, 5, 1, ns_map_cb, NULL); } __except (EXCEPTION_EXECUTE_HANDLER) {} }
            if (iface && g_net_script_state) {
                int k;
                cs_classify_all();
                for (k = 0; k < g_cs_push_n; k++)
                    __try { for_each_entity(iface, (DWORD)g_cs_push_types[k], 1, ns_map_cb, NULL); } __except (EXCEPTION_EXECUTE_HANDLER) {}
            }
            while (off + 8 <= len) {
                DWORD id = *(DWORD *)(buf + off);
                int rl = *(WORD *)(buf + off + 4), nv = *(WORD *)(buf + off + 6), c;
                BYTE *e = ns_map_get(id);
                if (!e) InterlockedIncrement(&g_ns_no_entity);
                else {
                    __try {
                        int ty = (int)((id >> 16) & 0x7FFF);
                        if (ty == 5 && (nv & NS_HUMAN)) {
                            c = g_net_human_state ? ns_apply_one(e, buf + off + 8, rl, nv) : 0;
                            if (c > 0) InterlockedIncrement(&g_ns_human_fixed);
                        } else if (ty == 5) c = is_human_character(e) ? 0 : ns_apply_one(e, buf + off + 8, rl, nv);
                        else if (g_net_script_state && cs_type_class(ty) == CS_PUSH) {
                            c = ns_apply_one(e, buf + off + 8, rl, nv);
                            if (c > 0) InterlockedIncrement(&g_ns_script_fixed);
                        } else c = 0;
                    } __except (EXCEPTION_EXECUTE_HANDLER) { c = -1; }
                    if (c < 0) InterlockedIncrement(&g_ns_bad);
                    else if (c > 0) { InterlockedIncrement(&g_ns_ents_fixed); InterlockedExchangeAdd(&g_ns_vars_fixed, c); }
                }
                off += 8 + rl;
            }
            InterlockedIncrement(&g_ns_applied_frames);
            if (InterlockedIncrement(&g_ns_logged) <= 3)
                plog("[nstate] client: host's NPC state of frame %d written before frame %d (%d bytes)", want, want + 1, len);
        }
    }
    return o_frame_cmds_client(netp, edx, frame);
}

static void ns_report(void)
{
    BYTE *net = kt_net();
    LONG es = InterlockedExchange(&g_ns_ents_sent, 0), bs = InterlockedExchange(&g_ns_bytes_sent, 0),
         ps = InterlockedExchange(&g_ns_pkts_sent, 0), fs = InterlockedExchange(&g_ns_frames_sent, 0),
         rp = InterlockedExchange(&g_ns_rx_pkts, 0), re = InterlockedExchange(&g_ns_rx_ents, 0),
         af = InterlockedExchange(&g_ns_applied_frames, 0), ef = InterlockedExchange(&g_ns_ents_fixed, 0),
         vf = InterlockedExchange(&g_ns_vars_fixed, 0), mi = InterlockedExchange(&g_ns_missing, 0),
         la = InterlockedExchange(&g_ns_late, 0), ne = InterlockedExchange(&g_ns_no_entity, 0),
         bd = InterlockedExchange(&g_ns_bad, 0), ck = InterlockedExchange(&g_cs_npc_skipped, 0);
    float pe = g_ns_pos_err_max;
    g_ns_pos_err_max = 0.0f;
    if (!net) return;
    if (net[0xDA4] == 1 && (fs || bd))
        plog("[nstate] last 10 s (host): %ld frames, %ld NPC records in %ld packets (%ld KB/s)%s", fs, es, ps, bs / 10240,
             bd ? " - SOME NPCs COULD NOT BE READ" : "");
    else if (net[0xDA4] == 0 && (rp || af || mi || la))
        plog("[nstate] last 10 s (client): %ld packets / %ld NPC records received; written in %ld frames: %ld NPCs differed "
             "(%ld vars, worst Position error %.2f m: %s); %ld frames without the host's state (%ld arrived too late), "
             "%ld records for NPCs not here, %ld unreadable", rp, re, af, ef, vf, pe, pe > 0 ? g_ns_worst : "-", mi + la, la, ne, bd);
    if (ck) plog("[net] last 10 s: %ld NPC character vars left out of the world checksum (net_csum_npcs=0)", ck);
    { LONG ss = InterlockedExchange(&g_ns_script_sent, 0), sf = InterlockedExchange(&g_ns_script_fixed, 0),
           sk = InterlockedExchange(&g_cs_script_skipped, 0);
      if (ss) plog("[nstate] last 10 s (host): %ld timer/objective/fight/door records sent", ss);
      { LONG hs = InterlockedExchange(&g_ns_human_sent, 0), hf = InterlockedExchange(&g_ns_human_fixed, 0);
        if (hs) plog("[nstate] last 10 s (host): %ld player State records sent", hs);
        if (hf) plog("[nstate] last 10 s (client): %ld player State records corrected from the host", hf); }
      if (sf) plog("[nstate] last 10 s (client): %ld timer/objective/fight/door records corrected from the host", sf);
      if (sk) plog("[net] last 10 s: %ld script/AI-only vars left out of the world checksum (net_csum_script=0)", sk); }
}

static void install_npc_state_hooks(void)
{
    if (!g_net_npc_state) {
        plog("[hook] npc_state                  off (net_npc_state=0)");
        return;
    }
    o_frame_send = (fn_net_this)hook_kt_call_site("net_npc_state_send", 0x1000D7F3, 0x100B00D0, (void *)hook_frame_send);
    o_frame_cmds_client = (fn_net_frame)hook_kt_call_site("net_npc_state_apply", 0x1000D68A, 0x100B2230, (void *)hook_frame_cmds_client);
    if (!o_frame_send || !o_frame_cmds_client) g_net_npc_state = 0;
}

static void net_report(void)
{
    LONG now = (LONG)GetTickCount(), at = g_net_report_at;
    LONG tx, txp, rx, rxp, calls, fail, rc, rp, rd, rsum, rmax;
    if (at == 0) { InterlockedCompareExchange(&g_net_report_at, now + 10000, 0); return; }
    if (now - at < 0) return;
    if (InterlockedCompareExchange(&g_net_report_at, now + 10000, at) != at) return;
    tx = InterlockedExchange(&g_net_tx_bytes, 0); txp = InterlockedExchange(&g_net_tx_pkts, 0);
    rx = InterlockedExchange(&g_net_rx_bytes, 0); rxp = InterlockedExchange(&g_net_rx_pkts, 0);
    calls = InterlockedExchange(&g_net_calls, 0); fail = InterlockedExchange(&g_net_fail, 0);
    if (tx || rx)
        plog("[net] last 10 s (%s): sent %ld KB/s in %ld datagrams/s, received %ld KB/s in %ld datagrams/s, "
             "%ld connection sends/s%s", nw_state_name(), tx / 10240, txp / 10, rx / 10240, rxp / 10, calls / 10,
             fail ? " - SOME SENDS FAILED (socket buffer full?)" : "");
    { LONG mp = InterlockedExchange(&g_pass_max_pkts, 0), mb = InterlockedExchange(&g_pass_max_bytes, 0), bg = InterlockedExchange(&g_pass_big, 0);
      LONG mm = InterlockedExchange(&g_pass_max_ms, 0);
      if (mp >= 10) plog("[net] last 10 s: largest send pass %ld datagrams / %ld KB; %ld passes with 10 or more datagrams; longest big pass %ld ms", mp, mb / 1024, bg, mm); }
    rc = InterlockedExchange(&g_rs_checksum, 0); rp = InterlockedExchange(&g_rs_predict, 0);
    rd = InterlockedExchange(&g_rs_done, 0); rsum = InterlockedExchange(&g_rs_ms_sum, 0);
    rmax = InterlockedExchange(&g_rs_ms_max, 0);
    if (rc || rp || rd)
        plog("[net] last 10 s: %ld resyncs asked (%ld world differs from the host, %ld too far ahead), "
             "%ld received, request->received avg %ld ms, max %ld ms", rc + rp, rc, rp, rd, rd ? rsum / rd : 0, rmax);
    { LONG n = InterlockedExchange(&g_rs_n, 0), b = InterlockedExchange(&g_rs_sum_bytes, 0), k = InterlockedExchange(&g_rs_sum_pkts, 0),
           f = InterlockedExchange(&g_rs_sum_first, 0), mb = InterlockedExchange(&g_rs_max_bytes, 0), mg = InterlockedExchange(&g_rs_max_big, 0),
           la = InterlockedExchange(&g_rs_sum_last, 0), tt = InterlockedExchange(&g_rs_sum_total, 0), fb = InterlockedExchange(&g_rs_sum_fbig, 0);
      if (n) plog("[net] last 10 s resync cost: %ld resync(s), received while pending avg %ld KB in %ld datagrams (max %ld KB, "
                  "largest datagram %ld bytes); after the ask: any datagram %ld ms, first big (>1000 B) %ld ms, last big %ld ms, applied %ld ms",
                  n, b / n / 1024, k / n, mb / 1024, mg, f / n, fb / n, la / n, tt / n); }
    { LONG hd = InterlockedExchange(&g_mm_hidden, 0), he = InterlockedExchange(&g_mm_healed, 0), ps = InterlockedExchange(&g_mm_passed, 0);
      int mx = g_mm_run_max; g_mm_run_max = 0;
      if (hd || he || ps)
          plog("[net] last 10 s patience: %ld checks differed and waited, %ld differences went away by themselves (no resync), "
               "%ld lasted over %d frames -> resync; longest run %d frames", hd, he, ps, g_net_resync_patience, mx); }
    { LONG h = InterlockedExchange(&g_rs_held, 0);
      if (h) plog("[net] last 10 s: %ld client checks skipped (less than %d s since the last resync, net_resync_gap)", h, g_net_resync_gap); }
    {
        LONG sk = InterlockedExchange(&g_cs_skipped, 0);
        if (sk) plog("[net] last 10 s: %ld rigid-body physics vars left out of the world checksum", sk);
        { LONG bk = InterlockedExchange(&g_cs_bullet_skipped, 0); if (bk) plog("[net] last 10 s: %ld bullet/projectile vars left out of the world checksum", bk); }
    }
    rng_report();
    seed_report();
    frz_report();
    ns_report();
    {
        LONG sent = InterlockedExchange(&g_npc_cmd_sent, 0), pk = InterlockedExchange(&g_npc_pkt_sent, 0);
        LONG app = InterlockedExchange(&g_npc_cmd_applied, 0), rxc = InterlockedExchange(&g_npc_rx_cmds, 0);
        LONG rxf = InterlockedExchange(&g_npc_rx_frames, 0), miss = InterlockedExchange(&g_npc_missing, 0);
        LONG hel = InterlockedExchange(&g_npc_hellos, 0), ovf = InterlockedExchange(&g_npc_overflow, 0);
        LONG dc = InterlockedExchange(&g_drv_captured, 0), da = InterlockedExchange(&g_drv_applied, 0);
        LONG dm = InterlockedExchange(&g_drv_missing, 0), drx = InterlockedExchange(&g_drv_rx, 0);
        LONG dh = InterlockedExchange(&g_drv_human, 0), ff = InterlockedExchange(&g_ft_frames, 0);
        BYTE *net = kt_net();
        if (net && net[0xDA4] == 1)
            plog("[net] last 10 s NPC frame table (host): %ld frames stamped, %ld commands decided by the AI, "
                 "%ld AI drive values captured, sent in %ld packets; applied here: %ld commands, %ld drive values "
                 "(%ld human character updates kept off the AI rules, %ld NPC updates without a table), "
                 "%ld hellos from clients%s", ff, sent, dc, pk, app, da, dh, dm + miss, hel,
                 ovf ? " - QUEUE OVERFLOW" : "");
        else if (net && net[0xDA4] == 0)
            plog("[net] last 10 s NPC frame table (client): %ld frames / %ld commands / %ld drive values received from "
                 "the host; applied: %ld commands, %ld drive values (%ld human character updates); %ld NPC PLAYER "
                 "and %ld character updates in frames the host's table had not arrived for%s", rxf, rxc, drx, app, da,
                 dh, miss, dm, g_npc_rx_at ? "" : " - NOTHING RECEIVED (host on an older version?)");
    }
}

static void net_set_buffers(SOCKET s, const char *why)
{
    int v = g_net_sockbuf, got = 0, n = sizeof(got);
    if (!p_setsockopt || g_net_sockbuf <= 0 || s == INVALID_SOCKET) return;
    p_setsockopt(s, SOL_SOCKET, SO_RCVBUF, (const char *)&v, sizeof(v));
    p_setsockopt(s, SOL_SOCKET, SO_SNDBUF, (const char *)&v, sizeof(v));
    if (p_getsockopt) p_getsockopt(s, SOL_SOCKET, SO_RCVBUF, (char *)&got, &n);
    plog("[net] %s UDP socket: send/receive buffers set to %d KB (receive buffer now %d KB)", why, v >> 10, got >> 10);
}

static SOCKET WINAPI hook_socket(int af, int type, int proto)
{
    SOCKET s = o_socket(af, type, proto);
    if (type == SOCK_DGRAM) net_set_buffers(s, "game");
    return s;
}

static int WINAPI hook_sendto(SOCKET s, const char *buf, int len, int flags, const struct sockaddr *to, int tolen)
{
    int r = o_sendto(s, buf, len, flags, to, tolen);
    if (r > 0) { InterlockedExchangeAdd(&g_net_tx_bytes, r); InterlockedIncrement(&g_net_tx_pkts); }
    else if (r < 0) InterlockedIncrement(&g_net_fail);
    if (r > 0 && to) npc_on_send(s, to);
    net_report();
    return r;
}

static int WINAPI hook_recvfrom(SOCKET s, char *buf, int len, int flags, struct sockaddr *from, int *fromlen)
{
    int r = o_recvfrom(s, buf, len, flags, from, fromlen);
    if (r > 0) { InterlockedExchangeAdd(&g_net_rx_bytes, r); InterlockedIncrement(&g_net_rx_pkts); }
    if (r > 0 && g_rs_asked_at) {
        InterlockedExchangeAdd(&g_rs_win_bytes, r);
        InterlockedIncrement(&g_rs_win_pkts);
        if (r > g_rs_win_big) g_rs_win_big = r;
        if (g_rs_win_first < 0) g_rs_win_first = (LONG)(GetTickCount() - g_rs_asked_at);
        if (r > 1000) { g_rs_win_last = (LONG)(GetTickCount() - g_rs_asked_at);   /* big datagrams = the resync burst */
                        if (g_rs_win_fbig < 0) g_rs_win_fbig = g_rs_win_last; }
    }
    if (r > 0 && !(flags & MSG_PEEK) && npc_on_packet(s, buf, r, from)) {
        /* ours: hide it from the engine (its select + recvfrom loops skip a -1) */
        if (p_wsasetlasterror) p_wsasetlasterror(WSAEWOULDBLOCK);
        return -1;
    }
    return r;
}

/* 0.42: datagrams per send pass (resyncs: 96 KB in ~81 datagrams over ~4 host ticks, 0.40/0.41 sessions) */
static char __fastcall hook_send_all(void *self, void *edx, void *a, void *b)
{
    LONG p0 = g_net_tx_pkts, b0 = g_net_tx_bytes, dp, db;
    char r;
    InterlockedIncrement(&g_net_calls);
    DWORD t0 = GetTickCount();
    r = o_send_all(self, edx, a, b);
    dp = g_net_tx_pkts - p0; db = g_net_tx_bytes - b0;
    if (dp >= 10) { LONG ms = (LONG)(GetTickCount() - t0); if (ms > g_pass_max_ms) g_pass_max_ms = ms; }
    if (dp > g_pass_max_pkts) g_pass_max_pkts = dp;
    if (db > g_pass_max_bytes) g_pass_max_bytes = db;
    if (dp >= 10) InterlockedIncrement(&g_pass_big);
    return r;
}

/* "jmp [slot]" (FF 25) or "call [slot]" (FF 15) at va: replace the import slot it uses */
static void *net_hook_import(const char *name, DWORD va, BYTE op2, void *hook)
{
    BYTE *p = KVA(va);
    void **slot, *orig;
    if (p[0] != 0xFF || p[1] != op2) {
        plog("[hook] %-26s at %08X: unexpected bytes %02X %02X - NOT installed", name, va, p[0], p[1]);
        return NULL;
    }
    slot = *(void ***)(p + 2);
    orig = *slot;
    if (!orig || !write_code(slot, &hook, sizeof(hook))) {
        plog("[hook] %-26s import slot %p: not writable - NOT installed", name, (void *)slot);
        return NULL;
    }
    plog("[hook] %-26s import slot %p -> ok", name, (void *)slot);
    return orig;
}

static void net_patch_imm(const char *name, DWORD va, const BYTE *expect, int n, int imm_off, int value)
{
    BYTE buf[16], *p = KVA(va);
    char found[64];
    if (value <= 0) { plog("[hook] %-26s off (config)", name); return; }
    if (memcmp(p, expect, n) != 0) {
        hexbytes(p, n, found);
        plog("[hook] %-26s at %08X: unexpected bytes %s - NOT patched", name, va, found);
        return;
    }
    memcpy(buf, expect, n);
    memcpy(buf + imm_off, &value, 4);
    if (write_code(p, buf, n)) plog("[hook] %-26s at %08X -> %d per send (engine %d)", name, va, value, *(int *)(expect + imm_off));
}

/* ------------------------------------------------------------------------ */
/* admin commands (chat + host hotkeys)                                      */
/* ------------------------------------------------------------------------ */
/*
 * Every chat line reaches the master's chat distribution KT 0x10101520 (thiscall: sender, owner,
 * team, std::string *text, flag; ret 14h): the host's own lines from 0x101030E6, a client's from
 * the master's chat-message handler 0x1010532F ("!!!Master : a slave chats"). Lines starting with
 * '/' or '!' are queued here (the line is still shown to everyone) and run on the game thread at
 * the next simulation update as Lua in the level's script state (the game's Lua has no string
 * library, so the proxy parses). The world change reaches the clients like any mission-script
 * teleport: the next checksum mismatch resyncs them. Replies ("[admin] ..." PrintDebug lines) go
 * back into the chat as a line from the command's sender.
 * [proxy] admin=1 (0 = off), admin_clients=1 (0 = only the host's own lines are obeyed),
 * admin_hotkeys=1 (host: Ctrl+F9 bring all, Ctrl+F10 go to the other player, Ctrl+F11 heal+ammo
 * all, Ctrl+F12 god mode on/off), admin_test=cmd;cmd (run 10 s after the mission starts, tests).
 */
static int g_admin = 1, g_admin_clients = 1, g_admin_hotkeys = 1;
static char g_admin_test[256];

typedef int (__fastcall *fn_chat)(void *t, void *edx, DWORD sender, DWORD owner, DWORD team,
                                  struct vc71_string *text, DWORD flag);
static fn_chat o_chat;                      /* KT 0x10101520 */
struct admin_ctx { void *t; DWORD sender, owner, team, flag; int valid; };
struct admin_req { char text[200]; char who[64]; int host; struct admin_ctx ctx; };
#define ADMIN_Q 16
static struct admin_req g_admin_q[ADMIN_Q];
static int g_admin_qn;
static volatile LONG g_admin_lock;
static struct admin_ctx g_admin_last;       /* the host's last chat line: where hotkey replies go */
static char g_admin_reply[6][200];
static int g_admin_nreply, g_admin_capture;
static DWORD g_admin_test_at;

static void admin_lock(void) { while (InterlockedExchange(&g_admin_lock, 1)) Sleep(0); }
static void admin_unlock(void) { InterlockedExchange(&g_admin_lock, 0); }

/* lua_capture: PrintDebug lines while an admin command runs */
static void admin_on_print(const char *msg)
{
    if (!g_admin_capture || strncmp(msg, "[admin] ", 8) != 0 || g_admin_nreply >= 6) return;
    strncpy(g_admin_reply[g_admin_nreply], msg, sizeof(g_admin_reply[0]) - 1);
    g_admin_reply[g_admin_nreply][sizeof(g_admin_reply[0]) - 1] = 0;
    g_admin_nreply++;
}

static void admin_enqueue(const char *text, const char *who, int host, const struct admin_ctx *ctx)
{
    admin_lock();
    if (g_admin_qn < ADMIN_Q) {
        struct admin_req *r = &g_admin_q[g_admin_qn++];
        strncpy(r->text, text, sizeof(r->text) - 1); r->text[sizeof(r->text) - 1] = 0;
        strncpy(r->who, who, sizeof(r->who) - 1); r->who[sizeof(r->who) - 1] = 0;
        r->host = host;
        if (ctx) r->ctx = *ctx; else memset(&r->ctx, 0, sizeof(r->ctx));
    }
    admin_unlock();
}

static int chat_common(int local, void *t, DWORD sender, DWORD owner, DWORD team, struct vc71_string *text, DWORD flag)
{
    static volatile LONG logged;
    char line[200];
    BYTE *net = kt_net();
    line[0] = 0;
    __try {
        const char *p = text ? (text->res >= 16 ? text->bx.ptr : text->bx.buf) : NULL;
        if (p && !IsBadStringPtrA(p, 200)) {
            strncpy(line, p, sizeof(line) - 1);
            line[sizeof(line) - 1] = 0;
        }
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        line[0] = 0;
    }
    if (g_admin && net && net[0xDA4] == 1 && (line[0] == '/' || line[0] == '!')) {
        struct admin_ctx ctx;
        char who[64] = "";
        int i;
        ctx.t = t; ctx.sender = sender; ctx.owner = owner; ctx.team = team; ctx.flag = flag; ctx.valid = 1;
        for (i = 0; i < g_nhumans; i++)
            if (g_human_conn[i] && g_human_conn[i] == sender) { strcpy(who, g_human_names[i]); break; }
        if (InterlockedIncrement(&logged) <= 20)
            plog("[admin] chat command from %s (sender %08X owner %08X team %lu flag %lu, %s thread): %s",
                 local ? "the host" : (who[0] ? who : "a client (sender not matched to a player)"),
                 sender, owner, team, flag, GetCurrentThreadId() == g_main_tid ? "game" : "OTHER", line);
        if (local) g_admin_last = ctx;
        if (local || g_admin_clients) admin_enqueue(line, who, local, &ctx);
        else plog("[admin] ignored: admin_clients=0");
    }
    return o_chat(t, NULL, sender, owner, team, text, flag);
}

static int __fastcall hook_chat_local(void *t, void *edx, DWORD s, DWORD o, DWORD tm, struct vc71_string *x, DWORD f)
{
    return chat_common(1, t, s, o, tm, x, f);
}
static int __fastcall hook_chat_slave(void *t, void *edx, DWORD s, DWORD o, DWORD tm, struct vc71_string *x, DWORD f)
{
    return chat_common(0, t, s, o, tm, x, f);
}

/* a chat line from ctx's sender (replies) */
static void admin_say(const struct admin_ctx *ctx, const char *msg)
{
    static char buf[256];
    struct vc71_string s;
    int n = (int)strlen(msg);
    plog("%s", msg);
    if (!ctx || !ctx->valid || !o_chat) return;
    if (n > 240) n = 240;
    memset(&s, 0, sizeof(s));
    if (n < 16) { memcpy(s.bx.buf, msg, n); s.bx.buf[n] = 0; s.res = 15; }
    else { memcpy(buf, msg, n); buf[n] = 0; s.bx.ptr = buf; s.res = (DWORD)n; }
    s.size = (DWORD)n;
    __try {
        o_chat(ctx->t, NULL, ctx->sender, ctx->owner, ctx->team, &s, ctx->flag);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[admin] chat reply failed (exception %08X)", GetExceptionCode());
    }
}

static int admin_word_ok(const char *w)
{
    for (; *w; w++)
        if (!isalnum((unsigned char)*w) && !strchr("_-.", *w)) return 0;
    return 1;
}

/* a human player by case-insensitive name prefix (NULL if none / ambiguous) */
static const char *admin_find_human(const char *w)
{
    const char *hit = NULL;
    int i, n = (int)strlen(w);
    for (i = 0; i < g_nhumans; i++) {
        if (_stricmp(g_human_names[i], w) == 0) return g_human_names[i];
        if (_strnicmp(g_human_names[i], w, n) == 0) {
            if (hit) return NULL;
            hit = g_human_names[i];
        }
    }
    return hit;
}

/* Lua expression (character id or nil) and label for a target word; 0 = bad word */
static int admin_target(const struct admin_req *r, const char *w, char *expr, int en, char *label, int ln)
{
    const char *h;
    if (!w || !*w || _stricmp(w, "me") == 0) {
        if (r->who[0]) { _snprintf(expr, en, "H([[%s]])", r->who); _snprintf(label, ln, "%s", r->who); }
        else if (r->host) { _snprintf(expr, en, "L()"); _snprintf(label, ln, "host"); }
        else { _snprintf(expr, en, "OTHER()"); _snprintf(label, ln, "client"); }
        return 1;
    }
    if (_stricmp(w, "other") == 0) {
        if (r->host || r->who[0]) { _snprintf(expr, en, "OTHER()"); _snprintf(label, ln, "the other player"); }
        else { _snprintf(expr, en, "L()"); _snprintf(label, ln, "host"); }
        return 1;
    }
    if (_stricmp(w, "host") == 0) { _snprintf(expr, en, "L()"); _snprintf(label, ln, "host"); return 1; }
    if (!admin_word_ok(w)) return 0;
    h = admin_find_human(w);
    _snprintf(expr, en, "H([[%s]])", h ? h : w);
    _snprintf(label, ln, "%s", h ? h : w);
    return 1;
}

static const char g_admin_prelude[] =
    "local function H(n) local id = GetCharacterID(n) if id == nil or id == GetInvalidEntityID() then return nil end return id end "
    "local function P(s) PrintDebug(\"[admin] \" .. s) end "
    "local function L() local id = GetLocalCharacterID() if id == nil or id == GetInvalidEntityID() then return nil end return id end "
    "local function OTHER() local me = GetLocalCharacterID() local r = nil local k = 0 local i = 1 "
    "  while Coop_Humans ~= nil and Coop_Humans[i] ~= nil do local id = H(Coop_Humans[i]) "
    "    if id ~= nil and id ~= me then r = id k = k + 1 end i = i + 1 end "
    "  if k == 1 then return r end return nil end "
    "Coop_AdminUndo = Coop_AdminUndo or {} "
    "local function UNDO(a, an) local p = GetVarValue(a, \"Position\") Coop_AdminUndo[an] = { p:GetX(), p:GetY(), p:GetZ() } end "
    /* no math library in this Lua: sine/cosine by range reduction + Taylor series, square root by Newton */
    "local function SIN(x) local t = 6.2831853 while x > 3.1415927 do x = x - t end while x < -3.1415927 do x = x + t end "
    "  local x2 = x * x return x * (1 - x2 / 6 * (1 - x2 / 20 * (1 - x2 / 42 * (1 - x2 / 72 * (1 - x2 / 110))))) end "
    "local function COS(x) return SIN(x + 1.5707963) end "
    "local function DIST(ax, ay, bx, by) local dx = bx - ax local dy = by - ay local d = dx * dx + dy * dy "
    "  if d <= 0 then return 0 end local r = d if r < 1 then r = 1 end local i = 0 while i < 30 do r = (r + d / r) / 2 i = i + 1 end return r end "
    "local function NEAREST(a) if a == nil or DOORS == nil then return nil end local p = GetVarValue(a, \"Position\") "
    "  local best = nil local bn = nil local bd = 1e9 local i = 1 "
    "  while DOORS[i] ~= nil do local id = GetDoorID(DOORS[i]) "
    "    if id ~= nil and id ~= GetInvalidEntityID() then local q = GetVarValue(id, \"Position\") "
    "      local d = DIST(p:GetX(), p:GetY(), q:GetX(), q:GetY()) if d < bd then bd = d best = id bn = DOORS[i] end end "
    "    i = i + 1 end return best, bn, bd end "
    "local function TELE(a, an, x, y, z) if a == nil then P(an .. \" not found\") return end "
    "  UNDO(a, an) local m = Coop_AllowMove Coop_AllowMove = true "
    "  TeleportCharacter(a, Vector3D(x, y, z), GetVarValue(a, \"Rotation\")) Coop_AllowMove = m "
    "  P(an .. \" teleported to \" .. x .. \" \" .. y .. \" \" .. z) end "
    "local function MOVE(a, an, b, bn) if b == nil then P(bn .. \" not found\") return end "
    "  if a == nil then P(an .. \" not found\") return end if a == b then P(an .. \" is already there\") return end "
    "  local p = GetVarValue(b, \"Position\") UNDO(a, an) local m = Coop_AllowMove Coop_AllowMove = true "
    "  TeleportCharacter(a, Vector3D(p:GetX() + 1.5, p:GetY(), p:GetZ() + 0.3), GetVarValue(b, \"Rotation\")) "
    "  Coop_AllowMove = m P(an .. \" -> \" .. bn) end "
    "local function EACH(self, f) local i = 1 local n = 0 "
    "  while Coop_Humans ~= nil and Coop_Humans[i] ~= nil do local id = H(Coop_Humans[i]) "
    "    if id ~= nil and id ~= self then f(id, Coop_Humans[i]) n = n + 1 end i = i + 1 end "
    "  if n == 0 then P(\"no other player found\") end end "
    "local function HEAL(a, an) if a == nil then P(an .. \" not found\") return end "
    "  SetVarValue(a, \"Health\", GetVarValue(a, \"MaxHealth\")) P(an .. \" healed\") end "
    "local function AMMO(a, an) if a == nil then P(an .. \" not found\") return end "
    "  CharacterMaxUpAmmo(a) P(an .. \" ammo refilled\") end "
    "Coop_AdminSaved = Coop_AdminSaved or {} ";

static const char *g_admin_help1[] = {
    "[admin] help 1/2 (players, moving) - /help2 for the rest",
    "[admin] /goto <player>  /bring <player|all>  /tp <who> <player>  /tp [who] x y z",
    "[admin] /pos [who]  /save [slot]  /back [slot] [who]  /fwd [m] [who]  /thru [who]  /undo [who]",
    "[admin] /heal [who|all]  /ammo [who|all]  /god [who]  /players  /restart",
    "[admin] who = me, other, host, a player name or prefix, or an NPC name",
};
static const char *g_admin_help2[] = {
    "[admin] help 2/2 (level, settings, keys) - /help1 for moving",
    "[admin] /door  /doors [open]  /obj  /skip [who]  /call <Function> [who]",
    "[admin] /difficulty 1-9 or easy|medium|hard|veteran|insane|brutal|deadly|hell|impossible (x1/1.6/2/2.5/3/4/5/6/8)  /champions [1|2|3]",
    "[admin] /lives [n|off|reset] [restart|warn]  /wipe restart|warn|off  /revive [on|off|time s|radius u|bleed s]  /giveup",
    "[admin] keys: host Ctrl+F3 skip F5 fwd F6 thru F7 door F8 undo F9 bring F10 goto F11 heal F12 god; anyone Ctrl+F4 = unstick",
};

/* 0.59: enemy difficulty. NPC damage to characters is scaled in Bos 0x10005BC0 / 0x10005C50 /
   0x10005DB0 by the Gameplay.cfg multiplier NPCDamageMultiplier_<Easy|Normal|Hard>, kept in the
   singleton at [0x1025DA70] (+0 FriendlyFire, +4 Easy, +8 Normal, +0xC Hard). The slot index comes
   from engine vtable +0x7C. The proxy scales all three slots, so "easy" stays exactly what co-op had. */
static int g_champions = 1;              /* coop_config.ini [proxy] champions: champions per fight (1-3) */
static int g_difficulty;                 /* 0 easy .. 4 insane (coop_config.ini [proxy] difficulty) */
#define DIFF_N 9
static float g_dmg_base[3];
static int g_diff_applied = -1;          /* level last written into the damage table */
static int g_dmg_base_ok;
/* 0.75: veteran and insane added (up to x3); 0.76: brutal, deadly, hell, impossible (up to x8) */
static const char *g_diff_names[DIFF_N] = { "easy", "medium", "hard", "veteran", "insane", "brutal", "deadly", "hell", "impossible" };
static const float g_diff_factor[DIFF_N] = { 1.0f, 1.6f, 2.0f, 2.5f, 3.0f, 4.0f, 5.0f, 6.0f, 8.0f };   /* enemy damage to players */
static const float g_diff_health[DIFF_N] = { 1.0f, 1.6f, 2.0f, 2.5f, 3.0f, 4.0f, 5.0f, 6.0f, 8.0f };   /* enemy health (shield, armor and flesh) */

/* 0.60: enemy health. Bos 0x100108D0 is the character damage method (thiscall, 11 stack args, ret 2Ch).
   arg 10 is set when an NPC dealt the hit (NPCDamageMultiplier is applied then), and arg 11 scales the
   whole hit: shield, armor and flesh. A hit on an NPC that no NPC dealt (a player, or the world) is
   divided by the health factor, which is the same as the NPC having that much more of everything. */
typedef void (__fastcall *fn_char_damage)(BYTE *self, void *edx, void *out, DWORD a2, void *a3, DWORD a4, DWORD a5,
                                          DWORD a6, DWORD a7, DWORD a8, DWORD a9, DWORD a10, float a11);
static fn_char_damage o_char_damage;
static int is_human_character(BYTE *ch);
static void __fastcall hook_char_damage(BYTE *self, void *edx, void *out, DWORD a2, void *a3, DWORD a4, DWORD a5,
                                        DWORD a6, DWORD a7, DWORD a8, DWORD a9, DWORD a10, float a11)
{
    static volatile LONG logged;
    if (g_difficulty > 0 && !(a10 & 0xFF)) {
        int human = 1;
        __try { human = is_human_character(self); } __except (EXCEPTION_EXECUTE_HANDLER) { human = 1; }
        if (!human) {
            float before = a11;
            a11 = a11 / g_diff_health[g_difficulty];
            if (InterlockedIncrement(&logged) <= 5)
                plog("[difficulty] hit on %s: damage scale %.2f -> %.2f (enemy health x%.1f)",
                     entity_name(self), before, a11, g_diff_health[g_difficulty]);
        }
    }
    o_char_damage(self, edx, out, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11);
}
static void install_difficulty_hook(void)
{
    static const BYTE e[8] = { 0x83, 0xEC, 0x18, 0xF6, 0x44, 0x24, 0x34, 0x04 };   /* sub esp,18h; test byte [esp+34h],4 */
    BYTE *fn = VA(0x100108D0), patch[8], *t;
    char found[32];
    if (memcmp(fn, e, 8) != 0) {
        hexbytes(fn, 8, found);
        plog("[hook] %-26s found %s - NOT installed", "char_damage_difficulty", found);
        return;
    }
    t = (BYTE *)VirtualAlloc(NULL, 32, MEM_COMMIT | MEM_RESERVE, PAGE_EXECUTE_READWRITE);
    if (!t) return;
    memcpy(t, fn, 8);
    t[8] = 0xE9;
    *(INT32 *)(t + 9) = (INT32)((fn + 8) - (t + 13));
    memset(patch, 0x90, sizeof(patch));
    patch[0] = 0xE9;
    *(INT32 *)(patch + 1) = (INT32)((BYTE *)hook_char_damage - (fn + 5));
    o_char_damage = (fn_char_damage)t;
    if (write_code(fn, patch, 8)) plog("[hook] %-26s detour at %08X -> ok", "char_damage_difficulty", 0x100108D0);
}
typedef void *(__cdecl *fn_void_ptr)(void);
typedef int (__fastcall *fn_this_int)(void *t, void *edx);
static int difficulty_apply(char *msg, int mn)
{
    float *t;
    int slot = -1, i;
    __try {
        t = *(float **)VA(0x1025DA70);
        if (!t) t = (float *)((fn_void_ptr)VA(0x10003FA0))();
        if (!t) { if (msg) _snprintf(msg, mn, "[admin] difficulty: damage table not loaded yet"); return 0; }
        if (!g_dmg_base_ok) { for (i = 0; i < 3; i++) g_dmg_base[i] = t[1 + i]; g_dmg_base_ok = 1; }
        g_diff_applied = g_difficulty;
        for (i = 0; i < 3; i++) t[1 + i] = g_dmg_base[i] * g_diff_factor[g_difficulty];
        ((fn_void_ptr)VA(0x10093CD0))();
        {
            void *eng = ((fn_void_ptr)VA(0x10093D00))();
            if (eng) slot = ((fn_this_int)(*(void ***)eng)[0x7C / 4])(eng, NULL);
        }
        if (slot >= 0 && slot < 3)
            plog("[difficulty] %s: NPC damage x%.2f (game slot %d, multiplier %.2f -> %.2f)", g_diff_names[g_difficulty],
                 g_diff_factor[g_difficulty], slot, g_dmg_base[slot], t[1 + slot]);
        else
            plog("[difficulty] %s: NPC damage x%.2f (game slot %d?)", g_diff_names[g_difficulty], g_diff_factor[g_difficulty], slot);
        if (msg) _snprintf(msg, mn, "[admin] difficulty %s: enemies deal x%.1f damage and have x%.1f health%s", g_diff_names[g_difficulty],
                           g_diff_factor[g_difficulty], g_diff_health[g_difficulty], g_difficulty ? "" : " (co-op baseline)");
        return 1;
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[difficulty] applying faulted (exception %08X)", GetExceptionCode());
        if (msg) _snprintf(msg, mn, "[admin] difficulty: failed");
        return 0;
    }
}

/* 0.41: DOORS = { [[name]], ... } of the level's DOOR entities (type 54, server world), for /door, /doors, /thru */
struct door_names { char *out; int n, len, count; };
static void door_collect(BYTE *e, void *ctx)
{
    struct door_names *d = (struct door_names *)ctx;
    const char *nm = entity_name(e);
    int k;
    if (!nm || !*nm || strchr(nm, ']') || d->count >= 64) return;
    k = _snprintf(d->out + d->len, d->n - d->len, "[[%s]],", nm);
    if (k > 0 && d->len + k < d->n - 4) { d->len += k; d->count++; }
}
/* 0.46: OBJS = { [[name]], ... } of the level's OBJECTIVE entities (type 0x2B), for /obj and /skip */
static int admin_obj_list(char *out, int n)
{
    struct door_names d;
    BYTE *iface = *(BYTE **)VA(VA_ENGINE_IFACE);
    int k = _snprintf(out, n, "OBJS = { ");
    if (k <= 0 || !iface) return 0;
    d.out = out; d.n = n - 4; d.len = k; d.count = 0;
    __try { for_each_entity(iface, 0x2B, 1, door_collect, &d); } __except (EXCEPTION_EXECUTE_HANDLER) {}
    if (d.len + 3 >= n) return 0;
    strcpy(out + d.len, "} ");
    return d.len + 2;
}

static int admin_door_list(char *out, int n)
{
    struct door_names d;
    BYTE *iface = *(BYTE **)VA(VA_ENGINE_IFACE);
    int k = _snprintf(out, n, "DOORS = { ");
    if (k <= 0 || !iface) return 0;
    d.out = out; d.n = n - 4; d.len = k; d.count = 0;
    __try { for_each_entity(iface, 54, 1, door_collect, &d); } __except (EXCEPTION_EXECUTE_HANDLER) {}
    if (d.len + 3 >= n) return 0;
    strcpy(out + d.len, "} ");
    return d.len + 2;
}

/*
 * 0.69: party lives (/lives, /wipe). Host only, once a second: every human character's Health
 * (CHARACTER var "Health"); a player whose character goes from alive to dead uses one life of the
 * party's pool. When the pool is empty, or every player is down at the same moment (a wipe), the
 * chosen action runs: "restart" = the same master restart as a failed mission (coop_restart_tick),
 * "warn" = only a chat message. The pool refills when a mission (re)starts.
 * coop_config.ini [proxy] party_lives (0 = unlimited), lives_action, wipe_action (restart|warn|off).
 */
enum { ACT_OFF = 0, ACT_WARN, ACT_RESTART };
static const char *g_act_names[3] = { "off", "warn", "restart" };
static int g_party_lives = 0, g_lives_action = ACT_RESTART, g_wipe_action = ACT_OFF;
static int g_lives_used, g_lives_fired, g_wipe_fired;
static struct { char name[64]; int alive; DWORD id; } g_lv[MAX_HUMANS];
static int g_lv_n;
static int g_health_var = -2;
/* 0.71: a chat line from the host also when the host has not typed anything yet: the chat object is
   KT [0x1018F0EC]->+0 (what 0x101030B0 passes to 0x10101520), sender = owner = this PC's PLAYER
   handle (the host's lines in every log: sender 800200A4 = its PLAYER), team 0 = everyone */
static DWORD g_rv_my_player;
static int chat_ctx_default(struct admin_ctx *c)
{
    BYTE *p;
    if (g_admin_last.valid) { *c = g_admin_last; return 1; }
    if (!g_rv_my_player || !g_kt_base) return 0;
    __try {
        p = *(BYTE **)KVA(0x1018F0EC);
        if (!p || !*(void **)p) return 0;
        c->t = *(void **)p;
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        return 0;
    }
    c->sender = c->owner = g_rv_my_player;
    c->team = 0; c->flag = 0; c->valid = 1;
    return 1;
}
static void lives_say(const char *msg)
{
    struct admin_ctx c;
    if (chat_ctx_default(&c)) admin_say(&c, msg); else plog("%s", msg);
}
static int act_parse(const char *w)
{
    int i;
    for (i = 0; i < 3; i++) if (!_stricmp(w, g_act_names[i])) return i;
    if (!_stricmp(w, "nothing") || !_stricmp(w, "none")) return ACT_OFF;
    return -1;
}
static int g_revive = 1;                 /* 0.71, see rv_tick */
static int g_rv_n;
static void lives_reset(void)
{
    g_lives_used = g_lives_fired = g_wipe_fired = 0;
    g_lv_n = 0;
    g_rv_n = 0;
}
/* 0.71: with revive on, a life is used when a downed player is let go (gave up / bled out), not at the death */
static void lives_lose(const char *name, const char *why)
{
    char m[200];
    g_lives_used++;
    if (g_party_lives > 0) {
        int left = g_party_lives - g_lives_used;
        _snprintf(m, sizeof(m), "[admin] %s %s - party lives left: %d of %d", name, why, left < 0 ? 0 : left, g_party_lives);
    } else
        _snprintf(m, sizeof(m), "[admin] %s %s - respawning", name, why);
    m[sizeof(m) - 1] = 0;
    lives_say(m);
}
static void lives_status(char *m, int mn)
{
    if (g_party_lives > 0)
        _snprintf(m, mn, "[admin] party lives: %d of %d left, when they run out: %s; team wipe: %s",
                  g_party_lives - g_lives_used < 0 ? 0 : g_party_lives - g_lives_used, g_party_lives,
                  g_act_names[g_lives_action], g_act_names[g_wipe_action]);
    else
        _snprintf(m, mn, "[admin] party lives: unlimited (%d deaths so far); team wipe: %s", g_lives_used, g_act_names[g_wipe_action]);
    m[mn - 1] = 0;
}
static void lives_fire(int act, const char *why)
{
    char m[200];
    if (act == ACT_OFF) return;
    if (act == ACT_RESTART) {
        _snprintf(m, sizeof(m), "[admin] %s - restarting the mission in 5 s", why);
        if (!g_fail_restart_at) g_fail_restart_at = GetTickCount() + 5000;
    } else
        _snprintf(m, sizeof(m), "[admin] %s", why);
    m[sizeof(m) - 1] = 0;
    lives_say(m);
}
static float char_health(BYTE *e)
{
    BYTE *vl = *(BYTE **)(e + 0x18), **v;
    if (g_health_var == -2) {
        int n = 0, i;
        BYTE **d = ns_descs(5, &n);
        g_health_var = -1;
        for (i = 0; d && i < n; i++) if (!strcmp(ns_desc_name(d[i]), "Health")) { g_health_var = i; break; }
        plog("[lives] CHARACTER Health is var %d", g_health_var);
    }
    if (g_health_var < 0 || !vl) return 1.0f;
    v = *(BYTE ***)(vl + 4);
    if (!v || (int)(*(BYTE ***)(vl + 8) - v) <= g_health_var || !v[g_health_var] || !*(BYTE **)(v[g_health_var] + 0x14)) return 1.0f;
    return **(float **)(v[g_health_var] + 0x14);
}
struct lv_scan { int seen[MAX_HUMANS]; int alive[MAX_HUMANS]; DWORD id[MAX_HUMANS]; };
static void lives_scan_cb(BYTE *e, void *ctx)
{
    struct lv_scan *sc = (struct lv_scan *)ctx;
    const char *nm;
    int i;
    __try {
        if (!is_human_character(e)) return;
        nm = entity_name(e);
        if (!nm || !nm[0]) return;
        for (i = 0; i < g_lv_n && strcmp(g_lv[i].name, nm); i++) {}
        if (i == g_lv_n) {
            if (g_lv_n >= MAX_HUMANS) return;
            strncpy(g_lv[i].name, nm, 63); g_lv[i].name[63] = 0;
            g_lv[i].alive = 0;
            g_lv_n++;
        }
        sc->seen[i] = 1;
        if (char_health(e) > 0.0f) { sc->alive[i] = 1; sc->id[i] = *(DWORD *)(e + 0x1C); }   /* a respawned character next to the old body counts */
    } __except (EXCEPTION_EXECUTE_HANDLER) {}
}
static void lives_tick(void)
{
    static DWORD next;
    struct lv_scan sc;
    BYTE *iface = *(BYTE **)VA(VA_ENGINE_IFACE);
    int i, anyone = 0, known = 0;
    if (!iface || GetTickCount() < next || strcmp(nw_state_name(), "MASTER") != 0) return;
    next = GetTickCount() + 1000;
    if (g_party_lives <= 0 && g_wipe_action == ACT_OFF) return;
    memset(&sc, 0, sizeof(sc));
    __try { for_each_entity(iface, 5, 1, lives_scan_cb, &sc); } __except (EXCEPTION_EXECUTE_HANDLER) { return; }
    for (i = 0; i < g_lv_n; i++) {
        /* dead now, or already back as a new character (died and respawned between two looks) */
        if (!g_revive && g_lv[i].alive && sc.seen[i] && (!sc.alive[i] || (g_lv[i].id && sc.id[i] != g_lv[i].id))) {
            char m[200];
            g_lives_used++;
            if (g_party_lives > 0) {
                int left = g_party_lives - g_lives_used;
                _snprintf(m, sizeof(m), "[admin] %s died - party lives left: %d of %d", g_lv[i].name, left < 0 ? 0 : left, g_party_lives);
                m[sizeof(m) - 1] = 0;
                lives_say(m);
            } else plog("[lives] %s died (%d deaths)", g_lv[i].name, g_lives_used);
        }
        if (sc.seen[i]) { g_lv[i].alive = sc.alive[i]; g_lv[i].id = sc.alive[i] ? sc.id[i] : 0; }
        if (g_lv[i].alive) anyone = 1;
        known++;
    }
    if (g_party_lives > 0 && g_lives_used >= g_party_lives && !g_lives_fired) {
        g_lives_fired = 1;
        lives_fire(g_lives_action, "the party is out of lives");
    }
    if (known > 0 && !anyone) {
        if (!g_wipe_fired) { g_wipe_fired = 1; lives_fire(g_wipe_action, "team wipe - every player is down"); }
    } else g_wipe_fired = 0;
}
static void lives_save(void)
{
    char v[16];
    _snprintf(v, sizeof(v), "%d", g_party_lives); v[sizeof(v) - 1] = 0;
    WritePrivateProfileStringA("proxy", "party_lives", v, g_config_path);
    WritePrivateProfileStringA("proxy", "lives_action", g_act_names[g_lives_action], g_config_path);
    WritePrivateProfileStringA("proxy", "wipe_action", g_act_names[g_wipe_action], g_config_path);
}

/*
 * 0.71: revive. Built on the multiplayer respawn, which only the master decides: the game mode's
 * server update (Bos 0x10074CF0, only when the engine says "server") queues every dead PLAYER that
 * has a class (0x100749B0 per team; its "is alive" test is the call to 0x10058EF0 at 0x100749F8)
 * whenever its wave timer (+0x98) runs out, then 0x100746B0 spawns the queue (+0xA8 list): a free
 * spawn point (0x10077CF0) and a "spawn" message to every PC (0x101418F0). So:
 *  - a dead player is DOWN: the master's test says "alive" for him, he is not queued;
 *  - another player within revive_radius of the body for revive_time seconds revives him: the
 *    master queues only him at once (0x100749B0 with everybody else held), and when his new
 *    character exists it stamps "put character X at the body" into the frame table; both PCs do it
 *    with TeleportCharacter (0x10006F00) in his PLAYER update of that frame (like NPC Freeze, 0.47);
 *  - giving up (/giveup, or holding revive_key 1 s while down) or bleeding out (revive_bleedout s)
 *    lets the normal respawn have him; that uses a party life (/lives). With everyone down nobody can
 *    revive: all are let go (and the wipe action runs).
 * Spawn decisions are the master's anyway (message to all), so holding / queueing cannot desync.
 * coop_config.ini [proxy] revive=1, revive_time=4, revive_radius=12 (game units), revive_bleedout=90 (0 = never),
 * revive_key=32 (virtual key, 0 = off).
 */
static float g_rv_time = 4.0f, g_rv_radius = 12.0f;   /* game units: the eye is ~7 above the feet (0.71 log) */
static int g_rv_bleed = 90, g_rv_key = VK_SPACE;
enum { RV_NONE = 0, RV_DOWN, RV_FREE };
static struct rv {
    char name[64];
    int state;
    DWORD alive_id;                       /* the character last seen alive */
    float last_pos[3];
    DWORD body_id;
    float body[3];
    DWORD down_at;
    float progress;                       /* seconds of revive done */
    int want_spawn;                       /* revived: the master queues him at once */
    DWORD spawn_asked, revived_at;
} g_rv[MAX_HUMANS];
static char g_rv_gq[4][64];               /* give-ups from the network thread */
static int g_rv_gq_n;
static volatile LONG g_rv_glock;
static __declspec(thread) int t_rv_force;
static BYTE *g_rv_gm;
typedef BYTE (__fastcall *fn_rv_alive)(BYTE *pl, void *edx);
typedef void (__fastcall *fn_rv_queue)(BYTE *gm, void *edx);
typedef void (__fastcall *fn_rv_team)(BYTE *gm, void *edx, int team);
static fn_rv_alive o_rv_alive;
static fn_rv_queue o_rv_spawn_queue;
static volatile LONG g_rv_tp_applied;
static struct { DWORD id, until; } g_rv_fix[4];   /* client: revived characters to watch for 10 s */

static struct rv *rv_find(const char *nm, int add)
{
    int i;
    if (!nm || !nm[0]) return NULL;
    for (i = 0; i < g_rv_n; i++) if (!strcmp(g_rv[i].name, nm)) return &g_rv[i];
    if (!add || g_rv_n >= MAX_HUMANS) return NULL;
    memset(&g_rv[g_rv_n], 0, sizeof(g_rv[0]));
    strncpy(g_rv[g_rv_n].name, nm, 63);
    return &g_rv[g_rv_n++];
}

static void rv_giveup_push(const char *name)
{
    while (InterlockedExchange(&g_rv_glock, 1)) Sleep(0);
    if (g_rv_gq_n < 4) { strncpy(g_rv_gq[g_rv_gq_n], name, 63); g_rv_gq[g_rv_gq_n][63] = 0; g_rv_gq_n++; }
    InterlockedExchange(&g_rv_glock, 0);
}

static void rv_client_note(DWORD id)
{
    int i, k = 0;
    DWORD now = GetTickCount();
    for (i = 0; i < 4; i++) { if (g_rv_fix[i].id == id) { k = i; break; } if (g_rv_fix[i].until < g_rv_fix[k].until) k = i; }
    g_rv_fix[k].id = id; g_rv_fix[k].until = now + 10000;
}

/* the downed player lets go: the normal respawn takes him (uses a life) */
static void rv_free(struct rv *r, const char *why)
{
    r->state = RV_FREE;
    r->want_spawn = 0;
    r->progress = 0;
    lives_lose(r->name, why);
}

static void rv_status(char *m, int mn)
{
    char bl[32];
    if (g_rv_bleed > 0) _snprintf(bl, sizeof(bl), "%d s", g_rv_bleed); else strcpy(bl, "never");
    bl[sizeof(bl) - 1] = 0;
    if (!g_revive) _snprintf(m, mn, "[admin] revive is off (/revive on)");
    else _snprintf(m, mn, "[admin] revive on: stand within %.0f units (a player is ~7 tall) of a downed player for %.1f s. Bleed-out: %s. "
                   "Downed: /giveup%s to respawn now", g_rv_radius, g_rv_time, bl,
                   g_rv_key == VK_SPACE ? " or hold Space" : g_rv_key > 0 ? " or hold the give-up key" : "");
    m[mn - 1] = 0;
}

static void rv_save(void)
{
    char v[32];
    WritePrivateProfileStringA("proxy", "revive", g_revive ? "1" : "0", g_config_path);
    _snprintf(v, sizeof(v), "%g", g_rv_time); v[31] = 0; WritePrivateProfileStringA("proxy", "revive_time", v, g_config_path);
    _snprintf(v, sizeof(v), "%g", g_rv_radius); v[31] = 0; WritePrivateProfileStringA("proxy", "revive_radius", v, g_config_path);
    _snprintf(v, sizeof(v), "%d", g_rv_bleed); v[31] = 0; WritePrivateProfileStringA("proxy", "revive_bleedout", v, g_config_path);
}

/* the PLAYER's character (a dead player still has his body), else the PLAYER's own name */
static struct rv *rv_of_player(BYTE *pl)
{
    BYTE *ch = NULL;
    const char *nm = NULL;
    __try {
        ch = ((BYTE *(__fastcall *)(BYTE *, void *))VA(0x10058D00))(pl, 0);
        nm = ch ? entity_name(ch) : entity_name(pl);
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        return NULL;
    }
    return rv_find(nm, 0);
}

/* master: is this PLAYER already in the spawn queue (gm+0xA8 list, head at +0xAC; node +8 = PLAYER handle) */
static int rv_queued(BYTE *gm, BYTE *pl)
{
    BYTE *head, *n;
    int k = 0;
    __try {
        DWORD h = *(DWORD *)(pl + 0x1C);
        head = *(BYTE **)(gm + 0xAC);
        for (n = head ? *(BYTE **)head : NULL; n && n != head && k < 64; n = *(BYTE **)n, k++)
            if (*(DWORD *)(n + 8) == h) return 1;
    } __except (EXCEPTION_EXECUTE_HANDLER) {
    }
    return 0;
}

/* master, Bos 0x100749F8 (wave queueing): 1 = "alive", not queued */
static BYTE __fastcall hook_rv_alive(BYTE *pl, void *edx)
{
    BYTE r = o_rv_alive(pl, edx);
    struct rv *v;
    if (r || !g_revive) return r;
    v = rv_of_player(pl);
    if (t_rv_force) {
        if (v && v->state == RV_DOWN && v->want_spawn && !rv_queued(g_rv_gm, pl)) return 0;
        return 1;                                         /* only the revived player is queued now */
    }
    if (v && v->state == RV_DOWN && !v->want_spawn) {           /* downed: waits for a revive */
        static int n;
        if (n++ < 5) plog("[revive] respawn of %s held (downed)", v->name);
        return 1;
    }
    return 0;
}

/* master, Bos 0x10074D2F: the game mode spawns its queue each server update - revived players first get queued */
static void __fastcall hook_rv_spawn_queue(BYTE *gm, void *edx)
{
    int i, any = 0;
    DWORD now = GetTickCount();
    if (g_rv_gm != gm) plog("[revive] game mode spawn update at %p (server)", gm);
    g_rv_gm = gm;
    if (g_revive) {
        for (i = 0; i < g_rv_n; i++)
            if (g_rv[i].state == RV_DOWN && g_rv[i].want_spawn && (!g_rv[i].spawn_asked || now - g_rv[i].spawn_asked > 3000)) {
                g_rv[i].spawn_asked = now | 1;
                any = 1;
            }
        if (any) {
            t_rv_force = 1;
            __try {
                ((fn_rv_team)VA(0x100749B0))(gm, 0, 1);
                ((fn_rv_team)VA(0x100749B0))(gm, 0, 2);
            } __except (EXCEPTION_EXECUTE_HANDLER) {
                plog("[revive] queueing the revived player faulted (%08X)", GetExceptionCode());
            }
            t_rv_force = 0;
            for (i = 0; i < g_rv_n; i++)
                if (g_rv[i].state == RV_DOWN && g_rv[i].want_spawn && g_rv[i].spawn_asked == (now | 1))
                    plog("[revive] %s queued for an immediate respawn", g_rv[i].name);
        }
    }
    o_rv_spawn_queue(gm, edx);
}

/* both PCs: TeleportCharacter to p (a little above the body) with the character's own rotation */
static void rv_teleport(BYTE *e, const float *p)
{
    float pos[4], rot[4];
    memcpy(pos, e + 0x174, 16);
    memcpy(rot, e + 0x198, 16);
    pos[0] = p[0]; pos[1] = p[1]; pos[2] = p[2] + 0.5f;
    ((fn_char_tp)VA(0x10006F00))(e, 0, pos, rot);
}

/* both PCs, every human PLAYER update: the frame table's revive teleport for its character in this frame */
static void rv_tp_apply(BYTE *pl, BYTE *ch)
{
    BYTE *net = kt_net();
    struct ft_frame *f;
    int frame, i, have = 0;
    float p[3];
    DWORD id;
    if (!ft_active(net)) return;
    frame = sim_frame(net, *(DWORD *)(pl + 0x1C));        /* every update: keeps the client's pass count right */
    id = *(DWORD *)(ch + 0x1C);
    EnterCriticalSection(&g_npc_cs);
    f = ft_get(frame);
    if (f) for (i = 0; i < f->ntp; i++) if (f->t[i].id == id) { p[0] = f->t[i].x; p[1] = f->t[i].y; p[2] = f->t[i].z; have = 1; }
    LeaveCriticalSection(&g_npc_cs);
    if (!have) return;
    __try { rv_teleport(ch, p); } __except (EXCEPTION_EXECUTE_HANDLER) { plog("[revive] teleport faulted"); return; }
    if (InterlockedIncrement(&g_rv_tp_applied) <= 40)
        plog("[revive] %s put at its body (%.1f, %.1f, %.1f) in frame %d (%s)", entity_name(ch), p[0], p[1], p[2], frame,
             net[0xDA4] == 1 ? "host" : "client");
}

struct rv_ch { char name[64]; DWORD id; float pos[3]; int alive; BYTE *e; };
struct rv_scan { struct rv_ch c[32]; int n; };
static void rv_scan_cb(BYTE *e, void *ctx)
{
    struct rv_scan *s = (struct rv_scan *)ctx;
    const char *nm;
    if (s->n >= 32) return;
    __try {
        if (!is_human_character(e)) return;
        nm = entity_name(e);
        if (!nm || !nm[0]) return;
        strncpy(s->c[s->n].name, nm, 63); s->c[s->n].name[63] = 0;
        s->c[s->n].id = *(DWORD *)(e + 0x1C);
        memcpy(s->c[s->n].pos, e + 0x174, 12);
        s->c[s->n].alive = char_health(e) > 0.0f;
        s->c[s->n].e = e;
        s->n++;
    } __except (EXCEPTION_EXECUTE_HANDLER) {}
}

/* client: a revived character whose teleport this PC missed is re-placed after the next resync */
static void rv_fix_cb(BYTE *e, void *ctx)
{
    int i;
    DWORD id = *(DWORD *)(e + 0x1C), now = GetTickCount();
    (void)ctx;
    for (i = 0; i < 4; i++) if (g_rv_fix[i].id == id && now < g_rv_fix[i].until) { tp_fix_cb(e, NULL); return; }
}

/* both PCs: holding the give-up key for 1 s while this PC's player is dead = /giveup */
static void rv_key_tick(BYTE *net)
{
    static DWORD held, sent;
    BYTE *lc = (BYTE *)local_character();
    const char *nm = NULL;
    DWORD now = GetTickCount(), pid = 0;
    int dead = 0;
    if (!g_revive || g_rv_key <= 0 || !lc) { held = 0; return; }
    __try { dead = char_health(lc) <= 0.0f; nm = entity_name(lc); } __except (EXCEPTION_EXECUTE_HANDLER) { return; }
    GetWindowThreadProcessId(GetForegroundWindow(), &pid);
    if (!dead || !nm || !nm[0] || pid != GetCurrentProcessId() || !(GetAsyncKeyState(g_rv_key) & 0x8000)) { held = 0; return; }
    if (!held) { held = now | 1; return; }
    if (now - held < 1000 || now - sent < 2000) return;
    sent = now;
    if (net[0xDA4] == 1) { rv_giveup_push(nm); return; }
    if (g_npc_master_s != INVALID_SOCKET && o_sendto) {
        struct giveup_pkt p;
        memset(&p, 0, sizeof(p));
        p.magic = NPC_MAGIC_GIVEUP;
        strncpy(p.name, nm, sizeof(p.name) - 1);
        o_sendto(g_npc_master_s, (const char *)&p, (int)sizeof(p), 0, (const struct sockaddr *)&g_npc_master, sizeof(g_npc_master));
        plog("[revive] give-up key held - asked the host to respawn %s", nm);
    }
}

/* 0.75: the difficulty changes damage on every PC's simulation, so the clients must use the host's level
   (before, only the host knew it and resyncs corrected the client). Host: sent every 2 s; client: applied. */
static int difficulty_apply(char *msg, int mn);
static void diff_sync_tick(BYTE *net)
{
    static DWORD sent;
    LONG rx;
    if (net[0xDA4] == 1) {
        DWORD now = GetTickCount();
        if (now - sent >= 2000) {
            DWORD p[2];
            sent = now;
            p[0] = NPC_MAGIC_DIFF; p[1] = (DWORD)g_difficulty;
            npc_send_packet(p, sizeof(p));
        }
        return;
    }
    rx = g_diff_rx;
    if (rx >= 0 && rx < DIFF_N && (rx != g_difficulty || g_diff_applied != rx)) {
        g_difficulty = (int)rx;
        if (difficulty_apply(NULL, 0)) plog("[difficulty] client: host plays %s - applied here too", g_diff_names[rx]);
    }
}

static void rv_tick(void)
{
    static DWORD last;
    BYTE *net = kt_net(), *iface = *(BYTE **)VA(VA_ENGINE_IFACE), *lc = (BYTE *)local_character(), *pl;
    struct rv_scan sc;
    DWORD now = GetTickCount();
    float dt;
    int i, j, known = 0, up = 0;
    char m[220];
    if (!net || !iface) return;
    if (lc && (pl = char_player(lc))) __try { g_rv_my_player = *(DWORD *)(pl + 0x1C); } __except (EXCEPTION_EXECUTE_HANDLER) {}
    rv_key_tick(net);
    diff_sync_tick(net);
    if (net[0xDA4] == 0) {                                  /* client: only the missed-teleport watch */
        for (i = 0; i < 4 && !(g_rv_fix[i].id && now < g_rv_fix[i].until); i++) {}
        if (i < 4) __try { for_each_entity(iface, 5, 1, rv_fix_cb, NULL); } __except (EXCEPTION_EXECUTE_HANDLER) {}
        return;
    }
    if (!g_revive || net[0xDA4] != 1 || strcmp(nw_state_name(), "MASTER") != 0) return;
    if (now - last < 100) return;
    dt = last && now - last < 1000 ? (now - last) / 1000.0f : 0.1f;
    last = now;
    memset(&sc, 0, sizeof(sc));
    __try { for_each_entity(iface, 5, 1, rv_scan_cb, &sc); } __except (EXCEPTION_EXECUTE_HANDLER) { return; }
    for (j = 0; j < sc.n; j++) rv_find(sc.c[j].name, 1);

    /* give-ups (key packets / host key) */
    while (InterlockedExchange(&g_rv_glock, 1)) Sleep(0);
    for (i = 0; i < g_rv_gq_n; i++) {
        struct rv *r = rv_find(g_rv_gq[i], 0);
        if (r && r->state == RV_DOWN && !r->want_spawn) rv_free(r, "gave up");
    }
    g_rv_gq_n = 0;
    InterlockedExchange(&g_rv_glock, 0);

    for (i = 0; i < g_rv_n; i++) {
        struct rv *r = &g_rv[i];
        struct rv_ch *alive = NULL, *old = NULL;
        int seen = 0;
        for (j = 0; j < sc.n; j++) {
            if (strcmp(sc.c[j].name, r->name)) continue;
            seen = 1;
            if (sc.c[j].alive) alive = &sc.c[j];
            if (sc.c[j].id == r->alive_id) old = &sc.c[j];
        }
        if (alive && alive->id != r->body_id) {
            if (r->state == RV_DOWN && r->want_spawn) {
                /* the revived player's new character: put it at the body on both PCs */
                if (ft_active(net)) {
                    EnterCriticalSection(&g_npc_cs);
                    if (g_tp_new_n < TP_PER_FRAME) {
                        g_tp_new[g_tp_new_n].id = alive->id;
                        g_tp_new[g_tp_new_n].x = r->body[0]; g_tp_new[g_tp_new_n].y = r->body[1]; g_tp_new[g_tp_new_n].z = r->body[2];
                        g_tp_new_n++;
                    }
                    LeaveCriticalSection(&g_npc_cs);
                } else {
                    __try { rv_teleport(alive->e, r->body); } __except (EXCEPTION_EXECUTE_HANDLER) {}
                    plog("[revive] %s put at the body directly (no frame table: no co-op client)", r->name);
                }
                _snprintf(m, sizeof(m), "[admin] %s is back up", r->name);
                m[sizeof(m) - 1] = 0;
                lives_say(m);
            }
            r->state = RV_NONE;
            r->want_spawn = 0;
        }
        if (alive) {
            if (alive->id != r->alive_id) __try { kits_char_dump(alive->e); } __except (EXCEPTION_EXECUTE_HANDLER) {}
            r->alive_id = alive->id;
            memcpy(r->last_pos, alive->pos, 12);
            known++; up++;
            continue;
        }
        if (!r->alive_id || !seen) continue;              /* never seen alive yet (joining) / left the game */
        known++;
        if (r->state == RV_NONE) {
            r->state = RV_DOWN;
            r->body_id = r->alive_id;
            memcpy(r->body, old ? old->pos : r->last_pos, 12);
            r->down_at = now;
            r->progress = 0;
            r->want_spawn = 0;
            r->spawn_asked = 0;
            _snprintf(m, sizeof(m), "[admin] %s is down! Stand next to the body for %.0f s to revive. %s: /giveup%s to respawn instead",
                      r->name, g_rv_time, r->name, g_rv_key == VK_SPACE ? " or hold Space" : g_rv_key > 0 ? " or hold the give-up key" : "");
            m[sizeof(m) - 1] = 0;
            lives_say(m);
            plog("[revive] %s down at (%.1f, %.1f, %.1f), body %08X", r->name, r->body[0], r->body[1], r->body[2], r->body_id);
        }
    }

    for (i = 0; i < g_rv_n; i++) {
        struct rv *r = &g_rv[i];
        struct rv_ch *best = NULL;
        float bd = 1e30f;
        if (r->state != RV_DOWN) continue;
        if (r->want_spawn) {
            if (now - r->revived_at > 20000) {              /* never came back: let the normal respawn have him */
                plog("[revive] %s: no new character 20 s after the revive - normal respawn", r->name);
                r->state = RV_FREE; r->want_spawn = 0;
            }
            continue;
        }
        if (known > 0 && up == 0) { rv_free(r, "is down with everyone else"); continue; }
        if (g_rv_bleed > 0 && now - r->down_at > (DWORD)g_rv_bleed * 1000) { rv_free(r, "bled out"); continue; }
        for (j = 0; j < sc.n; j++) {
            float dx, dy, dz, d2;
            if (!sc.c[j].alive || !strcmp(sc.c[j].name, r->name)) continue;
            dx = sc.c[j].pos[0] - r->body[0]; dy = sc.c[j].pos[1] - r->body[1]; dz = sc.c[j].pos[2] - r->body[2];
            d2 = dx * dx + dy * dy + dz * dz;
            if (d2 < bd) { bd = d2; best = &sc.c[j]; }
        }
        {
            static DWORD logged_at;
            if (best && now - logged_at > 2000) {
                logged_at = now;
                plog("[revive] %s down %lu s: nearest player %s is %.1f units from the body (needs %.1f) at (%.1f, %.1f, %.1f)",
                     r->name, (now - r->down_at) / 1000, best->name, sqrt(bd), g_rv_radius, best->pos[0], best->pos[1], best->pos[2]);
            }
        }
        if (best && bd <= g_rv_radius * g_rv_radius) {
            if (r->progress <= 0.0f) {
                _snprintf(m, sizeof(m), "[admin] %s is reviving %s...", best->name, r->name);
                m[sizeof(m) - 1] = 0;
                lives_say(m);
            }
            r->progress += dt;
            if (r->progress >= g_rv_time) {
                r->want_spawn = 1;
                r->spawn_asked = 0;
                r->revived_at = now;
                plog("[revive] %s revived by %s (%.1f units from the body)", r->name, best->name, sqrt(bd));
            }
        } else if (r->progress > 0.0f) {
            r->progress -= dt;                               /* stepping away loses the progress slowly */
            if (r->progress <= 0.0f) {
                r->progress = 0.0f;
                _snprintf(m, sizeof(m), "[admin] revive of %s interrupted", r->name);
                m[sizeof(m) - 1] = 0;
                lives_say(m);
            }
        }
    }
}

/* builds the Lua for one command; returns 0 when it was answered directly (or bad) */
static int admin_build(const struct admin_req *r, char *code, int cn)
{
    char buf[200], *tok[8], *p, *ctx2;
    char ea[160], la[64], eb[160], lb[64], self[160], ls[64];
    int nt = 0, i, n;
    strncpy(buf, r->text + 1, sizeof(buf) - 1);
    buf[sizeof(buf) - 1] = 0;
    for (p = strtok_s(buf, " \t", &ctx2); p && nt < 8; p = strtok_s(NULL, " \t", &ctx2)) tok[nt++] = p;
    if (!nt) return 0;
    for (i = 0; tok[0][i]; i++) tok[0][i] = (char)tolower((unsigned char)tok[0][i]);
    admin_target(r, "me", self, sizeof(self), ls, sizeof(ls));
    n = _snprintf(code, cn, "%s local SELF = %s ", g_admin_prelude, self);
    if (n > 0) { int m = admin_door_list(code + n, cn - n); if (m > 0) n += m; }
    if (n > 0) { int m = admin_obj_list(code + n, cn - n); if (m > 0) n += m; }
    if (n < 0) return 0;
    code += n; cn -= n;
#define BADW(w) do { (void)(w); _snprintf(code, cn, "P([[bad name: use letters, digits, _ - . only]])"); return 1; } while (0)
    if (!strcmp(tok[0], "help") || !strcmp(tok[0], "?") || !strcmp(tok[0], "help1") || !strcmp(tok[0], "help2")) {
        /* 0.63: one page did not fit the chat window - two pages of 5 lines */
        int two = !strcmp(tok[0], "help2") || (nt > 1 && !strcmp(tok[1], "2"));
        const char **pg = two ? g_admin_help2 : g_admin_help1;
        int pn = two ? (int)(sizeof(g_admin_help2) / sizeof(g_admin_help2[0])) : (int)(sizeof(g_admin_help1) / sizeof(g_admin_help1[0]));
        for (i = 0; i < pn; i++) admin_say(&r->ctx, pg[i]);
        return 0;
    }
    if (!strcmp(tok[0], "players")) {
        char m[200];
        int k = _snprintf(m, sizeof(m), "[admin] players:");
        for (i = 0; i < g_nhumans && k > 0 && k < (int)sizeof(m) - 70; i++)
            k += _snprintf(m + k, sizeof(m) - k, " %s", g_human_names[i]);
        admin_say(&r->ctx, m);
        return 0;
    }
    if (!strcmp(tok[0], "champions") || !strcmp(tok[0], "champs")) {
        if (nt > 1) {
            int want = atoi(tok[1]);
            if (want < 1 || want > 3) { admin_say(&r->ctx, "[admin] /champions 1 | 2 | 3"); return 0; }
            g_champions = want;
            {
                char v[8];
                _snprintf(v, sizeof(v), "%d", want); v[sizeof(v) - 1] = 0;
                WritePrivateProfileStringA("proxy", "champions", v, g_config_path);
            }
        }
        _snprintf(code, cn,
                  "Coop_ChampionCount = %d "
                  "local m = [[champions: %d at once]] local a = 0 "
                  "while a < 4 do local c = GetChampionFromArea(a) "
                  "  if c ~= nil and c ~= GetInvalidEntityID() then local n = 0 "
                  "    if Coop_BOS_Candidates ~= nil then local l, k = Coop_BOS_Candidates(a) n = k end "
                  "    m = m .. [[; fight ]] .. a .. [[: ]] .. (n + 1) .. [[ available]] end "
                  "  a = a + 1 end P(m)", g_champions, g_champions);
        return 1;
    }
    if (!strcmp(tok[0], "difficulty") || !strcmp(tok[0], "diff")) {
        char m[200];
        if (nt > 1) {
            int want = -1;
            for (i = 0; i < DIFF_N; i++) if (!_stricmp(tok[1], g_diff_names[i])) want = i;
            if (!_stricmp(tok[1], "normal")) want = 1;
            if (!_stricmp(tok[1], "nightmare") || !_stricmp(tok[1], "max")) want = DIFF_N - 1;
            if (want < 0 && tok[1][0] >= '1' && tok[1][0] < '1' + DIFF_N && !tok[1][1]) want = tok[1][0] - '1';   /* /difficulty 1..9 */
            if (want < 0) { admin_say(&r->ctx, "[admin] /difficulty 1-9: easy medium hard veteran insane brutal deadly hell impossible (x1 ... x8)"); return 0; }
            if (strcmp(nw_state_name(), "MASTER") != 0) { admin_say(&r->ctx, "[admin] difficulty: only the host's game decides damage"); return 0; }
            g_difficulty = want;
            WritePrivateProfileStringA("proxy", "difficulty", g_diff_names[want], g_config_path);
        }
        difficulty_apply(m, sizeof(m));
        admin_say(&r->ctx, m);
        return 0;
    }
    if (!strcmp(tok[0], "giveup") || !strcmp(tok[0], "respawn")) {
        const char *who = r->who[0] ? r->who : NULL;
        struct rv *v;
        BYTE *lc = (BYTE *)local_character();
        if (strcmp(nw_state_name(), "MASTER") != 0) { admin_say(&r->ctx, "[admin] giveup: only the host decides respawns"); return 0; }
        if (!who && r->host && lc) who = entity_name(lc);
        v = rv_find(who, 0);
        if (!g_revive) admin_say(&r->ctx, "[admin] revive is off - you respawn the normal way");
        else if (!v || v->state != RV_DOWN) admin_say(&r->ctx, "[admin] giveup: you are not down");
        else if (v->want_spawn) admin_say(&r->ctx, "[admin] giveup: you are already being revived");
        else rv_free(v, "gave up");
        return 0;
    }
    if (!strcmp(tok[0], "revive")) {
        char m[240];
        int k;
        for (k = 1; k < nt; k++) {
            if (!_stricmp(tok[k], "on")) { g_revive = 1; continue; }
            if (!_stricmp(tok[k], "off")) { g_revive = 0; continue; }
            if (k + 1 < nt && !_stricmp(tok[k], "time") && atof(tok[k + 1]) > 0) { g_rv_time = (float)atof(tok[++k]); if (g_rv_time > 60) g_rv_time = 60; continue; }
            if (k + 1 < nt && !_stricmp(tok[k], "radius") && atof(tok[k + 1]) > 0) { g_rv_radius = (float)atof(tok[++k]); if (g_rv_radius > 100) g_rv_radius = 100; continue; }
            if (k + 1 < nt && (!_stricmp(tok[k], "bleed") || !_stricmp(tok[k], "bleedout"))) { g_rv_bleed = atoi(tok[++k]); if (g_rv_bleed < 0) g_rv_bleed = 0; continue; }
            admin_say(&r->ctx, "[admin] /revive [on|off] [time s] [radius units, 12 = ~2 body widths] [bleed s (0 = never)]");
            return 0;
        }
        if (nt > 1) {
            int i;
            rv_save();
            if (!g_revive) for (i = 0; i < g_rv_n; i++) if (g_rv[i].state == RV_DOWN) { g_rv[i].state = RV_FREE; g_rv[i].want_spawn = 0; }
        }
        rv_status(m, sizeof(m));
        admin_say(&r->ctx, m);
        return 0;
    }
    if (!strcmp(tok[0], "lives") || !strcmp(tok[0], "wipe")) {
        char m[220];
        int k, isw = !strcmp(tok[0], "wipe");
        if (strcmp(nw_state_name(), "MASTER") != 0) { admin_say(&r->ctx, "[admin] lives: only the host's game counts them"); return 0; }
        for (k = 1; k < nt; k++) {
            int a = act_parse(tok[k]);
            if (!isw && (!_stricmp(tok[k], "off") || !_stricmp(tok[k], "unlimited") || !strcmp(tok[k], "0"))) { g_party_lives = 0; continue; }
            if (!isw && !_stricmp(tok[k], "reset")) { g_lives_used = 0; g_lives_fired = 0; continue; }
            if (!isw && atoi(tok[k]) > 0) { g_party_lives = atoi(tok[k]); if (g_party_lives > 999) g_party_lives = 999; g_lives_fired = 0; continue; }
            if (a >= 0) { if (isw) g_wipe_action = a; else g_lives_action = a; continue; }
            admin_say(&r->ctx, isw ? "[admin] /wipe restart | warn | off" : "[admin] /lives <number> | off | reset  [restart | warn]");
            return 0;
        }
        if (nt > 1) lives_save();
        lives_status(m, sizeof(m));
        admin_say(&r->ctx, m);
        return 0;
    }
    if (!strcmp(tok[0], "restart")) {
        if (strcmp(nw_state_name(), "MASTER") != 0) { admin_say(&r->ctx, "[admin] restart: not the master"); return 0; }
        g_fail_restart_at = GetTickCount() + 2000;
        admin_say(&r->ctx, "[admin] restarting the level in 2 s");
        return 0;
    }
    if (!strcmp(tok[0], "pos")) {
        if (!admin_target(r, nt > 1 ? tok[1] : "me", ea, sizeof(ea), la, sizeof(la))) BADW(tok[1]);
        _snprintf(code, cn, "local a = %s if a == nil then P([[%s not found]]) else local p = GetVarValue(a, \"Position\") "
                  "P([[%s at ]] .. p:GetX() .. \" \" .. p:GetY() .. \" \" .. p:GetZ()) end", ea, la, la);
        return 1;
    }
    if (!strcmp(tok[0], "goto") && nt > 1) {
        if (!admin_target(r, tok[1], ea, sizeof(ea), la, sizeof(la))) BADW(tok[1]);
        _snprintf(code, cn, "MOVE(SELF, [[%s]], %s, [[%s]])", ls, ea, la);
        return 1;
    }
    if (!strcmp(tok[0], "bring") && nt > 1) {
        if (!_stricmp(tok[1], "all")) {
            _snprintf(code, cn, "EACH(SELF, function(id, n) MOVE(id, n, SELF, [[%s]]) end)", ls);
            return 1;
        }
        if (!admin_target(r, tok[1], ea, sizeof(ea), la, sizeof(la))) BADW(tok[1]);
        _snprintf(code, cn, "MOVE(%s, [[%s]], SELF, [[%s]])", ea, la, ls);
        return 1;
    }
    if (!strcmp(tok[0], "tp") && nt >= 2) {
        double v[3];
        char *e;
        int first = 1, k;
        /* /tp x y z  |  /tp who x y z  |  /tp who target */
        if (nt == 4 || nt == 5) {
            int ok = 1;
            first = nt == 5 ? 2 : 1;
            for (k = 0; k < 3; k++) {
                v[k] = strtod(tok[first + k], &e);
                if (*e) ok = 0;
            }
            if (ok) {
                if (!admin_target(r, nt == 5 ? tok[1] : "me", ea, sizeof(ea), la, sizeof(la))) BADW(tok[1]);
                _snprintf(code, cn, "TELE(%s, [[%s]], %.3f, %.3f, %.3f)", ea, la, v[0], v[1], v[2]);
                return 1;
            }
        }
        if (nt == 3) {
            if (!admin_target(r, tok[1], ea, sizeof(ea), la, sizeof(la))) BADW(tok[1]);
            if (!admin_target(r, tok[2], eb, sizeof(eb), lb, sizeof(lb))) BADW(tok[2]);
            _snprintf(code, cn, "MOVE(%s, [[%s]], %s, [[%s]])", ea, la, eb, lb);
            return 1;
        }
        if (nt == 2) {
            if (!admin_target(r, tok[1], ea, sizeof(ea), la, sizeof(la))) BADW(tok[1]);
            _snprintf(code, cn, "MOVE(SELF, [[%s]], %s, [[%s]])", ls, ea, la);
            return 1;
        }
    }
    if (!strcmp(tok[0], "save")) {
        const char *slot = nt > 1 ? tok[1] : "1";
        if (!admin_word_ok(slot)) BADW(slot);
        _snprintf(code, cn, "if SELF == nil then P([[%s not found]]) else local p = GetVarValue(SELF, \"Position\") "
                  "Coop_AdminSaved[\"%s\"] = { p:GetX(), p:GetY(), p:GetZ() } P([[saved point %s]]) end", ls, slot, slot);
        return 1;
    }
    if (!strcmp(tok[0], "back") || !strcmp(tok[0], "load")) {
        const char *slot = nt > 1 ? tok[1] : "1";
        if (!admin_word_ok(slot)) BADW(slot);
        if (!admin_target(r, nt > 2 ? tok[2] : "me", ea, sizeof(ea), la, sizeof(la))) BADW(tok[2]);
        _snprintf(code, cn, "local s = Coop_AdminSaved[\"%s\"] if s == nil then P([[no saved point %s (use /save %s)]]) "
                  "else TELE(%s, [[%s]], s[1], s[2], s[3]) end", slot, slot, slot, ea, la);
        return 1;
    }
    if (!strcmp(tok[0], "heal") || !strcmp(tok[0], "ammo")) {
        const char *f = tok[0][0] == 'h' ? "HEAL" : "AMMO";
        if (nt > 1 && !_stricmp(tok[1], "all")) {
            _snprintf(code, cn, "%s(SELF, [[%s]]) EACH(SELF, %s)", f, ls, f);
            return 1;
        }
        if (!admin_target(r, nt > 1 ? tok[1] : "me", ea, sizeof(ea), la, sizeof(la))) BADW(tok[1]);
        _snprintf(code, cn, "%s(%s, [[%s]])", f, ea, la);
        return 1;
    }
    if (!strcmp(tok[0], "fwd") || !strcmp(tok[0], "f")) {
        double m = 3.0;
        char *e;
        int wi = 1;
        if (nt > 1) { double v = strtod(tok[1], &e); if (!*e) { m = v; wi = 2; } }
        if (m > 200) m = 200;
        if (m < -200) m = -200;
        if (!admin_target(r, nt > wi ? tok[wi] : "me", ea, sizeof(ea), la, sizeof(la))) BADW(tok[wi]);
        /* Rotation = (0, pitch, yaw); walking direction = (cos yaw, sin yaw) (checked against Velocity in ws dumps) */
        _snprintf(code, cn, "local a = %s if a == nil then P([[%s not found]]) else local p = GetVarValue(a, \"Position\") "
                  "local y = GetVarValue(a, \"Rotation\"):GetZ() "
                  "TELE(a, [[%s]], p:GetX() + %.2f * COS(y), p:GetY() + %.2f * SIN(y), p:GetZ() + 0.3) end", ea, la, la, m, m);
        return 1;
    }
    if (!strcmp(tok[0], "thru")) {
        if (!admin_target(r, nt > 1 ? tok[1] : "me", ea, sizeof(ea), la, sizeof(la))) BADW(tok[1]);
        /* mirror through the nearest door: 2.5 m past it, on the far side from the player */
        _snprintf(code, cn, "local a = %s if a == nil then P([[%s not found]]) else local d, dn, dd = NEAREST(a) "
                  "if d == nil then P([[no door in this level]]) elseif dd > 20 then P([[nearest door ]] .. dn .. [[ is ]] .. dd .. [[ m away (max 20)]]) "
                  "else local p = GetVarValue(a, \"Position\") local q = GetVarValue(d, \"Position\") "
                  "local dx = q:GetX() - p:GetX() local dy = q:GetY() - p:GetY() local l = DIST(0, 0, dx, dy) if l < 0.1 then l = 0.1 dx = 0.1 end "
                  "P([[through ]] .. dn) TELE(a, [[%s]], q:GetX() + dx / l * 2.5, q:GetY() + dy / l * 2.5, p:GetZ() + 0.3) end end",
                  ea, la, la);
        return 1;
    }
    if (!strcmp(tok[0], "undo")) {
        if (!admin_target(r, nt > 1 ? tok[1] : "me", ea, sizeof(ea), la, sizeof(la))) BADW(tok[1]);
        _snprintf(code, cn, "local a = %s if a == nil then P([[%s not found]]) else local s = Coop_AdminUndo[ [[%s]] ] "
                  "if s == nil then P([[nothing to undo for %s]]) else Coop_AdminUndo[ [[%s]] ] = nil "
                  "local m = Coop_AllowMove Coop_AllowMove = true TeleportCharacter(a, Vector3D(s[1], s[2], s[3]), GetVarValue(a, \"Rotation\")) "
                  "Coop_AllowMove = m P([[%s back to ]] .. s[1] .. \" \" .. s[2] .. \" \" .. s[3]) end end", ea, la, la, la, la, la);
        return 1;
    }
    if (!strcmp(tok[0], "door")) {
        _snprintf(code, cn, "local d, dn, dd = NEAREST(SELF) if d == nil then P([[no door found]]) else "
                  "local was = IsDoorLocked(d) UnLockDoor(d) OpenDoor(d) "
                  "if was then P(dn .. [[ unlocked and opened (]] .. dd .. [[ m)]]) else P(dn .. [[ opened (]] .. dd .. [[ m)]]) end end");
        return 1;
    }
    if (!strcmp(tok[0], "doors")) {
        int open = nt > 1 && !_stricmp(tok[1], "open");
        _snprintf(code, cn, "local i = 1 local p = nil if SELF ~= nil then p = GetVarValue(SELF, \"Position\") end "
                  "while DOORS[i] ~= nil do local d = GetDoorID(DOORS[i]) "
                  "  if d ~= nil and d ~= GetInvalidEntityID() then local s = DOORS[i] "
                  "    if p ~= nil then local q = GetVarValue(d, \"Position\") s = s .. [[ ]] .. DIST(p:GetX(), p:GetY(), q:GetX(), q:GetY()) .. [[ m]] end "
                  "    if IsDoorLocked(d) then s = s .. [[ LOCKED]] end if IsDoorOpened(d) then s = s .. [[ open]] end "
                  "    %s P(s) end i = i + 1 end if i == 1 then P([[no doors in this level]]) end",
                  open ? "UnLockDoor(d) OpenDoor(d) s = s .. [[ -> unlocked+opened]]" : "");
        return 1;
    }
    if (!strcmp(tok[0], "obj") || !strcmp(tok[0], "tasks")) {
        _snprintf(code, cn, "local i = 1 local p = nil if SELF ~= nil then p = GetVarValue(SELF, \"Position\") end "
                  "while OBJS[i] ~= nil do local o = GetObjectiveID(OBJS[i]) "
                  "  if o ~= nil and o ~= GetInvalidEntityID() then local s = OBJS[i] "
                  "    if GetVarValue(o, \"Active\") then s = s .. [[ ACTIVE]] end if GetVarValue(o, \"Completed\") then s = s .. [[ done]] end "
                  "    local q = GetVarValue(o, \"Position\") "
                  "    if p ~= nil and q ~= nil then s = s .. [[ ]] .. DIST(p:GetX(), p:GetY(), q:GetX(), q:GetY()) .. [[ m]] end "
                  "    P(s) end i = i + 1 end if i == 1 then P([[no tasks in this level]]) end");
        return 1;
    }
    if (!strcmp(tok[0], "skip")) {
        if (!admin_target(r, nt > 1 ? tok[1] : "me", ea, sizeof(ea), la, sizeof(la))) BADW(tok[1]);
        /* the active task without sub-tasks (the one the player acts on); else any active one */
        _snprintf(code, cn, "local a = %s if a == nil then P([[%s not found]]) else "
                  "local best = nil local bn = nil local i = 1 "
                  "while OBJS[i] ~= nil do local o = GetObjectiveID(OBJS[i]) "
                  "  if o ~= nil and o ~= GetInvalidEntityID() and GetVarValue(o, \"Active\") then "
                  "    if best == nil or GetVarSize(o, \"Sub-Objectives\") == 0 then best = o bn = OBJS[i] end end "
                  "  i = i + 1 end "
                  "if best == nil then P([[no active task]]) else local q = GetVarValue(best, \"Position\") "
                  "  if q == nil or (q:GetX() == 0 and q:GetY() == 0) then P([[task ]] .. bn .. [[ has no position - try /call with its trigger]]) "
                  "  else P([[skipping to task ]] .. bn) TELE(a, [[%s]], q:GetX(), q:GetY(), q:GetZ() + 0.5) end end end",
                  ea, la, la);
        return 1;
    }
    if (!strcmp(tok[0], "call") && nt > 1) {
        const char *f = tok[1];
        int ok = (isalpha((unsigned char)f[0]) || f[0] == '_'), j;
        for (j = 0; f[j] && ok; j++) ok = isalnum((unsigned char)f[j]) || f[j] == '_';
        if (!ok || strlen(f) > 60) { _snprintf(code, cn, "P([[function name: letters, digits and _ only]])"); return 1; }
        if (!admin_target(r, nt > 2 ? tok[2] : "me", ea, sizeof(ea), la, sizeof(la))) BADW(tok[2]);
        _snprintf(code, cn, "local a = %s if %s == nil then P([[no function %s in this level]]) else "
                  "local m = Coop_AllowMove Coop_AllowMove = true %s(a) Coop_AllowMove = m P([[called %s for %s]]) end",
                  ea, f, f, f, f, la);
        return 1;
    }
    if (!strcmp(tok[0], "god")) {
        if (!admin_target(r, nt > 1 ? tok[1] : "me", ea, sizeof(ea), la, sizeof(la))) BADW(tok[1]);
        _snprintf(code, cn, "local a = %s if a == nil then P([[%s not found]]) elseif IsInGodMode(a) then "
                  "SetGodMode(a, false) P([[%s: god mode off]]) else SetGodMode(a, true) P([[%s: god mode on]]) end",
                  ea, la, la, la);
        return 1;
    }
#undef BADW
    {
        char m[200];
        _snprintf(m, sizeof(m), "[admin] unknown command \"%.40s\" - try /help", tok[0]);
        m[sizeof(m) - 1] = 0;
        admin_say(&r->ctx, m);
    }
    return 0;
}

static void admin_hotkeys(void)
{
    static const int key[9] = { VK_F5, VK_F6, VK_F7, VK_F8, VK_F9, VK_F10, VK_F11, VK_F12, VK_F3 };
    static const int fnum[9] = { 5, 6, 7, 8, 9, 10, 11, 12, 3 };
    static int down[9];
    static const char *cmd[9][2] = { { "/fwd", NULL }, { "/thru", NULL }, { "/door", NULL }, { "/undo", NULL },
                                     { "/bring all", NULL }, { "/goto other", NULL },
                                     { "/heal all", "/ammo all" }, { "/god me", NULL }, { "/skip", NULL } };
    DWORD pid = 0;
    HWND fg;
    int i, ctrl;
    if (!g_admin_hotkeys) return;
    fg = GetForegroundWindow();
    if (!fg) return;
    GetWindowThreadProcessId(fg, &pid);
    if (pid != GetCurrentProcessId()) return;
    ctrl = (GetAsyncKeyState(VK_CONTROL) & 0x8000) != 0;
    for (i = 0; i < 9; i++) {
        int d = ctrl && (GetAsyncKeyState(key[i]) & 0x8000) != 0;
        if (d && !down[i]) {
            plog("[admin] hotkey Ctrl+F%d: %s%s%s", fnum[i], cmd[i][0], cmd[i][1] ? " + " : "", cmd[i][1] ? cmd[i][1] : "");
            admin_enqueue(cmd[i][0], "", 1, &g_admin_last);
            if (cmd[i][1]) admin_enqueue(cmd[i][1], "", 1, &g_admin_last);
        }
        down[i] = d;
    }
}

/* game thread, every simulation update */
static void admin_tick(void)
{
    static char code[6144];
    struct admin_req q[ADMIN_Q];
    int n, i, k;
    if (!g_admin || strcmp(nw_state_name(), "MASTER") != 0) return;
    admin_hotkeys();
    if (g_admin_test[0] && g_mission_started) {
        if (!g_admin_test_at) g_admin_test_at = GetTickCount() + 10000;
        else if (GetTickCount() >= g_admin_test_at) {
            char t[256], *p, *c2;
            strcpy(t, g_admin_test);
            g_admin_test[0] = 0;
            for (p = strtok_s(t, ";", &c2); p; p = strtok_s(NULL, ";", &c2)) {
                while (*p == ' ') p++;
                plog("[admin] admin_test: %s", p);
                admin_enqueue(p, "", 1, NULL);
            }
        }
    }
    admin_lock();
    n = g_admin_qn;
    memcpy(q, g_admin_q, n * sizeof(q[0]));
    g_admin_qn = 0;
    admin_unlock();
    for (i = 0; i < n; i++) {
        if (!admin_build(&q[i], code, sizeof(code))) continue;
        g_admin_nreply = 0;
        g_admin_capture = 1;
        if (lua_run("admin", code, 1) != 0) {
            g_admin_capture = 0;
            admin_say(&q[i].ctx, "[admin] the command failed (Lua error, see the log)");
            continue;
        }
        g_admin_capture = 0;
        for (k = 0; k < g_admin_nreply; k++) admin_say(&q[i].ctx, g_admin_reply[k]);
        if (!g_admin_nreply) admin_say(&q[i].ctx, "[admin] done");
    }
}

static int g_coop_kits = 1;
static char g_kits_file[MAX_PATH] = "Tuning\\Multiplayer\\Equipments.cfg";
typedef void (__fastcall *fn_db_load)(void *db, void *edx, const char *path);
static void kits_reload(void)
{
    BYTE *iface = *(BYTE **)VA(VA_ENGINE_IFACE);
    const char *lvl = NULL;
    char want[MAX_PATH], full[MAX_PATH];
    void *eq, *cl, *tm;
    if (!g_coop_kits || !iface) return;
    __try { lvl = ((const char *(__fastcall *)(BYTE *, void *))(*(void ***)iface)[0x74 / 4])(iface, 0); } __except (EXCEPTION_EXECUTE_HANDLER) { lvl = NULL; }
    strcpy(want, "Tuning\\Multiplayer\\Equipments.cfg");
    if (lvl && lvl[0] && strlen(lvl) < 100) {
        _snprintf(full, sizeof(full), "%sMods\\Bos\\Tuning\\Multiplayer\\Coop\\Equipments_%s.cfg", g_game_dir, lvl);
        full[sizeof(full) - 1] = 0;
        if (GetFileAttributesA(full) != INVALID_FILE_ATTRIBUTES)
            _snprintf(want, sizeof(want), "Tuning\\Multiplayer\\Coop\\Equipments_%s.cfg", lvl);
    }
    want[sizeof(want) - 1] = 0;
    if (!_stricmp(want, g_kits_file)) { plog("[kits] %s: class kits already from %s", lvl ? lvl : "?", want); return; }
    eq = *(void **)VA(0x10266E98); cl = *(void **)VA(0x10266E94); tm = *(void **)VA(0x1025DD34);
    if (!eq || !cl || !tm) { plog("[kits] tuning databases not created yet - kits unchanged"); return; }
    plog("[kits] before the reload (%s):", g_kits_file);
    kits_dump();
    __try {
        ((fn_db_load)VA(0x101995B0))(eq, 0, want);
        ((fn_db_load)VA(0x10197930))(cl, 0, "Tuning\\Multiplayer\\Classes.cfg");
        ((fn_db_load)VA(0x10198DE0))(tm, 0, "Tuning\\Multiplayer\\Teams.cfg");
        strcpy(g_kits_file, want);
        plog("[kits] %s: class kits loaded from %s (classes and teams reloaded after it)", lvl ? lvl : "?", want);
        kits_dump();
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[kits] reloading the kits faulted (%08X) - coop_kits switched off", GetExceptionCode());
        g_coop_kits = 0;
    }
}

/* 0.74 diagnostics: readable MSVC 7.1 strings inside an object (tuning data objects hold their fields as std::string) */
static int obj_strings(BYTE *o, int size, char *out, int n)
{
    int off, len = 0;
    out[0] = 0;
    for (off = 0; off + (int)sizeof(struct vc71_string) <= size; off += 4) {
        struct vc71_string *v = (struct vc71_string *)(o + off);
        const char *t = NULL;
        __try {
            if (v->res < 15 || v->res > 4096 || v->size > v->res || v->size == 0) continue;
            if (v->res >= 16) { if (IsBadStringPtrA(v->bx.ptr, 128)) continue; t = v->bx.ptr; }
            else t = v->bx.buf;
            if (strlen(t) != v->size) continue;
        } __except (EXCEPTION_EXECUTE_HANDLER) { continue; }
        if (len + (int)v->size + 4 >= n) break;
        len += _snprintf(out + len, n - len, "%s+%X=%s", len ? " " : "", off, t);
        off += sizeof(struct vc71_string) - 4;
    }
    return len;
}

/* after a kit reload: every equipment entry's strings (equipment DB +0x14..+0x18 = vector of objects) */
static void kits_dump(void)
{
    BYTE *eq = *(BYTE **)VA(0x10266E98), **b, **e;
    char line[600];
    int i;
    if (!eq) return;
    __try {
        b = *(BYTE ***)(eq + 0x14); e = *(BYTE ***)(eq + 0x18);
        plog("[kits] equipment table now has %d entries", (int)(e - b));
        for (i = 0; b + i < e && i < 64; i++) {
            if (!b[i]) continue;
            obj_strings(b[i], 0xA4, line, sizeof(line));
            if (strstr(line, "WRF_Destroyer_Level_1") || strstr(line, "WRF_Trooper_Level_1")) {
                int k, m = 0;
                char hx[0xA4 * 3 + 8];
                for (k = 0x20; k < 0xA4; k += 4) m += _snprintf(hx + m, sizeof(hx) - m, "%08X ", *(DWORD *)(b[i] + k));
                plog("[kits]   #%d %s  raw+20: %s", i, line, hx);
            }
        }
    } __except (EXCEPTION_EXECUTE_HANDLER) {
        plog("[kits] dump faulted");
    }
}

/* a human character's equipment vars when it appears (Armor and the hit points / mags it got) */
static void kits_char_dump(BYTE *e)
{
    static const char *const names[] = { "Armor", "HelmetHitPoints", "BodyHitPoints", "LegsHitPoints", "ShieldHitPoints",
                                         "MaxHealth", "OneHded_Mags", "TwoHded_Mags", "Heavy_Mags", "Grenade0", "GazGrenade0" };
    BYTE **d, *vl, **v;
    char line[700];
    int n = 0, i, k, len;
    d = ns_descs(5, &n);
    vl = *(BYTE **)(e + 0x18);
    if (!d || !vl) return;
    v = *(BYTE ***)(vl + 4);
    len = _snprintf(line, sizeof(line), "[kits] %s spawned with:", entity_name(e));
    for (k = 0; k < (int)(sizeof(names) / sizeof(names[0])); k++) {
        for (i = 0; i < n && strcmp(ns_desc_name(d[i]), names[k]); i++) {}
        if (i >= n || (int)(*(BYTE ***)(vl + 8) - v) <= i || !v[i]) continue;
        __try {
            BYTE *val = *(BYTE **)(v[i] + 0x14);
            char str[200];
            if (!val) continue;
            if (obj_strings(val, sizeof(struct vc71_string), str, sizeof(str)) > 0)
                len += _snprintf(line + len, sizeof(line) - len, " %s=\"%s\"", names[k], strchr(str, '=') + 1);
            else
                len += _snprintf(line + len, sizeof(line) - len, " %s=%08X(%.1f)", names[k], *(DWORD *)val, *(float *)val);
        } __except (EXCEPTION_EXECUTE_HANDLER) {}
        if (len >= (int)sizeof(line) - 40) break;
    }
    plog("%s", line);
}

static void install_admin_hooks(void)
{
    if (!g_admin) {
        plog("[hook] admin                      off (admin=0)");
        return;
    }
    o_chat = (fn_chat)hook_kt_call_site("admin_chat_host", 0x101030E6, 0x10101520, (void *)hook_chat_local);
    if (!hook_kt_call_site("admin_chat_client", 0x1010532F, 0x10101520, (void *)hook_chat_slave))
        plog("[admin] clients' chat lines are not seen - only hotkeys and the host's lines work");
    if (!o_chat) o_chat = (fn_chat)KVA(0x10101520);
}

static void install_net_hooks(void)
{
    /* mov edi,5 (normal datagram list and split-construction list, 0x10110759 / 0x10110789) */
    static const BYTE e_dgram[] = { 0xBF, 0x05, 0x00, 0x00, 0x00 };
    /* mov dword ptr [esi+14h],1 (fragment datagram list) */
    static const BYTE e_frag[] = { 0xC7, 0x46, 0x14, 0x01, 0x00, 0x00, 0x00 };
    HMODULE ws;
    if (!g_kt_base) return;
    net_patch_imm("net_datagrams", 0x10110747, e_dgram, sizeof(e_dgram), 1, g_net_datagrams);
    net_patch_imm("net_fragments", 0x10110852, e_frag, sizeof(e_frag), 3, g_net_fragments);
    ws = LoadLibraryA("ws2_32.dll");
    if (ws) {
        p_setsockopt = (fn_setsockopt)GetProcAddress(ws, "setsockopt");
        p_getsockopt = (fn_getsockopt)GetProcAddress(ws, "getsockopt");
        p_wsasetlasterror = (fn_wsasetlasterror)GetProcAddress(ws, "WSASetLastError");
    }
    o_socket = (fn_socket)net_hook_import("net_socket_buffers", 0x100F9AA6, 0x15, (void *)hook_socket);
    o_sendto = (fn_sendto)net_hook_import("net_sendto_count", 0x10135A1A, 0x25, (void *)hook_sendto);
    o_recvfrom = (fn_recvfrom)net_hook_import("net_recvfrom_count", 0x10135A14, 0x25, (void *)hook_recvfrom);
    o_send_all = (fn_send_all)hook_kt_call_site("net_send_all_count", 0x10110AF8, 0x101106F0, (void *)hook_send_all);
    {
        /* cmp ecx,3Ch ; jl 0x100B0CB9 */
        static const BYTE e_rs[] = { 0x83, 0xF9, 0x3C, 0x0F, 0x8C };
        BYTE *p = KVA(0x100B0B52), v = (BYTE)(g_net_resync_after > 0 && g_net_resync_after < 0x3C ? g_net_resync_after : 0x3C);
        char found[32];
        if (memcmp(p, e_rs, sizeof(e_rs)) != 0) {
            hexbytes(p, sizeof(e_rs), found);
            plog("[hook] %-26s at 100B0B52: unexpected bytes %s - NOT patched", "net_resync_after", found);
        } else if (v != 0x3C && write_code(p + 2, &v, 1)) {
            plog("[hook] %-26s at 100B0B52 -> client checks the host's checksum %d frames after a resync (engine 60)", "net_resync_after", v);
        } else {
            plog("[hook] %-26s off (engine 60 frames)", "net_resync_after");
        }
    }
    /*
     * 0.45: the host sends a resync one frame sooner. A client's request books it (SetResyncSlot
     * 0x10104370, and 0x10104D21 / 0x10106A16) at the slot 0x101038F0 returns = current frame
     * (+0xDC) + 1; the master's per-frame pass 0x101074C0 sends when slot == frame - 1, i.e. two
     * frames (~125 ms at 16/s) after the request was read, then the client waits for the data:
     * 250-313 ms per resync in the 0.40-0.44 logs. The slot is now the current frame: same exact
     * match, one frame (~62 ms) earlier, the state still labelled with its own frame.
     * lea esi,[edi+1] -> mov esi,edi ; nop  at 0x1010391B.
     */
    if (g_net_resync_early) {
        static const BYTE e_slot[] = { 0x8D, 0x77, 0x01, 0x50, 0x89, 0x74, 0x24, 0x0C };
        static const BYTE p_slot[] = { 0x8B, 0xF7, 0x90 };
        BYTE *q = KVA(0x1010391B);
        char found[40];
        if (memcmp(q, e_slot, sizeof(e_slot)) != 0) {
            hexbytes(q, sizeof(e_slot), found);
            plog("[hook] %-26s at 1010391B: unexpected bytes %s - NOT patched", "net_resync_early", found);
        } else if (write_code(q, p_slot, sizeof(p_slot))) {
            plog("[hook] %-26s at 1010391B -> the host sends a resync 1 frame after the request (engine 2)", "net_resync_early");
        }
    } else {
        plog("[hook] %-26s off (net_resync_early=0)", "net_resync_early");
    }
    o_rs_ask = (fn_rs_ask)hook_kt_call_site("net_resync_count#1", 0x100B0C67, 0x10017A80, (void *)hook_rs_ask_checksum);
    hook_kt_call_site("net_resync_count#2", 0x100B0CB4, 0x10017A80, (void *)hook_rs_ask_predict);
    o_rs_apply = (fn_rs_apply)hook_kt_call_site("net_resync_time#1", 0x100B1B89, 0x100B1A40, (void *)hook_rs_apply);
    hook_kt_call_site("net_resync_time#2", 0x100B1D11, 0x100B1A40, (void *)hook_rs_apply);
    o_desync_check = (fn_desync_check)hook_kt_call_site("net_desync_check_dump", 0x100A9999, 0x100B0A50, (void *)hook_desync_check);
    if (g_net_resync_patience > 0)
        o_ws_csum_check = (fn_ws_csum)hook_kt_call_site("net_resync_patience", 0x100B0B97, 0x100D9810, (void *)hook_ws_csum_check);
    else
        plog("[hook] %-26s off (net_resync_patience=0)", "net_resync_patience");
    InitializeCriticalSection(&g_npc_cs);
    o_read_frame_cmds = (fn_read_frame_cmds)hook_kt_call_site("net_npc_commands_flush", 0x1000D62E, 0x100B0200, (void *)hook_read_frame_cmds);
    o_add_cmd = (fn_add_cmd)hook_kt_vtable("net_npc_commands", 0x10142724, 305, 0x1001D7D0, (void *)hook_add_cmd);
    install_drive_hooks();
    install_npc_state_hooks();
    install_csum_hooks();
    install_admin_hooks();
    o_rv_alive = (fn_rv_alive)hook_call_site("revive_hold", 0x100749F8, 0x10058EF0, (void *)hook_rv_alive);
    o_rv_spawn_queue = (fn_rv_queue)hook_call_site("revive_spawn_queue", 0x10074D2F, 0x100746B0, (void *)hook_rv_spawn_queue);
    if (!o_rv_alive || !o_rv_spawn_queue) { g_revive = 0; plog("[revive] off: hooks not installed"); }
    install_rng_hooks();
}

static void install_hooks(void)
{
    o_rb_tick = (fn_this)hook_call_site("rigid_body_tick_guard", 0x10062263, 0x10060630, (void *)hook_rb_tick);
    o_rb_vars = (fn_this)hook_vtable("rigid_body_vars_log", 0x101FE91C, 1, 0x10060EC0, (void *)hook_rb_vars);
    o_rb_client_load = (fn_this)hook_vtable("rigid_body_client_load_guard", 0x101FE91C, 2, 0x10061D20, (void *)hook_rb_client_load);
    o_rb_slot3 = (fn_rb_this_1)hook_vtable("rigid_body_slot3_guard", 0x101FE91C, 3, 0x10061070, (void *)hook_rb_slot3);
    o_rb_update = (fn_this)hook_vtable("rigid_body_update_guard", 0x101FE91C, 4, 0x10062090, (void *)hook_rb_update);
    o_dobj_update = (fn_dobj_update)hook_vtable("destructible_update_guard", 0x10200E24, 1, 0x10080580, (void *)hook_dobj_update);
    o_dobj_method = (fn_dobj_method)hook_vtable("destructible_method_guard", 0x1020A8D8, 0, 0x10108FD0, (void *)hook_dobj_method);
    o_exo_station_update = (fn_exo_update)hook_vtable("exo_station_update_guard", 0x10202054, 3, 0x1008D840, (void *)hook_exo_station_update);
    o_pickup_update = (fn_this_1)hook_vtable("pickup_update_guard", 0x1020171C, 3, 0x10085F50, (void *)hook_pickup_update);
    o_set_local_player = (fn_this_1)hook_call_site("set_local_player_log#1", 0x1011305E, 0x10110D30, (void *)hook_set_local_player);
    hook_call_site("set_local_player_log#2", 0x10113084, 0x10110D30, (void *)hook_set_local_player);
    hook_call_site("set_local_player_log#3", 0x1019D17E, 0x10110D30, (void *)hook_set_local_player);
    o_player_mp_status = (fn_this)hook_call_site("player_mp_status_guard", 0x1005AE1E, 0x1005A6D0, (void *)hook_player_mp_status);
    o_pickup_light = (fn_this)hook_call_site("pickup_light_guard#1", 0x10086641, 0x100864C0, (void *)hook_pickup_light);
    hook_call_site("pickup_light_guard#2", 0x10086784, 0x100864C0, (void *)hook_pickup_light);
    o_pick_idle_cam = (fn_ptr_this)hook_call_site("idle_camera_guard#1", 0x1019D1BB, 0x1019CA30, (void *)hook_pick_idle_cam);
    hook_call_site("idle_camera_guard#2", 0x1007414C, 0x1019CA30, (void *)hook_pick_idle_cam);
    install_camera_patches();
    install_set_transition_hook();
    if (g_coop_menus) hook_msg_table();
    else plog("[hook] mission screens / career (coop_menus) off - multiplayer start as in 0.13");
    install_save_patch();
    install_ai_hooks();
    install_ready_hooks();
    install_engine_hooks();
    install_npc_equipment_hooks();       /* needs KT_Game.dll (install_engine_hooks finds it) */
    install_end_req_log();
    install_mission_failed_hook();
    install_net_hooks();
    install_difficulty_hook();
}

/* coop_config.ini next to the executable; every key is optional */
static void load_config(void)
{
    char path[MAX_PATH], *slash;
    GetModuleFileNameA(NULL, path, MAX_PATH);
    slash = strrchr(path, '\\');
    if (slash) slash[1] = 0; else path[0] = 0;
    strcat(path, "coop_config.ini");
    strcpy(g_config_path, path);
    g_force_ready = GetPrivateProfileIntA("proxy", "force_begin_play", 1, path);
    g_skip_failed_entities = GetPrivateProfileIntA("proxy", "skip_failed_entities", 1, path);
    g_run_mission_scripts = GetPrivateProfileIntA("proxy", "run_mission_scripts", 1, path);
    g_coop_shop = GetPrivateProfileIntA("proxy", "coop_shop", 1, path);
    g_coop_block_load = GetPrivateProfileIntA("proxy", "coop_block_load", 1, path);
    g_coop_block_save = GetPrivateProfileIntA("proxy", "coop_block_save", 1, path);
    g_coop_next_level = GetPrivateProfileIntA("proxy", "coop_next_level", 1, path);
    g_coop_movies = GetPrivateProfileIntA("proxy", "coop_movies", 1, path);
    g_coop_bos_start = GetPrivateProfileIntA("proxy", "coop_bos_start", 1, path);
    g_coop_bos_camera = GetPrivateProfileIntA("proxy", "coop_bos_camera", 1, path);
    g_coop_bos_countdown = GetPrivateProfileIntA("proxy", "coop_bos_countdown", 1, path);
    g_coop_remove_props = GetPrivateProfileIntA("proxy", "coop_remove_props", 1, path);
    g_ai_humans = GetPrivateProfileIntA("proxy", "ai_humans", 1, path);
    g_net_csum_bullets = GetPrivateProfileIntA("proxy", "net_csum_bullets", 0, path);
    g_net_csum_cosmetic = GetPrivateProfileIntA("proxy", "net_csum_cosmetic", 0, path);
    g_net_sync_freeze = GetPrivateProfileIntA("proxy", "net_sync_freeze", 1, path);
    g_net_npc_state = GetPrivateProfileIntA("proxy", "net_npc_state", 1, path);
    g_input_fix = GetPrivateProfileIntA("proxy", "input_fix", 1, path);
    g_client_cutscenes = GetPrivateProfileIntA("proxy", "client_cutscenes", 0, path);
    g_tp_fix = GetPrivateProfileIntA("proxy", "client_teleport_fix", 0, path);
    g_guard_pfreeze = GetPrivateProfileIntA("proxy", "guard_player_freeze", 1, path);
    g_net_csum_npcs = GetPrivateProfileIntA("proxy", "net_csum_npcs", 0, path);
    g_coop_fail_restart = GetPrivateProfileIntA("proxy", "coop_fail_restart", 8, path);
    g_net_datagrams = GetPrivateProfileIntA("proxy", "net_datagrams", 64, path);
    g_net_fragments = GetPrivateProfileIntA("proxy", "net_fragments", 64, path);
    g_net_sockbuf = GetPrivateProfileIntA("proxy", "net_sockbuf", 8 << 20, path);
    g_net_resync_after = GetPrivateProfileIntA("proxy", "net_resync_after", 60, path);
    g_net_resync_gap = GetPrivateProfileIntA("proxy", "net_resync_gap", 0, path);
    g_net_resync_early = GetPrivateProfileIntA("proxy", "net_resync_early", 1, path);
    g_net_resync_patience = GetPrivateProfileIntA("proxy", "net_resync_patience", 32, path);
    g_net_csum_script = GetPrivateProfileIntA("proxy", "net_csum_script", 0, path);
    g_net_script_state = GetPrivateProfileIntA("proxy", "net_script_state", 1, path);
    g_net_human_state = GetPrivateProfileIntA("proxy", "net_human_state", 1, path);
    g_net_npc_commands = GetPrivateProfileIntA("proxy", "net_npc_commands", 1, path);
    g_net_npc_drive = GetPrivateProfileIntA("proxy", "net_npc_drive", 1, path);
    g_net_trace = GetPrivateProfileIntA("proxy", "net_trace", 1, path);
    g_net_csum = GetPrivateProfileIntA("proxy", "net_csum", 1, path);
    g_net_csum_physics = GetPrivateProfileIntA("proxy", "net_csum_physics", 0, path);
    g_admin = GetPrivateProfileIntA("proxy", "admin", 1, path);
    g_net_rng_private = GetPrivateProfileIntA("proxy", "net_rng_private", 1, path);
    g_net_rng_frame = GetPrivateProfileIntA("proxy", "net_rng_frame", 1, path);
    g_admin_clients = GetPrivateProfileIntA("proxy", "admin_clients", 1, path);
    {
        char dv[16]; int i;
        GetPrivateProfileStringA("proxy", "difficulty", "easy", dv, sizeof(dv), path);
        for (i = 0; i < DIFF_N; i++) if (!_stricmp(dv, g_diff_names[i])) g_difficulty = i;
        if (!_stricmp(dv, "normal")) g_difficulty = 1;
        g_champions = GetPrivateProfileIntA("proxy", "champions", 1, path);
        {
            char w[32];
            g_party_lives = GetPrivateProfileIntA("proxy", "party_lives", 0, path);
            GetPrivateProfileStringA("proxy", "lives_action", "restart", w, sizeof(w), path);
            g_lives_action = act_parse(w) < 0 ? ACT_RESTART : act_parse(w);
            GetPrivateProfileStringA("proxy", "wipe_action", "off", w, sizeof(w), path);
            g_wipe_action = act_parse(w) < 0 ? ACT_OFF : act_parse(w);
            g_revive = GetPrivateProfileIntA("proxy", "revive", 1, path);
            g_coop_kits = GetPrivateProfileIntA("proxy", "coop_kits", 1, path);
            GetPrivateProfileStringA("proxy", "revive_time", "4", w, sizeof(w), path);
            if (atof(w) > 0) g_rv_time = (float)atof(w);
            GetPrivateProfileStringA("proxy", "revive_radius", "12", w, sizeof(w), path);
            if (atof(w) > 0) g_rv_radius = (float)atof(w);
            g_rv_bleed = GetPrivateProfileIntA("proxy", "revive_bleedout", 90, path);
            g_rv_key = GetPrivateProfileIntA("proxy", "revive_key", VK_SPACE, path);
        }
        if (g_champions < 1 || g_champions > 3) g_champions = 1;
    }
    g_admin_hotkeys = GetPrivateProfileIntA("proxy", "admin_hotkeys", 1, path);
    GetPrivateProfileStringA("proxy", "admin_test", "", g_admin_test, sizeof(g_admin_test), path);
    g_net_dump_ws = GetPrivateProfileIntA("proxy", "net_dump_ws", 1, path);
    g_net_dump_ws_max = GetPrivateProfileIntA("proxy", "net_dump_ws_max", 10, path);
    g_keep_mp_model = GetPrivateProfileIntA("proxy", "coop_keep_mp_model", 1, path);
    g_career_fpim = GetPrivateProfileIntA("proxy", "coop_career_fpim", 0, path);
    GetPrivateProfileStringA("proxy", "coop_career", "", g_career_save, sizeof(g_career_save), path);
    g_npc_equipment = GetPrivateProfileIntA("proxy", "npc_equipment", 1, path);
    g_coop_save = GetPrivateProfileIntA("proxy", "coop_save", 0, path);
    GetPrivateProfileStringA("proxy", "test_lua", "", g_test_lua, sizeof(g_test_lua), path);
    GetPrivateProfileStringA("proxy", "coop_lua", "coop_mission.lua", g_coop_lua, sizeof(g_coop_lua), path);
    g_ai_init = GetPrivateProfileIntA("proxy", "ai_init", 1, path);
    g_ai_kernel_on_sim = GetPrivateProfileIntA("proxy", "ai_kernel_on_sim", 0, path);
    GetPrivateProfileStringA("proxy", "ai_player", "", g_ai_player, sizeof(g_ai_player), path);
    GetPrivateProfileStringA("proxy", "coop_team_from", "Player", g_team_from, sizeof(g_team_from), path);
    GetPrivateProfileStringA("proxy", "team_test", "", g_team_test, sizeof(g_team_test), path);
    g_npc_input_block = GetPrivateProfileIntA("proxy", "npc_input_block", 1, path);
    /* 0.21: the single-player mission screens + career experiment (0.14-0.20) is off unless
       coop_menus=1 - the game then starts exactly as in 0.13 (MP class pick, no career). */
    g_coop_menus = GetPrivateProfileIntA("proxy", "coop_menus", 0, path);
    if (!g_coop_menus) {
        g_coop_shop = 0;
        strcpy(g_career_save, "-");
    }
}

static void fatal(const char *msg)
{
    plog("[fatal] %s", msg);
    MessageBoxA(NULL, msg, "CoopMod proxy", MB_OK | MB_ICONERROR);
    ExitProcess(1);
}

static BOOL CALLBACK init_once(PINIT_ONCE once, PVOID param, PVOID *ctx)
{
    char path[MAX_PATH], *slash, msg[512];
    IMAGE_NT_HEADERS *nt;
    int i;
    (void)once; (void)param; (void)ctx;

    GetModuleFileNameA(g_self, path, MAX_PATH);
    slash = strrchr(path, '\\');
    if (slash) slash[1] = 0; else path[0] = 0;
    strcat(path, "Bos_core.dll");

    g_core = LoadLibraryExA(path, NULL, LOAD_WITH_ALTERED_SEARCH_PATH);
    if (!g_core) {
        _snprintf(msg, sizeof(msg), "Could not load %s (error %lu).\n\nThe co-op proxy is installed "
                  "but the original Bos.dll is missing. Run CoopMod\\uninstall.ps1 or verify the "
                  "game files in Steam.", path, GetLastError());
        fatal(msg);
    }
    g_core_base = (BYTE *)g_core;
    nt = (IMAGE_NT_HEADERS *)(g_core_base + ((IMAGE_DOS_HEADER *)g_core_base)->e_lfanew);
    g_core_size = nt->OptionalHeader.SizeOfImage;
    plog("Bos_core.dll loaded at %p (size 0x%X, timestamp %08X)", g_core_base, g_core_size,
         nt->FileHeader.TimeDateStamp);

    for (i = 0; i < NUM_EXPORTS; i++) {
        if (strcmp(g_export_names[i], "ExportModOnBeforeLoadingLevel") == 0)
            g_idx_before_loading = i;
        if (strcmp(g_export_names[i], "ExportUpdateSimulationMod") == 0)
            g_idx_update_sim = i;
        if (strcmp(g_export_names[i], "ExportStartPlayingMovie") == 0) g_idx_movie_start = i;
        if (strcmp(g_export_names[i], "ExportStopPlayingMovie") == 0) g_idx_movie_stop = i;
        if (strcmp(g_export_names[i], "ExportUpdateRenderModAfterAll") == 0)
            g_idx_render = i;
        g_real[i] = GetProcAddress(g_core, g_export_names[i]);
        if (!g_real[i]) {
            _snprintf(msg, sizeof(msg), "Bos_core.dll does not export %s", g_export_names[i]);
            fatal(msg);
        }
    }

    /* every hook below was derived from this exact build of Bos.dll */
    if (nt->FileHeader.TimeDateStamp != 0x43369397u)
        plog("[hook] Bos_core.dll timestamp differs from the analysed build; hooks will verify bytes individually");
    load_config();
    install_hooks();
    CloseHandle(CreateThread(NULL, 0, watchdog_thread, NULL, 0, NULL));
    return TRUE;
}

static INIT_ONCE g_init = INIT_ONCE_STATIC_INIT;

/* ------------------------------------------------------------------------ */
/* export tracing                                                           */
/* ------------------------------------------------------------------------ */

static volatile LONG g_calls[64];
static volatile LONG g_calls_reported[64];
static DWORD g_last_summary;

static void summarise_calls(void)
{
    char line[900];
    int i, n = 0;
    line[0] = 0;
    for (i = 0; i < NUM_EXPORTS; i++) {
        LONG c = g_calls[i] - g_calls_reported[i];
        if (!c) continue;
        g_calls_reported[i] += c;
        n += _snprintf(line + n, sizeof(line) - n, " %s=%ld", g_export_names[i] + 6, c);
        if (n > (int)sizeof(line) - 80) {
            plog("[calls]%s", line);
            n = 0;
            line[0] = 0;
        }
    }
    if (n) plog("[calls]%s", line);
}

static void on_level_loading(void)
{
    /* the diagnostics log the first few events per level, not per process */
    g_rb_vars_calls = 0;
    g_rb_skips = 0;
    g_pickup_skips = 0;
    g_player_mp_skips = 0;
    g_ready_nlogged = 0;
    g_engine_logs = 0;
    g_idle_cam_fails = 0;
    g_save_log_lines = 0;
    g_entities_skipped = 0;
    g_mission_pending = 0;
    g_mission_started = 0;
    g_mission_armed = 0;
    g_coop_lua_loaded = 0;
    memset(g_ai_pos_ent, 0, sizeof(g_ai_pos_ent));
    g_cam_mode = -1;
    g_cam_state = -99;
    g_cam_target = g_cam_trans = g_cam_idle = NULL;
    g_cam_logs = 0;
    plog("[level] loading; forced-ready answers so far this process: %ld", g_ready_forced);
    log_selected_map();
}

/* cdecl, called from the naked stubs with all registers saved */
void __cdecl trace_export(int idx, DWORD *esp)
{
    static const char *last_state;
    const char *state;
    LONG n;
    InitOnceExecuteOnce(&g_init, init_once, NULL, NULL);
    state = nw_state_name();
    if (state != last_state) {
        plog("[state] engine network state: %s", state);
        last_state = state;
    }
    if (idx == g_idx_before_loading)
        on_level_loading();
    if (idx == g_idx_movie_start) {
        g_movie_active = 1;
        g_movie_pre_mode = g_cam_mode;
        g_movie_pre_state = g_cam_state;
        plog("[movie] started (camera mode %d, player State %d)", g_cam_mode, g_cam_state);
    }
    if (idx == g_idx_movie_stop) {
        g_movie_active = 0;
        g_movie_check_at = GetTickCount() + 700;
        plog("[movie] stopped (camera mode %d)", g_cam_mode);
    }
    if (idx == g_idx_update_sim && g_spawn_report_pending) {
        g_spawn_report_pending = 0;
        spawn_report();
        entity_census("round started");
    }
    if (idx == g_idx_update_sim && g_census_due && GetTickCount() >= g_census_due) {
        g_census_due = 0;
        entity_census("15 s after mission start");
    }
    if (idx == g_idx_update_sim) {
        camera_watch();
        ai_report();
        ai_bind_humans();
        coop_tick();
        merc_watch();
        admin_tick();
        if (g_mission_started) bos_arena_watch();
        if (g_mission_started) rb_strip_all("new props");
        ws_dump_host_tick();
        shop_watch();
        if (g_ai_kernel_on_sim) ai_kernel_on_sim();
    }
    if (idx == g_idx_render || idx == g_idx_update_sim) {
        if (!g_main_tid) g_main_tid = GetCurrentThreadId();
        g_last_frame_tick = GetTickCount();
    }
    if (idx == g_idx_render)
        run_state_watch();
    if (idx == g_idx_update_sim && g_mission_pending && GetTickCount() >= g_mission_pending_at) {
        g_mission_pending = 0;
        g_mission_started = 1;
        lives_reset();
        mission_bootstrap();               /* runs before the mod's own UpdateSimulation */
        difficulty_apply(NULL, 0);
        if (strcmp(nw_state_name(), "MASTER") == 0) {
            char cc[64];
            _snprintf(cc, sizeof(cc), "Coop_ChampionCount = %d", g_champions); cc[sizeof(cc) - 1] = 0;
            lua_run("champions per fight", cc, 0);
        }
        entity_census("after InitLevel");
        g_census_due = GetTickCount() + 15000;
    }
    n = InterlockedIncrement(&g_calls[idx]);
    if (g_export_per_frame[idx]) {
        if (n <= 2) {
            InterlockedIncrement(&g_calls_reported[idx]);
            plog("%s(%08X, %08X, %08X, %08X)  [per-frame; first calls only]",
                 g_export_names[idx], esp[1], esp[2], esp[3], esp[4]);
        }
        if (GetTickCount() - g_last_summary > 30000) {
            g_last_summary = GetTickCount();
            summarise_calls();
        }
    } else if (n <= 200) {
        InterlockedIncrement(&g_calls_reported[idx]);
        plog("%s(%08X, %08X, %08X, %08X)", g_export_names[idx], esp[1], esp[2], esp[3], esp[4]);
    }
}

/*
 * One naked stub per export: save everything, log, restore everything, then
 * tail-jump to the original so it sees exactly the caller's stack.
 */
#define EXPORT_STUB(i, name)                                         \
    __declspec(naked) void Stub_##name(void)                         \
    {                                                                \
        __asm pushad                                                 \
        __asm lea eax, [esp + 32]                                    \
        __asm push eax                                               \
        __asm push i                                                 \
        __asm call trace_export                                      \
        __asm add esp, 8                                             \
        __asm popad                                                  \
        __asm jmp dword ptr [g_real + i * 4]                         \
    }

#include "exports_gen_stubs.h"

/* exported through bos_proxy.def; lets tools tell the proxy from the original */
const char *__cdecl CoopMod_Version(void)
{
    return COOPMOD_VERSION;
}

BOOL WINAPI DllMain(HINSTANCE inst, DWORD reason, LPVOID reserved)
{
    (void)reserved;
    if (reason == DLL_PROCESS_ATTACH) {
        char *slash;
        g_self = inst;
        GetModuleFileNameA(inst, g_game_dir, MAX_PATH);
        slash = strrchr(g_game_dir, '\\');
        if (slash) slash[1] = 0;
        g_t0 = GetTickCount();
        g_last_summary = g_t0;
        DisableThreadLibraryCalls(inst);
        InitializeCriticalSection(&g_log_cs);
        log_open();
        plog("%s attached (pid %lu)", COOPMOD_VERSION, GetCurrentProcessId());
        AddVectoredExceptionHandler(0, crash_handler);
    } else if (reason == DLL_PROCESS_DETACH) {
        summarise_calls();
        plog("detach");
    }
    return TRUE;
}
