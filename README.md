# 哈基米西游 1.0.8.0 本地单机复刻

## 最终目标（唯一验收标准）

把《哈基米西游_1.0.8.0.apk》的**全部功能**完整复刻为本地单机版：客户端保持原版（画面、数值、流程、引导不变），原远程服务器由本地服务端替代，断网后游玩体验与原版一致。

已确认的需求决策（2026-09-26）：

| 问题 | 决策 |
|---|---|
| 服务端形态 | 先用 Python 在 PC 上实现并跑通全部功能（`server/`，客户端连 `127.0.0.1:9001`，经 `adb reverse` 转发）；功能完成后移植进 APK（Java 服务监听 127.0.0.1），做到装上即玩 |
| 依赖真人的玩法（好友/竞技/帮派/排行/聊天） | 服务端生成本地机器人玩家模拟，玩法流程完整可玩 |
| 充值 / VIP | 充值免费直接到账，按原档位发元宝和 VIP 经验 |
| 限时活动 | 客户端内存在的所有活动本地常开 |
| 原服独有数据（敌阵、掉率、奖励公式） | 优先从客户端配置表（`05_改造/data/config_dump.json`）和 Lua 逻辑推导；推导不出的用合理值，代码注释标 `推测值` |
| 实现顺序 | 按玩家成长路径，见 `文档/进度.md` |

硬性规则：
- 客户端只做最小离线化改动（地址指向本机、跳过 SDK/热更/支付校验、已证实的反编译缺陷修正），不改游戏内容。
- 服务端不得对未实现命令返回伪成功；未知命令记录并断开。
- 不给无限货币、不跳引导、不提前解锁（充值免费是唯一的"福利"例外）。

## 目录

| 路径 | 内容 |
|---|---|
| `哈基米西游_1.0.8.0.apk`、`00_原始样本/game.apk` | 原版基线（SHA-256 相同，只读） |
| `01_解包/` | APK 解包结果（script.dat、db.dat、资源） |
| `02_分析/` | 模块索引、脚本包拆分、分析工具 |
| `04_Lua源码/src/` | 909 个去符号反编译 Lua 模块。**只读参考**，用于查客户端如何发请求、如何消费响应 |
| `05_改造/schema/` | 从原包提取的协议：`protocol_schema.json`（命令/请求/响应）、`protocol_codes.json`（字段顺序） |
| `05_改造/data/config_dump.json` | 从 db.dat 导出的全部配置表（168 张，服务端规则数据来源） |
| `05_改造/lua/` | 旧的内嵌伪服务端 `LocalServer_logic.lua`（仅作逆向参考，不是最终实现） |
| `05_改造/apktool/` | Android 清单/smali 工作区 |
| `05_改造/baseline/` | 模拟器应用数据基线备份 |
| `06_构建/` | 最终产物 `hakimi_offline.apk`、`script_offline.dat`、签名 `sign/` |
| `09_脚本/` | 构建与工具脚本（见下） |
| `server/hakimi_server/` | **最终本地服务端**（Python） |
| `server/tests/` | 服务端自动测试 |
| `文档/` | `进度.md`（任务与进度）、`技术要点.md`（协议与踩坑）、`协议覆盖自动生成.md/.csv` |

调试截图、日志、测试 db 已不入库（见 `.gitignore`）。

## 快速开始（Windows 本机）

工具链：雷电模拟器 14（`D:\leidian\LDPlayer14\adb.exe`）、JDK 17、Lua 5.1（32 位 size_t luac）、openssl。包名 `com.eyugame.ahxy.mi`，入口 `com.eyugame.game.ActivityMain`。

```powershell
# 1. 构建客户端（只在改客户端补丁时需要）
$env:OFFLINE_STANDALONE = "1"; $env:OFFLINE_DEBUG = "1"
python 09_脚本\17_gen_localserver.py
python 09_脚本\18_build_offline.py        # -> 06_构建\hakimi_offline.apk

# 2. 启动服务端
python -m unittest discover -s server\tests
$env:PYTHONPATH = "server"
python -m hakimi_server.server --host 127.0.0.1 --port 19019 --data 06_构建\hakimi.db

# 3. 模拟器转发并启动
& D:\leidian\LDPlayer14\adb.exe reverse tcp:9001 tcp:19019
```

只改 Lua 时用 `09_脚本\31_debug_deploy.py` 替换 `files/assets/script.dat` 并重启，无需重装。

## 脚本

| 脚本 | 作用 |
|---|---|
| `16_extract_schema.py` | 从原包提取协议 schema |
| `17_gen_localserver.py` | 生成客户端内嵌的登录夹具 `LocalServer.lua` |
| `18_build_offline.py` | 打 Lua 补丁 → 编译 → 回填 script.dat → 改 manifest → 重建 APK → v1 签名 |
| `bytecode_overrides.py` | 在原字节码之后追加覆盖函数（保留原闭包），18 号脚本调用 |
| `25_patch_smali.py` | Android 兼容 smali 补丁 |
| `30_extract_db.py` | 导出 db.dat 配置表 |
| `31_debug_deploy.py` / `26_fast_deploy.py` / `deploy.ps1` | 部署与抓日志 |
| `32_protocol_coverage.py` | 生成协议覆盖清单（以 `server/` 为准） |
