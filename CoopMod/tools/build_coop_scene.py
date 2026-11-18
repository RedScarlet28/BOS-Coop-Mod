#!/usr/bin/env python3
"""Build a co-op scene: a campaign scene plus the multiplayer entities an MP
session needs to spawn players, with correct RIFF framing.

usage: build_coop_scene.py <campaign.kts> <mp donor.kts> <out.kts>
           --spots X,Y,Z [X,Y,Z ...]   walkable spawn spots (e.g. player / merc start positions)
           --camera X,Y,Z              where the MP idle/spawn camera points go

Added from the donor (types the campaign scene does not have):
  server  SPAWN_POINT (45), SPAWN_AREA (51)
  client  MULTI_IDLE_CAMPOINT (64)
Spawn points are spread over the spots (z + 3 so players drop onto the ground),
spawn areas sit on the first spot, camera points at --camera. Their handles
(type << 16 | index) cannot collide with campaign entities because the types
are new to the scene. Everything else is the campaign scene, unchanged.
"""
import struct
import sys
import os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import kts  # noqa: E402

SERVER_TYPES = {45: "SPAWN_POINT", 51: "SPAWN_AREA"}
CLIENT_TYPES = {64: "MULTI_IDLE_CAMPOINT"}


def parse_xyz(s):
    return tuple(float(v) for v in s.split(","))


def main():
    args = sys.argv[1:]
    base, donor, out = args[:3]
    spots, camera = [], None
    i = 3
    while i < len(args):
        if args[i] == "--spots":
            i += 1
            while i < len(args) and not args[i].startswith("--"):
                spots.append(parse_xyz(args[i]))
                i += 1
        elif args[i] == "--camera":
            camera = parse_xyz(args[i + 1])
            i += 2
        else:
            raise SystemExit(f"unknown argument {args[i]}")
    if not spots or not camera:
        raise SystemExit("--spots and --camera are required")

    raw = open(base, "rb").read()
    scene = kts.Scene(raw)
    mp = kts.Scene(open(donor, "rb").read())
    assert scene.types == mp.types, "type palettes differ"

    for kind, wanted in ((b"SVEN", SERVER_TYPES), (b"CLEN", CLIENT_TYPES)):
        blocks = scene.blocks(kind)
        donor_blocks = mp.blocks(kind)
        for t, name in wanted.items():
            assert scene.types[t] == name, (t, scene.types[t])
            if t in blocks:
                raise SystemExit(f"campaign scene already has {name}; refusing to merge two blocks of one type")
            blocks[t] = donor_blocks[t]
        scene.set_blocks(kind, blocks)

    sv, cl = scene.blocks(b"SVEN"), scene.blocks(b"CLEN")
    for k, (name, handle, e) in enumerate(kts.entities(sv[45])):
        x, y, z = spots[k % len(spots)]
        w = struct.unpack_from("<4f", kts.get_var(sv[45], e, "Position"))[3]
        kts.set_floats(sv[45], e, "Position", (x, y, z + 3.0, w))
    for name, handle, e in kts.entities(sv[51]):
        x, y, z = spots[0]
        w = struct.unpack_from("<4f", kts.get_var(sv[51], e, "Position"))[3]
        kts.set_floats(sv[51], e, "Position", (x, y, z + 3.0, w))
    for name, handle, e in kts.entities(cl[64]):
        for var in ("Position", "Interpolated_Position"):
            w = struct.unpack_from("<4f", kts.get_var(cl[64], e, var))[3]
            kts.set_floats(cl[64], e, var, (camera[0], camera[1], camera[2], w))

    data = scene.encode()
    check = kts.Scene(data)   # re-parse: raises if any framing is wrong
    open(out, "wb").write(data)
    print(f"wrote {out}: {len(data)} bytes")
    for kind in (b"SVEN", b"CLEN"):
        bl = check.blocks(kind)
        print(f"  {kind.decode()}: " + ", ".join(
            f"{t} {check.types[t]}({sum(1 for _ in kts.entities(b))})" for t, b in sorted(bl.items())))
    pts = [struct.unpack_from("<3f", kts.get_var(check.blocks(b'SVEN')[45], e, "Position"))
           for _, _, e in kts.entities(check.blocks(b"SVEN")[45])]
    print(f"  spawn points at {sorted(set((round(x, 1), round(y, 1), round(z, 1)) for x, y, z in pts))}")


if __name__ == "__main__":
    main()
