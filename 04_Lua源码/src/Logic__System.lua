require("Logic")
module((...), package.seeall)
EXE_VERSION = {INIT_SDK = 3}
class = Logic.class:subclass()
function class.initialize(A0_0)
  super.initialize(A0_0)
  A0_0.recServerTime = 0
  A0_0.recLocalTime = os.time()
  A0_0.strDeviceToken = CVariableSystem:GetSingleton():GetSysVariable(GV_DEVICE_TOKENID) and CVariableSystem:GetSingleton():GetSysVariable(GV_DEVICE_TOKENID) or ""
end
function class.GetTime(A0_1)
  return A0_1.recServerTime + (os.time() - A0_1.recLocalTime)
end
function class.GetTimeDate(A0_2, A1_3)
  A1_3 = A1_3 or A0_2:GetTime()
  return os.date("*t", A1_3)
end
function class.GetTimeStr(A0_4, A1_5, A2_6)
  A1_5 = A1_5 or "%c"
  A2_6 = A2_6 or A0_4:GetTime()
  return os.date(A1_5, A2_6)
end
function class.DiffTime(A0_7, A1_8, A2_9)
  A2_9 = A2_9 or A0_7:GetTime()
  return A1_8 - A2_9
end
function class.GetEndOfDay(A0_10, A1_11)
  A1_11 = A1_11 or A0_10:GetTime()
  return (os.time({
    year = os.date("*t", A1_11).year,
    month = os.date("*t", A1_11).month,
    day = os.date("*t", A1_11).day,
    hour = 23,
    min = 59,
    sec = 59
  }))
end
function class.GetWeekDay(A0_12)
  A0_12:GetTimeDate().day = 1
  return os.date("*t", os.time({
    year = A0_12:GetTimeDate().year,
    month = A0_12:GetTimeDate().month,
    day = A0_12:GetTimeDate().day
  })).wday
end
function class.GetTotalDays(A0_13)
  if A0_13:GetTimeDate().year % 4 == 0 and A0_13:GetTimeDate().year % 100 ~= 0 or A0_13:GetTimeDate().year % 400 == 0 then
    ({
      [1] = 31,
      [2] = 28,
      [3] = 31,
      [4] = 30,
      [5] = 31,
      [6] = 30,
      [7] = 31,
      [8] = 31,
      [9] = 30,
      [10] = 31,
      [11] = 30,
      [12] = 31
    })[2] = 29
  end
  return ({
    [1] = 31,
    [2] = 28,
    [3] = 31,
    [4] = 30,
    [5] = 31,
    [6] = 30,
    [7] = 31,
    [8] = 31,
    [9] = 30,
    [10] = 31,
    [11] = 30,
    [12] = 31
  })[A0_13:GetTimeDate().month]
end
function class.OnPushSystemTime(A0_14, A1_15, A2_16)
  A0_14:OnSystemTime(A1_15, A2_16)
end
function class.OnSystemTime(A0_17, A1_18, A2_19)
  if 0 == A1_18 then
    A0_17.recServerTime = A2_19 / 1000
    A0_17.recLocalTime = os.time()
  end
end
function class.OnRequestDescription(A0_20, A1_21, A2_22)
end
function class.QueryServerTime(A0_23)
  log4misc:warn("TODO: Query Server Time")
end
function class.SecToDay(A0_24, A1_25)
  local L2_26, L3_27
  if A1_25 == nil then
    L2_26 = false
    return L2_26
  end
  L2_26 = {}
  L2_26.day = 0
  L2_26.hour = 0
  L2_26.min = 0
  L2_26.sec = 0
  L3_27 = A1_25
  L2_26.day = math.modf(L3_27 / 86400)
  L3_27 = A1_25 % 86400
  L2_26.hour = math.modf(L3_27 / 3600)
  L3_27 = A1_25 % 3600
  L2_26.min = math.modf(L3_27 / 60)
  L2_26.sec = A1_25 % 60
  return L2_26
end
function class.SetShowOtherPlayer(A0_28, A1_29)
  A0_28.bShowOtherPlayer = A1_29
end
function class.IsShowOtherPlayer(A0_30)
  local L1_31
  L1_31 = A0_30.bShowOtherPlayer
  return L1_31
end
function class.MakeUsrVariableFile(A0_32)
  local L1_33, L2_34, L3_35
  L1_33 = Logic
  L2_34 = L1_33
  L1_33 = L1_33.Get
  L3_35 = "Login"
  L1_33 = L1_33(L2_34, L3_35)
  L2_34 = L1_33
  L1_33 = L1_33.GetLoginInfo
  L1_33 = L1_33(L2_34)
  L1_33 = L1_33.account
  L2_34 = Logic
  L3_35 = L2_34
  L2_34 = L2_34.Get
  L2_34 = L2_34(L3_35, "Login")
  L3_35 = L2_34
  L2_34 = L2_34.GetLoginInfo
  L2_34 = L2_34(L3_35)
  L2_34 = L2_34.server
  if nil == L1_33 or "" == L1_33 or nil == L2_34 or "" == L2_34 then
    L3_35 = log4misc
    L3_35 = L3_35.warn
    L3_35(L3_35, "error make usr config file")
    return
  end
  L3_35 = CMd5
  L3_35 = L3_35(L1_33 .. L2_34)
  L3_35 = L3_35.GetResult
  L3_35 = L3_35(L3_35)
  return string.format("var_%s.xml", L3_35)
end
function class.LoadUsrVariable(A0_36)
  local L1_37
  L1_37 = A0_36.MakeUsrVariableFile
  L1_37 = L1_37(A0_36)
  if nil == L1_37 or "" == L1_37 then
    return
  end
  CVariableSystem:GetSingleton():LoadUsrVariable(L1_37)
end
function class.SaveUsrVariable(A0_38)
  local L1_39
  L1_39 = A0_38.MakeUsrVariableFile
  L1_39 = L1_39(A0_38)
  if nil == L1_39 or "" == L1_39 then
    return
  end
  CVariableSystem:GetSingleton():SaveUsrVariable(L1_39)
end
function class.SaveSysVariable(A0_40)
  CVariableSystem:GetSingleton():SaveSysVariable()
end
function class.GetUniqueId(A0_41)
  return CEnvRoot:GetSingleton():GetUniqueId()
end
function class.GetMacAddr(A0_42)
  if nil == CEnvRoot:GetSingleton().GetMacAddr then
    return A0_42:GetUniqueId()
  end
  return CEnvRoot:GetSingleton():GetMacAddr()
end
function class.GetResVer(A0_43)
  local L1_44, L2_45
  L1_44 = CTwFilePack
  L1_44 = L1_44.Open
  L2_45 = "db/resver.dat"
  L1_44 = L1_44(L2_45)
  if nil ~= L1_44 and "" ~= L1_44 then
    L2_45 = tonumber
    L2_45 = L2_45(L1_44)
  else
    L1_44 = L2_45 or 0
  end
  L2_45 = CVariableSystem
  L2_45 = L2_45.GetSingleton
  L2_45 = L2_45(L2_45)
  L2_45 = L2_45.GetSysVariable
  L2_45 = L2_45(L2_45, GV_RES_VER)
  L2_45 = nil ~= L2_45 and "" ~= L2_45 and tonumber(L2_45) or 0
  return L1_44 > L2_45 and L1_44 or L2_45
end
function class.GetExeVer(A0_46)
  if nil == rawget(_G, "GV_EXE_VER") then
    return 0
  end
  return tonumber(CVariableSystem:GetSingleton():GetSysVariable(GV_EXE_VER)) or 0
end
function class.GetServerVer(A0_47)
  return A0_47:GetMisc("serverVer")
end
function class.GetOperatorId(A0_48)
  return A0_48:GetOperator("operatorId")
end
function class.GetOperatorName(A0_49)
  return A0_49:GetOperator("operatorName")
end
function class.IsOperator(A0_50, A1_51)
  if nil == A0_50:GetOperatorName() then
    return false
  end
  return A0_50:GetOperatorName() == A1_51
end
function class.GetChannel(A0_52)
  local L1_53
  L1_53 = CVariableSystem
  L1_53 = L1_53.GetSingleton
  L1_53 = L1_53(L1_53)
  L1_53 = L1_53.GetSysVariable
  L1_53 = L1_53(L1_53, GV_OPERATORPATH)
  if nil == L1_53 or "" == L1_53 then
    return false
  end
  L1_53 = string.gsub(L1_53, "sdk", "")
  L1_53 = string.gsub(L1_53, "[^%w_]", "")
  return L1_53
end
function class.IsChannel(A0_54, A1_55)
  if nil == A0_54:GetChannel() or "" == A0_54:GetChannel() then
    return false
  end
  return A0_54:GetChannel() == A1_55
end
function class.IsServerLocalVerfy(A0_56, A1_57, A2_58, A3_59)
  if nil == A1_57 or nil == A2_58 or nil == A3_59 then
    return true
  end
  if nil == A0_56:GetOperatorItemFromFile("list", "server.dat") then
    return true
  end
  for _FORV_8_ = 1, #A0_56:GetOperatorItemFromFile("list", "server.dat") do
    if nil ~= A0_56:GetOperatorItemFromFile("list", "server.dat")[_FORV_8_] and A1_57 == A0_56:GetOperatorItemFromFile("list", "server.dat")[_FORV_8_].server and A2_58 == A0_56:GetOperatorItemFromFile("list", "server.dat")[_FORV_8_].addr and A3_59 == A0_56:GetOperatorItemFromFile("list", "server.dat")[_FORV_8_].port then
      if nil == A0_56:GetOperatorItemFromFile("list", "server.dat")[_FORV_8_].localVerfy then
        return true
      end
      return 0 ~= A0_56:GetOperatorItemFromFile("list", "server.dat")[_FORV_8_].localVerfy
    end
  end
  return _FOR_
end
function class.GetSaltFilePath(A0_60)
  local L1_61
  L1_61 = CVariableSystem
  L1_61 = L1_61.GetSingleton
  L1_61 = L1_61(L1_61)
  L1_61 = L1_61.GetSysVariable
  L1_61 = L1_61(L1_61, GV_OPERATORPATH)
  if nil == L1_61 or "" == L1_61 then
    return ""
  end
  return L1_61 .. "salt.dat"
end
function class.IsSelfAccUI(A0_62)
  return nil ~= A0_62:GetOperator("accUI") and 0 ~= A0_62:GetOperator("accUI")
end
function class.IsSelfAccLogin(A0_63)
  return nil ~= A0_63:GetOperator("accLogin") and 0 ~= A0_63:GetOperator("accLogin")
end
function class.IsAnonymityLogin(A0_64)
  return nil ~= A0_64:GetOperator("anonymityLogin") and 0 ~= A0_64:GetOperator("anonymityLogin")
end
function class.IsCloseCharge(A0_65)
  return nil ~= A0_65:GetMisc("closeCharge") and 0 ~= A0_65:GetMisc("closeCharge")
end
function class.IsCanDelAccount(A0_66)
  return nil ~= A0_66:GetMisc("delAccount") and 0 ~= A0_66:GetMisc("delAccount")
end
function class.IsCloseAutoLogin(A0_67)
  return nil ~= A0_67:GetMisc("closeAutoLogin") and 0 ~= A0_67:GetMisc("closeAutoLogin")
end
function class.IsShowVersion(A0_68)
  return nil ~= A0_68:GetMisc("showVersion") and 0 ~= A0_68:GetMisc("showVersion")
end
function class.isOtherAccount(A0_69)
  return 1 == A0_69:GetMisc("otherAccount")
end
function class.IsUseShowPrice(A0_70)
  return nil ~= A0_70:GetMisc("useShowPrice") and 0 ~= A0_70:GetMisc("useShowPrice")
end
function class.GetCallBoardURL(A0_71)
  local L1_72, L2_73, L3_74, L4_75
  L2_73 = A0_71
  L1_72 = A0_71.GetMisc
  L3_74 = "serverLst"
  L1_72 = L1_72(L2_73, L3_74)
  if nil ~= L1_72 then
    L2_73 = L1_72.host
  elseif nil == L2_73 then
    return
  end
  L3_74 = A0_71
  L2_73 = A0_71.GetMisc
  L4_75 = "callBoardUrl"
  L2_73 = L2_73(L3_74, L4_75)
  L4_75 = A0_71
  L3_74 = A0_71.GetOperatorId
  L3_74 = L3_74(L4_75)
  L4_75 = A0_71.GetOperatorName
  L4_75 = L4_75(A0_71)
  if nil == L2_73 or nil == L3_74 or nil == L4_75 then
    return
  end
  if A0_71:IsOperator("movefun") then
    return "http://" .. L2_73
  end
  return A0_71:GetServerHTTPURL(string.format(L2_73, L3_74, L4_75))
end
function class.GetServerHTTPURL(A0_76, A1_77)
  local L2_78, L3_79, L4_80
  L3_79 = A0_76
  L2_78 = A0_76.GetMisc
  L4_80 = "serverLst"
  L2_78 = L2_78(L3_79, L4_80)
  if nil ~= L2_78 then
    L3_79 = L2_78.host
  elseif nil == L3_79 then
    return
  end
  L3_79 = tostring
  L4_80 = L2_78.host
  L3_79 = L3_79(L4_80)
  L4_80 = tonumber
  L4_80 = L4_80(L2_78.port or 80)
  if L3_79 == "43.240.74.93" then
    L4_80 = 18080
  end
  if L4_80 and L4_80 > 0 and L4_80 ~= 80 then
    L3_79 = L3_79 .. ":" .. tostring(L4_80)
  end
  A1_77 = tostring(A1_77 or "")
  if string.sub(A1_77, 1, 1) ~= "/" then
    A1_77 = "/" .. A1_77
  end
  return "http://" .. L3_79 .. A1_77
end
function class.IsHideAutoPatch(A0_81)
  return nil ~= Logic:Get("System"):GetMisc("HideAutoPatch") and 0 ~= Logic:Get("System"):GetMisc("HideAutoPatch")
end
function class.IsSendPlayerInfo(A0_82)
  return nil ~= A0_82:GetMisc("sendPlayerInfo") and 0 ~= A0_82:GetMisc("sendPlayerInfo")
end
function class.GetMisc(A0_83, A1_84)
  return A0_83:GetOperatorItemFromFile(A1_84, "misc.dat")
end
function class.GetOperator(A0_85, A1_86)
  return A0_85:GetOperatorItemFromFile(A1_86, "operator.dat")
end
function class.GetOperatorItemFromFile(A0_87, A1_88, A2_89)
  local L3_90, L4_91
  if nil ~= A1_88 then
    L3_90 = type
    L4_91 = A1_88
    L3_90 = L3_90(L4_91)
  elseif "string" ~= L3_90 then
    L3_90 = nil
    return L3_90
  end
  if nil ~= A2_89 then
    L3_90 = type
    L4_91 = A2_89
    L3_90 = L3_90(L4_91)
  elseif "string" ~= L3_90 then
    L3_90 = nil
    return L3_90
  end
  L3_90 = CVariableSystem
  L4_91 = L3_90
  L3_90 = L3_90.GetSingleton
  L3_90 = L3_90(L4_91)
  L4_91 = L3_90
  L3_90 = L3_90.GetSysVariable
  L3_90 = L3_90(L4_91, GV_OPERATORPATH)
  if nil == L3_90 or "" == L3_90 then
    L4_91 = nil
    return L4_91
  end
  L4_91 = CTwFilePack
  L4_91 = L4_91.Open
  L4_91 = L4_91(L3_90 .. A2_89)
  if nil == L4_91 or "" == L4_91 then
    return nil
  end
  L4_91 = CTwUtil:GetSingleton():Decrypt(L4_91)
  if nil == L4_91 then
    return nil
  end
  if not pcall(function()
    _UPVALUE0_ = json.decode(_UPVALUE1_)
  end) then
    return
  end
  if nil == nil then
    return nil
  end
  return (nil)[A1_88]
end
function class.GetDriveSize(A0_92)
  if CCDirector:sharedDirector():getOpenGLView() then
    return CCDirector:sharedDirector():getOpenGLView():getFrameSize()
  end
  return nil
end
function class.SetDeviceToken(A0_93, A1_94, A2_95)
  if A1_94 == DEVICE_TOKEN_REGISTER and nil ~= A2_95 then
    A0_93.strDeviceToken = string.gsub(A2_95, "[<> ]", "")
    CVariableSystem:GetSingleton():SetSysVariable(GV_DEVICE_TOKENID, A0_93.strDeviceToken)
    A0_93:SaveSysVariable()
  end
end
function class.GetDeviceToken(A0_96)
  local L1_97
  L1_97 = A0_96.strDeviceToken
  return L1_97
end
function class.GetServerDeviceType(A0_98)
  if CTwUtil.E_TP_MAC == CTwUtil:GetPlatform() then
    return TypeDef("com.eyu.mt.module.account.model.DeviceType").IOS
  elseif CTwUtil.E_TP_ANDROID == CTwUtil:GetPlatform() then
    return TypeDef("com.eyu.mt.module.account.model.DeviceType").ANDROID
  end
  return TypeDef("com.eyu.mt.module.account.model.DeviceType").WIN
end
function class.SetUsrVariableMisc(A0_99, A1_100, A2_101)
  A0_99:SetVariableMisc(A1_100, A2_101)
  A0_99:SaveUsrVariable()
end
function class.GetUsrVariableMisc(A0_102, A1_103)
  return A0_102:GetVariableMisc(A1_103)
end
function class.SetSysVariableMisc(A0_104, A1_105, A2_106)
  A0_104:SetVariableMisc(A1_105, A2_106, true)
  A0_104:SaveSysVariable()
end
function class.GetSysVariableMisc(A0_107, A1_108)
  return A0_107:GetVariableMisc(A1_108, true)
end
function class.IsUpgradeAniEnabled(A0_109)
  return A0_109:GetSysVariableMisc("GV_PLAY_UPGRADE_ANI") ~= "0" and A0_109:GetSysVariableMisc("GV_PLAY_UPGRADE_ANI") ~= 0
end
function class.SetVariableMisc(A0_110, A1_111, A2_112, A3_113)
  local L4_114, L5_115, L6_116, L7_117, L8_118, L9_119
  if A1_111 == nil then
    return
  end
  if A3_113 then
    L4_114 = "GetSysVariable"
  else
    L4_114 = L4_114 or "GetUsrVariable"
  end
  if A3_113 then
    L5_115 = "SetSysVariable"
  else
    L5_115 = L5_115 or "SetUsrVariable"
  end
  if A3_113 then
    L6_116 = GV_MISC
  else
    L6_116 = L6_116 or UV_MISC
  end
  L7_117 = CVariableSystem
  L8_118 = L7_117
  L7_117 = L7_117.GetSingleton
  L7_117 = L7_117(L8_118)
  L8_118 = L7_117[L4_114]
  L9_119 = L7_117
  L8_118 = L8_118(L9_119, L6_116)
  if L8_118 then
    L9_119 = #L8_118
  else
    if L9_119 == 0 then
      L9_119 = {}
  end
  elseif not L9_119 then
    L9_119 = json
    L9_119 = L9_119.decode
    L9_119 = L9_119(L8_118)
  end
  L9_119 = L9_119 or {}
  L9_119[A1_111] = A2_112
  L8_118 = json.encode(L9_119)
  L7_117[L5_115](L7_117, L6_116, L8_118)
end
function class.GetVariableMisc(A0_120, A1_121, A2_122)
  local L3_123, L4_124, L5_125, L6_126, L7_127
  if A1_121 == nil then
    L3_123 = nil
    return L3_123
  end
  if A2_122 then
    L3_123 = "GetSysVariable"
  else
    L3_123 = L3_123 or "GetUsrVariable"
  end
  if A2_122 then
    L4_124 = GV_MISC
  else
    L4_124 = L4_124 or UV_MISC
  end
  L5_125 = CVariableSystem
  L6_126 = L5_125
  L5_125 = L5_125.GetSingleton
  L5_125 = L5_125(L6_126)
  L6_126 = L5_125[L3_123]
  L7_127 = L5_125
  L6_126 = L6_126(L7_127, L4_124)
  if L6_126 then
    L7_127 = #L6_126
  else
    if L7_127 == 0 then
      L7_127 = {}
  end
  elseif not L7_127 then
    L7_127 = json
    L7_127 = L7_127.decode
    L7_127 = L7_127(L6_126)
  end
  L7_127 = L7_127 or {}
  return L7_127[A1_121]
end
function class.GetMoneyStr(A0_128, A1_129)
  local L2_130, L3_131, L4_132, L5_133, L6_134
  L2_130 = tonumber
  L3_131 = A1_129
  L2_130 = L2_130(L3_131)
  A1_129 = L2_130 or 0
  L2_130 = math
  L2_130 = L2_130.modf
  L3_131 = A1_129
  L3_131 = L2_130(L3_131)
  L4_132 = tostring
  L5_133 = math
  L5_133 = L5_133.abs
  L5_133 = L5_133(L6_134)
  L4_132 = L4_132(L5_133, L6_134, L5_133(L6_134))
  L2_130 = L4_132
  if L3_131 ~= 0 then
    L4_132 = tostring
    L5_133 = math
    L5_133 = L5_133.abs
    L5_133 = L5_133(L6_134)
    L4_132 = L4_132(L5_133, L6_134, L5_133(L6_134))
  else
    L3_131 = L4_132 or ""
  end
  L4_132 = #L2_130
  L5_133 = ""
  for _FORV_9_ = L4_132, 1, -1 do
    L5_133 = L2_130[_FORV_9_] .. L5_133
    if (L4_132 - _FORV_9_ + 1) % 3 == 0 and _FORV_9_ ~= L4_132 and _FORV_9_ ~= 1 then
      L5_133 = "," .. L5_133
    end
  end
  if A1_129 < 0 then
  else
  end
  return L6_134 .. L5_133 .. string.sub(L3_131, 2, 4)
end
function class.IsPkgUpdateWifiTip(A0_135)
  return nil == A0_135:GetMisc("pkgUpdateWifiTip") or 1 == A0_135:GetMisc("pkgUpdateWifiTip")
end
function class.GetPayRefreshDelayTime(A0_136)
  return A0_136:GetMisc("payRefreshDelayTime") or 0
end
function class.IsPayBackTip(A0_137)
  return nil == A0_137:GetMisc("payBackTip") or 1 == A0_137:GetMisc("payBackTip")
end
function class.IsUseCombineOrderId(A0_138)
  return nil ~= A0_138:GetMisc("useCombineOrderId") and 1 == A0_138:GetMisc("useCombineOrderId")
end
function class.GetIdfa(A0_139)
  if not Logic:Get("System"):IsOperator("appstore") then
    return
  end
  if CTwUtil.E_TP_MAC ~= CTwUtil:GetPlatform() then
    return
  end
  return CEnvRoot:GetSingleton():GetIdfa()
end
function class.SetKorAppUserId(A0_140, A1_141)
  A0_140.korAppUserId = A1_141
end
function class.GetKorAppUserId(A0_142)
  local L1_143
  L1_143 = A0_142.korAppUserId
  return L1_143
end
function class.GetFacebookShareLink(A0_144)
  return A0_144:GetMisc("facebookShareLink") or TwGetStr(10148)
end
function class.ShareFaceBook(A0_145, A1_146)
  local L2_147, L3_148
  L3_148 = A0_145
  L2_147 = A0_145.IsOpenFaceBook
  L2_147 = L2_147(L3_148)
  if not L2_147 then
    return
  end
  L2_147 = {}
  L2_147.caption = ""
  L2_147.description = ""
  L3_148 = TwGetStr
  L3_148 = L3_148(10147)
  L2_147.name = L3_148
  L3_148 = A0_145.GetFacebookShareLink
  L3_148 = L3_148(A0_145)
  L2_147.link = L3_148
  L2_147.text = A1_146
  L3_148 = TwGetStr
  L3_148 = L3_148(10149)
  L2_147.url = L3_148
  L3_148 = TwReflectEvtArgs
  L3_148 = L3_148(REFLECT_EVENT_FB_SHARE, 0, 0, json.encode(L2_147))
  CReflectSystem:GetSingleton():FireEvent(L3_148)
end
function class.IsOpenFaceBook(A0_149)
  return 1 == A0_149:GetMisc("isOpenFaceBook")
end
function class.IsCloseServerMusic(A0_150)
  return nil ~= A0_150:GetMisc("closeServerMusic") and 0 ~= A0_150:GetMisc("closeServerMusic")
end
function class.GetAutoPatch(A0_151)
  if nil ~= A0_151:GetOperatorItemFromFile("server", "autopatch.dat") and "" ~= A0_151:GetOperatorItemFromFile("server", "autopatch.dat") then
    return (A0_151:GetOperatorItemFromFile("server", "autopatch.dat"))
  end
  return A0_151:GetMisc("AutoPatch")
end
function class.GetLockBuyUITime(A0_152)
  return (A0_152:GetMisc("lockBuyUITime"))
end
function class.GetPhoneFeeSetting(A0_153)
  return A0_153:GetMisc("PhoneFee")
end
function class.GetUserAgreement(A0_154)
  return A0_154:GetMisc("userAgreement")
end
function class.SetAvaliableStorageSize(A0_155, A1_156)
  A0_155.avaliableSize = A1_156
end
function class.GetAvaliableStorageSize(A0_157)
  local L1_158
  L1_158 = A0_157.avaliableSize
  return L1_158
end
