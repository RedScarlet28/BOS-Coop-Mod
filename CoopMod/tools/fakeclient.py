import socket, struct, sys, time, subprocess, re

pid = int(sys.argv[1])
out = subprocess.run(['netstat', '-ano', '-p', 'UDP'], capture_output=True, text=True).stdout
ports = sorted({int(m.group(1)) for m in re.finditer(r'UDP\s+\S+:(\d+)\s+\S+\s+(\d+)', out) if int(m.group(2)) == pid})
print('server UDP ports:', ports)
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.bind(('127.0.0.1', 0))
s.settimeout(0.2)
frames = {}
cmds = 0
drv = {}
drv_shown = False
other = 0
st_frames = {}
st_shown = 0
end = time.time() + float(sys.argv[2])
last_hello = 0
while time.time() < end:
    if time.time() - last_hello > 1.5:
        for p in ports:
            s.sendto(b'CMH1', ('127.0.0.1', p))
        last_hello = time.time()
    try:
        data, addr = s.recvfrom(4096)
    except socket.timeout:
        continue
    if data[:4] == b'CMN1':
        frame, n, last = struct.unpack_from('<iHH', data, 4)
        frames[frame] = frames.get(frame, 0) + n
        cmds += n
        if n and cmds - n < 6:
            for i in range(n):
                a18, a1c, b20, b24, pid_ = struct.unpack_from('<5I', data, 12 + 20 * i)
                print('frame %d PLAYER %u buttons %08X %08X axes %08X %08X' % (frame, pid_, b20, b24, a18, a1c))
    elif data[:4] == b'CMD1':
        frame, n, last = struct.unpack_from('<iHH', data, 4)
        drv[frame] = drv.get(frame, 0) + n
        if n and not drv_shown:
            drv_shown = True
            for i in range(min(n, 4)):
                hid, sp, gait, cc, cd, fl = struct.unpack_from('<IfBBBB', data, 12 + 12 * i)
                print('drive frame %d char %08X speed %.3f gait %02X cc %d cd %d flags %d' % (frame, hid, sp, gait, cc, cd, fl))
    elif data[:4] == b'CMS1':
        frame, n, last = struct.unpack_from('<iHH', data, 4)
        st_frames[frame] = st_frames.get(frame, 0) + n
        off = 12
        for i in range(n):
            hid, ln, nv = struct.unpack_from('<IHH', data, off)
            if st_shown < 5:
                st_shown += 1
                print('state frame %d char %08X %d bytes, %d vars' % (frame, hid, ln, nv))
            off += 8 + ln
    else:
        other += 1
fs = sorted(frames)
print('NPC packets for %d frames (%s..%s), %d commands, %d other packets' % (len(fs), fs[:1], fs[-1:], cmds, other))
if fs:
    gaps = [b - a for a, b in zip(fs, fs[1:]) if b - a != 1]
    print('frame gaps:', gaps[:10])
ds=sorted(drv)
print('drive packets for %d frames (%s..%s), %d values' % (len(ds), ds[:1], ds[-1:], sum(drv.values())))
ss=sorted(st_frames)
print('NPC state packets for %d frames (%s..%s), %d records, avg %.1f per frame' % (len(ss), ss[:1], ss[-1:], sum(st_frames.values()), sum(st_frames.values())/max(1,len(ss))))
