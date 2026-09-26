module((...), package.seeall)
class = Logic.class:subclass()
function class.initialize(A0_0)
  super.initialize(A0_0)
end
function class.OnReset(A0_1)
  local L1_2
end
function class.OnDestory(A0_3)
  local L1_4
end
function class.Login(A0_5, A1_6, A2_7, A3_8)
  local L4_9, L5_10
  A1_6 = A1_6 or ""
  A2_7 = A2_7 or ""
  L4_9 = {}
  L4_9.username = A1_6
  L4_9.password = A2_7
  L4_9.type = "login"
  L4_9.extParam = A3_8
  L5_10 = json
  L5_10 = L5_10.encode
  L5_10 = L5_10(L4_9)
  CReflectSystem:GetSingleton():FireEvent(TwReflectEvtArgs(REFLECT_EVENT_LOGIN, 0, 0, L5_10))
end
function class.Regist(A0_11, A1_12, A2_13, A3_14)
  local L4_15, L5_16
  A1_12 = A1_12 or ""
  A2_13 = A2_13 or ""
  A3_14 = A3_14 or ""
  L4_15 = {}
  L4_15.username = A1_12
  L4_15.password = A2_13
  L4_15.email = A3_14
  L4_15.type = "regist"
  L5_16 = json
  L5_16 = L5_16.encode
  L5_16 = L5_16(L4_15)
  CReflectSystem:GetSingleton():FireEvent(TwReflectEvtArgs(REFLECT_EVENT_LOGIN, 0, 0, L5_16))
end
function class.AccountCrypto(A0_17, A1_18)
  if type(A1_18) ~= "table" then
    return
  end
  A1_18.type = "accountCrypto"
  CReflectSystem:GetSingleton():FireEvent(TwReflectEvtArgs(REFLECT_EVENT_LOGIN, 0, 0, json.encode(A1_18)))
end
function class.DiscardAccountCrypto(A0_19, A1_20)
  A0_19:AccountCrypto({
    action = "discard",
    token = A1_20 or ""
  })
end
function class.BuildTcpLoginProof(A0_21, A1_22)
  if type(A1_22) ~= "table" then
    return
  end
  A1_22.type = "tcpLoginProof"
  CReflectSystem:GetSingleton():FireEvent(TwReflectEvtArgs(REFLECT_EVENT_LOGIN, 0, 0, json.encode(A1_22)))
end
function class.ClearAccountCrypto(A0_23)
  local L1_24
  L1_24 = {}
  L1_24.type = "accountCryptoClear"
  CReflectSystem:GetSingleton():FireEvent(TwReflectEvtArgs(REFLECT_EVENT_LOGIN, 0, 0, json.encode(L1_24)))
end
function class.AnonymityLogin(A0_25, A1_26, A2_27)
  local L3_28, L4_29
  A1_26 = A1_26 or ""
  A2_27 = A2_27 or ""
  L3_28 = {}
  L3_28.username = A1_26
  L3_28.password = A2_27
  L3_28.type = "anonymityLogin"
  L4_29 = json
  L4_29 = L4_29.encode
  L4_29 = L4_29(L3_28)
  CReflectSystem:GetSingleton():FireEvent(TwReflectEvtArgs(REFLECT_EVENT_LOGIN, 0, 0, L4_29))
end
function class.BindAccount(A0_30, A1_31, A2_32, A3_33, A4_34)
  local L5_35, L6_36
  L5_35 = {}
  L5_35.username = A1_31
  L5_35.password = A2_32
  L5_35.oldUser = A3_33
  L5_35.serverId = A4_34
  L6_36 = json
  L6_36 = L6_36.encode
  L6_36 = L6_36(L5_35)
  CReflectSystem:GetSingleton():FireEvent(TwReflectEvtArgs(REFLECT_EVENT_BIND_ACCOUNT, 0, 0, L6_36))
end
function class.LoginComplete(A0_37)
  local L1_38, L2_39, L3_40, L4_41, L5_42
  L1_38 = Logic
  L2_39 = L1_38
  L1_38 = L1_38.Get
  L3_40 = "Sdk"
  L1_38 = L1_38(L2_39, L3_40)
  L2_39 = L1_38
  L1_38 = L1_38.CheckSdkFuncOpen
  L3_40 = "combineLoginCompParam"
  L1_38 = L1_38(L2_39, L3_40)
  L2_39 = Logic
  L3_40 = L2_39
  L2_39 = L2_39.Get
  L4_41 = "System"
  L2_39 = L2_39(L3_40, L4_41)
  L3_40 = L2_39
  L2_39 = L2_39.GetTime
  L2_39 = L2_39(L3_40)
  L3_40 = L2_39
  L4_41 = CTwUtil
  L5_42 = L4_41
  L4_41 = L4_41.GetPlatform
  L4_41 = L4_41(L5_42)
  if not L1_38 then
    L5_42 = CTwUtil
    L5_42 = L5_42.E_TP_MAC
  elseif L5_42 == L4_41 then
    L5_42 = {}
    L5_42.time = L2_39
    if Logic:Get("Login"):GetLoginInfo() then
      L5_42.userName, L5_42.accountId = Logic:Get("PlayerInfo"):GetPlayerName() or "", Logic:Get("Login"):GetLoginInfo().account
      L5_42.serverId = Logic:Get("Login"):GetLoginInfo().server
      L5_42.PlayerLevel, L5_42.isFirstLogin, L5_42.serverName = Logic:Get("PlayerInfo"):GetPlayerLevel(), Logic:Get("Login"):GetIsCreateRole(), Logic:Get("Login"):GetLoginInfo().name
    end
    L3_40 = json.encode(L5_42)
  end
  L5_42 = CReflectSystem
  L5_42 = L5_42.GetSingleton
  L5_42 = L5_42(L5_42)
  L5_42 = L5_42.FireEvent
  L5_42(L5_42, TwReflectEvtArgs(REFLECT_EVENT_LOGIN_COMPLETE, 0, 0, L3_40))
end
function class.Logout(A0_43)
  A0_43:ClearAccountCrypto()
  CReflectSystem:GetSingleton():FireEvent(TwEvtArgs(REFLECT_EVENT_LOGOUT))
end
function class.DelAccount(A0_44)
  CReflectSystem:GetSingleton():FireEvent(TwReflectEvtArgs(REFLECT_EVENT_DEL_ACCOUNT, 0, 0, ""))
end
function class.QueryServerLst(A0_45, A1_46)
  A1_46 = A1_46 or ""
  CReflectSystem:GetSingleton():FireEvent(TwReflectEvtArgs(REFLECT_EVENT_QUERY_SERVERLST, 0, 0, A1_46))
end
function class.ExitGame(A0_47)
  CReflectSystem:GetSingleton():FireEvent(TwEvtArgs(REFLECT_EVENT_EXIT))
end
function class.Recharge(A0_48, A1_49)
  local L2_50
  L2_50 = TwReflectEvtArgs
  L2_50 = L2_50(REFLECT_EVENT_PAY, 0, 0, A1_49)
  CReflectSystem:GetSingleton():FireEvent(L2_50)
end
function class.OpenUrl(A0_51, A1_52)
  local L2_53
  L2_53 = IsDevMode
  L2_53 = L2_53()
  if L2_53 then
    L2_53 = CTwUtil
    L2_53 = L2_53.GetPlatform
    L2_53 = L2_53(L2_53)
    if L2_53 == CTwUtil.E_TP_WIN32 then
    end
  elseif A1_52 ~= nil and A1_52 ~= "" then
    L2_53 = TwReflectEvtArgs
    L2_53 = L2_53(REFLECT_EVENT_OPEN_URL, 0, 0, A1_52)
    CReflectSystem:GetSingleton():FireEvent(L2_53)
  end
end
function class.OpenUrlRectType(A0_54, A1_55, A2_56)
  local L3_57, L4_58, L5_59, L6_60, L7_61, L8_62, L9_63, L10_64, L11_65, L12_66
  L3_57 = {}
  L4_58 = A2_56[1]
  L3_57.x = L4_58
  L4_58 = A2_56[2]
  L3_57.y = L4_58
  L4_58 = {}
  L5_59 = A2_56[3]
  L4_58.width = L5_59
  L5_59 = A2_56[4]
  L4_58.height = L5_59
  L5_59 = CCDirector
  L6_60 = L5_59
  L5_59 = L5_59.sharedDirector
  L5_59 = L5_59(L6_60)
  L6_60 = L5_59
  L5_59 = L5_59.getOpenGLView
  L5_59 = L5_59(L6_60)
  L7_61 = L5_59
  L6_60 = L5_59.getDesignResolutionSize
  L6_60 = L6_60(L7_61)
  L8_62 = L5_59
  L7_61 = L5_59.getFrameSize
  L7_61 = L7_61(L8_62)
  L8_62 = L7_61.width
  L9_63 = L6_60.width
  L8_62 = L8_62 / L9_63
  L9_63 = L7_61.height
  L10_64 = L6_60.height
  L9_63 = L9_63 / L10_64
  L10_64 = math
  L10_64 = L10_64.min
  L11_65 = L8_62
  L12_66 = L9_63
  L10_64 = L10_64(L11_65, L12_66)
  L11_65 = L3_57.x
  L11_65 = L11_65 * L10_64
  L12_66 = math
  L12_66 = L12_66.abs
  L12_66 = L12_66(L6_60.width * L10_64 - L7_61.width)
  L12_66 = L12_66 * 0.5
  L11_65 = L11_65 + L12_66
  L3_57.x = L11_65
  L11_65 = L3_57.y
  L11_65 = L11_65 * L10_64
  L12_66 = math
  L12_66 = L12_66.abs
  L12_66 = L12_66(L6_60.height * L10_64 - L7_61.height)
  L12_66 = L12_66 * 0.5
  L11_65 = L11_65 + L12_66
  L3_57.y = L11_65
  L11_65 = L4_58.width
  L11_65 = L11_65 * L10_64
  L4_58.width = L11_65
  L11_65 = L4_58.height
  L11_65 = L11_65 * L10_64
  L4_58.height = L11_65
  L11_65 = {}
  L11_65.url = A1_55
  L12_66 = L3_57.x
  L11_65.x = L12_66
  L12_66 = L3_57.y
  L11_65.y = L12_66
  L12_66 = L4_58.width
  L11_65.width = L12_66
  L12_66 = L4_58.height
  L11_65.height = L12_66
  L12_66 = IsDevMode
  L12_66 = L12_66()
  if L12_66 then
    L12_66 = CTwUtil
    L12_66 = L12_66.GetPlatform
    L12_66 = L12_66(L12_66)
    if L12_66 == CTwUtil.E_TP_WIN32 then
    end
  elseif A1_55 ~= nil and A1_55 ~= "" then
    L12_66 = TwReflectEvtArgs
    L12_66 = L12_66(REFLECT_EVENT_OPEN_URL, 0, 0, json.encode(L11_65))
    CReflectSystem:GetSingleton():FireEvent(L12_66)
  end
end
function class.SetKeepScreenOnState(A0_67, A1_68)
  local L2_69
  L2_69 = TwReflectEvtArgs
  L2_69 = L2_69(REFLECT_EVENT_KEEP_SCREEN_ON, A1_68)
  CReflectSystem:GetSingleton():FireEvent(L2_69)
end
function class.WeiboShare(A0_70, A1_71, A2_72)
  local L3_73, L4_74, L5_75, L6_76
  if A1_71 ~= "sina" and A1_71 ~= "tecent" then
    return
  end
  L3_73 = KFDBGetRecordByPT
  L4_74 = A1_71
  L3_73 = L3_73(L4_74)
  if nil == L3_73 then
    return
  end
  L4_74 = {}
  L4_74.platform = L3_73
  L4_74.content = A2_72
  L5_75 = json
  L5_75 = L5_75.encode
  L6_76 = L4_74
  L5_75 = L5_75(L6_76)
  L6_76 = TwReflectEvtArgs
  L6_76 = L6_76(REFLECT_EVENT_WEIBO_SHARE, 0, 0, L5_75)
  CReflectSystem:GetSingleton():FireEvent(L6_76)
end
function class.OpenUrlInRect(A0_77, A1_78, A2_79)
  local L3_80, L4_81, L5_82, L6_83, L7_84, L8_85, L9_86, L10_87, L11_88
  L3_80 = {}
  L4_81 = A2_79[1]
  L3_80.x = L4_81
  L4_81 = A2_79[2]
  L3_80.y = L4_81
  L4_81 = {}
  L5_82 = A2_79[3]
  L4_81.width = L5_82
  L5_82 = A2_79[4]
  L4_81.height = L5_82
  L5_82 = CCDirector
  L6_83 = L5_82
  L5_82 = L5_82.sharedDirector
  L5_82 = L5_82(L6_83)
  L6_83 = L5_82
  L5_82 = L5_82.getOpenGLView
  L5_82 = L5_82(L6_83)
  L7_84 = L5_82
  L6_83 = L5_82.getDesignResolutionSize
  L6_83 = L6_83(L7_84)
  L8_85 = L5_82
  L7_84 = L5_82.getFrameSize
  L7_84 = L7_84(L8_85)
  L8_85 = L7_84.width
  L9_86 = L6_83.width
  L8_85 = L8_85 / L9_86
  L9_86 = L7_84.height
  L10_87 = L6_83.height
  L9_86 = L9_86 / L10_87
  L10_87 = math
  L10_87 = L10_87.min
  L11_88 = L8_85
  L10_87 = L10_87(L11_88, L9_86)
  L11_88 = L3_80.x
  L11_88 = L11_88 * L10_87
  L11_88 = L11_88 + math.abs(L6_83.width * L10_87 - L7_84.width) * 0.5
  L3_80.x = L11_88
  L11_88 = L3_80.y
  L11_88 = L11_88 * L10_87
  L11_88 = L11_88 + math.abs(L6_83.height * L10_87 - L7_84.height) * 0.5
  L3_80.y = L11_88
  L11_88 = L4_81.width
  L11_88 = L11_88 * L10_87
  L4_81.width = L11_88
  L11_88 = L4_81.height
  L11_88 = L11_88 * L10_87
  L4_81.height = L11_88
  L11_88 = {}
  L11_88.url = A1_78
  L11_88.x = L3_80.x
  L11_88.y = L3_80.y
  L11_88.width = L4_81.width
  L11_88.height = L4_81.height
  CReflectSystem:GetSingleton():FireEvent(TwReflectEvtArgs(REFLECT_EVENT_OPEN_URL_IN_RECT, 0, 0, json.encode(L11_88)))
end
function class.OpenCallBoard(A0_89, A1_90, A2_91)
  local L3_92, L4_93
  L3_92 = IsDevMode
  L3_92 = L3_92()
  if L3_92 then
    L3_92 = CTwUtil
    L4_93 = L3_92
    L3_92 = L3_92.GetPlatform
    L3_92 = L3_92(L4_93)
    L4_93 = CTwUtil
    L4_93 = L4_93.E_TP_WIN32
    if L3_92 == L4_93 then
    end
  elseif A1_90 ~= nil and A1_90 ~= "" then
    A2_91.url = A1_90
    L3_92 = json
    L3_92 = L3_92.encode
    L4_93 = A2_91
    L3_92 = L3_92(L4_93)
    L4_93 = TwReflectEvtArgs
    L4_93 = L4_93(REFLECT_EVENT_CALLBOARD, 0, 0, L3_92)
    CReflectSystem:GetSingleton():FireEvent(L4_93)
  end
end
function class.CloseCallboard(A0_94)
  CReflectSystem:GetSingleton():FireEvent(TwReflectEvtArgs(REFLECT_EVENT_CLOSE_CALLBOARD))
end
function class.CloseWebPage(A0_95)
  CReflectSystem:GetSingleton():FireEvent(TwReflectEvtArgs(REFLECT_EVENT_CLOSE_WEBPAGE))
end
function class.EnterPlatform(A0_96, A1_97)
  A1_97 = A1_97 or ""
  CReflectSystem:GetSingleton():FireEvent(TwReflectEvtArgs(REFLECT_EVENT_ENTER_PLATFORM, 0, 0, A1_97))
end
function class.CheckPackageUpdate(A0_98)
  local L1_99, L2_100, L3_101, L4_102, L5_103, L6_104, L7_105, L8_106, L9_107, L10_108, L11_109
  L2_100 = A0_98
  L1_99 = A0_98.GetUpdateInfo
  L1_99 = L1_99(L2_100)
  L2_100 = L1_99.dateOk
  if L2_100 == false then
    return
  end
  L2_100 = L1_99.autoPatch
  L3_101 = L1_99.operatorId
  L4_102 = L1_99.operatorName
  L5_103 = L1_99.deviceName
  L6_104 = "http://"
  L7_105 = L2_100.host
  L8_106 = string
  L8_106 = L8_106.format
  L9_107 = L2_100.packageAct
  L10_108 = L2_100.productName
  L11_109 = L3_101
  L8_106 = L8_106(L9_107, L10_108, L11_109, L4_102, L5_103)
  L6_104 = L6_104 .. L7_105 .. L8_106
  L7_105 = L2_100.downPackageAct
  if nil ~= L7_105 then
    L7_105 = "http://"
    L8_106 = L2_100.downHost
    L9_107 = L2_100.downPackageAct
    L7_105 = L7_105 .. L8_106 .. L9_107
  else
    L7_105 = L7_105 or ""
  end
  L8_106 = L2_100.timeOut
  if nil ~= L8_106 then
    L8_106 = L2_100.timeOut
  else
    L8_106 = L8_106 or "0"
  end
  L9_107 = {}
  L9_107.versionUrl = L6_104
  L9_107.downUrl = L7_105
  L9_107.timeOut = L8_106
  L10_108 = json
  L10_108 = L10_108.encode
  L11_109 = L9_107
  L10_108 = L10_108(L11_109)
  L11_109 = TwReflectEvtArgs
  L11_109 = L11_109(REFLECT_EVENT_CHECK_UPDATE, 0, 0, L10_108)
  CReflectSystem:GetSingleton():FireEvent(L11_109)
end
function class.GetUpdateInfo(A0_110)
  local L1_111
  L1_111 = {}
  if nil == Logic:Get("System"):GetAutoPatch() or nil == Logic:Get("System"):GetAutoPatch().host or nil == Logic:Get("System"):GetAutoPatch().downHost or nil == Logic:Get("System"):GetAutoPatch().packageAct or nil == Logic:Get("System"):GetAutoPatch().productName then
    L1_111.dateOk = false
    return L1_111
  end
  L1_111.autoPatch = Logic:Get("System"):GetAutoPatch()
  if nil == Logic:Get("System"):GetOperatorName() or nil == Logic:Get("System"):GetOperatorId() then
    L1_111.dateOk = false
    return L1_111
  end
  L1_111.operatorName, L1_111.operatorId = Logic:Get("System"):GetOperatorName(), Logic:Get("System"):GetOperatorId()
  if nil == KFDBGetRecordByPT("deviceName") then
    L1_111.dateOk = false
    return L1_111
  end
  L1_111.deviceName = KFDBGetRecordByPT("deviceName")
  L1_111.dateOk = true
  return L1_111
end
function class.SendPlayerInfo(A0_112, A1_113)
  if nil == A1_113 or type(A1_113) ~= "string" then
    return
  end
  CReflectSystem:GetSingleton():FireEvent(TwReflectEvtArgs(REFLECT_EVENT_SEND_PLAYER_INFO, 0, 0, A1_113))
end
function class.PopAdvert(A0_114)
  if rawget(_G, "REFLECT_EVENT_POP_ADVERT") ~= nil then
    CReflectSystem:GetSingleton():FireEvent(TwReflectEvtArgs(REFLECT_EVENT_POP_ADVERT, 0, 0, ""))
  end
end
function class.CheckFuncExist(A0_115, A1_116)
  local L2_117
  if nil == A1_116 then
    L2_117 = false
    return L2_117
  end
  L2_117 = rawget
  L2_117 = L2_117(_G, A1_116)
  if nil == L2_117 then
    return false
  end
  if nil == CReflectSystem:GetSingleton().FindEventFunc then
    return false
  end
  return CReflectSystem:GetSingleton():FindEventFunc(L2_117)
end
