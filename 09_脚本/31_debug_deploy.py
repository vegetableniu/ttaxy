"""Preserve app data, update internal scripts, then collect a reproducible log."""
import pathlib
import subprocess
import sys
import time

ROOT = pathlib.Path(__file__).resolve().parents[1]
ADB = r'D:\leidian\LDPlayer14\adb.exe'
PKG = 'com.eyugame.ahxy.mi'


def adb(*args, binary=False):
    result = subprocess.run([ADB, '-s', '127.0.0.1:5555', *args], capture_output=True, check=True)
    return result.stdout if binary else result.stdout.decode('utf-8', errors='replace')


adb('shell', 'am', 'force-stop', PKG)
backup = ROOT / '05_改造' / 'baseline' / 'app_data.tar'
if not backup.exists():
    backup.write_bytes(adb('exec-out', 'run-as', PKG, 'tar', '-cf', '-', 'files', 'shared_prefs', binary=True))
    print('Saved app data backup', flush=True)
adb('push', str(ROOT / '06_构建' / 'script_offline.dat'), '/data/local/tmp/hakimi_script.dat')
adb('shell', 'run-as', PKG, 'cp', '/data/local/tmp/hakimi_script.dat', 'files/assets/script.dat')
adb('logcat', '-c')
print(adb('shell', 'am', 'start', '-n', PKG + '/com.eyugame.game.ActivityMain'), flush=True)
time.sleep(int(sys.argv[1]) if len(sys.argv) > 1 else 15)
log = adb('logcat', '-d', '-v', 'brief')
dest = ROOT / '06_构建' / ('debug_' + time.strftime('%H%M%S') + '.log')
dest.write_text(log, encoding='utf-8')
for line in log.splitlines():
    if any(key in line for key in ('[SCENE]', '[PATCH]', 'error ', 'attempt to', 'SIGSEGV', 'auto-answer', '[LocalServer] dispatch')):
        print(line)
print('LOG:', dest)
