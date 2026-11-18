import sys, re, collections

def parse(path):
    ents = []  # list of (cls, ct, {var: [values]})
    cls = None; cur = None; var = None
    with open(path, encoding='latin-1') as f:
        for raw in f:
            line = raw.rstrip('\r\n')
            if line.startswith('ENTITY_NAME :'):
                cls = line[13:].rstrip('>'); continue
            if line.startswith('CT :'):
                cur = {'cls': cls, 'ct': line[4:].strip(), 'vars': collections.OrderedDict()}
                ents.append(cur); var = None; continue
            if cur is None: continue
            if line.startswith('-VN :'):
                var = line[5:].strip(); cur['vars'][var] = []; continue
            if var is None: continue
            m = re.match(r'^(F32|S32 |U32 |BOOL |[A-Za-z]+ ?):(.*)$', line)
            if m:
                cur['vars'][var].append((m.group(1).strip(), m.group(2).strip()))
    return ents

def key_list(ents):
    out = collections.OrderedDict(); seen = collections.Counter()
    for e in ents:
        k = (e['cls'], e['ct'], seen[(e['cls'], e['ct'])]); seen[(e['cls'], e['ct'])] += 1
        out[k] = e
    return out

def main(h, c, tol=1e-3):
    H = key_list(parse(h)); C = key_list(parse(c))
    only_h = [k for k in H if k not in C]; only_c = [k for k in C if k not in H]
    print('entities host %d client %d; only host %d only client %d' % (len(H), len(C), len(only_h), len(only_c)))
    for k in only_h[:20]: print('  only host  ', k)
    for k in only_c[:20]: print('  only client', k)
    stats = collections.defaultdict(lambda: [0, 0, 0.0, []])  # cls.var -> [instances, differing, maxabs, samples]
    for k, he in H.items():
        ce = C.get(k)
        if not ce: continue
        for v, hv in he['vars'].items():
            cv = ce['vars'].get(v)
            s = stats[(k[0], v)]; s[0] += 1
            if cv is None: s[1] += 1; s[3].append('missing'); continue
            diff = False; mx = 0.0
            if len(hv) != len(cv): diff = True
            for (ht, hx), (ct, cx) in zip(hv, cv):
                if ht == 'F32':
                    try:
                        d = abs(float(hx) - float(cx))
                    except ValueError:
                        d = 0 if hx == cx else 1e9
                    mx = max(mx, d)
                    if d > tol: diff = True
                elif hx != cx: diff = True; mx = max(mx, 1e9)
            if diff:
                s[1] += 1; s[2] = max(s[2], mx)
                if len(s[3]) < 3:
                    s[3].append('ct%s h=%s c=%s' % (k[1], ','.join(x for _, x in hv[:4]), ','.join(x for _, x in cv[:4])))
    rows = [(k, s) for k, s in stats.items() if s[1]]
    rows.sort(key=lambda r: (-r[1][1], r[0]))
    for (cl, v), s in rows:
        print('%-22s %-28s %3d/%-3d max %-10s %s' % (cl, v, s[1], s[0], ('%.4g' % s[2]) if s[2] < 1e8 else 'discrete', ' | '.join(s[3])))

if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2], float(sys.argv[3]) if len(sys.argv) > 3 else 1e-3)
