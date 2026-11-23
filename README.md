# Bet On Soldier — Campaign Co-op Mod

Play the **Bet On Soldier** single-player campaign together with friends over LAN
(or a virtual LAN such as Radmin VPN / ZeroTier).

The campaign levels run inside a multiplayer session. A proxy DLL (`Bos.dll` → original kept
as `Bos_core.dll`) fixes the places where the game's code assumes a single player, and keeps
both PCs in sync.

WARNING! SKIP FIRST MISSION COOP_PATROL1 IF YOU WANT, IT IS JUST A TUTORIAL MISSION AND I HAVE CUT OUT THE CUTSCENES/VOICELINES SINCE THEY WERE HOLDING THE PACING BACK ALOT!.

## Features

- **The whole campaign in co-op**: 32 co-op levels (`COOP_<level>`), chained in story order.
  When a level is finished, everyone moves on to the next one together.
- Enemy and friendly **AI**, mission scripts, objectives, doors and triggers all work for every player.
- **Champion (BOS) fights**, including more champions per fight for bigger groups (`/champions`).
- **Revive**: a downed player stays down. A teammate standing near the body for a few seconds
  gets them back up. The body is marked on the minimap, and a line at the top of the screen shows how far
  away it is. The downed player can give up and respawn at any time (`/giveup`, or hold Space).
- **In-game co-op menu** (**Insert**): change difficulty, revive, lives and champions, or use the
  unstuck/teleport/restart actions, without typing commands. A client's changes are sent to the host.
- **Party lives**: a shared pool of lives, with an action when it runs out, e.g. restart the
  mission (`/lives`, `/wipe`).
- **Mission-honest loadouts**: the multiplayer class screen only offers kits built from the
  weapons and armour the solo mission allows.
- **Difficulty** for co-op (`/difficulty`), admin/rescue chat commands (`/help`), and a lost
  fight restarts the level.
- Netcode work for the campaign's much bigger worlds: NPC commands and script changes are
  shared between the PCs, and resyncs are rare and short.

## Requirements

- Bet On Soldier (Steam version; the mod checks for the original `Bos.dll`, SHA-256 `3DFB6EF3…5395`).
- **Every player** installs the mod. The host and the clients must have the same version.

## Install

1. Close the game.
2. Copy the contents of this repository into your `Bet On Soldier` folder (the one with
   `BoS.exe`) and overwrite when asked.
3. Run `CoopMod\install.bat`. It must say `OK: Bos_core.dll exists`. Your original `Bos.dll`
   is kept as `Bos_core.dll`.
4. Start the game once. A `coop_logs` folder should appear next to `BoS.exe`.
   No `coop_logs` folder means the co-op DLL isn't running.

**Uninstall:** run `CoopMod\uninstall.ps1`, or use Steam's "Verify integrity of game files".

## Playing

- **Host:** Multiplayer → Create (LAN). Pick a `COOP_…` map, e.g. `COOP_Patrol`, the first mission.
- **Others:** Multiplayer → LAN → join the host's game.
- Pick a class on the spawn screen. Its kit only contains weapons the current mission allows.
- Press **Insert** for the co-op menu (Up/Down pick, Left/Right change, Enter runs an action), or type
  `/help` and `/help2` in chat to list the commands.

| Command | What it does |
|---|---|
| `/revive [on\|off] [time s] [radius u] [bleed s]` | revive settings |
| `/giveup` | while downed: respawn now |
| `/lives [n\|off\|reset] [restart\|warn]` | shared party lives and what happens when they run out |
| `/wipe restart\|warn\|off` | what happens when every player is down |
| `/difficulty 1-9` or a name | enemy damage and health: easy x1, medium x1.6, hard x2, veteran x2.5, insane x3, brutal x4, deadly x5, hell x6, impossible x8 |
| `/champions 1\|2\|3` | champions per BOS fight |
| `/goto`, `/bring`, `/tp`, `/fwd`, `/thru`, `/undo` | get unstuck / regroup |
| `/door`, `/doors`, `/obj`, `/skip` | fix soft-locked doors and objectives |

Settings are saved in `coop_config.ini`, which is commented. The level order is in its `[next_level]` section.

## Building from source

The proxy is plain C (`CoopMod\proxy\bos_proxy.c`) built with MSVC (VS 2019 Build Tools, x86):

```
powershell -NoProfile -ExecutionPolicy Bypass -File CoopMod\build.ps1
```

The output goes to `CoopMod\bin\Bos.dll`, and `CoopMod\install.ps1` installs it.
`CoopMod\README.md` documents the hooks. `CoopMod\tools\` has the generators and test tools:

- `make_coop_level.py` builds the co-op levels.
- `make_coop_kits.py` builds the mission kits.
- `run_dedicated.ps1` tests a level on the dedicated server.
- `csdiff_site.py` / `tracediff.py` compare desync dumps.

## Known issues

- Occasional short resyncs (about 0.15 s) in heavy fights, when the PCs' simulations drift apart.
- Revive and the mission kits are new. Please report problems along with the newest file from `coop_logs\`.
- Saving is disabled in co-op (a save stops the multiplayer simulation). Use the level chain and `/lives` instead.

## Disclaimer

A fan-made mod, not affiliated with or endorsed by the game's developers or publishers.
The co-op levels are built from the game's own campaign data, so you need a legitimate copy of
Bet On Soldier to play.
