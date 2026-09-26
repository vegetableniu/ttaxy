local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("Logic")
L0_0 = require
L0_0("SceneHelper")
L0_0 = Enum
L0_0 = L0_0({
  "START",
  "STOP",
  "QUIT",
  "NEXT",
  "INEND",
  "END",
  "ERROR",
  "FIGHT_BEFORE",
  "BATTLE_END"
})
EVT = L0_0
L0_0 = require
L0_0 = L0_0("BattleShow.BattleDefine")
class = Logic.class:subclass()
function class.initialize(A0_1)
  super.initialize(A0_1)
  A0_1.curWave = 0
  A0_1.acc = _UPVALUE0_
  A0_1.hasRewardAdd = false
  A0_1:CleanUp()
  Logic:Get("Battle"):On(Logic.Battle.EVT.BATTLE_FINISHED, A0_1:Event("OnBattleFinished"))
  Logic:Get("PlayerInfo"):On(Logic.PlayerInfo.EVT.DATA_CHANGE, A0_1:Event("OnChangeAcc1", function(A0_2)
    if A0_2 then
      _UPVALUE0_:OnChangeAcc(false)
    end
  end))
  Logic:Get("PlayerInfo"):On(Logic.PlayerInfo.EVT.LEVEL_CHANGE, A0_1:Event("OnChangeAcc2", function()
    _UPVALUE0_:OnChangeAcc(true)
  end))
end
function class.GetFailRewardAndResult(A0_3)
  local L1_4, L2_5
  L1_4 = A0_3.failReward
  L2_5 = A0_3.success
  return L1_4, L2_5
end
function class.SetFailReward(A0_6, A1_7)
  A0_6.failReward = A1_7
  A0_6.costAndReward = {}
end
function class.SetReward(A0_8, A1_9, A2_10)
  A2_10 = A2_10 or 0
  A0_8.reward = A1_9
  A0_8.coins = A2_10
end
function class.GetReward(A0_11)
  local L1_12, L2_13
  L1_12 = A0_11.reward
  L2_13 = A0_11.coins
  return L1_12, L2_13
end
function class.SetCurWave(A0_14, A1_15)
  A0_14.curWave = A1_15
end
function class.SetEnemyCount(A0_16, A1_17, A2_18)
  A0_16.remains = A1_17
  A0_16.totle = A2_18 or 3
  A0_16:SetCurWave(A2_18 - A1_17)
end
function class.IsInMultiFight(A0_19)
  return A0_19:IsInArena() or A0_19:IsInDemog() or A0_19:IsInActive2() or A0_19:IsInFulled() or A0_19:IsInCultivate()
end
function class.GetTotleBattles(A0_20)
  local L1_21, L2_22, L3_23
  L1_21 = 3
  L3_23 = A0_20
  L2_22 = A0_20.IsInMultiFight
  L2_22 = L2_22(L3_23)
  if L2_22 then
    return L1_21
  end
  L3_23 = A0_20
  L2_22 = A0_20.GetBattleId
  L2_22 = L2_22(L3_23)
  L3_23 = nil
  if L2_22 then
    L3_23 = Logic:Get("Battle"):GetBattleInfoById(L2_22)
  end
  if L3_23 then
    L1_21 = tonumber(L3_23.enemies)
  end
  return L1_21
end
function class.HasNoBattle(A0_24)
  return A0_24.remains == 0
end
function class.GetDefenderArtifactLevel(A0_25)
  return A0_25.defenderArtifactLevel or -1
end
function class.SetDefenderArtifactLevel(A0_26, A1_27)
  A0_26.defenderArtifactLevel = A1_27
end
function class.SetCostAndReward(A0_28, A1_29)
  if type(A1_29) == "table" then
    A0_28.costAndReward = A1_29
  end
  A0_28:RestoreCurHeroInfo()
  Logic:Get("Cost"):CostAndReward(A1_29)
  Logic:Get("Facebook"):ShareFriend("Battle", A1_29.rewards)
end
function class.GetCostAndReward(A0_30)
  local L1_31
  L1_31 = A0_30.costAndReward
  return L1_31
end
function class.ProcessReward(A0_32)
  if A0_32.costAndReward and A0_32.hasRewardAdd == false then
    A0_32.hasRewardAdd = true
    Logic:Get("Cost"):CostAndReward(A0_32.costAndReward)
  end
end
function class.GetCurWave(A0_33)
  local L1_34
  L1_34 = A0_33.curWave
  return L1_34
end
function class.IsEnterBattle(A0_35)
  local L1_36
  L1_36 = A0_35.isEnterBattle
  return L1_36
end
function class.SetEnterBattle(A0_37, A1_38)
  A0_37.isEnterBattle = A1_38
end
function class.Error(A0_39)
  A0_39:CleanUp()
  if A0_39.scene then
    SceneHelper:popScene()
  end
  A0_39.scene = nil
  Logic:Get("BGSound"):PlayBGMusic()
  Logic:Get("Main"):GotoHomePage()
end
function class.SaveMultiFightReport(A0_40, A1_41)
  A0_40.multiFightReport = A1_41
  A0_40.multiFightWave = 0
end
function class.GetTotleMultiFightWave(A0_42)
  local L1_43
  L1_43 = A0_42.totleDemogWave
  return L1_43
end
function class.SetTotleMultiFightWaves(A0_44, A1_45)
  A0_44.totleDemogWave = A1_45
end
function class.GetMultiFightWave(A0_46)
  local L1_47
  L1_47 = A0_46.multiFightWave
  return L1_47
end
function class.GetLastFightResult(A0_48)
  local L1_49
  L1_49 = A0_48.lastResult
  return L1_49
end
function class.SetLastFightResult(A0_50, A1_51)
  A0_50.lastResult = A1_51
end
function class.SetMultiFightWaves(A0_52, A1_53, A2_54)
  local L3_55
  L3_55 = A1_53 or 1
  A0_52.atkWaves = L3_55
  L3_55 = A2_54 or 1
  A0_52.defWaves = L3_55
end
function class.GetMultiFightWaves(A0_56, A1_57, A2_58)
  local L3_59, L4_60
  L3_59 = A0_56.atkWaves
  L4_60 = A0_56.defWaves
  return L3_59, L4_60
end
function class.SetArenaPairMode(A0_61, A1_62)
  local L2_63
  if A1_62 then
    L2_63 = true
  else
    L2_63 = L2_63 or false
  end
  A0_61.arenaPairMode = L2_63
end
function class.IsArenaPairMode(A0_64)
  return A0_64.arenaPairMode == true
end
function class.StartMultiFightReport(A0_65)
  local L1_66
  L1_66 = A0_65.multiFightReport
  if L1_66 == nil then
    L1_66 = A0_65.IsInBattleShow
    L1_66 = L1_66(A0_65)
    if L1_66 then
      L1_66 = A0_65.Error
      L1_66(A0_65)
    end
    return
  end
  L1_66 = A0_65.multiFightWave
  L1_66 = L1_66 + 1
  A0_65.multiFightWave = L1_66
  L1_66 = A0_65.multiFightReport
  L1_66 = L1_66[A0_65.multiFightWave]
  if L1_66 == nil then
    if A0_65:IsInBattleShow() then
      A0_65:Error()
    end
    return
  end
  if A0_65.multiFightReport[A0_65.multiFightWave + 1] == nil then
    A0_65:SetFinfish(true)
  end
  A0_65:Start(L1_66)
end
function class.StartByStoredReport(A0_67, A1_68)
  if (A1_68 or A0_67:GetReport()) == nil then
    if A0_67:IsInBattleShow() then
      A0_67:Error()
    end
    return
  end
  A0_67.success = (A1_68 or A0_67:GetReport()).success
  A0_67:SetReward((A1_68 or A0_67:GetReport()).drops, (A1_68 or A0_67:GetReport()).coins)
  A0_67:SetFinfish((A1_68 or A0_67:GetReport()).finished)
  A0_67:Start((A1_68 or A0_67:GetReport()).reports)
end
function class.Start(A0_69, A1_70)
  if type(A1_70) ~= "string" then
    return
  end
  A0_69:SetEnterBattle(true)
  A0_69:InitAcc()
  A0_69:RestoreCurHeroInfo()
  xpcall(function()
    _UPVALUE0_.parser = _UPVALUE1_.class:new(_UPVALUE2_)
  end, function(A0_71)
    _UPVALUE0_ = true
    _UPVALUE1_:BattleFail(false)
    log4battle:warn(A0_71)
    return A0_71
  end)
  if false then
    return
  end
  if A0_69.scene then
    A0_69:FireEvent(EVT.NEXT)
  else
    A0_69.scene = true
    Logic:Get("BGSound"):PlayBattleMusic()
    SceneHelper:pushScene("BattleShow", nil, A0_69.mainScene)
    A0_69:FireEvent(EVT.START)
  end
end
function class.SetDropItems(A0_72, ...)
  A0_72.rwdItems = {
    ...
  }
end
function class.GetDropItems(A0_74)
  return A0_74.rwdItems or {}
end
function class.IsInBattleShow(A0_75)
  return A0_75.scene ~= nil
end
function class.SetMainScene(A0_76, A1_77)
  A0_76.mainScene = A1_77
end
function class.IsFinish(A0_78)
  local L1_79
  L1_79 = A0_78.bFin
  return L1_79
end
function class.SetFinfish(A0_80, A1_81)
  A0_80.bFin = A1_81
end
function class.GetParser(A0_82)
  local L1_83
  L1_83 = A0_82.parser
  return L1_83
end
function class.Stop(A0_84)
  A0_84:FireEvent(EVT.STOP)
end
function class.FightBefore(A0_85, A1_86)
  A0_85:FireEvent(EVT.FIGHT_BEFORE, A1_86)
end
function class.BattleEnd(A0_87, A1_88, A2_89)
  A0_87:FireEvent(EVT.BATTLE_END, A1_88, A2_89)
end
function class.BattleShowEnd(A0_90)
  A0_90:CleanUp()
  A0_90:GotoNextResult()
  A0_90:FireEvent(EVT.END)
end
function class.GoNextFight(A0_91)
  if A0_91:IsInMultiFight() then
    A0_91:StartMultiFightReport()
  else
    A0_91:StartByStoredReport()
  end
end
function class.BattleFail(A0_92)
  A0_92:BattlePlayEnd()
end
function class.BattlePlayEnd(A0_93, A1_94)
  if A0_93:IsInMultiFight() or A0_93:IsBattleTest() then
    A0_93:ShowBattleResult()
  else
    Logic:Get("Battle"):BattleFinished(A1_94 and A0_93.success)
  end
  A0_93:CleanUpTextureCache()
end
function class.SetBattleTest(A0_95)
  local L1_96
  A0_95.battleTest = true
end
function class.IsBattleTest(A0_97)
  local L1_98
  L1_98 = A0_97.battleTest
  return L1_98
end
function class.BattleShowInEnd(A0_99)
  A0_99:FireEvent(EVT.INEND)
end
function class.OnBattleFinished(A0_100)
  A0_100:FireEvent(EVT.QUIT)
  A0_100:ShowBattleResult()
end
function class.IsInCampaign(A0_101)
  return Logic:Get("Battle"):GetEmBattleType() == Logic.Battle.BATTLE_TYPE.CAMPAIGN
end
function class.IsInActive(A0_102)
  return Logic:Get("Battle"):GetEmBattleType() == Logic.Battle.BATTLE_TYPE.ACTIVE
end
function class.IsInArena(A0_103)
  return Logic:Get("Battle"):GetEmBattleType() == Logic.Battle.BATTLE_TYPE.ARENA
end
function class.IsInDemog(A0_104)
  return Logic:Get("Battle"):GetEmBattleType() == Logic.Battle.BATTLE_TYPE.DEMOG
end
function class.IsInActive2(A0_105)
  return Logic:Get("Battle"):GetEmBattleType() == Logic.Battle.BATTLE_TYPE.REBIRTH
end
function class.IsInFulled(A0_106)
  return Logic:Get("Battle"):GetEmBattleType() == Logic.Battle.BATTLE_TYPE.FULLED
end
function class.IsInCultivate(A0_107)
  return Logic:Get("Battle"):GetEmBattleType() == Logic.Battle.BATTLE_TYPE.PILL
end
function class.SetResultUI(A0_108, A1_109)
  A0_108.uiName = A1_109
end
function class.ShowBattleResult(A0_110)
  if A0_110.scene then
    SceneHelper:popScene()
  end
  Singleton(GameRoot):CheckMemory()
  A0_110:SetCurWave(0)
  A0_110:SetEnemyCount(0, 0)
  A0_110.scene = nil
  Logic:Get("BGSound"):PlayBGMusic()
  if A0_110:IsBattleTest() then
    return
  end
  if A0_110.uiName ~= nil then
    SceneHelper:removeScene(A0_110.uiName)
    SceneHelper:pushScene(A0_110.uiName, nil, A0_110.mainScene)
    return
  end
  if A0_110:IsInDemog() then
    SceneHelper:removeScene("DevilResult")
    SceneHelper:pushScene("DevilResult", nil, A0_110.mainScene)
  elseif A0_110:IsInArena() then
    SceneHelper:removeScene("FightResult")
    SceneHelper:pushScene("FightResult", nil, A0_110.mainScene)
  else
    SceneHelper:removeScene("BattleShowResult")
    SceneHelper:pushScene("BattleShowResult", nil, A0_110.mainScene)
  end
end
function class.CleanUp(A0_111)
  A0_111:SetCurWave(0)
  A0_111:SetEnemyCount(0, 0)
  A0_111:SetFinfish()
  A0_111:SetReward()
  A0_111.costAndReward = nil
  A0_111.scene = nil
  A0_111.hasRewardAdd = false
  A0_111.isEnterBattle = false
  A0_111.battleTest = false
  A0_111:SetFriendInfo()
  A0_111:SetTotleMultiFightWaves(0)
  A0_111:SetMultiFightWaves(0, 0)
  A0_111:SetArenaPairMode(false)
  A0_111:SaveMultiFightReport()
  A0_111:CleanUpTextureCache()
  A0_111:SetLastFightResult(false)
  A0_111.curHeroInfo = nil
  A0_111.campaignReports = nil
  A0_111.rwdItems = nil
  A0_111.remainDropItems = nil
  A0_111.defenderArtifactLevel = nil
  A0_111.uiName = nil
  Logic:Get("AniMgr"):RemoveAll()
end
function class.InitAcc(A0_112)
  A0_112.acc = Logic:Get("System"):GetUsrVariableMisc(_UPVALUE0_) or _UPVALUE1_
  if not Logic:Get("PlayerInfo"):IsOpenFunc() and Logic:Get("System"):GetUsrVariableMisc(_UPVALUE0_) == _UPVALUE2_ then
    A0_112.acc = not Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.SPEED_UP) and _UPVALUE3_ or _UPVALUE1_
  end
end
function class.RestoreAcc(A0_113)
  Logic:Get("System"):SetUsrVariableMisc(_UPVALUE0_, A0_113.acc)
end
function class.AddAcc(A0_114)
  if A0_114.acc == (Logic:Get("PlayerInfo"):IsOpenFunc() and _UPVALUE0_ or _UPVALUE1_) then
    A0_114.acc = _UPVALUE2_
  elseif A0_114.acc == _UPVALUE2_ then
    A0_114.acc = _UPVALUE1_
  else
    A0_114.acc = Logic:Get("PlayerInfo"):IsOpenFunc() and _UPVALUE0_ or _UPVALUE1_
  end
  A0_114:RestoreAcc()
end
function class.GetAcc(A0_115)
  local L1_116
  L1_116 = A0_115.acc
  return L1_116
end
function class.OnChangeAcc(A0_117, A1_118)
  local L2_119, L3_120, L4_121
  L2_119 = Logic
  L3_120 = L2_119
  L2_119 = L2_119.Get
  L4_121 = "Lock"
  L2_119 = L2_119(L3_120, L4_121)
  L3_120 = L2_119
  L2_119 = L2_119.GetOpenLevelAndBattle
  L4_121 = Logic
  L4_121 = L4_121.Lock
  L4_121 = L4_121.LOCK_ID
  L4_121 = L4_121.SPEED_UP
  L2_119 = L2_119(L3_120, L4_121)
  L3_120 = Logic
  L4_121 = L3_120
  L3_120 = L3_120.Get
  L3_120 = L3_120(L4_121, "PlayerInfo")
  L4_121 = L3_120
  L3_120 = L3_120.GetPlayerLevel
  L3_120 = L3_120(L4_121)
  L4_121 = Logic:Get("PlayerInfo")
  L4_121 = L4_121.IsOpenFunc
  L4_121 = L4_121(L4_121)
  if not Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.SPEED_UP) and (A1_118 and L2_119 == L3_120 or not A1_118 and L2_119 <= L3_120 and L4_121) then
    if not Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.SPEED_UP) then
    else
    end
    A0_117.acc = L4_121 and _UPVALUE0_ or _UPVALUE1_ or _UPVALUE2_
    A0_117:RestoreAcc()
  end
end
function class.GetInitAcc(A0_122)
  local L1_123
  L1_123 = _UPVALUE0_
  return L1_123
end
function class.SetFriendInfo(A0_124, A1_125)
  A0_124.friendInfo = A1_125
end
function class.GetFriendInfo(A0_126)
  return A0_126.friendInfo or Logic:Get("Hero"):GetHelperInfo()
end
function class.GetBattleId(A0_127)
  return Logic:Get("Battle"):GetCurSelBattleId() or Logic:Get("Battle"):GetBattleId()
end
function class.GetReportFileName(A0_128)
  local L1_129
  L1_129 = "battleReport"
  if Logic:Get("Login"):GetLoginInfo() or not L1_129 then
    L1_129 = Logic:Get("Login"):GetLoginInfo().account .. L1_129
  end
  L1_129 = CMd5(L1_129):GetResult()
  L1_129 = L1_129 .. ".dat"
  return L1_129
end
function class.SaveReportToFile(A0_130, A1_131)
  local L2_132, L3_133
  L2_132 = CVariableSystem
  L3_133 = L2_132
  L2_132 = L2_132.GetSingleton
  L2_132 = L2_132(L3_133)
  L3_133 = L2_132
  L2_132 = L2_132.GetSysVariable
  L2_132 = L2_132(L3_133, GV_DOCPATH)
  L3_133 = L2_132
  L2_132 = L3_133 .. "BattleLog"
  L3_133 = CTwDirUtils:MkDir(L2_132)
  L3_133 = L2_132
  L3_133 = L3_133 .. "/" .. A0_130:GetReportFileName()
  if nil == A1_131 or "" == A1_131 then
    os.remove(L3_133)
    return
  end
  if io.open(L3_133, "wb+") == nil then
    return
  end
  if not io.open(L3_133, "wb+"):write(A1_131) or not io.open(L3_133, "wb+"):close() then
    os.remove(L3_133)
  end
end
function class.ReadReportFromFile(A0_134)
  local L1_135, L2_136, L3_137, L4_138
  L1_135 = CVariableSystem
  L2_136 = L1_135
  L1_135 = L1_135.GetSingleton
  L1_135 = L1_135(L2_136)
  L2_136 = L1_135
  L1_135 = L1_135.GetSysVariable
  L3_137 = GV_DOCPATH
  L1_135 = L1_135(L2_136, L3_137)
  L2_136 = L1_135
  L3_137 = "BattleLog"
  L1_135 = L2_136 .. L3_137
  L2_136 = io
  L2_136 = L2_136.open
  L3_137 = L1_135
  L4_138 = "/"
  L3_137 = L3_137 .. L4_138 .. A0_134:GetReportFileName()
  L4_138 = "rb"
  L2_136 = L2_136(L3_137, L4_138)
  L3_137 = A0_134.campaignReports
  if L2_136 == nil then
    return L3_137
  end
  L4_138 = L2_136.read
  L4_138 = L4_138(L2_136, "*a")
  L2_136:close()
  if L4_138 ~= nil and L4_138 ~= "" then
    L3_137 = json.decode(L4_138)
  end
  return L3_137
end
function class.SaveReport(A0_139, A1_140)
  local L2_141
  if A1_140 == nil then
    return
  end
  A0_139.campaignReports = A1_140
  L2_141 = json
  L2_141 = L2_141.encode
  L2_141 = L2_141(A1_140)
  A0_139:SaveReportToFile(L2_141)
end
function class.DeleteReport(A0_142)
  A0_142:SaveReportToFile("")
end
function class.GetReport(A0_143)
  return nil
end
function class.SetRemainDropItems(A0_148, A1_149)
  local L2_150, L3_151, L4_152, L5_153, L6_154, L7_155
  L2_150 = {}
  L3_151 = 0
  for L7_155 = 1, #A1_149 do
    if nil ~= A1_149[L7_155] and json.null ~= A1_149[L7_155] then
      table.insert(L2_150, A1_149[L7_155].drops)
      L3_151 = L3_151 + tonumber(A1_149[L7_155].coins)
    end
  end
  L4_152.rewards = L2_150
  L4_152.coins = L3_151
  A0_148.remainDropItems = L4_152
end
function class.GetRemainDropItems(A0_156)
  return A0_156.remainDropItems or {}
end
function class.IsNeedLevelUpTip(A0_157)
  local L1_158
  L1_158 = A0_157.isNeedLevelUpTip
  return L1_158
end
function class.SetNeedLevelUpTip(A0_159, A1_160)
  A0_159.isNeedLevelUpTip = A1_160
end
function class.GotoNextResult(A0_161)
  if _G.__LocalServer and _G.__LocalServer.enabled then
    return
  end
  if A0_161:IsNeedLevelUpTip() then
    A0_161:SetNeedLevelUpTip()
    if A0_161:IsInHardCampaignMode() and A0_161:IsUpGradeSkillUnlock() then
      SceneHelper:runWithScene("HeroUpSkill", A0_161.rootNode)
    else
      SceneHelper:runWithScene("HeroUpgrade", A0_161.rootNode)
    end
  end
end
function class.SetBattleResult(A0_162, A1_163)
  A0_162.success = A1_163
end
function class.IsBattleWin(A0_164)
  local L1_165
  L1_165 = A0_164.success
  return L1_165
end
function class.IsUpGradeSkillUnlock(A0_166)
  return not Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.SKILL)
end
function class.IsInHardCampaignMode(A0_167)
  local L1_168
  L1_168 = A0_167.IsInCampaign
  L1_168 = L1_168(A0_167)
  if not L1_168 then
    L1_168 = false
    return L1_168
  end
  L1_168 = Logic:Get("Battle")
  L1_168 = L1_168.GetBattleId
  L1_168 = L1_168(L1_168)
  return Logic:Get("Battle"):GetEmBattleType() == Logic.Battle.BATTLE_TYPE.CAMPAIGN and Logic:Get("Battle"):GetBattleType(L1_168) == Logic.Battle.CAMPAIGN_TYPE.HARD
end
function class.SetSpecialDropItems(A0_169, A1_170)
  A0_169.specialDrops = A1_170
end
function class.GetSpecialDropItems(A0_171)
  local L1_172
  L1_172 = A0_171.specialDrops
  return L1_172
end
function class.GetTextureCache(A0_173, A1_174)
  local L2_175, L3_176
  L2_175 = A0_173.textureInfo
  if L2_175 ~= nil then
    L2_175 = A0_173.textureInfo
    L2_175 = L2_175[A1_174]
  elseif L2_175 == nil then
    return
  end
  L2_175 = A0_173.textureInfo
  L2_175 = L2_175[A1_174]
  L2_175 = L2_175.texture
  L3_176 = A0_173.textureInfo
  L3_176 = L3_176[A1_174]
  L3_176 = L3_176.textureRect
  return L2_175, L3_176
end
function class.RestoreTextureCache(A0_177, A1_178, A2_179)
  A0_177.textureInfo = A0_177.textureInfo or {}
  if A0_177.textureInfo[A1_178] == nil then
    A2_179.texture:retain()
    A0_177.textureInfo[A1_178] = A2_179
  end
end
function class.CleanUpTextureCache(A0_180)
  if A0_180.textureInfo == nil then
    return
  end
  for _FORV_4_, _FORV_5_ in pairs(A0_180.textureInfo) do
    _FORV_5_.texture:release()
  end
  A0_180.textureInfo = nil
end
function class.GetHeroRankColor3(A0_181, A1_182)
  local L2_183, L3_184
  L2_183 = require
  L3_184 = "BattleShow.BattleDefine"
  L2_183 = L2_183(L3_184)
  L3_184 = L2_183.RANK_COLOR
  L3_184 = L3_184[A1_182]
  L3_184 = L3_184 or L2_183.RANK_COLOR[1]
  return ccc3(unpack(L3_184))
end
function class.RestoreCurHeroInfo(A0_185)
  A0_185.curHeroInfo = {
    level = Logic:Get("PlayerInfo"):GetPlayerLevel(),
    playerInfo = tree.clone(Logic:Get("PlayerInfo"):GetPlayerAllInfo()),
    curFriMax = Logic:Get("Friend"):GetFriendMax(),
    curPhyPoint = tree.clone(Logic:Get("PlayerInfo"):GetPlayerPhysical()),
    curLeadership = Logic:Get("Hero"):GetLeadership(),
    curHero = Logic:Get("Hero"):GetTotalExtendLimit()
  }
end
function class.GetCurHeroInfo(A0_186)
  return A0_186.curHeroInfo or {}
end
function class.SaveReportToFileDebug(A0_187, A1_188)
  local L2_189, L3_190
  if A1_188 == nil then
    return
  end
  L2_189 = json
  L2_189 = L2_189.encode
  L3_190 = A1_188
  L2_189 = L2_189(L3_190)
  A1_188 = L2_189
  L2_189 = CVariableSystem
  L3_190 = L2_189
  L2_189 = L2_189.GetSingleton
  L2_189 = L2_189(L3_190)
  L3_190 = L2_189
  L2_189 = L2_189.GetSysVariable
  L2_189 = L2_189(L3_190, GV_DOCPATH)
  L3_190 = L2_189
  L2_189 = L3_190 .. "BattleLog"
  L3_190 = CTwDirUtils:MkDir(L2_189)
  L3_190 = io
  L3_190 = L3_190.open
  L3_190 = L3_190(L2_189 .. "/" .. "battleShowDebug", "wb+")
  if L3_190 == nil then
    return
  end
  L3_190:write(A1_188)
  L3_190:close()
end
function class.GetReportFromFileDebug(A0_191)
  local L1_192, L2_193, L3_194
  L1_192 = CVariableSystem
  L2_193 = L1_192
  L1_192 = L1_192.GetSingleton
  L1_192 = L1_192(L2_193)
  L2_193 = L1_192
  L1_192 = L1_192.GetSysVariable
  L3_194 = GV_DOCPATH
  L1_192 = L1_192(L2_193, L3_194)
  L2_193 = L1_192
  L3_194 = "BattleLog"
  L1_192 = L2_193 .. L3_194
  L2_193 = CTwDirUtils
  L3_194 = L2_193
  L2_193 = L2_193.MkDir
  L2_193(L3_194, L1_192)
  L2_193 = io
  L2_193 = L2_193.open
  L3_194 = L1_192
  L3_194 = L3_194 .. "/" .. "battleShowDebug"
  L2_193 = L2_193(L3_194, "rb")
  if L2_193 == nil then
    return
  end
  L3_194 = L2_193.read
  L3_194 = L3_194(L2_193, "*a")
  L2_193:close()
  L3_194 = json.decode(L3_194)
  return L3_194
end
