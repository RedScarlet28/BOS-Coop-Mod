#!/usr/bin/env python3
"""Reader/writer for Bet On Soldier scene files (.kts), with exact RIFF framing.

Layout (verified on Patrol_1.kts and MP_Patrol.kts):

    RIFF <size> KTSAVERS
      VERS <4>
      LIST TDFL ...              entity type palette: TPDF name per type index
      LIST SVEN                  server entities
        LIST ETYP                one block per entity type, ascending type index
          TYIN <4> <type index>
          LIST VDEF ...          variable definitions: VDED <name> per variable
          LIST ENTI              one per entity
            DATA <namelen><name><handle u32>...
            USER <n> ...
            LIST VARS
              VARD <u32 count><data>   one per variable, in VDEF order
      LIST CLEN                  client entities, same structure

Chunks are <4cc><u32 size><data>, padded to an even size. A handle is
0x80000000 | type << 16 | index for server entities (client ones lack the
high bit).

Earlier tools (.tools/kts_merge.py, kts_inject.py) split files at the text
"ETYPTYIN" instead of walking chunks; their output mixed client blocks into
the server section and left section sizes stale, so everything past the
first bad block was never loaded by the game. This module never does that.
"""
import struct


class Chunk:
    def __init__(self, cid, data=b"", kind=None, children=None):
        self.cid = cid            # 4-byte id
        self.kind = kind          # LIST/RIFF form type, else None
        self.data = data          # raw payload for leaf chunks
        self.children = children  # list for LIST/RIFF

    def is_list(self, kind=None):
        return self.children is not None and (kind is None or self.kind == kind)

    def find(self, kind_or_id):
        for c in self.children or []:
            if c.kind == kind_or_id or (c.children is None and c.cid == kind_or_id):
                yield c

    def first(self, kind_or_id):
        return next(self.find(kind_or_id), None)

    def encode(self):
        if self.children is not None:
            body = self.kind + b"".join(c.encode() for c in self.children)
        else:
            body = self.data
        out = self.cid + struct.pack("<I", len(body)) + body
        return out + (b"\0" if len(body) & 1 else b"")


def _parse(d, off, end):
    out = []
    while off + 8 <= end:
        cid = d[off:off + 4]
        size = struct.unpack_from("<I", d, off + 4)[0]
        body = off + 8
        if body + size > end:
            raise ValueError(f"chunk {cid!r} at 0x{off:X} overruns its parent")
        if cid in (b"LIST", b"RIFF"):
            out.append(Chunk(cid, kind=d[body:body + 4], children=_parse(d, body + 4, body + size)))
        else:
            out.append(Chunk(cid, data=d[body:body + size]))
        off = body + size + (size & 1)
    return out


def load(path):
    d = open(path, "rb").read()
    root = _parse(d, 0, len(d))
    if len(root) != 1 or root[0].cid != b"RIFF" or root[0].kind != b"KTSA":
        # form type is the 8 bytes "KTSAVERS" in practice: KTSA + VERS chunk id
        pass
    return Scene(d)


class Scene:
    """Parsed scene. Note the RIFF form type is 'KTSA' and the first child chunk is 'VERS'."""

    def __init__(self, d):
        assert d[:4] == b"RIFF" and d[8:12] == b"KTSA", "not a .kts scene"
        self.root = Chunk(b"RIFF", kind=b"KTSA", children=_parse(d, 12, 8 + struct.unpack_from("<I", d, 4)[0]))
        tdfl = self.root.first(b"TDFL")
        self.types = []
        for c in tdfl.children:
            if c.cid == b"TPDF":
                n = c.data[0]
                self.types.append(c.data[1:1 + n].rstrip(b"\0").decode("latin1"))
            elif c.is_list():
                for cc in c.children:
                    if cc.cid == b"TPDF":
                        n = cc.data[0]
                        self.types.append(cc.data[1:1 + n].rstrip(b"\0").decode("latin1"))

    def section(self, kind):          # b"SVEN" or b"CLEN"
        return self.root.first(kind)

    def blocks(self, kind):
        """{type index: ETYP chunk} for a section."""
        out = {}
        for b in self.section(kind).find(b"ETYP"):
            out[struct.unpack_from("<I", b.first(b"TYIN").data, 0)[0]] = b
        return out

    def set_blocks(self, kind, blocks):
        sec = self.section(kind)
        others = [c for c in sec.children if c.kind != b"ETYP"]
        sec.children = [blocks[t] for t in sorted(blocks)] + others

    def encode(self):
        return self.root.encode()


def var_names(etyp):
    names = []
    vdef = etyp.first(b"VDEF")
    for c in vdef.children:
        if c.cid == b"VDED":
            n = c.data[0]
            names.append(c.data[1:1 + n].rstrip(b"\0").decode("latin1"))
    return names


def entities(etyp):
    """Yield (name, handle, ENTI chunk) for every entity of a block."""
    for e in etyp.find(b"ENTI"):
        data = e.first(b"DATA").data
        n = data[0]
        name = data[1:1 + n].rstrip(b"\0").decode("latin1")
        handle = struct.unpack_from("<I", data, 1 + n)[0]
        yield name, handle, e


def get_var(etyp, enti, var):
    """Raw payload (after the u32 count) of one variable of one entity."""
    i = var_names(etyp).index(var)
    vard = [c for c in enti.first(b"VARS").children if c.cid == b"VARD"][i]
    return vard.data[4:]


def set_floats(etyp, enti, var, values):
    """Overwrite the leading floats of a variable in place (size unchanged)."""
    i = var_names(etyp).index(var)
    vard = [c for c in enti.first(b"VARS").children if c.cid == b"VARD"][i]
    b = bytearray(vard.data)
    struct.pack_into("<%df" % len(values), b, 4, *values)
    vard.data = bytes(b)
