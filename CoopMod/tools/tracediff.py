"""Compare coop_logs\\trace_host.txt and trace_client.txt (proxy 0.29+).

Both are written at the same point of the same frame (character drive step), so for every
(frame, handle) the values should be identical. Prints, per traced frame window, how many
characters differ and in what, and the worst cases.
usage: tracediff.py trace_host.txt trace_client.txt [pos_tol]
"""
import sys, collections

def load(path):
    rows = {}
    with open(path, encoding='latin-1') as f:
        for line in f:
            if line.startswith('#'): continue
            p = line.rstrip('\n').split(' ', 14)
            if len(p) < 14: continue
            fr, h = int(p[0]), p[1]
            rows[(fr, h)] = dict(human=p[2], ai=p[3], table=p[4], pos=tuple(map(float, p[5:8])),
                                 flags=int(p[8], 16), c13c=p[9], c140=p[10], speed=float(p[11]),
                                 cc=p[12], cd=p[13], name=p[14] if len(p) > 14 else '')
    return rows

def main(hp, cp, tol=0.01):
    H, C = load(hp), load(cp)
    frames = sorted({k[0] for k in H} & {k[0] for k in C})
    print('frames in both: %d (%s..%s); host rows %d, client rows %d' % (len(frames), frames[:1], frames[-1:], len(H), len(C)))
    only_h = collections.Counter(k[0] for k in H if k not in C)
    only_c = collections.Counter(k[0] for k in C if k not in H)
    if only_h: print('updated only on host (frame: n):', dict(list(only_h.items())[:10]))
    if only_c: print('updated only on client (frame: n):', dict(list(only_c.items())[:10]))
    first_bad = {}
    for fr in frames:
        kinds = collections.Counter(); worst = []
        for (f, h), a in H.items():
            if f != fr or (f, h) not in C: continue
            b = C[(f, h)]
            d = max(abs(x - y) for x, y in zip(a['pos'], b['pos']))
            bad = []
            if d > tol: bad.append('pos')
            for k in ('human', 'ai', 'table', 'c13c', 'c140', 'cc', 'cd'):
                if a[k] != b[k]: bad.append(k)
            if a['flags'] != b['flags']: bad.append('flags')
            if abs(a['speed'] - b['speed']) > 1e-4: bad.append('speed')
            for k in bad: kinds[k] += 1
            if bad:
                first_bad.setdefault(h, (fr, a['name'], bad))
                worst.append((d, h, a['name'], bad, a, b))
        worst.sort(key=lambda w: -w[0])
        print('frame %6d: %3d characters differ  %s' % (fr, len(worst), dict(kinds)))
        for d, h, n, bad, a, b in worst[:3]:
            print('     %s %-24s d=%.3f %s  host flags %08X cmd %s/%s ai %s | client flags %08X cmd %s/%s ai %s'
                  % (h, n[:24], d, ','.join(bad), a['flags'], a['c13c'], a['c140'], a['ai'],
                     b['flags'], b['c13c'], b['c140'], b['ai']))
    print('first difference per character (first 25):')
    for h, (fr, n, bad) in sorted(first_bad.items(), key=lambda x: x[1][0])[:25]:
        print('   frame %6d %s %-24s %s' % (fr, h, n[:24], ','.join(bad)))

if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2], float(sys.argv[3]) if len(sys.argv) > 3 else 0.01)
