"""Build mission-honest multiplayer class kits for every co-op level.

For each Mods/Bos/Levels/Multi/BOS/COOP_<x>/Level.def the solo level is read (DEF_GetSubLevelFiles
"<solo>\\..."), the solo mission that loads it is found in Tuning/Solo/Missions.cfg, and that
mission's Weapons/Armors lists become the six classes' equipment (both teams, all four equipment
levels the same - no multiplayer level-ups). Output:
    Mods/Bos/Tuning/Multiplayer/Coop/Equipments_<COOP level>.cfg
The proxy (coop_kits=1) loads that file instead of Tuning/Multiplayer/Equipments.cfg when the level
begins, on every PC. Run again after changing Missions.cfg:  python CoopMod/tools/make_coop_kits.py
"""
import os
import re
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
BOS = os.path.join(ROOT, "Mods", "Bos")
TUN = os.path.join(BOS, "Tuning")
OUT = os.path.join(TUN, "Multiplayer", "Coop")


def read(p):
    return open(p, encoding="latin-1").read()


def missions():
    t = re.sub(r"--[^\n]*", "", read(os.path.join(TUN, "Solo", "Missions.cfg")))
    res = {}
    heads = list(re.finditer(r"^(Mission_\w+)\s*=", t, re.M))
    for i, m in enumerate(heads):
        body = t[m.end(): heads[i + 1].start() if i + 1 < len(heads) else len(t)]
        w = re.search(r"Weapons\s*=\s*\{(.*?)\}", body, re.S)
        a = re.search(r"Armors\s*=\s*\{(.*?)\}", body, re.S)
        info = {"name": m.group(1),
                "weapons": re.findall(r'"(\w+)"', w.group(1)) if w else [],
                "armors": re.findall(r'"(\w+)"', a.group(1)) if a else []}
        for lvl in re.findall(r'Load_\d+\s*=\s*"(\w+)"', body):
            res[lvl.lower()] = info
    return res


def solo_level(coop_dir):
    p = os.path.join(coop_dir, "Level.def")
    if not os.path.exists(p):
        return None
    m = re.search(r'DEF_GetSubLevelFiles.*?return\s*"([^"\\]+)\\', read(p), re.S)
    return m.group(1) if m else None


def best(ws, *prefixes):
    """the last (= highest tier, Missions.cfg lists them in order) weapon of the first prefix found"""
    for pre in prefixes:
        hit = [w for w in ws if w.lower().startswith(pre.lower())]
        if hit:
            return hit[-1]
    return ""


def kits(info):
    ws, ar = info["weapons"], info["armors"]
    light = "Light_Player" if "Light_Player" in ar else (ar[0] if ar else "")
    heavy = "Heavy_Player" if "Heavy_Player" in ar else light
    melee = best(ws, "roto_Blade")
    gun = best(ws, "Gun_")
    smg = best(ws, "SMG_") or gun
    pump = best(ws, "Pump_") or gun
    frag = best(ws, "Grenade_Cluster", "Grenade_Frag")
    gaz = [w for w in ws if w.startswith("Grenade_Gaz_")]
    shield = best(ws, "Shield_Heavy_Player", "Shield_Light_Player")
    missile = best(ws, "Missile_")
    gazl = best(ws, "Gaz_")
    wshot = best(ws, "WShot_")

    def nade(n, kind):
        if kind == "frag":
            lst = [frag] * n if frag else []
        else:
            lst = (gaz * 3)[:n] if gaz else []
        return lst + [""] * (3 - len(lst))

    k = {
        # one-handed + shield, heavy armour
        "Protector": dict(OneHanded=smg, TwoHanded="", Heavy=shield, Frag=nade(1, "frag"), Gaz=nade(0, "gaz"), Armor=heavy),
        # pistol + best sniper / long rifle
        "Sniper": dict(OneHanded=gun, TwoHanded=best(ws, "Sniper_Rifle_", "Rifle_"), Heavy="", Frag=nade(1, "frag"), Gaz=nade(0, "gaz"), Armor=light),
        # pistol + rocket launcher (else gas launcher) + lots of grenades
        "Grenadier": dict(OneHanded=gun, TwoHanded="", Heavy=missile or gazl, Frag=nade(3, "frag"), Gaz=nade(3, "gaz"), Armor=light),
        # pistol + best assault rifle
        "Trooper": dict(OneHanded=gun, TwoHanded=best(ws, "Assault_", "Rifle_"), Heavy="", Frag=nade(2, "frag"), Gaz=nade(1, "gaz"), Armor=light),
        # shotgun + commando/rifle + war shotgun (else gas launcher)
        "Engineer": dict(OneHanded=pump, TwoHanded=best(ws, "COM_", "Rifle_"), Heavy=wshot or gazl, Frag=nade(1, "frag"), Gaz=nade(1, "gaz"), Armor=light),
        # pistol + gatling, heavy armour
        "Destroyer": dict(OneHanded=gun, TwoHanded="", Heavy=best(ws, "Gatlin_") or missile or gazl, Frag=nade(1, "frag"), Gaz=nade(0, "gaz"), Armor=heavy),
    }
    for v in k.values():
        v["Melee"] = melee
    return k


def hacking(orig):
    """HackingDuration per class from the original file (Level_1)"""
    res = {}
    for m in re.finditer(r"Equipment_(WRF|UAN)_(\w+?)_Level_1\s*=\s*\{(.*?)\}\s*$", orig, re.S | re.M):
        h = re.search(r"HackingDuration\s*=\s*([0-9.]+)", m.group(3))
        res[m.group(2)] = h.group(1) if h else "40.0"
    return res


def lua_list(lst):
    return "{" + "".join('"%s",' % x for x in lst) + "}"


def main():
    ms = missions()
    orig = read(os.path.join(TUN, "Multiplayer", "Equipments.cfg"))
    hack = hacking(orig)
    os.makedirs(OUT, exist_ok=True)
    base = os.path.join(BOS, "Levels", "Multi", "BOS")
    n = 0
    for d in sorted(os.listdir(base)):
        if not d.upper().startswith("COOP_"):
            continue
        solo = solo_level(os.path.join(base, d))
        info = ms.get((solo or "").lower())
        if not info:
            print("%-32s no solo mission (solo level %s) - keeps the multiplayer kits" % (d, solo))
            continue
        k = kits(info)
        lines = ["-- generated by CoopMod/tools/make_coop_kits.py - %s = solo %s, %s" % (d, solo, info["name"]),
                 "-- every class: only weapons/armour the solo mission allows; all 4 levels the same", ""]
        for team in ("WRF", "UAN"):
            for cls, v in k.items():
                for lvl in range(1, 5):
                    lines += ["Equipment_%s_%s_Level_%d = " % (team, cls, lvl), "{",
                              '\tMelee = "%s",' % v["Melee"],
                              '\tOneHanded = "%s",' % v["OneHanded"],
                              '\tTwoHanded = "%s",' % v["TwoHanded"],
                              '\tHeavy = "%s",' % v["Heavy"],
                              "\tFragGrenade = %s," % lua_list(v["Frag"]),
                              "\tGazGrenade = %s," % lua_list(v["Gaz"]),
                              '\tArmor = "%s",' % v["Armor"],
                              '\tArmorDesc = "",',
                              "\tHackingDuration = %s," % hack.get(cls, "40.0"),
                              '\tHackingSpeedDesc = "",',
                              '\tRepairingSpeedDesc = "",',
                              "}", ""]
        with open(os.path.join(OUT, "Equipments_%s.cfg" % d), "w", encoding="latin-1", newline="\r\n") as f:
            f.write("\n".join(lines))
        n += 1
        if "-v" in sys.argv or d in ("COOP_Patrol", "COOP_Patrol_2"):
            print("%-32s %s:" % (d, info["name"]))
            for cls, v in k.items():
                print("   %-10s %s" % (cls, ", ".join(x for x in [v["Melee"], v["OneHanded"], v["TwoHanded"], v["Heavy"]] + v["Frag"] + v["Gaz"] if x) + "  | armour " + v["Armor"]))
    print("%d kit files in %s" % (n, OUT))


if __name__ == "__main__":
    main()
