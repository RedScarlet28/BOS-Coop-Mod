"""Compare coop_logs\\csum_host.txt with csum_client.txt (proxy 0.30+).

Each sampled frame lists every networked entity's part of the world-state checksum and the part
of each of its vars. Prints, per frame both PCs logged, which entities/vars differ.
usage: csumdiff.py csum_host.txt csum_client.txt [max_rows_per_frame]
"""
import sys, collections

def load(path):
    frames = {}          # (frame, site) -> {handle: (type, part, [varparts])}
    totals = {}
    names = {}           # type -> [varnames]
    cur = None
    with open(path, encoding='latin-1') as f:
        for line in f:
            p = line.split()
            if not p or p[0] == '#': continue
            if p[0] == 'F':
                cur = (int(p[1]), int(p[2]) if len(p) > 2 else 0)
                while cur in frames: cur = (cur[0], cur[1] + 1)   # 0.30 logged no site: number by order
                frames[cur] = {}
            elif p[0] == 'T':
                names[int(p[1])] = (p[2] if len(p) > 2 else '').rstrip(',').split(',')
            elif p[0] == 'E' and cur:
                parts = [int(x, 16) for x in (p[4] if len(p) > 4 else '').rstrip(',').split(',') if x]
                frames[cur][p[1]] = (int(p[2]), int(p[3], 16), parts)
            elif p[0] == 'S' and cur:
                totals[cur] = int(p[1], 16)
    return frames, totals, names

def check_sums(tag, frames, totals):
    bad = 0
    for k, ents in frames.items():
        s = sum(e[1] for e in ents.values()) & 0xFFFFFFFF
        if k in totals and s != totals[k]: bad += 1
    print('%s: %d sampled frames, %d whose entity parts do not add up to the total' % (tag, len(frames), bad))

def main(hp, cp, rows=12):
    H, Ht, Hn = load(hp); C, Ct, Cn = load(cp)
    check_sums('host', H, Ht); check_sums('client', C, Ct)
    names = dict(Hn); names.update({k: v for k, v in Cn.items() if k not in names})
    cframes = {f for f, s in C}
    overall = collections.Counter()
    for fr in sorted(cframes):
        hk = (fr, 1) if (fr, 1) in H else (fr, 0)
        if hk not in H: continue
        h, c = H[hk], C[(fr, 0)] if (fr, 0) in C else C[(fr, 1)]
        diffs = []
        for hd in sorted(set(h) | set(c)):
            a, b = h.get(hd), c.get(hd)
            if a is None or b is None:
                diffs.append((hd, (a or b)[0], 'only ' + ('host' if a else 'client'))); continue
            if a[1] == b[1]: continue
            nm = names.get(a[0], [])
            vs = [nm[i] if i < len(nm) else '#%d' % i
                  for i in range(max(len(a[2]), len(b[2])))
                  if (a[2][i] if i < len(a[2]) else None) != (b[2][i] if i < len(b[2]) else None)]
            diffs.append((hd, a[0], ','.join(vs)))
        print('frame %d (host site %d): host total %08X client total %08X, %d entities differ'
              % (fr, hk[1], Ht.get(hk, 0), Ct.get((fr, 0), Ct.get((fr, 1), 0)), len(diffs)))
        for hd, t, what in diffs[:rows]:
            print('    %s type %-3d %s' % (hd, t, what))
            for v in what.split(','): overall[(t, v)] += 1
        for hd, t, what in diffs[rows:]:
            for v in what.split(','): overall[(t, v)] += 1
    print('most frequent differing (type, var):')
    for (t, v), n in overall.most_common(25):
        print('   %5d  type %-3d %s' % (n, t, v))

if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2], int(sys.argv[3]) if len(sys.argv) > 3 else 12)
