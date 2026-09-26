local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("Logic")
L0_0 = require
L0_0("protocol")
L0_0 = Enum
L0_0 = L0_0({
  "SET_LOGIN_NOTICE",
  "RESET_LOGIN_BTN",
  "SERVER_CHANGE",
  "GAME_STAGECHANGE",
  "LOGIN_COMPLETE",
  "UPDATE_PUSH",
  "PUSH_STATE"
})
EVT = L0_0
L0_0 = Enum
L0_0 = L0_0({
  [0] = "NORMAL",
  "NEW"
})
SERVER_SIGN_TYPE = L0_0
L0_0 = {}
L0_0.AUTOPATCH = 1
L0_0.ACCOUNT = 2
L0_0.ENTERGAME = 3
LOAD_STAGE = L0_0
L0_0 = Enum
L0_0 = L0_0(TypeDef("com.eyu.mt.module.account.facade.AccountResult"))
class = Logic.class:subclass()
function class.initialize(A0_1)
  super.initialize(A0_1)
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgAccount", _UPVALUE0_, _UPVALUE1_)
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgTencent", _UPVALUE2_, _UPVALUE3_)
  A0_1.deqLoginedServerInfo = {}
  A0_1.objLoginInfo = {}
  A0_1.isCreateRole = false
  A0_1.isNeedCallBoardBg = false
  A0_1.isPush = nil
  A0_1.reconnectAttempt = 0
  A0_1.reconnectScheduled = false
  A0_1.reconnectInProgress = false
  A0_1.reconnectHttpInFlight = false
  A0_1.tcpLoginProofSequence = 0
  A0_1.tcpLoginProofPending = nil
  MsgSystem:On("REQUEST_DESCRIPTION", A0_1:Event("OnDescription"))
  MsgAccount:On("CHECK_ACCOUNT", A0_1:Event("OnCheckAccount"), false)
  MsgAccount:On("LOGIN", A0_1:Event("OnLogin"), false)
  MsgAccount:On("LOGIN_INFO", A0_1:Event("OnLoginInfo"), false)
  MsgAccount:On("CREATE", A0_1:Event("OnCreateRole"), false)
  MsgAccount:On("LOGIN_COMPLETE", A0_1:Event("OnLoginComplete"))
  MsgAccount:On("UPDATE_PUSH", A0_1:Event("OnPushUpdate"))
  MsgAccount:On("PUSH_STATE", A0_1:Event("OnPushState"))
  MsgSystem:On("MD5_DESCRIPTION", A0_1:Event("OnMd5Description"))
  MsgTencent:On("UPLOAD_API_ARGS", A0_1:Event("OnUploadApiArgs"), false)
  MsgTencent:On("QUERY_BALANCE", A0_1:Event("OnQueryBalance"), false)
  Singleton(NetMgr):On(NetMgr.EVT.CONN, A0_1:Event("OnNetConnStart"))
  Singleton(NetMgr):On(NetMgr.EVT.CLOSE, A0_1:Event("OnNetConnStop"))
  Singleton(NetMgr):On(NetMgr.EVT.FAILED, A0_1:Event("OnNetConnFailed"))
  Singleton(NetMgr):On(NetMgr.EVT.LOGIN, A0_1:Event("Login"))
  Singleton(NetMgr):On(NetMgr.EVT.SESSION_TIMEOUT, A0_1:Event("OnSessionTimeOut"))
  Singleton(NetMgr):On(NetMgr.EVT.ERROR, A0_1:Event("OnMsgError"))
  Singleton(NetMgr):On(NetMgr.EVT.VERSION_CHANGE, A0_1:Event("OnVersionChanged"))
  Singleton(NetMgr):On(NetMgr.EVT.TENCENT_NEED_LOGIN, A0_1:Event("OnTencentUpdatePayToken"))
end
function class.OnReset(A0_2)
  A0_2.tcpLoginProofPending = nil
  A0_2.objLoginInfo = {}
  A0_2:CancelReconnect()
end
function class.CancelReconnect(A0_3)
  A0_3.reconnectAttempt = 0
  A0_3.reconnectScheduled = false
  A0_3.reconnectInProgress = false
  A0_3.reconnectHttpInFlight = false
  Singleton(NetMgr):EndRecovery()
  A0_3:EventTracer():Cancel("AUTO_RECONNECT")
end
function class.InitServerLst(A0_4, A1_5)
  if nil == A1_5 or "" == A1_5 then
    return false
  end
  if not pcall(function()
    local L0_6
    L0_6 = _UPVALUE0_
    L0_6.serverLst = json.decode(_UPVALUE1_)
    L0_6 = _UPVALUE0_
    L0_6.serverLst = _UPVALUE0_.serverLst.list
  end) then
    return false
  end
  A0_4:ServerSort(A0_4.serverLst)
  A0_4:ReadRecordServerIdx()
  return true
end
function class.GetServerLst(A0_7)
  local L1_8
  L1_8 = A0_7.serverLst
  return L1_8
end
function class.SetServerLst(A0_9, A1_10)
  A0_9.serverLst = A1_10
end
function class.Login(A0_11)
  local L1_12, L2_13, L3_14, L4_15, L5_16, L6_17
  L2_13 = A0_11
  L1_12 = A0_11.EventTracer
  L1_12 = L1_12(L2_13)
  L2_13 = L1_12
  L1_12 = L1_12.Exist
  L3_14 = "CHECK_VERSION"
  L1_12 = L1_12(L2_13, L3_14)
  if L1_12 then
    L1_12 = log4misc
    L2_13 = L1_12
    L1_12 = L1_12.warn
    L3_14 = "Login check twise"
    L1_12(L2_13, L3_14)
    return
  end
  L1_12 = Singleton
  L2_13 = NetMgr
  L1_12 = L1_12(L2_13)
  L2_13 = L1_12
  L1_12 = L1_12.SetSessionID
  L3_14 = nil
  L1_12(L2_13, L3_14)
  L1_12 = KFDBGetRecordByPT
  L2_13 = "deviceName"
  L1_12 = L1_12(L2_13)
  if nil == L1_12 then
    return
  end
  L2_13 = Logic
  L3_14 = L2_13
  L2_13 = L2_13.Get
  L4_15 = "System"
  L2_13 = L2_13(L3_14, L4_15)
  L3_14 = L2_13
  L2_13 = L2_13.GetAutoPatch
  L2_13 = L2_13(L3_14)
  if nil == L2_13 then
    return
  end
  L3_14 = Logic
  L4_15 = L3_14
  L3_14 = L3_14.Get
  L5_16 = "System"
  L3_14 = L3_14(L4_15, L5_16)
  L4_15 = L3_14
  L3_14 = L3_14.GetOperatorName
  L3_14 = L3_14(L4_15)
  L4_15 = Logic
  L5_16 = L4_15
  L4_15 = L4_15.Get
  L6_17 = "System"
  L4_15 = L4_15(L5_16, L6_17)
  L5_16 = L4_15
  L4_15 = L4_15.GetOperatorId
  L4_15 = L4_15(L5_16)
  if nil == L3_14 or nil == L4_15 then
    return
  end
  L5_16 = CVariableSystem
  L6_17 = L5_16
  L5_16 = L5_16.GetSingleton
  L5_16 = L5_16(L6_17)
  L6_17 = L5_16
  L5_16 = L5_16.GetSysVariable
  L5_16 = L5_16(L6_17, GV_DOCPATH)
  L6_17 = L5_16
  L6_17 = L6_17 .. "ZipFile/autopatch_version.xml"
  A0_11.verFile = L6_17
  L6_17 = ITwHttp
  L6_17 = L6_17.Request
  L6_17 = L6_17()
  L6_17.strHost = L2_13.host
  L6_17.strMethod = "GET"
  L6_17.strAction = string.format(L2_13.verAct, L2_13.productName, L4_15, L3_14, L1_12)
  L6_17.usPort = _UPVALUE0_(L2_13.host, L2_13.port)
  CTwDirUtils:DelFile(A0_11.verFile)
  L6_17:SetDownloadFile(A0_11.verFile)
  Singleton(NetHttp):On(L6_17.uReqId, A0_11:Event("CHECK_VERSION", "OnCheckVersion"))
  Singleton(NetHttp):Send(L6_17)
end
function class.OnCheckVersion(A0_18, A1_19, A2_20)
  local L3_21, L4_22, L5_23, L6_24
  L4_22 = A0_18
  L3_21 = A0_18.EventTracer
  L3_21 = L3_21(L4_22)
  L4_22 = L3_21
  L3_21 = L3_21.Cancel
  L5_23 = "CHECK_VERSION"
  L3_21(L4_22, L5_23)
  if 0 ~= A1_19 then
    L4_22 = A0_18
    L3_21 = A0_18.OnPromptConfirmRetry
    L5_23 = 10119
    L3_21(L4_22, L5_23)
    return
  end
  L3_21 = io
  L3_21 = L3_21.open
  L4_22 = A0_18.verFile
  L3_21 = L3_21(L4_22)
  if nil == L3_21 then
    L5_23 = A0_18
    L4_22 = A0_18.OnPromptConfirmRetry
    L6_24 = 10120
    L4_22(L5_23, L6_24)
    return
  end
  L5_23 = L3_21
  L4_22 = L3_21.read
  L6_24 = "*a"
  L4_22 = L4_22(L5_23, L6_24)
  L5_23 = io
  L5_23 = L5_23.close
  L6_24 = L3_21
  L5_23(L6_24)
  L5_23 = CTwDirUtils
  L6_24 = L5_23
  L5_23 = L5_23.DelFile
  L5_23(L6_24, A0_18.verFile)
  if nil == L4_22 or "" == L4_22 then
    L6_24 = A0_18
    L5_23 = A0_18.OnPromptConfirmRetry
    L5_23(L6_24, 10121)
    return
  end
  L5_23 = json
  L5_23 = L5_23.decode
  L6_24 = L4_22
  L5_23 = L5_23(L6_24)
  L6_24 = CVariableSystem
  L6_24 = L6_24.GetSingleton
  L6_24 = L6_24(L6_24)
  L6_24 = L6_24.GetSysVariable
  L6_24 = L6_24(L6_24, GV_VERSION)
  if nil == L6_24 or "" == L6_24 then
    return
  end
  L6_24 = tonumber(L6_24)
  if L6_24 < L5_23.package then
    if Logic:Get("Guide"):isGuiding() then
      Prompt:Confirm(A0_18, 10095, 10096, function()
        Singleton(GameStage):ChgStage("Logout", true)
      end)
    else
      Prompt:Select(A0_18, 10095, 10096, A0_18.OnConfirmCheckPackage)
    end
    return
  end
  if Logic:Get("System"):GetResVer() < L5_23.asset then
    A0_18:OnPromptConfirmRetry(10125)
    return
  end
  A0_18:CheckDescrition()
end
function class.CheckDescrition(A0_25)
  if tonumber(A0_25.objLoginInfo.ticketVersion) == 2 then
    MsgSystem:PostPrior("MD5_DESCRIPTION")
    return
  end
  if not Logic:Get("System"):IsServerLocalVerfy(A0_25.objLoginInfo.server, A0_25.objLoginInfo.addr, A0_25.objLoginInfo.port) then
    MsgSystem:PostPrior("REQUEST_DESCRIPTION")
  else
    MsgSystem:PostPrior("MD5_DESCRIPTION")
  end
end
function class.OnConfirmCheckPackage(A0_26, A1_27)
  if A1_27 == Prompt.RET.OK then
    A0_26:BackToAutoPatch()
  end
end
function class.OnMd5Description(A0_28, A1_29, A2_30)
  local L3_31, L4_32
  if nil == A1_29 or 0 ~= A1_29 or nil == A2_30 then
    L4_32 = A0_28
    L3_31 = A0_28.OnPromptConfirmRetry
    L3_31(L4_32, 10122)
    return
  end
  L3_31 = CMd5
  L4_32 = "db/describe.dat"
  L3_31 = L3_31(L4_32, true)
  L4_32 = L3_31
  L3_31 = L3_31.GetResult
  L3_31 = L3_31(L4_32)
  L4_32 = tonumber
  L4_32 = L4_32(A0_28.objLoginInfo.ticketVersion)
  if L4_32 == 2 then
    L4_32 = nil
    if not pcall(function()
      _UPVALUE0_ = json.decode(_UPVALUE1_)
    end) or type(L4_32) ~= "table" or type(L4_32.describeMd5) ~= "string" or string.upper(L3_31) ~= string.upper(L4_32.describeMd5) then
      A0_28:OnPromptConfirmRetry(10123)
      return
    end
    A0_28:OnDescription(0, A2_30)
    return
  end
  L4_32 = string
  L4_32 = L4_32.upper
  L4_32 = L4_32(L3_31)
  if L4_32 ~= string.upper(A2_30) then
    L4_32 = A0_28.OnPromptConfirmRetry
    L4_32(A0_28, 10123)
    return
  end
  L4_32 = A0_28.OnDescription
  L4_32(A0_28, 0)
end
function class.OnUploadApiArgs(A0_33, A1_34, A2_35)
  if nil == A1_34 or 0 ~= A1_34 then
    Prompt:Confirm(A0_33, 0, 10161, function()
      Logic:Get("EnvLogic"):Logout()
      Singleton(GameStage):ChgStage("Logout", false)
    end)
    return
  end
  A0_33.isLoginState = true
  MsgTencent:Post("QUERY_BALANCE")
end
function class.OnQueryBalance(A0_36, A1_37, A2_38, A3_39)
  local L4_40, L5_41
  L4_40 = TypeDef
  L5_41 = "com.eyu.mt.module.common.model.AttachmentState"
  L4_40 = L4_40(L5_41)
  L5_41 = #A3_39
  if L5_41 ~= 0 then
    L5_41 = struct
    L5_41 = L5_41.unpack
    L5_41 = L5_41(">!1I4", A3_39)
    if bit.band(L4_40.TENCENT_NEED_LOGIN, L5_41) == L4_40.TENCENT_NEED_LOGIN then
      return
    end
  end
  if nil == A1_37 or 0 ~= A1_37 or nil == A2_38 then
    L5_41 = A0_36.isLoginState
    if L5_41 == true then
      A0_36.isLoginState = false
      L5_41 = A0_36.LoginComplete
      L5_41(A0_36)
    end
    return
  end
  L5_41 = Logic
  L5_41 = L5_41.Get
  L5_41 = L5_41(L5_41, "PlayerInfo")
  L5_41 = L5_41.OnWallet
  L5_41(L5_41, A1_37, A2_38)
  L5_41 = A0_36.isLoginState
  if L5_41 == true then
    A0_36.isLoginState = false
    L5_41 = A0_36.LoginComplete
    L5_41(A0_36)
  end
end
function class.GetLoginInfo(A0_42)
  local L1_43
  L1_43 = A0_42.objLoginInfo
  return L1_43
end
function class.SetLoginInfo(A0_44, A1_45)
  A0_44.objLoginInfo = A1_45
end
function class.ReadRecordServerIdx(A0_46)
  if nil == CVariableSystem:GetSingleton():GetSysVariable(GV_LOGIN_SERVER) or "" == CVariableSystem:GetSingleton():GetSysVariable(GV_LOGIN_SERVER) then
    return
  end
  if not pcall(function()
    _UPVALUE0_.deqLoginedServerInfo = json.decode(_UPVALUE1_)
  end) then
    A0_46.deqLoginedServerInfo = {}
  end
end
function class.RecordServerInfo(A0_47, A1_48)
  local L2_49, L3_50, L4_51, L5_52
  if nil == A1_48 then
    return
  end
  if nil ~= L2_49 then
  elseif L2_49 then
    A0_47.deqLoginedServerInfo = L2_49
  end
  for L5_52 = 1, #L3_50 do
    if A0_47.deqLoginedServerInfo[L5_52] and A0_47.deqLoginedServerInfo[L5_52].aa == A1_48.aa and A0_47.deqLoginedServerInfo[L5_52].bb == A1_48.bb then
      table.remove(A0_47.deqLoginedServerInfo, L5_52)
      break
    end
  end
  L5_52 = A1_48
  L2_49(L3_50, L4_51, L5_52)
  if nil == L2_49 then
    return
  end
  L5_52 = GV_LOGIN_SERVER
  L3_50(L4_51, L5_52, L2_49)
  L3_50(L4_51)
end
function class.ForgetAccountPassword(A0_53, A1_54)
  local L2_55, L3_56, L4_57, L5_58
  if nil == L2_55 then
    return
  end
  for L5_58 = #L2_55, 1, -1 do
    if A0_53.deqLoginedServerInfo[L5_58] and A0_53.deqLoginedServerInfo[L5_58].bb == A1_54 then
      table.remove(A0_53.deqLoginedServerInfo, L5_58)
    end
  end
  L5_58 = json
  L5_58 = L5_58.encode
  L5_58 = L5_58(A0_53.deqLoginedServerInfo)
  L2_55(L3_56, L4_57, L5_58, L5_58(A0_53.deqLoginedServerInfo))
  L2_55(L3_56)
end
function class.GetRecordServerAmt(A0_59)
  local L1_60
  L1_60 = A0_59.deqLoginedServerInfo
  if nil == L1_60 then
    L1_60 = 0
    return L1_60
  end
  L1_60 = A0_59.deqLoginedServerInfo
  L1_60 = #L1_60
  return L1_60
end
function class.GetRecordServerByIdx(A0_61, A1_62)
  local L2_63
  L2_63 = A0_61.deqLoginedServerInfo
  if nil == L2_63 then
    L2_63 = nil
    return L2_63
  end
  L2_63 = A0_61.deqLoginedServerInfo
  L2_63 = L2_63[A1_62]
  return L2_63
end
function class.GetAccountStr(A0_64)
  if nil == A0_64.objLoginInfo or nil == A0_64.objLoginInfo.account or nil == A0_64.objLoginInfo.operator or nil == A0_64.objLoginInfo.server then
    log4misc:warn("error heroId")
    return
  end
  return string.format("%s.%d_%d", A0_64.objLoginInfo.account, A0_64.objLoginInfo.operator, A0_64.objLoginInfo.server)
end
function class.CalcKey(A0_65)
  local L1_66
  L1_66 = A0_65.objLoginInfo
  L1_66 = L1_66.sign
  if nil ~= L1_66 then
    L1_66 = A0_65.objLoginInfo
    L1_66 = L1_66.time
    if nil ~= L1_66 then
      L1_66 = A0_65.objLoginInfo
      L1_66 = L1_66.sign
      return L1_66, A0_65.objLoginInfo.time
    end
  end
end
function class.ServerSort(A0_67, A1_68)
  local L2_69, L3_70, L4_71, L5_72, L6_73, L7_74, L8_75, L9_76, L10_77, L11_78, L12_79, L13_80, L14_81
  if A1_68 == nil then
    return
  end
  L2_69 = #A1_68
  for L6_73 = 1, L2_69 do
    if L7_74 == "string" then
      L7_74.port = L8_75
    end
    if L7_74 == "string" then
      L7_74.server = L8_75
    end
  end
  if L4_71 == L3_70 then
  else
  end
  if L5_72 == L3_70 then
  end
  if nil == L5_72 or not L5_72 then
  end
  if nil ~= L6_73 then
  end
  for L9_76 = 1, #L5_72 do
    for L13_80 = #A1_68, 1, -1 do
      L14_81 = A1_68[L13_80]
      if nil ~= L14_81 then
        L14_81 = L5_72[L9_76]
        if nil ~= L14_81 then
          L14_81 = A1_68[L13_80]
          L14_81 = L14_81.server
          if L14_81 == L5_72[L9_76] then
            L14_81 = table
            L14_81 = L14_81.remove
            L14_81(A1_68, L13_80)
          end
        end
      end
    end
  end
  if nil == L6_73 or not L6_73 then
  end
  if nil ~= L7_74 then
  end
  for L10_77 = 1, #L6_73 do
    for L14_81 = #A1_68, 1, -1 do
      if nil ~= A1_68[L14_81] and nil ~= L6_73[L10_77] and nil ~= A1_68[L14_81].server and A1_68[L14_81].server == L6_73[L10_77].server then
        table.remove(A1_68, L14_81)
      end
    end
    L11_78(L12_79, L13_80)
  end
  L7_74(L8_75, L9_76)
end
function class.GetServerAmount(A0_82)
  local L1_83
  L1_83 = A0_82.serverLst
  if nil == L1_83 then
    L1_83 = 0
    return L1_83
  end
  L1_83 = A0_82.serverLst
  L1_83 = #L1_83
  return L1_83
end
function class.GetServerInfoByIdx(A0_84, A1_85)
  local L2_86
  L2_86 = A0_84.serverLst
  if nil == L2_86 then
    L2_86 = nil
    return L2_86
  end
  L2_86 = A0_84.serverLst
  L2_86 = L2_86[A1_85]
  return L2_86
end
function class.GetServerInfo(A0_87, A1_88)
  local L4_89, L5_90, L6_91
  if nil == A1_88 then
    return L4_89
  end
  if nil == L4_89 then
    return L4_89
  end
  for _FORV_5_ = 1, #L5_90 do
    if A0_87.serverLst[_FORV_5_] and A1_88 == A0_87.serverLst[_FORV_5_].server then
      return A0_87.serverLst[_FORV_5_]
    end
  end
  return L4_89
end
function class.SetSelectServer(A0_92, A1_93)
  A0_92.selectIdx = A1_93
  A0_92:FireEvent(EVT.SERVER_CHANGE)
end
function class.GetSelextServer(A0_94)
  local L1_95
  L1_95 = A0_94.selectIdx
  return L1_95
end
function class.OnDescription(A0_96, A1_97, A2_98)
  log4login:debug("desc")
  if nil == A0_96:CalcKey() or "" == A0_96:CalcKey() or nil == A0_96:CalcKey() then
    log4misc:warn("missing zone login ticket for account check")
    Singleton(NetMgr):Disconnect()
    A0_96:FireEvent(EVT.RESET_LOGIN_BTN, true)
    return
  end
  if tonumber(A0_96.objLoginInfo.ticketVersion) == 2 then
    if A1_97 ~= 0 or type(A2_98) ~= "string" or "" == A2_98 or nil == A0_96:GetAccountStr() then
      Singleton(NetMgr):Disconnect()
      A0_96:FireEvent(EVT.RESET_LOGIN_BTN, true)
      return
    end
    A0_96.tcpLoginProofSequence = (tonumber(A0_96.tcpLoginProofSequence) or 0) + 1
    A0_96.tcpLoginProofPending = {
      token = "tcp-proof-" .. tostring(A0_96.tcpLoginProofSequence),
      ticket = A0_96:CalcKey()
    }
    Logic:Get("EnvLogic"):BuildTcpLoginProof({
      token = "tcp-proof-" .. tostring(A0_96.tcpLoginProofSequence),
      describeJson = A2_98,
      expectedDescribeMd5 = CMd5("db/describe.dat", true):GetResult(),
      ticket = A0_96:CalcKey()
    })
    return
  end
  MsgAccount:PostPrior("CHECK_ACCOUNT", {
    account = A0_96:GetAccountStr(),
    key = A0_96:CalcKey()
  })
end
function class.OnTcpLoginProof(A0_99, A1_100)
  local L2_101
  L2_101 = A0_99.tcpLoginProofPending
  if type(A1_100) ~= "table" or nil == L2_101 or A1_100.token ~= L2_101.token then
    return
  end
  A0_99.tcpLoginProofPending = nil
  if tonumber(A1_100.transportCode) ~= 0 or type(A1_100.credential) ~= "string" or not string.match(A1_100.credential, "^p2%.[A-Za-z0-9_-]+%.[A-Za-z0-9_-]+$") or A0_99:CalcKey() ~= L2_101.ticket or A0_99:CalcKey() ~= L2_101.timestamp or A0_99:GetAccountStr() ~= L2_101.account or tonumber(A0_99.objLoginInfo.server) ~= L2_101.zoneId then
    Singleton(NetMgr):Disconnect()
    A0_99:FireEvent(EVT.RESET_LOGIN_BTN, true)
    return
  end
  MsgAccount:PostPrior("CHECK_ACCOUNT", {
    account = L2_101.account,
    key = A1_100.credential,
    timestamp = L2_101.timestamp
  })
end
function class.HandleServerUnopened(A0_102, A1_103, A2_104)
  if A1_103 == _UPVALUE0_.ACCOUNT_ALREADY_EXISTS and type(A2_104) == "table" and A2_104.serverUnopened then
    Prompt:Confirm(A0_102, 103001, 102219)
    Singleton(NetMgr):Disconnect()
    A0_102:FireEvent(EVT.RESET_LOGIN_BTN, true)
    return true
  end
  return false
end
function class.OnCheckAccount(A0_105, A1_106, A2_107)
  log4login:debug("check")
  if A0_105:HandleServerUnopened(A1_106, A2_107) then
    return
  end
  if Logic:Get("MsgAssist"):OnMsgResult("MsgAccount", A1_106) then
    Singleton(NetMgr):Disconnect()
    A0_105:FireEvent(EVT.RESET_LOGIN_BTN, true)
    return
  end
  if A2_107 == false then
    A0_105:FireEvent(EVT.SET_LOGIN_NOTICE, TwGetStr(10051))
    Singleton(GameStage):ChgStage("CreateHero")
    return
  end
  A0_105:FireEvent(EVT.SET_LOGIN_NOTICE, TwGetStr(10052))
  A0_105:PostLogin()
end
function class.PostLogin(A0_108)
  local L1_109, L2_110, L3_111, L4_112, L5_113, L6_114, L7_115, L8_116, L9_117
  L2_110 = A0_108
  L1_109 = A0_108.GetAccountStr
  L1_109 = L1_109(L2_110)
  L3_111 = A0_108
  L2_110 = A0_108.CalcKey
  L3_111 = L2_110(L3_111)
  if nil == L2_110 or nil == L3_111 then
    L4_112 = log4misc
    L5_113 = L4_112
    L4_112 = L4_112.warn
    L6_114 = "get key or timestamp error"
    L4_112(L5_113, L6_114)
    return
  end
  L4_112 = Logic
  L5_113 = L4_112
  L4_112 = L4_112.Get
  L6_114 = "System"
  L4_112 = L4_112(L5_113, L6_114)
  L5_113 = L4_112
  L4_112 = L4_112.GetDeviceToken
  L4_112 = L4_112(L5_113)
  L4_112 = L4_112 or ""
  L5_113 = Logic
  L6_114 = L5_113
  L5_113 = L5_113.Get
  L7_115 = "System"
  L5_113 = L5_113(L6_114, L7_115)
  L6_114 = L5_113
  L5_113 = L5_113.GetServerDeviceType
  L5_113 = L5_113(L6_114)
  L6_114 = CVariableSystem
  L7_115 = L6_114
  L6_114 = L6_114.GetSingleton
  L6_114 = L6_114(L7_115)
  L7_115 = L6_114
  L6_114 = L6_114.GetSysVariable
  L8_116 = GV_PKG_IDENTIFIER
  L6_114 = L6_114(L7_115, L8_116)
  L6_114 = L6_114 or ""
  L7_115 = Logic
  L8_116 = L7_115
  L7_115 = L7_115.Get
  L9_117 = "System"
  L7_115 = L7_115(L8_116, L9_117)
  L8_116 = L7_115
  L7_115 = L7_115.IsSelfAccLogin
  L7_115 = L7_115(L8_116)
  if L7_115 then
    L7_115 = A0_108.objLoginInfo
    L7_115 = L7_115.account
  elseif not L7_115 then
    L7_115 = A0_108.objLoginInfo
    L7_115 = L7_115.originUserId
  end
  if nil ~= L7_115 then
    L8_116 = tostring
    L9_117 = L7_115
    L8_116 = L8_116(L9_117)
  else
    L7_115 = L8_116 or nil
  end
  L8_116 = Logic
  L9_117 = L8_116
  L8_116 = L8_116.Get
  L8_116 = L8_116(L9_117, "System")
  L9_117 = L8_116
  L8_116 = L8_116.GetUniqueId
  L8_116 = L8_116(L9_117)
  L8_116 = L8_116 or ""
  L9_117 = Logic
  L9_117 = L9_117.Get
  L9_117 = L9_117(L9_117, "System")
  L9_117 = L9_117.IsOperator
  L9_117 = L9_117(L9_117, "appstore")
  if L9_117 then
    L9_117 = {}
    L9_117.idfa = Logic:Get("System"):GetIdfa() or ""
    L9_117.uuid = Logic:Get("System"):GetUniqueId() or ""
    L9_117.mac = Logic:Get("System"):GetMacAddr() or ""
    L9_117.account = A0_108.objLoginInfo.originUserId or ""
    L8_116 = json.encode(L9_117)
  end
  L9_117 = nil
  if Logic:Get("System"):IsChannel("appstoreJS") then
    L9_117 = CTwUtil:GetPlatform()
  end
  MsgAccount:PostPrior("LOGIN", {
    account = L1_109,
    adult = false,
    timestamp = L3_111,
    key = L2_110,
    device = L5_113,
    token = L4_112,
    appId = L6_114,
    origin = L7_115,
    idfa = L8_116,
    channel = L9_117
  })
end
function class.CreateRole(A0_118, A1_119)
  if not Logic:Get("Account"):HasFreshTicketForServer(A0_118:GetSelextServer()) then
    Logic:Get("Account"):RefreshLoginTicket(function(A0_120)
      if A0_120 then
        _UPVALUE0_:CreateRole(_UPVALUE1_)
      else
        _UPVALUE0_:FireEvent(EVT.RESET_LOGIN_BTN, true)
      end
    end)
    return
  end
  if nil == A0_118:CalcKey() or nil == A0_118:CalcKey() then
    A0_118:FireEvent(EVT.RESET_LOGIN_BTN, true)
    return
  end
  A1_119.timestamp, A1_119.key = A0_118:CalcKey()
  MsgAccount:PostPrior("CREATE", A1_119)
  A0_118.roleInfo = {
    id = A0_118.objLoginInfo.account,
    server = A0_118.objLoginInfo.server,
    name = A1_119.name,
    profession = A1_119.select,
    origin = A0_118.objLoginInfo.originUserId
  }
end
function class.OnCreateRole(A0_121, A1_122, A2_123)
  log4login:debug("create role")
  if A0_121:HandleServerUnopened(A1_122, A2_123) then
    return
  end
  if A1_122 == TypeDef("com.eyu.mt.module.account.facade.AccountResult").ACCOUNT_ALREADY_EXISTS then
    Prompt:Confirm(A0_121, 0, 10022, function()
      Logic:Get("EnvLogic"):Logout()
      Singleton(GameStage):ChgStage("Logout", true)
    end)
    return
  end
  if Logic:Get("MsgAssist"):OnMsgResult("MsgAccount", A1_122) or 0 ~= A2_123 then
    A0_121:FireEvent(EVT.RESET_LOGIN_BTN, true)
    return
  end
  if nil ~= A0_121.objLoginInfo and nil ~= A0_121.roleInfo then
    Logic:Get("Account"):AddRole(A0_121.roleInfo.server, A0_121.roleInfo.id, A0_121.roleInfo.name, A0_121.roleInfo.profession)
  end
  A0_121.isCreateRole = true
  A0_121:Login()
  Logic:Get("Guide"):setup()
end
function class.OnLogin(A0_124, A1_125, A2_126)
  if A0_124:HandleServerUnopened(A1_125, A2_126) then
    return
  end
  if Logic:Get("MsgAssist"):OnMsgResult("MsgAccount", A1_125) then
    Singleton(NetMgr):Disconnect()
    A0_124:FireEvent(EVT.RESET_LOGIN_BTN, true)
    return
  end
  Singleton(NetMgr):SetSessionID(A2_126)
  log4login:debug("login" .. A2_126)
  MsgAccount:PostPrior("LOGIN_INFO")
end
function class.OnLoginInfo(A0_127, A1_128, A2_129)
  local L3_130
  L3_130 = log4login
  L3_130 = L3_130.debug
  L3_130(L3_130, "loginInfo")
  if A1_128 == -503 then
    L3_130 = type
    L3_130 = L3_130(A2_129)
    if L3_130 == "table" then
      L3_130 = tonumber
      L3_130 = L3_130(A2_129.retryAfterMs)
    else
      L3_130 = L3_130 or nil
    end
    log4login:warn("Login info busy; retry after %d ms", L3_130 or 1000)
    A0_127.reconnectHttpInFlight = false
    Singleton(NetMgr):BeginRecovery()
    Singleton(NetMgr):Disconnect()
    if not A0_127:ScheduleReconnect(L3_130) then
      Prompt:Confirm(A0_127, 10072, 10071)
    end
    return
  end
  if nil ~= A2_129 then
    L3_130 = Logic
    L3_130 = L3_130.Get
    L3_130 = L3_130(L3_130, "MsgAssist")
    L3_130 = L3_130.OnMsgResult
    L3_130 = L3_130(L3_130, "MsgAccount", A1_128)
  elseif L3_130 then
    L3_130 = A0_127.CancelReconnect
    L3_130(A0_127)
    if nil == A2_129 then
      L3_130 = TwGetStr
      L3_130 = L3_130(10050)
      if not L3_130 then
      end
    end
    L3_130 = Prompt
    L3_130 = L3_130.Fail
    L3_130(L3_130, (TwGetStr(10046)))
    L3_130 = Singleton
    L3_130 = L3_130(NetMgr)
    L3_130 = L3_130.Disconnect
    L3_130(L3_130)
    L3_130 = A0_127.FireEvent
    L3_130(A0_127, EVT.RESET_LOGIN_BTN, true)
    return
  end
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "System")
  L3_130 = L3_130.GetServerVer
  L3_130 = L3_130(L3_130)
  if L3_130 ~= A2_129.asset then
    L3_130 = A0_127.CancelReconnect
    L3_130(A0_127)
    L3_130 = A0_127.OnPromptConfirmRetry
    L3_130(A0_127, 10124)
    return
  end
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "PlayerInfo")
  L3_130 = L3_130.InitInfo
  L3_130(L3_130, A2_129.player)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "PlayerInfo")
  L3_130 = L3_130.InitPhysical
  L3_130(L3_130, A2_129.actionPoint.points[0])
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "PlayerInfo")
  L3_130 = L3_130.InitWallet
  L3_130(L3_130, A2_129.wallet)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "PlayerInfo")
  L3_130 = L3_130.SetVipInfo
  L3_130(L3_130, A2_129.vip)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Hero")
  L3_130 = L3_130.SetGroupInfo
  L3_130(L3_130, A2_129.groupVo)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Hero")
  L3_130 = L3_130.OnLoginHeroInfo
  L3_130(L3_130, A2_129.heros)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Lineup")
  L3_130 = L3_130.setTeamInfo
  L3_130(L3_130, A2_129.teamInfoVo)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "System")
  L3_130 = L3_130.OnSystemTime
  L3_130(L3_130, 0, A2_129.systemTime)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Email")
  L3_130 = L3_130.SetNewMailPro
  L3_130(L3_130, A2_129.hasNewMail)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Gift")
  L3_130 = L3_130.SetHasReward
  L3_130(L3_130, A2_129.hasReward)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Achievement")
  L3_130 = L3_130.NewAchievePrompt
  L3_130(L3_130, A2_129.hasAchieve)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Achievement")
  L3_130 = L3_130.setAchieve
  L3_130(L3_130, A2_129.emblemAchieveList)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Draw")
  L3_130 = L3_130.setLastDrawLevel
  L3_130(L3_130, A2_129.lotteryLevel)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Compose")
  L3_130 = L3_130.OnGetItems
  L3_130(L3_130, 0, A2_129.items)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Achievement")
  L3_130 = L3_130.onBuff
  L3_130(L3_130, A2_129.buffs)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Friend")
  L3_130 = L3_130.InitFriendInfo
  L3_130(L3_130, A2_129.friendPack)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Friend")
  L3_130 = L3_130.setCommendFriend
  L3_130(L3_130, A2_129.commendFriend)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Gift")
  L3_130 = L3_130.onLoginAcc
  L3_130(L3_130, A2_129.account)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "PlayerInfo")
  L3_130 = L3_130.SetDailyCheckInfo
  L3_130(L3_130, A2_129.dailyCheckInfo)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Gift")
  L3_130 = L3_130.OnAllGift
  L3_130(L3_130, 0, A2_129.validGiftVo)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Gift")
  L3_130 = L3_130.OnGetActivitys
  L3_130(L3_130, 0, A2_129.activitys)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Treasure")
  L3_130 = L3_130.setInfo
  L3_130(L3_130, A2_129.treasurePack)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Fight")
  L3_130 = L3_130.setMatchData
  L3_130(L3_130, A2_129.arenaMatchList)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Devil")
  L3_130 = L3_130.setActiveId
  L3_130(L3_130, A2_129.demogActiveId)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Devil")
  L3_130 = L3_130.setFeatsRank
  L3_130(L3_130, A2_129.demogRank)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Devil")
  L3_130 = L3_130.SetFeat
  L3_130(L3_130, A2_129.demogFeat)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Devil")
  L3_130 = L3_130.SetEnergy
  L3_130(L3_130, A2_129.actionPoint.points[1])
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Artifact")
  L3_130 = L3_130.SetArtLevel
  L3_130(L3_130, A2_129.artifactLevel)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Target")
  L3_130 = L3_130.SetProgress
  L3_130(L3_130, A2_129.targetProgress)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Mall")
  L3_130 = L3_130.SetDrawProgress
  L3_130(L3_130, A2_129.lotteryRecord)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Battle")
  L3_130 = L3_130.OnProgress
  L3_130(L3_130, 0, A2_129.progressVo)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Elite")
  L3_130 = L3_130.CreateCampaignMap
  L3_130(L3_130, A2_129.eliteBattleIds)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Platform")
  L3_130 = L3_130.setLastPraiseTime
  L3_130(L3_130, A2_129.lastPraiseTime)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Rebirth")
  L3_130 = L3_130.SetActiveProgress
  L3_130(L3_130, A2_129.activeProgress)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Dumpling")
  L3_130 = L3_130.setCoolTime
  L3_130(L3_130, A2_129.dumplingCoolTime)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Talisman")
  L3_130 = L3_130.OnLoadAllTalisman
  L3_130(L3_130, 0, A2_129.talismanVos)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Armor")
  L3_130 = L3_130.setEquipInfos
  L3_130(L3_130, A2_129.equipVos)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Armor")
  L3_130 = L3_130.initPackInfo
  L3_130(L3_130, A2_129.buyEquipSpace, A2_129.buyEquipPackCount)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Sect")
  L3_130 = L3_130.SetInfoFromLogin
  L3_130(L3_130, A2_129.menpaiLoginVo)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Consume")
  L3_130 = L3_130.setHasConsumeReward
  L3_130(L3_130, A2_129.consumeRankCanDraw)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Talisman")
  L3_130 = L3_130.InitTalismanSize
  L3_130(L3_130, A2_129.talismanPackExtendCount)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "WeChat")
  L3_130 = L3_130.InitPlatformInfo
  L3_130(L3_130, A2_129.platformInfo)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "PlayerInfo")
  L3_130 = L3_130.SetResetPlayerName
  L3_130(L3_130, A2_129.resetPlayerName)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Cultivate")
  L3_130 = L3_130.OnHeroCultivate
  L3_130(L3_130, A2_129.heroCultivateVos)
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "Explore")
  L3_130 = L3_130.setExploreExecuteTask
  L3_130(L3_130, A2_129.exploreExecuteTasks)
  L3_130 = A0_127.isCreateRole
  if L3_130 then
    L3_130 = A0_127.UserChoose
    L3_130(A0_127)
  end
  L3_130 = Logic
  L3_130 = L3_130.Get
  L3_130 = L3_130(L3_130, "System")
  L3_130 = L3_130.IsOperator
  L3_130 = L3_130(L3_130, "myapp")
  if L3_130 then
    L3_130 = Logic
    L3_130 = L3_130.Get
    L3_130 = L3_130(L3_130, "Account")
    L3_130 = L3_130.GetTencentLoginRet
    L3_130 = L3_130(L3_130)
    L3_130 = json.decode(L3_130) or {}
    ;({}).openid = L3_130.openid or ""
    ;({}).openkey = L3_130.openkey or ""
    ;({}).pay_token = L3_130.pay_token or ""
    ;({}).pf = L3_130.pf or ""
    ;({}).pfkey = L3_130.pfkey or ""
    MsgTencent:Post("UPLOAD_API_ARGS", {
      args = {}
    })
  else
    L3_130 = A0_127.LoginComplete
    L3_130(A0_127)
  end
end
function class.PostPushUpdate(A0_131, A1_132)
  if Singleton(GameStage):IsStage("Normal") then
    MsgAccount:Post("UPDATE_PUSH", {push = A1_132})
  end
end
function class.OnPushUpdate(A0_133, A1_134, A2_135)
  if A1_134 ~= 0 then
    return
  end
  A0_133:FireEvent(EVT.UPDATE_PUSH, A2_135)
end
function class.OnPushState(A0_136, A1_137, A2_138)
  if A1_137 ~= 0 then
    return
  end
  A0_136.isPush = A2_138 and 1 or 0
  A0_136:FireEvent(EVT.PUSH_STATE, A2_138)
end
function class.getIsPush(A0_139)
  local L1_140
  L1_140 = A0_139.isPush
  return L1_140
end
function class.setIsPush(A0_141, A1_142)
  A0_141.isPush = A1_142
end
function class.LoginComplete(A0_143)
  Logic:Get("Sdk"):SendAdvertisement()
  MsgAccount:PostPrior("LOGIN_COMPLETE")
end
function class.OnLoginComplete(A0_144)
  A0_144.reconnectAttempt = 0
  A0_144.reconnectScheduled = false
  A0_144.reconnectInProgress = false
  A0_144.reconnectHttpInFlight = false
  Singleton(NetMgr):EndRecovery()
  A0_144:EventTracer():Cancel("AUTO_RECONNECT")
  Logic:Get("EnvLogic"):LoginComplete()
  Singleton(GameStage):ChgStage("Normal")
  Logic:Get("PlayerInfo"):SendPlayerInfo()
  A0_144:FireEvent(EVT.LOGIN_COMPLETE)
end
function class.OnRecoveryHttpFailed(A0_145)
  if not A0_145.reconnectHttpInFlight then
    return
  end
  A0_145.reconnectHttpInFlight = false
  A0_145.reconnectInProgress = false
  Singleton(NetMgr):EndRecovery()
  A0_145:EventTracer():Cancel("AUTO_RECONNECT")
end
function class.OpenNetConnTip(A0_146, A1_147)
  SceneHelper:pushPrompt("NetConnTip")
  if A1_147 then
    SceneHelper:getPrompt(nil, "NetConnTip"):showInstant()
  end
end
function class.CloseNetConnTip(A0_148)
  SceneHelper:removePrompt(nil, "NetConnTip")
end
function class.OnNetConnStart(A0_149)
  A0_149:OpenNetConnTip()
end
function class.OnNetConnStop(A0_150)
  A0_150.tcpLoginProofPending = nil
  A0_150:CloseNetConnTip()
end
function class.OnNetConnFailed(A0_151)
  if A0_151.reconnectHttpInFlight then
    return
  end
  if (Singleton(GameStage):IsStage("Normal") or Singleton(GameStage):IsStage("CreateHero")) and A0_151:ScheduleReconnect() then
    return
  end
  A0_151:CancelReconnect()
  Prompt:Confirm(A0_151, 10072, 10071)
end
function class.ScheduleReconnect(A0_152, A1_153)
  local L2_154, L3_155
  L2_154 = A0_152.reconnectScheduled
  if not L2_154 then
    L2_154 = A0_152.reconnectHttpInFlight
  elseif L2_154 then
    L2_154 = false
    return L2_154
  end
  L2_154 = A0_152.reconnectAttempt
  if L2_154 >= 5 then
    A0_152.reconnectInProgress = false
    L2_154 = false
    return L2_154
  end
  A0_152.reconnectInProgress = true
  L2_154 = Singleton
  L3_155 = NetMgr
  L2_154 = L2_154(L3_155)
  L3_155 = L2_154
  L2_154 = L2_154.BeginRecovery
  L2_154(L3_155)
  L2_154 = A0_152.reconnectAttempt
  L2_154 = L2_154 + 1
  A0_152.reconnectAttempt = L2_154
  L2_154 = math
  L2_154 = L2_154.pow
  L3_155 = 2
  L2_154 = L2_154(L3_155, A0_152.reconnectAttempt - 1)
  L2_154 = 1000 * L2_154
  L3_155 = math
  L3_155 = L3_155.max
  L3_155 = L3_155(L2_154, tonumber(A1_153) or 0)
  L3_155 = L3_155 + math.random(0, 250)
  L3_155 = math.max(500, math.min(30000, L3_155))
  A0_152.reconnectScheduled = true
  log4login:warn("Schedule reconnect attempt %d after %d ms", A0_152.reconnectAttempt, L3_155)
  Singleton(Timer):After(L3_155, A0_152:Event("AUTO_RECONNECT", function()
    _UPVALUE0_.reconnectScheduled = false
    if not _UPVALUE0_.reconnectInProgress then
      return
    end
    if _UPVALUE0_.reconnectHttpInFlight then
      return
    end
    if not Singleton(GameStage):IsStage("Normal") and not Singleton(GameStage):IsStage("CreateHero") then
      _UPVALUE0_:CancelReconnect()
      return
    end
    _UPVALUE0_.reconnectHttpInFlight = true
    log4login:warn("Start reconnect attempt %d", _UPVALUE0_.reconnectAttempt)
    Logic:Get("Account"):NeedAutoEnterGame(true)
    if Logic:Get("Account"):GetIsVisitorType() then
      Logic:Get("Account"):AnonymityLogin()
    else
      Logic:Get("Account"):Login(false)
    end
  end))
  return true
end
function class.OnMsgError(A0_156, A1_157, A2_158)
  if Singleton(GameStage):IsStage("Normal") then
    SceneHelper:runWithScene("Home")
  end
  log4msg:warn("[mod = %d-%d]%s", A1_157, A2_158, TwGetStr(10080))
end
function class.OnSessionTimeOut(A0_159)
  Prompt:Confirm(A0_159, 0, 10079, function()
    Singleton(GameStage):ChgStage("Logout", true)
  end)
end
function class.BackToAutoPatch(A0_160)
  if Singleton(GameStage):IsStage("AutoPatch") then
    Logic:Get("Login"):SetLoadingStage(Logic.Login.LOAD_STAGE.AUTOPATCH)
  else
    Singleton(GameStage):ChgStage("AutoPatch")
  end
end
function class.OnPromptConfirmRetry(A0_161, A1_162)
  Prompt:Confirm(A0_161, 0, A1_162, A0_161.BackToAutoPatch)
end
function class.OnVersionChanged(A0_163)
  A0_163:CancelReconnect()
  A0_163:OnPromptConfirmRetry(10088)
end
function class.OnTencentUpdatePayToken(A0_164)
  Prompt:Confirm(A0_164, 0, 10160, function()
    Logic:Get("EnvLogic"):Logout()
    Singleton(GameStage):ChgStage("Logout", false)
  end)
end
function class.removeAni(A0_165, A1_166, A2_167, A3_168)
  local L4_169, L5_170
  if A1_166 == nil or A2_167 == nil or A2_167 == "" then
    return
  end
  L4_169 = Logic
  L5_170 = L4_169
  L4_169 = L4_169.Get
  L4_169 = L4_169(L5_170, "System")
  L5_170 = L4_169
  L4_169 = L4_169.GetDriveSize
  L4_169 = L4_169(L5_170)
  L5_170 = CCArray
  L5_170 = L5_170.create
  L5_170 = L5_170(L5_170)
  L5_170:addObject(CCMoveTo:create(0.3, ccp(L4_169 and L4_169.width or INIT_TO, 0)))
  L5_170:addObject(CCCallFunc:create(function()
    SceneHelper:removeScene(_UPVALUE0_)
    Logic:Get("Login"):SetLoadingStage(_UPVALUE1_)
  end))
  A1_166:runAction(CCSequence:create(L5_170))
end
function class.SetLoadingStage(A0_171, A1_172)
  A0_171.gameStage = A1_172
  A0_171:FireEvent(EVT.GAME_STAGECHANGE)
end
function class.GetLoadingStage(A0_173)
  local L1_174
  L1_174 = A0_173.gameStage
  return L1_174
end
function class.SetIsCreateRole(A0_175, A1_176)
  A0_175.isCreateRole = A1_176
end
function class.GetIsCreateRole(A0_177)
  local L1_178
  L1_178 = A0_177.isCreateRole
  return L1_178
end
function class.openCallboard(A0_179)
  if not Logic:Get("EnvLogic").isOpenCallBoard and A0_179:isNeedCallBoard() and nil ~= Logic:Get("System"):GetCallBoardURL() and "" ~= Logic:Get("System"):GetCallBoardURL() then
    if CTwUtil:GetPlatform() ~= CTwUtil.E_TP_WIN32 then
      SceneHelper:pushPrompt("Callboard", nil, A0_179.rootNode)
    end
    Logic:Get("EnvLogic").isOpenCallBoard = true
  end
end
function class.setCallBoardImg(A0_180, A1_181)
  A0_180.isNeedCallBoardBg = A1_181
end
function class.isNeedCallBoardImg(A0_182)
  local L1_183
  L1_183 = A0_182.isNeedCallBoardBg
  return L1_183
end
function class.isNeedCallBoard(A0_184)
  return Logic:Get("System"):GetSysVariableMisc("NeedOpenCallboard") == 1
end
function class.UserChoose(A0_185)
  local L1_186, L2_187, L3_188, L4_189, L5_190, L6_191, L7_192, L8_193
  L1_186 = Logic
  L2_187 = L1_186
  L1_186 = L1_186.Get
  L3_188 = "System"
  L1_186 = L1_186(L2_187, L3_188)
  L2_187 = L1_186
  L1_186 = L1_186.GetOperatorId
  L1_186 = L1_186(L2_187)
  L2_187 = Logic
  L3_188 = L2_187
  L2_187 = L2_187.Get
  L4_189 = "Account"
  L2_187 = L2_187(L3_188, L4_189)
  L3_188 = L2_187
  L2_187 = L2_187.GetAccName
  L2_187 = L2_187(L3_188)
  L3_188 = Logic
  L4_189 = L3_188
  L3_188 = L3_188.Get
  L5_190 = "Account"
  L3_188 = L3_188(L4_189, L5_190)
  L4_189 = L3_188
  L3_188 = L3_188.GetUserId
  L3_188 = L3_188(L4_189)
  L4_189 = Logic
  L5_190 = L4_189
  L4_189 = L4_189.Get
  L6_191 = "PlayerInfo"
  L4_189 = L4_189(L5_190, L6_191)
  L5_190 = L4_189
  L4_189 = L4_189.GetPlayerId
  L4_189 = L4_189(L5_190)
  L5_190 = protocol
  L5_190 = L5_190.Id2Str
  L6_191 = L4_189
  L5_190 = L5_190(L6_191)
  L4_189 = L5_190 or L4_189
  L5_190 = CMd5
  L6_191 = L1_186
  L7_192 = A0_185.objLoginInfo
  L7_192 = L7_192.server
  L8_193 = L2_187
  L6_191 = L6_191 .. L7_192 .. L8_193 .. L3_188 .. L4_189
  L5_190 = L5_190(L6_191)
  L6_191 = L5_190
  L5_190 = L5_190.GetResult
  L5_190 = L5_190(L6_191)
  L6_191 = Logic
  L7_192 = L6_191
  L6_191 = L6_191.Get
  L8_193 = "Account"
  L6_191 = L6_191(L7_192, L8_193)
  L7_192 = L6_191
  L6_191 = L6_191.GetServer
  L6_191 = L6_191(L7_192)
  L7_192 = nil
  L8_193 = L6_191.act
  L7_192 = L8_193 .. string.format(L6_191.userChoose, L1_186, A0_185.objLoginInfo.server, L2_187, L3_188, L4_189, L5_190)
  L8_193 = Logic
  L8_193 = L8_193.Get
  L8_193 = L8_193(L8_193, "Account")
  L8_193 = L8_193.HttpRequest
  L8_193 = L8_193(L8_193, L7_192)
  A0_185:EventTracer():Cancel("UserChoose")
  Singleton(NetHttp):On(L8_193.uReqId, A0_185:Event("UserChoose", "OnGetUserChoose"))
  Singleton(NetHttp):Send(L8_193)
end
function class.OnGetUserChoose(A0_194, A1_195, A2_196)
end
function class.initLoggedServer(A0_197)
  local L1_198, L2_199, L3_200, L4_201, L5_202, L6_203, L7_204, L8_205, L9_206, L10_207
  L1_198 = A0_197.deqLoginedServerInfo
  if nil == L1_198 then
    L1_198 = nil
    return L1_198
  end
  L1_198 = Logic
  L2_199 = L1_198
  L1_198 = L1_198.Get
  L3_200 = "Account"
  L1_198 = L1_198(L2_199, L3_200)
  L2_199 = L1_198
  L1_198 = L1_198.GetAccName
  L1_198 = L1_198(L2_199)
  L2_199 = {}
  L3_200 = {}
  A0_197.loggedServerLst = L3_200
  L3_200 = 0
  L4_201 = {}
  for L8_205, L9_206 in L5_202(L6_203) do
    if L3_200 == 4 then
      break
    end
    L10_207 = L9_206.bb
    if L10_207 == L1_198 then
      L10_207 = {}
      L10_207.server = L9_206.aa
      table.insert(L4_201, L10_207)
      L3_200 = L3_200 + 1
    end
  end
  if L3_200 == 0 then
    L2_199.isShowAllServer = true
    L5_202(L6_203, L7_204)
    return
  end
  L2_199 = L5_202
  L2_199.isShowAllServer = false
  L5_202(L6_203, L7_204)
  L5_202(L6_203, L7_204)
  for L8_205, L9_206 in L5_202(L6_203) do
    L10_207 = table
    L10_207 = L10_207.insert
    L10_207(A0_197.loggedServerLst, L9_206)
  end
  L2_199 = L5_202
  L2_199.isShowAllServer = true
  L5_202(L6_203, L7_204)
  L5_202(L6_203)
end
function class.GetLoggedServerByIdx(A0_208, A1_209)
  local L2_210
  L2_210 = A0_208.loggedServerLst
  if L2_210 then
    L2_210 = A0_208.loggedServerLst
    L2_210 = L2_210[A1_209]
  else
    L2_210 = L2_210 or ""
  end
  return L2_210
end
function class.GetLoggeServerdAmount(A0_211)
  local L1_212
  L1_212 = A0_211.loggedServerLst
  if nil == L1_212 then
    L1_212 = 0
    return L1_212
  end
  L1_212 = A0_211.loggedServerLst
  L1_212 = #L1_212
  return L1_212
end
function class.GetServerIdxByServer(A0_213, A1_214)
  local L2_215
  L2_215 = A0_213.serverLstMap
  if nil == L2_215 then
    L2_215 = 1
    return L2_215
  end
  L2_215 = A0_213.serverLstMap
  L2_215 = L2_215[A1_214]
  return L2_215
end
function class.SetServerLstMap(A0_216)
  if nil == A0_216.serverLst then
    return
  end
  A0_216.serverLstMap = {}
  for _FORV_4_, _FORV_5_ in pairs(A0_216.serverLst) do
    A0_216.serverLstMap[_FORV_5_.server] = _FORV_4_
  end
end
