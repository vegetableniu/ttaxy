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
L0_0 = L0_0("com.eyu.mt.module.elite.facade.EliteResult")
EVT = Enum({
  "GET_BATTLES_TIMES",
  "RECORD",
  "BUY_TIMES",
  "ON_QUICK_ADVANCE",
  "FIRST_CLEAR",
  "FIRST_RECORD"
})
function class.initialize(A0_1)
  super.initialize(A0_1)
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgElite", _UPVALUE0_, _UPVALUE1_)
  MsgElite:On("GET_BATTLES_TIMES", A0_1:Event("OnGetBattlesTimes"))
  MsgElite:On("MULTI_ACTION", A0_1:Event("OnMultiaction"))
  MsgElite:On("BUY_TIMES", A0_1:Event("OnBuyTimes"))
  MsgElite:On("RECORD", A0_1:Event("OnRecord"))
  MsgElite:On("QUICK_ADVANCE", A0_1:Event("OnQuickAdvance"))
  MsgElite:On("FIRST_RECORD", A0_1:Event("OnFirstRecord"))
  A0_1.campaignId = ""
  A0_1.activeBuys = {}
  A0_1.activeCounts = {}
  A0_1.battles = {}
  A0_1.campaigns = {}
  A0_1.bSkipFight = false
  A0_1.campaignList = {}
  A0_1.battleList = {}
end
function class.dispose(A0_2)
  super.dispose(A0_2)
end
function class.SetCampaignId(A0_3, A1_4)
  A0_3.campaignId = A1_4
end
function class.GetCampaignId(A0_5)
  local L1_6
  L1_6 = A0_5.campaignId
  return L1_6
end
function class.SetBattleId(A0_7, A1_8)
  A0_7.battleId = A1_8
end
function class.GetBattleId(A0_9)
  local L1_10
  L1_10 = A0_9.battleId
  return L1_10
end
function class.GetCampaignList(A0_11)
  local L1_12
  L1_12 = A0_11.campaignList
  return L1_12
end
function class.GetBattleList(A0_13)
  local L1_14
  L1_14 = A0_13.battleList
  return L1_14
end
function class.IsFirstCampaign(A0_15)
  if not A0_15.campaignId then
    return
  end
  if not (KFDBGetRecord("CampaignConfig", A0_15.campaignId) or {}).prevId or (KFDBGetRecord("CampaignConfig", A0_15.campaignId) or {}).prevId == "" then
    return true
  end
  return false
end
function class.IsFinalCampaign(A0_16, A1_17)
  local L2_18, L3_19, L4_20, L5_21, L6_22, L7_23
  A1_17 = A1_17 or A0_16.campaignId
  if not A1_17 then
    return
  end
  for L5_21 = 1, L3_19(L4_20) do
    L6_22 = KFDBGetRecordByIdx
    L7_23 = "CampaignConfig"
    L6_22 = L6_22(L7_23, L5_21)
    L6_22 = L6_22 or {}
    L7_23 = json
    L7_23 = L7_23.decode
    L7_23 = L7_23(L6_22.prevId or "")
    L7_23 = L7_23 or {}
    for _FORV_11_, _FORV_12_ in ipairs(L7_23) do
      if _FORV_12_ == A1_17 then
        return false
      end
    end
  end
  return L2_18
end
function class.IsFinalBattle(A0_24, A1_25)
  local L2_26, L3_27, L4_28, L5_29
  if not A1_25 then
    return
  end
  for L5_29 = 1, L3_27(L4_28) do
    if (KFDBGetRecordByIdx("BattleInfoConfig", L5_29) or {}).campaignId == A0_24.campaignId and (KFDBGetRecordByIdx("BattleInfoConfig", L5_29) or {}).prevId == A1_25 then
      return false
    end
  end
  return L2_26
end
function class.GetPrevCamp(A0_30, A1_31)
  if not A1_31 then
    return
  end
  return KFDBGetRecord("CampaignConfig", (json.decode((KFDBGetRecord("CampaignConfig", A1_31) or {}).prevId or "") or {})[1]) or {}
end
function class.GetNextCamp(A0_32, A1_33)
  local L2_34, L3_35, L4_36, L5_37, L6_38
  if not A1_33 then
    return
  end
  L2_34 = {}
  for L6_38 = 1, L4_36(L5_37) do
    L2_34 = KFDBGetRecordByIdx("CampaignConfig", L6_38) or {}
    if (json.decode(L2_34.prevId or "") or {})[1] and (json.decode(L2_34.prevId or "") or {})[1] == A1_33 then
      return L2_34
    end
  end
end
function class.CreateCampaignMap(A0_39, A1_40)
  local L2_41, L3_42, L4_43, L5_44, L6_45
  A0_39.campaigns = L2_41
  L3_42 = A1_40 or {}
  for L5_44, L6_45 in L2_41(L3_42) do
    if Logic:Get("Battle"):GetBattleInfoById(L6_45) and Logic:Get("Battle"):IsLastBattle(L6_45) then
      A0_39.campaigns[Logic:Get("Battle"):GetBattleInfoById(L6_45).campaignId] = true
    end
  end
  A0_39.battles = L2_41
end
function class.GetBuyTimesById(A0_46, A1_47)
  if not A1_47 then
    return 0
  end
  if table.empty(A0_46.activeBuys[A0_46.campaignId] or {}) then
    return 0
  end
  if A0_46.activeBuys[A0_46.campaignId][A1_47] then
    return A0_46.activeBuys[A0_46.campaignId][A1_47]
  end
  return 0
end
function class.refreshActiveProgress(A0_48)
  A0_48.bClearBtl = false
  if A0_48.battles[A0_48.battleId] then
    A0_48.bClearBtl = true
    return
  end
  A0_48.battles[A0_48.battleId] = true
  Logic:Get("Battle"):FireEvent(Logic.Battle.EVT.BATTLE_COMPLETED, A0_48.battleId)
  if not Logic:Get("Battle"):IsLastBattle(A0_48.battleId) then
    return
  end
  if not Logic:Get("Battle"):GetBattleInfoById(A0_48.battleId) or "" == Logic:Get("Battle"):GetBattleInfoById(A0_48.battleId).campaignId then
    return
  end
  if A0_48.campaigns[Logic:Get("Battle"):GetBattleInfoById(A0_48.battleId).campaignId] then
    return
  end
  A0_48.campaigns[Logic:Get("Battle"):GetBattleInfoById(A0_48.battleId).campaignId] = true
  Logic:Get("Battle"):FireEvent(Logic.Battle.EVT.CAMPAIGN_COMPLETED, Logic:Get("Battle"):GetBattleInfoById(A0_48.battleId).campaignId)
end
function class.AddClearTimes(A0_49)
  local L1_50, L2_51, L3_52, L4_53
  L1_50 = A0_49.activeCounts
  L2_51 = A0_49.campaignId
  L1_50 = L1_50[L2_51]
  if not L1_50 then
    L1_50 = A0_49.activeCounts
    L2_51 = A0_49.campaignId
    L3_52 = {}
    L1_50[L2_51] = L3_52
  end
  L1_50 = A0_49.activeCounts
  L2_51 = A0_49.campaignId
  L1_50 = L1_50[L2_51]
  L2_51 = A0_49.battleId
  L1_50 = L1_50[L2_51]
  if not L1_50 then
    L1_50 = A0_49.activeCounts
    L2_51 = A0_49.campaignId
    L1_50 = L1_50[L2_51]
    L2_51 = A0_49.battleId
    L1_50[L2_51] = 0
  end
  L1_50 = A0_49.activeCounts
  L2_51 = A0_49.campaignId
  L1_50 = L1_50[L2_51]
  L2_51 = A0_49.battleId
  L3_52 = A0_49.activeCounts
  L4_53 = A0_49.campaignId
  L3_52 = L3_52[L4_53]
  L4_53 = A0_49.battleId
  L3_52 = L3_52[L4_53]
  L4_53 = A0_49.count
  L4_53 = L4_53 or 1
  L3_52 = L3_52 + L4_53
  L1_50[L2_51] = L3_52
  A0_49.count = nil
end
function class.AddBuyTime(A0_54, A1_55)
  local L2_56, L3_57, L4_58, L5_59
  L2_56 = A0_54.activeBuys
  L3_57 = A0_54.campaignId
  L2_56 = L2_56[L3_57]
  if not L2_56 then
    L2_56 = A0_54.activeBuys
    L3_57 = A0_54.campaignId
    L4_58 = {}
    L2_56[L3_57] = L4_58
  end
  L2_56 = A0_54.activeBuys
  L3_57 = A0_54.campaignId
  L2_56 = L2_56[L3_57]
  L3_57 = A0_54.battleId
  L2_56 = L2_56[L3_57]
  if not L2_56 then
    L2_56 = A0_54.activeBuys
    L3_57 = A0_54.campaignId
    L2_56 = L2_56[L3_57]
    L3_57 = A0_54.battleId
    L2_56[L3_57] = 0
  end
  L2_56 = A0_54.activeBuys
  L3_57 = A0_54.campaignId
  L2_56 = L2_56[L3_57]
  L3_57 = A0_54.battleId
  L4_58 = A0_54.activeBuys
  L5_59 = A0_54.campaignId
  L4_58 = L4_58[L5_59]
  L5_59 = A0_54.battleId
  L4_58 = L4_58[L5_59]
  L4_58 = L4_58 + A1_55
  L2_56[L3_57] = L4_58
end
function class.changeValue2Key(A0_60, A1_61)
  local L2_62, L3_63, L4_64, L5_65, L6_66, L7_67
  L2_62 = {}
  L4_64 = A1_61 or {}
  for L6_66, L7_67 in L3_63(L4_64) do
    if type(L7_67) == "string" or type(L7_67) == "number" then
      L2_62[L7_67] = L6_66
    end
  end
  return L2_62
end
function class.initCampaignList(A0_68, A1_69)
  local L2_70, L3_71, L4_72, L5_73, L6_74
  A0_68.campaignList = L2_70
  for L5_73 = 1, L3_71(L4_72) do
    L6_74 = KFDBGetRecordByIdx
    L6_74 = L6_74("CampaignConfig", L5_73)
    L6_74 = L6_74 or {}
    if A0_68:IsShowCampLst(L6_74, A1_69) then
      table.insert(A0_68.campaignList, L6_74)
    end
  end
  L5_73 = L2_70
  L3_71(L4_72, L5_73)
end
function class.IsShowCampLst(A0_75, A1_76, A2_77)
  local L3_78, L4_79, L5_80, L6_81, L7_82, L8_83
  if A1_76 then
    L3_78 = A1_76.type
  elseif not L3_78 then
    L3_78 = false
    return L3_78
  end
  A2_77 = A2_77 or "ELITE"
  L3_78 = A1_76.type
  if A2_77 ~= L3_78 then
    L3_78 = false
    return L3_78
  end
  L3_78 = A0_75.IsClearCampaign
  L3_78 = L3_78(L4_79, L5_80)
  if L3_78 then
    L3_78 = true
    return L3_78
  end
  L3_78 = A1_76.prevId
  if "" == L3_78 then
    L3_78 = true
    return L3_78
  end
  L3_78 = json
  L3_78 = L3_78.decode
  L3_78 = L3_78(L4_79)
  L3_78 = L3_78 or {}
  for L7_82, L8_83 in L4_79(L5_80) do
    if not A0_75:IsClearCampaign(L8_83) then
      return false
    end
  end
  return L4_79
end
function class.IsClearCampaign(A0_84, A1_85)
  if Logic:Get("Battle"):IsCampainFinish(A1_85) then
    return true
  end
  if A0_84.campaigns[A1_85] then
    return true
  end
  return false
end
function class.initBattleList(A0_86, A1_87)
  local L2_88, L3_89, L4_90, L5_91, L6_92, L7_93
  A0_86.battleList = L2_88
  for L5_91 = 1, L3_89(L4_90) do
    L6_92 = KFDBGetRecordByIdx
    L7_93 = "BattleInfoConfig"
    L6_92 = L6_92(L7_93, L5_91)
    if L6_92 then
      L7_93 = L6_92.campaignId
      if L7_93 then
        L7_93 = L6_92.campaignId
        if L7_93 == A0_86.campaignId then
          L7_93 = A0_86.isClearPrevBattle
          L7_93 = L7_93(A0_86, L6_92.id, A1_87)
          if L7_93 then
            L7_93 = {}
            for _FORV_11_, _FORV_12_ in pairs(L6_92) do
              L7_93[_FORV_11_] = _FORV_12_
            end
            if A0_86.activeCounts and A0_86.activeCounts[L6_92.campaignId] and A0_86.activeCounts[L6_92.campaignId][L6_92.id] then
              L7_93.dailyCount = math.max(0, (tonumber(L6_92.dailyCount) or 0) - A0_86.activeCounts[L6_92.campaignId][L6_92.id])
            end
            table.insert(A0_86.battleList, L7_93)
          end
        end
      end
    end
  end
  L5_91 = L2_88
  L3_89(L4_90, L5_91)
end
function class.isClearPrevBattle(A0_94, A1_95, A2_96)
  local L3_97, L4_98
  L3_97 = Logic
  L4_98 = L3_97
  L3_97 = L3_97.Get
  L3_97 = L3_97(L4_98, "Battle")
  L4_98 = L3_97
  L3_97 = L3_97.GetBattleInfoById
  L3_97 = L3_97(L4_98, A1_95)
  if not L3_97 then
    L4_98 = false
    return L4_98
  end
  L4_98 = Logic
  L4_98 = L4_98.Get
  L4_98 = L4_98(L4_98, "Battle")
  L4_98 = L4_98.GetCampaignInfoById
  L4_98 = L4_98(L4_98, L3_97.campaignId)
  if "" == L3_97.prevId and A0_94:IsShowCampLst(L4_98, A2_96) then
    return true
  end
  if Logic:Get("Battle"):IsBattleFinish(L3_97.prevId) then
    return true
  end
  if A0_94:IsClearBattle(L3_97.prevId) then
    return true
  end
  return false
end
function class.IsClearBattle(A0_99, A1_100)
  local L2_101
  if not A1_100 then
    L2_101 = false
    return L2_101
  end
  L2_101 = A0_99.battles
  L2_101 = L2_101[A1_100]
  if L2_101 then
    L2_101 = true
    return L2_101
  end
  L2_101 = false
  return L2_101
end
function class.GetAllCampaign(A0_102, A1_103)
  local L2_104, L3_105, L4_106, L5_107, L6_108, L7_109
  if not A1_103 then
    L2_104 = {}
    return L2_104
  end
  L2_104 = {}
  for L6_108 = 1, L4_106(L5_107) do
    L7_109 = KFDBGetRecordByIdx
    L7_109 = L7_109("CampaignConfig", L6_108)
    L7_109 = L7_109 or {}
    if L7_109.type == A1_103 then
      table.insert(L2_104, L7_109)
    end
  end
  L6_108 = L3_105
  L4_106(L5_107, L6_108)
  return L2_104
end
function class.GetAllBattles(A0_110, A1_111)
  local L2_112, L3_113, L4_114, L5_115, L6_116, L7_117
  if not A1_111 then
    L2_112 = {}
    return L2_112
  end
  L2_112 = {}
  for L6_116 = 1, L4_114(L5_115) do
    L7_117 = KFDBGetRecordByIdx
    L7_117 = L7_117("BattleInfoConfig", L6_116)
    L7_117 = L7_117 or {}
    if L7_117.campaignId == A1_111 then
      table.insert(L2_112, L7_117)
    end
  end
  return L2_112
end
function class.PostGetBattlesTimes(A0_118)
  MsgElite:Post("GET_BATTLES_TIMES")
end
function class.PostMultiaction(A0_119, A1_120)
  A0_119.bSkipFight = A1_120
  A0_119.bClearCamp = A0_119:IsClearCampaign(A0_119.campaignId)
  MsgElite:Post("MULTI_ACTION", {
    battleId = A0_119.battleId,
    embattle = Logic:Get("Hero"):GetSendGroupHeros(),
    quick = A1_120
  })
end
function class.PostBuyTimes(A0_121)
  MsgElite:Post("BUY_TIMES", {
    battleId = A0_121.battleId
  })
end
function class.PostRecord(A0_122)
  MsgElite:Post("RECORD", {
    battleId = A0_122.battleId
  })
end
function class.OnGetBattlesTimes(A0_123, A1_124, A2_125)
  if A1_124 ~= 0 or A2_125 == nil then
    return
  end
  A0_123.activeBuys = A2_125.battleBuys
  A0_123.activeCounts = A2_125.battleCounts
  A0_123:initCampaignList()
  A0_123:FireEvent(EVT.GET_BATTLES_TIMES)
end
function class.OnMultiaction(A0_126, A1_127, A2_128)
  if A1_127 ~= 0 or A2_128 == nil then
    return
  end
  Logic:Get("Hero"):clearGroupEmbattle()
  if A0_126.bSkipFight then
    A0_126:OnQuickBattle(0, A2_128)
    return
  end
  Logic:Get("Battle"):SetCurSelBattleId(A0_126.battleId)
  Logic:Get("Devil"):SetHasDemog(A2_128.hasDemog)
  if A2_128.finished then
    A0_126:refreshActiveProgress()
    A0_126:AddClearTimes()
  end
  if A0_126:IsClearCampaign(A0_126.campaignId) ~= A0_126.bClearCamp then
    A0_126:FireEvent(EVT.FIRST_CLEAR)
  end
  Logic:Get("BattleShow"):CleanUp()
  Logic:Get("Battle"):SetEmBattleType(Logic.Battle.BATTLE_TYPE.ARENA)
  Logic:Get("BattleShow"):SetResultUI("BattleShowResult")
  Logic:Get("BattleShow"):SetBattleResult(A2_128.finished)
  Logic:Get("BattleShow"):SetCostAndReward(A2_128.costAndReward)
  Logic:Get("BattleShow"):SetEnemyCount(1, 3)
  Logic:Get("BattleShow"):SetEnterBattle(true)
  Logic:Get("BattleShow"):SetReward(A2_128.triggers[1].drops, A2_128.triggers[1].coins)
  Logic:Get("BattleShow"):SetTotleMultiFightWaves(A2_128.groupNum * A2_128.triggers[1].enemyNum)
  Logic:Get("BattleShow"):SetMultiFightWaves(A2_128.groupNum, A2_128.triggers[1].enemyNum)
  Logic:Get("BattleShow"):SaveMultiFightReport(A2_128.triggers[1].reports)
  Logic:Get("BattleShow"):StartMultiFightReport()
end
function class.OnBuyTimes(A0_129, A1_130, A2_131)
  local L3_132
  if A1_130 ~= 0 or A2_131 == nil then
    return
  end
  L3_132 = A0_129.activeCounts
  L3_132[A0_129.campaignId] = A0_129.activeCounts[A0_129.campaignId] or {}
  L3_132 = A0_129.activeCounts
  L3_132 = L3_132[A0_129.campaignId]
  L3_132[A0_129.battleId] = 0
  L3_132 = 1
  A0_129:AddBuyTime(L3_132)
  Logic:Get("Cost"):AddCosts(A2_131.costResults)
  A0_129:FireEvent(EVT.BUY_TIMES)
  Prompt:Msg(TwGetStr(114121))
end
function class.OnRecord(A0_133, A1_134, A2_135)
  if A1_134 ~= 0 or A2_135 == nil then
    return
  end
  Logic:Get("Rebirth"):SetBestRecord(A2_135)
  A0_133:FireEvent(EVT.RECORD)
end
function class.OnFirstRecord(A0_136, A1_137, A2_138)
  if A1_137 ~= 0 or A2_138 == nil then
    return
  end
  Logic:Get("Battle"):SetFirstRecord(A2_138)
  A0_136:FireEvent(EVT.FIRST_RECORD)
end
function class.OnQuickBattle(A0_139, A1_140, A2_141)
  if A1_140 ~= 0 or A2_141 == nil then
    return
  end
  Logic:Get("Battle"):SetBattleId(A2_141.battleId)
  Logic:Get("Devil"):SetHasDemog(A2_141.hasDemog)
  if A2_141.finished then
    A0_139:refreshActiveProgress()
    A0_139:AddClearTimes()
  end
  Logic:Get("BattleShow"):CleanUp()
  Logic:Get("BattleShow"):SetBattleResult(A2_141.finished)
  Logic:Get("BattleShow"):SetEnterBattle(false)
  Logic:Get("BattleShow"):SetCostAndReward(A2_141.costAndReward)
  Logic:Get("BattleShow"):OnBattleFinished()
end
function class.PostQuickAdvance(A0_142, A1_143)
  if not A1_143 or not A0_142.battleId then
    return
  end
  if type(A1_143) ~= "number" or A1_143 <= 0 then
    return
  end
  A0_142.count = A1_143
  MsgElite:Post("QUICK_ADVANCE", {
    advanceCount = A1_143,
    battleId = A0_142.battleId
  })
end
function class.OnQuickAdvance(A0_144, A1_145, A2_146)
  if A1_145 ~= 0 or not A2_146 then
    return
  end
  Logic:Get("Battle"):SetCurSelBattleId(A0_144.battleId)
  Logic:Get("Devil"):SetHasDemog(A2_146.exitVo.hasDemog)
  if not A2_146.failed then
    A0_144:refreshActiveProgress()
    A0_144:AddClearTimes()
  end
  Logic:Get("BattleShow"):CleanUp()
  Logic:Get("BattleShow"):SetBattleResult(not A2_146.failed)
  Logic:Get("BattleShow"):SetEnterBattle(false)
  Logic:Get("BattleShow"):SetCostAndReward(A2_146.exitVo.costAndReward)
  Logic:Get("BattleShow"):SetResultUI("BattleShowResult")
  Logic:Get("Hero"):setEmbattleArry()
  Logic:Get("Battle"):SetBattleId(A2_146.battleId)
  Logic:Get("Battle"):FireEvent(Logic.Battle.EVT.BATTLE_FINISHED, A2_146.battleId, not A2_146.failed)
  A0_144:FireEvent(EVT.ON_QUICK_ADVANCE, A2_146.battleId, not A2_146.failed)
end
function class.isEliteBattle(A0_147)
  return A0_147.eliteGuideBool or false
end
function class.setEliteBattle(A0_148, A1_149)
  A0_148.eliteGuideBool = A1_149
end
function class.GetClearBtlFlag(A0_150, ...)
  local L2_152
  L2_152 = A0_150.bClearBtl
  return L2_152
end
function class.GetCountByBattleId(A0_153, A1_154)
  if not A1_154 then
    return 0
  end
  for _FORV_5_, _FORV_6_ in ipairs(A0_153.battleList) do
    if _FORV_6_.id == A1_154 then
      return _FORV_6_.dailyCount
    end
  end
  return 0
end
function class.IsActiveCountEmpty(A0_155, ...)
  return table.empty(A0_155.activeCounts or {})
end
function class.SetFirstRecordType(A0_157, A1_158)
  A0_157.honorType = A1_158
end
function class.GetFirstRecordType(A0_159)
  local L1_160
  L1_160 = A0_159.honorType
  return L1_160
end
