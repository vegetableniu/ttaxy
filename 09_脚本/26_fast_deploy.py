#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
快速部署：只把新编译的 script.dat 推到游戏的资源目录并重启 App。
（游戏实际读的是 /sdcard/Android/data/<pkg>/files/assets/script.dat，
  不是 APK 里那份，所以改 Lua 完全不需要重装 APK。）

用法:  python 09_脚本/26_fast_deploy.py [等待秒数]
"""
import os, sys, time, subprocess

ROOT = r'C:\Users\nkq\Desktop\game\hakimi'
ADB = r'D:\leidian\LDPlayer14\adb.exe'
SER = '127.0.0.1:5555'
PKG = 'com.eyugame.ahxy.mi'
DEV_DAT = '/storage/emulated/0/Android/data/%s/files/assets/script.dat' % PKG
LOCAL_DAT = os.path.join(ROOT, '06_构建', 'script_offline.dat')
WAIT = int(sys.argv[1]) if len(sys.argv) > 1 else 60


def sh(*a, **kw):
    return subprocess.run([ADB, '-s', SER] + list(a), capture_output=True, text=True,
                          encoding='utf-8', errors='replace', **kw)


def log(s):
    print(s, flush=True)


t0 = time.time()
subprocess.run([ADB, 'start-server'], capture_output=True)
for _ in range(6):
    r = subprocess.run([ADB, 'connect', SER], capture_output=True, text=True,
                       encoding='utf-8', errors='replace')
    if 'connected' in (r.stdout or ''):
        break
    time.sleep(3)

if not os.path.exists(LOCAL_DAT):
    sys.exit('找不到 ' + LOCAL_DAT + '，先跑 18_build_offline.py')
log('推送 script.dat (%d 字节) ...' % os.path.getsize(LOCAL_DAT))
r = subprocess.run([ADB, '-s', SER, 'push', LOCAL_DAT, DEV_DAT],
                   capture_output=True, text=True, encoding='utf-8', errors='replace')
log('  ' + (r.stdout or r.stderr or '').strip().splitlines()[-1])

sh('shell', 'am', 'force-stop', PKG)
sh('logcat', '-c')
sh('shell', 'am', 'start', '-n', '%s/com.eyugame.game.ActivityMain' % PKG)
log('已启动，等待 %ds ...' % WAIT)
time.sleep(WAIT)

out = sh('logcat', '-d', '-v', 'brief', '-s', 'TwLog:V').stdout or ''
keep = ('PATCH', 'LocalServer', 'auto-answer', 'unknown', 'error', 'Send [', 'Recv [')
seen = []
for line in out.splitlines():
    if any(k in line for k in keep):
        i = line.find('TwLog')
        seen.append(line[i + 5:].lstrip(' :(').lstrip('0123456789) ') if i >= 0 else line)
for line in seen:
    log('  ' + line)

pid = (sh('shell', 'pidof', PKG).stdout or '').strip()
log('进程: %s   总耗时 %.0fs' % (pid or '已退出', time.time() - t0))

shot = os.path.join(ROOT, '08_存档', 'fast_%s.png' % time.strftime('%H%M%S'))
sh('shell', 'screencap', '-p', '/sdcard/_f.png')
sh('pull', '/sdcard/_f.png', shot)
log('截图: ' + shot)
