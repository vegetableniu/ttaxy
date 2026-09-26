# 本机独立服务端

这里是最终方案的服务端代码。它直接实现原客户端的 TCP 帧、动态二进制协议、会话、业务状态和存档，不依赖 APK 内的 `LocalServer.lua`。

传输和登录到主城的原生链路已经过实机验证。当前业务仍是固定账号夹具；下一步是 SQLite 新账号创建与版本化存档。业务域按照 `../文档/协议覆盖自动生成.md` 的依赖顺序逐项迁移。`../05_改造/lua/LocalServer_logic.lua` 只作为逆向试验和响应对照，不是服务端业务代码来源。

运行自检：

```powershell
Set-Location server
python -m unittest discover -s tests -v
```

启动服务端：

```powershell
$env:PYTHONPATH = "server"
python -m hakimi_server.server --host 127.0.0.1 --port 9001
```

模拟器调试时可用 `adb reverse tcp:9001 tcp:9001` 把 Android 客户端的回环地址映射到电脑本机。
