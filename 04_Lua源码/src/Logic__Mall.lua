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
L0_0 = L0_0({
  "BUY_POINTS",
  "BUY_BAG",
  "BUY_FRIEND_LIMITE",
  "BUY_SUCCESSED",
  "GET_LOTTERY_LIST"
})
EVT = L0_0
L0_0 = {}
L0_0.LOTTERY = "LOTTERY"
L0_0.BUY_POINTS = "BUY_POINTS"
L0_0.BUY_BAG = "BUY_BAG"
L0_0.BUY_FRIEND = "BUY_FRIEND"
L0_0.BUY_SOUL = "BUY_SOUL"
L0_0.TOKEN_COIN = "TOKEN_COIN"
L0_0.OPEN_BETA_GOODS = "OPEN_BETA_GOODS"
L0_0.BUY_TALISMAN_PACK = "BUY_TALISMAN_PACK"
L0_0.CHEAP_BUY = "CHEAP_BUY"
L0_0.BUY_EQUIP_PACK = "BUY_EQUIP_PACK"
L0_0.ACTIVITY_EQUIP = "ACTIVITY_EQUIP"
L0_0.SUPER_GIFT = "SUPER_GIFT"
L0_0.EQUIP_GIFT = "EQUIP_GIFT"
L0_0.EQUIP_MATERIAL = "EQUIP_MATERIAL"
L0_0.PRECIOUSROOM = "PRECIOUSROOM"
ITEM_KIND = L0_0
L0_0 = {}
L0_0.LOTTERY_XIAN = "LOTTERY_XIAN"
L0_0.LOTTERY_THREE = "LOTTERY_THREE"
L0_0.LOTTERY_STONE = "LOTTERY_STONE"
L0_0.ACTIVITY_EQUIP_01 = "ACTIVITY_EQUIP_01"
L0_0.ACTIVITY_EQUIP_02 = "ACTIVITY_EQUIP_02"
L0_0.ACTIVITY_EQUIP_03 = "ACTIVITY_EQUIP_03"
L0_0.ACTIVITY_EQUIP_04 = "ACTIVITY_EQUIP_04"
ITEM_TYPE = L0_0
L0_0 = {
  "year",
  "month",
  "day",
  "hour",
  "min",
  "sec"
}
function class.initialize(A0_1)
  super.initialize(A0_1)
  A0_1.physicalBuyCounts = 0
  A0_1.isFromMall = false
  A0_1.tabData = {}
  A0_1.openTimeMarker = Logic:Get("System"):GetTimeDate()
  A0_1.drawProgress = {}
  A0_1.lotteryList = {}
  A0_1.tokenCoinData = {}
  A0_1.openBetaData = {}
  A0_1.soulStoneData = {}
  A0_1.cheapbuyInfo = {}
  A0_1.isFrom = "Mall"
  MsgPoint:On("BUY_SINGLE", A0_1:Event("OnBuySingle"), false)
  MsgHero:On("BUY_PACK", A0_1:Event("OnBuyBag"), false)
  MsgHero:On("BUY_PACK_BY_COUPON", A0_1:Event("OnBuyPackByCoupon"))
  MsgSociality:On("BUY_PACK", A0_1:Event("OnBuyFriendLimit"), false)
  MsgPlayer:On("GET_LOTTERY_LIST", A0_1:Event("OnGetLotteryList"))
end
function class.OnReset(A0_2)
  local L1_3
end
function class.SetSoulStoneData(A0_4, A1_5)
  A0_4.soulStoneData = A1_5
end
function class.GetSoulStoneData(A0_6)
  local L1_7
  L1_7 = A0_6.soulStoneData
  return L1_7
end
function class.SetTokenCoinData(A0_8, A1_9)
  A0_8.tokenCoinData = A1_9
end
function class.GetTokenCoinData(A0_10)
  local L1_11
  L1_11 = A0_10.tokenCoinData
  return L1_11
end
function class.GetTokenCoinName(A0_12, A1_13)
  require("Logic.Reward")
  if not tonumber(string.match(A1_13, "%d") or 0) then
    return Logic.Reward.TOKEN_COIN[0]
  end
  return Logic.Reward.TOKEN_COIN[tonumber(string.match(A1_13, "%d") or 0)] or Logic.Reward.TOKEN_COIN[0]
end
function class.GetTokenCoinPath(A0_14, A1_15)
  local L2_16
  L2_16 = {}
  L2_16.TOKEN_COIN_0 = "images/Mall/iconTaichu.png"
  L2_16.TOKEN_COIN_1 = "images/Mall/iconCoin.png"
  L2_16.TOKEN_COIN_2 = "images/Mall/iconSpar.png"
  L2_16.TOKEN_COIN_3 = "images/Mall/iconCoin.png"
  L2_16.TOKEN_COIN_4 = "images/Mall/iconGold.png"
  L2_16.TOKEN_COIN_5 = "images/Mall/iconJiNian.png"
  L2_16.TOKEN_COIN_6 = "images/Mall/iconDiamond.png"
  L2_16.TOKEN_COIN_7 = "images/Other/xianjinClean.png"
  if not A1_15 then
    return L2_16.TOKEN_COIN_0
  end
  return L2_16[A1_15] or L2_16.TOKEN_COIN_0
end
function class.GetTokenCoinColor(A0_17, A1_18)
end
function class.SetOpenBetaData(A0_19, A1_20)
  A0_19.openBetaData = A1_20
end
function class.GetOpenBetaData(A0_21)
  local L1_22
  L1_22 = A0_21.openBetaData
  return L1_22
end
function class.setCheapBuyInfo(A0_23, A1_24)
  A0_23.cheapbuyInfo = A1_24
end
function class.getCheapBuyInfo(A0_25)
  local L1_26
  L1_26 = A0_25.cheapbuyInfo
  return L1_26
end
function class.initItemData(A0_27)
  local L1_28, L2_29, L3_30, L4_31, L5_32, L6_33, L7_34, L8_35, L9_36
  L1_28 = {}
  A0_27.tabData = L1_28
  L1_28 = {}
  L2_29 = Logic
  L3_30 = L2_29
  L2_29 = L2_29.Get
  L2_29 = L2_29(L3_30, L4_31)
  L3_30 = L2_29
  L2_29 = L2_29.GetPlayerLevel
  L2_29 = L2_29(L3_30)
  function L3_30(A0_37)
    if table.empty(A0_37 or {}) then
      return false
    end
    if Logic:Get("Lock"):checkLock(A0_37.level, nil, A0_37.battle, nil, A0_37.activity, nil, A0_37.eliteBattle) then
      return false
    end
    if _UPVALUE0_ > A0_37.endLevel then
      return false
    end
    if _UPVALUE1_:IsOverDrawLimit(A0_37.type, A0_37.limits) then
      return false
    end
    if A0_37.weight and A0_37.weight > 0 then
      if table.empty(_UPVALUE2_[A0_37.lotteryType] or {}) then
        _UPVALUE2_[A0_37.lotteryType] = {}
      end
      table.insert(_UPVALUE2_[A0_37.lotteryType], A0_37)
      return false
    end
    return true
  end
  for L7_34, L8_35 in L4_31(L5_32) do
    L9_36 = L3_30
    L9_36 = L9_36(L8_35)
    if L9_36 then
      L9_36 = table
      L9_36 = L9_36.insert
      L9_36(A0_27.tabData, L8_35)
    end
  end
  for L8_35, L9_36 in L5_32(L6_33) do
    if not table.empty(L9_36) then
      table.sort(L9_36, L4_31)
    end
  end
  for L8_35, L9_36 in L5_32(L6_33) do
    if not table.empty(L9_36[1] or {}) then
      table.insert(A0_27.tabData, L9_36[1])
    end
  end
  L5_32(L6_33)
end
function class.IsOverDrawLimit(A0_38, A1_39, A2_40)
  if not A2_40 or A2_40 == 0 then
    return false
  end
  return A2_40 <= A0_38:GetDrawProgressByKey(A1_39)
end
function class.IsOverTimeByData(A0_41, A1_42)
  if table.empty(A1_42 or {}) then
    return false
  end
  if not A1_42.startTime or not A1_42.endTime then
    return false
  end
  if Logic:Get("System"):DiffTime(A1_42.startTime / 1000) > 0 or Logic:Get("System"):DiffTime(A1_42.endTime / 1000) < 0 then
    return true
  end
  return false
end
function class.sortItemData(A0_43)
  local L1_44
  L1_44 = table
  L1_44 = L1_44.empty
  L1_44 = L1_44(A0_43.tabData)
  if not L1_44 then
    function L1_44(A0_45, A1_46)
      if A0_45.sort ~= A1_46.sort then
        return A0_45.sort > A1_46.sort
      end
      if A0_45.kind ~= A1_46.kind then
        return tostring(A0_45.kind or "") < tostring(A1_46.kind or "")
      end
      return tonumber(A0_45.id or 0) < tonumber(A1_46.id or 0)
    end
    table.sort(A0_43.tabData, L1_44)
  end
end
function class.GetTabData(A0_47)
  local L1_48
  L1_48 = A0_47.tabData
  return L1_48
end
function class.GetItemTime(A0_49, A1_50)
  local L2_51, L3_52, L4_53
  if A1_50 == nil or "" == A1_50 then
    L2_51 = {}
    return L2_51
  end
  L2_51 = {}
  L3_52 = 1
  L4_53 = 1
  for _FORV_8_, _FORV_9_ in pairs(_UPVALUE0_) do
    L3_52, L4_53 = string.find(A1_50, "%d+", L3_52)
    if L3_52 and L4_53 then
      L2_51[_FORV_9_] = tonumber(string.match(A1_50, "%d+", L3_52))
      L3_52 = L4_53 + 1
    end
  end
  return L2_51
end
function class.SetDrawProgress(A0_54, A1_55)
  A0_54.drawProgress = A1_55
end
function class.AddDrawProgress(A0_56, A1_57, A2_58)
  local L4_59
  L4_59 = A0_56.drawProgress
  L4_59[A1_57] = A0_56.drawProgress[A1_57] and A0_56.drawProgress[A1_57] + A2_58 or A2_58
end
function class.GetDrawProgressByKey(A0_60, A1_61)
  local L2_62
  if A1_61 == nil or "" == A1_61 then
    L2_62 = 0
    return L2_62
  end
  L2_62 = A0_60.drawProgress
  L2_62 = L2_62[A1_61]
  if L2_62 then
    L2_62 = A0_60.drawProgress
    L2_62 = L2_62[A1_61]
    return L2_62
  end
  L2_62 = 0
  return L2_62
end
function class.IsFriendDraw(A0_63, A1_64)
  if A1_64 == nil then
    return false
  end
  if string.find(A1_64, "LOTTERY_L0") then
    return true
  end
  return false
end
function class.IsOnceDraw(A0_65, A1_66)
  if A1_66 == nil then
    return false
  end
  if string.find(A1_66, "LOTTERY_ONE") then
    return true
  end
  return false
end
function class.SetFromMall(A0_67, A1_68)
  if A1_68 ~= nil then
    A0_67.isFromMall = A1_68
  end
end
function class.GetCostIdx(A0_69, A1_70, A2_71)
  if A2_71 and A1_70 then
    if A1_70 < #A2_71 then
    else
    end
    return #A2_71
  else
    return 1
  end
end
function class.buyFriendLimit(A0_72)
  local L1_73, L2_74, L3_75, L4_76
  L1_73 = KFDBGetRecord
  L2_74 = "ConfigValue"
  L3_75 = "SOCIALITY:BUY_PACK_SIZE"
  L1_73 = L1_73(L2_74, L3_75)
  L2_74 = 0
  if L1_73 then
    L3_75 = tonumber
    L4_76 = L1_73.content
    L3_75 = L3_75(L4_76)
    L2_74 = L3_75
  end
  L3_75 = Logic
  L4_76 = L3_75
  L3_75 = L3_75.Get
  L3_75 = L3_75(L4_76, "Friend")
  L4_76 = L3_75
  L3_75 = L3_75.GetBuyFriendBagNum
  L3_75 = L3_75(L4_76)
  L4_76 = A0_72.GetCurrFriendLimitCost
  L4_76 = L4_76(A0_72)
  if L4_76 then
    A0_72:FireEvent(EVT.BUY_FRIEND_LIMITE, L4_76, L2_74)
  end
end
function class.GetCurrFriendLimitCost(A0_77)
  local L1_78, L2_79, L3_80
  L1_78 = KFDBGetRecord
  L2_79 = "ConfigValue"
  L3_80 = "SOCIALITY:BUY_PACK_COST"
  L1_78 = L1_78(L2_79, L3_80)
  L2_79 = {}
  if L1_78 then
    L3_80 = json
    L3_80 = L3_80.decode
    L3_80 = L3_80(L1_78.content)
    L2_79 = L3_80
  end
  L3_80 = Logic
  L3_80 = L3_80.Get
  L3_80 = L3_80(L3_80, "Friend")
  L3_80 = L3_80.GetBuyFriendBagNum
  L3_80 = L3_80(L3_80)
  if L2_79 then
    return L2_79[A0_77:GetCostIdx(L3_80, L2_79)]
  else
    return 0
  end
end
function class.BuyBag(A0_81)
  local L1_82, L2_83, L3_84, L4_85, L5_86, L6_87, L7_88
  L2_83 = A0_81
  L1_82 = A0_81.GetCouponCost
  L1_82 = L1_82(L2_83)
  L3_84 = A0_81
  L2_83 = A0_81.GetCurrentBagCostAndSize
  L3_84 = L2_83(L3_84)
  L4_85 = Logic
  L5_86 = L4_85
  L4_85 = L4_85.Get
  L6_87 = "PlayerInfo"
  L4_85 = L4_85(L5_86, L6_87)
  L5_86 = L4_85
  L4_85 = L4_85.GetPlayerMoney
  L4_85 = L4_85(L5_86)
  L5_86 = string
  L5_86 = L5_86.lower
  L6_87 = "COUPON"
  L5_86 = L5_86(L6_87)
  L5_86 = L4_85[L5_86]
  L5_86 = L5_86 or 0
  L6_87 = TwGetStr
  L7_88 = 105204
  L6_87 = L6_87(L7_88, L3_84, L2_83)
  L7_88 = L6_87
  L6_87 = L7_88 .. [[

 
]] .. TwGetStr(105286, L5_86 or 0, L1_82)
  L7_88 = Prompt
  L7_88 = L7_88.Confirm
  L7_88(L7_88, A0_81, 105203, L6_87, A0_81.onConfirmBuy, Prompt.PROMPT_TYPE.SELECT)
end
function class.GetCurrentBagCostAndSize(A0_89)
  local L1_90, L2_91, L3_92, L4_93, L5_94
  L1_90 = Logic
  L2_91 = L1_90
  L1_90 = L1_90.Get
  L3_92 = "Hero"
  L1_90 = L1_90(L2_91, L3_92)
  L2_91 = L1_90
  L1_90 = L1_90.GetAllHeroInfo
  L1_90 = L1_90(L2_91)
  L2_91 = KFDBGetRecord
  L3_92 = "ConfigValue"
  L4_93 = "HERO:BUY_PACK_COST"
  L2_91 = L2_91(L3_92, L4_93)
  L3_92 = KFDBGetRecord
  L4_93 = "ConfigValue"
  L5_94 = "HERO:BUY_PACK_SIZE"
  L3_92 = L3_92(L4_93, L5_94)
  L4_93 = {}
  L5_94 = 1
  if L2_91 and L3_92 then
    L4_93 = json.decode(L2_91.content)
    L5_94 = tonumber(L3_92.content)
  end
  if L4_93 then
    return L4_93[A0_89:GetCostIdx(L1_90.extendLimit / L5_94, L4_93)], L5_94
  else
    return 0, 0
  end
end
function class.GetCouponCost(A0_95)
  local L1_96, L2_97, L3_98, L4_99
  L1_96 = KFDBGetRecord
  L2_97 = "ConfigValue"
  L3_98 = "HERO:BUY_PACK_COST_COUPON"
  L1_96 = L1_96(L2_97, L3_98)
  L1_96 = L1_96 or {}
  L2_97 = KFDBGetRecord
  L3_98 = "ConfigValue"
  L4_99 = "HERO:BUY_PACK_SIZE"
  L2_97 = L2_97(L3_98, L4_99)
  L2_97 = L2_97 or {}
  L3_98 = L2_97.content
  if L3_98 then
    L3_98 = tonumber
    L4_99 = L2_97.content
    L3_98 = L3_98(L4_99)
  else
    L3_98 = L3_98 or 1
  end
  L4_99 = json
  L4_99 = L4_99.decode
  L4_99 = L4_99(L1_96.content or "[]")
  L4_99 = L4_99 or {}
  if table.empty(L4_99) then
    return 0
  end
  if 1 > Logic:Get("Hero"):GetAllHeroInfo().extendLimit / L3_98 then
  end
  if (1 or Logic:Get("Hero"):GetAllHeroInfo().extendLimit / L3_98) > #L4_99 then
  end
  return L4_99[#L4_99 or 1 or Logic:Get("Hero"):GetAllHeroInfo().extendLimit / L3_98]
end
function class.BuyPoints(A0_100)
  local L1_101, L2_102, L3_103, L4_104, L5_105, L6_106, L7_107, L8_108
  L1_101 = Logic
  L2_102 = L1_101
  L1_101 = L1_101.Get
  L3_103 = "System"
  L1_101 = L1_101(L2_102, L3_103)
  L2_102 = L1_101
  L1_101 = L1_101.GetTimeDate
  L1_101 = L1_101(L2_102)
  L2_102 = A0_100.openTimeMarker
  L2_102 = L2_102.day
  L3_103 = L1_101.day
  if L2_102 ~= L3_103 then
    L2_102 = Logic
    L3_103 = L2_102
    L2_102 = L2_102.Get
    L4_104 = "PlayerInfo"
    L2_102 = L2_102(L3_103, L4_104)
    L3_103 = L2_102
    L2_102 = L2_102.SetPlaerPhsicalExchange
    L4_104 = 0
    L2_102(L3_103, L4_104)
  end
  A0_100.openTimeMarker = L1_101
  L2_102 = Logic
  L3_103 = L2_102
  L2_102 = L2_102.Get
  L4_104 = "PlayerInfo"
  L2_102 = L2_102(L3_103, L4_104)
  L3_103 = L2_102
  L2_102 = L2_102.GetPlayerPhysical
  L2_102 = L2_102(L3_103)
  L3_103 = KFDBGetRecord
  L4_104 = "ConfigValue"
  L5_105 = "POINT:SINGLE_BUY_COST"
  L3_103 = L3_103(L4_104, L5_105)
  L4_104 = KFDBGetRecord
  L5_105 = "ConfigValue"
  L6_106 = "POINT:SINGLE_BUY_COUNT"
  L4_104 = L4_104(L5_105, L6_106)
  L5_105 = {}
  L6_106 = 0
  if L3_103 and L4_104 then
    L7_107 = json
    L7_107 = L7_107.decode
    L8_108 = L3_103.content
    L7_107 = L7_107(L8_108)
    L5_105 = L7_107
    L7_107 = tonumber
    L8_108 = L4_104.content
    L7_107 = L7_107(L8_108)
    L6_106 = L7_107
  end
  if L5_105 then
    L7_107 = L2_102.exchangeCount
    A0_100.physicalBuyCounts = L7_107
    L8_108 = A0_100
    L7_107 = A0_100.GetCostIdx
    L7_107 = L7_107(L8_108, L2_102.exchangeCount, L5_105)
    L8_108 = A0_100.GetMaxBuyPointTimes
    L8_108 = L8_108(A0_100)
    L8_108 = L8_108 - L2_102.exchangeCount
    A0_100:FireEvent(EVT.BUY_POINTS, L5_105[L7_107], L6_106, L8_108)
  end
end
function class.GetMaxBuyPointTimes(A0_109)
  local L1_110, L2_111, L3_112, L4_113, L5_114
  L1_110 = 0
  for L5_114 = 1, L3_112(L4_113) do
    if KFDBGetRecordByIdx("Charge2Times", L5_114) and KFDBGetRecordByIdx("Charge2Times", L5_114).type == "ACTION_POINT" and Logic:Get("PlayerInfo"):GetPlayerMoney().totalCharge >= KFDBGetRecordByIdx("Charge2Times", L5_114).chargeAmount and L1_110 < KFDBGetRecordByIdx("Charge2Times", L5_114).addTimes then
      L1_110 = KFDBGetRecordByIdx("Charge2Times", L5_114).addTimes
    end
  end
  return L1_110
end
function class.PostBuySingle(A0_115)
  MsgPoint:Post("BUY_SINGLE")
end
function class.PostBuyBag(A0_116)
  MsgHero:Post("BUY_PACK")
end
function class.PostBuyBagByCoupon(A0_117)
  MsgHero:Post("BUY_PACK_BY_COUPON")
end
function class.PostBuyFriendLimit(A0_118)
  MsgSociality:Post("BUY_PACK")
end
function class.OnGetLotteryList(A0_119, A1_120, A2_121)
  if A1_120 ~= 0 then
    return
  end
  A0_119.lotteryList = A2_121 or {}
  A0_119:FireEvent(EVT.GET_LOTTERY_LIST)
end
function class.OnBuySingle(A0_122, A1_123, A2_124)
  if 0 == A1_123 and A2_124 then
    if A0_122.physicalBuyCounts then
      A0_122.physicalBuyCounts = A0_122.physicalBuyCounts + 1
    end
    Logic:Get("Cost"):AddCosts(A2_124.costs)
    Logic:Get("Reward"):AddRewards(A2_124.rewards)
    Logic:Get("PlayerInfo"):SetPlaerPhsicalExchange(A0_122.physicalBuyCounts)
    if Logic:Get("Target"):IsActivityOpen() then
      Logic:Get("Target"):PostGetProgress(nil)
    end
    A0_122:BuySuccussed()
  else
    A0_122:BuyFailed(A1_123)
  end
end
function class.OnBuyBag(A0_125, A1_126, A2_127)
  if 0 == A1_126 and A2_127 then
    Logic:Get("Cost"):AddCosts(A2_127.costs)
    Logic:Get("Hero"):SetPackExtendLimit(A2_127.extendLimit)
    A0_125:BuySuccussed()
  else
    A0_125:BuyFailed(A1_126)
  end
end
function class.OnBuyPackByCoupon(A0_128, A1_129, A2_130)
  if A1_129 ~= 0 then
    return
  end
  A0_128:OnBuyBag(0, A2_130)
end
function class.OnBuyFriendLimit(A0_131, A1_132, A2_133)
  if 0 == A1_132 and A2_133 then
    Logic:Get("Cost"):AddCosts(A2_133.costs)
    Logic:Get("Friend"):SetBuyFriendNum(A2_133.extendCount)
    A0_131:BuySuccussed()
  else
    A0_131:BuyFailed(A1_132)
  end
end
function class.BuySuccussed(A0_134)
  Prompt:Msg(TwGetStr(105207))
  A0_134:FireEvent(EVT.BUY_SUCCESSED)
end
function class.BuyFailed(A0_135, A1_136)
  if A1_136 == -105 then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
  elseif A1_136 == -14 then
    Prompt:Fail(TwGetStr(10078))
  elseif A1_136 == -28 then
    Prompt:Fail(TwGetStr(10078))
  elseif A1_136 == -402 then
    Prompt:Fail(TwGetStr(10078))
  elseif A1_136 == -403 then
    Prompt:Fail(TwGetStr(10081))
  else
    Logic:Get("MsgAssist"):OnMsgResult("", A1_136)
  end
end
function class.onConfirmBuy(A0_137)
  if A0_137:GetCouponCost() <= (Logic:Get("PlayerInfo"):GetPlayerMoney()[string.lower("COUPON")] or 0) then
    A0_137:PostBuyBagByCoupon()
    return
  end
  if A0_137:GetCurrentBagCostAndSize() > Logic:Get("PlayerInfo"):GetPlayerAllJade() then
    Logic:Get("Main"):PromptCharge()
    return
  end
  A0_137:PostBuyBag()
end
function class.setSuperGoodInfo(A0_138, A1_139)
  A0_138.superGood = A1_139
end
function class.getSuperGoodInfo(A0_140)
  local L1_141
  L1_141 = A0_140.superGood
  return L1_141
end
function class.setIsFrom(A0_142, A1_143)
  A0_142.isFrom = A1_143
end
function class.getIsFrom(A0_144)
  local L1_145
  L1_145 = A0_144.isFrom
  return L1_145
end
