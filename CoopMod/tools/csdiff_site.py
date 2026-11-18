"""Diff per-entity checksum dumps (coop_logs/csum_host.txt vs csum_client.txt).

Usage: python csdiff_site.py csum_host.txt csum_client.txt [site]
Only dump site 0 (the confirmed world) is compared by default - the client also writes site 1,
which is a different world build and gives false differences.
"""
import sys
from collections import Counter

SITE = sys.argv[3] if len(sys.argv) > 3 else "0"


def load(p):
    fr, types, cur = {}, {}, None
    for ln in open(p, encoding="latin-1"):
        t = ln.split()
        if not t:
            continue
        if t[0] == "F":
            cur = fr.setdefault(int(t[1]), {}) if (len(t) < 3 or t[2] == SITE) else None
        elif t[0] == "T":
            types[int(t[1])] = t[2].split(",") if len(t) > 2 else []
        elif t[0] == "E" and cur is not None:
            cur[t[1]] = (int(t[2]), t[3], t[4].split(",") if len(t) > 4 else [])
    return fr, types


h, ht = load(sys.argv[1])
c, ct = load(sys.argv[2])
common = sorted(set(h) & set(c))
print("frames host", len(h), "client", len(c), "common", len(common))
tally = Counter()
for f in common:
    d = []
    for k in set(h[f]) | set(c[f]):
        a, b = h[f].get(k), c[f].get(k)
        if a is None or b is None:
            # an entity on one PC only matters if its checksum part is not 0
            part = (a or b)[1]
            if part != "00000000":
                d.append((k, "only host" if b is None else "only client"))
            continue
        if a[1] != b[1]:
            names = ht.get(a[0], [])
            vs = [names[i] if i < len(names) else str(i) for i, (x, y) in enumerate(zip(a[2], b[2])) if x != y]
            d.append((k, "type %d: %s" % (a[0], ",".join(vs))))
            tally["type %d: %s" % (a[0], ",".join(vs))] += 1
    if d:
        print(f, d[:8])
print("differing samples:", sum(1 for f in common if any(True for _ in [0])) and None)
for k, v in tally.most_common(20):
    print(v, k)
