module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
FROM_MALL = 1
FROM_DEVIL = 2
EVT = Enum({
  "DRAW_SUCCESSED",
  "DRAW_FAILED",
  "REFRESH_DESCRIPTION",
  "SHOW_CARDS",
  "MSG_LOTTERY_TIME",
  "MSG_LOTTERY_OK",
  "ON_EQUIP_LOTTERY"
})
RANK_COLOR = {
  [1] = {
    255,
    255,
    255
  },
  [2] = {
    76,
    171,
    5
  },
  [3] = {
    77,
    173,
    255
  },
  [4] = {
    206,
    36,
    242
  },
  [5] = {
    255,
    255,
    0
  },
  [6] = {
    255,
    134,
    0
  }
}
REWARDS_TYPE = TypeDef("com.eyu.mt.module.reward.model.RewardType")
function class.initialize(A0_0)
  super.initialize(A0_0)
  A0_0.fromWhere = nil
  A0_0.layer = 1
  A0_0.times = 0
  A0_0.drawType = 0
  A0_0.cards = {}
  A0_0.drawData = nil
  A0_0.bShowCard = false
  MsgPlayer:On("LOTTERY", A0_0:Event("OnLottery"), true)
  MsgPlayer:On("EQUIP_LOTTERY", A0_0:Event("OnEquipLottery"), false)
end
function class.OnReset(A0_1)
  local L1_2
end
function class.GetNameStr(A0_3, A1_4)
  local L2_5, L3_6, L4_7, L5_8, L6_9, L7_10
  if A1_4 ~= nil then
    L2_5 = table
    L2_5 = L2_5.empty
    L2_5 = L2_5(L3_6)
  elseif L2_5 then
    L2_5 = ""
    return L2_5
  end
  L2_5 = ""
  for L6_9, L7_10 in L3_6(L4_7) do
    if Logic:Get("Hero"):GetHeroInfoByBaseId(L7_10) and Logic:Get("Hero"):GetHeroInfoByBaseId(L7_10).name then
      if L6_9 ~= #A1_4 then
        L2_5 = L2_5 .. Logic:Get("Hero"):GetHeroInfoByBaseId(L7_10).name .. TwGetStr(105273)
      else
        L2_5 = L2_5 .. Logic:Get("Hero"):GetHeroInfoByBaseId(L7_10).name
      end
    end
  end
  return L2_5
end
function class.GetCostTableByLotteryType(A0_11)
  if table.empty(A0_11.drawData or {}) then
    return {}
  end
  if A0_11.drawData.activityCharge > 0 and A0_11.drawData.playerActivityCharge >= A0_11.drawData.activityCharge then
    return A0_11.drawData.salePrices or {}
  end
  return json.decode(A0_11.drawData.prices or "[]") or {}
end
function class.GetRateUpCostByType(A0_12, A1_13)
  local L2_14
  L2_14 = A0_12.GetCostTableByLotteryType
  L2_14 = L2_14(A0_12)
  if L2_14 == nil or table.empty(L2_14) then
    return 0
  end
  if Logic:Get("Mall"):GetDrawProgressByKey(A1_13) == nil then
  end
  if 0 >= (0 or Logic:Get("Mall"):GetDrawProgressByKey(A1_13)) + 1 then
  end
  if (1 or (0 or Logic:Get("Mall"):GetDrawProgressByKey(A1_13)) + 1) > #L2_14 then
  end
  return L2_14[#L2_14 or 1 or (0 or Logic:Get("Mall"):GetDrawProgressByKey(A1_13)) + 1] or 0
end
function class.checkStoneEnough(A0_15, A1_16)
  if A1_16 == nil then
    return false
  end
  if Logic:Get("PlayerInfo"):GetPlayerStone() >= A0_15:GetColorBoxCost() * A1_16 then
    return true
  end
  return false
end
function class.ShowDrawResult(A0_17, A1_18)
  if A1_18 == nil or table.empty(A1_18) then
    return
  end
  A0_17.cards = A0_17:formatRewardData(A1_18)
  A0_17.times = #A0_17.cards
  if A0_17.times == 1 or A0_17.times == 3 or A0_17.times == 10 then
    A0_17.bShowCard = true
    A0_17:FireEvent(EVT.SHOW_CARDS)
  end
end
function class.isOpenTenDraw(A0_19)
  if not Logic:Get("PlayerInfo"):IsOpenFunc() and Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.LOTTERY_TEN) then
    return false
  end
  return true
end
function class.SetDrawData(A0_20, A1_21)
  A0_20.drawData = A1_21
end
function class.GetDrawData(A0_22)
  local L1_23
  L1_23 = A0_22.drawData
  return L1_23
end
function class.GetDrawDiscount(A0_24)
  local L1_25
  L1_25 = A0_24.drawDiscount
  return L1_25
end
function class.SetLayer(A0_26, A1_27)
  if A1_27 then
    A0_26.layer = A1_27
  end
end
function class.GetFrom(A0_28)
  local L1_29
  L1_29 = A0_28.fromWhere
  return L1_29
end
function class.SetFrom(A0_30, A1_31)
  if A1_31 then
    A0_30.fromWhere = A1_31
  end
end
function class.GetGoldCostAndGolds(A0_32)
  local L1_33
  L1_33 = Logic
  L1_33 = L1_33.Get
  L1_33 = L1_33(L1_33, "PlayerInfo")
  L1_33 = L1_33.GetPlayerAllJade
  L1_33 = L1_33(L1_33)
  if L1_33 then
    return A0_32:GetDrawOnceCost(), L1_33
  else
    return A0_32:GetDrawOnceCost(), 0
  end
end
function class.GetThreeCost(A0_34)
  return A0_34:GetDrawOnceCost()
end
function class.GetColorBoxCost(A0_35)
  return A0_35:GetDrawOnceCost()
end
function class.GetDrawOnceCost(A0_36)
  if table.empty(A0_36.drawData or {}) then
    return 0
  end
  return (json.decode(A0_36.drawData.prices or "[]") or {})[1] or 0
end
function class.GetFriendCostAndPoints(A0_37)
  local L1_38, L2_39
  L1_38 = table
  L1_38 = L1_38.empty
  L2_39 = A0_37.drawData
  L2_39 = L2_39 or {}
  L1_38 = L1_38(L2_39)
  if L1_38 then
    L1_38 = 0
    L2_39 = 0
    return L1_38, L2_39
  end
  L1_38 = Logic
  L2_39 = L1_38
  L1_38 = L1_38.Get
  L1_38 = L1_38(L2_39, "PlayerInfo")
  L2_39 = L1_38
  L1_38 = L1_38.GetPlayerMoney
  L1_38 = L1_38(L2_39)
  if not L1_38 then
    L2_39 = 0
    return L2_39, 0
  end
  L2_39 = json
  L2_39 = L2_39.decode
  L2_39 = L2_39(A0_37.drawData.prices or "[]")
  L2_39 = L2_39 or {}
  return L2_39, L1_38.friendship or 0
end
function class.GetTimes(A0_40)
  local L1_41
  L1_41 = A0_40.times
  return L1_41
end
function class.GetCards(A0_42)
  local L1_43
  L1_43 = A0_42.cards
  return L1_43
end
function class.SetDrawType(A0_44, A1_45)
  A0_44.drawType = A1_45
end
function class.GetDrawType(A0_46)
  local L1_47
  L1_47 = A0_46.drawType
  return L1_47
end
function class.SetShowCard(A0_48, A1_49)
  A0_48.bShowCard = A1_49
end
function class.IsShowCard(A0_50)
  local L1_51
  L1_51 = A0_50.bShowCard
  return L1_51
end
function class.PostLottery(A0_52, A1_53)
  if A1_53 then
    A0_52.times = A1_53
    if A0_52.drawData and A0_52.drawData.id then
      MsgPlayer:Post("LOTTERY", {
        time = A1_53,
        id = A0_52.drawData.id
      })
    end
  end
end
function class.PostEquipLottery(A0_54, A1_55, A2_56)
  if not A1_55 then
    return
  end
  if A2_56 == nil then
    A2_56 = A1_55 == 1 and A0_54:CheckCanLottery()
  end
  A0_54.times = A1_55
  MsgPlayer:Post("EQUIP_LOTTERY", {
    free = A2_56,
    id = A0_54.drawData.id,
    time = A1_55
  })
end
function class.OnLottery(A0_57, A1_58, A2_59)
  local L3_60, L4_61, L5_62, L6_63, L7_64
  if 0 == A1_58 and A2_59 then
    L3_60 = Logic
    L3_60 = L3_60.Get
    L3_60 = L3_60(L4_61, L5_62)
    L3_60 = L3_60.AddDrawProgress
    L3_60(L4_61, L5_62, L6_63)
    L3_60 = {}
    A0_57.cards = L3_60
    L3_60 = Logic
    L3_60 = L3_60.Get
    L3_60 = L3_60(L4_61, L5_62)
    L3_60 = L3_60.AddCosts
    L3_60(L4_61, L5_62)
    L3_60 = Logic
    L3_60 = L3_60.Get
    L3_60 = L3_60(L4_61, L5_62)
    L3_60 = L3_60.AddRewards
    L3_60(L4_61, L5_62)
    L3_60 = A0_57.formatRewardData
    L3_60 = L3_60(L4_61, L5_62)
    A0_57.cards = L3_60
    while true do
      L3_60 = A0_57.cards
      L3_60 = #L3_60
      if L3_60 > L4_61 then
        L3_60 = false
        for L7_64 = #L4_61, 1, -1 do
          if tonumber(A0_57.cards[L7_64].baseId) == 501 then
            table.remove(A0_57.cards, L7_64)
            L3_60 = true
            break
          end
        end
      elseif not L3_60 then
        break
      end
    end
    L3_60 = A0_57.IsNeedSortData
    L3_60 = L3_60(L4_61, L5_62)
    if L3_60 then
      A0_57.cards = L4_61
      L7_64 = L4_61
      L5_62(L6_63, L7_64)
    end
    if L4_61 == 10 then
      A0_57.cards = L4_61
    end
    L7_64 = A2_59.rewards
    L4_61(L5_62, L6_63, L7_64)
    L4_61(L5_62, L6_63)
    L4_61(L5_62, L6_63)
    L4_61(L5_62)
    L7_64 = "SelectTimes"
    L4_61(L5_62, L6_63, L7_64)
    if L4_61 == 10 then
      if L4_61 then
        if not L4_61 then
          L4_61.prices = L5_62
          L4_61.salePrices = L5_62
        end
      end
    end
    if L4_61 then
      if L4_61 > 0 then
        L7_64 = "System"
        L4_61.resetDate = L5_62
      end
    end
    L4_61(L5_62, L6_63)
    L4_61(L5_62, L6_63)
  else
    L3_60 = Logic
    L3_60 = L3_60.Get
    L3_60 = L3_60(L4_61, L5_62)
    L3_60 = L3_60.done
    L3_60(L4_61, L5_62, L6_63)
    L3_60 = A0_57.FireEvent
    L3_60(L4_61, L5_62, L6_63)
  end
end
function class.OnEquipLottery(A0_65, A1_66, A2_67)
  local L3_68
  if A1_66 == 0 then
    L3_68 = A0_65.drawData
    L3_68.resetDate = A2_67 and A2_67.resetDate
    L3_68 = A0_65.drawData
    L3_68.current = A2_67 and A2_67.current
    L3_68 = A0_65.drawData
    L3_68.usedFreeTimes = A2_67 and A2_67.usedFreeTimes
    L3_68 = A0_65.IsLotteryTimeCold
    L3_68 = L3_68(A0_65)
    if L3_68 then
      L3_68 = A0_65.LotteryColdTimeChanged
      L3_68(A0_65)
    else
      L3_68 = A0_65.DecLotteryTime
      L3_68(A0_65)
    end
    L3_68 = A2_67 and A2_67.result
    A0_65:OnLottery(A1_66, L3_68)
    A0_65:FireEvent(EVT.ON_EQUIP_LOTTERY)
  else
    L3_68 = A0_65.FireEvent
    L3_68(A0_65, EVT.DRAW_FAILED, A1_66)
  end
end
function class.randomSort(A0_69, A1_70)
  local L2_71, L3_72, L4_73, L5_74
  L2_71 = #A1_70
  if L2_71 < 10 then
    return
  end
  L2_71 = {}
  L3_72 = 1
  while L3_72 <= 10 do
    L4_73 = table
    L4_73 = L4_73.insert
    L4_73(L5_74, L3_72)
    L3_72 = L3_72 + 1
  end
  L4_73 = {}
  L3_72 = 1
  while L3_72 <= 10 do
    table.insert(L4_73, A1_70[L2_71[L5_74]])
    table.remove(L2_71, L5_74)
    L3_72 = L3_72 + 1
  end
  for _FORV_8_ = 11, #A1_70 do
    if A1_70[_FORV_8_] then
      table.insert(L4_73, A1_70[_FORV_8_])
    end
  end
  return L4_73
end
function class.formatRewardSort(A0_75, A1_76)
  local L2_77, L3_78, L4_79, L5_80
  L3_78 = A0_75
  L2_77 = A0_75.IsNeedSortData
  L4_79 = A0_75.drawData
  L4_79 = L4_79.type
  L3_78 = L2_77(L3_78, L4_79)
  if not L2_77 then
    return
  end
  L4_79 = {}
  L4_79[501] = 999
  L4_79[502] = 999
  L4_79[503] = 999
  L5_80 = json
  L5_80 = L5_80.decode
  L5_80 = L5_80(L3_78.sortType)
  L5_80 = L5_80 or {}
  for _FORV_9_, _FORV_10_ in pairs(A1_76) do
    for _FORV_14_, _FORV_15_ in pairs(L5_80) do
      if _FORV_10_.rewardType == REWARDS_TYPE[_FORV_15_] then
        if _FORV_10_.rewardType == REWARDS_TYPE.HERO and L4_79[_FORV_10_.baseId] then
          _FORV_10_.sort = L4_79[_FORV_10_.baseId]
        else
          _FORV_10_.sort = _FORV_14_
        end
      end
    end
  end
  return A1_76
end
function class.IsNeedSortData(A0_81, A1_82)
  local L2_83, L3_84
  if A1_82 == nil then
    L2_83 = false
    L3_84 = nil
    return L2_83, L3_84
  end
  L2_83 = A0_81.drawData
  if L2_83 ~= nil then
    L2_83 = A0_81.drawData
    L2_83 = L2_83.sortType
    if L2_83 ~= nil then
      L2_83 = A0_81.drawData
      L2_83 = L2_83.sortType
    end
  elseif "" == L2_83 then
    L2_83 = false
    L3_84 = nil
    return L2_83, L3_84
  end
  L2_83 = true
  L3_84 = A0_81.drawData
  return L2_83, L3_84
end
function class.formatRewardData(A0_85, A1_86)
  local L2_87, L3_88, L4_89, L5_90, L6_91, L7_92, L8_93, L9_94, L10_95, L11_96, L12_97, L13_98, L14_99, L15_100, L16_101
  L2_87 = {}
  for L6_91, L7_92 in L3_88(L4_89) do
    if L8_93 ~= L9_94 then
    else
      if L8_93 == "ITEM" then
        L8_93.rewardType = L9_94
        L8_93(L9_94, L10_95)
    end
    else
      if L8_93 ~= L9_94 then
      else
        if L8_93 == "EQUIP" then
          L8_93.rewardType = L9_94
          L8_93(L9_94, L10_95)
      end
      else
        if L8_93 ~= L9_94 then
          if L8_93 ~= "EQUIPMENT" then
          end
        else
          if L8_93 == "EQUIPMENT_FRAGMENT" then
            if L8_93 > 1 then
              for L11_96 = 1, L7_92.amount do
                L12_97.rewardType = L13_98
                L12_97(L13_98, L14_99)
              end
            elseif L8_93 == 1 then
              L8_93.rewardType = L9_94
              L8_93(L9_94, L10_95)
            end
        end
        else
          if L8_93 ~= L9_94 then
          else
            if L8_93 == "EQUIPMENT_MATERIAL" then
              L11_96 = A0_85.times
              L11_96 = L8_93
              if L9_94 then
                L11_96 = L9_94.content
                if L11_96 then
                  L11_96 = tonumber
                  L11_96 = L11_96(L12_97)
                end
              end
              L11_96 = L7_92.amount
              if L10_95 < L11_96 then
                L11_96 = math
                L11_96 = L11_96.ceil
                L11_96 = L11_96(L12_97)
                for L15_100 = 1, L11_96 do
                  L16_101 = {}
                  L16_101.rewardType = L7_92.type
                  L16_101.baseId = L7_92.code + 800
                  table.insert(L2_87, L16_101)
                end
              else
                L11_96 = {}
                L11_96.rewardType = L12_97
                L11_96.baseId = L12_97
                L12_97(L13_98, L14_99)
              end
          end
          else
            if L8_93 ~= L9_94 then
            else
              if L8_93 == "FRAGMENT" then
                if L8_93 > 1 then
                  for L11_96 = 1, L7_92.amount do
                    L12_97.rewardType = L13_98
                    L12_97(L13_98, L14_99)
                  end
                elseif L8_93 == 1 then
                  L8_93.rewardType = L9_94
                  L8_93(L9_94, L10_95)
                end
            end
            else
              if L8_93 ~= L9_94 then
              else
                if L8_93 == "HERO" then
                  L8_93.rewardType = L9_94
                  L8_93(L9_94, L10_95)
              end
              else
                if L8_93 ~= L9_94 then
                else
                  if L8_93 == "EXP_CARD" then
                    L8_93.rewardType = L9_94
                    L8_93(L9_94, L10_95)
                end
                else
                  if L8_93 ~= L9_94 then
                  else
                    if L8_93 == "COIN_CARD" then
                      L8_93.rewardType = L9_94
                      L8_93(L9_94, L10_95)
                  end
                  elseif L8_93 ~= L9_94 then
                  elseif L8_93 == "TREASURE" then
                    L8_93.rewardType = L9_94
                    L8_93(L9_94, L10_95)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  return L2_87
end
function class.formatTabData(A0_102, A1_103)
  if A1_103 == nil then
    return nil
  end
  if A1_103.rewardType == REWARDS_TYPE.EQUIPMENT or A1_103.rewardType == REWARDS_TYPE.EQUIPMENT_MATERIAL or A1_103.rewardType == REWARDS_TYPE.EQUIPMENT_FRAGMENT then
    return A1_103
  end
  if Logic:Get("HeroCardInfo"):kdbBaseHero(A1_103.baseId) == nil then
    return nil
  end
  if A1_103.rewardType and A1_103.rewardType == Logic.Lottery.REWARDS_TYPE.FRAGMENT then
    A1_103.fra = true
    A1_103.itemName = Logic:Get("Compose"):kdbItemConfig(A1_103.baseId).name
  end
  A1_103.powerSkill = A1_103.powerSkill and A1_103.powerSkill or Logic:Get("HeroCardInfo"):kdbBaseHero(A1_103.baseId).powerSkill
  A1_103.level = A1_103.level and A1_103.level or 1
  return A1_103
end
function class.GetHeroRankColor3(A0_104, A1_105)
  local L2_106
  if A1_105 < 1 then
    A1_105 = 1
  end
  L2_106 = RANK_COLOR
  L2_106 = #L2_106
  if A1_105 > L2_106 then
    L2_106 = RANK_COLOR
    A1_105 = #L2_106
  end
  L2_106 = RANK_COLOR
  L2_106 = L2_106[A1_105]
  L2_106 = L2_106 or RANK_COLOR[1]
  return ccc3(unpack(L2_106))
end
function class.setGuideLottery(A0_107, A1_108)
  A0_107.guideBool = A1_108 or nil
end
function class.isGuideLottery(A0_109)
  local L1_110
  L1_110 = A0_109.guideBool
  return L1_110
end
function class.setGuideLotterEvo(A0_111, A1_112)
  A0_111.evoBool = A1_112 or nil
end
function class.isGuideLotterEvo(A0_113)
  local L1_114
  L1_114 = A0_113.evoBool
  return L1_114
end
function class.IsLotteryTimeCold(A0_115)
  local L1_116
  L1_116 = A0_115.lotteryTime
  return L1_116
end
function class.LotteryColdTimeChanged(A0_117)
  if not A0_117.drawData.resetDate then
    return
  end
  A0_117.lotteryTime = A0_117.drawData.resetDate / 1000 + (KFDBGetRecord("EquipLottery", A0_117.drawData.id) and KFDBGetRecord("EquipLottery", A0_117.drawData.id).resetTimesHours and KFDBGetRecord("EquipLottery", A0_117.drawData.id).resetTimesHours or tonumber(A0_117.drawData.cooldownHours) or 48) * 3600
end
function class.DecLotteryTime(A0_118)
  local L1_119, L2_120, L3_121, L4_122
  L1_119 = A0_118.lotteryTime
  if not L1_119 then
    L2_120 = A0_118
    L1_119 = A0_118.LotteryColdTimeChanged
    L1_119(L2_120)
    L1_119 = A0_118.lotteryTime
    if not L1_119 then
      return
    end
  end
  L1_119 = Logic
  L2_120 = L1_119
  L1_119 = L1_119.Get
  L3_121 = "System"
  L1_119 = L1_119(L2_120, L3_121)
  L2_120 = L1_119
  L1_119 = L1_119.DiffTime
  L3_121 = A0_118.lotteryTime
  L1_119 = L1_119(L2_120, L3_121)
  if L1_119 > 0 then
    L2_120 = Logic
    L3_121 = L2_120
    L2_120 = L2_120.Get
    L4_122 = "System"
    L2_120 = L2_120(L3_121, L4_122)
    L3_121 = L2_120
    L2_120 = L2_120.SecToDay
    L4_122 = L1_119
    L2_120 = L2_120(L3_121, L4_122)
    L2_120 = L2_120 or {}
    L3_121 = L2_120.hour
    L3_121 = L3_121 or 0
    L4_122 = L2_120.day
    if L4_122 then
      L4_122 = L2_120.day
      if L4_122 ~= 0 then
        L4_122 = L2_120.day
        L4_122 = L4_122 * 24
        L3_121 = L3_121 + L4_122
      end
    end
    L4_122 = string
    L4_122 = L4_122.format
    L4_122 = L4_122("%02d:%02d:%02d", L3_121, L2_120.min or 0, L2_120.sec or 0)
    A0_118.strTime = L4_122
    A0_118:FireEvent(EVT.MSG_LOTTERY_TIME, L4_122)
    Singleton(Timer):After(1000, A0_118:Event("DecLotteryTime"))
  else
    A0_118.lotteryTime = nil
    A0_118.strTime = nil
    L3_121 = A0_118
    L2_120 = A0_118.FireEvent
    L4_122 = EVT
    L4_122 = L4_122.MSG_LOTTERY_OK
    L2_120(L3_121, L4_122)
  end
end
function class.CheckCanLottery(A0_123)
  if not A0_123.lotteryTime then
    return true
  end
  return Logic:Get("System"):DiffTime(A0_123.lotteryTime) <= 0
end
function class.GetArmorColdTime(A0_124, A1_125)
  local L2_126, L3_127, L4_128, L5_129, L6_130, L7_131, L8_132, L9_133, L10_134, L11_135
  if not A1_125 then
    return
  end
  L2_126 = A1_125.resetDate
  L2_126 = L2_126 or A1_125.coldTime
  L3_127 = A1_125.id
  L4_128 = false
  L5_129 = ""
  if L2_126 then
    if not L3_127 then
      L6_130 = ""
      return L6_130
    end
    L6_130 = KFDBGetRecord
    L7_131 = "EquipLottery"
    L8_132 = L3_127
    L6_130 = L6_130(L7_131, L8_132)
    L7_131 = tonumber
    L8_132 = A1_125.cooldownHours
    L7_131 = L7_131(L8_132)
    L7_131 = L7_131 or 48
    if L6_130 then
      L8_132 = L6_130.resetTimesHours
      if L8_132 then
        L8_132 = L6_130.resetTimesHours
        L7_131 = L8_132 or L7_131
      end
    end
    L8_132 = L2_126 / 1000
    L9_133 = L7_131 * 3600
    L8_132 = L8_132 + L9_133
    L9_133 = Logic
    L10_134 = L9_133
    L9_133 = L9_133.Get
    L11_135 = "System"
    L9_133 = L9_133(L10_134, L11_135)
    L10_134 = L9_133
    L9_133 = L9_133.DiffTime
    L11_135 = L8_132
    L9_133 = L9_133(L10_134, L11_135)
    if L9_133 > 0 then
      L10_134 = Logic
      L11_135 = L10_134
      L10_134 = L10_134.Get
      L10_134 = L10_134(L11_135, "System")
      L11_135 = L10_134
      L10_134 = L10_134.SecToDay
      L10_134 = L10_134(L11_135, L9_133)
      L10_134 = L10_134 or {}
      L11_135 = L10_134.hour
      L11_135 = L11_135 or 0
      if L10_134.day and L10_134.day ~= 0 then
        L11_135 = L11_135 + L10_134.day * 24
      end
      L5_129 = string.format("%02d:%02d:%02d", L11_135, L10_134.min or 0, L10_134.sec or 0)
    else
      L4_128 = true
    end
  end
  L6_130 = KFDBGetRecord
  L7_131 = "EquipLottery"
  L8_132 = L3_127
  L6_130 = L6_130(L7_131, L8_132)
  if L6_130 then
    L7_131 = L6_130.resetTimes
    if L7_131 then
      L7_131 = L6_130.resetTimes
      L8_132 = A1_125.usedFreeTimes
      if L8_132 ~= 0 then
        L8_132 = A1_125.usedFreeTimes
      elseif L7_131 > L8_132 then
        L4_128 = true
      end
    end
  end
  L7_131 = L5_129
  L8_132 = L4_128
  return L7_131, L8_132
end
function class.SetFromArmor(A0_136, A1_137)
  A0_136.fromArmor = A1_137
end
function class.IsFromArmor(A0_138)
  local L1_139
  L1_139 = A0_138.fromArmor
  return L1_139
end
function class.IsLotteryAcceptJade(A0_140, A1_141)
  A1_141 = A1_141 or A0_140.drawData
  if A1_141 and tonumber(A1_141.id) == 155 then
    return true
  end
  return (KFDBGetRecord("EquipLottery", A1_141.id) or {}).cost ~= "false"
end
