local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("Logic")
L0_0 = Logic
L0_0 = L0_0.class
L0_0 = L0_0.subclass
L0_0 = L0_0(L0_0)
class = L0_0
L0_0 = Enum
L0_0 = L0_0({"MOON_INFO", "EXHCNAGE"})
EVT = L0_0
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.moon.facade.MoonResult")
function class.initialize(A0_1)
  super.initialize(A0_1)
  A0_1.bags = {
    moon = {},
    spring = {}
  }
  A0_1.groupData = {}
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgMoon", _UPVALUE0_, _UPVALUE1_)
  MsgMoon:On("MOON_INFO", A0_1:Event("OnMoonInfoMoon"))
  MsgMoon:On("COMPOSE_MOON", A0_1:Event("OnComposeMoonMoon"))
  MsgMoon:On("BUY_MOON", A0_1:Event("OnBuyMoonMoon"))
  MsgMoon:On("EXHCNAGE", A0_1:Event("OnExchangeMoon"))
  if MsgSpring then
    Logic:Get("MsgAssist"):RecordErrorMsg("MsgSpring", _UPVALUE0_, _UPVALUE1_)
    MsgSpring:On("MOON_INFO", A0_1:Event("OnMoonInfoSpring"))
    MsgSpring:On("COMPOSE_MOON", A0_1:Event("OnComposeMoonSpring"))
    MsgSpring:On("BUY_MOON", A0_1:Event("OnBuyMoonSpring"))
    MsgSpring:On("EXHCNAGE", A0_1:Event("OnExchangeSpring"))
  end
end
function class.dispose(A0_2)
  super.dispose(A0_2)
end
function class.isSpring(A0_3)
  return (Logic:Get("Gift"):GetActivityGift() or {}).activityType == "SPRING" or (Logic:Get("Gift"):GetActivityGift() or {}).activityType == "SPRING_SHARE"
end
function class.bagKey(A0_4)
  if A0_4:isSpring() then
    return "spring"
  end
  return "moon"
end
function class.net(A0_5)
  if A0_5:bagKey() == "spring" and MsgSpring then
    return MsgSpring
  end
  return MsgMoon
end
function class.GetMoonCount(A0_6)
  local L1_7
  L1_7 = A0_6.bags
  L1_7 = L1_7[A0_6:bagKey()]
  if table.empty(L1_7 or {}) then
    return {}
  end
  return L1_7.count or {}
end
function class.GetMoonPost(A0_8)
  local L1_9
  L1_9 = A0_8.bags
  L1_9 = L1_9[A0_8:bagKey()]
  if table.empty(L1_9 or {}) then
    return {}
  end
  return L1_9.post or {}
end
function class.SetGroupData(A0_10, A1_11)
  A0_10.groupData = A1_11 or {}
end
function class.GetGroupData(A0_12)
  local L1_13
  L1_13 = A0_12.groupData
  return L1_13
end
function class.PostMoonInfo(A0_14)
  A0_14:net():Post("MOON_INFO")
end
function class.PostComposeMoon(A0_15, A1_16)
  A0_15:net():Post("COMPOSE_MOON", {count = A1_16})
end
function class.PostBuyMoon(A0_17, A1_18, A2_19)
  A0_17:net():Post("BUY_MOON", {count = A1_18, type = A2_19})
end
function class.PostExchange(A0_20, A1_21)
  A0_20:net():Post("EXHCNAGE", {group = A1_21})
end
function class.OnMoonInfoMoon(A0_22, A1_23, A2_24)
  A0_22:storeInfo("moon", A1_23, A2_24)
end
function class.OnMoonInfoSpring(A0_25, A1_26, A2_27)
  A0_25:storeInfo("spring", A1_26, A2_27)
end
function class.storeInfo(A0_28, A1_29, A2_30, A3_31)
  if A2_30 ~= 0 then
    return
  end
  A0_28.bags[A1_29] = A3_31 or {}
  A0_28:FireEvent(EVT.MOON_INFO)
end
function class.OnComposeMoonMoon(A0_32, A1_33, A2_34)
  A0_32:storeCompose("moon", A1_33, A2_34)
end
function class.OnComposeMoonSpring(A0_35, A1_36, A2_37)
  A0_35:storeCompose("spring", A1_36, A2_37)
end
function class.storeCompose(A0_38, A1_39, A2_40, A3_41)
  if A2_40 ~= 0 then
    return
  end
  A0_38.bags[A1_39] = A0_38.bags[A1_39] or {}
  A0_38.bags[A1_39].count = A3_41.curCount
  if A1_39 == "moon" then
    Prompt:Msg(string.format("\230\129\173\229\150\156\232\142\183\229\190\151\230\156\136\233\165\188%d\228\184\170!", A3_41.composeCount or 1))
  else
    Prompt:Msg(TwGetStr(115004, A3_41.composeCount or 1))
  end
  A0_38:FireEvent(EVT.MOON_INFO)
end
function class.OnBuyMoonMoon(A0_42, A1_43, A2_44)
  A0_42:storeBuy("moon", A1_43, A2_44)
end
function class.OnBuyMoonSpring(A0_45, A1_46, A2_47)
  A0_45:storeBuy("spring", A1_46, A2_47)
end
function class.storeBuy(A0_48, A1_49, A2_50, A3_51)
  if A2_50 ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(A3_51.costs)
  A0_48.bags[A1_49] = A0_48.bags[A1_49] or {}
  A0_48.bags[A1_49].count = A3_51.curCount
  Prompt:Msg(TwGetStr(105207))
  A0_48:FireEvent(EVT.MOON_INFO)
end
function class.OnExchangeMoon(A0_52, A1_53, A2_54)
  A0_52:storeExchange("moon", A1_53, A2_54)
end
function class.OnExchangeSpring(A0_55, A1_56, A2_57)
  A0_55:storeExchange("spring", A1_56, A2_57)
end
function class.storeExchange(A0_58, A1_59, A2_60, A3_61)
  local L4_62
  if A2_60 ~= 0 then
    return
  end
  L4_62 = Logic
  L4_62 = L4_62.Get
  L4_62 = L4_62(L4_62, "Cost")
  L4_62 = L4_62.AddCosts
  L4_62(L4_62, A3_61.costResults)
  L4_62 = Logic
  L4_62 = L4_62.Get
  L4_62 = L4_62(L4_62, "Reward")
  L4_62 = L4_62.AddRewards
  L4_62(L4_62, A3_61.rewardResults)
  L4_62 = A0_58.bags
  L4_62[A1_59] = A0_58.bags[A1_59] or {}
  L4_62 = A0_58.bags
  L4_62 = L4_62[A1_59]
  L4_62.count = A3_61.curCount
  L4_62 = Logic
  L4_62 = L4_62.Get
  L4_62 = L4_62(L4_62, "Reward")
  L4_62 = L4_62.AddDupiCardTip
  L4_62 = L4_62(L4_62, A3_61.rewardResults)
  Prompt:Msg(L4_62)
  A0_58:FireEvent(EVT.EXHCNAGE)
end
function class.ApplyCakeArt(A0_63, A1_64)
end
