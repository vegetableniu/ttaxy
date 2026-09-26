@echo off
chcp 65001 >nul
rem 一键启动：本地服务端 + 雷电模拟器端口转发（模拟器需已启动并安装 06_构建\hakimi_offline.apk）
set ADB=D:\leidian\LDPlayer14\adb.exe
cd /d %~dp0
"%ADB%" reverse tcp:9001 tcp:19019
set PYTHONPATH=server
python -m hakimi_server.server --host 127.0.0.1 --port 19019 --data 06_构建\hakimi.db
pause
