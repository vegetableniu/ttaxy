local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("Logic")
L0_0 = Enum
L0_0 = L0_0({
  "QUERY_ROLE",
  "DEL_ROLE",
  "ADD_ROLE",
  "BIND_ACCOUNT",
  "GET_SERVERSTART",
  "LOGIN_SUCCEED",
  "SECONDARY_PASSWORD_SUCCEED",
  "LOGIN_FAIL",
  "LOGOUT"
})
EVT = L0_0
L0_0 = {
  10064,
  10070,
  10056,
  10057,
  10058,
  10059,
  10060,
  10061,
  10062,
  10067,
  10089,
  10112,
  10152
}
class = Logic.class:subclass()
function class.initialize(A0_1)
  super.initialize(A0_1)
  A0_1.deqLoginedServerIdx = {}
  A0_1.bReLogin = false
  A0_1.bauto = true
  A0_1.password = ""
  A0_1.inviteCode = ""
  A0_1.email = ""
  A0_1.ext = ""
  A0_1.tencentLoginRet = ""
  A0_1.secureAccountSequence = 0
  A0_1.secureAccountPending = nil
  A0_1.server = Logic:Get("System"):GetMisc("Account")
  A0_1.operator = Logic:Get("System"):GetOperatorId()
  setupCrashReporter(function(A0_2)
    _UPVALUE0_:AddCrashLog(A0_2)
  end)
end
function class.SetEmail(A0_3, A1_4)
  A0_3.email = A1_4
end
function class.GetEmail(A0_5)
  local L1_6
  L1_6 = A0_5.email
  return L1_6
end
function class.SetNickName(A0_7, A1_8)
  A0_7.nickName = A1_8
end
function class.GetNickName(A0_9)
  local L1_10
  L1_10 = A0_9.nickName
  return L1_10
end
function class.SetInviteCode(A0_11, A1_12)
  A0_11.inviteCode = A1_12 or ""
end
function class.GetInviteCode(A0_13)
  return A0_13.inviteCode or ""
end
function class.SetAccName(A0_14, A1_15)
  if nil ~= A0_14.account and A0_14.account ~= A1_15 then
    A0_14:SetUserId(nil)
  end
  A0_14.account = A1_15
end
function class.GetAccName(A0_16)
  local L1_17
  L1_17 = A0_16.account
  return L1_17
end
function class.SetPassword(A0_18, A1_19)
  A0_18.password = A1_19
end
function class.GetPassword(A0_20)
  local L1_21
  L1_21 = A0_20.password
  return L1_21
end
function class.GetUserId(A0_22)
  local L1_23
  L1_23 = A0_22.userId
  return L1_23
end
function class.SetUserId(A0_24, A1_25)
  A0_24.userId = A1_25
  if nil == A1_25 or "" == A1_25 then
    A0_24.secureAccountPending = nil
    A0_24:EventTracer():Cancel("SECURE_ACCOUNT_HTTP")
    A0_24:EventTracer():Cancel("SECURE_ACCOUNT_TIMEOUT")
    A0_24.sign = nil
    A0_24.time = nil
    A0_24.ticketServerId = nil
    A0_24.ticketReceivedAt = nil
    A0_24.ticketExpiresAtLocal = nil
    A0_24.ticketVersion = nil
    Logic:Get("EnvLogic"):ClearAccountCrypto()
  end
end
function class.AcceptLoginTicket(A0_26, A1_27)
  local L2_28, L3_29, L4_30, L5_31, L6_32
  L2_28 = type
  L3_29 = A1_27
  L2_28 = L2_28(L3_29)
  if L2_28 == "table" then
    L2_28 = tonumber
    L3_29 = A1_27.ticketVersion
    L2_28 = L2_28(L3_29)
    if L2_28 == 2 then
      L2_28 = type
      L3_29 = A1_27.sign
      L2_28 = L2_28(L3_29)
      if L2_28 == "string" then
        L2_28 = A1_27.sign
      end
    end
  elseif "" == L2_28 then
    L2_28 = false
    return L2_28
  end
  L2_28 = type
  L3_29 = A1_27.userId
  L2_28 = L2_28(L3_29)
  if L2_28 == "string" then
    L2_28 = string
    L2_28 = L2_28.match
    L3_29 = A1_27.userId
    L4_30 = "^[1-9][0-9]*$"
    L2_28 = L2_28(L3_29, L4_30)
  elseif not L2_28 then
    L2_28 = false
    return L2_28
  end
  L2_28 = tonumber
  L3_29 = A1_27.serverId
  L2_28 = L2_28(L3_29)
  L3_29 = tonumber
  L4_30 = Logic
  L5_31 = L4_30
  L4_30 = L4_30.Get
  L6_32 = "Login"
  L4_30 = L4_30(L5_31, L6_32)
  L5_31 = L4_30
  L4_30 = L4_30.GetSelextServer
  L6_32 = L4_30(L5_31)
  L3_29 = L3_29(L4_30, L5_31, L6_32, L4_30(L5_31))
  L4_30 = tonumber
  L5_31 = A1_27.time
  L4_30 = L4_30(L5_31)
  L5_31 = tonumber
  L6_32 = A1_27.expiresAt
  L5_31 = L5_31(L6_32)
  if nil ~= L2_28 and L2_28 == L3_29 and nil ~= L4_30 and nil ~= L5_31 and not (L4_30 >= L5_31) then
    L6_32 = L5_31 - L4_30
  elseif L6_32 > 300 then
    L6_32 = false
    return L6_32
  end
  L6_32 = Logic
  L6_32 = L6_32.Get
  L6_32 = L6_32(L6_32, "Login")
  L6_32 = L6_32.GetLoginInfo
  L6_32 = L6_32(L6_32)
  if type(L6_32) ~= "table" or tonumber(L6_32.server) ~= L2_28 then
    return false
  end
  A0_26.userId = A1_27.userId
  A0_26.sign = A1_27.sign
  A0_26.time = L4_30
  A0_26.ticketReceivedAt = os.time()
  A0_26.ticketServerId = L2_28
  A0_26.ticketVersion = 2
  A0_26.ticketExpiresAtLocal = A0_26.ticketReceivedAt + L5_31 - L4_30 - 120
  L6_32.sign = A0_26.sign
  L6_32.time = A0_26.time
  L6_32.ticketVersion = A0_26.ticketVersion
  return true
end
function class.HasFreshTicketForServer(A0_33, A1_34)
  return tonumber(A0_33.ticketVersion) == 2 and nil ~= A0_33.sign and "" ~= A0_33.sign and nil ~= tonumber(A0_33.time) and nil ~= tonumber(A0_33.ticketReceivedAt) and tonumber(A0_33.ticketServerId) == tonumber(A1_34) and tonumber(A0_33.ticketReceivedAt) <= os.time() and nil ~= tonumber(A0_33.ticketExpiresAtLocal) and os.time() < A0_33.ticketExpiresAtLocal
end
function class.RefreshLoginTicket(A0_35, A1_36)
  A0_35.ticketRefreshCallback = A1_36
  if A0_35.bVisitor then
    A0_35:AnonymityLogin()
  else
    A0_35:Login(false)
  end
end
function class.FinishTicketRefresh(A0_37, A1_38)
  local L2_39
  L2_39 = A0_37.ticketRefreshCallback
  A0_37.ticketRefreshCallback = nil
  if nil ~= L2_39 then
    L2_39(A1_38)
    return true
  end
  return false
end
function class.SetExt(A0_40, A1_41)
  A0_40.ext = A1_41 and A1_41 or ""
end
function class.SetTencentLoginRet(A0_42, A1_43)
  A0_42.tencentLoginRet = A1_43
end
function class.GetTencentLoginRet(A0_44)
  local L1_45
  L1_45 = A0_44.tencentLoginRet
  return L1_45
end
function class.HttpRequest(A0_46, A1_47)
  ITwHttp.Request().strHost = A0_46.server.host
  ITwHttp.Request().strMethod = "POST"
  ITwHttp.Request().strAction = A1_47
  ITwHttp.Request().usPort = _UPVALUE0_(A0_46.server)
  return (ITwHttp.Request())
end
function class.SecureAccountRequest(A0_48, A1_49, A2_50, A3_51)
  if nil ~= A0_48.secureAccountPending then
    Prompt:Fail("\232\180\166\229\143\183\232\175\183\230\177\130\230\173\163\229\156\168\229\164\132\231\144\134\228\184\173\239\188\140\232\175\183\231\168\141\229\128\153\227\128\130")
    return false
  end
  if nil == tonumber(Logic:Get("Login"):GetSelextServer()) or tonumber(Logic:Get("Login"):GetSelextServer()) <= 0 or type(A1_49) ~= "string" or type(A2_50) ~= "table" or type(A3_51) ~= "string" then
    return false
  end
  A0_48.secureAccountSequence = (tonumber(A0_48.secureAccountSequence) or 0) + 1
  A0_48.secureAccountPending = {
    token = "account-" .. tostring(A0_48.secureAccountSequence),
    phase = "seal",
    handler = A3_51
  }
  Logic:Get("EnvLogic"):AccountCrypto({
    action = "seal",
    token = "account-" .. tostring(A0_48.secureAccountSequence),
    op = A1_49,
    clientVersion = _UPVALUE0_,
    zoneId = tonumber(Logic:Get("Login"):GetSelextServer()),
    payload = A2_50
  })
  Singleton(Timer):After(_UPVALUE1_, A0_48:Event("SECURE_ACCOUNT_TIMEOUT", function()
    local L0_52
    L0_52 = _UPVALUE0_
    L0_52 = L0_52.secureAccountPending
    if nil ~= L0_52 and L0_52.token == _UPVALUE1_ then
      _UPVALUE0_:FailSecureAccount(true)
    end
  end))
  return true
end
function class.FailSecureAccount(A0_53, A1_54)
  local L2_55, L3_56
  L2_55 = A0_53.secureAccountPending
  if nil == L2_55 then
    return
  end
  A0_53.secureAccountPending = nil
  L3_56 = A0_53.EventTracer
  L3_56 = L3_56(A0_53)
  L3_56 = L3_56.Cancel
  L3_56(L3_56, "SECURE_ACCOUNT_HTTP")
  L3_56 = A0_53.EventTracer
  L3_56 = L3_56(A0_53)
  L3_56 = L3_56.Cancel
  L3_56(L3_56, "SECURE_ACCOUNT_TIMEOUT")
  if A1_54 then
    L3_56 = Logic
    L3_56 = L3_56.Get
    L3_56 = L3_56(L3_56, "EnvLogic")
    L3_56 = L3_56.DiscardAccountCrypto
    L3_56(L3_56, L2_55.token)
  end
  L3_56 = L2_55.handler
  L3_56 = A0_53[L3_56]
  if nil ~= L3_56 then
    L3_56(A0_53, -1, nil)
  end
end
function class.OnAccountCrypto(A0_57, A1_58)
  local L2_59, L3_60, L4_61, L5_62
  L2_59 = A0_57.secureAccountPending
  L3_60 = type
  L4_61 = A1_58
  L3_60 = L3_60(L4_61)
  if L3_60 == "table" and nil ~= L2_59 then
    L3_60 = A1_58.token
    L4_61 = L2_59.token
  elseif L3_60 ~= L4_61 then
    return
  end
  L3_60 = tonumber
  L4_61 = A1_58.transportCode
  L3_60 = L3_60(L4_61)
  if L3_60 == 0 then
    L3_60 = type
    L4_61 = A1_58.data
    L3_60 = L3_60(L4_61)
    if L3_60 == "string" then
      L3_60 = A1_58.data
    end
  elseif "" == L3_60 then
    L4_61 = A0_57
    L3_60 = A0_57.FailSecureAccount
    L5_62 = false
    L3_60(L4_61, L5_62)
    return
  end
  L3_60 = L2_59.phase
  if L3_60 == "seal" then
    L3_60 = nil
    L4_61 = pcall
    function L5_62()
      _UPVALUE0_ = json.decode(_UPVALUE1_.data)
    end
    L4_61 = L4_61(L5_62)
    if L4_61 then
      L5_62 = type
      L5_62 = L5_62(L3_60)
      if L5_62 == "table" then
        L5_62 = type
        L5_62 = L5_62(L3_60.envelope)
        if L5_62 == "string" then
          L5_62 = L3_60.envelope
        end
      end
    elseif "" == L5_62 then
      L5_62 = A0_57.FailSecureAccount
      L5_62(A0_57, true)
      return
    end
    L2_59.phase = "http"
    L5_62 = A0_57.HttpRequest
    L5_62 = L5_62(A0_57, A0_57.server.act .. "/v2/secure.php?e=" .. L3_60.envelope)
    L5_62.ucRetry = 0
    A0_57:EventTracer():Cancel("SECURE_ACCOUNT_HTTP")
    Singleton(NetHttp):On(L5_62.uReqId, A0_57:Event("SECURE_ACCOUNT_HTTP", "OnSecureAccountHttp"))
    Singleton(NetHttp):Send(L5_62)
    return
  end
  L3_60 = L2_59.phase
  if L3_60 ~= "open" then
    L4_61 = A0_57
    L3_60 = A0_57.FailSecureAccount
    L5_62 = true
    L3_60(L4_61, L5_62)
    return
  end
  A0_57.secureAccountPending = nil
  L4_61 = A0_57
  L3_60 = A0_57.EventTracer
  L3_60 = L3_60(L4_61)
  L4_61 = L3_60
  L3_60 = L3_60.Cancel
  L5_62 = "SECURE_ACCOUNT_HTTP"
  L3_60(L4_61, L5_62)
  L4_61 = A0_57
  L3_60 = A0_57.EventTracer
  L3_60 = L3_60(L4_61)
  L4_61 = L3_60
  L3_60 = L3_60.Cancel
  L5_62 = "SECURE_ACCOUNT_TIMEOUT"
  L3_60(L4_61, L5_62)
  L3_60 = L2_59.handler
  L3_60 = A0_57[L3_60]
  if nil ~= L3_60 then
    L4_61 = L3_60
    L5_62 = A0_57
    L4_61(L5_62, 0, A1_58.data)
  end
end
function class.OnSecureAccountHttp(A0_63, A1_64, A2_65)
  A0_63:EventTracer():Cancel("SECURE_ACCOUNT_HTTP")
  if nil == A0_63.secureAccountPending or A0_63.secureAccountPending.phase ~= "http" then
    return
  end
  if A1_64 ~= 0 or type(A2_65) ~= "string" or "" == A2_65 then
    A0_63:FailSecureAccount(true)
    return
  end
  A0_63.secureAccountPending.phase = "open"
  Logic:Get("EnvLogic"):AccountCrypto({
    action = "open",
    token = A0_63.secureAccountPending.token,
    response = A2_65
  })
end
function class.AppendClientParams(A0_66, A1_67, A2_68)
  local L3_69
  L3_69 = A1_67
  A1_67 = L3_69 .. "&clientVersion=" .. _UPVALUE0_
  L3_69 = Logic
  L3_69 = L3_69.Get
  L3_69 = L3_69(L3_69, "Login")
  L3_69 = L3_69.GetSelextServer
  L3_69 = L3_69(L3_69)
  if nil ~= L3_69 then
    A1_67 = A1_67 .. "&serverId=" .. tostring(L3_69)
  end
  if A2_68 then
    A1_67 = A1_67 .. "&inviteCode=" .. (A0_66:GetInviteCode() or "")
  end
  return A1_67
end
function class.OnError(A0_70, A1_71, A2_72, A3_73)
  local L4_74, L5_75, L6_76, L7_77, L8_78
  if nil == A3_73 then
    A3_73 = true
  end
  if A1_71 ~= 0 or nil == A2_72 or "" == A2_72 then
    if A3_73 then
      L4_74 = Prompt
      L5_75 = L4_74
      L4_74 = L4_74.Fail
      L6_76 = 10063
      L4_74(L5_75, L6_76)
    end
    L4_74 = true
    return L4_74
  end
  if "" == A2_72 then
    L4_74 = true
    return L4_74
  end
  L4_74 = nil
  L5_75 = pcall
  function L6_76()
    _UPVALUE0_ = json.decode(_UPVALUE1_)
  end
  L6_76 = L5_75(L6_76)
  if not L5_75 then
    if A3_73 then
      L7_77 = Prompt
      L8_78 = L7_77
      L7_77 = L7_77.Fail
      L7_77(L8_78, 10111)
    end
    L7_77 = true
    return L7_77
  end
  if nil == L4_74 then
    if A3_73 then
      L7_77 = Prompt
      L8_78 = L7_77
      L7_77 = L7_77.Fail
      L7_77(L8_78, 10111)
    end
    L7_77 = true
    return L7_77
  end
  L7_77 = L4_74.code
  if 0 ~= L7_77 then
    L7_77 = L4_74.message
    if not L7_77 then
      L7_77 = _UPVALUE0_
      L8_78 = L4_74.error
      L7_77 = L7_77[L8_78]
    end
    if A3_73 and L7_77 and L7_77 ~= "" then
      L8_78 = Prompt
      L8_78 = L8_78.Fail
      L8_78(L8_78, L7_77)
      L8_78 = true
      return L8_78
    end
    L8_78 = L4_74.code
    if nil ~= L8_78 then
      L8_78 = L4_74.code
      if not (L8_78 > #_UPVALUE1_) then
        L8_78 = L4_74.code
      end
    elseif L8_78 <= 0 then
      if A3_73 then
        L8_78 = Prompt
        L8_78 = L8_78.Fail
        L8_78(L8_78, 10111)
      end
      L8_78 = true
      return L8_78
    end
    if A3_73 then
      L8_78 = _UPVALUE1_
      L8_78 = L8_78[L4_74.code]
      if nil == L8_78 then
        return true
      end
      Prompt:Fail(L8_78)
    end
    L8_78 = true
    return L8_78
  end
  L7_77 = false
  L8_78 = L4_74
  return L7_77, L8_78
end
function class.MakeSign(A0_79, A1_80)
  local L2_81
  A1_80 = A1_80 or ""
  L2_81 = Logic
  L2_81 = L2_81.Get
  L2_81 = L2_81(L2_81, "System")
  L2_81 = L2_81.GetSaltFilePath
  L2_81 = L2_81(L2_81)
  return CTwUtil:GetSingleton():MakeSaltKey(A1_80, _UPVALUE0_, L2_81).strKey, CTwUtil:GetSingleton():MakeSaltKey(A1_80, _UPVALUE0_, L2_81).dwTime
end
function class.MakeRoleId(A0_82, A1_83, A2_84)
  local L3_85
  if nil == A1_83 then
    L3_85 = ""
    return L3_85
  end
  return A1_83
end
function class.GetDeviceId64(A0_86)
  local L1_87
  L1_87 = CVariableSystem
  L1_87 = L1_87.GetSingleton
  L1_87 = L1_87(L1_87)
  L1_87 = L1_87.GetSysVariable
  L1_87 = L1_87(L1_87, GV_DEVICE_NAME)
  L1_87 = L1_87 or ""
  L1_87 = base64.encode(L1_87)
  L1_87 = string.gsub(L1_87, ".", {
    ["+"] = "_",
    ["/"] = "-"
  })
  return L1_87
end
function class.RememberLoginAccount(A0_88)
  local L1_89
  L1_89 = A0_88.account
  if nil ~= L1_89 then
    L1_89 = A0_88.account
  elseif "" == L1_89 then
    return
  end
  L1_89 = {}
  L1_89.bb = A0_88.account
  L1_89.cc = A0_88.password
  L1_89.dd = A0_88.bVisitor
  L1_89.aa = Logic:Get("Login"):GetSelextServer()
  L1_89.nickName = A0_88.nickName
  Logic:Get("Login"):RecordServerInfo(L1_89)
end
function class.LoginFinish(A0_90, A1_91)
  if nil == A1_91 then
    return
  end
  Logic:Get("Login"):GetLoginInfo().account = A1_91
  Logic:Get("Login"):GetLoginInfo().sign = A0_90.sign
  Logic:Get("Login"):GetLoginInfo().time = A0_90.time
  Logic:Get("Login"):GetLoginInfo().ticketVersion = A0_90.ticketVersion
  Logic:Get("Login"):GetLoginInfo().originUserId = A0_90.account
  if A0_90.bVisitor then
    Logic:Get("System"):SetSysVariableMisc("AnonymityAcc", A0_90.account)
    Logic:Get("System"):SetSysVariableMisc("AnonymityPwd", A0_90.password)
  end
  A0_90:RememberLoginAccount()
  Logic:Get("Login"):Login()
end
function class.inquireServerInfo(A0_92)
  local L1_93, L2_94
  L1_93 = Logic
  L2_94 = L1_93
  L1_93 = L1_93.Get
  L1_93 = L1_93(L2_94, "System")
  L2_94 = L1_93
  L1_93 = L1_93.GetMisc
  L1_93 = L1_93(L2_94, "inquire")
  if nil ~= L1_93 then
    L2_94 = L1_93.host
  elseif nil == L2_94 then
    return
  end
  L2_94 = A0_92.EventTracer
  L2_94 = L2_94(A0_92)
  L2_94 = L2_94.Exist
  L2_94 = L2_94(L2_94, "INQUIRE_SERVER")
  if L2_94 then
    return
  end
  L2_94 = ITwHttp
  L2_94 = L2_94.Request
  L2_94 = L2_94()
  L2_94.strHost = L1_93.host
  L2_94.usPort = _UPVALUE0_(L1_93)
  L2_94.strMethod = "POST"
  L2_94.strAction = L1_93.check .. "?operatorId=" .. Logic:Get("System"):GetOperatorId()
  L2_94.ucRetry = 0
  Singleton(NetHttp):On(L2_94.uReqId, A0_92:Event("INQUIRE_SERVER", "OnInquireServer"))
  Singleton(NetHttp):Send(L2_94, false)
end
function class.OnInquireServer(A0_95, A1_96, A2_97)
  A0_95:EventTracer():Cancel("INQUIRE_SERVER")
  if A0_95:OnError(A1_96, A2_97, false) then
    return
  end
  if nil == A0_95:OnError(A1_96, A2_97, false) then
    return
  end
  A0_95.serverfps = A0_95:OnError(A1_96, A2_97, false).data
  A0_95:FireEvent(EVT.GET_SERVERSTART)
end
function class.GetServerFPSById(A0_98, A1_99)
  local L2_100
  L2_100 = A0_98.serverfps
  if nil == L2_100 then
    return
  end
  if nil == A1_99 then
    return
  end
  L2_100 = A0_98.serverfps
  L2_100 = L2_100[tostring(A1_99)]
  return L2_100
end
function class.CheckUser(A0_101, A1_102)
  if A1_102 then
    A0_101:AnonymityLogin()
    return
  end
  A0_101:SecureAccountRequest("check", {
    username = A0_101.account or ""
  }, "OnCheckUser")
end
function class.OnCheckUser(A0_103, A1_104, A2_105)
  A0_103:EventTracer():Cancel("CHECK")
  if A1_104 ~= 0 or nil == A2_105 then
    Prompt:Confirm(A0_103, 0, 10063, A0_103.loginErr)
    return true
  end
  if not pcall(function()
    _UPVALUE0_ = json.decode(_UPVALUE1_)
  end) then
    Prompt:Confirm(A0_103, 0, 10111, A0_103.loginErr)
    return
  end
  if nil == nil then
    return
  end
  if nil ~= (nil).code then
    if _UPVALUE0_ == (nil).code then
      A0_103:Login()
      return
    elseif _UPVALUE1_ == (nil).code then
      A0_103:Regist()
      return
    end
  end
  if A0_103:OnError(A1_104, A2_105) then
    return
  end
end
function class.Regist(A0_106)
  A0_106:SecureAccountRequest("register", {
    username = A0_106.account or "",
    password = A0_106.password or "",
    inviteCode = A0_106:GetInviteCode() or ""
  }, "OnRegist")
end
function class.OnRegist(A0_107, A1_108, A2_109)
  local L3_110, L4_111
  L4_111 = A0_107
  L3_110 = A0_107.EventTracer
  L3_110 = L3_110(L4_111)
  L4_111 = L3_110
  L3_110 = L3_110.Cancel
  L3_110(L4_111, "REGIST")
  L4_111 = A0_107
  L3_110 = A0_107.OnError
  L4_111 = L3_110(L4_111, A1_108, A2_109)
  if L3_110 then
    A0_107:loginErr()
    return
  end
  if nil == L4_111 then
    A0_107:loginErr()
    return
  end
  if not A0_107:AcceptLoginTicket(L4_111) then
    Prompt:Fail("\231\153\187\229\189\149\229\135\173\232\175\129\230\151\160\230\149\136\239\188\140\232\175\183\233\135\141\230\150\176\231\153\187\229\189\149\227\128\130")
    A0_107:loginErr()
    return
  end
  A0_107.bVisitor = false
  A0_107.needAutoEnterGame = false
  A0_107:FireEvent(EVT.LOGIN_SUCCEED)
end
function class.BindAccount(A0_112, A1_113)
  if nil == A1_113 or A1_113 == "" then
    return
  end
  Prompt:Fail("\229\189\147\229\137\141\231\137\136\230\156\172\230\156\170\229\188\128\230\148\190\230\184\184\229\174\162\232\180\166\229\143\183\231\187\145\229\174\154\227\128\130")
end
function class.OnBindAccount(A0_114, A1_115, A2_116)
  local L3_117, L4_118, L5_119, L6_120
  L4_118 = A0_114
  L3_117 = A0_114.EventTracer
  L3_117 = L3_117(L4_118)
  L4_118 = L3_117
  L3_117 = L3_117.Cancel
  L5_119 = "BIND_ACCOUNT"
  L3_117(L4_118, L5_119)
  L4_118 = A0_114
  L3_117 = A0_114.OnError
  L5_119 = A1_115
  L6_120 = A2_116
  L4_118 = L3_117(L4_118, L5_119, L6_120)
  if L3_117 then
    return
  end
  if nil == L4_118 then
    return
  end
  A0_114.bVisitor = false
  L5_119 = Logic
  L6_120 = L5_119
  L5_119 = L5_119.Get
  L5_119 = L5_119(L6_120, "Login")
  L6_120 = L5_119
  L5_119 = L5_119.GetLoginInfo
  L5_119 = L5_119(L6_120)
  if nil ~= L5_119 then
    L6_120 = L5_119.server
    if nil ~= L6_120 then
      L6_120 = A0_114.account
      if nil ~= L6_120 then
        L6_120 = A0_114.password
        if nil ~= L6_120 then
          L6_120 = {}
          L6_120.aa = L5_119.server
          L6_120.bb = A0_114.account
          L6_120.cc = A0_114.password
          L6_120.dd = A0_114.bVisitor
          L6_120.nickName = A0_114.nickName or ""
          Logic:Get("Login"):RecordServerInfo(L6_120)
        end
      end
    end
  end
  L6_120 = Logic
  L6_120 = L6_120.Get
  L6_120 = L6_120(L6_120, "System")
  L6_120 = L6_120.SetSysVariableMisc
  L6_120(L6_120, "AnonymityAcc", "")
  L6_120 = Logic
  L6_120 = L6_120.Get
  L6_120 = L6_120(L6_120, "System")
  L6_120 = L6_120.SetSysVariableMisc
  L6_120(L6_120, "AnonymityPwd", "")
  L6_120 = A0_114.FireEvent
  L6_120(A0_114, EVT.BIND_ACCOUNT, L4_118.data)
end
function class.AnonymityLogin(A0_121)
  Prompt:Fail("\229\189\147\229\137\141\231\137\136\230\156\172\230\156\170\229\188\128\230\148\190\230\184\184\229\174\162\231\153\187\229\189\149\227\128\130")
  Logic:Get("Login"):OnRecoveryHttpFailed()
  A0_121:FinishTicketRefresh(false)
end
function class.OnAnonymityLogin(A0_122, A1_123, A2_124)
  local L3_125, L4_126
  L4_126 = A0_122
  L3_125 = A0_122.EventTracer
  L3_125 = L3_125(L4_126)
  L4_126 = L3_125
  L3_125 = L3_125.Cancel
  L3_125(L4_126, "ANONYMITY")
  L4_126 = A0_122
  L3_125 = A0_122.OnError
  L4_126 = L3_125(L4_126, A1_123, A2_124)
  if L3_125 then
    Logic:Get("Login"):OnRecoveryHttpFailed()
    A0_122:FinishTicketRefresh(false)
    return
  end
  if nil == L4_126 then
    Logic:Get("Login"):OnRecoveryHttpFailed()
    A0_122:FinishTicketRefresh(false)
    return
  end
  if not A0_122:AcceptLoginTicket(L4_126) then
    A0_122:FinishTicketRefresh(false)
    return
  end
  A0_122.bVisitor = true
  if A0_122:FinishTicketRefresh(true) then
    A0_122:FireEvent(EVT.LOGIN_SUCCEED)
    return
  end
  A0_122:QueryRole()
  A0_122:FireEvent(EVT.LOGIN_SUCCEED)
end
function class.SuperLogin(A0_127, A1_128)
  if nil == A1_128 then
    return
  end
  Logic:Get("Login"):GetLoginInfo().account = A1_128.account
  Logic:Get("Login"):GetLoginInfo().sign = A1_128.key
  Logic:Get("Login"):GetLoginInfo().time = A1_128.timestamp
  Logic:Get("Login"):GetLoginInfo().originUserId = A1_128.origin
  Logic:Get("Login"):GetLoginInfo().server = A1_128.server
  Logic:Get("Login"):GetLoginInfo().addr = A1_128.ip
  Logic:Get("Login"):GetLoginInfo().port = A1_128.port
  Logic:Get("Login"):GetLoginInfo().name = A1_128.name
  Logic:Get("Login"):GetLoginInfo().operator = tonumber(A1_128.operator)
  Singleton(NetMgr):SetUrlAndPort(Logic:Get("Login"):GetLoginInfo().addr, Logic:Get("Login"):GetLoginInfo().port)
  Logic:Get("Login"):OnDescription(0)
end
function class.Login(A0_129, A1_130)
  A0_129.showError = A1_130
  return A0_129:SecureAccountRequest("login", {
    username = A0_129.account or "",
    password = A0_129.password or ""
  }, "OnLogin")
end
function class.OnLogin(A0_131, A1_132, A2_133)
  local L3_134, L4_135, L5_136
  L4_135 = A0_131
  L3_134 = A0_131.EventTracer
  L3_134 = L3_134(L4_135)
  L4_135 = L3_134
  L3_134 = L3_134.Cancel
  L5_136 = "LOGIN"
  L3_134(L4_135, L5_136)
  L3_134 = A0_131.ticketRefreshCallback
  L3_134 = nil == L3_134
  L5_136 = A0_131
  L4_135 = A0_131.OnError
  L5_136 = L4_135(L5_136, A1_132, A2_133, L3_134)
  if L4_135 then
    Logic:Get("Login"):OnRecoveryHttpFailed()
    A0_131:loginErr()
    A0_131:FinishTicketRefresh(false)
    return
  end
  if nil == L5_136 then
    Logic:Get("Login"):OnRecoveryHttpFailed()
    A0_131:loginErr()
    A0_131:FinishTicketRefresh(false)
    return
  end
  if not A0_131:AcceptLoginTicket(L5_136) then
    Prompt:Fail("\231\153\187\229\189\149\229\135\173\232\175\129\230\151\160\230\149\136\239\188\140\232\175\183\233\135\141\230\150\176\231\153\187\229\189\149\227\128\130")
    A0_131:loginErr()
    A0_131:FinishTicketRefresh(false)
    return
  end
  A0_131.bVisitor = false
  A0_131:RememberLoginAccount()
  if A0_131:FinishTicketRefresh(true) then
    A0_131:FireEvent(EVT.LOGIN_SUCCEED)
    return
  end
  if A0_131.needAutoEnterGame then
    A0_131.needAutoEnterGame = false
    Logic:Get("Account"):QueryRole()
  end
  A0_131:FireEvent(EVT.LOGIN_SUCCEED)
end
function class.GetIsVisitorType(A0_137)
  local L1_138
  L1_138 = A0_137.bVisitor
  return L1_138
end
function class.SetAutoLogin(A0_139, A1_140)
  A0_139.bauto = A1_140
end
function class.GetAutoLogin(A0_141)
  local L1_142
  L1_142 = A0_141.bauto
  return L1_142
end
function class.YesLogin(A0_143)
  A0_143:SecureAccountRequest("yeslogin", {
    username = A0_143.account or "",
    password = A0_143.password or ""
  }, "OnYesLogin")
end
function class.OnYesLogin(A0_144, A1_145, A2_146)
  local L3_147, L4_148
  L4_148 = A0_144
  L3_147 = A0_144.EventTracer
  L3_147 = L3_147(L4_148)
  L4_148 = L3_147
  L3_147 = L3_147.Cancel
  L3_147(L4_148, "YES_LOGIN")
  L4_148 = A0_144
  L3_147 = A0_144.OnError
  L4_148 = L3_147(L4_148, A1_145, A2_146)
  if L3_147 then
    A0_144:loginErr()
    return
  end
  if nil == L4_148 then
    A0_144:loginErr()
    return
  end
  if not A0_144:AcceptLoginTicket(L4_148) then
    Prompt:Fail("\231\153\187\229\189\149\229\135\173\232\175\129\230\151\160\230\149\136\239\188\140\232\175\183\233\135\141\230\150\176\231\153\187\229\189\149\227\128\130")
    A0_144:loginErr()
    return
  end
  A0_144.bVisitor = false
  A0_144:QueryRole()
end
function class.ChangePassword(A0_149, A1_150, A2_151, A3_152)
  if nil == A2_151 or nil == A1_150 or nil == A3_152 then
    return
  end
  A0_149:SecureAccountRequest("change_password", {
    username = A1_150,
    oldPassword = A3_152,
    newPassword = A2_151
  }, "OnChangePassword")
end
function class.BindSecondaryPassword(A0_153, A1_154, A2_155, A3_156)
  if nil == A1_154 or nil == A2_155 or nil == A3_156 then
    return
  end
  A0_153:SecureAccountRequest("bind_secondary", {
    username = A1_154,
    password = A2_155,
    secondaryPassword = A3_156
  }, "OnBindSecondaryPassword")
end
function class.SetSecondaryFlow(A0_157, A1_158, A2_159)
  A0_157.secondaryMode = A1_158
  A0_157.secondaryAccount = A2_159 or ""
end
function class.GetSecondaryFlow(A0_160)
  local L1_161
  L1_161 = A0_160.secondaryMode
  return L1_161, A0_160.secondaryAccount or ""
end
function class.ConfigureSecondaryView(A0_162, A1_163)
  local L2_164
  L2_164 = A0_162.secondaryMode
  L2_164 = L2_164 == "bind"
  A1_163.admin:setString("\232\180\166\229\143\183")
  A1_163.passward:setString(L2_164 and "\231\153\187\229\189\149\229\175\134\231\160\129" or "\228\186\140\231\186\167\229\175\134\231\160\129")
  A1_163.staComPass:setString(L2_164 and "\228\186\140\231\186\167\229\175\134\231\160\129" or "\230\150\176\231\153\187\229\189\149\229\175\134\231\160\129")
  A1_163.staRegist:setString(L2_164 and "\231\187\145\229\174\154" or "\228\191\174\230\148\185\229\175\134\231\160\129")
  A1_163.staReturn:setString("\232\191\148\229\155\158")
  A1_163.staPrompt:setString(L2_164 and "\233\170\140\232\175\129\232\180\166\229\143\183\229\146\140\231\153\187\229\189\149\229\175\134\231\160\129\229\144\142\239\188\140\231\187\145\229\174\1546\228\189\141\230\149\176\229\173\151\228\186\140\231\186\167\229\175\134\231\160\129" or "\228\189\191\231\148\168\232\180\166\229\143\183\229\146\1406\228\189\141\230\149\176\229\173\151\228\186\140\231\186\167\229\175\134\231\160\129\228\191\174\230\148\185\231\153\187\229\189\149\229\175\134\231\160\129")
  A1_163.edtPassword:setPasswordMode(true)
  A1_163.edtCheckPass:setPasswordMode(true)
  A1_163.edtAccount:setFontSize(30)
  A1_163.edtPassword:setFontSize(30)
  A1_163.edtCheckPass:setFontSize(30)
  A1_163.edtAccount:setMaxLens(20)
  A1_163.edtPassword:setMaxLens(20)
  A1_163.edtCheckPass:setMaxLens(20)
  A1_163.edtAccount:setString(A0_162.secondaryAccount or "")
  A1_163.edtPassword:setString("")
  A1_163.edtCheckPass:setString("")
end
function class.FinishSecondaryFlow(A0_165, A1_166)
  A0_165.secondaryMode = nil
  A0_165.secondaryAccount = nil
  A0_165.secondaryReturnAccount = A1_166 or ""
end
function class.TakeSecondaryReturnAccount(A0_167)
  local L1_168
  L1_168 = A0_167.secondaryReturnAccount
  A0_167.secondaryReturnAccount = nil
  return L1_168
end
function class.SubmitSecondary(A0_169, A1_170, A2_171, A3_172, A4_173)
  if getStrShowWidth(A2_171) < 6 or getStrShowWidth(A2_171) > 20 or string.find(A2_171, "[^%w]") or getCodePointAmount(A2_171) ~= string.len(A2_171) then
    Prompt:Fail(10102)
    return
  end
  if A1_170 == "bind" then
    if getStrShowWidth(A3_172) < 6 or getStrShowWidth(A3_172) > 20 or string.find(A3_172, "[^%w]") then
      Prompt:Fail(10069)
    elseif not string.match(A4_173, "^%d%d%d%d%d%d$") then
      Prompt:Fail("\228\186\140\231\186\167\229\175\134\231\160\129\229\191\133\233\161\187\230\152\1756\228\189\141\230\149\176\229\173\151\227\128\130")
    else
      A0_169:BindSecondaryPassword(A2_171, CMd5(A3_172):GetResult(), A4_173)
    end
  elseif not string.match(A3_172, "^%d%d%d%d%d%d$") then
    Prompt:Fail("\228\186\140\231\186\167\229\175\134\231\160\129\229\191\133\233\161\187\230\152\1756\228\189\141\230\149\176\229\173\151\227\128\130")
  elseif getStrShowWidth(A4_173) < 6 or getStrShowWidth(A4_173) > 20 or string.find(A4_173, "[^%w]") then
    Prompt:Fail(10069)
  else
    A0_169:ResetPasswordWithSecondary(A2_171, A3_172, CMd5(A4_173):GetResult())
  end
end
function class.OnBindSecondaryPassword(A0_174, A1_175, A2_176)
  A0_174:EventTracer():Cancel("BIND_SECONDARY_PASSWORD")
  if A0_174:OnError(A1_175, A2_176) then
    return
  end
  A0_174:FireEvent(EVT.SECONDARY_PASSWORD_SUCCEED, "bind", A0_174:OnError(A1_175, A2_176) and A0_174:OnError(A1_175, A2_176).message or "\228\186\140\231\186\167\229\175\134\231\160\129\231\187\145\229\174\154\230\136\144\229\138\159\227\128\130")
end
function class.ResetPasswordWithSecondary(A0_177, A1_178, A2_179, A3_180)
  if nil == A1_178 or nil == A2_179 or nil == A3_180 then
    return
  end
  A0_177.pendingSecondaryResetAccount = A1_178
  A0_177:SecureAccountRequest("reset_secondary", {
    username = A1_178,
    secondaryPassword = A2_179,
    newPassword = A3_180
  }, "OnResetPasswordWithSecondary")
end
function class.OnResetPasswordWithSecondary(A0_181, A1_182, A2_183)
  A0_181:EventTracer():Cancel("RESET_PASSWORD_SECONDARY")
  if A0_181:OnError(A1_182, A2_183) then
    return
  end
  A0_181:SetAutoLogin(false)
  A0_181:SetPassword("")
  Logic:Get("Login"):ForgetAccountPassword(A0_181.pendingSecondaryResetAccount or "")
  A0_181.pendingSecondaryResetAccount = nil
  A0_181:FireEvent(EVT.SECONDARY_PASSWORD_SUCCEED, "reset", A0_181:OnError(A1_182, A2_183) and A0_181:OnError(A1_182, A2_183).message or "\231\153\187\229\189\149\229\175\134\231\160\129\228\191\174\230\148\185\230\136\144\229\138\159\227\128\130")
end
function class.OnChangePassword(A0_184, A1_185, A2_186)
  A0_184:EventTracer():Cancel("CHANGE_PASSWORD")
  if A0_184:OnError(A1_185, A2_186) then
    return
  end
end
function class.QueryRole(A0_187)
  local L1_188, L2_189
  L1_188 = _UPVALUE0_
  if L1_188 then
    L2_189 = A0_187
    L1_188 = A0_187.LoginFinish
    return L1_188(L2_189, A0_187.userId)
  end
  L1_188 = A0_187.server
  L1_188 = L1_188.act
  L2_189 = string
  L2_189 = L2_189.format
  L2_189 = L2_189(A0_187.server.rolequery, A0_187.operator, A0_187.userId, A0_187.server.gameId)
  L1_188 = L1_188 .. L2_189
  L2_189 = A0_187.HttpRequest
  L2_189 = L2_189(A0_187, L1_188)
  Singleton(NetHttp):On(L2_189.uReqId, A0_187:Event("QUERY_ROLE", "OnQueryRole"))
  Singleton(NetHttp):Send(L2_189)
end
function class.OnQueryRole(A0_190, A1_191, A2_192)
  local L3_193, L4_194, L5_195
  L4_194 = A0_190
  L3_193 = A0_190.EventTracer
  L3_193 = L3_193(L4_194)
  L4_194 = L3_193
  L3_193 = L3_193.Cancel
  L5_195 = "QUERY_ROLE"
  L3_193(L4_194, L5_195)
  L4_194 = A0_190
  L3_193 = A0_190.OnError
  L5_195 = A1_191
  L4_194 = L3_193(L4_194, L5_195, A2_192)
  if L3_193 then
    L5_195 = Logic
    L5_195 = L5_195.Get
    L5_195 = L5_195(L5_195, "Login")
    L5_195 = L5_195.OnRecoveryHttpFailed
    L5_195(L5_195)
    return
  end
  if nil ~= L4_194 then
    L5_195 = L4_194.data
  elseif nil == L5_195 then
    L5_195 = Logic
    L5_195 = L5_195.Get
    L5_195 = L5_195(L5_195, "Login")
    L5_195 = L5_195.OnRecoveryHttpFailed
    L5_195(L5_195)
    return
  end
  L5_195 = nil
  if "" == L4_194.data or nil == L4_194.data[1] or nil == L4_194.data[1].roleId then
    L5_195 = Logic:Get("Account"):MakeRoleId(Logic:Get("Account"):GetUserId())
  else
    L5_195 = L4_194.data[1].roleId
  end
  Logic:Get("Account"):LoginFinish(L5_195)
end
function class.DelRole(A0_196, A1_197, A2_198)
  local L3_199, L4_200
  L3_199 = A0_196.server
  L3_199 = L3_199.act
  L4_200 = string
  L4_200 = L4_200.format
  L4_200 = L4_200(A0_196.server.roledel, A0_196.operator, A0_196.userId, A1_197, A0_196.server.gameId, A2_198)
  L3_199 = L3_199 .. L4_200
  L4_200 = A0_196.HttpRequest
  L4_200 = L4_200(A0_196, L3_199)
  Singleton(NetHttp):On(L4_200.uReqId, A0_196:Event("DEL_ROLE", "OnDelRole"))
  Singleton(NetHttp):Send(L4_200)
end
function class.OnDelRole(A0_201, A1_202, A2_203)
  A0_201:EventTracer():Cancel("DEL_ROLE")
  if A0_201:OnError(A1_202, A2_203) then
    return
  end
  A0_201:FireEvent(EVT.DEL_ROLE)
end
function class.AddRole(A0_204, A1_205, A2_206, A3_207, A4_208)
  local L5_209, L6_210
  L5_209 = _UPVALUE0_
  if L5_209 then
    return
  end
  L5_209 = A0_204.server
  L5_209 = L5_209.act
  L6_210 = string
  L6_210 = L6_210.format
  L6_210 = L6_210(A0_204.server.rolelog, A0_204.operator, A0_204.userId, A1_205, A0_204.server.gameId, A2_206, A3_207, A4_208)
  L5_209 = L5_209 .. L6_210
  L6_210 = A0_204.HttpRequest
  L6_210 = L6_210(A0_204, L5_209)
  Singleton(NetHttp):On(L6_210.uReqId, A0_204:Event("ADD_ROLE", "OnAddRole"))
  Singleton(NetHttp):Send(L6_210)
end
function class.OnAddRole(A0_211, A1_212, A2_213)
  A0_211:EventTracer():Cancel("ADD_ROLE")
  if A0_211:OnError(A1_212, A2_213) then
    return
  end
  A0_211:FireEvent(EVT.ADD_ROLE)
end
function class.AddCrashLog(A0_214, A1_215)
  local L2_216, L3_217, L4_218, L5_219, L6_220, L7_221
  L2_216 = Logic
  L3_217 = L2_216
  L2_216 = L2_216.Get
  L4_218 = "PlayerInfo"
  L2_216 = L2_216(L3_217, L4_218)
  L3_217 = L2_216
  L2_216 = L2_216.GetPlayerAllInfo
  L2_216 = L2_216(L3_217)
  if nil ~= L2_216 then
    L3_217 = L2_216.name
    if nil ~= L3_217 then
      L3_217 = L2_216.name
    end
  else
    L3_217 = L3_217 or "00000000"
  end
  L4_218 = A0_214.account
  if nil ~= L4_218 then
    L4_218 = A0_214.account
  else
    L4_218 = L4_218 or "00000000"
  end
  L5_219 = A0_214.userId
  if nil ~= L5_219 then
    L5_219 = A0_214.userId
  else
    L5_219 = L5_219 or "00000000"
  end
  L6_220 = A0_214.server
  L6_220 = L6_220.act
  L7_221 = string
  L7_221 = L7_221.format
  L7_221 = L7_221(A0_214.server.crashlog, A0_214.operator, L4_218, L5_219, A1_215, A0_214.server.gameId, L3_217)
  L6_220 = L6_220 .. L7_221
  L7_221 = A0_214.HttpRequest
  L7_221 = L7_221(A0_214, L6_220)
  L7_221.ucRetry = 0
  Singleton(NetHttp):Send(L7_221, false)
end
function class.SubmitBug(A0_222)
  local L1_223, L2_224
  L1_223 = A0_222.server
  L1_223 = L1_223.act
  L2_224 = string
  L2_224 = L2_224.format
  L2_224 = L2_224(A0_222.server.bugSubmit, A0_222.operator, A0_222.userId, A0_222.server.gameId)
  L1_223 = L1_223 .. L2_224
  L2_224 = "http://"
  L2_224 = L2_224 .. A0_222.server.host .. L1_223
  Logic:Get("EnvLogic"):OpenUrl(L2_224)
end
function class.NeedAutoEnterGame(A0_225, A1_226)
  A0_225.needAutoEnterGame = A1_226
end
function class.GetServer(A0_227)
  local L1_228
  L1_228 = A0_227.server
  return L1_228
end
function class.loginErr(A0_229)
  Logic:Get("Login"):CloseNetConnTip()
  Logic:Get("Login"):FireEvent(Logic.Login.EVT.RESET_LOGIN_BTN, true)
end
