#!/usr/bin/env python3
"""Turn a campaign level into a co-op multiplayer level, the way COOP_Patrol_2 was made.

usage: make_coop_level.py <game folder> <Level> [<Level> ...]     (e.g. Hold_that_Point_1)

For Levels\\<L> it writes
  Levels\\Multi\\BOS\\COOP_<L>\\
      COOP_<L>.kts            campaign scene + MP spawn points / areas / idle cameras
                              (build_coop_scene.py, donor MP_Patrol), spread over the player
                              and mercenary start positions
      Events.kt3              campaign trigger boxes + MP_Patrol's two spawn sectors moved to
                              the player start (kt3_add_sectors.py)
      COOP_<L>_Dynamic_Lights.Kt3, staticlights.dat, every *.lua of the level
      AI\\coop_<l>*            the level's AI files renamed (AI loader looks for <level name>*)
      Level.def               the campaign one + Coop_<L>.lua as the last script
      Coop_<L>.lua            generated co-op adjustments (below)
  Levels\\COOP_<L>\\AI\\       the same AI files (the loader's campaign-layout path)
  Tuning\\Maps.cfg             Map_Multi_COOP_<L> = copy of Map_<L>
Generated Coop_<L>.lua (Lua 5.0; the game's Lua has no _G, so names are written in literally):
  - every OnEnter_*/OnStay_* trigger of the level's scripts treats any human player as the host
    (the campaign checks id == _idPlayer; COOP_Patrol_2 did this by hand for its walkway)
  - every champion fight (LaunchBOS(arena, setup, warmup, combat, won, lost, timeout)) gets the
    COOP_Patrol_2 rules through coop_mission.lua's Coop_BOS_* helpers: set-up may move the host
    and brings the other players along, combat runs once, the win runs once and is called when
    the champion dies (the engine never does in MP), lost / time-out are ignored after a win.
"""
import math
import os
import re
import shutil
import struct
import subprocess
import sys

TOOLS = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, TOOLS)
import kts  # noqa: E402


def find_ci(folder, name):
    for f in os.listdir(folder):
        if f.lower() == name.lower():
            return os.path.join(folder, f)
    return None


def starts(scene_path):
    sc = kts.Scene(open(scene_path, "rb").read())
    player, mercs, chars = None, [], []
    for t, etyp in sc.blocks(b"SVEN").items():
        if sc.types[t] != "CHARACTER":
            continue
        for name, handle, e in kts.entities(etyp):
            try:
                p = struct.unpack_from("<3f", kts.get_var(etyp, e, "Position"))
            except Exception:
                continue
            chars.append(p)
            if "Repere" in name:
                continue
            if name == "Player":
                player = p
            elif name.startswith("Char_Merc_"):
                mercs.append(p)
    return player, mercs, chars


def spawn_spots(player, mercs, chars, want=4):
    """0.58: the campaign start spots themselves - the player start plus the mercenary starts at the
    same height (within 2.5 m) and within 40 m. The game only spawns on a point with nothing inside
    5.8 m (Bos 0x10077BB0); the in-between spots of spawn_spots_055 failed that everywhere and nobody
    could spawn (2026-11-12)."""
    d2 = lambda a, b: math.hypot(a[0] - b[0], a[1] - b[1])
    return [player] + [m for m in mercs if abs(m[2] - player[2]) < 2.5 and d2(m, player) < 40.0]


def spawn_spots_055(player, mercs, chars, want=4):
    """Spawn spots near the start that no scene character stands on (players spawned inside the
    campaign Player / the mercenaries and the bodies pushed each other to death) and at the start's
    height (Alaska_1's intro mercs stand ~500 m up - a 2D-only check spawned players in the sky).
    Points between the start and same-height mercenary starts lie on walked ground; a ring around
    the start is the fallback."""
    d2 = lambda a, b: math.hypot(a[0] - b[0], a[1] - b[1])
    def clear(q, picked):
        if any(d2(q, c) < 3.0 and abs(q[2] - c[2]) < 4.0 for c in chars):
            return False
        return all(d2(q, o) >= 2.5 for o in picked)
    refs = [m for m in mercs if abs(m[2] - player[2]) < 2.5 and d2(m, player) < 40.0]
    pts = [player] + refs
    cand = []
    for i in range(len(pts)):
        for j in range(i + 1, len(pts)):
            a, b = pts[i], pts[j]
            if abs(a[2] - b[2]) >= 2.5:
                continue
            for k in range(1, 10):
                t = k / 10.0
                cand.append((a[0] + (b[0] - a[0]) * t, a[1] + (b[1] - a[1]) * t, max(a[2], b[2])))
    cand = [q for q in cand if 3.0 <= d2(q, player) <= 15.0]
    cand.sort(key=lambda q: d2(q, player))
    picked = []
    for q in cand:
        if len(picked) < want and clear(q, picked):
            picked.append(q)
    for r in (4.0, 6.0):
        for k in range(8):
            if len(picked) >= want:
                break
            a = k * math.pi / 4.0
            q = (player[0] + r * math.cos(a), player[1] + r * math.sin(a), player[2])
            if clear(q, picked):
                picked.append(q)
    return picked


def script_files(level_def):
    txt = open(level_def, encoding="latin-1").read()
    m = re.search(r"function\s+DEF_GetLevelScriptFiles\s*\(\s*\)(.*?)\bend\b", txt, re.S)
    return re.findall(r'"([^"]+\.lua)"', m.group(1), re.I), txt, m


LAUNCH = re.compile(r'^[^-\n]*?LaunchBOS\s*\(\s*(\d+)\s*,\s*"([^"]*)"\s*,\s*"([^"]*)"\s*,\s*"([^"]*)"\s*,'
                    r'\s*"([^"]*)"\s*,\s*"([^"]*)"\s*,\s*"([^"]*)"\s*\)', re.M)
TRIGGER = re.compile(r'^\s*function\s+((?:OnEnter|OnStay)_[A-Za-z0-9_]+)\s*\(\s*([A-Za-z_][A-Za-z0-9_]*)', re.M)


def strip_comments(src):
    src = re.sub(r"--\[\[.*?\]\]", "", src, flags=re.S)       # block comments (the levels use --[[ ]])
    return re.sub(r"--[^\n]*", "", src)


# The MP round starts ticking UpdateLevel as soon as the level loads, but the proxy runs InitLevel
# only once the host has spawned: in between, the campaign's per-frame checks read unset variables
# (_idMerc, objective counters) - COOP_Alaska_Special_Forces_1 failed its mission there. UpdateLevel
# waits until coop_mission.lua (run right before InitLevel) sets Coop_LevelReady.
HOLD_UPDATE = """
-- UpdateLevel waits for InitLevel (coop_mission.lua sets Coop_LevelReady right before it)
Coop_LevelReady = false
-- dialogue is spoken in this level (coop_mission.lua; COOP_Patrol sets true to skip it)
Coop_SkipDialogue = false
if UpdateLevel ~= nil then Coop_Orig.UpdateLevel = UpdateLevel
\tfunction UpdateLevel(a1, a2, a3) if Coop_LevelReady then return Coop_Orig.UpdateLevel(a1, a2, a3) end end end
"""


def gen_coop_lua(level, lua_texts):
    fights, triggers, seen_t = [], [], set()
    for fname, src in lua_texts:
        src = strip_comments(src)
        for m in LAUNCH.finditer(src):
            f = (int(m.group(1)),) + tuple(m.group(i) for i in range(2, 8))
            if f not in fights:
                fights.append(f)
        for m in TRIGGER.finditer(src):
            if m.group(1) not in seen_t:
                seen_t.add(m.group(1))
                triggers.append(m.group(1))
    L = []
    w = L.append
    w("-- CoopMod: COOP_%s adjustments for the co-op session (GENERATED by CoopMod\\tools\\make_coop_level.py;" % level)
    w("-- loaded after the mission scripts). Lua 5.0. Helpers (Coop_IsHuman, Coop_BOS_*) are in coop_mission.lua.")
    w("Coop_Orig = Coop_Orig or {}")
    w("")
    w("-- %d trigger(s): any human player counts as the host (the campaign checks id == _idPlayer)" % len(triggers))
    for t in triggers:
        w("if %s ~= nil then Coop_Orig.%s = %s" % (t, t, t))
        w("\tfunction %s(id, a2, a3) if Coop_IsHuman and Coop_IsHuman(id) then id = _idPlayer end return Coop_Orig.%s(id, a2, a3) end end" % (t, t))
    w("")
    wrapped = set()
    tick = []
    w("-- %d champion fight(s) (LaunchBOS)" % len(fights))
    for (a, setup, warm, combat, won, lost, tout) in fights:
        w("-- arena %d: setup %s, warm-up %s, combat %s, won %s, lost %s, time-out %s" % (a, setup or "-", warm or "-", combat or "-", won or "-", lost or "-", tout or "-"))
        if setup and setup not in wrapped:
            wrapped.add(setup)
            w("if %s ~= nil then Coop_Orig.%s = %s" % (setup, setup, setup))
            w("\tfunction %s(a1, a2, a3) Coop_BOS_Setup(%d) Coop_AllowMove = true Coop_Orig.%s(a1, a2, a3) Coop_BOS_BringPlayers() Coop_AllowMove = false end end" % (setup, a, setup))
        if combat and combat not in wrapped:
            wrapped.add(combat)
            w("if %s ~= nil then Coop_Orig.%s = %s" % (combat, combat, combat))
            w("\tfunction %s(a1, a2, a3) if Coop_BOS_Combat(%d) then return Coop_Orig.%s(a1, a2, a3) end end end" % (combat, a, combat))
        if won and won not in wrapped:
            wrapped.add(won)
            w("if %s ~= nil then Coop_Orig.%s = %s" % (won, won, won))
            w("\tfunction %s(a1, a2, a3) if Coop_BOS_Won(%d) then return Coop_Orig.%s(a1, a2, a3) end end end" % (won, a, won))
            tick.append((a, won))
        for nm in (lost, tout):
            if nm and nm not in wrapped and nm != won:
                wrapped.add(nm)
                w("if %s ~= nil then Coop_Orig.%s = %s" % (nm, nm, nm))
                w("\tfunction %s(a1, a2, a3) if Coop_BOS_IsDone(%d) then PrintDebug(\"[coop] %s after the fight was won - ignored\") return end return Coop_Orig.%s(a1, a2, a3) end end" % (nm, a, nm, nm))
    if tick:
        w("")
        w("-- the engine never ends a fight when the champion dies in MP: Coop_Tick (host, 1/s) does")
        w("function Coop_LevelTick()")
        for a, won in tick:
            w("\tif %s ~= nil and Coop_BOS_ChampionDead(%d) then PrintDebug(\"[coop] champion of arena %d is dead - %s\") %s() end" % (won, a, a, won, won))
        w("end")
    L.extend(HOLD_UPDATE.strip("\r\n").split("\n"))
    w('PrintDebug("[coop] COOP_%s co-op script loaded: %d trigger(s), %d champion fight(s)")' % (level, len(triggers), len(fights)))
    return "\r\n".join(L) + "\r\n", len(triggers), len(fights)


def add_maps_cfg(maps_cfg, level):
    b = open(maps_cfg, "rb").read().decode("latin-1")
    if re.search(r"^Map_Multi_COOP_%s\s*=" % re.escape(level), b, re.M):
        return False
    m = re.search(r"^Map_%s\s*=\s*\r?\n\{.*?\r?\n\}" % re.escape(level), b, re.M | re.S)
    if not m:
        raise SystemExit("Maps.cfg has no Map_%s" % level)
    entry = "Map_Multi_COOP_" + m.group(0)[len("Map_"):] + "\r\n\r\n"
    anchor = b.find("Map_Multi_COOP_1_MP =")
    b = b[:anchor] + entry + b[anchor:]
    open(maps_cfg, "wb").write(b.encode("latin-1"))
    return True


def make(game, level):
    mods = os.path.join(game, "Mods", "Bos")
    lv = os.path.join(mods, "Levels")
    src = os.path.join(lv, level)
    name = "COOP_" + level
    dst = os.path.join(lv, "Multi", "BOS", name)
    ai2 = os.path.join(lv, name, "AI")
    os.makedirs(os.path.join(dst, "AI"), exist_ok=True)
    os.makedirs(ai2, exist_ok=True)

    scene = find_ci(src, level + ".kts")
    player, mercs, chars = starts(scene)
    if not player:
        raise SystemExit("%s: no Player in the scene" % level)
    spots = spawn_spots(player, mercs, chars)
    fmt = lambda p: "%.1f,%.1f,%.1f" % p
    camera = (player[0] + 2.6, player[1] - 33.0, player[2] + 36.0)   # COOP_Patrol_2's offset
    out_kts = os.path.join(dst, name + ".kts")
    cmd = [sys.executable, "-I", os.path.join(TOOLS, "build_coop_scene.py"), scene,
           os.path.join(lv, "Multi", "BOS", "MP_Patrol", "MP_Patrol.kts"), out_kts, "--spots"] + \
          [fmt(p) for p in spots] + ["--camera", fmt(camera)]
    r = subprocess.run(cmd, capture_output=True, text=True)
    if r.returncode:
        raise SystemExit("%s: build_coop_scene failed:\n%s%s" % (level, r.stdout, r.stderr))

    ev = os.path.join(dst, "Events.kt3")
    if os.path.exists(ev + ".orig"):
        os.remove(ev + ".orig")
    shutil.copyfile(find_ci(src, "Events.kt3"), ev)
    r = subprocess.run([sys.executable, "-I", os.path.join(TOOLS, "kt3_add_sectors.py"),
                        os.path.join(lv, "Multi", "BOS", "MP_Patrol", "Events.kt3"), ev,
                        "--move-to", "%.1f" % player[0], "%.1f" % player[1], "%.1f" % player[2],
                        "Sector_Area_Base_UAN", "Sector_Area_Base_WRF"], capture_output=True, text=True)
    if r.returncode:
        raise SystemExit("%s: kt3_add_sectors failed:\n%s%s" % (level, r.stdout, r.stderr))
    if os.path.exists(ev + ".orig"):
        os.remove(ev + ".orig")

    dl = find_ci(src, level + "_Dynamic_Lights.Kt3")
    if dl:
        shutil.copyfile(dl, os.path.join(dst, name + "_Dynamic_Lights.Kt3"))
    sl = find_ci(src, "staticlights.dat")
    if sl:
        shutil.copyfile(sl, os.path.join(dst, "staticlights.dat"))
    for f in os.listdir(src):
        if f.lower().endswith(".lua"):
            shutil.copyfile(os.path.join(src, f), os.path.join(dst, f))
    pref = re.compile("^" + re.escape(level), re.I)
    for f in os.listdir(os.path.join(src, "AI")):
        nb = pref.sub("coop_" + level.lower(), f)
        shutil.copyfile(os.path.join(src, "AI", f), os.path.join(dst, "AI", nb))
        shutil.copyfile(os.path.join(src, "AI", f), os.path.join(ai2, nb))
    open(os.path.join(lv, name, "README.txt"), "w", newline="\r\n").write(
        "CoopMod: AI data for the co-op level Multi\\BOS\\%s (copies of Levels\\%s\\AI renamed;\n"
        "the AI loader looks in Levels\\<level name>\\AI for <level name>* files).\n" % (name, level))

    scripts, deftxt, m = script_files(os.path.join(src, "Level.def"))
    missing = [s for s in scripts if not find_ci(src, s)]
    if missing:
        raise SystemExit("%s: Level.def lists missing scripts %s" % (level, missing))
    texts = [(s, open(find_ci(src, s), encoding="latin-1").read()) for s in scripts]
    lua, nt, nf = gen_coop_lua(level, texts)
    coop_lua = "Coop_%s.lua" % level
    open(os.path.join(dst, coop_lua), "w", encoding="latin-1", newline="").write(lua)
    body = m.group(1)
    q = body.rfind('"')
    newbody = body[:q + 1] + ', "%s"' % coop_lua + body[q + 1:]
    newdef = ("-- %s: campaign mission %s hosted as a multiplayer level (CoopMod, make_coop_level.py).\r\n"
              "-- Scene = campaign scene + MP_Patrol spawn points / areas / idle cameras at the player start;\r\n"
              "-- Events.kt3 = campaign trigger boxes + MP_Patrol's two spawn sectors; %s = co-op adjustments.\r\n"
              % (name, level, coop_lua)) + deftxt[:m.start(1)] + newbody + deftxt[m.end(1):]
    open(os.path.join(dst, "Level.def"), "w", encoding="latin-1", newline="").write(newdef)

    added = add_maps_cfg(os.path.join(mods, "Tuning", "Maps.cfg"), level)
    print("%-26s start (%.1f, %.1f, %.1f), %d spawn spot(s), %d trigger(s), %d champion fight(s)%s" %
          (name, player[0], player[1], player[2], len(spots), nt, nf, ", Maps.cfg entry added" if added else ""))


if __name__ == "__main__":
    game = sys.argv[1]
    for lvl in sys.argv[2:]:
        make(game, lvl)
