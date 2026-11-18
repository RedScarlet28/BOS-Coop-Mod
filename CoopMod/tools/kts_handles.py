#!/usr/bin/env python3
"""Map entity handles (as logged by the proxy, e.g. "handle=80150123") to names.

usage: kts_handles.py <scene.kts> [handle ...]
       kts_handles.py <scene.kts> --log <proxy log>    (resolves every handle= in it)

A handle is 0x80000000 | typeIndex << 16 | perTypeIndex for server entities;
typeIndex is the position in the scene's TPDF type palette.
"""
import re
import struct
import sys


def palette(d):
    names, i = [], d.find(b"TPDF")
    while 0 <= i < 0x4000:
        size = struct.unpack_from("<I", d, i + 4)[0]
        n = d[i + 8]
        names.append(d[i + 9:i + 9 + n].rstrip(b"\0").decode("latin1"))
        i = d.find(b"TPDF", i + 8 + size)
    return names


def entities(d):
    out = {}
    for m in re.finditer(b"ENTIDATA", d):
        o = m.end()
        n = d[o + 4]
        name = d[o + 5:o + 5 + n].decode("latin1")
        out[struct.unpack_from("<I", d, o + 5 + n)[0]] = name
    return out


def main():
    d = open(sys.argv[1], "rb").read()
    types, ents = palette(d), entities(d)
    if len(sys.argv) > 3 and sys.argv[2] == "--log":
        handles = re.findall(r"handle=([0-9A-Fa-f]{8})", open(sys.argv[3], errors="replace").read())
    else:
        handles = sys.argv[2:]
    for h in dict.fromkeys(handles):
        v = int(h, 16)
        t = (v >> 16) & 0x7FFF
        tname = types[t] if t < len(types) else "?"
        print(f"{v:08X}  {tname:<24} {ents.get(v, '(not in scene - created at runtime?)')}")


if __name__ == "__main__":
    main()
