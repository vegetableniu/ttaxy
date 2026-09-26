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
L0_0 = 1000
EVT = Enum({
  "UPDATE_FIGHT_INFO",
  "UPDATE_FIGHT_TIMES",
  "UPDATE_REFRESH_TIME",
  "GET_REWARDS",
  "SHOW_COMPARE",
  "UPDATE_REWARD_LIST",
  "ENTER_REWARD_STORE",
  "REFRESH_INTEGRAL",
  "UPDATE_RANK_LIST",
  "SKIP_FIGHT"
})
RANK_TYPE = Enum({
  "ALL_RANK",
  "MY_RANK",
  "RANK_REWARD"
})
function class.initialize(A0_1)
  local L1_2
  L1_2 = super
  L1_2 = L1_2.initialize
  L1_2(A0_1)
  L1_2 = KFDBGetRecord
  L1_2 = L1_2("ConfigValue", "ARENA:MAX_BUY_TIMES")
  A0_1.maxBuyTimes = L1_2 and tonumber(L1_2.content) or 0
  L1_2 = KFDBGetRecord("ConfigValue", "ARENA:MAX_FREE_TIMES")
  A0_1.maxFreeTimes = L1_2 and tonumber(L1_2.content) or 0
  L1_2 = KFDBGetRecord("ConfigValue", "ARENA:REFRESH_COST")
  A0_1.refreshCost = L1_2 and tonumber(L1_2.content) or 0
  L1_2 = KFDBGetRecord("ConfigValue", "ARENA:BUY_TIMES_COST")
  A0_1.buyTimesCost = L1_2 and json.decode(L1_2.content) or {}
  L1_2 = KFDBGetRecord("ConfigValue", "ARENA:DEFY_COST_POINT")
  A0_1.fightCost = L1_2 and tonumber(L1_2.content) or 0
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgArena", _UPVALUE0_, _UPVALUE1_)
  MsgArena:On("MATCH_LIST", A0_1:Event("OnInitMatchData"))
  MsgArena:On("BUY_DEFY_TIMES", A0_1:Event("OnBuyDefyTimes"))
  MsgArena:On("MANUAL_REFRESH_LIST", A0_1:Event("OnManualRefreshList"))
  MsgArena:On("DEFY_MATCH", A0_1:Event("OnDefyMatch"))
  MsgArena:On("LINEUP_COMPARE", A0_1:Event("OnLineUpCompare"))
  MsgArena:On("CLEAR_COOL_TIME", A0_1:Event("OnClearCoolTime"))
  MsgArena:On("INTEGRAL_EXCHANGE", A0_1:Event("OnIntergralExchange"))
  MsgArena:On("GET_RANK_LIST", A0_1:Event("OnGetRankList"))
  A0_1.fightTimes = 0
  A0_1.leaveBuyTimes = 0
  A0_1.matchList = {}
  A0_1.coolState = false
  A0_1.refreshTime = 0
  A0_1.integral = 0
  A0_1.reports = nil
  A0_1.success = false
  A0_1.fighter = {}
  A0_1.rewards = nil
  A0_1.own = nil
  A0_1.enemy = nil
  A0_1.giftItemData = {}
  A0_1.hasDrawList = {}
  A0_1.rewardList = {}
  A0_1.sendId = -1
  A0_1.storeClicked = false
  A0_1.rank = 0
  A0_1.totalIntegral = 0
  A0_1.rankType = RANK_TYPE.ALL_RANK
  A0_1.defyIntegral = 0
  A0_1.enterMarker = Logic:Get("System"):GetTimeDate()
  A0_1.levelMark = Logic:Get("PlayerInfo"):GetPlayerLevel() or 0
  A0_1.groupData = {}
  A0_1.battleEffect = 0
  A0_1.loseTime = 0
  A0_1.bSkipFight = false
  A0_1.allRankList = {}
  A0_1.myRankList = {}
  A0_1.robotName = ""
  A0_1.hasBuyTimes = 0
  A0_1:randomRobotName()
end
function class.OnReset(A0_3)
  local L1_4
end
function class.setData(A0_5, A1_6)
  local L2_7
  if A1_6 then
    L2_7 = A1_6.battleEffect
    L2_7 = L2_7 or A0_5.battleEffect
    A0_5.battleEffect = L2_7
    L2_7 = A1_6.rank
    L2_7 = L2_7 or A0_5.rank
    A0_5.rank = L2_7
    L2_7 = A1_6.coolState
    A0_5.coolState = L2_7
    L2_7 = A1_6.times
    L2_7 = L2_7 or A0_5.fightTimes
    A0_5.fightTimes = L2_7
    L2_7 = A1_6.leaveBuyTimes
    L2_7 = L2_7 or A0_5.leaveBuyTimes
    A0_5.leaveBuyTimes = L2_7
    L2_7 = A1_6.playerList
    L2_7 = L2_7 or A0_5.matchList
    A0_5.matchList = L2_7
    L2_7 = A1_6.coolTime
    L2_7 = L2_7 or A0_5.refreshTime
    A0_5.refreshTime = L2_7
    L2_7 = A1_6.integral
    L2_7 = L2_7 or A0_5.integral
    A0_5.integral = L2_7
    L2_7 = A1_6.totalIntegral
    L2_7 = L2_7 or A0_5.totalIntegral
    A0_5.totalIntegral = L2_7
    L2_7 = A1_6.hasBuyTimes
    L2_7 = L2_7 or A0_5.hasBuyTimes
    A0_5.hasBuyTimes = L2_7
  end
end
function class.initGiftData(A0_8)
  local L1_9, L2_10, L3_11, L4_12, L5_13, L6_14
  L1_9 = {}
  for L5_13 = 1, L3_11(L4_12) do
    L6_14 = KFDBGetRecordByIdx
    L6_14 = L6_14("IntegralReward", L5_13)
    if L6_14 and Logic:Get("PlayerInfo"):GetPlayerLevel() >= L6_14.minLevel and Logic:Get("PlayerInfo"):GetPlayerLevel() <= L6_14.maxLevel then
      table.insert(L1_9, L6_14)
    end
  end
  return L1_9
end
function class.removeDrawGift(A0_15, A1_16)
  local L2_17, L3_18, L4_19, L5_20, L6_21, L7_22, L8_23, L9_24, L10_25
  for L5_20, L6_21 in L2_17(L3_18) do
    for L10_25 = #A1_16, 1, -1 do
      if L6_21 == v.id then
        table.remove(A1_16, L10_25)
      end
    end
  end
end
function class.IsInitDraw(A0_26)
  local L1_27
  L1_27 = A0_26.initGiftData
  L1_27 = L1_27(A0_26)
  A0_26:removeDrawGift(L1_27)
  for _FORV_5_, _FORV_6_ in pairs(L1_27) do
    if A0_26.integral >= _FORV_6_.integral then
      return true
    end
  end
  return false
end
function class.isLevelChanged(A0_28)
  if Logic:Get("PlayerInfo"):GetPlayerLevel() > A0_28.levelMark then
    A0_28.levelMark = Logic:Get("PlayerInfo"):GetPlayerLevel()
    return true
  end
  return false
end
function class.isOpenDiffDay(A0_29)
  if A0_29.enterMarker.day ~= Logic:Get("System"):GetTimeDate().day then
    A0_29.enterMarker = Logic:Get("System"):GetTimeDate()
    return true
  end
  A0_29.enterMarker = Logic:Get("System"):GetTimeDate()
  return false
end
function class.GetTotalBuyTimesAndCost(A0_30)
  local L1_31, L2_32, L3_33, L4_34, L5_35, L6_36, L7_37, L8_38, L9_39, L10_40
  L1_31 = 0
  L2_32 = 0
  L3_33 = Logic
  L4_34 = L3_33
  L3_33 = L3_33.Get
  L5_35 = "PlayerInfo"
  L3_33 = L3_33(L4_34, L5_35)
  L4_34 = L3_33
  L3_33 = L3_33.GetPlayerAllJade
  L3_33 = L3_33(L4_34)
  L4_34 = 0
  L6_36 = A0_30
  L5_35 = A0_30.GetExtraBuyTimes
  L5_35 = L5_35(L6_36)
  L6_36 = A0_30.maxBuyTimes
  L6_36 = L6_36 + L5_35
  for L10_40 = L7_37 + 1, L6_36 do
    L4_34 = L4_34 + (A0_30.buyTimesCost[L10_40 <= #A0_30.buyTimesCost and L10_40 or #A0_30.buyTimesCost] or 0)
    if L3_33 >= L4_34 then
      L1_31 = L1_31 + 1
      L2_32 = L4_34
    else
      break
    end
  end
  return L7_37, L8_38
end
function class.GetExtraBuyTimes(A0_41)
  local L1_42, L2_43, L3_44, L4_45, L5_46
  L1_42 = 0
  for L5_46 = 1, L3_44(L4_45) do
    if KFDBGetRecordByIdx("Charge2Times", L5_46) and KFDBGetRecordByIdx("Charge2Times", L5_46).type == "ARENA" and Logic:Get("PlayerInfo"):GetPlayerMoney().totalCharge >= KFDBGetRecordByIdx("Charge2Times", L5_46).chargeAmount and L1_42 < KFDBGetRecordByIdx("Charge2Times", L5_46).addTimes then
      L1_42 = KFDBGetRecordByIdx("Charge2Times", L5_46).addTimes
    end
  end
  return L1_42
end
function class.SetSkipFight(A0_47, A1_48)
  A0_47.bSkipFight = A1_48
end
function class.isClickStore(A0_49, A1_50)
  A0_49.storeClicked = A1_50 and A1_50 or false
end
function class.SetSendId(A0_51, A1_52)
  A0_51.sendId = A1_52 or A0_51.sendId
end
function class.GetBattleEffect(A0_53)
  local L1_54
  L1_54 = A0_53.battleEffect
  return L1_54
end
function class.GetGroupData(A0_55)
  local L1_56
  L1_56 = A0_55.groupData
  return L1_56
end
function class.GetGiftData(A0_57)
  local L1_58
  L1_58 = A0_57.giftItemData
  return L1_58
end
function class.GetRewardList(A0_59)
  local L1_60
  L1_60 = A0_59.rewardList
  return L1_60
end
function class.GetIntegral(A0_61)
  local L1_62
  L1_62 = A0_61.integral
  return L1_62
end
function class.GetFightTimes(A0_63)
  local L1_64
  L1_64 = A0_63.fightTimes
  return L1_64
end
function class.GetLeaveBuyTimes(A0_65)
  local L1_66
  L1_66 = A0_65.leaveBuyTimes
  return L1_66
end
function class.GetMatchList(A0_67)
  local L1_68
  L1_68 = A0_67.matchList
  return L1_68
end
function class.GetRefreshTime(A0_69)
  local L1_70
  L1_70 = A0_69.refreshTime
  return L1_70
end
function class.GetBuyTimesCost(A0_71)
  if 1 > #A0_71.buyTimesCost then
  end
  return A0_71.buyTimesCost[#A0_71.buyTimesCost]
end
function class.GetReports(A0_72)
  local L1_73
  L1_73 = A0_72.reports
  return L1_73
end
function class.SetFighter(A0_74, A1_75)
  if A1_75 then
    A0_74.fighter = A1_75
  end
end
function class.GetFighter(A0_76)
  local L1_77
  L1_77 = A0_76.fighter
  return L1_77
end
function class.GetSuccess(A0_78)
  local L1_79
  L1_79 = A0_78.success
  return L1_79
end
function class.GetRewards(A0_80)
  local L1_81
  L1_81 = A0_80.rewards
  return L1_81
end
function class.GetOwn(A0_82)
  local L1_83
  L1_83 = A0_82.own
  return L1_83
end
function class.GetEnemy(A0_84)
  local L1_85
  L1_85 = A0_84.enemy
  return L1_85
end
function class.isColdDown(A0_86)
  local L1_87
  L1_87 = A0_86.coolState
  return L1_87
end
function class.clearCompareData(A0_88)
  local L1_89
  A0_88.own = nil
  A0_88.enemy = nil
end
function class.GetRank(A0_90)
  local L1_91
  L1_91 = A0_90.rank
  return L1_91
end
function class.AddTotalIntegral(A0_92, A1_93)
  local L2_94
  L2_94 = A0_92.totalIntegral
  L2_94 = L2_94 + (A1_93 or 0)
  A0_92.totalIntegral = L2_94
end
function class.GetTotalIntegral(A0_95)
  local L1_96
  L1_96 = A0_95.totalIntegral
  return L1_96
end
function class.GetFightCost(A0_97)
  local L1_98
  L1_98 = A0_97.fightCost
  return L1_98
end
function class.GetRankType(A0_99)
  local L1_100
  L1_100 = A0_99.rankType
  return L1_100
end
function class.SetRankType(A0_101, A1_102)
  if A1_102 == nil then
    return
  end
  A0_101.rankType = A1_102
end
function class.GetDefyIntegral(A0_103)
  local L1_104
  L1_104 = A0_103.defyIntegral
  return L1_104
end
function class.GetAllRankList(A0_105)
  local L1_106
  L1_106 = A0_105.allRankList
  return L1_106
end
function class.GetMyRankList(A0_107)
  local L1_108
  L1_108 = A0_107.myRankList
  return L1_108
end
function class.clearRankList(A0_109)
  local L1_110
  L1_110 = {}
  A0_109.allRankList = L1_110
  L1_110 = {}
  A0_109.myRankList = L1_110
end
function class.GetWaitTime(A0_111)
  local L1_112
  L1_112 = A0_111.waitTime
  return L1_112
end
function class.GetLostTime(A0_113)
  local L1_114
  L1_114 = A0_113.loseTime
  return L1_114
end
function class.PostDefyMatch(A0_115)
  if A0_115.fighter then
    MsgArena:Post("DEFY_MATCH", {
      id = A0_115.fighter.id,
      embattle = Logic:Get("Hero"):GetSendGroupHeros()
    })
  end
end
function class.PostGetMatchList(A0_116)
  MsgArena:Post("MATCH_LIST")
end
function class.setMatchData(A0_117, A1_118)
  A0_117:setData(A1_118)
  table.sort(A0_117.matchList, function(A0_119, A1_120)
    local L3_121
    L3_121 = A0_119.id
    L3_121 = L3_121 == ID[-1]
    return L3_121
  end)
  A0_117:initTimer()
  A0_117:FireEvent(EVT.UPDATE_FIGHT_INFO)
end
function class.SetCompareData(A0_122, A1_123)
  A0_122.own = A1_123.own
  A0_122.enemy = A1_123.enemy
  A0_122.groupData = {}
  for _FORV_5_, _FORV_6_ in pairs(A1_123.own.groups or {}) do
    if _FORV_6_.leaderBaseId > 0 then
      if A0_122.groupData[_FORV_6_.groupId] == nil then
        A0_122.groupData[_FORV_6_.groupId] = {}
      end
      A0_122.groupData[_FORV_6_.groupId].player = _FORV_6_
    end
  end
  for _FORV_5_, _FORV_6_ in pairs(A1_123.enemy.groups or {}) do
    if _FORV_6_.leaderBaseId > 0 then
      if A0_122.groupData[_FORV_6_.groupId] == nil then
        A0_122.groupData[_FORV_6_.groupId] = {}
      end
      A0_122.groupData[_FORV_6_.groupId].enemy = _FORV_6_
    end
  end
end
function class.OnInitMatchData(A0_124, A1_125, A2_126)
  if A1_125 ~= 0 or A2_126 == nil then
    return
  end
  A0_124:setMatchData(A2_126)
end
function class.OnBuyDefyTimes(A0_127, A1_128, A2_129)
  if A1_128 == 0 and A2_129 then
    Logic:Get("Cost"):AddCosts(A2_129.costResults)
    A0_127.leaveBuyTimes = A0_127.maxBuyTimes + A0_127:GetExtraBuyTimes() - A2_129.hasBuyTimes
    A0_127.fightTimes = A2_129.times
    A0_127.hasBuyTimes = A2_129.hasBuyTimes
    A0_127:FireEvent(EVT.UPDATE_FIGHT_TIMES)
    Logic:Get("Mall"):BuySuccussed()
    if Logic:Get("Target"):IsActivityOpen() then
      Logic:Get("Target"):PostGetProgress(nil)
    end
  end
end
function class.OnManualRefreshList(A0_130, A1_131, A2_132)
  if A1_131 == 0 and A2_132 then
    Logic:Get("Cost"):AddCosts(A2_132.costResult)
    A0_130:setData(A2_132)
    A0_130:initTimer()
    A0_130:FireEvent(EVT.UPDATE_FIGHT_INFO)
  end
end
function class.OnDefyMatch(A0_133, A1_134, A2_135)
  local L3_136, L4_137
  if A1_134 == 0 and A2_135 then
    L3_136 = Logic
    L4_137 = L3_136
    L3_136 = L3_136.Get
    L3_136 = L3_136(L4_137, "Hero")
    L4_137 = L3_136
    L3_136 = L3_136.clearGroupEmbattle
    L3_136(L4_137)
    L3_136 = Logic
    L4_137 = L3_136
    L3_136 = L3_136.Get
    L3_136 = L3_136(L4_137, "Cost")
    L4_137 = L3_136
    L3_136 = L3_136.AddCosts
    L3_136(L4_137, A2_135.costResult)
    L4_137 = A0_133
    L3_136 = A0_133.setData
    L3_136(L4_137, A2_135.matchPlayerList)
    L4_137 = A0_133
    L3_136 = A0_133.initTimer
    L3_136(L4_137)
    L3_136 = A2_135.success
    A0_133.success = L3_136
    L3_136 = A2_135.reports
    A0_133.reports = L3_136
    L3_136 = A2_135.rewards
    A0_133.rewards = L3_136
    L3_136 = A2_135.rewards
    if L3_136 ~= nil then
      L3_136 = Logic
      L4_137 = L3_136
      L3_136 = L3_136.Get
      L3_136 = L3_136(L4_137, "Reward")
      L4_137 = L3_136
      L3_136 = L3_136.AddRewards
      L3_136(L4_137, A2_135.rewards)
    end
    L3_136 = A2_135.integral
    A0_133.defyIntegral = L3_136
    L3_136 = A0_133.bSkipFight
    if L3_136 then
      L4_137 = A0_133
      L3_136 = A0_133.FireEvent
      L3_136(L4_137, EVT.SKIP_FIGHT)
      A0_133.bSkipFight = false
      return
    end
    L3_136 = Logic
    L4_137 = L3_136
    L3_136 = L3_136.Get
    L3_136 = L3_136(L4_137, "BattleShow")
    L4_137 = L3_136.CleanUp
    L4_137(L3_136)
    L4_137 = L3_136.SetArenaPairMode
    L4_137(L3_136, true)
    L4_137 = L3_136.SetEnemyCount
    L4_137(L3_136, 1, 3)
    L4_137 = L3_136.SetEnterBattle
    L4_137(L3_136, true)
    L4_137 = L3_136.SetDefenderArtifactLevel
    L4_137(L3_136, A2_135.targetArtifactLevel)
    L4_137 = A2_135.reports
    L4_137 = L4_137 or {}
    L3_136:SetTotleMultiFightWaves(#L4_137)
    L3_136:SetMultiFightWaves(A2_135.groupNum, A2_135.targetGroupNum)
    L3_136:SaveMultiFightReport(L4_137)
    L3_136:StartMultiFightReport()
  end
end
function class.OnLineUpCompare(A0_138, A1_139, A2_140)
  if A1_139 == 0 and A2_140 then
    A0_138:SetCompareData(A2_140)
    A0_138:FireEvent(EVT.SHOW_COMPARE)
  end
end
function class.OnClearCoolTime(A0_141, A1_142, A2_143)
  if A1_142 == 0 and A2_143 then
    Logic:Get("Cost"):AddCosts(A2_143)
    A0_141.refreshTime = 0
    A0_141.coolState = false
    A0_141:initTimer()
  end
end
function class.OnGetIntegralReward(A0_144, A1_145, A2_146)
  if A1_145 == 0 and A2_146 then
    A0_144.hasDrawList = A2_146.hasDrawList
    A0_144.integral = A2_146.integral
    A0_144.leaveBuyTimes = A2_146.leaveBuyTimes
    A0_144.rewardList = A2_146.rewardList
    A0_144.fightTimes = A2_146.times
    if A0_144.storeClicked then
      A0_144:FireEvent(EVT.ENTER_REWARD_STORE)
      A0_144.storeClicked = false
    else
      A0_144:FireEvent(EVT.GET_REWARDS)
    end
  end
end
function class.OnDrawIntegralReward(A0_147, A1_148, A2_149)
  local L3_150
  if A1_148 == 0 and A2_149 then
    L3_150(L3_150, A2_149)
    if L3_150 > 0 then
      for _FORV_6_, _FORV_7_ in L3_150(A0_147.giftItemData) do
        if A0_147.sendId == _FORV_7_.id then
          table.insert(A0_147.hasDrawList, _FORV_7_.id)
          break
        end
      end
    end
    L3_150(A0_147, EVT.UPDATE_REWARD_LIST)
    Prompt:Fail(L3_150)
  end
end
function class.OnIntergralExchange(A0_151, A1_152, A2_153)
  local L3_154
  if A1_152 == 0 and A2_153 then
    L3_154 = A2_153.totalIntegral
    A0_151.totalIntegral = L3_154
    L3_154 = Logic
    L3_154 = L3_154.Get
    L3_154 = L3_154(L3_154, "Reward")
    L3_154 = L3_154.AddRewards
    L3_154(L3_154, A2_153.rewardResult)
    L3_154 = Logic
    L3_154 = L3_154.Get
    L3_154 = L3_154(L3_154, "Reward")
    L3_154 = L3_154.AddRewardsTip
    L3_154 = L3_154(L3_154, A2_153.rewardResult)
    Prompt:Fail(L3_154)
    A0_151:FireEvent(EVT.REFRESH_INTEGRAL)
  end
end
function class.OnGetRankList(A0_155, A1_156, A2_157)
  local L3_158, L4_159, L5_160, L6_161, L7_162, L8_163
  if A1_156 == 0 and A2_157 then
    L3_158 = Logic
    L3_158 = L3_158.Get
    L3_158 = L3_158(L4_159, L5_160)
    L3_158 = L3_158.GetPlayerName
    L3_158 = L3_158(L4_159)
    for L7_162, L8_163 in L4_159(L5_160) do
      if L7_162 <= 5 then
        table.insert(A0_155.allRankList, L8_163)
      end
      if L8_163.userName == L3_158 then
        for _FORV_12_ = L7_162 - 2, L7_162 + 2 do
          if _FORV_12_ >= 1 and _FORV_12_ <= #A2_157 then
            table.insert(A0_155.myRankList, A2_157[_FORV_12_])
          end
        end
      end
    end
    L4_159(L5_160, L6_161)
  end
end
function class.PostIntegralReward(A0_164)
  MsgArena:Post("GET_INTEGRAL_REWARD")
end
function class.initTimer(A0_165)
  A0_165.lastTime = Logic:Get("System"):GetTime() + (A0_165.refreshTime or 0)
  if not A0_165.eventTracer:Exist("updatePhyWaitTime") then
    Singleton(Timer):Repeat(_UPVALUE0_, A0_165:Event("updatePhyWaitTime"))
  end
  A0_165:updatePhyWaitTime()
end
function class.updatePhyWaitTime(A0_166)
  A0_166.loseTime = Logic:Get("System"):DiffTime(A0_166.lastTime)
  if A0_166.loseTime <= 0 then
    A0_166:EventTracer():Cancel("updatePhyWaitTime")
  end
  A0_166:FireEvent(EVT.UPDATE_REFRESH_TIME)
end
function class.randomRobotName(A0_167)
  local L1_168, L2_169, L3_170, L4_171, L5_172
  L1_168 = ""
  for L5_172 = 1, 6 do
    L1_168 = L1_168 .. string.char(96 + math.random(26))
  end
  A0_167.robotName = L1_168
end
function class.GetRobotName(A0_173)
  local L1_174
  L1_174 = A0_173.robotName
  return L1_174
end
function class.setGuideFight(A0_175, A1_176)
  A0_175.fightBool = A1_176 or nil
end
function class.isGuideFight(A0_177)
  local L1_178
  L1_178 = A0_177.fightBool
  return L1_178
end
function class.setGuideFightDraw(A0_179, A1_180)
  A0_179.fightDraw = A1_180 or nil
end
function class.isGuideFightDraw(A0_181)
  local L1_182
  L1_182 = A0_181.fightDraw
  return L1_182
end
