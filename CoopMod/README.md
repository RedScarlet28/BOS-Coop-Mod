# CoopMod â€” proxy for `Bos.dll`

Native layer of the Bet On Soldier campaign co-op project. It sits between the engine
(`KT_Game.dll`) and the game's mod DLL so we can fix and instrument the mod without
editing it.

```
KT_Game.dll --LoadLibrary("Bos.dll")--> CoopMod proxy (this)  --> Bos_core.dll (original Bos.dll, untouched)
```

## Commands

Run from the game folder (Windows PowerShell 5.1 is enough; `pwsh` is not installed here):

| Task | Command |
|---|---|
| Build + offline test | `powershell -NoProfile -ExecutionPolicy Bypass -File CoopMod\build.ps1` |
| Install into the game | `powershell -NoProfile -ExecutionPolicy Bypass -File CoopMod\install.ps1` |
| Remove (restore original `Bos.dll`) | `powershell -NoProfile -ExecutionPolicy Bypass -File CoopMod\uninstall.ps1` |
| Remove everything co-op related | `powershell -NoProfile -ExecutionPolicy Bypass -File .\coop_uninstall.ps1` |

`install.ps1` only proceeds if `Bos.dll` is the original (SHA-256 `3DFB6EF3â€¦5395`) or the
proxy is already installed. The original is kept byte-for-byte as `Bos_core.dll`. Steam's
"Verify integrity of game files" also undoes the install.

## What it does

1. **Exports all 64 `Export*` entry points.** The engine resolves every one by name and
   aborts mod loading if one is missing. Each export is a naked stub that logs the call and
   jumps to the original with registers and stack untouched. Names come from the real export
   table (`proxy/gen_exports.py`), never typed by hand.
2. **Installs verified hooks into `Bos_core.dll`.** Every hook compares the exact original
   bytes / vtable entry first and refuses to patch anything else.

| Hook | Where (Bos.dll VA) | Why |
|---|---|---|
| `rigid_body_tick_guard` | call site `0x10062263` â†’ `0x10060630` | `SINGLE_RIGID_BODY::Update` always calls `0x10060630`, which dereferences the model's `collision_center` node (`this+0x54`). In MP the model was never loaded â†’ crash at `Bos+0x60639` (COOP_5, COOP_8). Skips the call when the node is NULL. |
| `pickup_update_guard` | `PICKUP` vtable `0x1020171C` slot 3 | `PICKUP::Update` reads the local player's character (`BosGame+4`). In MP that is NULL until you spawn â†’ crash at `Bos+0x85F90` (COOP_3, COOP_4). Skips the update while it is NULL. |
| `player_mp_status_guard` | call site `0x1005AE1E` â†’ `0x1005A6D0` | `PLAYER::Update` (MP master only) reads the `BOS_RULES` entity that `BeginPlayLevel` creates. Without it â†’ crash at `Bos+0x5A710` (COOP_6, COOP_8). Skips that update while it is missing. |
| `begin_play_readiness` | slots 18/19 of 52 entity vtables (`proxy/ready_hooks_gen.h`) | The engine starts a level only if *every* entity answers "ready". Logs each entity that says no (`[ready] NOT READY â€¦ handle=â€¦`) and, with `force_begin_play=1` in `coop_config.ini`, answers "ready" for it. |
| `load_entity_skip_failed` | `KT_Game` call site `0x1008D8BD` â†’ `0x1008CD80` | **The key fix.** The engine aborts the whole scene, and with it BeginPlay, on the first entity it can't load. In MP, 26 of the campaign's 126 `Glow` effects overflow their pool. Skips just the failed entity (`skip_failed_entities=1`). |
| `engine_loader_log` | `KT_Game` `0x1008B1F0` (6-byte detour) | Copies the engine scene/save loader's own messages, normally discarded, into our log as `[engine] â€¦`. |
| `idle_camera_guard` Ã—2 | call sites of `0x1019CA30` | MP spawn camera picker divides by the number of `MULTI_IDLE_CAMPOINT`s. With none â†’ no spawn camera instead of a crash. |
| `cutscene_camera_mp` | `0x1009C462` (2 bytes) | The camera manager draws a cut-scene camera (mode 6) only in solo. The `je` after the `IsSolo` check becomes two `nop`s, so mission cut-scenes move the camera in MP. |
| `engine_is_solo_wrap` + `npc_equipment` | KT vtable `0x10142724` slot 112; `CHARACTER` vtable `0x101F6714` slot 1 | A character's weapons (from its `Arsenal`) and armor are created only in solo. In MP the engine's IsSolo answers true while a non-human character's vars are applied (`npc_equipment=1`). Humans are recognised by the names the MP connect routine gives their characters (`human_player_names`, call site `0x101403EE`). |
| `end_level_to_restart` (`coop_next_level`) | engine vtable `0x10142724` slots 0x70 / 0x80; `LEVEL_CYCLE_MANAGER` vtable `0x1014F9AC` slot 5 | The campaign's EndOfLevel (no BOS mission) unloaded the level and left the session in the menu. On the MP host it becomes the master restart (slot 0x57C) and the next map comes from `[next_level]` (default `COOP_Patrol` -> `COOP_Patrol_2`). |
| `coop_bos_start` | calls `0x101854A0` before `InitLevel` | Sets up the champion fight the solo way for a level without a mission (Debug.lua's champion, Master Loa in COOP_Patrol_2). |
| `display_mission_failed` (`coop_fail_restart`) | push at `0x10094904` (`0x10165100`) | A lost champion fight restarts the level after N seconds (default 8) instead of the solo failure screen. |
| `net_datagrams`, `net_fragments`, `net_sockbuf` | KT `0x10110747` / `0x10110852` (immediates in SendAllDatagramm `0x101106F0`); `socket`/`sendto`/`recvfrom` import slots | The engine sends at most 5 normal datagrams and 1 fragment datagram (1400 bytes) per connection per send. Campaign levels have several times the entities of an MP map, so the client's world lagged. Raised to 64 / 64, UDP buffers 8 MB; `[net]` reports traffic every 10 s. |
| `net_resync_after` | KT `0x100B0B52` (slave desync check `0x100B0A50`); resync calls `0x100B0C67`/`0x100B0CB4`/`0x100B1B89`/`0x100B1D11` | The client waits 60 frames after a resync before it compares its world with the host's again, so a client that drifts (campaign AI and scripts run on the host only) was corrected only every ~4 s. Configurable; default stays 60 (4 frames in 0.24 made the client rebuild its world ~2x per second and stop showing models). Client side: the client must run the proxy. |
| `coop_save_station` | `0x10089F26` (6 bytes) | Skips the engine save from a save station in MP (`coop_save=0`): saving stopped the multiplayer simulation. The station is still used up. |
| `[run]` / `[hang]` | per frame / watchdog thread | Logs changes of the engine's window-active / simulation / pause flags, and samples the game thread when no frame runs for 5 s. |
| NPC AI (`ai_init`) | calls `0x101128F0` at mission start | MP never builds the AI world (solo-only block of `BeginPlayLevel`), so NPCs never walked, followed or fought. The host builds it after `InitLevel`. Needs the level's AI files in `Mods\Bos\Levels\<level>\AI`. `[ai]` lines report AI files, ticks, thinks, orders and how many NPCs moved. |
| `npc_player_input` (`npc_input_block`) | `PLAYER` vtable `0x101FE0DC` slot 3 (`0x1005AEF0`) | NPCs move and fire only through input commands the engine hands their PLAYER (axes `+0x18/+0x1C`, buttons `+0x20/+0x24`). In MP the PLAYER update clears the character's command instead when the PLAYER's `+0x4C` var is 0 (`0x1005AE3A`). For NPC PLAYERs: empty commands are dropped; real ones run the update with IsSolo forced, as in solo. `[ai]` reports count them by caller. |
| `ai_bind_humans` | calls `0x100A82A0` once a second (MP host) | Gives every human character without an AI agent the AI's "Player" agent, so enemies can target clients and respawned players, not only the host's first character. |
| `coop_team` (`coop_team_from`) | once a second (MP host), via the game's `SetVarValue` | Friend or foe is the CHARACTER `Team` var (None/WRF/UAN/SYNDICATE/RESISTANCE, cached at `+0x24C`); the AI treats equal and not None as friends. MP characters get their MP team, so friendly NPCs shot the players. Every human character gets the Team of the scene's campaign player (`Player`). `team_test=<NPC>` treats one NPC the same way (dedicated-server test). |
| `coop_shop`, `shop_messages` | game message table `0x10251B28` entries 5/6; calls `0x10110970`, `0x1013FC40` | Experimental: opens the solo mission screens (briefing, BOS, mercenaries, weapons) for the host when the co-op mission starts; `OnMissionBegins` waits for their Launch (message 6, fallback 180 s). `coop_shop=0` turns it off. |
| `npc_weapons` | `CHARACTER` vtable `0x101F6714` slot 2 (`0x10010440`) | Builds the weapon inventory (`+0x44`) from the arsenal, solo only (`0x100105E5`). Same forced-IsSolo treatment as `npc_equipment`. The engine skips this step on the dedicated server (no renderer). |
| `ai_*_count`, `group_vars_log` | AI update call sites / vtables | Diagnostic counters for the `[ai]` report; logs GROUPs left without members. |
| co-op Lua layer (`coop_lua`) | `lua_dostring` (KT `0x100CD260`) | Runs `coop_mission.lua` on the host before `InitLevel`: logs cut-scene steps, releases the host after 45 s of black bars / locked controls with no camera sequence. `test_lua` runs a test file the same way. |
| mission start + `camera_watch` | per simulation frame (host) | Starts the level's `InitLevel` / `OnMissionBegins` once the host is in first person (`run_mission_scripts=1`); sends a cut-scene that ends on the spawn camera back to first person; logs `[camera]` changes. |
| level-start logs | `KT_Game` `0x10029D60`, `0x1000C2C0`, readiness vtables, `0x1008DDB0`, `0x1008D720` | Diagnostic: `[begin]` / `[load]` lines for each step of starting a level. |
| `rigid_body_vars_log` | `SINGLE_RIGID_BODY` vtable `0x101FE91C` slot 1 | Diagnostic: logs whether the model / physics actor got created. |
| `set_local_player_log` Ã—3 | call sites of `0x10110D30` | Diagnostic: logs when and from where the local player is bound. |

3. **Logs crashes.** A vectored exception handler records faults inside the game's own DLLs
   with registers and a module-relative stack (`Bos+0xâ€¦ (VA 1006â€¦)`, directly comparable to
   a disassembly listing).

The guards are **scaffolding**: they let a campaign scene keep running in a multiplayer
session so we can find every remaining failure in one test. The real co-op behaviour (e.g.
pickups usable by any player, not just the host) replaces them later.

## Logs

One file per run in `coop_logs\<exe>_<yyyymmdd_hhmmss>.log` next to `BoS.exe`;
`coop_proxy.log` holds the path of the latest one.

To turn a logged `handle=â€¦` into an entity name:
`python CoopMod\tools\kts_handles.py <level>.kts --log <log file>`

## Level tools (`tools\`)

| Tool | Purpose |
|---|---|
| `kts.py` | Scene (`.kts`) reader/writer with exact RIFF framing (server `SVEN` / client `CLEN` sections, typed blocks, entities, variables by name). Round-trips shipped scenes byte-for-byte. |
| `build_coop_scene.py` | Campaign scene + MP spawn points / spawn areas / spawn cameras, placed on given walkable spots. Used for `COOP_Patrol` and `COOP_8`. |
| `kt3_add_sectors.py` | Adds named sector volumes (`SECT`) from one `Events.kt3` to another, optionally moved (`--move-to`). |
| `make_testenv.ps1` | Builds `CoopMod\testenv\`: an isolated copy of the game (hard links / junctions) with its own `Bos.dll` and settings. |
| `run_dedicated.ps1 <map> [s] [-Maps "A,B"] [-TimeLimit min]` | Hosts a map on the dedicated server in the test install for a few seconds and prints the proxy log. `-Maps` adds maps to the cycle, `-TimeLimit` sets the round length. |

Mission tests on the dedicated server (it has no local player, no animations, no renderer): in
`testenv\coop_config.ini` set `run_mission_scripts=2` (mission starts 3 s after BeginPlay),
`test_lua=<file>` (a script from `test\lua`, run before `InitLevel`; stubs the presentation
calls the server cannot run), `ai_player=Player` (character that stands in for the host during
the AI setup) and `ai_kernel_on_sim=1` (drives the AI kernel from the simulation step; normally
the render export does). `coop_test_solberg.lua` checks the General's AI orders,
`coop_test_cine.lua` the cut-scene release (needs `CoopCine_Skip = false`), `coop_test_group.lua`
`FreezeAll` on a group, `coop_test_story.lua` the whole story with cut-scenes and dialogue skipped.

Decompiled C for every function Ghidra found in `Bos_core.dll` is in `decomp\functions\0x<VA>.c`
(REA + Ghidra 12.1.4; addresses are the same VAs as in `dumpbin`). Functions reached only through
a vtable are sometimes missing (e.g. `0x10011C40`); disassemble those with `dumpbin /disasm /range:`.

Do not use `.tools\kts_merge.py` / `kts_inject.py`: they corrupt scenes (see `COOP_STATUS.md`).

## Files

```
CoopMod\
  build.ps1, install.ps1, uninstall.ps1
  proxy\bos_proxy.c          proxy source
  proxy\gen_exports.py       generates exports_gen_*.h and bos_proxy.def from the original DLL
  test\loadtest.c            offline test (run by build.ps1)
  test\lua\*.lua             dedicated-server mission tests (copied into testenv)
..\coop_mission.lua          co-op Lua layer the proxy runs on the host (cut-scene log + release)
  bin\Bos.dll                build output
```

The offline test loads the proxy with `Bos_core.dll` forced away from its preferred base
(as in the game), resolves all 64 exports, forwards a call, drives both guards with fake
objects, and runs a negative control: an unpatched copy of the original must fault at
exactly `+0x60639`, the in-game crash.
