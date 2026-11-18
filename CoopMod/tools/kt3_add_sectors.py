#!/usr/bin/env python3
"""Copy named sector volumes (top-level "LIST SECT" chunks) between Events.kt3 files.

usage: kt3_add_sectors.py <donor Events.kt3> <target Events.kt3> [--move-to X Y Z] <sector name> [...]

--move-to centres each copied sector on X,Y,Z. A SECT holds a bounding sphere
("sphr": centre x,y,z, 1.0, radius) and a BSP ("root": 24-byte nodes = plane
nx,ny,nz,d + two child indices). Planes follow n.p + d = 0 (checked against
the sector's mesh vertices), so moving by t means centre += t, d -= n.t.

Events.kt3 is a RIFF "SCEN" file. Its top level holds one NODE (the event
boxes' meshes) and one SECT per named volume (name, bounding sphere, BSP).
Campaign files store these chunks compressed as "zip!" (original type + size,
then compressed data); MP files store them plain. The engine reads both kinds
side by side, so appending plain SECT chunks leaves every existing (compressed)
chunk untouched. Only the RIFF size changes. The target's original is kept
as <target>.orig the first time.

MP spawn areas (SPAWN_AREA) reference their sector by name; without it no
player can spawn ("spawning in 15 seconds" forever).
"""
import os
import shutil
import struct
import sys


def top_level(d):
    """Yield (offset, id, type, name, raw chunk bytes) for each top-level chunk."""
    off = 12  # after RIFF <size> SCEN
    while off + 8 <= len(d):
        cid = d[off:off + 4]
        size = struct.unpack_from("<I", d, off + 4)[0]
        end = off + 8 + size + (size & 1)
        typ, name = b"", ""
        if cid == b"LIST":
            typ = d[off + 8:off + 12]
            j = d.find(b"@nam", off + 12, min(off + 80, end))
            if j >= 0:
                n = struct.unpack_from("<I", d, j + 4)[0]
                name = d[j + 8:j + 8 + n].rstrip(b"\0").decode("latin1")
        elif cid == b"zip!":
            typ = d[off + 8:off + 12]
        yield off, cid, typ, name, d[off:end]
        off = end


def move_sector(raw, target):
    """Return a copy of a 'LIST SECT' chunk centred on target (x, y, z)."""
    b = bytearray(raw)
    s = b.find(b"sphr")
    cx, cy, cz = struct.unpack_from("<3f", b, s + 8)
    t = (target[0] - cx, target[1] - cy, target[2] - cz)
    struct.pack_into("<3f", b, s + 8, *target)
    r = b.find(b"root")
    size = struct.unpack_from("<I", b, r + 4)[0]
    assert size % 24 == 0, "unexpected BSP node size"
    for o in range(r + 8, r + 8 + size, 24):
        nx, ny, nz, d = struct.unpack_from("<4f", b, o)
        struct.pack_into("<f", b, o + 12, d - (nx * t[0] + ny * t[1] + nz * t[2]))
    return bytes(b), (cx, cy, cz)


def main():
    args = sys.argv[1:]
    move = None
    if "--move-to" in args:
        i = args.index("--move-to")
        move = tuple(float(v) for v in args[i + 1:i + 4])
        del args[i:i + 4]
    donor, target, names = args[0], args[1], args[2:]
    dd = open(donor, "rb").read()
    td = open(target, "rb").read()
    assert dd[:4] == b"RIFF" and dd[8:12] == b"SCEN", "donor is not an Events.kt3"
    assert td[:4] == b"RIFF" and td[8:12] == b"SCEN", "target is not an Events.kt3"

    have = {n for _, c, t, n, _ in top_level(td) if c == b"LIST" and t == b"SECT"}
    out = bytearray(td)
    added = []
    for off, cid, typ, name, raw in top_level(dd):
        if cid == b"LIST" and typ == b"SECT" and name in names:
            if name in have:
                print(f"  {name}: already present, skipped")
                continue
            if move:
                raw, was = move_sector(raw, move)
                print(f"  {name}: moved from ({was[0]:.1f}, {was[1]:.1f}, {was[2]:.1f}) to {move}")
            if len(out) & 1:
                out += b"\0"
            out += raw
            added.append(name)
    missing = set(names) - set(added) - have
    if missing:
        print(f"  NOT FOUND in donor: {sorted(missing)}")
        return 1
    struct.pack_into("<I", out, 4, len(out) - 8)

    if added:
        bak = target + ".orig"
        if not os.path.exists(bak):
            shutil.copyfile(target, bak)
        open(target, "wb").write(bytes(out))
    # verify by re-parsing
    names_after = [n for _, c, t, n, _ in top_level(bytes(out)) if t == b"SECT" and c == b"LIST"]
    zips = sum(1 for _, c, _, _, _ in top_level(bytes(out)) if c == b"zip!")
    print(f"  added {added}; target now {len(out)} bytes, RIFF={struct.unpack_from('<I', out, 4)[0]}, "
          f"{zips} compressed chunks kept, plain SECTs: {names_after}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
