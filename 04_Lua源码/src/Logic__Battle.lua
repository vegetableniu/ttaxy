local L0_0, L1_1
L0_0 = module
L1_1 = (...)
L0_0(L1_1, package.seeall)
L0_0 = require
L1_1 = "Logic"
L0_0(L1_1)
L0_0 = Enum
L1_1 = {
  "CAMPAIGN",
  "ACTIVE",
  "ARENA",
  "DEMOG",
  "REBIRTH",
  "FULLED",
  "ELITE",
  "PILL"
}
L0_0 = L0_0(L1_1)
BATTLE_TYPE = L0_0
L0_0 = {}
L0_0.NORMAL = "NORMAL"
L0_0.HARD = "HARD"
L0_0.ACTIVE = "ACTIVE"
CAMPAIGN_TYPE = L0_0
L0_0 = Enum
L1_1 = {"OPEN", "OVER"}
L0_0 = L0_0(L1_1)
CAMPAIN_STATE = L0_0
L0_0 = Enum
L1_1 = {"OPEN", "OVER"}
L0_0 = L0_0(L1_1)
BATTLE_STATE = L0_0
L0_0 = Enum
L1_1 = {
  "BEFORE",
  "IN",
  "END"
}
L0_0 = L0_0(L1_1)
ACTIVE_STATE = L0_0
L0_0 = Enum
L1_1 = {"CAMPAIGN", "BATTLE"}
L0_0 = L0_0(L1_1)
UI_LAYER_TYPE = L0_0
L0_0 = Enum
L1_1 = {
  "CLICK_BATTLE_COPY_FRIEND_ITEM",
  "CLICK_BATTLE_COPY_ITEM",
  "REFRESH_BATTLE_COPY",
  "REOPEN_BATTLE_COPY",
  "OPEN_BATTLE_FRIEND",
  "BATTLE_FINISHED",
  "BATTLE_COMPLETED",
  "CAMPAIGN_COMPLETED",
  "SET_UI_NEXT_LAYER",
  "SET_UI_CAMPAIGN_TYPE",
  "ENTER_BATTLE",
  "EXIT_BATTLE",
  "EMBATTLE_SCENE_RETURN",
  "BATTLE_FRIEND_SCENE_RETURN",
  "SELECT_ONE_BATTLE",
  "BEST_RECORD",
  "FIRST_RECORD"
}
L0_0 = L0_0(L1_1)
EVT = L0_0
L0_0 = 60000
L1_1 = TypeDef
L1_1 = L1_1("com.eyu.mt.module.battle.facade.SingleResults")
class = Logic.class:subclass()
function class.initialize(A0_2)
  super.initialize(A0_2)
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgBattle", _UPVALUE0_, _UPVALUE1_)
  MsgBattle:On("PROGRESS", A0_2:Event("OnProgress"))
  MsgBattle:On("TRIGGER", A0_2:Event("OnTrigger"), false)
  MsgBattle:On("ENTER", A0_2:Event("OnEnter"), false)
  MsgBattle:On("EXIT", A0_2:Event("OnExit"), false)
  MsgBattle:On("DAILYCOUNT", A0_2:Event("OnDailyCount"))
  MsgBattle:On("QUICK_BATTLE", A0_2:Event("OnQuickBattle"), false)
  MsgBattle:On("MULTI_ACTION", A0_2:Event("OnMultiAction"), false)
  MsgBattle:On("QUICK_ADVANCE", A0_2:Event("OnQuickAdvance"))
  MsgBattle:On("FIRST_RECORD", A0_2:Event("OnFirstRecord"))
  MsgBattle:On("BEST_RECORD", A0_2:Event("OnBestRecord"))
  Logic:Get("PlayerInfo"):On(Logic.PlayerInfo.EVT.LEVEL_CHANGE, A0_2:Event("OnHeroLevelChange"))
  A0_2.battles = {}
  A0_2.campaigns = {}
  A0_2.current = {}
  A0_2.dailyCounts = {}
  A0_2.curUISelectInfo = {
    campaignId = nil,
    battleId = nil,
    friendId = nil,
    layerType = nil
  }
  A0_2.grpCampaigns = {}
  A0_2.grpCampaigns[CAMPAIGN_TYPE.NORMAL] = {}
  A0_2.grpCampaigns[CAMPAIGN_TYPE.HARD] = {}
  A0_2.grpBattles = {}
  A0_2.embattleType = BATTLE_TYPE.CAMPAIGN
  A0_2.lastBattleCampInfo = {}
  A0_2.parseDataInfo = {}
  A0_2.campMapBattles = nil
  A0_2.prevCampShowLst = {}
  A0_2.openingCamps = {}
  A0_2.openingBattles = {}
  A0_2.bestRecord = {}
  A0_2.firstRecord = {}
  A0_2.failedTimes = 0
  A0_2.IsOpenInBattleCopy = false
end
function class.dispose(A0_3)
  super.dispose(A0_3)
end
function class.ResumeBattleShow(A0_4)
  local L1_5, L2_6, L3_7
  L1_5 = table
  L1_5 = L1_5.empty
  L2_6 = A0_4.current
  L1_5 = L1_5(L2_6)
  if not L1_5 then
    L1_5 = A0_4.current
    L1_5 = L1_5.battleId
  L1_5 = L1_5 ~= nil
  if not L1_5 then
    return
  end
  L2_6 = Logic
  L3_7 = L2_6
  L2_6 = L2_6.Get
  L2_6 = L2_6(L3_7, "BattleShow")
  L3_7 = nil
  if not L2_6:IsInBattleShow() then
    L3_7 = L2_6:GetReport()
  end
  if not L3_7 and (not A0_4.current.success or A0_4.current.finished or 0 == A0_4.current.remains) then
    A0_4:BattleFinished()
  elseif L3_7 then
    L2_6:StartByStoredReport(L3_7)
    return
  else
    A0_4:PostExitMsg()
    return
  end
end
function class.OnEnterWorld(A0_8)
  A0_8:ResumeBattleShow()
  A0_8:RefreshLeftTimes()
end
function class.SetEmBattleType(A0_9, A1_10)
  A0_9.embattleType = A1_10
end
function class.GetEmBattleType(A0_11)
  local L1_12
  L1_12 = A0_11.embattleType
  return L1_12
end
function class.GetFailedTimes(A0_13)
  local L1_14
  L1_14 = A0_13.failedTimes
  return L1_14
end
function class.GetBattleId(A0_15)
  local L1_16
  L1_16 = A0_15.current
  if L1_16 then
    L1_16 = A0_15.current
    L1_16 = L1_16.battleId
  else
    L1_16 = L1_16 or nil
  end
  return L1_16
end
function class.SetBattleId(A0_17, A1_18)
  local L2_19
  L2_19 = A0_17.current
  L2_19 = L2_19 or {}
  A0_17.current = L2_19
  L2_19 = A0_17.current
  L2_19.battleId = A1_18
end
function class.GetCampaignId(A0_20)
  local L1_21
  L1_21 = A0_20.GetBattleId
  L1_21 = L1_21(A0_20)
  if nil == L1_21 then
    return nil
  end
  return A0_20:GetBattleCampaignId(L1_21)
end
function class.SetCurSelBattleId(A0_22, A1_23)
  A0_22.curUISelectInfo.battleId = A1_23
end
function class.GetCurSelBattleId(A0_24)
  local L1_25
  L1_25 = A0_24.curUISelectInfo
  if L1_25 then
    L1_25 = A0_24.curUISelectInfo
    L1_25 = L1_25.battleId
  else
    L1_25 = L1_25 or nil
  end
  return L1_25
end
function class.SetCurSelCampaign(A0_26, A1_27)
  A0_26.curUISelectInfo.campaignId = A1_27
end
function class.GetCurSelCampaign(A0_28)
  local L1_29
  L1_29 = A0_28.curUISelectInfo
  if L1_29 then
    L1_29 = A0_28.curUISelectInfo
    L1_29 = L1_29.campaignId
  else
    L1_29 = L1_29 or nil
  end
  return L1_29
end
function class.SetCurSelFriendId(A0_30, A1_31)
  A0_30.curUISelectInfo.friendId = A1_31
end
function class.GetCurSelFriendId(A0_32)
  local L1_33
  L1_33 = A0_32.curUISelectInfo
  if L1_33 then
    L1_33 = A0_32.curUISelectInfo
    L1_33 = L1_33.friendId
  else
    L1_33 = L1_33 or nil
  end
  return L1_33
end
function class.SetCurSelLayerType(A0_34, A1_35)
  A0_34.curUISelectInfo.layerType = A1_35
end
function class.GetCurSelLayerType(A0_36)
  local L1_37
  L1_37 = A0_36.curUISelectInfo
  if L1_37 then
    L1_37 = A0_36.curUISelectInfo
    L1_37 = L1_37.layerType
  else
    L1_37 = L1_37 or nil
  end
  return L1_37
end
function class.SetBestRecord(A0_38, A1_39)
  A0_38.bestRecord = A1_39
end
function class.GetBestRecord(A0_40)
  local L1_41
  L1_41 = A0_40.bestRecord
  return L1_41
end
function class.SetFirstRecord(A0_42, A1_43)
  A0_42.firstRecord = A1_43
end
function class.GetFirstRecord(A0_44)
  local L1_45
  L1_45 = A0_44.firstRecord
  return L1_45
end
function class.GetCurSelInfo(A0_46)
  local L1_47
  L1_47 = A0_46.curUISelectInfo
  return L1_47
end
function class.ClearCurSelInfo(A0_48)
  A0_48.curUISelectInfo = {}
end
function class.GetLeftTimes(A0_49, A1_50)
  if nil == A0_49:GetBattleInfoById(A1_50) then
    return 0
  end
  if 0 == A0_49:GetBattleInfoById(A1_50).dailyCount then
    return -1
  end
  return math.max(A0_49:GetBattleInfoById(A1_50).dailyCount - (A0_49.dailyCounts[A1_50] or 0), 0)
end
function class.RefreshLeftTimes(A0_51)
  if nil == A0_51.timeLastRefLeftTimes then
    A0_51.timeLastRefLeftTimes = Logic:Get("System"):GetTime()
  elseif Logic:Get("System"):GetTimeDate().day ~= Logic:Get("System"):GetTimeDate(A0_51.timeLastRefLeftTimes).day then
    A0_51:PostDailyCountMsg()
    A0_51.timeLastRefLeftTimes = Logic:Get("System"):GetTime()
  end
end
function class.IsBattleFinish(A0_52, A1_53)
  for _FORV_5_, _FORV_6_ in ipairs(A0_52.battles) do
    if _FORV_6_ == A1_53 then
      return true
    end
  end
  if nil == A0_52:GetBattleInfoById(A1_53) then
    return false
  end
  if A0_52:IsCampainFinish(A0_52:GetBattleInfoById(A1_53).campaignId) then
    return true
  end
  return false
end
function class.IsLastPassBattle(A0_54, A1_55)
  if not A0_54:IsBattleFinish(A1_55) then
    return false
  end
  if A0_54:GetBattleByPreId(A1_55) == nil then
    return true
  end
  return not A0_54:IsBattleFinish(A0_54:GetBattleByPreId(A1_55).id)
end
function class.GetBattleLst(A0_56, A1_57)
  return A0_56.grpBattles[A1_57]
end
function class.IsCampainFinish(A0_58, A1_59)
  for _FORV_5_, _FORV_6_ in ipairs(A0_58.campaigns) do
    if _FORV_6_ == A1_59 then
      return true
    end
  end
  return false
end
function class.GetCampainLst(A0_60, A1_61)
  local L2_62
  L2_62 = A0_60.grpCampaigns
  L2_62 = L2_62[A1_61]
  L2_62 = L2_62 or {}
  return L2_62
end
function class.IsCampInPreShow(A0_63, A1_64)
  return A0_63.prevCampShowLst[A1_64]
end
function class.GetOpenningCamps(A0_65)
  local L1_66
  L1_66 = A0_65.openingCamps
  return L1_66
end
function class.GetOpenningBattles(A0_67)
  local L1_68
  L1_68 = A0_67.openingBattles
  return L1_68
end
function class.ParseCampaignData(A0_69)
  local L1_70, L2_71, L3_72, L4_73, L5_74, L6_75, L7_76, L8_77, L9_78, L10_79, L11_80, L12_81, L13_82, L14_83, L15_84, L16_85, L17_86, L18_87, L19_88, L20_89, L21_90
  L1_70 = A0_69.parseDataInfo
  if L1_70 then
    L1_70 = A0_69.parseDataInfo
    L1_70 = L1_70.finishCampsNum
    if L1_70 then
      L1_70 = A0_69.parseDataInfo
      L1_70 = L1_70.finishBattlesNum
      if L1_70 then
        L1_70 = A0_69.campaigns
        if L1_70 then
          L1_70 = A0_69.campaigns
          L1_70 = #L1_70
        else
          L1_70 = L1_70 or 0
        end
        L2_71 = A0_69.battles
        if L2_71 then
          L2_71 = A0_69.battles
          L2_71 = #L2_71
        else
          L2_71 = L2_71 or 0
        end
        if L1_70 == L3_72 then
          if L2_71 == L3_72 then
            return L3_72
          end
        end
      end
    end
  end
  L1_70 = A0_69.parseDataInfo
  L1_70 = L1_70 or {}
  A0_69.parseDataInfo = L1_70
  L1_70 = A0_69.parseDataInfo
  L2_71 = A0_69.campaigns
  if L2_71 then
    L2_71 = A0_69.campaigns
    L2_71 = #L2_71
  else
    L2_71 = L2_71 or 0
  end
  L1_70.finishCampsNum = L2_71
  L1_70 = A0_69.parseDataInfo
  L2_71 = A0_69.battles
  if L2_71 then
    L2_71 = A0_69.battles
    L2_71 = #L2_71
  else
    L2_71 = L2_71 or 0
  end
  L1_70.finishBattlesNum = L2_71
  L1_70 = {}
  L2_71 = {}
  for L6_75, L7_76 in L3_72(L4_73) do
    L2_71[L7_76] = true
  end
  L6_75 = L5_74
  L6_75 = L6_75()
  L6_75 = L6_75 or {}
  L7_76 = {}
  for L11_80 = 1, L9_78(L10_79) do
    L14_83 = L11_80
    L14_83 = CAMPAIGN_TYPE
    L14_83 = L14_83.NORMAL
    if L13_82 == L14_83 then
      if L13_82 then
        if not L13_82 then
          L14_83 = L12_81.type
          L14_83 = L1_70[L14_83]
          L14_83 = L14_83 or {}
          L1_70[L13_82] = L14_83
          L14_83 = L12_81.type
          L14_83 = L1_70[L14_83]
          L15_84 = L12_81.id
          L13_82(L14_83, L15_84)
        end
      elseif L13_82 ~= "" then
        L14_83 = L12_81
      elseif L13_82 then
        L14_83 = L12_81.type
        L14_83 = L1_70[L14_83]
        L14_83 = L14_83 or {}
        L1_70[L13_82] = L14_83
        L14_83 = L12_81.type
        L14_83 = L1_70[L14_83]
        L15_84 = L12_81.id
        L13_82(L14_83, L15_84)
        L14_83 = L7_76
        L15_84 = L12_81.id
        L13_82(L14_83, L15_84)
      end
    end
  end
  for L13_82, L14_83 in L10_79(L11_80) do
    L9_78[L14_83] = true
  end
  for L14_83, L15_84 in L11_80(L12_81) do
    L16_85 = A0_69.GetCampainBattles
    L16_85 = L16_85(L17_86, L18_87)
    for L20_89, L21_90 in L17_86(L18_87) do
      if A0_69:GetBattleInfoById(L21_90) and (A0_69:GetBattleInfoById(L21_90).prevId == "" or L9_78[A0_69:GetBattleInfoById(L21_90).prevId]) then
        L8_77[L15_84] = L8_77[L15_84] or {}
        table.insert(L8_77[L15_84], L21_90)
        if not L9_78[L21_90] then
          table.insert(L10_79, L21_90)
        end
      end
    end
  end
  for L14_83, L15_84 in L11_80(L12_81) do
    L16_85 = A0_69.GetCampainBattles
    L16_85 = L16_85(L17_86, L18_87)
    for L20_89, L21_90 in L17_86(L18_87) do
      L8_77[L15_84] = L8_77[L15_84] or {}
      table.insert(L8_77[L15_84], L21_90)
    end
  end
  A0_69.grpCampaigns = L1_70
  A0_69.grpBattles = L8_77
  A0_69.prevCampShowLst = L3_72
  A0_69.openingCamps = L7_76
  A0_69.openingBattles = L10_79
  L11_80(L12_81, L13_82)
  L11_80(L12_81, L13_82)
  return L11_80
end
function class.BattleFinished(A0_91, A1_92)
  local L2_93, L3_94, L4_95, L5_96
  if A1_92 ~= nil then
    L2_93 = A0_91.current
    L2_93.success = A1_92
  end
  L2_93 = A0_91.current
  L2_93 = L2_93.battleId
  if nil == L2_93 then
    return
  end
  L3_94 = {}
  A0_91.lastBattleCampInfo = L3_94
  L3_94 = A0_91.lastBattleCampInfo
  L3_94.battleId = L2_93
  L3_94 = A0_91.lastBattleCampInfo
  L4_95 = A0_91.current
  L4_95 = L4_95.success
  L3_94.success = L4_95
  L3_94 = A0_91.current
  L3_94 = L3_94.success
  if L3_94 then
    L4_95 = A0_91
    L3_94 = A0_91.AddDailyCounts
    L5_96 = L2_93
    L3_94(L4_95, L5_96)
    L4_95 = A0_91
    L3_94 = A0_91.OpenNewBattle
    L5_96 = L2_93
    L4_95 = L3_94(L4_95, L5_96)
    L5_96 = A0_91.lastBattleCampInfo
    L5_96.bBattleFinish = L3_94
    L5_96 = A0_91.lastBattleCampInfo
    L5_96.bCampFinish = L4_95
    if L3_94 then
      L5_96 = A0_91.FireEvent
      L5_96(A0_91, EVT.BATTLE_COMPLETED, L2_93)
    end
    if L4_95 then
      L5_96 = A0_91.GetBattleCampaignId
      L5_96 = L5_96(A0_91, L2_93)
      A0_91:FireEvent(EVT.CAMPAIGN_COMPLETED, L5_96)
    end
  end
  L4_95 = A0_91
  L3_94 = A0_91.FireEvent
  L5_96 = EVT
  L5_96 = L5_96.BATTLE_FINISHED
  L3_94(L4_95, L5_96, L2_93, A0_91.current.success)
end
function class.AddDailyCounts(A0_97, A1_98)
  if nil == A1_98 then
    return
  end
  if CAMPAIGN_TYPE.NORMAL == A0_97:GetBattleType(A1_98) then
    A0_97.dailyCounts[A1_98] = (A0_97.dailyCounts[A1_98] or 0) + 1
  end
end
function class.GetLastBattleCampInfo(A0_99)
  local L1_100
  L1_100 = A0_99.lastBattleCampInfo
  return L1_100
end
function class.OpenNewBattle(A0_101, A1_102)
  local L2_103, L3_104, L4_105, L5_106, L6_107, L7_108, L8_109, L9_110, L10_111, L11_112, L12_113, L13_114
  L3_104 = A0_101
  L2_103 = A0_101.GetBattleType
  L4_105 = A1_102
  L2_103 = L2_103(L3_104, L4_105)
  L3_104 = CAMPAIGN_TYPE
  L3_104 = L3_104.NORMAL
  if L2_103 ~= L3_104 then
    L2_103 = false
    L3_104 = false
    return L2_103, L3_104
  end
  L3_104 = A0_101
  L2_103 = A0_101.IsBattleFinish
  L4_105 = A1_102
  L2_103 = L2_103(L3_104, L4_105)
  if L2_103 then
    L2_103 = false
    L3_104 = false
    return L2_103, L3_104
  end
  L3_104 = A0_101
  L2_103 = A0_101.GetBattleInfoById
  L4_105 = A1_102
  L2_103 = L2_103(L3_104, L4_105)
  if nil == L2_103 then
    L3_104 = false
    L4_105 = false
    return L3_104, L4_105
  end
  L3_104 = true
  L4_105 = L2_103.campaignId
  L6_107 = A0_101
  L5_106 = A0_101.IsCampainFinishByBattleId
  L7_108 = A1_102
  L5_106 = L5_106(L6_107, L7_108)
  if L5_106 then
    L7_108 = A0_101
    L6_107 = A0_101.GetCampainBattles
    L6_107 = L6_107(L7_108, L8_109)
    L7_108 = {}
    for L11_112, L12_113 in L8_109(L9_110) do
      L7_108[L12_113] = true
    end
    for L12_113, L13_114 in L9_110(L10_111) do
      if not L7_108[L13_114] then
        table.insert(L8_109, L13_114)
      end
    end
    A0_101.battles = L8_109
    L9_110(L10_111, L11_112)
  else
    L6_107 = table
    L6_107 = L6_107.insert
    L7_108 = A0_101.battles
    L6_107(L7_108, L8_109)
  end
  L7_108 = A0_101
  L6_107 = A0_101.ParseCampaignData
  L6_107(L7_108)
  L6_107 = L3_104
  L7_108 = L5_106
  return L6_107, L7_108
end
function class.OnHeroLevelChange(A0_115)
  A0_115:ParseCampaignData()
  A0_115:FireEvent(EVT.REFRESH_BATTLE_COPY, true, true)
end
function class.OpenLastCamp(A0_116)
  local L1_117, L2_118, L3_119, L4_120
  L2_118 = A0_116
  L1_117 = A0_116.GetOpenningCamps
  L1_117 = L1_117(L2_118)
  if L1_117 then
    L2_118 = table
    L2_118 = L2_118.empty
    L3_119 = L1_117
    L2_118 = L2_118(L3_119)
  elseif L2_118 then
    return
  end
  L2_118 = L1_117[1]
  L3_119 = Logic
  L4_120 = L3_119
  L3_119 = L3_119.Get
  L3_119 = L3_119(L4_120, "PlayerInfo")
  L4_120 = L3_119
  L3_119 = L3_119.GetPlayerLevel
  L3_119 = L3_119(L4_120)
  L4_120 = A0_116.GetCampaignInfoById
  L4_120 = L4_120(A0_116, L2_118)
  if nil == L4_120 then
    return
  end
  while L3_119 < L4_120.level do
    if nil == Logic:Get("Battle"):GetCampaignInfoById(L2_118) then
      return
    end
    if "" == Logic:Get("Battle"):GetCampaignInfoById(L2_118).prevId then
      return
    end
    if #json.decode(Logic:Get("Battle"):GetCampaignInfoById(L2_118).prevId) == 0 then
      return
    end
    L2_118 = json.decode(Logic:Get("Battle"):GetCampaignInfoById(L2_118).prevId)[1]
    L4_120 = A0_116:GetCampaignInfoById(L2_118)
    if nil == L4_120 then
      return
    end
  end
  A0_116:FireEvent(EVT.CLICK_BATTLE_COPY_ITEM, L2_118, UI_LAYER_TYPE.CAMPAIGN)
end
function class.OnProgress(A0_121, A1_122, A2_123)
  local L3_124, L4_125
  L3_124 = A2_123.battles
  A0_121.battles = L3_124
  L3_124 = A2_123.campaigns
  A0_121.campaigns = L3_124
  L3_124 = A2_123.dailyCounts
  A0_121.dailyCounts = L3_124
  L3_124 = {}
  A0_121.current = L3_124
  L4_125 = A0_121
  L3_124 = A0_121.ParseCampaignData
  L3_124(L4_125)
  L3_124 = A2_123.current
  if nil ~= L3_124 then
    L3_124 = A0_121.current
    L4_125 = A2_123.current
    L4_125 = L4_125.battleId
    L3_124.battleId = L4_125
    L3_124 = A0_121.current
    L4_125 = A2_123.current
    L4_125 = L4_125.remains
    L3_124.remains = L4_125
    L3_124 = A0_121.current
    L4_125 = A2_123.current
    L4_125 = L4_125.totalEnemies
    L3_124.totalEnemies = L4_125
    L3_124 = A0_121.current
    L4_125 = A2_123.current
    L4_125 = L4_125.failed
    L4_125 = not L4_125
    L3_124.success = L4_125
    L3_124 = A0_121.current
    L4_125 = A2_123.current
    L4_125 = L4_125.finished
    L3_124.finished = L4_125
    L3_124 = A0_121.current
    L4_125 = A2_123.current
    L4_125 = L4_125.coins
    L3_124.coins = L4_125
    L3_124 = A0_121.current
    L4_125 = A2_123.current
    L4_125 = L4_125.equips
    L3_124.equips = L4_125
    L3_124 = A0_121.current
    L4_125 = A2_123.current
    L4_125 = L4_125.fragments
    L3_124.fragments = L4_125
    L3_124 = A0_121.current
    L4_125 = A2_123.current
    L4_125 = L4_125.heros
    L3_124.heros = L4_125
    L3_124 = Logic
    L4_125 = L3_124
    L3_124 = L3_124.Get
    L3_124 = L3_124(L4_125, "BattleShow")
    L4_125 = L3_124
    L3_124 = L3_124.CleanUp
    L3_124(L4_125)
    L3_124 = Logic
    L4_125 = L3_124
    L3_124 = L3_124.Get
    L3_124 = L3_124(L4_125, "BattleShow")
    L4_125 = L3_124.RestoreCurHeroInfo
    L4_125(L3_124)
    L4_125 = L3_124.SetEnemyCount
    L4_125(L3_124, A2_123.current.remains, A2_123.current.totalEnemies)
    L4_125 = L3_124.SetFinfish
    L4_125(L3_124, A2_123.current.finished)
    L4_125 = {
      A0_121.current.heros + A2_123.current.equips,
      A0_121.current.fragments,
      A0_121.current.coins
    }
    L3_124:SetDropItems(unpack(L4_125))
    L3_124:SetFriendInfo(A2_123.current.assistant)
    L3_124:SetEnterBattle(true)
    L3_124:SetBattleResult(A0_121.current.success)
  end
end
function class.PostProgressMsg(A0_126)
  MsgBattle:Post("PROGRESS")
end
function class.OnTrigger(A0_127, A1_128, A2_129)
  if Logic:Get("MsgAssist"):OnMsgResult("MsgBattle", A1_128, 22, 4, true) then
    log4misc:warn("MsgBattle-TRIGGER:ERROR[%d]", A1_128)
    Logic:Get("BattleShow"):Error()
    return
  end
  A0_127.current = A0_127.current or {}
  if A0_127.current.remains then
    A0_127.current.remains = math.max(A0_127.current.remains - 1, 0)
  end
  A0_127.current.success = A2_129.success
  Logic:Get("BattleShow"):SetReward(A2_129.drops)
  Logic:Get("BattleShow"):SetFinfish(A2_129.finished)
  Logic:Get("BattleShow"):Start(A2_129.reports)
end
function class.PostTriggerMsg(A0_130)
  MsgBattle:Post("TRIGGER")
end
function class.DeleteCommendFriend(A0_131)
  local L1_132
  L1_132 = A0_131.curUISelectInfo
  if L1_132 then
    L1_132 = A0_131.curUISelectInfo
    L1_132 = L1_132.friendId
  else
    L1_132 = L1_132 or nil
  end
  if nil == L1_132 then
    return
  end
  Logic:Get("Friend"):DeleteCommendFriend(L1_132)
  A0_131.curUISelectInfo.friendId = nil
end
function class.OnEnter(A0_133, A1_134, A2_135)
  if Logic:Get("MsgAssist"):OnMsgResult("MsgBattle", A1_134, 22, 2, true) then
    Logic:Get("Main"):GotoHomePage()
    return
  end
  A0_133:DeleteCommendFriend()
  A0_133.current = A0_133.current or {}
  A0_133.current.campainId = A0_133:GetBattleCampaignId(A2_135.battleId)
  A0_133.current.battleId = A2_135.battleId
  A0_133.current.remains = A2_135.remains
  A0_133.current.totalEnemies = A2_135.totalEnemies
  A0_133:PostTriggerMsg()
end
function class.PostEnterMsg(A0_136)
  local L1_137, L2_138, L3_139
  L1_137 = A0_136.curUISelectInfo
  if nil == L1_137 then
    return
  end
  L1_137 = A0_136.curUISelectInfo
  L1_137 = L1_137.battleId
  L2_138 = A0_136.curUISelectInfo
  L2_138 = L2_138.friendId
  if nil == L1_137 then
    L3_139 = log4battle
    L3_139 = L3_139.debug
    L3_139(L3_139, "PostEnterMsg data error. do not selected battle")
    return
  end
  L3_139 = {}
  L3_139.battleId = L1_137
  L3_139.friend = L2_138 or ID[-1]
  L3_139.embattle = Logic:Get("Hero"):GetCurrentEmbattle()
  A0_136:PostMultiAction(L3_139)
end
function class.OnExit(A0_140, A1_141, A2_142)
  local L3_143, L4_144
  if 0 ~= A1_141 then
    L3_143 = _UPVALUE0_
    L3_143 = L3_143.BATTLE_NOT_ENTER
    if A1_141 == L3_143 then
      L3_143 = log4battle
      L4_144 = L3_143
      L3_143 = L3_143.warn
      L3_143(L4_144, "OnExit BATTLE_NOT_ENTER")
      L3_143 = Logic
      L4_144 = L3_143
      L3_143 = L3_143.Get
      L3_143 = L3_143(L4_144, "Login")
      L4_144 = L3_143
      L3_143 = L3_143.Login
      L3_143(L4_144)
    else
      L3_143 = Logic
      L4_144 = L3_143
      L3_143 = L3_143.Get
      L3_143 = L3_143(L4_144, "MsgAssist")
      L4_144 = L3_143
      L3_143 = L3_143.OnMsgResult
      L3_143(L4_144, "MsgBattle", A1_141, 22, 5, true)
      L4_144 = A0_140
      L3_143 = A0_140.FireEvent
      L3_143(L4_144, EVT.REFRESH_BATTLE_COPY, false)
    end
  end
  if A1_141 == 0 then
    if A2_142 == nil then
      L3_143 = {}
      A2_142 = L3_143 or A2_142
    end
    L3_143 = A2_142.costAndReward
    L4_144 = A2_142.hasDemog
    A0_140.failedTimes = A2_142.failedTimes
    Logic:Get("BattleShow"):SetCostAndReward(L3_143)
    Logic:Get("Devil"):SetHasDemog(L4_144)
  end
  L4_144 = A0_140
  L3_143 = A0_140.FireEvent
  L3_143(L4_144, EVT.EXIT_BATTLE, 0 ~= A1_141)
end
function class.PostExitMsg(A0_145)
  MsgBattle:Post("EXIT")
end
function class.OnDailyCount(A0_146, A1_147, A2_148)
  A0_146.dailyCounts = A2_148
  A0_146:FireEvent(EVT.REFRESH_BATTLE_COPY, true)
end
function class.PostDailyCountMsg(A0_149)
  MsgBattle:Post("DAILYCOUNT")
end
function class.OnQuickBattle(A0_150, A1_151, A2_152)
  if Logic:Get("MsgAssist"):OnMsgResult("MsgBattle", A1_151) then
    if A1_151 == _UPVALUE0_.BLOCK_BY_DEAD or A1_151 == _UPVALUE0_.POINT_NOT_FOUND or A1_151 == _UPVALUE0_.BATTLE_NOT_FINISHED then
      log4battle:warn("OnQuickBattle code:" .. A1_151 .. " battleid:" .. (A0_150.current and A0_150.current.battleId or "nil") .. " campainId:" .. (A0_150.current and A0_150.current.campainId or "nil"))
      A0_150:PostExitMsg()
      Logic:Get("Login"):Login()
    end
    return
  end
  if not A2_152 then
    return
  end
  A0_150:DeleteCommendFriend()
  A0_150.current = A0_150.current or {}
  A0_150.current.campainId = A0_150:GetBattleCampaignId(A2_152.battleId)
  A0_150.current.battleId = A2_152.battleId
  A0_150.current.success = not A2_152.failed
  Logic:Get("Devil"):SetHasDemog(A2_152.exitVo.hasDemog)
  Logic:Get("BattleShow"):CleanUp()
  Logic:Get("BattleShow"):SetBattleResult(not A2_152.failed)
  Logic:Get("BattleShow"):SetEnterBattle(false)
  Logic:Get("BattleShow"):SetCostAndReward(A2_152.exitVo.costAndReward)
  Logic:Get("Hero"):setEmbattleArry()
  A0_150:BattleFinished()
end
function class.NextQuickRequestId(A0_153)
  A0_153.quickRequestSequence = (A0_153.quickRequestSequence or 0) + 1
  return tostring(os.time()) .. "-" .. tostring(TimeGetTime()) .. "-" .. tostring(A0_153.quickRequestSequence)
end
function class.PostQuickBattle(A0_154, A1_155, A2_156)
  A0_154.current = A0_154.current or {}
  A0_154.current.battleId = A1_155
  A0_154.current.campainId = A0_154:GetBattleCampaignId(A1_155)
  MsgBattle:Post("QUICK_BATTLE", {
    battleId = A1_155,
    friend = A2_156,
    embattle = Logic:Get("Hero"):GetTempEmbattle(),
    requestId = A0_154:NextQuickRequestId()
  })
end
function class.PostMultiAction(A0_157, A1_158)
  A0_157.current = A0_157.current or {}
  A0_157.current.battleId = A1_158.battleId
  A0_157.current.campainId = A0_157:GetBattleCampaignId(A1_158.battleId)
  MsgBattle:Post("MULTI_ACTION", A1_158)
end
function class.OnMultiAction(A0_159, A1_160, A2_161)
  if Logic:Get("MsgAssist"):OnMsgResult("MsgBattle", A1_160) then
    if A1_160 == _UPVALUE0_.BLOCK_BY_DEAD or A1_160 == _UPVALUE0_.POINT_NOT_FOUND or A1_160 == _UPVALUE0_.BATTLE_NOT_FINISHED then
      log4battle:warn("OnMultiAction code:" .. A1_160 .. " battleid:" .. (A0_159.current and A0_159.current.battleId or "nil") .. " campainId:" .. (A0_159.current and A0_159.current.campainId or "nil"))
      A0_159:PostExitMsg()
      Logic:Get("Login"):Login()
    end
    return
  end
  A0_159:DeleteCommendFriend()
  A0_159.current = A0_159.current or {}
  A0_159.current.success = A2_161.success
  Logic:Get("BattleShow"):CleanUp()
  Logic:Get("BattleShow"):DeleteReport()
  Logic:Get("BattleShow"):SaveReport(A2_161)
  Logic:Get("Hero"):setEmbattleArry()
  Logic:Get("BattleShow"):StartByStoredReport()
end
function class.PostQuickAdvance(A0_162, A1_163, A2_164)
  MsgBattle:Post("QUICK_ADVANCE", {
    battleId = A1_163,
    friend = A2_164,
    requestId = A0_162:NextQuickRequestId()
  })
end
function class.OnQuickAdvance(A0_165, A1_166, A2_167)
  if not A2_167 then
    return
  end
  A0_165.current = A0_165.current or {}
  A0_165.current.campainId = A0_165:GetBattleCampaignId(A2_167.battleId)
  A0_165.current.battleId = A2_167.battleId
  A0_165.current.success = not A2_167.failed
  A0_165:DeleteCommendFriend()
  Logic:Get("Devil"):SetHasDemog(A2_167.exitVo.hasDemog)
  Logic:Get("Hero"):ClearFiendInfo()
  Logic:Get("BattleShow"):CleanUp()
  Logic:Get("BattleShow"):SetBattleResult(not A2_167.failed)
  Logic:Get("BattleShow"):SetEnterBattle(false)
  Logic:Get("BattleShow"):SetCostAndReward(A2_167.exitVo.costAndReward)
  Logic:Get("Hero"):setEmbattleArry()
  A0_165:BattleFinished()
end
function class.OnFirstRecord(A0_168, A1_169, A2_170)
  if A1_169 ~= 0 then
    return
  end
  A0_168.firstRecord = A2_170
  A0_168:FireEvent(EVT.FIRST_RECORD)
end
function class.OnBestRecord(A0_171, A1_172, A2_173)
  if A1_172 ~= 0 or A2_173 == nil then
    return
  end
  A0_171.bestRecord = A2_173
  A0_171:FireEvent(EVT.BEST_RECORD)
end
function class.GetBattleInfoById(A0_174, A1_175)
  if nil == KFDBGetRecord("BattleInfoConfig", A1_175) then
    log4battle:warn("get BattleInfoConfig failed:" .. (A1_175 and A1_175 or "id is nil"))
  end
  return (KFDBGetRecord("BattleInfoConfig", A1_175))
end
function class.GetBattleName(A0_176, A1_177)
  if nil == A0_176:GetBattleInfoById(A1_177) then
    return ""
  end
  return A0_176:GetBattleInfoById(A1_177).name
end
function class.GetBattleCampaignId(A0_178, A1_179)
  if nil == A0_178:GetBattleInfoById(A1_179) then
    return ""
  end
  return A0_178:GetBattleInfoById(A1_179).campaignId
end
function class.GetBattleType(A0_180, A1_181)
  if nil == A0_180:GetBattleInfoById(A1_181) then
    return nil
  end
  return A0_180:GetCampaignInfoById(A0_180:GetBattleInfoById(A1_181).campaignId) and A0_180:GetCampaignInfoById(A0_180:GetBattleInfoById(A1_181).campaignId).type or nil
end
function class.GetBattleByPreId(A0_182, A1_183)
  local L2_184, L3_185, L4_186, L5_187, L6_188, L7_189, L8_190, L9_191
  if nil == A1_183 then
    L2_184 = nil
    return L2_184
  end
  L3_185 = A0_182
  L2_184 = A0_182.GetBattleInfoById
  L2_184 = L2_184(L3_185, L4_186)
  if L2_184 == nil then
    L3_185 = nil
    return L3_185
  end
  L3_185 = A0_182.IsLastBattle
  L3_185 = L3_185(L4_186, L5_187)
  if L3_185 then
    L3_185 = L2_184.campaignId
    if L4_186 then
      if L5_187 > 1 then
        L8_190 = " has too many next battle"
        L9_191 = #L4_186
        L5_187(L6_188, L7_189)
      end
    end
    for L8_190, L9_191 in L5_187(L6_188) do
      return A0_182:GetBattleInfoNonPre(L9_191)
    end
    return L5_187
  end
  L3_185 = A0_182.GetCampainBattles
  L3_185 = L3_185(L4_186, L5_187)
  for L7_189, L8_190 in L4_186(L5_187) do
    L9_191 = A0_182.GetBattleInfoById
    L9_191 = L9_191(A0_182, L8_190)
    if L9_191 and L9_191.prevId == A1_183 then
      return L9_191
    end
  end
  return L4_186
end
function class.IsLastBattle(A0_192, A1_193)
  if nil == A0_192:GetBattleInfoById(A1_193) then
    return false
  end
  return A0_192:GetBattleInfoById(A1_193).last == "true"
end
function class.GetBattleInfoNonPre(A0_194, A1_195)
  local L2_196, L3_197, L4_198, L5_199, L6_200, L7_201
  L2_196 = A0_194.GetCampainBattles
  L2_196 = L2_196(L3_197, L4_198)
  L4_198 = L2_196 or {}
  for L6_200, L7_201 in L3_197(L4_198) do
    if A0_194:GetBattleInfoById(L7_201) and A0_194:GetBattleInfoById(L7_201).prevId == "" then
      return (A0_194:GetBattleInfoById(L7_201))
    end
  end
  return L3_197
end
function class.GetCampaignInfoById(A0_202, A1_203)
  if nil == KFDBGetRecord("CampaignConfig", A1_203) then
    log4battle:warn("get CampaignConfig failed:" .. (A1_203 and A1_203 or "id is nil"))
  end
  return (KFDBGetRecord("CampaignConfig", A1_203))
end
function class.GetCampainName(A0_204, A1_205)
  if nil == A0_204:GetCampaignInfoById(A1_205) then
    return ""
  end
  return A0_204:GetCampaignInfoById(A1_205).name
end
function class.GetCampainIntroduction(A0_206, A1_207)
  if nil == A0_206:GetCampaignInfoById(A1_207) then
    return ""
  end
  return A0_206:GetCampaignInfoById(A1_207).introduction
end
function class.GetCampainBattles(A0_208, A1_209)
  local L2_210
  function L2_210()
    local L0_211, L1_212, L2_213, L3_214
    L0_211.campMapBattles = L1_212
    for L3_214 = 1, L1_212(L2_213) do
      _UPVALUE0_.campMapBattles[KFDBGetRecordByIdx("BattleInfoConfig", L3_214).campaignId] = _UPVALUE0_.campMapBattles[KFDBGetRecordByIdx("BattleInfoConfig", L3_214).campaignId] or {}
      table.insert(_UPVALUE0_.campMapBattles[KFDBGetRecordByIdx("BattleInfoConfig", L3_214).campaignId], KFDBGetRecordByIdx("BattleInfoConfig", L3_214).id)
    end
  end
  if A0_208.campMapBattles == nil then
    L2_210()
  end
  return A0_208.campMapBattles[A1_209] or {}
end
function class.IsCampainFinishByBattleId(A0_215, A1_216)
  return A0_215:IsLastBattle(A1_216) == true
end
function class.GetCampaignByPreId(A0_217, A1_218, A2_219)
  local L3_220, L4_221, L5_222, L6_223, L7_224
  L3_220 = {}
  for L7_224 = 1, L5_222(L6_223) do
    if KFDBGetRecordByIdx("CampaignConfig", L7_224).prevId == A1_218 and (nil == A2_219 or A2_219 == KFDBGetRecordByIdx("CampaignConfig", L7_224).type) then
      table.insert(L3_220, KFDBGetRecordByIdx("CampaignConfig", L7_224).id)
      break
    end
  end
  return L3_220
end
function class.setOpenActivityInBattleCopy(A0_225, A1_226)
  A0_225.IsOpenInBattleCopy = A1_226
end
function class.IsOpenActivityInBattleCopy(A0_227)
  local L1_228
  L1_228 = A0_227.IsOpenInBattleCopy
  return L1_228
end
;({}).SortCampaigns = function(A0_229, A1_230)
  local L2_231, L3_232, L4_233, L5_234, L6_235
  for L5_234, L6_235 in L2_231(L3_232) do
    table.sort(L6_235, _UPVALUE0_)
  end
end
;({}).SortBattles = function(A0_236, A1_237)
  local L2_238, L3_239, L4_240, L5_241, L6_242
  for L5_241, L6_242 in L2_238(L3_239) do
    table.sort(L6_242, _UPVALUE0_)
  end
end
