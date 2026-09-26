module((...), package.seeall)
class = Logic.class:subclass()
EVT = Enum({
  "ON_GET_CARDS",
  "ON_EXCHANGE",
  "MSG_UPDATE_LIST",
  "MSG_POP_TIP"
})
function class.initialize(A0_0, ...)
  super.initialize(A0_0, ...)
  A0_0:initParam()
  A0_0:registerEvent()
end
function class.dispose(A0_2)
  super.dispose(A0_2)
end
function class.initParam(A0_3)
  local L1_4
  L1_4 = {}
  A0_3.cards = L1_4
  L1_4 = {}
  A0_3.tempCards = L1_4
  L1_4 = {}
  A0_3.cardsMap = L1_4
end
function class.registerEvent(A0_5)
  local L1_6, L2_7, L3_8
  L1_6 = MsgHero
  L2_7 = L1_6
  L1_6 = L1_6.On
  L3_8 = "GET_RED_CARD_EXCHANGE_INFO"
  L1_6(L2_7, L3_8, A0_5:Event("OnGetCards"))
  L1_6 = MsgHero
  L2_7 = L1_6
  L1_6 = L1_6.On
  L3_8 = "RED_CARD_EXCHANGE"
  L1_6(L2_7, L3_8, A0_5:Event("OnExchanged"))
end
function class.PostGetCards(A0_9)
  MsgHero:Post("GET_RED_CARD_EXCHANGE_INFO")
end
function class.OnGetCards(A0_10, A1_11, A2_12)
  A0_10.cardsMap = A2_12
  A0_10:FireEvent(EVT.ON_GET_CARDS)
end
function class.PostExchange(A0_13, A1_14)
  local L2_15, L3_16, L4_17, L5_18
  if not A1_14 then
    return
  end
  L3_16 = A0_13
  L2_15 = A0_13.GetExchangeCards
  L4_17 = A1_14
  L2_15 = L2_15(L3_16, L4_17)
  L3_16 = Logic
  L4_17 = L3_16
  L3_16 = L3_16.Get
  L5_18 = "Hero"
  L3_16 = L3_16(L4_17, L5_18)
  L4_17 = L3_16
  L3_16 = L3_16.GetHeroInfosByIds
  L5_18 = A0_13.cards
  L5_18 = L5_18 or {}
  L3_16 = L3_16(L4_17, L5_18)
  L3_16 = L3_16 or {}
  L5_18 = A0_13
  L4_17 = A0_13.MatchExchangeMaterials
  L5_18 = L4_17(L5_18, L2_15, L3_16)
  for _FORV_9_, _FORV_10_ in ipairs(L5_18) do
    if _FORV_10_ == 0 then
      Prompt:Tip(TwGetStr(114007))
      return
    end
  end
  MsgHero:Post("RED_CARD_EXCHANGE", {configId = A1_14, costHeroIds = L4_17})
end
function class.OnExchanged(A0_19, A1_20, A2_21)
  local L3_22
  if not A2_21 then
    return
  end
  L3_22 = Logic
  L3_22 = L3_22.Get
  L3_22 = L3_22(L3_22, "Cost")
  L3_22 = L3_22.CostAndReward
  L3_22(L3_22, A2_21.costAndReward)
  L3_22 = A2_21.exchangeRecord
  L3_22 = L3_22 or {}
  A0_19.cardsMap = L3_22
  L3_22 = A0_19.ClearCards
  L3_22(A0_19)
  L3_22 = Logic
  L3_22 = L3_22.Get
  L3_22 = L3_22(L3_22, "Reward")
  L3_22 = L3_22.AddRewardsTip
  L3_22 = L3_22(L3_22, A2_21.costAndReward.rewards)
  A0_19:FireEvent(EVT.ON_EXCHANGE, L3_22)
end
function class.GetExchangeCards(A0_23, A1_24)
  local L2_25
  if not A1_24 then
    return
  end
  L2_25 = {}
  L2_25.mainCard = tonumber((KFDBGetRecord("RedCardExchange", A1_24) or {}).heroId) or (KFDBGetRecord("RedCardExchange", A1_24) or {}).heroId
  L2_25.stars = json.decode((KFDBGetRecord("RedCardExchange", A1_24) or {}).costMinStar or "") or {}
  L2_25.cards = json.decode((KFDBGetRecord("RedCardExchange", A1_24) or {}).costSameNameId or "") or {}
  return L2_25
end
function class.GetExchangeIdByDestId(A0_26, A1_27)
  local L2_28, L3_29, L4_30, L5_31
  if not A1_27 then
    return
  end
  for L5_31 = 1, L3_29(L4_30) do
    if (KFDBGetRecordByIdx("RedCardExchange", L5_31) or {}).heroId == A1_27 then
      return (KFDBGetRecordByIdx("RedCardExchange", L5_31) or {}).id
    end
  end
end
function class.AddCard(A0_32, A1_33)
  if not A1_33 then
    return
  end
  if not A0_32:IsSelected(A1_33) then
    table.insert(A0_32.tempCards, A1_33)
  end
end
function class.RemoveCard(A0_34, A1_35)
  local L2_36, L3_37
  L3_37 = A0_34
  L2_36 = A0_34.IsSelected
  L3_37 = L2_36(L3_37, A1_35)
  if L2_36 then
    table.remove(A0_34.tempCards, L3_37)
  end
end
function class.IsSelected(A0_38, A1_39)
  local L2_40, L3_41, L4_42, L5_43
  if not A1_39 then
    return
  end
  for L5_43, _FORV_6_ in L2_40(L3_41) do
    if A1_39 == _FORV_6_ then
      return true, L5_43
    end
  end
  return L2_40
end
function class.loadToCards(A0_44)
  A0_44.cards = table.values(A0_44.tempCards) or {}
end
function class.loadToTempCards(A0_45)
  A0_45.tempCards = table.values(A0_45.cards) or {}
end
function class.ClearCards(A0_46)
  local L1_47
  L1_47 = {}
  A0_46.cards = L1_47
  L1_47 = {}
  A0_46.tempCards = L1_47
end
function class.ClearExchangeIds(A0_48)
  A0_48.exchangeIds = {}
end
function class.GetSelectedCards(A0_49)
  local L1_50
  L1_50 = A0_49.tempCards
  L1_50 = L1_50 or {}
  A0_49.tempCards = L1_50
  L1_50 = A0_49.tempCards
  return L1_50, #A0_49.tempCards
end
function class.IsSameName(A0_51, A1_52)
  local L2_53, L3_54, L4_55, L5_56, L6_57, L7_58, L8_59, L9_60
  if not A1_52 then
    return
  end
  L2_53 = Logic
  L3_54 = L2_53
  L2_53 = L2_53.Get
  L4_55 = "Hero"
  L2_53 = L2_53(L3_54, L4_55)
  L3_54 = L2_53
  L2_53 = L2_53.GetHeroInfoById
  L4_55 = A1_52
  L2_53 = L2_53(L3_54, L4_55)
  L2_53 = L2_53 or {}
  L3_54 = Logic
  L4_55 = L3_54
  L3_54 = L3_54.Get
  L3_54 = L3_54(L4_55, L5_56)
  L4_55 = L3_54
  L3_54 = L3_54.GetHeroInfoByBaseId
  L3_54 = L3_54(L4_55, L5_56)
  L3_54 = L3_54 or {}
  L4_55 = L3_54.sameNameId
  for L8_59, L9_60 in L5_56(L6_57) do
    if L4_55 == (Logic:Get("Hero"):GetHeroInfoByBaseId((Logic:Get("Hero"):GetHeroInfoById(L9_60) or {}).baseId) or {}).sameNameId and A1_52 ~= L9_60 then
      return true
    end
  end
end
function class.GetExchangeCardsInfo(A0_61)
  local L1_62, L2_63
  L1_62 = A0_61.cards
  L1_62 = #L1_62
  if L1_62 == 0 then
    return
  end
  L1_62 = ""
  L2_63 = Logic
  L2_63 = L2_63.Get
  L2_63 = L2_63(L2_63, "Hero")
  L2_63 = L2_63.GetHeroInfosByIds
  L2_63 = L2_63(L2_63, A0_61.cards)
  L2_63 = L2_63 or {}
  for _FORV_6_, _FORV_7_ in ipairs(L2_63) do
    L1_62 = L1_62 .. TwGetStr(114003, (Logic:Get("Hero"):GetHeroInfoByBaseId(_FORV_7_.baseId) or {}).star or 1, (Logic:Get("Hero"):GetHeroInfoByBaseId(_FORV_7_.baseId) or {}).name or "")
    if _FORV_6_ ~= #L2_63 then
      L1_62 = L1_62 .. ","
    end
  end
  return L1_62
end
function class.PostUpdateList(A0_64)
  A0_64:FireEvent(EVT.MSG_UPDATE_LIST)
end
function class.PostPopTip(A0_65)
  A0_65:FireEvent(EVT.MSG_POP_TIP)
end
function class.GetCardsList(A0_66)
  local L1_67
end
function class.AddExchangeId(A0_68, A1_69)
  A0_68.exchangeIds = A0_68.exchangeIds or {}
  table.insert(A0_68.exchangeIds, A1_69)
end
function class.RemoveExchangeId(A0_70)
  table.remove(A0_70.exchangeIds, #A0_70.exchangeIds)
end
function class.GetExchangeId(A0_71)
  local L1_72
  if next(A0_71.exchangeIds) then
    L1_72 = (KFDBGetRecord("RedCardExchange", A0_71.exchangeIds[#A0_71.exchangeIds]) or {}).heroId
  end
  return A0_71.exchangeIds, L1_72
end
function class.CheckIsMainCard(A0_73, A1_74)
  local L2_75, L3_76, L4_77, L5_78, L6_79, L7_80, L8_81, L9_82, L10_83
  if not A1_74 then
    return
  end
  L2_75 = Logic
  L3_76 = L2_75
  L2_75 = L2_75.Get
  L2_75 = L2_75(L3_76, L4_77)
  L3_76 = L2_75
  L2_75 = L2_75.GetHeroInfoByBaseId
  L2_75 = L2_75(L3_76, L4_77)
  L2_75 = L2_75 or {}
  L3_76 = L2_75.sameNameId
  for L7_80 = 1, L5_78(L6_79) do
    L8_81 = KFDBGetRecordByIdx
    L9_82 = "RedCardExchange"
    L10_83 = L7_80
    L8_81 = L8_81(L9_82, L10_83)
    L8_81 = L8_81 or {}
    L9_82 = Logic
    L10_83 = L9_82
    L9_82 = L9_82.Get
    L9_82 = L9_82(L10_83, "Hero")
    L10_83 = L9_82
    L9_82 = L9_82.GetHeroInfoByBaseId
    L9_82 = L9_82(L10_83, L8_81.heroId)
    L9_82 = L9_82 or {}
    L10_83 = L9_82.sameNameId
    if tonumber(L10_83) == tonumber(L3_76) then
      return true, L8_81.id
    end
  end
end
function class.CheckSameNameAndFull(A0_84, A1_85)
  local L2_86, L3_87, L4_88, L5_89, L6_90, L7_91, L8_92, L9_93
  if not A1_85 then
    L2_86 = false
    return L2_86
  end
  function L2_86(A0_94)
    return (Logic:Get("Hero"):GetHeroInfoByBaseId((Logic:Get("Hero"):GetHeroInfoById(A0_94) or {}).baseId) or {}).sameNameId
  end
  L3_87 = L2_86
  L4_88 = A1_85
  L3_87 = L3_87(L4_88)
  L4_88 = 0
  for L8_92, L9_93 in L5_89(L6_90) do
    if L2_86(L9_93) == L3_87 then
      L4_88 = L4_88 + 1
    end
  end
  L8_92 = "RedCardExchange"
  L9_93 = L6_90
  L8_92 = json
  L8_92 = L8_92.decode
  L9_93 = L7_91.costSameNameId
  L9_93 = L9_93 or ""
  L8_92 = L8_92(L9_93)
  L8_92 = L8_92 or {}
  L9_93 = 0
  for _FORV_13_, _FORV_14_ in ipairs(L8_92) do
    if _FORV_14_ == L3_87 then
      L9_93 = L9_93 + 1
    end
  end
  return L4_88 >= L9_93
end
function class.GetCheckedIndex(A0_95)
  local L1_96
  L1_96 = A0_95.index
  return L1_96
end
function class.ClearIndex(A0_97)
  local L1_98
  A0_97.index = nil
end
function class.GetExchangeRestCount(A0_99, A1_100)
  local L2_101
  if not A1_100 then
    L2_101 = A0_99.exchangeIds
    A1_100 = L2_101[#A0_99.exchangeIds]
  end
  L2_101 = A0_99.cardsMap
  if L2_101 then
    L2_101 = A0_99.cardsMap
    L2_101 = L2_101[A1_100]
  else
    L2_101 = L2_101 or 0
  end
  return ((KFDBGetRecord("RedCardExchange", A1_100) or {}).maxExchangeNum or 0) - L2_101
end
function class.GetComsumeList(A0_102, A1_103)
  local L2_104, L3_105, L4_106, L5_107, L6_108, L7_109, L8_110, L9_111, L10_112, L11_113, L12_114
  if not A1_103 then
    return
  end
  L3_105 = A0_102
  L2_104 = A0_102.GetExchangeCards
  L4_106 = A1_103
  L2_104 = L2_104(L3_105, L4_106)
  L3_105 = L2_104.cards
  L3_105 = L3_105 or {}
  L4_106 = L2_104.stars
  L4_106 = L4_106 or {}
  L5_107 = {}
  L6_108 = {}
  for L10_112, L11_113 in L7_109(L8_110) do
    L12_114 = A0_102.GetComsumeCard
    L12_114 = L12_114(A0_102, L11_113, L4_106[L10_112], L5_107)
    table.insert(L6_108, L12_114)
  end
  L10_112 = L5_107
  L6_108 = L8_110
  L10_112 = L6_108
  return L9_111, L10_112
end
function class.MatchExchangeMaterials(A0_115, A1_116, A2_117)
  local L3_118, L4_119, L5_120, L6_121
  L3_118 = {}
  L4_119 = {}
  L5_120 = {}
  L6_121 = {}
  for _FORV_10_, _FORV_11_ in ipairs(A1_116.cards or {}) do
    L3_118[#L3_118 + 1] = {
      index = _FORV_10_,
      sameId = _FORV_11_,
      star = A1_116.stars[_FORV_10_] or 0
    }
    L5_120[_FORV_10_] = 0
  end
  table.sort(L3_118, function(A0_122, A1_123)
    return A0_122.star > A1_123.star
  end)
  for _FORV_10_, _FORV_11_ in ipairs(L3_118) do
    for _FORV_15_, _FORV_16_ in ipairs(A2_117 or {}) do
      if _FORV_16_.id and not L6_121[_FORV_16_.id] and not _FORV_16_.locked and (Logic:Get("Hero"):GetHeroInfoByBaseId(_FORV_16_.baseId) or {}).sameNameId == _FORV_11_.sameId then
        if ((Logic:Get("Hero"):GetHeroInfoByBaseId(_FORV_16_.baseId) or {}).star or 0) >= _FORV_11_.star then
          L6_121[_FORV_16_.id] = true
          L4_119[_FORV_11_.index] = _FORV_16_.id
          L5_120[_FORV_11_.index] = 1
          break
        end
      end
    end
  end
  return L4_119, L5_120
end
function class.GetComsumeCard(A0_124, A1_125, A2_126, A3_127)
  local L4_128, L5_129, L6_130, L7_131, L8_132, L9_133, L10_134, L11_135
  if not A1_125 or not A2_126 then
    return
  end
  L4_128 = A1_125
  L5_129 = Logic
  L6_130 = L5_129
  L5_129 = L5_129.Get
  L5_129 = L5_129(L6_130, L7_131)
  L6_130 = L5_129
  L5_129 = L5_129.GetUnbattlingHero
  L5_129 = L5_129(L6_130, L7_131)
  L6_130 = Logic
  L6_130 = L6_130.Get
  L6_130 = L6_130(L7_131, L8_132)
  L6_130 = L6_130.GetHeroInfosByIds
  L6_130 = L6_130(L7_131, L8_132)
  L5_129 = L6_130
  L6_130 = 0
  for L10_134, L11_135 in L7_131(L8_132) do
    if (Logic:Get("Hero"):GetHeroInfoByBaseId(L11_135.baseId) or {}).sameNameId == L4_128 and A2_126 <= (Logic:Get("Hero"):GetHeroInfoByBaseId(L11_135.baseId) or {}).star then
      for _FORV_17_, _FORV_18_ in ipairs(A3_127) do
        if _FORV_18_.id == L11_135.id then
          break
        end
      end
      L6_130 = L6_130 + 1
      if not true then
        table.insert(A3_127, L11_135)
      end
    end
  end
  return L6_130
end
