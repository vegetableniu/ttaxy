local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = Logic
L0_0 = L0_0.class
L0_0 = L0_0.subclass
L0_0 = L0_0(L0_0)
class = L0_0
L0_0 = 1
EVT = {ENTER_SELSERVER = 1}
function class.initialize(A0_1, ...)
  local L3_3, L4_4
  L3_3 = super
  L3_3 = L3_3.initialize
  L4_4 = A0_1
  L3_3(L4_4, ...)
end
function class.OnReset(A0_5)
  local L1_6
end
function class.OnDestory(A0_7)
  local L1_8
end
function class.OnConfirmRestart(A0_9, A1_10)
  if A1_10 == Prompt.RET.OK then
    A0_9:StartQuery()
  else
    Logic:Get("EnvLogic"):ExitGame()
  end
end
function class.OnConfirmRedown(A0_11, A1_12)
  if A1_12 == Prompt.RET.OK then
    A0_11:DownloadVersion(A0_11.resData[A0_11.curDown])
  else
    Logic:Get("EnvLogic"):ExitGame()
  end
end
function class.OnConfirmCheckPackage(A0_13, A1_14)
  if A1_14 == Prompt.RET.OK then
    Logic:Get("EnvLogic"):CheckPackageUpdate()
  else
    Logic:Get("EnvLogic"):ExitGame()
  end
end
function class.StartQuery(A0_15)
  local L1_16, L2_17, L3_18, L4_19, L5_20, L6_21, L7_22, L8_23
  L2_17 = A0_15
  L1_16 = A0_15.EventTracer
  L1_16 = L1_16(L2_17)
  L2_17 = L1_16
  L1_16 = L1_16.Exist
  L3_18 = "CHECK_VERSION"
  L1_16 = L1_16(L2_17, L3_18)
  if L1_16 then
    L1_16 = log4misc
    L2_17 = L1_16
    L1_16 = L1_16.warn
    L3_18 = "AutoPatch query twise"
    L1_16(L2_17, L3_18)
    return
  end
  L1_16 = {}
  A0_15.retryTimes = L1_16
  L1_16 = CVariableSystem
  L2_17 = L1_16
  L1_16 = L1_16.GetSingleton
  L1_16 = L1_16(L2_17)
  L2_17 = L1_16
  L1_16 = L1_16.GetSysVariable
  L3_18 = GV_RESPATH
  L1_16 = L1_16(L2_17, L3_18)
  A0_15.resPath = L1_16
  L1_16 = CVariableSystem
  L2_17 = L1_16
  L1_16 = L1_16.GetSingleton
  L1_16 = L1_16(L2_17)
  L2_17 = L1_16
  L1_16 = L1_16.GetSysVariable
  L3_18 = GV_DOCPATH
  L1_16 = L1_16(L2_17, L3_18)
  A0_15.docPath = L1_16
  L1_16 = CVariableSystem
  L2_17 = L1_16
  L1_16 = L1_16.GetSingleton
  L1_16 = L1_16(L2_17)
  L2_17 = L1_16
  L1_16 = L1_16.GetSysVariable
  L3_18 = GV_PATCHPATH
  L1_16 = L1_16(L2_17, L3_18)
  A0_15.patchPath = L1_16
  L1_16 = CVariableSystem
  L2_17 = L1_16
  L1_16 = L1_16.GetSingleton
  L1_16 = L1_16(L2_17)
  L2_17 = L1_16
  L1_16 = L1_16.GetSysVariable
  L3_18 = GV_VERSION
  L1_16 = L1_16(L2_17, L3_18)
  A0_15.version = L1_16
  L1_16 = A0_15.docPath
  L2_17 = "unzip_tmp/"
  L1_16 = L1_16 .. L2_17
  A0_15.tmpPath = L1_16
  L1_16 = A0_15.docPath
  L2_17 = "autopatch_version.xml"
  L1_16 = L1_16 .. L2_17
  A0_15.verFile = L1_16
  L1_16 = A0_15.docPath
  L2_17 = "autopatch_package.xml"
  L1_16 = L1_16 .. L2_17
  A0_15.packageFile = L1_16
  L1_16 = A0_15.docPath
  L2_17 = "autopatch_assets.xml"
  L1_16 = L1_16 .. L2_17
  A0_15.resFile = L1_16
  L1_16 = A0_15.docPath
  L2_17 = "autopatch_programs.xml"
  L1_16 = L1_16 .. L2_17
  A0_15.prgFile = L1_16
  L1_16 = A0_15.docPath
  L2_17 = "srvLst.dat"
  L1_16 = L1_16 .. L2_17
  A0_15.serverLstFile = L1_16
  L1_16 = Logic
  L2_17 = L1_16
  L1_16 = L1_16.Get
  L3_18 = "System"
  L1_16 = L1_16(L2_17, L3_18)
  L2_17 = L1_16
  L1_16 = L1_16.GetOperatorName
  L1_16 = L1_16(L2_17)
  A0_15.operatorName = L1_16
  L1_16 = Logic
  L2_17 = L1_16
  L1_16 = L1_16.Get
  L3_18 = "System"
  L1_16 = L1_16(L2_17, L3_18)
  L2_17 = L1_16
  L1_16 = L1_16.GetOperatorId
  L1_16 = L1_16(L2_17)
  A0_15.operatorId = L1_16
  L1_16 = A0_15.operatorName
  if nil ~= L1_16 then
    L1_16 = A0_15.operatorId
  elseif nil == L1_16 then
    L1_16 = log4misc
    L2_17 = L1_16
    L1_16 = L1_16.warn
    L3_18 = "error get operator name or operatorId"
    L1_16(L2_17, L3_18)
    return
  end
  L1_16 = Logic
  L2_17 = L1_16
  L1_16 = L1_16.Get
  L3_18 = "System"
  L1_16 = L1_16(L2_17, L3_18)
  L2_17 = L1_16
  L1_16 = L1_16.GetResVer
  L1_16 = L1_16(L2_17)
  A0_15.resVer = L1_16
  L1_16 = A0_15.resVer
  if nil == L1_16 then
    return
  end
  L1_16 = tonumber
  L2_17 = A0_15.version
  L1_16 = L1_16(L2_17)
  A0_15.version = L1_16
  L1_16 = CVariableSystem
  L2_17 = L1_16
  L1_16 = L1_16.GetSingleton
  L1_16 = L1_16(L2_17)
  L2_17 = L1_16
  L1_16 = L1_16.GetSysVariable
  L3_18 = GV_RESTMP_VER
  L1_16 = L1_16(L2_17, L3_18)
  if nil ~= L1_16 then
    L2_17 = tonumber
    L3_18 = L1_16
    L2_17 = L2_17(L3_18)
  else
    L2_17 = L2_17 or 0
  end
  L3_18 = CVariableSystem
  L4_19 = L3_18
  L3_18 = L3_18.GetSingleton
  L3_18 = L3_18(L4_19)
  L4_19 = L3_18
  L3_18 = L3_18.GetSysVariable
  L5_20 = GV_PRGTMP_VER
  L3_18 = L3_18(L4_19, L5_20)
  if nil ~= L3_18 then
    L4_19 = tonumber
    L5_20 = L3_18
    L4_19 = L4_19(L5_20)
  else
    L4_19 = L4_19 or 0
  end
  L5_20 = A0_15.resVer
  if L2_17 <= L5_20 then
    L5_20 = CTwDirUtils
    L6_21 = L5_20
    L5_20 = L5_20.ClrContent
    L7_22 = A0_15.tmpPath
    L5_20(L6_21, L7_22)
    L5_20 = CVariableSystem
    L6_21 = L5_20
    L5_20 = L5_20.GetSingleton
    L5_20 = L5_20(L6_21)
    L6_21 = L5_20
    L5_20 = L5_20.SetSysVariable
    L7_22 = GV_RESTMP_VER
    L8_23 = 0
    L5_20(L6_21, L7_22, L8_23)
    L5_20 = Logic
    L6_21 = L5_20
    L5_20 = L5_20.Get
    L7_22 = "System"
    L5_20 = L5_20(L6_21, L7_22)
    L6_21 = L5_20
    L5_20 = L5_20.SaveSysVariable
    L5_20(L6_21)
  else
    A0_15.resVer = L2_17
    L5_20 = Singleton
    L6_21 = Timer
    L5_20 = L5_20(L6_21)
    L6_21 = L5_20
    L5_20 = L5_20.After
    L7_22 = 1000
    L8_23 = A0_15.Event
    L8_23 = L8_23(A0_15, "DOWN_FINISH", "DownloadFinish")
    L5_20(L6_21, L7_22, L8_23, L8_23(A0_15, "DOWN_FINISH", "DownloadFinish"))
    return
  end
  L5_20 = CTwDirUtils
  L6_21 = L5_20
  L5_20 = L5_20.MkDir
  L7_22 = A0_15.tmpPath
  L5_20(L6_21, L7_22)
  L5_20 = CTwDirUtils
  L6_21 = L5_20
  L5_20 = L5_20.MkDir
  L7_22 = A0_15.patchPath
  L5_20(L6_21, L7_22)
  L5_20 = KFDBGetRecordByPT
  L6_21 = "deviceName"
  L5_20 = L5_20(L6_21)
  if nil == L5_20 then
    return
  end
  L6_21 = Logic
  L7_22 = L6_21
  L6_21 = L6_21.Get
  L8_23 = "System"
  L6_21 = L6_21(L7_22, L8_23)
  L7_22 = L6_21
  L6_21 = L6_21.GetAutoPatch
  L6_21 = L6_21(L7_22)
  if nil == L6_21 then
    return
  end
  L7_22 = A0_15.docPath
  L8_23 = "ZipFile"
  L7_22 = L7_22 .. L8_23
  L8_23 = CTwDirUtils
  L8_23 = L8_23.MkDir
  L8_23(L8_23, L7_22)
  L8_23 = CTwDirUtils
  L8_23 = L8_23.DelFile
  L8_23(L8_23, A0_15.resFile)
  L8_23 = ITwHttp
  L8_23 = L8_23.Request
  L8_23 = L8_23()
  L8_23.strHost = L6_21.host
  L8_23.strMethod = "GET"
  L8_23.strAction = string.format(L6_21.verAct, L6_21.productName, A0_15.operatorId, A0_15.operatorName, L5_20)
  L8_23.usPort = _UPVALUE0_(L6_21.host, L6_21.port)
  CTwDirUtils:DelFile(A0_15.verFile)
  L8_23:SetDownloadFile(A0_15.verFile)
  Singleton(NetHttp):On(L8_23.uReqId, A0_15:Event("CHECK_VERSION", "OnCheckVersion"))
  Singleton(NetHttp):Send(L8_23)
end
function class.OnCheckVersion(A0_24, A1_25, A2_26)
  local L3_27, L4_28, L5_29, L6_30, L7_31, L8_32, L9_33
  L4_28 = A0_24
  L3_27 = A0_24.EventTracer
  L3_27 = L3_27(L4_28)
  L4_28 = L3_27
  L3_27 = L3_27.Cancel
  L5_29 = "CHECK_VERSION"
  L3_27(L4_28, L5_29)
  if A1_25 ~= 0 then
    L3_27 = Prompt
    L4_28 = L3_27
    L3_27 = L3_27.Select
    L5_29 = A0_24
    L6_30 = 10094
    L7_31 = 10090
    L8_32 = A0_24.OnConfirmRestart
    L3_27(L4_28, L5_29, L6_30, L7_31, L8_32)
    return
  end
  L3_27 = io
  L3_27 = L3_27.open
  L4_28 = A0_24.verFile
  L3_27 = L3_27(L4_28)
  if nil == L3_27 then
    L4_28 = Prompt
    L5_29 = L4_28
    L4_28 = L4_28.Select
    L6_30 = A0_24
    L7_31 = 10094
    L8_32 = 10097
    L9_33 = A0_24.OnConfirmRestart
    L4_28(L5_29, L6_30, L7_31, L8_32, L9_33)
    return
  end
  L5_29 = L3_27
  L4_28 = L3_27.read
  L6_30 = "*a"
  L4_28 = L4_28(L5_29, L6_30)
  L5_29 = io
  L5_29 = L5_29.close
  L6_30 = L3_27
  L5_29(L6_30)
  L5_29 = CTwDirUtils
  L6_30 = L5_29
  L5_29 = L5_29.DelFile
  L7_31 = A0_24.verFile
  L5_29(L6_30, L7_31)
  if nil == L4_28 or "" == L4_28 then
    L5_29 = Prompt
    L6_30 = L5_29
    L5_29 = L5_29.Select
    L7_31 = A0_24
    L8_32 = 10094
    L9_33 = 10115
    L5_29(L6_30, L7_31, L8_32, L9_33, A0_24.OnConfirmRestart)
    return
  end
  L5_29 = nil
  L6_30 = pcall
  function L7_31()
    _UPVALUE0_ = json.decode(_UPVALUE1_)
  end
  L7_31 = L6_30(L7_31)
  if L6_30 and nil ~= L5_29 then
    L8_32 = L5_29.package
    if nil ~= L8_32 then
      L8_32 = L5_29.asset
    end
  elseif nil == L8_32 then
    L8_32 = log4misc
    L9_33 = L8_32
    L8_32 = L8_32.warn
    L8_32(L9_33, L7_31)
    L8_32 = Prompt
    L9_33 = L8_32
    L8_32 = L8_32.Select
    L8_32(L9_33, A0_24, 10094, 10116, A0_24.OnConfirmRestart)
    return
  end
  L8_32 = A0_24.version
  L9_33 = L5_29.package
  if L8_32 < L9_33 then
    L8_32 = Logic
    L9_33 = L8_32
    L8_32 = L8_32.Get
    L8_32 = L8_32(L9_33, "System")
    L9_33 = L8_32
    L8_32 = L8_32.IsPkgUpdateWifiTip
    L8_32 = L8_32(L9_33)
    L9_33 = 10096
    if L8_32 then
      CheckNetworkStatus()
      L9_33 = NETWORK_WIFI ~= Singleton(NetMgr):GetNetType() and 100066 or 10096
    end
    Prompt:Select(A0_24, 10095, L9_33, A0_24.OnConfirmCheckPackage)
    return
  end
  L8_32 = A0_24.resVer
  L9_33 = L5_29.asset
  if L8_32 >= L9_33 then
    L9_33 = A0_24
    L8_32 = A0_24.done
    L8_32(L9_33)
    return
  end
  L9_33 = A0_24
  L8_32 = A0_24.CheckResVersion
  L8_32(L9_33)
end
function class.CheckResVersion(A0_34)
  local L1_35, L2_36, L3_37
  L1_35 = Logic
  L2_36 = L1_35
  L1_35 = L1_35.Get
  L3_37 = "System"
  L1_35 = L1_35(L2_36, L3_37)
  L2_36 = L1_35
  L1_35 = L1_35.GetAutoPatch
  L1_35 = L1_35(L2_36)
  L2_36 = CTwDirUtils
  L3_37 = L2_36
  L2_36 = L2_36.DelFile
  L2_36(L3_37, A0_34.resFile)
  L2_36 = KFDBGetRecordByPT
  L3_37 = "deviceName"
  L2_36 = L2_36(L3_37)
  if nil == L2_36 then
    return
  end
  L3_37 = ITwHttp
  L3_37 = L3_37.Request
  L3_37 = L3_37()
  L3_37.strHost = L1_35.host
  L3_37.strMethod = "GET"
  L3_37.strAction = string.format(L1_35.resAct, L1_35.productName, A0_34.operatorId, A0_34.operatorName, L2_36)
  L3_37.usPort = _UPVALUE0_(L1_35.host, L1_35.port)
  CTwDirUtils:DelFile(A0_34.resFile)
  L3_37:SetDownloadFile(A0_34.resFile)
  Singleton(NetHttp):On(L3_37.uReqId, A0_34:Event("CHECK_RES_VERSION", "OnCheckResVersion"))
  Singleton(NetHttp):Send(L3_37)
end
function class.OnCheckResVersion(A0_38, A1_39, A2_40)
  local L3_41, L4_42, L5_43, L6_44, L7_45, L8_46, L9_47, L10_48, L11_49
  L4_42 = A0_38
  L3_41 = A0_38.EventTracer
  L3_41 = L3_41(L4_42)
  L4_42 = L3_41
  L3_41 = L3_41.Cancel
  L5_43 = "CHECK_RES_VERSION"
  L3_41(L4_42, L5_43)
  if 0 ~= A1_39 then
    L3_41 = Prompt
    L4_42 = L3_41
    L3_41 = L3_41.Select
    L5_43 = A0_38
    L6_44 = 10094
    L7_45 = 10113
    L3_41(L4_42, L5_43, L6_44, L7_45, L8_46)
    return
  end
  L3_41 = io
  L3_41 = L3_41.open
  L4_42 = A0_38.resFile
  L3_41 = L3_41(L4_42)
  if nil == L3_41 then
    L4_42 = Prompt
    L5_43 = L4_42
    L4_42 = L4_42.Select
    L6_44 = A0_38
    L7_45 = 10094
    L4_42(L5_43, L6_44, L7_45, L8_46, L9_47)
    return
  end
  L5_43 = L3_41
  L4_42 = L3_41.read
  L6_44 = "*a"
  L4_42 = L4_42(L5_43, L6_44)
  L5_43 = io
  L5_43 = L5_43.close
  L6_44 = L3_41
  L5_43(L6_44)
  L5_43 = CTwDirUtils
  L6_44 = L5_43
  L5_43 = L5_43.DelFile
  L7_45 = A0_38.resFile
  L5_43(L6_44, L7_45)
  A0_38.resData = nil
  L5_43 = pcall
  function L6_44()
    _UPVALUE0_.resData = json.decode(_UPVALUE1_)
  end
  L6_44 = L5_43(L6_44)
  if L5_43 then
    L7_45 = A0_38.resData
  elseif nil == L7_45 then
    L7_45 = Prompt
    L7_45 = L7_45.Select
    L11_49 = 10114
    L7_45(L8_46, L9_47, L10_48, L11_49, A0_38.OnConfirmRestart)
    return
  end
  function L7_45(A0_50, A1_51)
    return A0_50.version < A1_51.version
  end
  L8_46(L9_47, L10_48)
  for L11_49 = #L8_46, 1, -1 do
    if nil ~= #A0_38.resData[L11_49] and A0_38.resData[L11_49].version <= A0_38.resVer then
      table.remove(A0_38.resData, L11_49)
    end
  end
  if L8_46 == 0 then
    L9_47(L10_48)
    return
  end
  A0_38.curDown = 1
  L11_49 = A0_38.resData
  L11_49 = L11_49[A0_38.curDown]
  L9_47(L10_48, L11_49)
end
function class.GetServerLst(A0_52)
  local L1_53, L2_54
  L1_53 = Logic
  L2_54 = L1_53
  L1_53 = L1_53.Get
  L1_53 = L1_53(L2_54, "System")
  L2_54 = L1_53
  L1_53 = L1_53.GetMisc
  L1_53 = L1_53(L2_54, "serverLst")
  L2_54 = L1_53.useOpt
  if nil ~= L2_54 then
    L2_54 = L1_53.useOpt
    if 0 ~= L2_54 then
      L2_54 = Logic
      L2_54 = L2_54.Get
      L2_54 = L2_54(L2_54, "EnvLogic")
      L2_54 = L2_54.QueryServerLst
      L2_54(L2_54)
      return
    end
  end
  L2_54 = ITwHttp
  L2_54 = L2_54.Request
  L2_54 = L2_54()
  if nil ~= L1_53.appHost and (Logic:Get("System"):IsOperator("appstore") or Logic:Get("System"):IsChannel("taiwsqios")) then
    L2_54.strHost = string.format(L1_53.appHost, A0_52.version)
  else
    L2_54.strHost = L1_53.host
  end
  L2_54.strMethod = "GET"
  L2_54.strAction = string.format(L1_53.action, A0_52.operatorId, A0_52.operatorName)
  L2_54.usPort = _UPVALUE0_(L2_54.strHost, L1_53.port)
  CTwDirUtils:DelFile(A0_52.serverLstFile)
  L2_54:SetDownloadFile(A0_52.serverLstFile)
  Singleton(NetHttp):On(L2_54.uReqId, A0_52:Event("GET_SERVER_LST", "OnGetServerLst"))
  Singleton(NetHttp):Send(L2_54)
end
function class.OnGetServerLst(A0_55, A1_56, A2_57)
  local L3_58, L4_59
  L4_59 = A0_55
  L3_58 = A0_55.EventTracer
  L3_58 = L3_58(L4_59)
  L4_59 = L3_58
  L3_58 = L3_58.Cancel
  L3_58(L4_59, "GET_SERVER_LST")
  if 0 ~= A1_56 then
    L3_58 = Prompt
    L4_59 = L3_58
    L3_58 = L3_58.Select
    L3_58(L4_59, A0_55, "", 10110, A0_55.OnConfirmReGetServerLst)
    return
  end
  L3_58 = io
  L3_58 = L3_58.open
  L4_59 = A0_55.serverLstFile
  L3_58 = L3_58(L4_59)
  if nil == L3_58 then
    L4_59 = Prompt
    L4_59 = L4_59.Select
    L4_59(L4_59, A0_55, "", 10117, A0_55.OnConfirmReGetServerLst)
    return
  end
  L4_59 = L3_58.read
  L4_59 = L4_59(L3_58, "*a")
  io.close(L3_58)
  CTwDirUtils:DelFile(A0_55.serverLstFile)
  if not Logic:Get("Login"):InitServerLst(L4_59) then
    Prompt:Select(A0_55, "", 10117, A0_55.OnConfirmReGetServerLst)
    return
  end
  A0_55:FireEvent(EVT.ENTER_SELSERVER)
end
function class.OnConfirmReGetServerLst(A0_60, A1_61)
  if A1_61 == Prompt.RET.OK then
    A0_60:GetServerLst()
  else
    Logic:Get("EnvLogic"):ExitGame()
  end
end
function class.DownloadVersion(A0_62, A1_63)
  local L2_64, L3_65, L4_66
  L3_65 = A0_62
  L2_64 = A0_62.checkAvaliableStorageSize
  L2_64 = L2_64(L3_65)
  if not L2_64 then
    L2_64 = Prompt
    L3_65 = L2_64
    L2_64 = L2_64.Select
    L4_66 = A0_62
    L2_64(L3_65, L4_66, 10094, 10157, A0_62.OnConfirmRestart)
    return
  end
  L2_64 = Logic
  L3_65 = L2_64
  L2_64 = L2_64.Get
  L4_66 = "System"
  L2_64 = L2_64(L3_65, L4_66)
  L3_65 = L2_64
  L2_64 = L2_64.GetAutoPatch
  L2_64 = L2_64(L3_65)
  if nil == L2_64 then
    return
  end
  L3_65 = ITwHttp
  L3_65 = L3_65.Request
  L3_65 = L3_65()
  L4_66 = L2_64.downHost
  L3_65.strHost = L4_66
  L3_65.strMethod = "GET"
  L4_66 = L2_64.downAct
  L4_66 = L4_66 .. A1_63.url
  L3_65.strAction = L4_66
  L4_66 = _UPVALUE0_
  L4_66 = L4_66(L2_64.downHost, L2_64.downPort)
  L3_65.usPort = L4_66
  L4_66 = A0_62.docPath
  L4_66 = L4_66 .. "ZipFile/" .. string.match(A1_63.url, ".+/([^/]*%.%w+)$")
  L3_65:SetDownloadFile(L4_66)
  A0_62.curDownFileInitSize = L3_65.pBufferReader:GetInitFileSize()
  L3_65:AddHeader("Range", string.format("bytes=%d-", A0_62.curDownFileInitSize))
  A0_62.downReq = L3_65
  Singleton(NetHttp):On(L3_65.uReqId, A0_62:Event("DOWNLOAD", "OnDownloadVersion"))
  Singleton(NetHttp):Send(L3_65, false)
end
function class.OnDownloadVersion(A0_67, A1_68, A2_69)
  local L3_70, L4_71
  L4_71 = A0_67
  L3_70 = A0_67.EventTracer
  L3_70 = L3_70(L4_71)
  L4_71 = L3_70
  L3_70 = L3_70.Cancel
  L3_70(L4_71, "DOWNLOAD")
  if A1_68 ~= 0 then
    L3_70 = Prompt
    L4_71 = L3_70
    L3_70 = L3_70.Select
    L3_70(L4_71, A0_67, 10094, 10093, A0_67.OnConfirmRedown)
    return
  end
  L3_70 = A0_67.downReq
  L3_70 = L3_70.pBufferReader
  L4_71 = L3_70
  L3_70 = L3_70.GetFileName
  L3_70 = L3_70(L4_71)
  L4_71 = CMd5
  L4_71 = L4_71(L3_70, false)
  L4_71 = L4_71.GetResult
  L4_71 = L4_71(L4_71)
  if string.upper(L4_71) ~= string.upper(A0_67.resData[A0_67.curDown].md5) or 0 ~= TwUnzip(L3_70, A0_67.tmpPath) then
    if nil == A0_67.retryTimes[A0_67.curDown] then
      A0_67.retryTimes[A0_67.curDown] = 1
    else
      A0_67.retryTimes[A0_67.curDown] = A0_67.retryTimes[A0_67.curDown] + 1
    end
    if A0_67.retryTimes[A0_67.curDown] > _UPVALUE0_ then
      Prompt:Select(A0_67, 10094, 10118, A0_67.OnConfirmRedown)
      A0_67.retryTimes[A0_67.curDown] = 0
      CTwDirUtils:DelFile(L3_70)
      return
    end
    A0_67.curDown = A0_67.curDown - 1
  else
    CVariableSystem:GetSingleton():SetSysVariable(GV_RESTMP_VER, A0_67.resData[A0_67.curDown].version)
    Logic:Get("System"):SaveSysVariable()
  end
  CTwDirUtils:DelFile(L3_70)
  if A0_67.curDown >= #A0_67.resData then
    A0_67.resVer = A0_67.resData[#A0_67.resData].version
    Singleton(Timer):After(1000, A0_67:Event("DOWN_FINISH", "DownloadFinish"))
    return
  end
  A0_67.curDown = A0_67.curDown + 1
  A0_67:DownloadVersion(A0_67.resData[A0_67.curDown])
end
function class.DownloadFinish(A0_72)
  if CTwDirUtils:Rename(A0_72.tmpPath, A0_72.patchPath) then
    CTwDirUtils:ClrContent(A0_72.tmpPath)
    CVariableSystem:GetSingleton():SetSysVariable(GV_RESTMP_VER, 0)
    CVariableSystem:GetSingleton():SetSysVariable(GV_RES_VER, A0_72.resVer)
    Logic:Get("System"):SaveSysVariable()
  end
  CEnvRoot:GetSingleton():SetReloadAll()
end
function class.GetDownFileInfo(A0_73)
  local L1_74
  L1_74 = A0_73.downReq
  if L1_74 == nil then
    return
  end
  L1_74 = 0
  for _FORV_5_ = 1, #A0_73.resData do
    if nil ~= A0_73.resData[_FORV_5_] and nil ~= A0_73.resData[_FORV_5_].size then
      L1_74 = L1_74 + A0_73.resData[_FORV_5_].size
    end
  end
  return _FOR_:GetInstance():GetDownloadInfo(A0_73.downReq.uReqId), A0_73.curDown, #A0_73.resData, L1_74
end
function class.done(A0_75)
  if Logic:Get("System"):GetExeVer() >= Logic.System.EXE_VERSION.INIT_SDK then
    Logic:Get("Sdk"):OnInit()
  end
  A0_75:GetServerLst()
  Tw.TexturePreloader:getInstance():preload()
end
function class.checkAvaliableStorageSize(A0_76)
  if rawget(_G, "REFLECT_EVENT_CHECK_STORAGESIZE") == nil then
    return true
  end
  CReflectSystem:GetSingleton():FireEvent(TwEvtArgs(REFLECT_EVENT_CHECK_STORAGESIZE))
  if nil == Logic:Get("System"):GetAvaliableStorageSize() then
    return true
  end
  if nil == A0_76.resData then
    return true
  end
  for _FORV_6_ = A0_76.curDown, #A0_76.resData do
    if nil ~= _FORV_6_ and nil ~= A0_76.resData[_FORV_6_] and nil ~= A0_76.resData[_FORV_6_].size then
    end
  end
  return Logic:Get("System"):GetAvaliableStorageSize() > _FOR_ / 1048576
end
