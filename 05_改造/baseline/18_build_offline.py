#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
18_build_offline.py（哈基米西游版）
把反编译源码打补丁 -> luac 编译 -> 重打包 script.dat -> 重建 APK。

与原版 ttaxy 的关键差异：
  - 哈基米源码是「去符号」反编译：函数签名 `function class.Method(A0_x, A1_y)`，
    方法体里 `self` 被改名成 `A0_x`；且 unluac 对未命名 upvalue 输出 `_UPVALUE0_` 占位。
  - 因此补丁锚点要用 A0_x 风格，并在注入代码里 `local self = A0_x` 复用原版补丁逻辑。
  - 两处登录关键函数（InitServerLst / HandleServerUnopened）含 `_UPVALUE0_` 占位，
    重编译后会变成 nil 全局导致崩溃，这里直接整函数重写。
"""
import os, re, sys, json, shutil, struct, subprocess, hashlib, base64, zipfile

ROOT = r'C:\Users\nkq\Desktop\game\hakimi'
TT = r'C:\Users\nkq\Desktop\game\ttaxy'   # 工具链在原版工作区
SRC = os.path.join(ROOT, '04_Lua源码', 'src')
WRK = os.path.join(ROOT, '05_改造')
PATCHED = os.path.join(WRK, 'patched')
BUILD = os.path.join(ROOT, '06_构建')
LUAC = os.path.join(TT, '03_工具链', 'lua51', 'luac.exe')
APK_IN = os.path.join(ROOT, '00_原始样本', 'game.apk')
DAT_IN = os.path.join(ROOT, '01_解包', 'assets', 'script.dat')
DEX_PATCHED = os.path.join(BUILD, 'classes.dex')
LOCALSERVER = os.path.join(WRK, 'lua', 'LocalServer.lua')
MODULE_LIST = os.path.join(ROOT, '02_分析', 'module_list.txt')

for d in (PATCHED, BUILD):
    os.makedirs(d, exist_ok=True)

report = []


def log(s):
    print(s, flush=True)
    report.append(s)


# ---------- 1. 建立 模块名 -> 容器key 映射（module_list.txt: "<key>  <mod>  <size>"） ----------
key_of = {}
for line in open(MODULE_LIST, encoding='utf-8'):
    line = line.rstrip('\n')
    if not line.strip():
        continue
    parts = line.split()
    if len(parts) >= 2:
        try:
            key_of[parts[1]] = int(parts[0], 16)
        except ValueError:
            pass
log('[1] 模块名->key 映射: %d 条' % len(key_of))


# ---------- 2. 打补丁 ----------
def read(mod):
    p = os.path.join(SRC, mod.replace('/', '__') + '.lua')
    return open(p, encoding='utf-8').read()


def sub1(txt, old, new, tag):
    if old not in txt:
        raise SystemExit('!! 补丁锚点未找到: ' + tag)
    if txt.count(old) != 1:
        raise SystemExit('!! 补丁锚点不唯一(%d): %s' % (txt.count(old), tag))
    return txt.replace(old, new, 1)


patches = {}

# ---- 2.1 NetMsg：注入 LocalServer + 拦截 Send ----
ls_code = open(LOCALSERVER, encoding='utf-8').read()
ls_code = re.sub(r'^return LS\s*$', '-- (inlined into NetMsg)', ls_code, flags=re.M)
netmsg = read('base/NetMsg')
anchor = 'function class:Send(mod, cmd, data, login)'
new_send = '''function class:Send(mod, cmd, data, login)
  if _G.__LocalServer and _G.__LocalServer.enabled then
    return _G.__LocalServer.dispatch(mod, cmd, data)
  end'''
netmsg = sub1(netmsg, anchor, new_send, 'NetMsg:Send')
netmsg = netmsg.replace('module((...), package.seeall)', 'module((...), package.seeall)\n\n' + ls_code, 1)
patches['base/NetMsg'] = netmsg
log('[2.1] NetMsg      注入 LocalServer(%d 字节) + Send 拦截' % len(ls_code))

# ---- 2.2 AutoPatch：跳过全部 HTTP 热更 ----
ap = read('Logic/AutoPatch')
anchor = 'function class.StartQuery(A0_15)'
new = '''function class.StartQuery(A0_15)
  local self = A0_15
  if _G.__LocalServer and _G.__LocalServer.enabled then
    log4misc:warn("[PATCH] AutoPatch skip -> local server list")
    if not Logic:Get("Login"):InitServerLst(_G.__LocalServer.SERVER_JSON) then
      log4misc:warn("[PATCH] InitServerLst failed")
      return
    end
    A0_15:done()
    return
  end'''
ap = sub1(ap, anchor, new, 'AutoPatch:StartQuery')
patches['Logic/AutoPatch'] = ap
log('[2.2] AutoPatch    跳过热更新 HTTP，直接本地区服列表')

# ---- 2.3 GameStageAutoPatch：离线时跳过平台 SDK 与热更，直接进选服/登录 ----
gap = read('Stage/GameStageAutoPatch')
anchor = 'function class:OnStageActive()'
new = '''function class:OnStageActive()
  if _G.__LocalServer and _G.__LocalServer.enabled then
    log4misc:warn("[PATCH] offline: skip Sdk+AutoPatch -> go Logout")
    Logic:Get("Login"):InitServerLst(_G.__LocalServer.SERVER_JSON)
    Logic:Get("Login"):SetLoadingStage(Logic.Login.LOAD_STAGE.ENTERGAME)
    local _pok,_perr = pcall(function() Tw.TexturePreloader:getInstance():preload() end); if not _pok then log4misc:warn('[PATCH] preload error: '..tostring(_perr)) end
    Singleton(Timer):After(1200, self:Event("OFFLINE_GO", function()
      log4misc:warn("[PATCH] offline: ChgStage Logout")
      Logic:Get("Account"):SetAutoLogin(true)
      Singleton(GameStage):ChgStage("Logout", true)
    end))
    return
  end'''
gap = sub1(gap, anchor, new, 'GameStageAutoPatch:OnStageActive')
patches['Stage/GameStageAutoPatch'] = gap
log('[2.3] GameStageAutoPatch  跳过平台 SDK + 热更，延时直接切 Logout 阶段')

# ---- 2.4 Account：CheckUser 走本地（直接 LoginFinish，绕开 QueryRole 的 _UPVALUE0_）----
acc = read('Logic/Account')
anchor = 'function class.CheckUser(A0_101, A1_102)'
new = '''function class.CheckUser(A0_101, A1_102)
  local self = A0_101
  if _G.__LocalServer and _G.__LocalServer.enabled then
    log4misc:warn("[PATCH] Account:CheckUser -> local")
    self.userId = self.account or _G.__LocalServer.ACCOUNT
    self.sign = "localsign"
    self.time = os.time()
    self.bVisitor = false
    self:LoginFinish(self.userId)
    return
  end'''
acc = sub1(acc, anchor, new, 'Account:CheckUser')
# 崩溃上报回调里的 _UPVALUE0_ 重编译后是 nil，报错时再触发会导致二次崩溃，这里改成空回调
acc = acc.replace('setupCrashReporter(function(A0_2)\n    _UPVALUE0_:AddCrashLog(A0_2)\n  end)',
                  'setupCrashReporter(function(A0_2)\n    -- offline: crash report disabled\n  end)', 1)
# inquireServerInfo 里 _UPVALUE0_(L1_93) 是函数 upvalue（重编译后 nil），且离线无需查询服务器信息
_i = acc.find('function class.inquireServerInfo(A0_92)')
_j = acc.find('function class.OnInquireServer', _i)
if _i < 0 or _j < 0:
    raise SystemExit('Account inquireServerInfo 重写失败')
acc = acc[:_i] + '''function class.inquireServerInfo(A0_92)
  -- offline: skip server info inquiry
end
''' + acc[_j:]
patches['Logic/Account'] = acc
log('[2.4] Account      CheckUser 跳过 HTTP 账号校验；inquireServerInfo 离线跳过')

# ---- 2.5 Login：跳过版本检查，直接进服握手 ----
lg = read('Logic/Login')
anchor = 'function class.Login(A0_11)'
new = '''function class.Login(A0_11)
  local self = A0_11
  if _G.__LocalServer and _G.__LocalServer.enabled then
    log4misc:warn("[PATCH] Login:Login -> OnDescription (skip version check)")
    self:EventTracer():Cancel("CHECK_VERSION")
    self:OnDescription(0)
    return
  end'''
lg = sub1(lg, anchor, new, 'Login:Login')

# ---- 2.5a 把 initialize 里的 _UPVALUE 占位改成 nil（否则 StrictCheck 未声明变量告警会触发
#         buildReport -> Logic:Get("Login") 递归，造成 "loop or previous error"）----
lg = lg.replace('Logic:Get("MsgAssist"):RecordErrorMsg("MsgAccount", _UPVALUE0_, _UPVALUE1_)',
                'Logic:Get("MsgAssist"):RecordErrorMsg("MsgAccount", nil, nil)', 1)
lg = lg.replace('Logic:Get("MsgAssist"):RecordErrorMsg("MsgTencent", _UPVALUE2_, _UPVALUE3_)',
                'Logic:Get("MsgAssist"):RecordErrorMsg("MsgTencent", nil, nil)', 1)

# ---- 2.5x 重写 InitServerLst（原函数内闭包引用 _UPVALUE0_/_UPVALUE1_，重编译会变 nil 全局导致返回 false）----
_i = lg.find('function class.InitServerLst(A0_4, A1_5)')
_j = lg.find('function class.GetServerLst', _i)
if _i < 0 or _j < 0:
    raise SystemExit('InitServerLst 重写失败')
lg = lg[:_i] + '''function class.InitServerLst(A0_4, A1_5)
  if nil == A1_5 or "" == A1_5 then
    return false
  end
  local ok, decoded = pcall(function()
    return json.decode(A1_5)
  end)
  if not ok or type(decoded) ~= "table" then
    return false
  end
  A0_4.serverLst = decoded.list or decoded
  return true
end
''' + lg[_j:]

# ---- 2.5y 重写 HandleServerUnopened（离线无此错误，返回 false 即可，避免 _UPVALUE0_.ACCOUNT_ALREADY_EXISTS 崩）----
_i = lg.find('function class.HandleServerUnopened(A0_102, A1_103, A2_104)')
_j = lg.find('function class.OnCheckAccount', _i)
if _i < 0 or _j < 0:
    raise SystemExit('HandleServerUnopened 重写失败')
lg = lg[:_i] + '''function class.HandleServerUnopened(A0_102, A1_103, A2_104)
  return false
end
''' + lg[_j:]

# ---- 2.5z 重写 RecordServerInfo（去符号反编译丢失局部变量导致 #nil 崩，离线不需要记录区服）----
_i = lg.find('function class.RecordServerInfo(A0_47, A1_48)')
_j = lg.find('function class.ForgetAccountPassword', _i)
if _i < 0 or _j < 0:
    raise SystemExit('RecordServerInfo 重写失败')
lg = lg[:_i] + '''function class.RecordServerInfo(A0_47, A1_48)
  if nil == A1_48 then
    return
  end
end
''' + lg[_j:]

# ---- 2.5w 修 PostLogin 里 IsOperator 的寄存器复用 bug（去符号反编译把实例和方法复用同一寄存器，
#        导致 self 传错 -> "attempt to index a function value"）----
_bad_iso = '''  L9_117 = Logic
  L9_117 = L9_117.Get
  L9_117 = L9_117(L9_117, "System")
  L9_117 = L9_117.IsOperator
  L9_117 = L9_117(L9_117, "appstore")'''
_good_iso = '''  L9_117 = Logic:Get("System"):IsOperator("appstore")'''
if _bad_iso not in lg:
    raise SystemExit('PostLogin IsOperator 补丁锚点未找到')
lg = lg.replace(_bad_iso, _good_iso, 1)

# ---- 2.5v 修 OnLoginInfo 等函数里「Logic:Get("X"):Method(arg)」被去符号反编译成寄存器复用 bug ----
# 反编译产出：
#   L3_130 = Logic
#   L3_130 = L3_130.Get
#   L3_130 = L3_130(L3_130, "X")
#   L3_130 = L3_130.Method
#   L3_130(L3_130, arg)      <- self 传成了 Method 自身，而非 X 实例
# 统一改回：L3_130 = Logic:Get("X"):Method(arg)
_broken_call = re.compile(
    r'  (L\d+_\d+) = Logic\n'
    r'  \1 = \1\.Get\n'
    r'  \1 = \1\(\1, "([^"]+)"\)\n'
    r'  \1 = \1\.(\w+)\n'
    r'  \1(?: = \1)?\(\1(?:, ([^\n]*?))?\)')
def _fix_call(m):
    reg, name, method, arg = m.group(1), m.group(2), m.group(3), m.group(4)
    argstr = arg if (arg is not None and arg.strip()) else ''
    call = 'Logic:Get("%s"):%s(%s)' % (name, method, argstr)
    if method == 'GetServerVer':
        return '  %s = %s' % (reg, call)
    # 其余初始化调用逐行 pcall 保护，单个子系统失败不中断登录链
    return '  %s = pcall(function() %s end)' % (reg, call)
lg = _broken_call.sub(_fix_call, lg)
# IsOperator("myapp") 的返回值被 if 使用，不能 pcall 包（否则返回 true 会误入 myapp 分支）
lg = lg.replace('  L3_130 = pcall(function() Logic:Get("System"):IsOperator("myapp") end)',
                '  L3_130 = Logic:Get("System"):IsOperator("myapp")', 1)
# initLoggedServer 丢失局部变量（L5_202/L6_203 未赋值即调用），离线只需空列表
_i = lg.find('function class.initLoggedServer(A0_197)')
_j = lg.find('function class.GetLoggedServerByIdx', _i)
if _i < 0 or _j < 0:
    raise SystemExit('Login initLoggedServer 重写失败')
lg = lg[:_i] + '''function class.initLoggedServer(A0_197)
  A0_197.loggedServerLst = {}
end
''' + lg[_j:]
log('[2.5v] Login 寄存器复用修正（Logic:Get 链 + 逐行 pcall）')
patches['Logic/Login'] = lg
log('[2.5] Login        Login() 跳过版本检查；InitServerLst/HandleServerUnopened 已重写去 _UPVALUE')

# ---- 2.6b GameStageNormal：Root 场景结果可见 ----
gn = read('Stage/GameStageNormal')
anchor = 'local sceneMain = SceneHelper:replaceScene("Root")'
new = '''local sceneMain = SceneHelper:replaceScene("Root")
  log4misc:warn("[PATCH] Normal: replaceScene(Root) -> " .. tostring(sceneMain))'''
gn = sub1(gn, anchor, new, 'GameStageNormal:OnStageActive')
patches['Stage/GameStageNormal'] = gn
log('[2.6b] GameStageNormal  记录 Root 场景创建结果')

# ---- 2.6 GameStageLogout：自动选服 + 自动登录 ----
glo = read('Stage/GameStageLogout')
anchor = '  SceneHelper:replaceScene("GameLoading")\nend'
new = '''  SceneHelper:replaceScene("GameLoading")
  if _G.__LocalServer and _G.__LocalServer.enabled then
    log4misc:warn("[PATCH] Logout: schedule autoLogin")
    Logic:Get("Login"):SetSelectServer(1)
    Singleton(Timer):After(2000, self:Event("OFFLINE_LOGIN", function()
      log4misc:warn("[PATCH] Logout: timer autoLogin")
      _G.__LocalServer.autoLogin()
    end))
  end
end'''
glo = sub1(glo, anchor, new, 'GameStageLogout:OnStageActive')
patches['Stage/GameStageLogout'] = glo
log('[2.6] GameStageLogout  自动选服 + 2 秒后自动登录')

# ---- 2.8 GameStage：记录阶段切换 ----
gs = read('base/GameStage')
anchor = 'function mgr:ChgStage(type, ...)'
new = '''function mgr:ChgStage(type, ...)
  log4misc:warn("[PATCH] ChgStage -> " .. tostring(type))'''
gs = sub1(gs, anchor, new, 'GameStage:ChgStage')
patches['base/GameStage'] = gs
log('[2.8] base/GameStage     记录阶段切换')

# ---- 2.9 EnvLogic：Login / Regist / AnonymityLogin 本地化（防 SDK 空指针崩溃）----
env = read('Logic/EnvLogic')
for _fn, _self in (('Login', 'A0_5'), ('Regist', 'A0_11'), ('AnonymityLogin', 'A0_25')):
    _a = 'function class.%s(' % _fn
    _i = env.find(_a)
    if _i < 0:
        raise SystemExit('EnvLogic 补丁失败，找不到 ' + _fn)
    _j = env.index('\n', _i) + 1
    block = ('  do\n'
             '    log4misc:warn("[PATCH] EnvLogic:%s -> local (LS=" .. tostring(_G.__LocalServer ~= nil) .. ")")\n'
             '    if _G.__LocalServer and _G.__LocalServer.autoLogin\n'
             '       and not _G.__LocalServer.loginScheduled then\n'
             '      _G.__LocalServer.loginScheduled = true\n'
             '      Singleton(Timer):After(800, %s:Event("ENVLOGIN_LOCAL", function()\n'
             '        _G.__LocalServer.autoLogin()\n'
             '      end))\n'
             '    end\n'
             '    return\n'
             '  end\n') % (_fn, _self)
    env = env[:_j] + block + env[_j:]
patches['Logic/EnvLogic'] = env
log('[2.9] Logic/EnvLogic   Login/Regist/AnonymityLogin 本地化')

# ---- 2.9b EnvLogic:LoginComplete 里 CReflectSystem:GetSingleton() 有寄存器复用 bug，
#        离线不需要上报 SDK，直接重写成空 ----
_i = env.find('function class.LoginComplete(A0_37)')
_j = env.find('function class.Logout', _i)
if _i < 0 or _j < 0:
    raise SystemExit('EnvLogic LoginComplete 重写失败')
env = env[:_i] + '''function class.LoginComplete(A0_37)
  -- offline: skip CReflectSystem SDK event
end
''' + env[_j:]
patches['Logic/EnvLogic'] = env

# ---- 2.10 Guide：跳过所有新手引导 ----
gd = read('Logic/Guide')
anchor = 'function class.check(A0_3)'
new = '''function class.check(A0_3)
  local self = A0_3
  if _G.__LocalServer and _G.__LocalServer.enabled then
    self.modules = {}
    self.triggers = {}
    self.guides = {}
    return
  end'''
gd = sub1(gd, anchor, new, 'Guide:check')
# Guide:reload 里 CVariableSystem:GetSingleton() 有寄存器复用 bug，且离线跳过引导，直接清空
_i = gd.find('function class.reload(A0_35)')
_j = gd.find('function class.save', _i)
if _i < 0 or _j < 0:
    raise SystemExit('Guide reload 重写失败')
gd = gd[:_i] + '''function class.reload(A0_35)
  A0_35.modules = {}
  A0_35.triggers = {}
  A0_35.guides = {}
end
''' + gd[_j:]
patches['Logic/Guide'] = gd
log('[2.10] Logic/Guide     跳过所有新手引导')

# ---- 2.11 BattleShow:GotoNextResult 离线时不自动弹升级界面 ----
bs_ = read('Logic/BattleShow')
anchor = 'function class.GotoNextResult(A0_161)'
new = '''function class.GotoNextResult(A0_161)
  if _G.__LocalServer and _G.__LocalServer.enabled then
    return
  end'''
bs_ = sub1(bs_, anchor, new, 'BattleShow:GotoNextResult')
# GetReport 里 _UPVALUE1_:ReadReportFromFile() 有 _UPVALUE 占位；离线无战报可恢复，直接返回 nil
_i = bs_.find('function class.GetReport(A0_143)')
_j = bs_.find('function class.SetRemainDropItems', _i)
if _i < 0 or _j < 0:
    raise SystemExit('BattleShow GetReport 重写失败')
bs_ = bs_[:_i] + '''function class.GetReport(A0_143)
  return nil
end
''' + bs_[_j:]
patches['Logic/BattleShow'] = bs_
log('[2.11] Logic/BattleShow  不自动弹升级界面；GetReport 离线返回 nil')

# ---- 2.12 Friend:IsNeedGetNewCommendFriend 离线时不刷新好友 ----
fr_ = read('Logic/Friend')
anchor = 'function class.IsNeedGetNewCommendFriend(A0_157)'
new = '''function class.IsNeedGetNewCommendFriend(A0_157)
  if _G.__LocalServer and _G.__LocalServer.enabled then
    return false
  end'''
fr_ = sub1(fr_, anchor, new, 'Friend:IsNeedGetNewCommendFriend')
# 诊断：定位 Friend initialize 加载失败点
fr_ = fr_.replace('function class.initialize(A0_1)',
                  'function class.initialize(A0_1)\n  log4misc:warn("[DBG] Friend init start")', 1)
fr_ = fr_.replace('  A0_1.hasDemog = false\nend',
                  '  A0_1.hasDemog = false\n  log4misc:warn("[DBG] Friend init done")\nend', 1)
patches['Logic/Friend'] = fr_
log('[2.12] Logic/Friend    离线时不刷新好友列表')

# ---- 2.13 StrictCheck：禁用未声明变量告警 ----
# 去符号反编译会把未命名 upvalue 输出成 _UPVALUE0_ 占位，重编译后变成未声明全局；
# 一旦在模块加载期被访问，StrictCheck 的 log4misc:warn 会走 logger -> buildReport
# -> Logic:Get("Login") 递归，直接 "loop or previous error"。这里关掉告警即可。
sc = read('base/StrictCheck')
sc = sc.replace('log4misc:warn("assign to undeclared variable \'" .. n .. "\'")',
                '-- strict warn disabled', 1)
sc = sc.replace('log4misc:warn("variable \'" .. n .. "\' is not declared")',
                '-- strict warn disabled', 1)
patches['base/StrictCheck'] = sc
log('[2.13] base/StrictCheck  禁用未声明变量告警')

# ---- 2.14 通用寄存器复用修正：GLOBAL:GetSingleton():Method(...) 链 ----
# 去符号反编译把 self 传错（把方法本身当 self），统一改回 GLOBAL:GetSingleton():Method(arg)
_singleton_call = re.compile(
    r'  (L\d+_\d+) = (\w+)\n'
    r'  \1 = \1\.GetSingleton\n'
    r'  \1 = \1\(\1\)\n'
    r'  \1 = \1\.(\w+)\n'
    r'  \1(?: = )?\1\(\1(?:, ([^\n]*?))?\)')
def _fix_singleton(m):
    reg, g, method, arg = m.group(1), m.group(2), m.group(3), m.group(4)
    argstr = arg if (arg is not None and arg.strip()) else ''
    return '  %s = %s:GetSingleton():%s(%s)' % (reg, g, method, argstr)
for _mod in patches:
    patches[_mod] = _singleton_call.sub(_fix_singleton, patches[_mod])
log('[2.14] 通用 GetSingleton 链寄存器复用修正')

# ---- 2.15 通用 RecordErrorMsg 的 _UPVALUE 占位改成 nil ----
# 去符号反编译把 RecordErrorMsg 的错误码 upvalue 变成 _UPVALUE0_/_UPVALUE1_ 占位，
# 重编译后是未声明全局；改成 nil 即可（RecordErrorMsg 对 nil 直接 return）。
_record_err = re.compile(r'RecordErrorMsg\(("[\w]+"), _UPVALUE\d+_, _UPVALUE\d+_\)')
for _mod in patches:
    patches[_mod] = _record_err.sub(r'RecordErrorMsg(\1, nil, nil)', patches[_mod])
log('[2.15] 通用 RecordErrorMsg _UPVALUE -> nil 修正')

# ---- 2.16 通用 class = Logic.class:subclass() 的寄存器复用修正 ----
# 反编译把 class = Logic.class:subclass() 拆成 L0_0 复用（subclass 把自身当 self），
# 统一改回 class = Logic.class:subclass()
_class_call = re.compile(
    r'L0_0 = Logic\nL0_0 = L0_0\.class\nL0_0 = L0_0\.subclass\nL0_0 = L0_0\(L0_0\)\nclass = L0_0')
for _mod in patches:
    patches[_mod] = _class_call.sub('class = Logic.class:subclass()', patches[_mod])
log('[2.16] 通用 class=Logic.class:subclass() 寄存器复用修正')

# ---- 2.17 通用 GLOBAL:Method(...) 三行式寄存器复用修正 ----
# 反编译把 X:Method(arg) 拆成 L_x=X; L_x=L_x.Method; L_x=L_x(L_x,arg)，self 传成了 Method 自身。
# 统一改回 X:Method(arg)。在 5 行式（GetSingleton/Logic:Get 链）之后运行，避免打断链。
_static_call = re.compile(
    r'  (L\d+_\d+) = (\w+)\n'
    r'  \1 = \1\.(\w+)\n'
    r'  \1(?: = \1)?\(\1(?:, ([^\n]*?))?\)')
def _fix_static(m):
    reg, g, method, arg = m.group(1), m.group(2), m.group(3), m.group(4)
    argstr = arg if (arg is not None and arg.strip()) else ''
    return '  %s = %s:%s(%s)' % (reg, g, method, argstr)
for _mod in patches:
    patches[_mod] = _static_call.sub(_fix_static, patches[_mod])
log('[2.17] 通用 GLOBAL:Method() 三行式寄存器复用修正')

# ---- 2.18 通用 tonumber(X) <= 0 防 nil 比较 ----
# 反编译代码里 tonumber(A1_x) 可能返回 nil（非数字入参），nil <= 0 会崩；加 or 0 兜底。
for _mod in patches:
    patches[_mod] = re.sub(r'tonumber\(([A-Z]\d+_\d+)\) <= 0', r'(tonumber(\1) or 0) <= 0', patches[_mod])
log('[2.18] 通用 tonumber 防 nil 比较修正')

# ---- 2.19 通用 A_y:Method1():Method2(...) 四行式寄存器复用修正 ----
# 反编译把 A_y:EventTracer():Exist(x) 拆成 L_x=A_y.EventTracer; L_x=L_x(A_y);
# L_x=L_x.Exist; L_x=L_x(L_x,x)，第二个 self 传成了 Exist 自身。统一改回链式调用。
_chain_call = re.compile(
    r'  (L\d+_\d+) = (A\d+_\d+)\.(\w+)\n'
    r'  \1 = \1\(\2\)\n'
    r'  \1 = \1\.(\w+)\n'
    r'  \1(?: = \1)?\(\1(?:, ([^\n]*?))?\)')
def _fix_chain(m):
    reg, self_, m1, m2, arg = m.group(1), m.group(2), m.group(3), m.group(4), m.group(5)
    argstr = arg if (arg is not None and arg.strip()) else ''
    return '  %s = %s:%s():%s(%s)' % (reg, self_, m1, m2, argstr)
for _mod in patches:
    patches[_mod] = _chain_call.sub(_fix_chain, patches[_mod])
log('[2.19] 通用 A:Method1():Method2() 链式寄存器复用修正')

for mod, txt in patches.items():
    fn = os.path.join(PATCHED, mod.replace('/', '__') + '.lua')
    open(fn, 'w', encoding='utf-8').write(txt)
log('[2] 已生成 %d 个补丁模块 -> %s' % (len(patches), PATCHED))


# ---------- 3. 语法检查 + 编译 ----------
luac_dir = os.path.join(BUILD, '_luac')
shutil.rmtree(luac_dir, ignore_errors=True)
os.makedirs(luac_dir, exist_ok=True)
compiled = {}
for mod, txt in patches.items():
    src = os.path.join(PATCHED, mod.replace('/', '__') + '.lua')
    out = os.path.join(luac_dir, mod.replace('/', '__') + '.luac')
    r = subprocess.run([LUAC, '-s', '-o', out, src], capture_output=True, text=True)
    if r.returncode != 0:
        log('  [FAIL] %-28s %s' % (mod, (r.stderr or r.stdout)[:400]))
        raise SystemExit('编译失败: ' + mod)
    compiled[mod] = open(out, 'rb').read()
    log('  [OK] %-28s %d -> %d 字节' % (mod, len(txt), len(compiled[mod])))
log('[3] luac 编译通过: %d/%d' % (len(compiled), len(patches)))


# ---------- 4. 重打包 script.dat ----------
def parse(blob):
    assert blob[:4] == b'PFDW'
    count, payload_end = struct.unpack_from('<II', blob, 4)
    toc = [struct.unpack_from('<IIII', blob, payload_end + i * 16) for i in range(count)]
    return count, payload_end, toc


def rebuild(blob, replace):
    count, payload_end, toc = parse(blob)
    order = sorted(toc, key=lambda e: e[1])
    out = bytearray()
    new_toc = []
    for k, off, size, r4 in order:
        data = replace.get(k)
        if data is None:
            data = blob[off:off + size]
        new_off = 12 + len(out)
        out += data
        new_toc.append((k, new_off, len(data), r4))
    new_toc.sort(key=lambda e: e[0])
    return (b'PFDW' + struct.pack('<II', count, 12 + len(out)) + bytes(out) +
            b''.join(struct.pack('<IIII', *e) for e in new_toc))


dat = open(DAT_IN, 'rb').read()
replace = {}
for mod, blob in compiled.items():
    k = key_of.get(mod)
    if k is None:
        raise SystemExit('找不到模块对应的容器 key: ' + mod)
    replace[k] = blob
    log('  %-28s key=%08x' % (mod, k))
new_dat = rebuild(dat, replace)
dat_out = os.path.join(BUILD, 'script_offline.dat')
open(dat_out, 'wb').write(new_dat)
c2, pe2, toc2 = parse(new_dat)
assert c2 == parse(dat)[0] and pe2 == 12 + sum(e[2] for e in toc2)
log('[4] script.dat 重打包完成: %d -> %d 字节 (%s)' % (len(dat), len(new_dat), dat_out))


# ---------- 4.5 改 AndroidManifest 的 targetSdkVersion ----------
import importlib.util
_spec = importlib.util.spec_from_file_location('axmlmod', os.path.join(ROOT, '02_分析', 'tools', 'axml.py'))
axmlmod = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(axmlmod)

NEW_TARGET_SDK = 22


def patch_manifest(blob):
    sp, pool_size, _ = axmlmod.parse_string_pool(blob, 8)
    pos = 8 + pool_size
    n = len(blob)
    while pos < n - 8:
        typ, hsize, size = struct.unpack_from('<HHI', blob, pos)
        if size == 0:
            break
        if typ == 0x0102:
            attrstart, attrsize, attrcount = struct.unpack_from('<HHH', blob, pos + 24)
            for i in range(attrcount):
                p = pos + 16 + attrstart + i * attrsize
                if p + 20 > n:
                    break
                an = struct.unpack_from('<i', blob, p + 4)[0]
                if 0 <= an < len(sp) and sp[an] == 'targetSdkVersion':
                    old = struct.unpack_from('<I', blob, p + 16)[0]
                    return blob[:p + 16] + struct.pack('<I', NEW_TARGET_SDK) + blob[p + 20:], old
        pos += size
    return blob, None


MANIFEST_IN = os.path.join(ROOT, '01_解包', 'AndroidManifest.xml')
man_in = open(MANIFEST_IN, 'rb').read()
man_out, old_target = patch_manifest(man_in)
if old_target is None:
    log('[4.5] !! 没找到 targetSdkVersion，manifest 未修改')
else:
    open(os.path.join(BUILD, 'AndroidManifest.xml'), 'wb').write(man_out)
    log('[4.5] AndroidManifest targetSdkVersion: %s -> %s（长度不变 %d）'
        % (old_target, NEW_TARGET_SDK, len(man_out) == len(man_in)))


# ---------- 5. 重建 APK ----------
def make_apk():
    apk_out = os.path.join(BUILD, 'hakimi_offline.apk')
    zin = zipfile.ZipFile(APK_IN, 'r')
    tmp = os.path.join(BUILD, '_apk')
    shutil.rmtree(tmp, ignore_errors=True)
    os.makedirs(tmp, exist_ok=True)
    entries = []
    for it in zin.infolist():
        if it.filename.upper().startswith('META-INF/'):
            continue
        data = zin.read(it.filename)
        if it.filename == 'assets/script.dat':
            data = new_dat
            log('  assets/script.dat 已替换 (%d 字节)' % len(data))
        elif it.filename == 'AndroidManifest.xml' and old_target is not None:
            data = man_out
            log('  AndroidManifest.xml 已替换 (targetSdk %s -> %s)' % (old_target, NEW_TARGET_SDK))
        elif it.filename == 'classes.dex' and os.path.exists(DEX_PATCHED):
            data = open(DEX_PATCHED, 'rb').read()
            log('  classes.dex 已替换 (%d 字节)' % len(data))
        entries.append((it.filename, data))
    zin.close()
    with zipfile.ZipFile(apk_out, 'w', zipfile.ZIP_DEFLATED) as zo:
        for name, data in entries:
            zi = zipfile.ZipInfo(name, date_time=(2026, 1, 1, 0, 0, 0))
            zi.compress_type = zipfile.ZIP_DEFLATED
            zi.external_attr = 0o644 << 16
            zo.writestr(zi, data)
    log('[5] APK 重建: %d 条 -> %s (%.1f MB)' % (len(entries), apk_out, os.path.getsize(apk_out) / 1048576))
    return apk_out


apk_out = make_apk()

# ---------- 6. v1 (JAR) 签名 ----------
openssl = r'D:\miniconda\Library\bin\openssl.exe'
OSSL_CFG = r'D:\miniconda\Library\ssl\openssl.cnf'
os.environ['OPENSSL_CONF'] = OSSL_CFG
ks = os.path.join(BUILD, 'sign')
os.makedirs(ks, exist_ok=True)
keypem = os.path.join(ks, 'key.pem')
certpem = os.path.join(ks, 'cert.pem')
if os.path.exists(keypem) and os.path.exists(certpem):
    log('[6] 复用已有签名密钥')
else:
    r = subprocess.run([openssl, 'req', '-x509', '-newkey', 'rsa:2048', '-keyout', keypem, '-out', certpem,
                        '-days', '3650', '-nodes', '-config', OSSL_CFG,
                        '-subj', '/C=CN/O=Local/CN=Local Offline'],
                       capture_output=True, text=True)
    if r.returncode != 0:
        log('  openssl 生成密钥失败: ' + (r.stderr or '')[-300:])
    else:
        log('[6] 自签名证书已生成')

if os.path.exists(keypem):
    def digest_b64(b):
        return base64.b64encode(hashlib.sha1(b).digest()).decode()

    z = zipfile.ZipFile(apk_out)
    names = [n for n in z.namelist() if not n.upper().startswith('META-INF/')]
    mf = ['Manifest-Version: 1.0', 'Created-By: LocalOffline', '']
    for n in names:
        d = digest_b64(z.read(n))
        mf.append('Name: %s' % n)
        mf.append('SHA1-Digest: %s' % d)
        mf.append('')
    mf_txt = '\r\n'.join(mf).encode()
    sf = ['Signature-Version: 1.0']
    sf.append('SHA1-Digest-Manifest: %s' % digest_b64(mf_txt))
    sf.append('Created-By: LocalOffline')
    sf.append('')
    for n in names:
        d = digest_b64(z.read(n))
        seg = ('Name: %s\r\nSHA1-Digest: %s\r\n\r\n' % (n, d)).encode()
        sf.append('Name: %s' % n)
        sf.append('SHA1-Digest: %s' % digest_b64(seg))
        sf.append('')
    sf_txt = '\r\n'.join(sf).encode()
    z.close()

    sfp = os.path.join(ks, 'LOCAL.SF')
    open(sfp, 'wb').write(sf_txt)
    rsap = os.path.join(ks, 'LOCAL.RSA')
    r2 = subprocess.run([openssl, 'smime', '-sign', '-binary', '-noattr', '-outform', 'DER',
                         '-config', OSSL_CFG,
                         '-in', sfp, '-signer', certpem, '-inkey', keypem, '-out', rsap],
                        capture_output=True, text=True)
    if r2.returncode != 0:
        log('  PKCS7 签名失败: ' + (r2.stderr or '')[-300:])
    else:
        signed = apk_out.replace('.apk', '_signed.apk')
        with zipfile.ZipFile(apk_out) as zi, zipfile.ZipFile(signed, 'w', zipfile.ZIP_DEFLATED) as zo:
            for it in zi.infolist():
                zo.writestr(it, zi.read(it.filename))
            for name, data in (('META-INF/MANIFEST.MF', mf_txt),
                               ('META-INF/LOCAL.SF', sf_txt),
                               ('META-INF/LOCAL.RSA', open(rsap, 'rb').read())):
                zo.writestr(name, data)
        shutil.move(signed, apk_out)
        log('[6] v1 签名完成 -> %s (%.1f MB)' % (apk_out, os.path.getsize(apk_out) / 1048576))

open(os.path.join(BUILD, 'build_report.txt'), 'w', encoding='utf-8').write('\n'.join(report))
log('\n=== 构建完成 ===')
log('  %s' % dat_out)
log('  %s' % apk_out)
