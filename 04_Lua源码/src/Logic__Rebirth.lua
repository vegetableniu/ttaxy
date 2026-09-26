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
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.rebirth.facade.RebirthResults")
EVT = Enum({
  "PROGRESS",
  "RECORD",
  "CLEAR_BATTLE"
})
HONOR_TYPE = Enum({
  "BATTLE",
  "REBIRTH",
  "ELITE"
})
function class.initialize(A0_1)
  super.initialize(A0_1)
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgRebirth", _UPVALUE0_, _UPVALUE1_)
  MsgRebirth:On("PROGRESS", A0_1:Event("OnProgress"))
  MsgRebirth:On("MULTI_ACTION", A0_1:Event("OnMultiaction"))
  MsgRebirth:On("BUY_TIMES", A0_1:Event("OnBuyTimes"))
  MsgRebirth:On("RECORD", A0_1:Event("OnRecord"))
  MsgRebirth:On("QUICK_BATTLE", A0_1:Event("OnQuickBattle"))
  MsgRebirth:On("QUICK_ADVANCE", A0_1:Event("OnQuickAdvance"))
  MsgRebirth:On("QUICK_CAMPAIGN", A0_1:Event("OnQuickCampaign"))
  A0_1.campaignId = ""
  A0_1.lockTowerListMode = false
  A0_1.activeBuys = {}
  A0_1.activeCounts = {}
  A0_1.battles = {}
  A0_1.buyCount = 0
  A0_1.listData = {}
  A0_1.activeProgress = {}
  A0_1.bestRecord = {}
  A0_1.honorType = ""
  A0_1.enterTime = {}
  A0_1.buyCost = KFDBGetRecord("ConfigValue", "REBIRTH:BUY_COST") and json.decode(KFDBGetRecord("ConfigValue", "REBIRTH:BUY_COST").content) or {}
end
function class.dispose(A0_2)
  super.dispose(A0_2)
end
function class.SetActiveProgress(A0_3, A1_4)
  A0_3.activeProgress = A1_4 or {}
end
function class.SetEnterTime(A0_5, A1_6)
  A0_5.enterTime = A1_6 or Logic:Get("System"):GetTimeDate()
end
function class.SetCampaignId(A0_7, A1_8)
  A0_7.campaignId = A1_8
end
function class.GetCampaignId(A0_9)
  local L1_10
  L1_10 = A0_9.campaignId
  return L1_10
end
function class.SetLockTowerListMode(A0_11, A1_12)
  A0_11.lockTowerListMode = A1_12 == true
end
function class.IsLockTowerListMode(A0_13)
  return A0_13.lockTowerListMode == true
end
function class.SetBattleId(A0_14, A1_15)
  A0_14.battleId = A1_15
end
function class.GetBattleId(A0_16)
  local L1_17
  L1_17 = A0_16.battleId
  return L1_17
end
function class.GetListData(A0_18)
  local L1_19
  L1_19 = A0_18.listData
  return L1_19
end
function class.GetBuyCnt(A0_20)
  local L1_21
  L1_21 = A0_20.buyCount
  return L1_21
end
function class.SetBestRecord(A0_22, A1_23)
  A0_22.bestRecord = A1_23 and A1_23 or A0_22.bestRecord
end
function class.GetBestRecord(A0_24)
  local L1_25
  L1_25 = A0_24.bestRecord
  return L1_25
end
function class.SetHonorType(A0_26, A1_27)
  A0_26.honorType = A1_27
end
function class.GetHonorType(A0_28)
  local L1_29
  L1_29 = A0_28.honorType
  return L1_29
end
function class.refreshActiveProgress(A0_30)
  if A0_30:isLimitedActive(A0_30.campaignId) then
    return
  end
  if A0_30:IsClearActiveBattle(A0_30.battleId) then
    return
  end
  table.insert(A0_30.activeProgress, A0_30.battleId)
end
function class.IsClearActiveBattle(A0_31, A1_32)
  if A1_32 == nil or "" == A1_32 then
    return false
  end
  if table.empty(A0_31.activeProgress or {}) then
    return false
  end
  for _FORV_5_, _FORV_6_ in pairs(A0_31.activeProgress) do
    if _FORV_6_ == A1_32 then
      return true
    end
  end
  return false
end
function class.IsClickNewDay(A0_33)
  if A0_33.enterTime == nil or table.empty(A0_33.enterTime) then
    return false
  end
  if A0_33.enterTime.day ~= Logic:Get("System"):GetTimeDate().day then
    return true
  end
  return false
end
function class.isRebirthActive(A0_34, A1_35)
  if A1_35 == nil or "" == A1_35 then
    return false
  end
  if not KFDBGetRecord("CampaignConfig", A1_35) then
    return false
  end
  if KFDBGetRecord("CampaignConfig", A1_35).type == "REBIRTH" then
    return true
  end
  return false
end
function class.isLimitedActive(A0_36, A1_37)
  if A1_37 == nil or "" == A1_37 then
    return false
  end
  if not KFDBGetRecord("CampaignConfig", A1_37) then
    return false
  end
  if KFDBGetRecord("CampaignConfig", A1_37).type == "LIMITED" then
    return true
  end
  return false
end
function class.isFulledActive(A0_38, A1_39)
  if A1_39 == nil or "" == A1_39 then
    return false
  end
  if not KFDBGetRecord("CampaignConfig", A1_39) then
    return false
  end
  if KFDBGetRecord("CampaignConfig", A1_39).type == "FULLED" then
    return true
  end
  return false
end
function class.initListData(A0_40)
  local L1_41, L2_42, L3_43, L4_44, L5_45
  if nil ~= L1_41 then
  elseif "" == L1_41 then
    return
  end
  A0_40.listData = L1_41
  for L4_44 = 1, L2_42(L3_43) do
    L5_45 = KFDBGetRecordByIdx
    L5_45 = L5_45("BattleInfoConfig", L4_44)
    if L5_45 and L5_45.campaignId ~= nil and L5_45.campaignId == A0_40.campaignId and (A0_40:isClearPrevBattle(L5_45.prevId) or Logic:Get("Battle"):IsBattleFinish(L5_45.prevId)) then
      if A0_40.activeBuys and A0_40.activeBuys[L5_45.id] then
        L5_45.dailyCount = L5_45.dailyCount + A0_40.activeBuys[L5_45.id]
      end
      if A0_40.activeCounts and A0_40.activeCounts[L5_45.id] then
        L5_45.dailyCount = L5_45.dailyCount - A0_40.activeCounts[L5_45.id]
      end
      table.insert(A0_40.listData, L5_45)
    end
  end
  L4_44 = L1_41
  L2_42(L3_43, L4_44)
end
function class.isClearPrevBattle(A0_46, A1_47)
  if A1_47 == nil or "" == A1_47 then
    return true
  end
  for _FORV_5_, _FORV_6_ in pairs(A0_46.battles or {}) do
    if A1_47 == _FORV_6_ then
      return true
    end
  end
  return false
end
function class.GetBuyTimeCost(A0_48)
  if A0_48.buyCost == nil or table.empty(A0_48.buyCost) then
    return 0
  end
  if 0 >= A0_48.buyCount + 1 then
  end
  if (1 or A0_48.buyCount + 1) > #A0_48.buyCost then
  end
  return A0_48.buyCost[#A0_48.buyCost or 1 or A0_48.buyCount + 1]
end
function class.GetMaxFreeTimes(A0_49)
  local L1_50, L2_51, L3_52, L4_53, L5_54
  L1_50 = 0
  for L5_54 = 1, L3_52(L4_53) do
    if KFDBGetRecordByIdx("Charge2Times", L5_54) and KFDBGetRecordByIdx("Charge2Times", L5_54).type == "REBIRTH_BUYS" and Logic:Get("PlayerInfo"):GetPlayerMoney().totalCharge >= KFDBGetRecordByIdx("Charge2Times", L5_54).chargeAmount and L1_50 < KFDBGetRecordByIdx("Charge2Times", L5_54).addTimes then
      L1_50 = KFDBGetRecordByIdx("Charge2Times", L5_54).addTimes
    end
  end
  return L1_50
end
function class.IsClearCampaign(A0_55)
  local L1_56, L2_57, L3_58, L4_59, L5_60
  L1_56 = A0_55.campaignId
  if nil ~= L1_56 then
    L1_56 = A0_55.campaignId
  elseif "" == L1_56 then
    L1_56 = false
    return L1_56
  end
  L1_56 = 0
  for L5_60 = 1, L3_58(L4_59) do
    if KFDBGetRecordByIdx("BattleInfoConfig", L5_60) and KFDBGetRecordByIdx("BattleInfoConfig", L5_60).campaignId ~= nil and KFDBGetRecordByIdx("BattleInfoConfig", L5_60).campaignId == A0_55.campaignId then
      L1_56 = L1_56 + 1
    end
  end
  L2_57 = L1_56 <= L2_57
  return L2_57
end
function class.IsSkipCampaign(A0_61)
  local L1_62, L2_63, L3_64, L4_65, L5_66, L6_67
  L2_63 = A0_61
  L1_62 = A0_61.IsClearCampaign
  L1_62 = L1_62(L2_63)
  if not L1_62 then
    L2_63 = false
    return L2_63
  end
  L2_63 = 0
  for L6_67 = 1, L4_65(L5_66) do
    if KFDBGetRecordByIdx("BattleInfoConfig", L6_67) and KFDBGetRecordByIdx("BattleInfoConfig", L6_67).campaignId ~= nil and KFDBGetRecordByIdx("BattleInfoConfig", L6_67).campaignId == A0_61.campaignId then
      L2_63 = L2_63 + 1
    end
  end
  for _FORV_7_, _FORV_8_ in L4_65(L5_66) do
  end
  L4_65 = L3_64 > 0
  return L4_65
end
function class.GetLastBattleId(A0_68)
  local L1_69, L2_70, L3_71, L4_72, L5_73
  if L1_69 ~= nil then
  elseif L1_69 then
    return L1_69
  end
  for L4_72, L5_73 in L1_69(L2_70) do
    if Logic:Get("Battle"):IsLastBattle(L5_73) then
      return L5_73
    end
  end
  return L1_69
end
function class.PostProgress(A0_74)
  if nil == A0_74.campaignId or "" == A0_74.campaignId then
    return
  end
  MsgRebirth:Post("PROGRESS", {
    campaignId = A0_74.campaignId
  })
end
function class.PostMultiaction(A0_75)
  MsgRebirth:Post("MULTI_ACTION", {
    battleId = A0_75.battleId,
    embattle = Logic:Get("Hero"):GetSendGroupHeros()
  })
end
function class.PostBuyTimes(A0_76)
  MsgRebirth:Post("BUY_TIMES", {
    battleId = A0_76.battleId
  })
end
function class.PostRecord(A0_77)
  MsgRebirth:Post("RECORD", {
    battleId = A0_77.battleId
  })
end
function class.PostQuickBattle(A0_78)
  MsgRebirth:Post("QUICK_BATTLE", {
    battleId = A0_78.battleId
  })
end
function class.PostQuickAdvance(A0_79)
  MsgRebirth:Post("QUICK_ADVANCE", {
    battleId = A0_79.battleId
  })
end
function class.PostQuickCampaign(A0_80)
  if nil == A0_80.campaignId or "" == A0_80.campaignId then
    return
  end
  MsgRebirth:Post("QUICK_CAMPAIGN", {
    campaignId = A0_80.campaignId
  })
end
function class.OnProgress(A0_81, A1_82, A2_83)
  if A1_82 ~= 0 or A2_83 == nil then
    return
  end
  A0_81.activeBuys = A2_83.activeBuys
  A0_81.activeCounts = A2_83.activeCounts
  A0_81.battles = A2_83.battles
  A0_81.buyCount = A2_83.buyCount
  A0_81:initListData()
  A0_81:FireEvent(EVT.PROGRESS)
end
function class.OnMultiaction(A0_84, A1_85, A2_86)
  if A1_85 ~= 0 or A2_86 == nil then
    return
  end
  Logic:Get("Devil"):SetHasDemog(A2_86.hasDemog)
  Logic:Get("Hero"):clearGroupEmbattle()
  Logic:Get("Battle"):SetCurSelBattleId(A0_84.battleId)
  if A2_86.finished then
    A0_84:refreshActiveProgress()
    A0_84:FireEvent(EVT.CLEAR_BATTLE, A0_84.battleId)
  end
  Logic:Get("BattleShow"):CleanUp()
  if Logic:Get("BattleShow"):IsInFulled() then
    Logic:Get("Battle"):SetEmBattleType(Logic.Battle.BATTLE_TYPE.ARENA)
    Logic:Get("BattleShow"):SetResultUI("BattleShowResult")
  end
  Logic:Get("BattleShow"):SetBattleResult(A2_86.finished)
  Logic:Get("BattleShow"):SetCostAndReward(A2_86.costAndReward)
  Logic:Get("BattleShow"):SetEnemyCount(1, 3)
  Logic:Get("BattleShow"):SetEnterBattle(true)
  Logic:Get("BattleShow"):SetReward(A2_86.triggers[1].drops, A2_86.triggers[1].coins)
  Logic:Get("BattleShow"):SetTotleMultiFightWaves(A2_86.groupNum * A2_86.triggers[1].enemyNum)
  Logic:Get("BattleShow"):SetMultiFightWaves(A2_86.groupNum, A2_86.triggers[1].enemyNum)
  Logic:Get("BattleShow"):SaveMultiFightReport(A2_86.triggers[1].reports)
  Logic:Get("BattleShow"):StartMultiFightReport()
end
function class.OnBuyTimes(A0_87, A1_88, A2_89)
  if A1_88 ~= 0 or A2_89 == nil then
    return
  end
  A0_87.activeBuys = A0_87.activeBuys == nil and {} or A0_87.activeBuys
  A0_87.activeBuys[A0_87.battleId] = A0_87.activeBuys[A0_87.battleId] and A0_87.activeBuys[A0_87.battleId] + 1 or 1
  Logic:Get("Cost"):AddCosts(A2_89.costResults)
  A0_87.buyCount = A0_87.buyCount + 1
  A0_87:initListData()
  A0_87:FireEvent(EVT.PROGRESS)
  Prompt:Msg(TwGetStr(105207))
end
function class.OnRecord(A0_90, A1_91, A2_92)
  if A1_91 ~= 0 or A2_92 == nil then
    return
  end
  A0_90.bestRecord = A2_92
  A0_90:FireEvent(EVT.RECORD)
end
function class.OnQuickBattle(A0_93, A1_94, A2_95)
  if A1_94 ~= 0 or A2_95 == nil then
    return
  end
  Logic:Get("Battle"):SetBattleId(A2_95.battleId)
  Logic:Get("Devil"):SetHasDemog(A2_95.hasDemog)
  if A2_95.finished then
    A0_93:refreshActiveProgress()
    A0_93:FireEvent(EVT.CLEAR_BATTLE, A0_93.battleId)
  end
  Logic:Get("BattleShow"):CleanUp()
  Logic:Get("BattleShow"):SetBattleResult(A2_95.finished)
  Logic:Get("BattleShow"):SetEnterBattle(false)
  Logic:Get("BattleShow"):SetCostAndReward(A2_95.costAndReward)
  Logic:Get("BattleShow"):OnBattleFinished()
end
function class.OnQuickAdvance(A0_96, A1_97, A2_98)
  A0_96:OnQuickBattle(A1_97, A2_98)
end
function class.OnQuickCampaign(A0_99, A1_100, A2_101)
  local L3_102, L4_103, L5_104, L6_105
  if A1_100 ~= 0 then
    return
  end
  L3_102 = Logic
  L4_103 = L3_102
  L3_102 = L3_102.Get
  L5_104 = "Cost"
  L3_102 = L3_102(L4_103, L5_104)
  L4_103 = L3_102
  L3_102 = L3_102.CostAndReward
  L5_104 = A2_101
  L3_102(L4_103, L5_104)
  L4_103 = A0_99
  L3_102 = A0_99.GetLastBattleId
  L3_102 = L3_102(L4_103)
  L5_104 = A0_99
  L4_103 = A0_99.FireEvent
  L6_105 = EVT
  L6_105 = L6_105.CLEAR_BATTLE
  L4_103(L5_104, L6_105, L3_102)
  L4_103 = Logic
  L5_104 = L4_103
  L4_103 = L4_103.Get
  L6_105 = "Reward"
  L4_103 = L4_103(L5_104, L6_105)
  L5_104 = L4_103
  L4_103 = L4_103.AddRewardsTip
  L6_105 = A2_101.rewards
  L4_103 = L4_103(L5_104, L6_105)
  L5_104 = Logic
  L6_105 = L5_104
  L5_104 = L5_104.Get
  L5_104 = L5_104(L6_105, "Reward")
  L6_105 = L5_104
  L5_104 = L5_104.CalcTotleNum
  L6_105 = L5_104(L6_105, A2_101.rewards, nil, "MENPAI_EXP_ADD")
  if L6_105 > 0 then
    L4_103 = L4_103 .. TwGetStr(110203, L6_105)
  end
  Prompt:Confirm(A0_99, "", L4_103, A0_99.refreshList, Prompt.PROMPT_TYPE.CONFIRM)
end
function class.refreshList(A0_106)
  A0_106:PostProgress()
end
