@echo off
rem Start local server + LDPlayer port forward. Emulator must be running with 06_build hakimi_offline.apk installed.
set ADB=D:\leidian\LDPlayer14\adb.exe
cd /d "%~dp0"
"%ADB%" reverse tcp:9001 tcp:19019
set PYTHONPATH=server
python -m hakimi_server.server --host 127.0.0.1 --port 19019 --data 06_¹¹½¨\hakimi.db
pause
