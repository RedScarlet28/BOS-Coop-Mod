#!/usr/bin/env python3
"""Print the player / mercenary start positions of a campaign scene (.kts).

usage: level_starts.py <scene.kts> [...]
The CHARACTER entities named Player and Char_Merc_* (and those with "Repere" = markers are skipped)
are the spots build_coop_scene.py spreads the MP spawn points over.
"""
import os
import struct
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import kts  # noqa: E402


def starts(path):
    sc = kts.Scene(open(path, "rb").read())
    out = []
    for t, etyp in sc.blocks(b"SVEN").items():
        if sc.types[t] != "CHARACTER":
            continue
        for name, handle, e in kts.entities(etyp):
            if name == "Player" or name.startswith("Char_Merc_"):
                if "Repere" in name:
                    continue
                pos = struct.unpack_from("<3f", kts.get_var(etyp, e, "Position"))
                out.append((name, pos))
    return out


if __name__ == "__main__":
    for p in sys.argv[1:]:
        print(p)
        for name, pos in starts(p):
            print("   %-28s %9.2f %9.2f %8.2f" % (name, pos[0], pos[1], pos[2]))
