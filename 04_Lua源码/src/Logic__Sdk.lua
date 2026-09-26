local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("Logic")
L0_0 = require
L0_0("Logic.Login")
L0_0 = Logic
L0_0 = L0_0.Login
class = Logic.class:subclass()
function class.initialize(A0_1)
  super.initialize(A0_1)
  A0_1.inRecoverOrders = {
    tryTimes = 0,
    tryIdx = 1,
    orderLst = {}
  }
  A0_1.sdkFuncStatus = {}
  A0_1.refreshMoney = {}
  A0_1.ExtSid = {}
  Logic:Get("Login"):On(_UPVALUE0_.EVT.LOGIN_COMPLETE, A0_1:Event("OnLoginComplete"))
end
function class.OnInit(A0_2)
  A0_2:InitOperatorSdk()
end
function class.InitOperatorSdk(A0_3)
  local L1_4, L2_5, L3_6
  L1_4 = Logic
  L2_5 = L1_4
  L1_4 = L1_4.Get
  L3_6 = "System"
  L1_4 = L1_4(L2_5, L3_6)
  L2_5 = L1_4
  L1_4 = L1_4.GetOperatorItemFromFile
  L3_6 = "sdkInfo"
  L1_4 = L1_4(L2_5, L3_6, "config.dat")
  if nil ~= L1_4 then
    L2_5 = json
    L2_5 = L2_5.encode
    L3_6 = L1_4
    L2_5 = L2_5(L3_6)
  else
    L2_5 = L2_5 or ""
  end
  L3_6 = TwReflectEvtArgs
  L3_6 = L3_6(REFLECT_EVENT_INIT_SDK, 0, 0, L2_5)
  CReflectSystem:GetSingleton():FireEvent(L3_6)
end
function class.OnLoginComplete(A0_7)
  if Logic:Get("System"):IsOperator("appstore") then
    A0_7:RecoverAppOrder()
  end
end
function class.OnAccountCrypto(A0_8, A1_9)
  Logic:Get("Account"):OnAccountCrypto(A1_9)
end
function class.OnTcpLoginProof(A0_10, A1_11)
  Logic:Get("Login"):OnTcpLoginProof(A1_11)
end
function class.LockUI(A0_12, A1_13)
  Logic:Get("Recharge"):LockUI(A1_13 or 10000)
end
function class.UnLockUI(A0_14)
  Logic:Get("Recharge"):UnLockUI()
end
function class.SaveRechargeUserInfo(A0_15, A1_16)
  local L2_17, L3_18
  if nil == A1_16 then
    return
  end
  L2_17 = Logic
  L3_18 = L2_17
  L2_17 = L2_17.Get
  L2_17 = L2_17(L3_18, "System")
  L3_18 = L2_17
  L2_17 = L2_17.GetSysVariableMisc
  L2_17 = L2_17(L3_18, _UPVALUE0_)
  if L2_17 then
    L3_18 = json
    L3_18 = L3_18.decode
    L3_18 = L3_18(L2_17)
  else
    L3_18 = L3_18 or {}
  end
  L3_18 = L3_18 or {}
  ;({}).accountId = A1_16.accountId
  ;({}).serverId = A1_16.serverId
  ;({}).time = Logic:Get("System"):GetTime()
  L3_18[A1_16.goodsId] = {}
  Logic:Get("System"):SetSysVariableMisc(_UPVALUE0_, json.encode(L3_18))
end
function class.GetRechargeUserInfo(A0_19, A1_20)
  local L2_21
  L2_21 = Logic
  L2_21 = L2_21.Get
  L2_21 = L2_21(L2_21, "System")
  L2_21 = L2_21.GetSysVariableMisc
  L2_21 = L2_21(L2_21, _UPVALUE0_)
  if nil == L2_21 or "" == L2_21 then
    return nil
  end
  if nil == json.decode(L2_21) then
    return nil
  end
  return json.decode(L2_21)[A1_20]
end
function class.Recharge(A0_22, A1_23)
  local L2_24, L3_25
  if nil == A1_23 then
    return
  end
  L3_25 = A0_22
  L2_24 = A0_22.SaveRechargeUserInfo
  L2_24(L3_25, A1_23)
  L2_24 = Logic
  L3_25 = L2_24
  L2_24 = L2_24.Get
  L2_24 = L2_24(L3_25, "System")
  L3_25 = L2_24
  L2_24 = L2_24.GetLockBuyUITime
  L2_24 = L2_24(L3_25)
  L3_25 = Logic
  L3_25 = L3_25.Get
  L3_25 = L3_25(L3_25, "System")
  L3_25 = L3_25.IsOperator
  L3_25 = L3_25(L3_25, "appstore")
  if L3_25 then
    L3_25 = 10000
    L2_24 = L3_25 or L2_24
  end
  if L2_24 then
    L3_25 = A0_22.LockUI
    L3_25(A0_22, L2_24)
  end
  L3_25 = json
  L3_25 = L3_25.encode
  L3_25 = L3_25(A1_23)
  Logic:Get("EnvLogic"):Recharge(L3_25)
end
function class.CheckOrderTimer(A0_26, A1_27)
  local L2_28, L3_29
  L3_29 = A0_26
  L2_28 = A0_26.GetRechargeUserInfo
  L2_28 = L2_28(L3_29, A1_27)
  if nil == L2_28 then
    L3_29 = false
    return L3_29
  end
  L3_29 = Logic
  L3_29 = L3_29.Get
  L3_29 = L3_29(L3_29, "System")
  L3_29 = L3_29.GetTime
  L3_29 = L3_29(L3_29)
  if L3_29 - (L2_28.time or L3_29) > _UPVALUE0_ then
    return true, L2_28.accountId, L2_28.serverId
  end
  return false
end
function class.OnAPPItemBuyed(A0_30, A1_31)
  local L2_32, L3_33, L4_34, L5_35, L6_36, L7_37
  if nil == A1_31 or "" == A1_31 then
    L2_32 = log4misc
    L3_33 = L2_32
    L2_32 = L2_32.warn
    L4_34 = "app buyed data is wrong"
    L2_32(L3_33, L4_34)
    return
  end
  L2_32 = Logic
  L3_33 = L2_32
  L2_32 = L2_32.Get
  L4_34 = "System"
  L2_32 = L2_32(L3_33, L4_34)
  L3_33 = L2_32
  L2_32 = L2_32.IsOperator
  L4_34 = "appstore"
  L2_32 = L2_32(L3_33, L4_34)
  if not L2_32 then
    L3_33 = json
    L3_33 = L3_33.decode
    L4_34 = A1_31
    L3_33 = L3_33(L4_34)
    if L3_33 then
      L4_34 = L3_33.ret
      if L4_34 then
        L5_35 = A0_30
        L4_34 = A0_30.RefreshMoneyDelay
        L4_34(L5_35)
        L4_34 = Logic
        L5_35 = L4_34
        L4_34 = L4_34.Get
        L6_36 = "System"
        L4_34 = L4_34(L5_35, L6_36)
        L5_35 = L4_34
        L4_34 = L4_34.IsPayBackTip
        L4_34 = L4_34(L5_35)
        if L4_34 then
          L4_34 = Prompt
          L5_35 = L4_34
          L4_34 = L4_34.Msg
          L6_36 = 100057
          L4_34(L5_35, L6_36)
        end
        L4_34 = Logic
        L5_35 = L4_34
        L4_34 = L4_34.Get
        L6_36 = "System"
        L4_34 = L4_34(L5_35, L6_36)
        L5_35 = L4_34
        L4_34 = L4_34.IsOperator
        L6_36 = "myapp"
        L4_34 = L4_34(L5_35, L6_36)
        if L4_34 then
          L4_34 = MsgTencent
          L5_35 = L4_34
          L4_34 = L4_34.Post
          L6_36 = "QUERY_BALANCE"
          L4_34(L5_35, L6_36)
        end
      end
      L4_34 = L3_33.unlockui
      if L4_34 then
        L5_35 = A0_30
        L4_34 = A0_30.UnLockUI
        L4_34(L5_35)
      end
    end
    return
  end
  L3_33 = json
  L3_33 = L3_33.decode
  L4_34 = A1_31
  L3_33 = L3_33(L4_34)
  if nil == L3_33 then
    L4_34 = log4misc
    L5_35 = L4_34
    L4_34 = L4_34.warn
    L6_36 = "OnAPPItemBuyed data error:"
    L7_37 = A1_31
    L6_36 = L6_36 .. L7_37
    L4_34(L5_35, L6_36)
    L5_35 = A0_30
    L4_34 = A0_30.UnLockUI
    L4_34(L5_35)
    return
  end
  if nil ~= L3_33 then
    L4_34 = L3_33.success
  elseif L4_34 ~= "true" then
    L5_35 = A0_30
    L4_34 = A0_30.UnLockUI
    L4_34(L5_35)
    return
  end
  L5_35 = A0_30
  L4_34 = A0_30.CheckOrderTimer
  L6_36 = L3_33.proIdentifier
  L6_36 = L4_34(L5_35, L6_36)
  if L4_34 then
    L7_37 = "app order time is too long accountId:"
    L7_37 = L7_37 .. (L5_35 or "nil") .. " serverId:" .. (L6_36 or "nil") .. " orderData:" .. (A1_31 or "nil")
    Log(L7_37, "critical")
    A0_30:DeleteAppOrder(L3_33.transIdentifier)
    A0_30:DelInRecoverOrder(L3_33.transIdentifier)
    return
  end
  L7_37 = A0_30.SaveAppOrder
  L7_37(A0_30, L3_33.transIdentifier, A1_31)
  L7_37 = A0_30.infoBuy
  L7_37 = L7_37 or {}
  A0_30.infoBuy = L7_37
  L7_37 = A0_30.infoBuy
  L7_37[L3_33.proIdentifier] = A0_30.infoBuy[L3_33.proIdentifier] or {}
  L7_37 = A0_30.infoBuy
  L7_37[L3_33.proIdentifier] = L3_33
  L7_37 = A0_30.CheckInRecoverOrdersData
  L7_37(A0_30)
  L7_37 = A0_30.inRecoverOrders
  L7_37.tryTimes = 0
  L7_37 = A0_30.inRecoverOrders
  L7_37.tryIdx = 1
  L7_37 = table
  L7_37 = L7_37.insert
  L7_37(A0_30.inRecoverOrders.orderLst, 1, L3_33.transIdentifier)
  L7_37 = Logic
  L7_37 = L7_37.Get
  L7_37 = L7_37(L7_37, "Recharge")
  L7_37 = L7_37.BuyGoods
  L7_37(L7_37, L3_33.proIdentifier)
end
function class.OnGetOrderId(A0_38, A1_39)
  local L2_40, L3_41, L4_42, L5_43, L6_44
  L2_40 = A0_38.infoBuy
  if nil ~= L2_40 and nil ~= A1_39 then
    L2_40 = A1_39.orderId
    if nil ~= L2_40 then
      L2_40 = A1_39.goodsId
      if nil ~= L2_40 then
        L2_40 = A0_38.infoBuy
        L3_41 = A1_39.goodsId
        L2_40 = L2_40[L3_41]
      end
    end
  elseif nil == L2_40 then
    return
  end
  L2_40 = A0_38.infoBuy
  L3_41 = A1_39.goodsId
  L2_40 = L2_40[L3_41]
  L3_41 = A1_39.orderId
  L2_40.order = L3_41
  L4_42 = A0_38
  L3_41 = A0_38.CheckOrderTimer
  L5_43 = A1_39.goodsId
  L5_43 = L3_41(L4_42, L5_43)
  if L3_41 then
    L6_44 = "app order time is too long accountId:"
    L6_44 = L6_44 .. (L4_42 or "nil") .. " serverId:" .. (L5_43 or "nil") .. " orderData:" .. (L2_40 and json.encode(L2_40) or "nil")
    Log(L6_44, "critical")
    A0_38:DeleteAppOrder(L2_40.transIdentifier)
    A0_38:DelInRecoverOrder(L2_40.transIdentifier)
    return
  end
  L6_44 = A0_38.AppVerify
  L6_44(A0_38, L2_40)
end
function class.GetAppVerifyData(A0_45, A1_46)
  local L2_47, L3_48, L4_49, L5_50, L6_51, L7_52, L8_53, L9_54
  function L2_47(A0_55, A1_56)
    if nil == A0_55 or nil == A1_56 then
      return false
    end
    return A0_55.name < A1_56.name
  end
  function L3_48(A0_57, A1_58)
    local L2_59
    L2_59 = ""
    for _FORV_6_, _FORV_7_ in ipairs(A0_57) do
      if nil == _FORV_7_.value then
        log4misc:warn((_FORV_7_.name or "name is nil ") .. " value is nil")
      else
        L2_59 = L2_59 .. _FORV_7_.value
      end
    end
    L2_59 = L2_59 .. A1_58
    return L2_59
  end
  L4_49 = A1_46.proIdentifier
  L5_50 = Logic
  L6_51 = L5_50
  L5_50 = L5_50.Get
  L7_52 = "Recharge"
  L5_50 = L5_50(L6_51, L7_52)
  L6_51 = L5_50
  L5_50 = L5_50.GetChargeGoodsInfo
  L7_52 = L4_49
  L5_50 = L5_50(L6_51, L7_52)
  if nil == L5_50 then
    L6_51 = nil
    return L6_51
  end
  L7_52 = A0_45
  L6_51 = A0_45.GetRechargeUserInfo
  L8_53 = L4_49
  L6_51 = L6_51(L7_52, L8_53)
  L7_52 = L6_51 and L6_51.accountId
  L8_53 = L6_51 and L6_51.serverId
  if nil == L7_52 or nil == L8_53 then
    L9_54 = Logic
    L9_54 = L9_54.Get
    L9_54 = L9_54(L9_54, "Login")
    L9_54 = L9_54.GetLoginInfo
    L9_54 = L9_54(L9_54)
    if nil == L9_54 or nil == L9_54.account or nil == L9_54.server then
      return nil
    end
    L7_52 = L9_54.account
    L8_53 = L9_54.server
  end
  L9_54 = {}
  table.insert(L9_54, {
    name = "receipts",
    value = A1_46.transReceipt
  })
  table.insert(L9_54, {
    name = "goodsId",
    value = A1_46.proIdentifier
  })
  table.insert(L9_54, {
    name = "order",
    value = A1_46.transIdentifier
  })
  table.insert(L9_54, {
    name = "originalMoney",
    value = L5_50.price
  })
  table.insert(L9_54, {
    name = "goodsCount",
    value = A1_46.quantity or 1
  })
  table.insert(L9_54, {
    name = "orderMoney",
    value = L5_50.discount
  })
  table.insert(L9_54, {name = "server", value = L8_53})
  table.insert(L9_54, {name = "userId", value = L7_52})
  table.insert(L9_54, {
    name = "isMonthCard",
    value = L5_50.appsecret ~= nil and L5_50.appsecret ~= "" and "true" or "false"
  })
  table.insert(L9_54, {
    name = "selfOrder",
    value = A1_46.order
  })
  table.sort(L9_54, L2_47)
  for _FORV_14_, _FORV_15_ in ipairs(L9_54) do
    ({})[_FORV_15_.name] = _FORV_15_.value
  end
  if nil == Logic:Get("System"):GetMisc("AppVerify") then
    return nil
  end
  ;({}).signature = CMd5(L3_48(L9_54, Logic:Get("System"):GetMisc("AppVerify").md5)):GetResult()
  return {}
end
function class.AppVerify(A0_60, A1_61)
  local L2_62, L3_63
  L3_63 = A0_60
  L2_62 = A0_60.GetAppVerifyData
  L2_62 = L2_62(L3_63, A1_61)
  if nil == L2_62 then
    return
  end
  L3_63 = json
  L3_63 = L3_63.encode
  L3_63 = L3_63(L2_62)
  A0_60:PostAppVerify(L3_63)
end
function class.PostAppVerify(A0_64, A1_65)
  local L2_66, L3_67, L4_68
  L2_66 = Logic
  L3_67 = L2_66
  L2_66 = L2_66.Get
  L4_68 = "System"
  L2_66 = L2_66(L3_67, L4_68)
  L3_67 = L2_66
  L2_66 = L2_66.GetMisc
  L4_68 = "AppVerify"
  L2_66 = L2_66(L3_67, L4_68)
  if nil == L2_66 then
    return
  end
  L3_67 = Logic
  L4_68 = L3_67
  L3_67 = L3_67.Get
  L3_67 = L3_67(L4_68, "System")
  L4_68 = L3_67
  L3_67 = L3_67.GetOperatorId
  L3_67 = L3_67(L4_68)
  L4_68 = ITwHttp
  L4_68 = L4_68.Request
  L4_68 = L4_68()
  L4_68.strHost = L2_66.host
  L4_68.strMethod = "POST"
  L4_68.strAction = L2_66.check .. A1_65
  L4_68.ucRetry = 0
  A0_64:EventTracer():Cancel("APP_VERIFY")
  Singleton(NetHttp):On(L4_68.uReqId, A0_64:Event("APP_VERIFY", "OnAppVerifyServerBack"))
  Singleton(NetHttp):Send(L4_68, false)
end
function class.OnAppVerifyServerBack(A0_69, A1_70, A2_71)
  A2_71 = json.decode(A2_71)
  if true or nil == A2_71 or nil == A2_71.order or type(A2_71.order) == "userdata" then
    A0_69:ClearInRecoverOrderData()
  else
    A0_69:DeleteAppOrder(A2_71.order)
    for _FORV_7_, _FORV_8_ in pairs(A0_69.infoBuy or {}) do
      if _FORV_8_.transIdentifier == A2_71.order then
        Prompt:Msg(100057)
        A0_69.infoBuy[_FORV_7_] = nil
        break
      end
    end
    A0_69:DelInRecoverOrder(A2_71.order)
    A0_69:UnLockUI()
    A0_69:RefreshMoneyDelay()
  end
  if A0_69.inRecoverOrders and A0_69.inRecoverOrders.orderLst and 0 < #A0_69.inRecoverOrders.orderLst and not A0_69:EventTracer():Exist("RecoverAppOrderTimer") then
    Singleton(Timer):Repeat(_UPVALUE0_, A0_69:Event("RecoverAppOrderTimer"))
  end
end
function class.SaveAppOrder(A0_72, A1_73, A2_74)
  local L3_75, L4_76, L5_77, L6_78, L7_79
  if nil == A2_74 or nil == A1_73 then
    return
  end
  L3_75 = CVariableSystem
  L4_76 = L3_75
  L3_75 = L3_75.GetSingleton
  L3_75 = L3_75(L4_76)
  L4_76 = L3_75
  L3_75 = L3_75.GetSysVariable
  L5_77 = GV_DOCPATH
  L3_75 = L3_75(L4_76, L5_77)
  L4_76 = io
  L4_76 = L4_76.open
  L5_77 = L3_75
  L6_78 = A1_73
  L7_79 = ".dat"
  L5_77 = L5_77 .. L6_78 .. L7_79
  L6_78 = "wb"
  L4_76 = L4_76(L5_77, L6_78)
  if nil == L4_76 then
    L5_77 = Log
    L6_78 = "save app order failed "
    L7_79 = A1_73
    L6_78 = L6_78 .. L7_79 .. " " .. A2_74
    L7_79 = "critical"
    L5_77(L6_78, L7_79)
    return
  end
  L5_77 = CTwUtil
  L6_78 = L5_77
  L5_77 = L5_77.GetSingleton
  L5_77 = L5_77(L6_78)
  L6_78 = L5_77
  L5_77 = L5_77.Encrypt
  L7_79 = A2_74
  L5_77 = L5_77(L6_78, L7_79)
  L7_79 = L4_76
  L6_78 = L4_76.write
  L6_78(L7_79, L5_77)
  L7_79 = L4_76
  L6_78 = L4_76.close
  L6_78(L7_79)
  L6_78 = Logic
  L7_79 = L6_78
  L6_78 = L6_78.Get
  L6_78 = L6_78(L7_79, "System")
  L7_79 = L6_78
  L6_78 = L6_78.GetSysVariableMisc
  L6_78 = L6_78(L7_79, _UPVALUE0_)
  L7_79 = json
  L7_79 = L7_79.decode
  L7_79 = L7_79(L6_78)
  L7_79 = not L7_79 and {}
  for _FORV_12_, _FORV_13_ in ipairs(L7_79) do
    if _FORV_13_ == A1_73 then
      break
    end
  end
  if not true then
    table.insert(L7_79, A1_73)
    Logic:Get("System"):SetSysVariableMisc(_UPVALUE0_, json.encode(L7_79))
  end
end
function class.DeleteAppOrder(A0_80, A1_81)
  local L2_82, L3_83, L4_84, L5_85, L6_86, L7_87
  if nil == A1_81 then
    return
  end
  L2_82 = Logic
  L3_83 = L2_82
  L2_82 = L2_82.Get
  L2_82 = L2_82(L3_83, L4_84)
  L3_83 = L2_82
  L2_82 = L2_82.GetSysVariableMisc
  L2_82 = L2_82(L3_83, L4_84)
  L3_83 = json
  L3_83 = L3_83.decode
  L3_83 = L3_83(L4_84)
  L3_83 = L3_83 or {}
  for L7_87, _FORV_8_ in L4_84(L5_85) do
    if _FORV_8_ == A1_81 then
      table.remove(L3_83, L7_87)
      break
    end
  end
  L7_87 = json
  L7_87 = L7_87.encode
  L7_87 = L7_87(L3_83)
  L4_84(L5_85, L6_86, L7_87, L7_87(L3_83))
  L7_87 = A1_81
  L5_85(L6_86)
end
function class.CheckInRecoverOrdersData(A0_88)
  local L1_89, L2_90
  L1_89 = A0_88.inRecoverOrders
  L1_89 = L1_89 or {}
  A0_88.inRecoverOrders = L1_89
  L1_89 = A0_88.inRecoverOrders
  L2_90 = A0_88.inRecoverOrders
  L2_90 = L2_90.orderLst
  L2_90 = L2_90 or {}
  L1_89.orderLst = L2_90
  L1_89 = A0_88.inRecoverOrders
  L2_90 = A0_88.inRecoverOrders
  L2_90 = L2_90.tryTimes
  L2_90 = L2_90 or 0
  L1_89.tryTimes = L2_90
  L1_89 = A0_88.inRecoverOrders
  L2_90 = A0_88.inRecoverOrders
  L2_90 = L2_90.tryIdx
  L2_90 = L2_90 or 1
  L1_89.tryIdx = L2_90
end
function class.DelInRecoverOrder(A0_91, A1_92)
  local L2_93, L3_94, L4_95, L5_96
  if nil ~= A1_92 then
  elseif nil == L2_93 then
    return
  end
  for L5_96, _FORV_6_ in L2_93(L3_94) do
    if _FORV_6_ == A1_92 then
      table.remove(A0_91.inRecoverOrders.orderLst, L5_96)
      return
    end
  end
end
function class.ClearInRecoverOrderData(A0_97)
  local L1_98, L2_99, L3_100, L4_101, L5_102
  if L1_98 then
    if L1_98 then
      if L1_98 >= L2_99 then
        for L4_101, L5_102 in L1_98(L2_99) do
          A0_97:DeleteAppOrder(L5_102)
        end
        A0_97.inRecoverOrders = L1_98
      end
    end
  end
end
function class.RecoverAppOrder(A0_103)
  local L1_104, L2_105, L3_106, L4_107, L5_108, L6_109
  L1_104 = Logic
  L1_104 = L1_104.Get
  L1_104 = L1_104(L2_105, L3_106)
  L1_104 = L1_104.GetSysVariableMisc
  L1_104 = L1_104(L2_105, L3_106)
  if nil == L1_104 or "" == L1_104 then
    return
  end
  L2_105(L3_106)
  L1_104 = L2_105 or L2_105
  for L5_108, L6_109 in L2_105(L3_106) do
    table.insert(A0_103.inRecoverOrders.orderLst, L6_109)
  end
  if L2_105 > 0 then
    L2_105(L3_106, L4_107)
    if not L2_105 then
      L6_109 = A0_103
      L5_108 = A0_103.Event
      L6_109 = L5_108(L6_109, "RecoverAppOrderTimer")
      L2_105(L3_106, L4_107, L5_108, L6_109, L5_108(L6_109, "RecoverAppOrderTimer"))
    end
  end
end
function class.RecoverAppOrderById(A0_110, A1_111)
  local L2_112, L3_113, L4_114, L5_115
  L2_112 = CVariableSystem
  L3_113 = L2_112
  L2_112 = L2_112.GetSingleton
  L2_112 = L2_112(L3_113)
  L3_113 = L2_112
  L2_112 = L2_112.GetSysVariable
  L4_114 = GV_DOCPATH
  L2_112 = L2_112(L3_113, L4_114)
  L3_113 = io
  L3_113 = L3_113.open
  L4_114 = L2_112
  L5_115 = A1_111
  L4_114 = L4_114 .. L5_115 .. ".dat"
  L5_115 = "rb"
  L3_113 = L3_113(L4_114, L5_115)
  if L3_113 then
    L5_115 = L3_113
    L4_114 = L3_113.read
    L4_114 = L4_114(L5_115, "*a")
    L5_115 = L3_113.close
    L5_115(L3_113)
    if L4_114 and "" ~= L4_114 then
      L5_115 = CTwUtil
      L5_115 = L5_115.GetSingleton
      L5_115 = L5_115(L5_115)
      L5_115 = L5_115.Decrypt
      L5_115 = L5_115(L5_115, L4_114)
      if json.decode(L5_115) and json.decode(L5_115).proIdentifier then
        A0_110.infoBuy = A0_110.infoBuy or {}
        A0_110.infoBuy[json.decode(L5_115).proIdentifier] = json.decode(L5_115)
        Logic:Get("Recharge"):BuyGoods(json.decode(L5_115).proIdentifier)
      else
        A0_110:DeleteAppOrder(A1_111)
        A0_110:DelInRecoverOrder(A1_111)
        log4misc:warn("RecoverAppOrderById failed orderId:" .. (A1_111 or "nil"))
      end
    end
  else
    L5_115 = A0_110
    L4_114 = A0_110.DeleteAppOrder
    L4_114(L5_115, A1_111)
    L5_115 = A0_110
    L4_114 = A0_110.DelInRecoverOrder
    L4_114(L5_115, A1_111)
    L4_114 = log4misc
    L5_115 = L4_114
    L4_114 = L4_114.warn
    L4_114(L5_115, "read file failed orderId:" .. (A1_111 or "nil"))
  end
end
function class.RecoverAppOrderTimer(A0_116)
  if not Singleton(GameStage):IsStage("Normal") then
    return
  end
  if nil == A0_116.inRecoverOrders or nil == A0_116.inRecoverOrders.orderLst or table.empty(A0_116.inRecoverOrders.orderLst) then
    A0_116:EventTracer():Cancel("RecoverAppOrderTimer")
    return
  end
  A0_116:CheckInRecoverOrdersData()
  A0_116.inRecoverOrders.tryTimes = A0_116.inRecoverOrders.tryTimes + 1
  if (_UPVALUE0_[A0_116.inRecoverOrders.tryIdx] or _UPVALUE0_[#_UPVALUE0_]) <= A0_116.inRecoverOrders.tryTimes then
    A0_116:RecoverAppOrderById(A0_116.inRecoverOrders.orderLst[1])
    A0_116.inRecoverOrders.tryTimes = 0
    A0_116.inRecoverOrders.tryIdx = A0_116.inRecoverOrders.tryIdx + 1
  end
end
function class.CheckUCSid(A0_117, A1_118)
  local L2_119, L3_120
  L2_119 = Logic
  L3_120 = L2_119
  L2_119 = L2_119.Get
  L2_119 = L2_119(L3_120, "System")
  L3_120 = L2_119
  L2_119 = L2_119.GetOperatorItemFromFile
  L2_119 = L2_119(L3_120, "sdkInfo", "config.dat")
  if nil ~= L2_119 then
    L3_120 = L2_119.SidHost
    if nil ~= L3_120 then
      L3_120 = L2_119.SidPort
      if nil ~= L3_120 then
        L3_120 = L2_119.SidAct
      end
    end
  elseif nil == L3_120 then
    L3_120 = log4misc
    L3_120 = L3_120.warn
    L3_120(L3_120, "sdk sid param config is empty")
    return
  end
  L3_120 = ITwHttp
  L3_120 = L3_120.Request
  L3_120 = L3_120()
  L3_120.strHost = L2_119.SidHost
  L3_120.port = L2_119.SidPort
  L3_120.strMethod = "POST"
  L3_120.strAction = string.format(L2_119.SidAct, A1_118)
  L3_120.ucRetry = 0
  Singleton(NetHttp):On(L3_120.uReqId, A0_117:Event("CHECK_UC_SID", "OnCheckUCSid"))
  Singleton(NetHttp):Send(L3_120)
end
function class.OnCheckUCSid(A0_121, A1_122, A2_123)
  A0_121:EventTracer():Cancel("CHECK_UC_SID")
  if Logic:Get("Account"):OnError(A1_122, A2_123) then
    return
  end
  if nil == Logic:Get("Account"):OnError(A1_122, A2_123) or nil == Logic:Get("Account"):OnError(A1_122, A2_123).user or nil == Logic:Get("Account"):OnError(A1_122, A2_123).user.data or nil == Logic:Get("Account"):OnError(A1_122, A2_123).user.data.ucid then
    return
  end
  Logic:Get("Account"):SetNickName(Logic:Get("Account"):OnError(A1_122, A2_123).user.data.nickName)
  Logic:Get("Account"):SetAccName(tostring(Logic:Get("Account"):OnError(A1_122, A2_123).user.data.ucid))
  Logic:Get("Account"):SetPassword(CMd5(tostring(Logic:Get("Account"):OnError(A1_122, A2_123).user.data.ucid)):GetResult())
  Logic:Get("Account"):CheckUser()
end
function class.CheckQiDianSid(A0_124, A1_125)
  local L2_126, L3_127, L4_128
  L2_126 = Logic
  L3_127 = L2_126
  L2_126 = L2_126.Get
  L4_128 = "System"
  L2_126 = L2_126(L3_127, L4_128)
  L3_127 = L2_126
  L2_126 = L2_126.GetOperatorItemFromFile
  L4_128 = "sdkInfo"
  L2_126 = L2_126(L3_127, L4_128, "config.dat")
  if nil ~= L2_126 then
    L3_127 = L2_126.SidHost
    if nil ~= L3_127 then
      L3_127 = L2_126.SidPort
      if nil ~= L3_127 then
        L3_127 = L2_126.SidAct
      end
    end
  elseif nil == L3_127 then
    L3_127 = log4misc
    L4_128 = L3_127
    L3_127 = L3_127.warn
    L3_127(L4_128, "sdk sid param config is empty")
    return
  end
  L3_127 = json
  L3_127 = L3_127.decode
  L4_128 = A1_125
  L3_127 = L3_127(L4_128)
  L4_128 = ITwHttp
  L4_128 = L4_128.Request
  L4_128 = L4_128()
  A0_124.ExtSid = A1_125
  L4_128.strHost = L2_126.SidHost
  L4_128.port = L2_126.SidPort
  L4_128.strMethod = "POST"
  L4_128.strAction = string.format(L2_126.SidAct, L3_127.tkey)
  L4_128.ucRetry = 0
  Singleton(NetHttp):On(L4_128.uReqId, A0_124:Event("CHECK_QiDian_SID", "OnCheckQiDianSid"))
  Singleton(NetHttp):Send(L4_128)
end
function class.OnCheckQiDianSid(A0_129, A1_130, A2_131)
  A0_129:EventTracer():Cancel("CHECK_QiDian_SID")
  if Logic:Get("Account"):OnError(A1_130, A2_131) then
    return
  end
  if nil == Logic:Get("Account"):OnError(A1_130, A2_131) or nil == Logic:Get("Account"):OnError(A1_130, A2_131).data.UserId then
    return
  end
  Logic:Get("Account"):SetNickName(Logic:Get("Account"):OnError(A1_130, A2_131).data.NickName)
  Logic:Get("Account"):SetAccName(tostring(Logic:Get("Account"):OnError(A1_130, A2_131).data.UserId))
  Logic:Get("Account"):SetPassword(CMd5(tostring(Logic:Get("Account"):OnError(A1_130, A2_131).data.UserId)):GetResult())
  Logic:Get("Account"):SetExt(A0_129.ExtSid)
  Logic:Get("Account"):CheckUser()
end
function class.CheckWan37Sid(A0_132, A1_133)
  local L2_134, L3_135, L4_136
  L2_134 = Logic
  L3_135 = L2_134
  L2_134 = L2_134.Get
  L4_136 = "System"
  L2_134 = L2_134(L3_135, L4_136)
  L3_135 = L2_134
  L2_134 = L2_134.GetOperatorItemFromFile
  L4_136 = "sdkInfo"
  L2_134 = L2_134(L3_135, L4_136, "config.dat")
  if nil ~= L2_134 then
    L3_135 = L2_134.SidHost
    if nil ~= L3_135 then
      L3_135 = L2_134.SidPort
      if nil ~= L3_135 then
        L3_135 = L2_134.SidAct
      end
    end
  elseif nil == L3_135 then
    L3_135 = log4misc
    L4_136 = L3_135
    L3_135 = L3_135.warn
    L3_135(L4_136, "sdk sid param config is empty")
    return
  end
  L3_135 = json
  L3_135 = L3_135.decode
  L4_136 = A1_133
  L3_135 = L3_135(L4_136)
  L4_136 = ITwHttp
  L4_136 = L4_136.Request
  L4_136 = L4_136()
  A0_132.ExtSid = A1_133
  L4_136.strHost = L2_134.SidHost
  L4_136.port = L2_134.SidPort
  L4_136.strMethod = "POST"
  L4_136.strAction = string.format(L2_134.SidAct, L3_135.pid, L3_135.gid, L3_135.token)
  L4_136.ucRetry = 0
  Singleton(NetHttp):On(L4_136.uReqId, A0_132:Event("CHECK_Wan37_SID", "OnCheckWan37Sid"))
  Singleton(NetHttp):Send(L4_136)
end
function class.OnCheckWan37Sid(A0_137, A1_138, A2_139)
  A0_137:EventTracer():Cancel("CHECK_Wan37_SID")
  if Logic:Get("Account"):OnError(A1_138, A2_139) then
    return
  end
  if nil == Logic:Get("Account"):OnError(A1_138, A2_139) or nil == Logic:Get("Account"):OnError(A1_138, A2_139).data.uid then
    return
  end
  Logic:Get("Account"):SetNickName(Logic:Get("Account"):OnError(A1_138, A2_139).data.disname)
  Logic:Get("Account"):SetAccName(tostring(Logic:Get("Account"):OnError(A1_138, A2_139).data.uid))
  Logic:Get("Account"):SetPassword(CMd5(tostring(Logic:Get("Account"):OnError(A1_138, A2_139).data.uid)):GetResult())
  Logic:Get("Account"):SetExt(A0_137.ExtSid)
  Logic:Get("Account"):CheckUser()
end
function class.CheckLeWanSid(A0_140, A1_141)
  if nil == A1_141 then
    return
  end
  Logic:Get("Account"):SetNickName(json.decode(A1_141).code)
  Logic:Get("Account"):SetAccName(tostring(json.decode(A1_141).code))
  Logic:Get("Account"):SetPassword(CMd5(tostring(json.decode(A1_141).code)):GetResult())
  Logic:Get("Account"):SetExt(A1_141)
  Logic:Get("Account"):CheckUser()
end
function class.CheckKuaiYongSid(A0_142, A1_143)
  local L2_144, L3_145, L4_146
  L2_144 = Logic
  L3_145 = L2_144
  L2_144 = L2_144.Get
  L4_146 = "System"
  L2_144 = L2_144(L3_145, L4_146)
  L3_145 = L2_144
  L2_144 = L2_144.GetOperatorItemFromFile
  L4_146 = "sdkInfo"
  L2_144 = L2_144(L3_145, L4_146, "config.dat")
  if nil ~= L2_144 then
    L3_145 = L2_144.SidHost
    if nil ~= L3_145 then
      L3_145 = L2_144.SidPort
      if nil ~= L3_145 then
        L3_145 = L2_144.SidAct
      end
    end
  elseif nil == L3_145 then
    L3_145 = log4misc
    L4_146 = L3_145
    L3_145 = L3_145.warn
    L3_145(L4_146, "sdk sid param config is empty")
    return
  end
  L3_145 = json
  L3_145 = L3_145.decode
  L4_146 = A1_143
  L3_145 = L3_145(L4_146)
  L4_146 = ITwHttp
  L4_146 = L4_146.Request
  L4_146 = L4_146()
  A0_142.ExtSid = A1_143
  L4_146.strHost = L2_144.SidHost
  L4_146.port = L2_144.SidPort
  L4_146.strMethod = "POST"
  L4_146.strAction = string.format(L2_144.SidAct, L3_145.tokenKey)
  L4_146.ucRetry = 0
  Singleton(NetHttp):On(L4_146.uReqId, A0_142:Event("CHECK_KuaiYong_SID", "OnCheckKuaiYongSid"))
  Singleton(NetHttp):Send(L4_146)
end
function class.OnCheckKuaiYongSid(A0_147, A1_148, A2_149)
  A0_147:EventTracer():Cancel("CHECK_KuaiYong_SID")
  if Logic:Get("Account"):OnError(A1_148, A2_149) then
    return
  end
  if nil == Logic:Get("Account"):OnError(A1_148, A2_149) or nil == Logic:Get("Account"):OnError(A1_148, A2_149).data.guid then
    return
  end
  Logic:Get("Account"):SetNickName(Logic:Get("Account"):OnError(A1_148, A2_149).data.username)
  Logic:Get("Account"):SetAccName(tostring(Logic:Get("Account"):OnError(A1_148, A2_149).data.guid))
  Logic:Get("Account"):SetPassword(CMd5(tostring(Logic:Get("Account"):OnError(A1_148, A2_149).data.guid)):GetResult())
  Logic:Get("Account"):SetExt(A0_147.ExtSid)
  Logic:Get("Account"):CheckUser()
end
function class.CheckPPSid(A0_150, A1_151)
  local L2_152, L3_153
  L2_152 = Logic
  L3_153 = L2_152
  L2_152 = L2_152.Get
  L2_152 = L2_152(L3_153, "System")
  L3_153 = L2_152
  L2_152 = L2_152.GetOperatorItemFromFile
  L2_152 = L2_152(L3_153, "sdkInfo", "config.dat")
  if nil ~= L2_152 then
    L3_153 = L2_152.SidHost
    if nil ~= L3_153 then
      L3_153 = L2_152.SidPort
      if nil ~= L3_153 then
        L3_153 = L2_152.SidAct
      end
    end
  elseif nil == L3_153 then
    L3_153 = log4misc
    L3_153 = L3_153.warn
    L3_153(L3_153, "sdk sid param config is empty")
    return
  end
  L3_153 = ITwHttp
  L3_153 = L3_153.Request
  L3_153 = L3_153()
  A0_150.ExtSid = A1_151
  L3_153.strHost = L2_152.SidHost
  L3_153.port = L2_152.SidPort
  L3_153.strMethod = "POST"
  L3_153.strAction = string.format(L2_152.SidAct, A1_151)
  L3_153.ucRetry = 0
  Singleton(NetHttp):On(L3_153.uReqId, A0_150:Event("CHECK_PP_SID", "OnCheckPPSid"))
  Singleton(NetHttp):Send(L3_153)
end
function class.OnCheckPPSid(A0_154, A1_155, A2_156)
  A0_154:EventTracer():Cancel("CHECK_PP_SID")
  if Logic:Get("Account"):OnError(A1_155, A2_156) then
    return
  end
  if nil == Logic:Get("Account"):OnError(A1_155, A2_156) or nil == Logic:Get("Account"):OnError(A1_155, A2_156).data.userid then
    return
  end
  Logic:Get("Account"):SetNickName(Logic:Get("Account"):OnError(A1_155, A2_156).data.username)
  Logic:Get("Account"):SetAccName(tostring(Logic:Get("Account"):OnError(A1_155, A2_156).data.userid))
  Logic:Get("Account"):SetPassword(CMd5(tostring(Logic:Get("Account"):OnError(A1_155, A2_156).data.userid)):GetResult())
  Logic:Get("Account"):SetExt(A0_154.ExtSid)
  Logic:Get("Account"):CheckUser()
end
function class.CheckKeNuoSid(A0_157, A1_158)
  local L2_159, L3_160
  L2_159 = Logic
  L3_160 = L2_159
  L2_159 = L2_159.Get
  L2_159 = L2_159(L3_160, "System")
  L3_160 = L2_159
  L2_159 = L2_159.GetOperatorItemFromFile
  L2_159 = L2_159(L3_160, "sdkInfo", "config.dat")
  if nil ~= L2_159 then
    L3_160 = L2_159.SidHost
    if nil ~= L3_160 then
      L3_160 = L2_159.SidPort
      if nil ~= L3_160 then
        L3_160 = L2_159.SidAct
      end
    end
  elseif nil == L3_160 then
    L3_160 = log4misc
    L3_160 = L3_160.warn
    L3_160(L3_160, "sdk sid param config is empty")
    return
  end
  L3_160 = ITwHttp
  L3_160 = L3_160.Request
  L3_160 = L3_160()
  L3_160.strHost = L2_159.SidHost
  L3_160.port = L2_159.SidPort
  L3_160.strMethod = "POST"
  L3_160.strAction = string.format(L2_159.SidAct, A1_158)
  L3_160.ucRetry = 0
  Singleton(NetHttp):On(L3_160.uReqId, A0_157:Event("CHECK_KENUO_SID", "OnCheckKeNuoSid"))
  Singleton(NetHttp):Send(L3_160)
end
function class.OnCheckKeNuoSid(A0_161, A1_162, A2_163)
  A0_161:EventTracer():Cancel("CHECK_KENUO_SID")
  if Logic:Get("Account"):OnError(A1_162, A2_163) then
    return
  end
  if nil == Logic:Get("Account"):OnError(A1_162, A2_163) or nil == Logic:Get("Account"):OnError(A1_162, A2_163).user or nil == Logic:Get("Account"):OnError(A1_162, A2_163).user.userId then
    return
  end
  Logic:Get("Account"):SetNickName(Logic:Get("Account"):OnError(A1_162, A2_163).user.username or "")
  Logic:Get("Account"):SetAccName(tostring(Logic:Get("Account"):OnError(A1_162, A2_163).user.userId))
  Logic:Get("Account"):SetPassword(CMd5(tostring(Logic:Get("Account"):OnError(A1_162, A2_163).user.userId)):GetResult())
  Logic:Get("Account"):CheckUser()
end
function class.CheckJuGameSid(A0_164, A1_165)
  local L2_166, L3_167, L4_168
  L2_166 = Logic
  L3_167 = L2_166
  L2_166 = L2_166.Get
  L4_168 = "System"
  L2_166 = L2_166(L3_167, L4_168)
  L3_167 = L2_166
  L2_166 = L2_166.GetOperatorItemFromFile
  L4_168 = "sdkInfo"
  L2_166 = L2_166(L3_167, L4_168, "config.dat")
  if nil ~= L2_166 then
    L3_167 = L2_166.SidHost
    if nil ~= L3_167 then
      L3_167 = L2_166.SidPort
      if nil ~= L3_167 then
        L3_167 = L2_166.SidAct
      end
    end
  elseif nil == L3_167 then
    L3_167 = log4misc
    L4_168 = L3_167
    L3_167 = L3_167.warn
    L3_167(L4_168, "sdk sid param config is empty")
    return
  end
  L3_167 = json
  L3_167 = L3_167.decode
  L4_168 = A1_165
  L3_167 = L3_167(L4_168)
  L4_168 = ITwHttp
  L4_168 = L4_168.Request
  L4_168 = L4_168()
  L4_168.strHost = L2_166.SidHost
  L4_168.port = L2_166.SidPort
  L4_168.strMethod = "POST"
  L4_168.strAction = string.format(L2_166.SidAct, L3_167.tkey)
  L4_168.ucRetry = 0
  Singleton(NetHttp):On(L4_168.uReqId, A0_164:Event("CHECK_JuGame_SID", "OnCheckJuGameSid"))
  Singleton(NetHttp):Send(L4_168)
end
function class.OnCheckJuGameSid(A0_169, A1_170, A2_171)
  local L3_172, L4_173, L5_174
  L4_173 = A0_169
  L3_172 = A0_169.EventTracer
  L3_172 = L3_172(L4_173)
  L4_173 = L3_172
  L3_172 = L3_172.Cancel
  L5_174 = "CHECK_JuGame_SID"
  L3_172(L4_173, L5_174)
  L3_172 = Logic
  L4_173 = L3_172
  L3_172 = L3_172.Get
  L5_174 = "Account"
  L3_172 = L3_172(L4_173, L5_174)
  L4_173 = L3_172
  L3_172 = L3_172.OnError
  L5_174 = A1_170
  L4_173 = L3_172(L4_173, L5_174, A2_171)
  if nil ~= L4_173 then
    L5_174 = L4_173.data
    L5_174 = L5_174.suid
  elseif nil == L5_174 then
    return
  end
  L5_174 = L4_173.data
  L5_174 = L5_174.nickName
  if nil == L5_174 or "" == L5_174 then
    L5_174 = tostring(L4_173.data.suid)
  end
  Logic:Get("Account"):SetNickName(L5_174)
  Logic:Get("Account"):SetAccName(tostring(L4_173.data.suid))
  Logic:Get("Account"):SetPassword(CMd5(tostring(L4_173.data.suid)):GetResult())
  Logic:Get("Account"):CheckUser()
end
function class.CheckEWanLoginSid(A0_175, A1_176)
  local L2_177, L3_178, L4_179
  L2_177 = Logic
  L3_178 = L2_177
  L2_177 = L2_177.Get
  L4_179 = "System"
  L2_177 = L2_177(L3_178, L4_179)
  L3_178 = L2_177
  L2_177 = L2_177.GetOperatorItemFromFile
  L4_179 = "sdkInfo"
  L2_177 = L2_177(L3_178, L4_179, "config.dat")
  if nil ~= L2_177 then
    L3_178 = L2_177.SidHost
    if nil ~= L3_178 then
      L3_178 = L2_177.SidPort
      if nil ~= L3_178 then
        L3_178 = L2_177.SidAct
      end
    end
  elseif nil == L3_178 then
    L3_178 = log4misc
    L4_179 = L3_178
    L3_178 = L3_178.warn
    L3_178(L4_179, "sdk sid param config is empty")
    return
  end
  L3_178 = json
  L3_178 = L3_178.decode
  L4_179 = A1_176
  L3_178 = L3_178(L4_179)
  L4_179 = ITwHttp
  L4_179 = L4_179.Request
  L4_179 = L4_179()
  L4_179.strHost = L2_177.SidHost
  L4_179.port = L2_177.SidPort
  L4_179.strMethod = "POST"
  Logic:Get("Account"):SetNickName(L3_178.NickName)
  L4_179.strAction = string.format(L2_177.SidAct, L3_178.tkey)
  L4_179.ucRetry = 0
  Singleton(NetHttp):On(L4_179.uReqId, A0_175:Event("CHECK_LOGIN_SID", "OnCheckEWanLoginSid"))
  Singleton(NetHttp):Send(L4_179)
end
function class.OnCheckEWanLoginSid(A0_180, A1_181, A2_182)
  A0_180:EventTracer():Cancel("CHECK_LOGIN_SID")
  if Logic:Get("Account"):OnError(A1_181, A2_182) then
    return
  end
  if nil == Logic:Get("Account"):OnError(A1_181, A2_182) or nil == Logic:Get("Account"):OnError(A1_181, A2_182).data.UserId then
    return
  end
  Logic:Get("Account"):SetAccName(tostring(Logic:Get("Account"):OnError(A1_181, A2_182).data.UserId))
  Logic:Get("Account"):SetPassword(CMd5(tostring(Logic:Get("Account"):OnError(A1_181, A2_182).data.UserId)):GetResult())
  Logic:Get("Account"):CheckUser()
end
function class.CheckLoginSid(A0_183, A1_184)
  local L2_185, L3_186, L4_187, L5_188
  L2_185 = Logic
  L3_186 = L2_185
  L2_185 = L2_185.Get
  L4_187 = "System"
  L2_185 = L2_185(L3_186, L4_187)
  L3_186 = L2_185
  L2_185 = L2_185.GetOperatorItemFromFile
  L4_187 = "sdkInfo"
  L5_188 = "config.dat"
  L2_185 = L2_185(L3_186, L4_187, L5_188)
  if nil ~= L2_185 then
    L3_186 = L2_185.SidHost
    if nil ~= L3_186 then
      L3_186 = L2_185.SidPort
      if nil ~= L3_186 then
        L3_186 = L2_185.SidAct
      end
    end
  elseif nil == L3_186 then
    L3_186 = log4misc
    L4_187 = L3_186
    L3_186 = L3_186.warn
    L5_188 = "sdk sid param config is empty"
    L3_186(L4_187, L5_188)
    return
  end
  L3_186 = json
  L3_186 = L3_186.decode
  L4_187 = A1_184
  L3_186 = L3_186(L4_187)
  L4_187 = ITwHttp
  L4_187 = L4_187.Request
  L4_187 = L4_187()
  A0_183.ExtSid = A1_184
  L5_188 = L2_185.SidHost
  L4_187.strHost = L5_188
  L5_188 = L2_185.SidPort
  L4_187.port = L5_188
  L4_187.strMethod = "POST"
  L5_188 = require
  L5_188 = L5_188("socket.url")
  L5_188 = L5_188.escape
  L5_188 = L5_188(L3_186.tkey)
  L4_187.strAction = L2_185.SidAct .. L5_188
  L4_187.ucRetry = 0
  Singleton(NetHttp):On(L4_187.uReqId, A0_183:Event("CHECK_LOGIN_SID", "OnCheckLoginSid"))
  Singleton(NetHttp):Send(L4_187)
end
function class.OnCheckLoginSid(A0_189, A1_190, A2_191)
  A0_189:EventTracer():Cancel("CHECK_LOGIN_SID")
  if Logic:Get("Account"):OnError(A1_190, A2_191) then
    return
  end
  if nil == Logic:Get("Account"):OnError(A1_190, A2_191) or nil == Logic:Get("Account"):OnError(A1_190, A2_191).data.UserId then
    return
  end
  Logic:Get("Account"):SetNickName(Logic:Get("Account"):OnError(A1_190, A2_191).data.NickName)
  Logic:Get("Account"):SetAccName(tostring(Logic:Get("Account"):OnError(A1_190, A2_191).data.UserId))
  Logic:Get("Account"):SetPassword(CMd5(tostring(Logic:Get("Account"):OnError(A1_190, A2_191).data.UserId)):GetResult())
  Logic:Get("Account"):SetExt(A0_189.ExtSid)
  Logic:Get("Account"):CheckUser()
end
function class.SetSdkFuncStatus(A0_192, A1_193, A2_194)
  if nil == A1_193 or nil == A2_194 then
    return
  end
  A0_192.sdkFuncStatus[A1_193] = A2_194
end
function class.CheckSdkFuncOpen(A0_195, A1_196)
  local L2_197
  if nil == A1_196 then
    L2_197 = false
    return L2_197
  end
  L2_197 = A0_195.sdkFuncStatus
  L2_197 = L2_197[A1_196]
  if nil ~= L2_197 then
    L2_197 = A0_195.sdkFuncStatus
    L2_197 = L2_197[A1_196]
    L2_197 = 1 == L2_197
    return L2_197
  end
  L2_197 = rawget
  L2_197 = L2_197(_G, "REFLECT_EVENT_CHECK_SDK_FUNC")
  if nil == L2_197 then
    return false
  end
  CReflectSystem:GetSingleton():FireEvent(TwReflectEvtArgs(L2_197, 0, 0, A1_196))
  return 1 == A0_195.sdkFuncStatus[A1_196]
end
function class.SendAdvertisement(A0_198)
  local L1_199, L2_200, L3_201, L4_202, L5_203, L6_204
  L1_199 = Logic
  L2_200 = L1_199
  L1_199 = L1_199.Get
  L3_201 = "System"
  L1_199 = L1_199(L2_200, L3_201)
  L2_200 = L1_199
  L1_199 = L1_199.IsOperator
  L3_201 = "appstore"
  L1_199 = L1_199(L2_200, L3_201)
  if not L1_199 then
    return
  end
  L1_199 = Logic
  L2_200 = L1_199
  L1_199 = L1_199.Get
  L3_201 = "System"
  L1_199 = L1_199(L2_200, L3_201)
  L2_200 = L1_199
  L1_199 = L1_199.GetVariableMisc
  L3_201 = "sendAdvert"
  L4_202 = true
  L1_199 = L1_199(L2_200, L3_201, L4_202)
  if L1_199 ~= nil then
    return
  end
  L1_199 = Logic
  L2_200 = L1_199
  L1_199 = L1_199.Get
  L3_201 = "System"
  L1_199 = L1_199(L2_200, L3_201)
  L2_200 = L1_199
  L1_199 = L1_199.GetOperatorItemFromFile
  L3_201 = "advertisement"
  L4_202 = "config.dat"
  L1_199 = L1_199(L2_200, L3_201, L4_202)
  if nil == L1_199 then
    return
  end
  L2_200 = Logic
  L3_201 = L2_200
  L2_200 = L2_200.Get
  L4_202 = "System"
  L2_200 = L2_200(L3_201, L4_202)
  L3_201 = L2_200
  L2_200 = L2_200.GetIdfa
  L2_200 = L2_200(L3_201)
  L2_200 = L2_200 or ""
  L3_201 = Logic
  L4_202 = L3_201
  L3_201 = L3_201.Get
  L5_203 = "System"
  L3_201 = L3_201(L4_202, L5_203)
  L4_202 = L3_201
  L3_201 = L3_201.GetMacAddr
  L3_201 = L3_201(L4_202)
  L3_201 = L3_201 or ""
  L4_202 = Logic
  L5_203 = L4_202
  L4_202 = L4_202.Get
  L6_204 = "System"
  L4_202 = L4_202(L5_203, L6_204)
  L5_203 = L4_202
  L4_202 = L4_202.GetUniqueId
  L4_202 = L4_202(L5_203)
  L4_202 = L4_202 or ""
  L5_203 = CMd5
  L6_204 = "AXCCC!9212359@21abc3efV"
  L6_204 = L6_204 .. L3_201 .. L2_200 .. L4_202
  L5_203 = L5_203(L6_204)
  L6_204 = L5_203
  L5_203 = L5_203.GetResult
  L5_203 = L5_203(L6_204)
  L6_204 = ITwHttp
  L6_204 = L6_204.Request
  L6_204 = L6_204()
  L6_204.strHost = L1_199.host
  L6_204.port = L1_199.port
  L6_204.strMethod = "POST"
  L6_204.strAction = string.format(L1_199.act .. "&uuid=%s&sign=%s", L3_201, L2_200, L4_202, L5_203)
  Singleton(NetHttp):On(L6_204.uReqId, A0_198:Event("SEND_ADVERTISEMENT", "OnSendAdvertisement"))
  Singleton(NetHttp):Send(L6_204, false)
end
function class.OnSendAdvertisement(A0_205, A1_206, A2_207)
  A0_205:EventTracer():Cancel("SEND_ADVERTISEMENT")
  if 0 ~= A1_206 then
    return
  end
  Logic:Get("System"):SetVariableMisc("sendAdvert", true, true)
  Logic:Get("System"):SaveSysVariable()
end
function class.SetFBShareRst(A0_208, A1_209)
  if nil == A1_209 or "" == A1_209 then
    return
  end
  if nil == json.decode(A1_209) or nil == json.decode(A1_209).id then
    return
  end
  Logic:Get("WeChat"):PostShare()
end
function class.RefreshMoneyDelay(A0_210)
  local L1_211, L2_212, L3_213
  function L1_211()
    _UPVALUE0_.refreshMoney = {
      time = {
        3,
        3,
        3,
        6,
        10
      },
      idx = 1,
      money = 0
    }
    _UPVALUE0_:EventTracer():Cancel("GET_RECHARGE")
  end
  L2_212 = L1_211
  L2_212()
  L2_212 = A0_210.refreshMoney
  L3_213 = Logic
  L3_213 = L3_213.Get
  L3_213 = L3_213(L3_213, "PlayerInfo")
  L3_213 = L3_213.GetPlayerAllJade
  L3_213 = L3_213(L3_213)
  L2_212.money = L3_213
  L2_212 = A0_210.refreshMoney
  L2_212 = L2_212.time
  L3_213 = A0_210.refreshMoney
  L3_213 = L3_213.idx
  L2_212 = L2_212[L3_213]
  L3_213 = A0_210.refreshMoney
  L3_213.idx = A0_210.refreshMoney.idx + 1
  function L3_213()
    Logic:Get("PlayerInfo"):PostGetVip()
    _UPVALUE0_.refreshMoney.idx = _UPVALUE0_.refreshMoney.idx + 1
    if _UPVALUE0_.refreshMoney.time[_UPVALUE0_.refreshMoney.idx] == nil or Logic:Get("PlayerInfo"):GetPlayerAllJade() ~= _UPVALUE0_.refreshMoney.money then
      _UPVALUE0_:EventTracer():Cancel("GET_RECHARGE")
      return
    end
    Singleton(Timer):After(_UPVALUE0_.refreshMoney.time[_UPVALUE0_.refreshMoney.idx] * 1000, _UPVALUE0_:Event("GET_RECHARGE", _UPVALUE1_))
  end
  Singleton(Timer):After(L2_212 * 1000, A0_210:Event("GET_RECHARGE", L3_213))
end
function class.SetWeixinShareRst(A0_214, A1_215)
  if nil == A1_215 or "" == A1_215 then
    return
  end
  if json.decode(A1_215).WeixinCode == "0" then
    Logic:Get("WeChat"):PostShare()
    return
  end
  if json.decode(A1_215).bWeixinInstall == "0" then
    Prompt:Fail(110707)
    return
  end
  if json.decode(A1_215).bWeixinOpenApi == "1" then
  end
  if json.decode(A1_215).WeixinInstallUrl ~= nil then
  end
  if json.decode(A1_215).WeixinVersion ~= nil then
  end
end
function class.GetWeixinInfo(A0_216)
  local L1_217
  L1_217 = {}
  L1_217.Scene = "GetWeixinInfo"
  if rawget(_G, "REFLECT_EVENT_WEIXIN_SHARE") ~= nil then
    CReflectSystem:GetSingleton():FireEvent(TwReflectEvtArgs(REFLECT_EVENT_WEIXIN_SHARE, 0, 0, json.encode(L1_217)))
  end
end
function class.WeixinShareLink(A0_218, A1_219, A2_220, A3_221, A4_222)
  local L5_223
  L5_223 = {}
  L5_223.Title = A1_219 or ""
  L5_223.Desc = A2_220 or ""
  L5_223.PageUrl = A3_221 or ""
  L5_223.ImagePath = A4_222 or "Icon.png"
  L5_223.Scene = "Friends"
  L5_223.ShareType = "Link"
  if rawget(_G, "REFLECT_EVENT_WEIXIN_SHARE") ~= nil then
    CReflectSystem:GetSingleton():FireEvent(TwReflectEvtArgs(REFLECT_EVENT_WEIXIN_SHARE, 0, 0, json.encode(L5_223)))
  end
end
function class.WeixinShareText(A0_224, A1_225)
  local L2_226
  L2_226 = {}
  L2_226.Text = A1_225 or ""
  L2_226.Scene = "Friends"
  L2_226.ShareType = "Text"
  if rawget(_G, "REFLECT_EVENT_WEIXIN_SHARE") ~= nil then
    CReflectSystem:GetSingleton():FireEvent(TwReflectEvtArgs(REFLECT_EVENT_WEIXIN_SHARE, 0, 0, json.encode(L2_226)))
  end
end
function class.ConvertServerLstPop18(A0_227, A1_228)
  local L2_229, L3_230
  if nil == A1_228 then
    return
  end
  L2_229 = json
  L2_229 = L2_229.decode
  L3_230 = A1_228
  L2_229 = L2_229(L3_230)
  L3_230 = {}
  L3_230.list = {}
  for _FORV_7_ = 1, #L2_229 do
    table.insert(L3_230.list, {
      server = tonumber(L2_229[_FORV_7_].code),
      addr = L2_229[_FORV_7_].host,
      port = tonumber(L2_229[_FORV_7_].port),
      name = L2_229[_FORV_7_].name
    })
  end
  return _FOR_.encode(L3_230)
end
