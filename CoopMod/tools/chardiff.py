import sys
from wsdiff import parse, key_list
H = key_list(parse(sys.argv[1])); C = key_list(parse(sys.argv[2]))
for k, he in H.items():
    if k[0] != 'CHARACTER': continue
    ce = C[k]; hv = he['vars']; cv = ce['vars']
    diffs = []
    for v in hv:
        a = hv[v]; b = cv.get(v)
        if b is None: continue
        bad = False
        for (t, x), (u, y) in zip(a, b):
            if t == 'F32':
                if abs(float(x) - float(y)) > 0.01: bad = True
            elif x != y: bad = True
        if bad: diffs.append('%s h=%s c=%s' % (v, ','.join(x for _, x in a[:3]), ','.join(y for _, y in b[:3])))
    if diffs:
        print(k, 'Player', hv['Player'][0][1], 'AI', hv['CharacterAI'][0][1])
        for d in diffs: print('    ', d)
