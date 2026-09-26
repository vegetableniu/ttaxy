local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = Logic
L0_0 = L0_0.class
L0_0 = L0_0.subclass
L0_0 = L0_0(L0_0)
class = L0_0
L0_0 = Enum
L0_0 = L0_0({
  "GET_LOAD_INFO",
  "EXCHANGE_SUCCESS"
})
EVT = L0_0
L0_0 = Enum
L0_0 = L0_0(TypeDef("com.eyu.mt.module.exchange.facade.ExchangeResult"))
function class.initialize(A0_1, ...)
  super.initialize(A0_1, ...)
  A0_1:initParam()
  A0_1:registerEvent()
end
function class.dispose(A0_3)
  super.dispose(A0_3)
end
function class.initParam(A0_4)
  A0_4.loadInfo = {}
  A0_4.goodsId = nil
end
function class.registerEvent(A0_5)
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgExchange", _UPVALUE0_, _UPVALUE1_)
  MsgExchange:On("LOAD_INFO", A0_5:Event("OnLoadInfo"))
  MsgExchange:On("LOAD_EXCHANGE", A0_5:Event("OnLoadExchange"))
end
function class.PostLoadInfo(A0_6, A1_7)
  MsgExchange:Post("LOAD_INFO", {activityId = A1_7})
end
function class.OnLoadInfo(A0_8, A1_9, A2_10)
  if A1_9 == 0 then
    A0_8.loadInfo = A2_10
    Logic:Get("HallowmasShop"):setSweet(A2_10.sweets)
    A0_8:FireEvent(EVT.GET_LOAD_INFO)
  end
end
function class.PostLoadExchange(A0_11, A1_12, A2_13)
  A0_11.goodsId = A2_13
  MsgExchange:Post("LOAD_EXCHANGE", {heros = A1_12, id = A2_13})
end
function class.OnLoadExchange(A0_14, A1_15, A2_16)
  local L3_17
  if A1_15 == 0 then
    L3_17 = Logic
    L3_17 = L3_17.Get
    L3_17 = L3_17(L3_17, "Cost")
    L3_17 = L3_17.AddCosts
    L3_17(L3_17, A2_16.costResults)
    L3_17 = Logic
    L3_17 = L3_17.Get
    L3_17 = L3_17(L3_17, "Reward")
    L3_17 = L3_17.AddRewards
    L3_17(L3_17, A2_16.rewardResults)
    L3_17 = Logic
    L3_17 = L3_17.Get
    L3_17 = L3_17(L3_17, "Reward")
    L3_17 = L3_17.AddDupiCardTip
    L3_17 = L3_17(L3_17, A2_16.rewardResults)
    Prompt:Fail(L3_17)
    A0_14:addBuyTimes()
    A0_14:FireEvent(EVT.EXCHANGE_SUCCESS)
  end
end
function class.GetExchangeCards(A0_18, A1_19)
  local L2_20, L3_21, L4_22, L5_23, L6_24
  if not A1_19 then
    return
  end
  L2_20 = {}
  for L6_24 = 1, L4_22(L5_23) do
    if (KFDBGetRecordByIdx("ExchangeSetting", L6_24) or {}) and (KFDBGetRecordByIdx("ExchangeSetting", L6_24) or {}).activity == A1_19 then
      L2_20.mainCard = (KFDBGetRecordByIdx("ExchangeSetting", L6_24) or {}).rewardId
      L2_20.material = json.decode((KFDBGetRecordByIdx("ExchangeSetting", L6_24) or {}).costItems or "") or {}
      L2_20.stars = json.decode((KFDBGetRecordByIdx("ExchangeSetting", L6_24) or {}).costMinStar or "") or {}
      L2_20.cards = json.decode((KFDBGetRecordByIdx("ExchangeSetting", L6_24) or {}).costSameNameId or "") or {}
      L2_20.id = (KFDBGetRecordByIdx("ExchangeSetting", L6_24) or {}).id
      L2_20.level = (KFDBGetRecordByIdx("ExchangeSetting", L6_24) or {}).level
      return L2_20
    end
  end
  return L2_20
end
function class.GetExchangeRestCount(A0_25, A1_26)
  local L2_27
  if not A1_26 then
    L2_27 = 0
    return L2_27
  end
  L2_27 = A0_25.loadInfo
  if L2_27 then
    L2_27 = A0_25.loadInfo
    L2_27 = L2_27.buyTimes
    L2_27 = L2_27[A1_26]
  else
    L2_27 = L2_27 or 0
  end
  return ((KFDBGetRecord("ExchangeSetting", A1_26) or {}).limit or 0) - L2_27
end
function class.addBuyTimes(A0_28)
  local L1_29, L2_30, L3_31
  L1_29 = A0_28.loadInfo
  L1_29 = L1_29.buyTimes
  L2_30 = A0_28.goodsId
  L1_29 = L1_29[L2_30]
  if L1_29 == nil then
    L1_29 = A0_28.loadInfo
    L1_29 = L1_29.buyTimes
    L2_30 = A0_28.goodsId
    L1_29[L2_30] = 1
  else
    L1_29 = A0_28.loadInfo
    L1_29 = L1_29.buyTimes
    L2_30 = A0_28.goodsId
    L3_31 = A0_28.loadInfo
    L3_31 = L3_31.buyTimes
    L3_31 = L3_31[A0_28.goodsId]
    L3_31 = L3_31 + 1
    L1_29[L2_30] = L3_31
  end
end
function class.GetComsumeList(A0_32, A1_33)
  local L2_34, L3_35, L4_36, L5_37, L6_38, L7_39, L8_40, L9_41, L10_42
  if not A1_33 then
    return
  end
  L2_34 = A1_33.cards
  L2_34 = L2_34 or {}
  L3_35 = A1_33.stars
  L3_35 = L3_35 or {}
  L4_36 = {}
  L5_37 = {}
  for L9_41, L10_42 in L6_38(L7_39) do
    A0_32:GetComsumeCard(L10_42, L3_35[L9_41], L4_36)
  end
  return L4_36
end
function class.GetComsumeCard(A0_43, A1_44, A2_45, A3_46)
  local L4_47, L5_48, L6_49, L7_50, L8_51, L9_52, L10_53, L11_54
  if not A1_44 or not A2_45 then
    return
  end
  L4_47 = A1_44
  L5_48 = A2_45
  L6_49 = Logic
  L6_49 = L6_49.Get
  L6_49 = L6_49(L7_50, L8_51)
  L6_49 = L6_49.GetUnbattlingHero
  L6_49 = L6_49(L7_50, L8_51)
  L6_49 = L7_50
  L6_49 = L7_50
  for L10_53, L11_54 in L7_50(L8_51) do
    if (Logic:Get("Hero"):GetHeroInfoByBaseId(L11_54.baseId) or {}).sameNameId == L4_47 and L5_48 <= (Logic:Get("Hero"):GetHeroInfoByBaseId(L11_54.baseId) or {}).star then
      table.insert(A3_46, L11_54)
      break
    end
  end
end
function class.sort(A0_55, A1_56)
  table.sort(A1_56, function(A0_57, A1_58)
    if not Logic:Get("Hero"):GetHeroInfoByBaseId(A0_57.baseId) or not Logic:Get("Hero"):GetHeroInfoByBaseId(A1_58.baseId) then
      return false
    elseif Logic:Get("Hero"):GetHeroInfoByBaseId(A0_57.baseId).star == Logic:Get("Hero"):GetHeroInfoByBaseId(A1_58.baseId).star then
      if A0_57.level == A1_58.level then
        return A0_57.baseId > A1_58.baseId
      else
        return A0_57.level < A1_58.level
      end
    else
      return Logic:Get("Hero"):GetHeroInfoByBaseId(A0_57.baseId).star < Logic:Get("Hero"):GetHeroInfoByBaseId(A1_58.baseId).star
    end
  end)
  return A1_56
end
