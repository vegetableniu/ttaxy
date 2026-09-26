local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = require
L0_0("Reward")
L0_0 = require
L0_0("LabelAtlas")
L0_0 = require
L0_0 = L0_0("BattleShow.ReportParser")
prototype = Tw.Controller.prototype:extend()
function prototype.initialize(A0_1)
  super.initialize(A0_1)
  A0_1.curWave = 0
  A0_1.dropTable = {}
  A0_1.unitsPos = {}
  Logic:Get("BattleShow"):On(Logic.BattleShow.EVT.NEXT, A0_1:Event("Start"))
  Logic:Get("BattleShow"):On(Logic.BattleShow.EVT.QUIT, A0_1:Event("QuitBattle"))
  Logic:Get("Hero"):On(Logic.Hero.EVT.EMBATTLE_SET, A0_1:Event("SetEmbattle"))
end
function prototype.onNodeLoaded(A0_2, A1_3, A2_4)
  local L3_5, L4_6, L5_7
  L3_5 = Logic
  L4_6 = L3_5
  L3_5 = L3_5.Get
  L5_7 = "BattleShow"
  L3_5 = L3_5(L4_6, L5_7)
  L5_7 = L3_5
  L4_6 = L3_5.GetTotleBattles
  L4_6 = L4_6(L5_7)
  A0_2.totleWaves = L4_6
  L5_7 = A0_2
  L4_6 = A0_2.SetBackGround
  L4_6(L5_7, A0_2.totleWaves)
  L4_6 = bind
  L5_7 = L3_5.Stop
  L4_6 = L4_6(L5_7, L3_5)
  A0_2.listener = L4_6
  L5_7 = L3_5
  L4_6 = L3_5.GetDropItems
  L4_6 = L4_6(L5_7)
  L5_7 = L3_5.GetRemainDropItems
  L5_7 = L5_7(L3_5)
  _UPVALUE0_:Init(A0_2, L4_6, L5_7)
  _UPVALUE0_:Display()
  A0_2.bIsInActive2 = Logic:Get("BattleShow"):IsInActive2()
  A0_2.mFragmentSet:setVisible(not A0_2.bIsInActive2)
  A0_2.mSoulSet:setVisible(A0_2.bIsInActive2)
  A0_2.bIsInDemog = Logic:Get("BattleShow"):IsInDemog()
  A0_2.bIsInArena = Logic:Get("BattleShow"):IsInArena() or A0_2.bIsInActive2
  A0_2.bIsInMultiFight = Logic:Get("BattleShow"):IsInMultiFight()
  A0_2.bIsArenaPairMode = L3_5:IsArenaPairMode()
  A0_2.mDeferArtifact:setVisible(A0_2.bIsInArena and not Logic:Get("Lock"):checkStatusById("BEEEFFGEE") and Logic:Get("BattleShow"):GetDefenderArtifactLevel() >= 0)
  A0_2.mAtkerArtifact:setVisible(not Logic:Get("Lock"):checkStatusById("BEEEFFGEE"))
  A0_2:SaveUnitsPos()
  A0_2:SetBtlInfoText(1, _UPVALUE1_.TOL_ROUDNS)
  A0_2:GetEffectINIData()
  A0_2:BattleAcc()
  A0_2:Start()
end
function prototype.SaveUnitsPos(A0_8)
  local L1_9, L2_10, L3_11, L4_12
  for L4_12 = 1, _UPVALUE0_ do
    A0_8.unitsPos[A0_8[_UPVALUE1_.MakeID(L4_12)]] = ccp(A0_8[_UPVALUE1_.MakeID(L4_12)]:getPosition())
  end
end
function prototype.RestoreDefendersPos(A0_13)
  local L1_14, L2_15, L3_16, L4_17, L5_18
  for L4_17, L5_18 in L1_14(L2_15) do
    if L4_17:IsEnemy() then
      L4_17:setPosition(L5_18)
    end
  end
end
function prototype.RestoreAttackersPos(A0_19)
  local L1_20, L2_21, L3_22, L4_23, L5_24
  for L4_23, L5_24 in L1_20(L2_21) do
    if not L4_23:IsEnemy() then
      L4_23:setPosition(L5_24)
    end
  end
end
function prototype.onExit(A0_25)
  A0_25:ResetAcc()
  A0_25:CleanUpBuff()
end
function prototype.SetBackGround(A0_26, A1_27)
  local L2_28, L3_29, L4_30, L5_31, L6_32, L7_33, L8_34, L9_35, L10_36, L11_37, L12_38, L13_39, L14_40, L15_41
  L2_28 = math
  L2_28 = L2_28.ceil
  L3_29 = A1_27 / 3
  L2_28 = L2_28(L3_29)
  L2_28 = L2_28 * 2
  L3_29 = _UPVALUE0_
  L3_29 = L3_29.DEFAULT_BG
  L4_30 = _UPVALUE0_
  L4_30 = L4_30.DEFAULT_BOSS_BG
  L5_31 = _UPVALUE0_
  L5_31 = L5_31.DEFAULT_INIT_BG
  L6_32 = Logic
  L7_33 = L6_32
  L6_32 = L6_32.Get
  L8_34 = "BattleShow"
  L6_32 = L6_32(L7_33, L8_34)
  L7_33 = L6_32
  L6_32 = L6_32.GetBattleId
  L6_32 = L6_32(L7_33)
  L7_33 = nil
  if L6_32 then
    L8_34 = Logic
    L9_35 = L8_34
    L8_34 = L8_34.Get
    L10_36 = "Battle"
    L8_34 = L8_34(L9_35, L10_36)
    L9_35 = L8_34
    L8_34 = L8_34.GetBattleInfoById
    L10_36 = L6_32
    L8_34 = L8_34(L9_35, L10_36)
    L7_33 = L8_34
  end
  if L7_33 then
    L8_34 = L7_33.mapBg
    L3_29 = L8_34 or L3_29
    L8_34 = L7_33.mapBoss
    L4_30 = L8_34 or L4_30
    L8_34 = L7_33.mapInit
    L5_31 = L8_34 or L5_31
  end
  L8_34 = CCDirector
  L9_35 = L8_34
  L8_34 = L8_34.sharedDirector
  L8_34 = L8_34(L9_35)
  L9_35 = L8_34
  L8_34 = L8_34.getWinSize
  L8_34 = L8_34(L9_35)
  L9_35 = L8_34.height
  L10_36 = _UPVALUE1_
  L9_35 = L9_35 - L10_36
  L8_34.height = L9_35
  L9_35 = CCLayer
  L10_36 = L9_35
  L9_35 = L9_35.create
  L9_35 = L9_35(L10_36)
  L10_36 = A0_26.rootNode
  L10_36 = L10_36.addChild
  L14_40 = _UPVALUE2_
  L10_36(L11_37, L12_38, L13_39, L14_40)
  L10_36 = CCSprite
  L10_36 = L10_36.create
  L10_36 = L10_36(L11_37, L12_38)
  L11_37(L12_38, L13_39)
  L14_40 = 0
  L15_41 = 0
  L15_41 = L13_39(L14_40, L15_41)
  L11_37(L12_38, L13_39, L14_40, L15_41, L13_39(L14_40, L15_41))
  L14_40 = 0
  L15_41 = 0
  L15_41 = L13_39(L14_40, L15_41)
  L11_37(L12_38, L13_39, L14_40, L15_41, L13_39(L14_40, L15_41))
  for L14_40 = 1, L2_28 do
    L15_41 = CCSprite
    L15_41 = L15_41.create
    L15_41 = L15_41(L15_41, L3_29)
    L15_41:setContentSize(L8_34)
    L15_41:setAnchorPoint(ccp(0, 0))
    L9_35:addChild(L15_41)
    L15_41:setPosition(ccp(0, L10_36:getContentSize().height - _UPVALUE1_ + L8_34.height * (L14_40 - 1)))
  end
  L14_40 = L11_37
  L12_38(L13_39, L14_40)
  L14_40 = L11_37
  L15_41 = ccp
  L15_41 = L15_41(0, 0)
  L13_39(L14_40, L15_41, L15_41(0, 0))
  L14_40 = L11_37
  L15_41 = ccp
  L15_41 = L15_41(0, L8_34.height * L2_28 + L10_36:getContentSize().height - _UPVALUE1_)
  L13_39(L14_40, L15_41, L15_41(0, L8_34.height * L2_28 + L10_36:getContentSize().height - _UPVALUE1_))
  L14_40 = L8_34.height
  L14_40 = L14_40 * L2_28
  L15_41 = L10_36.getContentSize
  L15_41 = L15_41(L10_36)
  L15_41 = L15_41.height
  L14_40 = L14_40 + L15_41
  L15_41 = _UPVALUE1_
  L14_40 = L14_40 - L15_41
  L15_41 = L11_37.getContentSize
  L15_41 = L15_41(L11_37)
  L15_41 = L15_41.height
  L14_40 = L14_40 + L15_41
  L13_39.height = L14_40
  L14_40 = L8_34.width
  L13_39.width = L14_40
  L15_41 = L9_35
  L14_40 = L9_35.setContentSize
  L14_40(L15_41, L13_39)
  L14_40 = L13_39.height
  L15_41 = L8_34.height
  L14_40 = L14_40 - L15_41
  L15_41 = math
  L15_41 = L15_41.ceil
  L15_41 = L15_41(A1_27 / 3)
  L14_40 = L14_40 / L15_41
  L14_40 = L14_40 / 3
  A0_26.moveDistance = L14_40
end
function prototype.SetBtlInfoText(A0_42, A1_43, A2_44)
  local L3_45, L4_46
  L3_45 = _UPVALUE0_
  L3_45 = L3_45.TOL_ROUDNS
  L3_45 = A2_44 == L3_45 or not L3_45
  L4_46 = A0_42.mLbBattleInfo
  L4_46 = L4_46.setVisible
  L4_46(L4_46, L3_45)
  L4_46 = _UPVALUE0_
  L4_46 = L4_46.TOL_ROUDNS
  if A2_44 == L4_46 then
    L4_46 = 107002
  else
    L4_46 = L4_46 or 107001
  end
  L4_46 = TwGetStr(L4_46, A1_43, A2_44)
  A0_42.mLbBattleInfo:setString(L4_46)
  A0_42.mLbBattleInfo:setStyle(kCCLabelTTFStyleOutline)
end
function prototype.Init(A0_47)
  local L1_48, L2_49, L3_50, L4_51
  L1_48 = Logic
  L2_49 = L1_48
  L1_48 = L1_48.Get
  L3_50 = "BattleShow"
  L1_48 = L1_48(L2_49, L3_50)
  L3_50 = L1_48
  L2_49 = L1_48.GetParser
  L2_49 = L2_49(L3_50)
  A0_47.parser = L2_49
  L2_49 = A0_47.parser
  L3_50 = L2_49
  L2_49 = L2_49.GetResult
  L2_49 = L2_49(L3_50)
  A0_47.bResult = L2_49
  L3_50 = L1_48
  L2_49 = L1_48.GetCurWave
  L2_49 = L2_49(L3_50)
  A0_47.curWave = L2_49
  L2_49 = A0_47.mBtnMoveForward
  L3_50 = L2_49
  L2_49 = L2_49.setVisible
  L4_51 = false
  L2_49(L3_50, L4_51)
  L2_49 = Logic
  L3_50 = L2_49
  L2_49 = L2_49.Get
  L4_51 = "BattleShow"
  L2_49 = L2_49(L3_50, L4_51)
  L3_50 = L2_49
  L2_49 = L2_49.GetReward
  L3_50 = L2_49(L3_50)
  function L4_51(A0_52, A1_53)
    return _UPVALUE0_.MakeID((A0_52 - 1) * 3 + A1_53 + 6)
  end
  A0_47.dropTable = _UPVALUE1_:GetUnitsAnimat(L2_49, L3_50, L4_51)
  if A0_47.bIsInMultiFight and not L1_48:IsFinish() then
    A0_47.dropTable = {}
  end
  A0_47:SetNormalBackGroundPos()
  Logic:Get("RoleView"):ClearAll()
end
function prototype.SetNormalBackGroundPos(A0_54)
  local L1_55
  function L1_55()
    _UPVALUE0_:SetBackGroundPos()
    _UPVALUE0_:AddCurrentWave()
  end
  if not A0_54.bIsInMultiFight then
    L1_55()
    return
  end
  if not A0_54.runOneTime then
    L1_55()
  end
end
function prototype.NormalInitAction(A0_56)
  local L1_57
  function L1_57()
    _UPVALUE0_:CleanUpBuff()
    _UPVALUE0_:ShowDefenders(false)
    _UPVALUE0_:ShowAttackersHpProgress(false)
    _UPVALUE0_:ShowReliefView(true)
    _UPVALUE0_:MoveActionPlus()
    _UPVALUE0_:ShowAttackersHpProgress(true)
    _UPVALUE0_:SetBtlInfoText(1, _UPVALUE1_.TOL_ROUDNS)
    _UPVALUE0_:ShowRoundTips()
    _UPVALUE0_:ShowDefenders(true)
  end
  if not A0_56.bIsInMultiFight then
    L1_57()
    return
  end
  if not A0_56.runOneTime then
    L1_57()
  else
    A0_56:ShowReliefView(false)
    A0_56:MoveUnitsInside()
    A0_56:SetBtlInfoText(1, _UPVALUE0_.TOL_ROUDNS)
  end
  A0_56.runOneTime = true
end
function prototype.SetBackGroundPos(A0_58)
  local L1_59, L2_60, L3_61, L4_62, L5_63, L6_64, L7_65, L8_66, L9_67
  L1_59 = Logic
  L2_60 = L1_59
  L1_59 = L1_59.Get
  L3_61 = "BattleShow"
  L1_59 = L1_59(L2_60, L3_61)
  L2_60 = L1_59
  L1_59 = L1_59.IsInActive2
  L1_59 = L1_59(L2_60)
  A0_58.bIsInActive2 = L1_59
  L1_59 = A0_58.bIsInActive2
  if L1_59 then
    A0_58.totleWaves = 3
    A0_58.curWave = 2
  end
  L1_59 = math
  L1_59 = L1_59.ceil
  L2_60 = A0_58.totleWaves
  L2_60 = L2_60 / 3
  L1_59 = L1_59(L2_60)
  L1_59 = L1_59 * 3
  L2_60 = A0_58.moveDistance
  L3_61 = A0_58.totleWaves
  L3_61 = L1_59 - L3_61
  L4_62 = A0_58.curWave
  L3_61 = L3_61 + L4_62
  L3_61 = L2_60 * L3_61
  L4_62 = A0_58.rootNode
  L5_63 = L4_62
  L4_62 = L4_62.getChildByTag
  L6_64 = _UPVALUE0_
  L4_62 = L4_62(L5_63, L6_64)
  L6_64 = L4_62
  L5_63 = L4_62.getPosition
  L6_64 = L5_63(L6_64)
  L8_66 = L4_62
  L7_65 = L4_62.setPosition
  L9_67 = L5_63
  L7_65(L8_66, L9_67, -L3_61)
end
function prototype.ShowReliefView(A0_68, A1_69)
  local L2_70, L3_71, L4_72, L5_73, L6_74, L7_75, L8_76, L9_77, L10_78, L11_79, L12_80
  L2_70 = A0_68.bIsInMultiFight
  if not L2_70 then
    return
  end
  L2_70 = Logic
  L3_71 = L2_70
  L2_70 = L2_70.Get
  L4_72 = "AniMgr"
  L2_70 = L2_70(L3_71, L4_72)
  L3_71 = Logic
  L4_72 = L3_71
  L3_71 = L3_71.Get
  L3_71 = L3_71(L4_72, L5_73)
  L4_72 = L3_71
  L3_71 = L3_71.GetMultiFightWaves
  L4_72 = L3_71(L4_72)
  if L5_73 then
    L5_73(L6_74, L7_75)
    L5_73(L6_74, L7_75)
    if A1_69 then
      L3_71 = L5_73
      L4_72 = L5_73
      for L8_76 = 1, 3 do
        L11_79 = L8_76 <= L3_71
        L9_77(L10_78, L11_79)
        L11_79 = L8_76 <= L4_72
        L9_77(L10_78, L11_79)
      end
    else
      if L3_71 and L3_71 > 0 then
        L8_76 = L2_70
        L12_80 = 0.5
        L12_80 = L10_78(L11_79, L12_80, 0)
        ;({
          [4] = L10_78(L11_79, L12_80, 0)
        })[1] = L10_78
        ;({
          [4] = L10_78(L11_79, L12_80, 0)
        })[2] = L11_79
        ;({
          [4] = L10_78(L11_79, L12_80, 0)
        })[3] = L12_80
        L12_80 = L7_75(L8_76, L9_77)
        L5_73(L6_74, L7_75, L8_76, L9_77, L10_78, L11_79, L12_80, L7_75(L8_76, L9_77))
        L3_71 = L3_71 - 1
      end
      if L4_72 and L4_72 > 0 then
        L8_76 = L2_70
        L12_80 = 0.5
        L12_80 = L10_78(L11_79, L12_80, 0)
        ;({
          [4] = L10_78(L11_79, L12_80, 0)
        })[1] = L10_78
        ;({
          [4] = L10_78(L11_79, L12_80, 0)
        })[2] = L11_79
        ;({
          [4] = L10_78(L11_79, L12_80, 0)
        })[3] = L12_80
        L12_80 = L7_75(L8_76, L9_77)
        L5_73(L6_74, L7_75, L8_76, L9_77, L10_78, L11_79, L12_80, L7_75(L8_76, L9_77))
        L4_72 = L4_72 - 1
      end
    end
    L8_76 = L4_72
    L5_73(L6_74, L7_75, L8_76)
    return
  end
  if L5_73 then
  else
  end
  L8_76 = "Relief"
  if L5_73 then
    L8_76 = L4_72 - 1
  else
    L8_76 = L8_76 or L3_71
  end
  if not L8_76 or L8_76 <= 0 then
    return
  end
  L9_77(L10_78, L11_79)
  L9_77(L10_78, L11_79)
  for L12_80 = 1, L3_71 do
    A0_68["AtkRelief" .. L12_80]:setVisible(true)
  end
  for L12_80 = 1, L4_72 - 1 do
    A0_68["DefRelief" .. L12_80]:setVisible(true)
  end
  L12_80 = L10_78
  L11_79(L12_80, CCScaleTo:create(0.5, 0))
  L12_80 = L9_77
  L11_79(L12_80, L2_70:CreateSequence(L10_78))
  if not L5_73 or not L3_71 then
    L3_71 = L3_71 - 1
  end
  if L5_73 then
    L4_72 = L11_79 or L4_72
  end
  L12_80 = L11_79
  L12_80 = L11_79
  L11_79(L12_80, L3_71, L4_72)
end
function prototype.Start(A0_81)
  A0_81:Init()
  A0_81:Embattle()
  A0_81:InitDisplayCombs()
  A0_81:TextureCachePreLoad()
  Singleton(Timer):After(0, A0_81:Event("BATTLE_WAIT", function()
    RunInCoroutine(function()
      _UPVALUE0_:StartMovieBeforeFight()
      _UPVALUE0_:NormalInitAction()
      _UPVALUE0_:StartDisplayCombs()
      _UPVALUE0_:DelayTime(0.5)
      _UPVALUE0_:InitUnitHeightLight()
      _UPVALUE0_:PlayRounds()
      _UPVALUE0_:PlayEnd()
      _UPVALUE0_.listener()
    end)
  end))
end
function prototype.CleanUpUnits(A0_82)
  for _FORV_4_, _FORV_5_ in ipairs(A0_82.attackers or {}) do
    _FORV_5_:Cleanup()
  end
  for _FORV_4_, _FORV_5_ in ipairs(A0_82.defenders or {}) do
    _FORV_5_:Cleanup()
  end
end
function prototype.CleanUpBuff(A0_83)
  for _FORV_4_, _FORV_5_ in ipairs(A0_83.attackers or {}) do
    _FORV_5_:CleanupBuff(true)
  end
  for _FORV_4_, _FORV_5_ in ipairs(A0_83.defenders or {}) do
    _FORV_5_:CleanupBuff(true)
  end
end
function prototype.StartMovieBeforeFight(A0_84)
  if A0_84.curWave == 1 then
    Logic:Get("BattleShow"):FightBefore(Utils.Synchroniser:new():Join())
    Utils.Synchroniser:new():Sync()
    A0_84:ShowReinforcementsTip()
  end
end
function prototype.StartMovieBattleEnd(A0_85)
  Logic:Get("BattleShow"):BattleEnd(A0_85.bResult, Utils.Synchroniser:new():Join())
  Utils.Synchroniser:new():Sync()
end
function prototype.Embattle(A0_86)
  local L1_87, L2_88, L3_89, L4_90, L5_91, L6_92
  function L1_87(A0_93)
    local L1_94
    L1_94 = true
    if _UPVALUE0_.bIsInMultiFight then
      L1_94 = _UPVALUE0_.runOneTime or not A0_93:IsEnemy()
    else
      L1_94 = not A0_93:IsEnemy()
    end
    return L1_94
  end
  function L2_88(A0_95, A1_96)
    local L2_97, L3_98, L4_99, L5_100, L6_101, L7_102, L8_103, L9_104
    L2_97 = {}
    for L6_101 = A0_95, A1_96 do
      L7_102 = _UPVALUE0_
      L7_102 = L7_102.parser
      L8_103 = L7_102
      L7_102 = L7_102.GetUnitInfo
      L9_104 = L6_101 - 1
      L7_102 = L7_102(L8_103, L9_104)
      L8_103 = _UPVALUE1_
      L8_103 = L8_103.MakeID
      L9_104 = L6_101
      L8_103 = L8_103(L9_104)
      L9_104 = _UPVALUE0_
      L9_104 = L9_104[L8_103]
      L9_104:SetPosId(L8_103)
      L9_104:SetUnitInfo(L7_102, _UPVALUE2_(L9_104))
      if L7_102 then
        Logic:Get("RoleView"):Add(L8_103, L9_104)
      end
      L9_104:SetDropAnimat(_UPVALUE0_.dropTable[L8_103])
      table.insert(L2_97, L9_104)
    end
    return L2_97
  end
  A0_86.attackers = L3_89
  A0_86.defenders = L3_89
  if not L3_89 then
    if L3_89 then
      if L3_89 then
        return
      end
    end
    A0_86.bIsNotFirstFight = true
    L3_89(L4_90)
  end
  for L6_92 = 1, _UPVALUE1_ do
    A0_86[_UPVALUE0_.MakeID(L6_92)]:SetOrginPosition(ccp(A0_86[_UPVALUE0_.MakeID(L6_92)]:getPosition()))
  end
end
function prototype.SetBossPos(A0_105)
  local L1_106, L2_107, L3_108, L4_109, L5_110, L6_111, L7_112, L8_113, L9_114, L10_115, L11_116, L12_117, L13_118, L14_119, L15_120, L16_121, L17_122, L18_123, L19_124, L20_125, L21_126, L22_127, L23_128
  L2_107 = A0_105
  L1_106 = A0_105.RestoreDefendersPos
  L1_106(L2_107)
  L1_106 = A0_105.defenders
  L2_107 = L1_106[1]
  L3_108 = L2_107
  L2_107 = L2_107.getContentSize
  L2_107 = L2_107(L3_108)
  L3_108 = L1_106[1]
  L4_109 = L3_108
  L3_108 = L3_108.getScale
  L3_108 = L3_108(L4_109)
  L4_109 = L2_107.width
  L4_109 = L4_109 * L3_108
  L5_110 = L2_107.height
  L5_110 = L5_110 * L3_108
  L6_111 = _UPVALUE0_
  L6_111 = L6_111.BOSS_POS
  L6_111 = L6_111.SCALE
  L6_111 = L4_109 * L6_111
  L6_111 = L6_111 - L4_109
  L6_111 = L6_111 / 2
  L6_111 = L6_111 - 15
  L7_112 = _UPVALUE0_
  L7_112 = L7_112.BOSS_POS
  L7_112 = L7_112.SCALE
  L7_112 = L5_110 * L7_112
  L7_112 = L7_112 - L5_110
  L7_112 = L7_112 / 2
  L7_112 = L7_112 - 15
  L8_113 = 0
  L9_114 = 0
  L10_115 = 0
  L11_116 = 0
  L12_117 = 0
  L13_118 = 0
  L14_119 = 0
  L15_120 = 0
  L16_121 = 0
  L17_122 = 0
  L18_123 = 0
  L19_124 = 0
  L20_125 = L1_106[5]
  L21_126 = L20_125
  L20_125 = L20_125.IsBoss
  L20_125 = L20_125(L21_126)
  if L20_125 then
    L17_122 = L17_122 - 1
    L20_125 = L1_106[4]
    L21_126 = L20_125
    L20_125 = L20_125.IsExist
    L20_125 = L20_125(L21_126)
    if L20_125 then
      L20_125 = L14_119 - 1
      L14_119 = L20_125 or L14_119
    end
    L20_125 = L1_106[6]
    L21_126 = L20_125
    L20_125 = L20_125.IsExist
    L20_125 = L20_125(L21_126)
    if L20_125 then
      L20_125 = L18_123 + 1
      L18_123 = L20_125 or L18_123
    end
    L20_125 = L1_106[2]
    L21_126 = L20_125
    L20_125 = L20_125.IsExist
    L20_125 = L20_125(L21_126)
    if L20_125 then
      L20_125 = L11_116 - 2
      L11_116 = L20_125 or L11_116
    end
  end
  L20_125 = L1_106[2]
  L21_126 = L20_125
  L20_125 = L20_125.IsBoss
  L20_125 = L20_125(L21_126)
  if L20_125 then
    L20_125 = L1_106[5]
    L21_126 = L20_125
    L20_125 = L20_125.IsExist
    L20_125 = L20_125(L21_126)
    if L20_125 then
      L20_125 = L11_116 - 1
    else
      L11_116 = L20_125 or L11_116 + 1
    end
    L20_125 = L1_106[1]
    L21_126 = L20_125
    L20_125 = L20_125.IsExist
    L20_125 = L20_125(L21_126)
    if L20_125 then
      L20_125 = L8_113 - 1
      L8_113 = L20_125 or L8_113
    end
    L20_125 = L1_106[3]
    L21_126 = L20_125
    L20_125 = L20_125.IsExist
    L20_125 = L20_125(L21_126)
    if L20_125 then
      L20_125 = L12_117 + 1
      L12_117 = L20_125 or L12_117
    end
  end
  L20_125 = L1_106[4]
  L21_126 = L20_125
  L20_125 = L20_125.IsBoss
  L20_125 = L20_125(L21_126)
  if L20_125 then
    L15_120 = L15_120 - 1
    L20_125 = L1_106[1]
    L21_126 = L20_125
    L20_125 = L20_125.IsExist
    L20_125 = L20_125(L21_126)
    if L20_125 then
      L20_125 = L9_114 - 2
      L9_114 = L20_125 or L9_114
    end
  end
  L20_125 = L1_106[6]
  L21_126 = L20_125
  L20_125 = L20_125.IsBoss
  L20_125 = L20_125(L21_126)
  if L20_125 then
    L19_124 = L19_124 - 1
    L20_125 = L1_106[3]
    L21_126 = L20_125
    L20_125 = L20_125.IsExist
    L20_125 = L20_125(L21_126)
    if L20_125 then
      L20_125 = L13_118 - 2
      L13_118 = L20_125 or L13_118
    end
  end
  L20_125 = L1_106[1]
  L21_126 = L20_125
  L20_125 = L20_125.IsBoss
  L20_125 = L20_125(L21_126)
  if not L20_125 then
    L20_125 = L1_106[4]
    L21_126 = L20_125
    L20_125 = L20_125.IsExist
    L20_125 = L20_125(L21_126)
    if L20_125 then
      L20_125 = L9_114 - 1
    else
      L9_114 = L20_125 or L9_114 + 1
    end
  end
  L20_125 = L1_106[3]
  L21_126 = L20_125
  L20_125 = L20_125.IsBoss
  L20_125 = L20_125(L21_126)
  if not L20_125 then
    L20_125 = L1_106[6]
    L21_126 = L20_125
    L20_125 = L20_125.IsExist
    L20_125 = L20_125(L21_126)
    if L20_125 then
      L20_125 = L13_118 - 1
    else
      L13_118 = L20_125 or L13_118 + 1
    end
  end
  function L20_125(A0_129, A1_130)
    return math.abs(A0_129) > math.abs(A1_130) and A0_129 or A1_130
  end
  L21_126 = math
  L21_126 = L21_126.min
  L22_127 = math
  L22_127 = L22_127.min
  L23_128 = L9_114
  L22_127 = L22_127(L23_128, L11_116)
  L23_128 = L13_118
  L21_126 = L21_126(L22_127, L23_128)
  L22_127 = L21_126
  L23_128 = L21_126
  L13_118 = L21_126
  L11_116 = L23_128
  L9_114 = L22_127
  L22_127 = L1_106[1]
  L23_128 = L22_127
  L22_127 = L22_127.IsBoss
  L22_127 = L22_127(L23_128)
  L9_114 = L22_127 and L21_126 or L21_126 - 1
  L22_127 = L1_106[2]
  L23_128 = L22_127
  L22_127 = L22_127.IsBoss
  L22_127 = L22_127(L23_128)
  L11_116 = L22_127 and L21_126 or L21_126 - 1
  L22_127 = L1_106[3]
  L23_128 = L22_127
  L22_127 = L22_127.IsBoss
  L22_127 = L22_127(L23_128)
  L13_118 = L22_127 and L21_126 or L21_126 - 1
  L22_127 = L20_125
  L23_128 = L8_113
  L22_127 = L22_127(L23_128, L14_119)
  L23_128 = L22_127
  L14_119 = L22_127
  L8_113 = L23_128
  L23_128 = L20_125
  L23_128 = L23_128(L12_117, L18_123)
  L22_127 = L23_128
  L23_128 = L22_127
  L18_123 = L22_127
  L12_117 = L23_128
  function L23_128(A0_131, A1_132, A2_133)
    local L3_134
    L3_134 = {}
    L3_134.x = 0
    L3_134.y = 0
    L3_134.scale = 1
    L3_134.y = A2_133 * _UPVALUE0_
    L3_134.x = A1_132 * _UPVALUE1_
    L3_134.scale = A0_131:getScale() * (A0_131:IsBoss() and _UPVALUE2_.BOSS_POS.SCALE or 1)
    A0_131:SetPositionRelative(L3_134)
  end
  L23_128(L1_106[1], L8_113, L9_114)
  L23_128(L1_106[3], L12_117, L13_118)
  L23_128(L1_106[4], L14_119, L15_120)
  L23_128(L1_106[6], L18_123, L19_124)
  L23_128(L1_106[2], 0, L11_116)
  L23_128(L1_106[5], 0, L17_122)
end
function prototype.PlayRounds(A0_135)
  local L1_136, L2_137, L3_138, L4_139, L5_140, L6_141, L7_142, L8_143, L9_144, L10_145, L11_146
  L11_146 = L2_137(L3_138)
  for L4_139, L5_140 in L1_136(L2_137, L3_138, L4_139, L5_140, L6_141, L7_142, L8_143, L9_144, L10_145, L11_146, L2_137(L3_138)) do
    L9_144 = _UPVALUE0_
    L9_144 = L9_144.TOL_ROUDNS
    L6_141(L7_142, L8_143, L9_144)
    L6_141(L7_142, L8_143)
    for L9_144, L10_145 in L6_141(L7_142) do
      L11_146 = nil
      if L9_144 == #L5_140 then
        L11_146 = L5_140.ends
      end
      A0_135:PlayAction(L10_145, L4_139, A0_135:GetNextAction(L4_139, L9_144), L11_146)
      A0_135:SetUnitAngerCD(L10_145.owner, L5_140.cdInfos)
      A0_135:SetUnitLastHit(A0_135:GetNextRoundActByOwner(L10_145.owner, L4_139))
      A0_135:DelayTime(_UPVALUE1_)
    end
  end
end
function prototype.RefreshRoundSkillHighLight(A0_147, A1_148)
  local L2_149, L3_150, L4_151, L5_152, L6_153, L7_154, L8_155, L9_156, L10_157
  L2_149 = {}
  L4_151 = A1_148 or {}
  for L6_153, L7_154 in L3_150(L4_151) do
    L8_155 = L7_154.owner
    L9_156 = L7_154.skill
    L2_149[L8_155] = L9_156
  end
  for L6_153, L7_154 in L3_150(L4_151) do
    L9_156 = L7_154
    L8_155 = L7_154.SetSkillHighLightStatus
    L10_157 = false
    L8_155(L9_156, L10_157)
    L9_156 = L7_154
    L8_155 = L7_154.ShowSkillHighLight
    L8_155(L9_156)
  end
  for L6_153, L7_154 in L3_150(L4_151) do
    L9_156 = L7_154
    L8_155 = L7_154.SetSkillHighLightStatus
    L10_157 = false
    L8_155(L9_156, L10_157)
    L9_156 = L7_154
    L8_155 = L7_154.ShowSkillHighLight
    L8_155(L9_156)
  end
  for L6_153, L7_154 in L3_150(L4_151) do
    L8_155 = KFDBGetRecord
    L9_156 = "SkillConfig"
    L10_157 = L7_154
    L8_155 = L8_155(L9_156, L10_157)
    L9_156 = false
    if L8_155 then
      L10_157 = L8_155.isMasterSkill
      L9_156 = L10_157 and (string.lower(L10_157) == "true" or L10_157 == "1")
    end
    if L9_156 then
      L10_157 = Logic
      L10_157 = L10_157.Get
      L10_157 = L10_157(L10_157, "RoleView")
      L10_157 = L10_157.Find
      L10_157 = L10_157(L10_157, L6_153)
      if L10_157 then
        L10_157:SetSkillHighLightStatus(true)
        L10_157:ShowSkillHighLight()
      end
    end
  end
end
function prototype.SetUnitAngerCD(A0_158, A1_159, A2_160)
  for _FORV_6_, _FORV_7_ in ipairs(A2_160) do
    if A1_159 == _FORV_7_.target then
      Logic:Get("RoleView"):Find(_FORV_7_.target):ShowSkillHeightLightByCD(_FORV_7_.cds)
      break
    end
  end
end
function prototype.SetUnitLastHit(A0_161, A1_162)
  if not A1_162 then
    return
  end
  if Logic:Get("RoleView"):Find(A1_162.owner) then
    for _FORV_6_, _FORV_7_ in ipairs(A1_162.targets) do
      Logic:Get("RoleView"):Find(A1_162.owner):ShowLastHitHeightLightByState(_FORV_7_.state)
    end
  end
end
function prototype.GetNextAction(A0_163, A1_164, A2_165)
  if A2_165 == #A0_163.parser:GetRounds()[A1_164] then
    A2_165 = 0
  end
  if A0_163.parser:GetRounds()[A1_164 + 1] == nil then
    return nil
  end
  return A0_163.parser:GetRounds()[A1_164 + 1][A2_165 + 1]
end
function prototype.GetNextRoundActByOwner(A0_166, A1_167, A2_168)
  local L3_169, L4_170
  L3_169 = A0_166.parser
  L4_170 = L3_169
  L3_169 = L3_169.GetRounds
  L3_169 = L3_169(L4_170)
  L4_170 = A2_168 + 1
  L4_170 = L3_169[L4_170]
  if not L4_170 then
    return nil
  end
  for _FORV_8_, _FORV_9_ in ipairs(L4_170) do
    if _FORV_9_.owner == A1_167 then
      return _FORV_9_
    end
  end
  return nil
end
function prototype.DelayTime(A0_171, A1_172)
  Logic:Get("AniMgr"):DelayTimeSync(A0_171.rootNode, A1_172, true)
end
function prototype.IsNextMasterSkill(A0_173, A1_174, A2_175)
  local L3_176, L4_177, L5_178, L6_179, L7_180, L8_181, L9_182, L10_183, L11_184, L12_185
  L3_176 = A0_173.parser
  L4_177 = L3_176
  L3_176 = L3_176.GetRounds
  L3_176 = L3_176(L4_177)
  L4_177 = A1_174 + 1
  L4_177 = L3_176[L4_177]
  if L4_177 then
    L5_178 = A2_175.owner
    for L9_182, L10_183 in L6_179(L7_180) do
      L11_184 = L10_183.owner
      if L11_184 == L5_178 then
        L11_184 = KFDBGetRecord
        L12_185 = "SkillConfig"
        L11_184 = L11_184(L12_185, L10_183.skill)
        if L11_184 then
          L12_185 = L11_184.isMasterSkill
          return L12_185 and (string.lower(L12_185) == "true" or L12_185 == "1")
        end
      end
    end
  end
  L5_178 = false
  return L5_178
end
function prototype.PlayEnd(A0_186)
  local L1_187, L2_188
  L1_187 = Logic
  L2_188 = L1_187
  L1_187 = L1_187.Get
  L1_187 = L1_187(L2_188, "BattleShow")
  L2_188 = L1_187
  L1_187 = L1_187.IsFinish
  L1_187 = L1_187(L2_188)
  L2_188 = A0_186.bIsInMultiFight
  if not L2_188 then
    L2_188 = A0_186.bResult
  else
    if L2_188 and not L1_187 then
      L2_188 = Logic
      L2_188 = L2_188.Get
      L2_188 = L2_188(L2_188, "BattleShow")
      L2_188 = L2_188.IsBattleTest
      L2_188 = L2_188(L2_188)
  end
  elseif L2_188 then
    L2_188 = A0_186.CleanUpBuff
    L2_188(A0_186)
    L2_188 = A0_186.CleanUpUnits
    L2_188(A0_186)
    L2_188 = A0_186.bResult
    if L2_188 then
      L2_188 = _UPVALUE0_
      L2_188 = L2_188.BATTLE_WIN
    elseif not L2_188 then
      L2_188 = A0_186.bIsInMultiFight
      if L2_188 then
        L2_188 = _UPVALUE0_
        L2_188 = L2_188.BATTLE_AGAIN
      elseif not L2_188 then
        L2_188 = _UPVALUE0_
        L2_188 = L2_188.BATTLE_LOSE
      end
    end
    if A0_186.bResult then
      A0_186:DelayTime(1)
    end
    Logic:Get("BGSound"):StopBattleMusic()
    if A0_186.bResult then
      Logic:Get("BGSound"):PlayEffect("audio/win.mp3")
    else
      Logic:Get("BGSound"):PlayEffect("audio/lose.mp3")
    end
    _UPVALUE1_.class:new(L2_188, A0_186, nil):RunAnimationSync(true)
    A0_186:CancelTimer()
    A0_186:CancelTouch()
    Logic:Get("SureConfirm"):FireEvent(Logic.SureConfirm.EVT.CLOSE_POPTIP)
    A0_186:StartMovieBattleEnd()
    A0_186:TextureCacheRemove()
    A0_186:ClearEffectINIData()
    Logic:Get("BattleShow"):BattlePlayEnd(A0_186.bResult)
    return
  end
  L2_188 = A0_186.bIsInMultiFight
  if not L2_188 then
    L2_188 = A0_186.SetBtlInfoText
    L2_188(A0_186, A0_186.curWave + 1, A0_186.totleWaves)
  else
    L2_188 = Logic
    L2_188 = L2_188.Get
    L2_188 = L2_188(L2_188, "BattleShow")
    A0_186:SetBtlInfoText(L2_188:GetMultiFightWave() + 1, L2_188:GetTotleMultiFightWave())
  end
  L2_188 = A0_186.DelayTime
  L2_188(A0_186, 2)
  L2_188 = A0_186.CleanUpBattle
  L2_188(A0_186)
  L2_188 = A0_186.MoveUnitsOutside
  L2_188(A0_186, A0_186.bResult)
  L2_188 = A0_186.ShowReliefTip
  L2_188(A0_186)
  L2_188 = Logic
  L2_188 = L2_188.Get
  L2_188 = L2_188(L2_188, "BattleShow")
  L2_188 = L2_188.SetLastFightResult
  L2_188(L2_188, A0_186.bResult)
  L2_188 = A0_186.onMoveForward
  L2_188(A0_186)
end
function prototype.CleanUpBattle(A0_189)
  for _FORV_4_, _FORV_5_ in ipairs(A0_189.attackers) do
    _FORV_5_:CleanUpOtherChild()
  end
  for _FORV_4_, _FORV_5_ in ipairs(A0_189.defenders) do
    _FORV_5_:CleanUpOtherChild()
  end
end
function prototype.PlayAction(A0_190, A1_191, A2_192, A3_193, A4_194)
  local L5_195, L6_196
  L5_195 = Logic
  L6_196 = L5_195
  L5_195 = L5_195.Get
  L5_195 = L5_195(L6_196, "RoleView")
  L6_196 = L5_195
  L5_195 = L5_195.Find
  L5_195 = L5_195(L6_196, A1_191.owner)
  if L5_195 == nil then
    return
  end
  L6_196 = {}
  L6_196.act = A1_191
  L6_196.nextAct = A3_193
  L6_196.beforeAct = A1_191.startPassives
  L6_196.endAct = A4_194
  _UPVALUE0_.class:new(A0_190, L6_196)
end
function prototype.InitUnitHeightLight(A0_197)
  for _FORV_4_, _FORV_5_ in ipairs(A0_197.attackers) do
    _FORV_5_:ShowSkillHeightLightByRounds(1)
  end
  for _FORV_4_, _FORV_5_ in ipairs(A0_197.defenders) do
    _FORV_5_:ShowSkillHeightLightByRounds(1)
  end
end
function prototype.bindAnimationMgr(A0_198)
  local L1_199
  L1_199 = true
  return L1_199
end
function prototype.onMoveForward(A0_200, A1_201, A2_202)
  Logic:Get("BattleShow"):GoNextFight()
end
function prototype.completedAnimationSequenceNamed(A0_203, A1_204)
end
function prototype.MoveActionPlus(A0_205)
  local L1_206, L2_207, L3_208, L4_209, L5_210, L6_211, L7_212, L8_213, L9_214, L10_215, L11_216, L12_217, L13_218, L14_219, L15_220, L16_221, L17_222, L18_223, L19_224, L20_225, L21_226, L22_227, L23_228, L24_229, L25_230
  L1_206 = Logic
  L2_207 = L1_206
  L1_206 = L1_206.Get
  L3_208 = "AniMgr"
  L1_206 = L1_206(L2_207, L3_208)
  L2_207 = Utils
  L2_207 = L2_207.Synchroniser
  L3_208 = L2_207
  L2_207 = L2_207.new
  L2_207 = L2_207(L3_208)
  L4_209 = A0_205
  L3_208 = A0_205.DelayTime
  L5_210 = 0.5
  L3_208(L4_209, L5_210)
  function L3_208(A0_231, A1_232, A2_233)
    return math.sqrt(math.pow(A0_231.y - A1_232.y, 2) + math.pow(A0_231.x - A1_232.x, 2)) / (A2_233 or 250) - math.sqrt(math.pow(A0_231.y - A1_232.y, 2) + math.pow(A0_231.x - A1_232.x, 2)) / (A2_233 or 250) % 0.01
  end
  L4_209 = 450
  L5_210 = 250
  L6_211 = 0
  L7_212 = {}
  L8_213 = {}
  L9_214 = {
    L10_215,
    L11_216,
    L12_217,
    L13_218,
    L14_219,
    L15_220
  }
  L13_218 = 5
  L14_219 = 4
  L15_220 = 6
  for L13_218, L14_219 in L10_215(L11_216) do
    L15_220 = A0_205.attackers
    L15_220 = L15_220[L14_219]
    L17_222 = L15_220
    L16_221 = L15_220.IsExist
    L16_221 = L16_221(L17_222)
    if L16_221 then
      L16_221 = ccp
      L18_223 = L15_220
      L17_222 = L15_220.getPosition
      L25_230 = L17_222(L18_223)
      L16_221 = L16_221(L17_222, L18_223, L19_224, L20_225, L21_226, L22_227, L23_228, L24_229, L25_230, L17_222(L18_223))
      L7_212[L15_220] = L16_221
      L16_221 = table
      L16_221 = L16_221.insert
      L17_222 = L8_213
      L18_223 = L15_220
      L16_221(L17_222, L18_223)
      L17_222 = L15_220
      L16_221 = L15_220.IsFrontArmy
      L16_221 = L16_221(L17_222)
      if L16_221 then
        L6_211 = L6_211 + 1
      end
    end
  end
  L25_230 = L11_216(L12_217)
  L13_218 = L12_217
  L25_230 = L12_217(L13_218)
  L13_218 = A0_205.attackers
  L13_218 = L13_218[4]
  L14_219 = L13_218
  L13_218 = L13_218.getPosition
  L25_230 = L13_218(L14_219)
  L13_218 = math
  L13_218 = L13_218.abs
  L14_219 = L11_216.y
  L15_220 = L10_215.y
  L14_219 = L14_219 - L15_220
  L13_218 = L13_218(L14_219)
  L13_218 = L13_218 - 10
  L14_219 = L3_208
  L15_220 = L12_217
  L16_221 = L10_215
  L17_222 = L5_210
  L14_219 = L14_219(L15_220, L16_221, L17_222)
  L15_220 = L3_208
  L16_221 = L11_216
  L17_222 = {}
  L18_223 = L11_216.x
  L17_222.x = L18_223
  L18_223 = L11_216.y
  L18_223 = L18_223 + L13_218
  L17_222.y = L18_223
  L18_223 = L5_210
  L15_220 = L15_220(L16_221, L17_222, L18_223)
  L16_221 = 0
  L17_222 = 0.2
  L19_224 = L2_207
  L18_223 = L2_207.Join
  L18_223 = L18_223(L19_224)
  function L19_224(A0_234, A1_235)
    local L2_236, L3_237, L4_238, L5_239, L6_240, L7_241, L8_242
    L2_236 = _UPVALUE0_
    L2_236()
    L2_236 = _UPVALUE1_
    L3_237 = L2_236
    L2_236 = L2_236.Join
    L2_236 = L2_236(L3_237)
    L3_237 = _UPVALUE2_
    L5_239 = A0_234
    L4_238 = A0_234.IsFrontArmy
    L4_238 = L4_238(L5_239)
    if L4_238 then
      L3_237 = _UPVALUE3_
    end
    L4_238 = ccp
    L6_240 = A0_234
    L5_239 = A0_234.getPosition
    L8_242 = L5_239(L6_240)
    L4_238 = L4_238(L5_239, L6_240, L7_241, L8_242, L5_239(L6_240))
    L5_239 = ccp
    L6_240 = L4_238.x
    L7_241 = L4_238.y
    L8_242 = _UPVALUE4_
    L7_241 = L7_241 - L8_242
    L5_239 = L5_239(L6_240, L7_241)
    L6_240 = _UPVALUE5_
    L6_240 = L6_240[A0_234]
    L7_241 = _UPVALUE6_
    L8_242 = L4_238
    L7_241 = L7_241(L8_242, L5_239, _UPVALUE7_)
    if A1_235 == 1 then
      L7_241 = L7_241 - 0.1
    end
    L8_242 = {}
    table.insert(L8_242, CCMoveTo:create(L7_241, L5_239))
    table.insert(L8_242, CCDelayTime:create(_UPVALUE8_ * (A1_235 - 1)))
    table.insert(L8_242, CCMoveTo:create(0.5, L6_240))
    table.insert(L8_242, function()
      _UPVALUE0_:CleanUpOtherChild()
      _UPVALUE1_()
    end)
    A0_234:runAction(_UPVALUE9_:CreateSequence(L8_242))
  end
  function L20_225(A0_243, A1_244)
    local L2_245, L3_246, L4_247, L5_248, L6_249, L7_250, L8_251, L9_252, L10_253, L11_254
    if A1_244 > 4 then
      return
    end
    function L2_245()
      _UPVALUE0_.class:new(_UPVALUE1_.MEM_MOVE, _UPVALUE2_, nil, _UPVALUE3_.LAYER_LEVEL.HERO):AttachCard(_UPVALUE2_:GetUnitInfo())
      _UPVALUE0_.class:new(_UPVALUE1_.MEM_MOVE, _UPVALUE2_, nil, _UPVALUE3_.LAYER_LEVEL.HERO):RunAnimation()
    end
    L4_247 = A0_243
    L3_246 = A0_243.GetPosIdByNum
    L3_246 = L3_246(L4_247)
    L4_247 = ccp
    L6_249 = A0_243
    L5_248 = A0_243.getPosition
    L11_254 = L5_248(L6_249)
    L4_247 = L4_247(L5_248, L6_249, L7_250, L8_251, L9_252, L10_253, L11_254, L5_248(L6_249))
    L5_248 = _UPVALUE3_
    L7_250 = A0_243
    L6_249 = A0_243.IsFrontArmy
    L6_249 = L6_249(L7_250)
    if L6_249 then
      L5_248 = _UPVALUE4_
    end
    L6_249 = ccp
    L7_250 = L5_248.x
    L8_251 = L5_248.y
    L9_252 = _UPVALUE5_
    L8_251 = L8_251 + L9_252
    L6_249 = L6_249(L7_250, L8_251)
    L7_250 = _UPVALUE6_
    L8_251 = L5_248
    L9_252 = L6_249
    L10_253 = _UPVALUE7_
    L7_250 = L7_250(L8_251, L9_252, L10_253)
    L8_251 = _UPVALUE6_
    L9_252 = L4_247
    L10_253 = L5_248
    L11_254 = _UPVALUE7_
    L8_251 = L8_251(L9_252, L10_253, L11_254)
    L9_252 = _UPVALUE8_
    L9_252 = L9_252.attackers
    L9_252 = L9_252[2]
    L10_253 = L9_252
    L9_252 = L9_252.IsExist
    L9_252 = L9_252(L10_253)
    if L9_252 then
      L9_252 = 1
    else
      L9_252 = L9_252 or 0
    end
    L11_254 = A0_243
    L10_253 = A0_243.IsFrontArmy
    L10_253 = L10_253(L11_254)
    if L10_253 then
      L10_253 = _UPVALUE10_
      L11_254 = A1_244 - L9_252
      L10_253 = L10_253 * L11_254
      _UPVALUE9_ = L10_253
    else
      L10_253 = _UPVALUE10_
      L11_254 = A1_244 - L9_252
      L11_254 = L11_254 - 1
      L10_253 = L10_253 * L11_254
      _UPVALUE9_ = L10_253
      L10_253 = _UPVALUE8_
      L10_253 = L10_253.attackers
      L10_253 = L10_253[5]
      L11_254 = L10_253
      L10_253 = L10_253.IsExist
      L10_253 = L10_253(L11_254)
      if not L10_253 then
        L10_253 = _UPVALUE11_
        if L10_253 == 1 then
          L10_253 = _UPVALUE8_
          L10_253 = L10_253.attackers
          L10_253 = L10_253[2]
          L11_254 = L10_253
          L10_253 = L10_253.IsExist
          L10_253 = L10_253(L11_254)
        else
          if not L10_253 then
            L10_253 = _UPVALUE11_
        end
        elseif L10_253 == 0 then
          L10_253 = _UPVALUE9_
          L11_254 = _UPVALUE12_
          L10_253 = L10_253 + L11_254
          _UPVALUE9_ = L10_253
        end
      end
    end
    L10_253 = _UPVALUE9_
    L10_253 = L10_253 - L8_251
    if A1_244 == 1 then
      L10_253 = 0
      L11_254 = _UPVALUE11_
      if L11_254 == 1 then
        L11_254 = _UPVALUE8_
        L11_254 = L11_254.attackers
        L11_254 = L11_254[2]
        L11_254 = L11_254.IsExist
        L11_254 = L11_254(L11_254)
        if L11_254 then
          L11_254 = _UPVALUE8_
          L11_254 = L11_254.attackers
          L11_254 = L11_254[5]
          L11_254 = L11_254.IsExist
          L11_254 = L11_254(L11_254)
          if not L11_254 then
            L10_253 = _UPVALUE12_
          end
        end
      end
    end
    if not (L10_253 > 0) or not L10_253 then
      L10_253 = 0
    end
    L11_254 = {}
    table.insert(L11_254, CCDelayTime:create(L10_253))
    table.insert(L11_254, L2_245)
    table.insert(L11_254, CCMoveTo:create(L8_251, L5_248))
    table.insert(L11_254, CCMoveTo:create(L7_250, L6_249))
    if A1_244 == 1 then
      table.insert(L11_254, function()
        local L0_255, L1_256, L2_257, L3_258, L4_259
        for L3_258, L4_259 in L0_255(L1_256) do
          L4_259:stopAllActions()
          _UPVALUE1_(L4_259, L3_258)
        end
      end)
    end
    A0_243:runAction(_UPVALUE15_:CreateSequence(L11_254))
  end
  for L24_229, L25_230 in L21_226(L22_227) do
    L20_225(L25_230, L24_229)
  end
  L21_226(L22_227)
  L24_229 = 2
  L25_230 = L21_226
  L22_227(L23_228, L24_229, L25_230)
  L22_227(L23_228)
  L24_229 = A0_205.rootNode
  L25_230 = 0.3
  L22_227(L23_228, L24_229, L25_230, true)
end
function prototype.MoveUnitsOutside(A0_260, A1_261)
  local L2_262, L3_263, L4_264, L5_265, L6_266, L7_267, L8_268, L9_269
  if not L2_262 then
    return
  end
  if L2_262 then
    for L5_265, L6_266 in L2_262(L3_263) do
      L9_269 = L6_266
      L8_268 = L6_266.getPosition
      L9_269 = L8_268(L9_269)
      L9_269 = L6_266
      L8_268 = L6_266.setPosition
      L8_268(L9_269, ccp(L7_267.x, L7_267.y - 500))
    end
    for L5_265, L6_266 in L2_262(L3_263) do
      L9_269 = L6_266
      L8_268 = L6_266.getPosition
      L9_269 = L8_268(L9_269)
      L9_269 = L6_266
      L8_268 = L6_266.setPosition
      L8_268(L9_269, ccp(L7_267.x, L7_267.y + 500))
    end
    return
  end
  if A1_261 then
  else
  end
  if A1_261 then
  else
  end
  for L8_268, L9_269 in L5_265(L6_266) do
    L4_264(L9_269)
  end
end
function prototype.MoveUnitsInside(A0_270)
  local L1_271, L2_272, L3_273, L4_274, L5_275, L6_276, L7_277, L8_278, L9_279, L10_280
  L1_271 = A0_270.bIsInMultiFight
  if not L1_271 then
    return
  end
  L1_271 = Logic
  L2_272 = L1_271
  L1_271 = L1_271.Get
  L3_273 = "AniMgr"
  L1_271 = L1_271(L2_272, L3_273)
  L2_272 = Utils
  L2_272 = L2_272.Synchroniser
  L3_273 = L2_272
  L2_272 = L2_272.new
  L2_272 = L2_272(L3_273)
  L3_273 = Logic
  L4_274 = L3_273
  L3_273 = L3_273.Get
  L3_273 = L3_273(L4_274, L5_275)
  L4_274 = L3_273
  L3_273 = L3_273.GetLastFightResult
  L3_273 = L3_273(L4_274)
  L4_274 = {}
  if L5_275 then
    for L8_278, L9_279 in L5_275(L6_276) do
      L10_280 = table
      L10_280 = L10_280.insert
      L10_280(L4_274, L9_279)
    end
    for L8_278, L9_279 in L5_275(L6_276) do
      L10_280 = table
      L10_280 = L10_280.insert
      L10_280(L4_274, L9_279)
    end
  elseif L3_273 then
  else
    L4_274 = L5_275 or A0_270.attackers
  end
  for L9_279, L10_280 in L6_276(L7_277) do
    L5_275(L10_280)
  end
  L6_276(L7_277)
  L9_279 = 0.3
  L10_280 = true
  L6_276(L7_277, L8_278, L9_279, L10_280)
end
function prototype.MoveAction(A0_281)
  local L1_282, L2_283, L3_284, L4_285, L5_286, L6_287, L7_288, L8_289, L9_290
  L1_282 = Logic
  L2_283 = L1_282
  L1_282 = L1_282.Get
  L3_284 = "AniMgr"
  L1_282 = L1_282(L2_283, L3_284)
  L2_283 = Utils
  L2_283 = L2_283.Synchroniser
  L3_284 = L2_283
  L2_283 = L2_283.new
  L2_283 = L2_283(L3_284)
  L4_285 = L2_283
  L3_284 = L2_283.Join
  L3_284 = L3_284(L4_285)
  function L4_285(A0_291)
    local L1_292, L2_293, L3_294
    L1_292 = math
    L1_292 = L1_292.random
    L2_293 = 0
    L3_294 = 2
    L1_292 = L1_292(L2_293, L3_294)
    L1_292 = L1_292 * 0.1
    L2_293 = _UPVALUE0_
    L3_294 = {}
    table.insert(L3_294, CCDelayTime:create(L1_292))
    table.insert(L3_294, function()
      _UPVALUE0_.class:new(_UPVALUE1_.MEM_MOVE, _UPVALUE2_, nil, _UPVALUE3_.LAYER_LEVEL.HERO):AttachCard(_UPVALUE2_:GetUnitInfo())
      _UPVALUE0_.class:new(_UPVALUE1_.MEM_MOVE, _UPVALUE2_, nil, _UPVALUE3_.LAYER_LEVEL.HERO):RunAnimationByTimes(nil, _UPVALUE4_, _UPVALUE5_)
    end)
    A0_291:runAction(_UPVALUE5_:CreateSequence(L3_294))
  end
  for L8_289, L9_290 in L5_286(L6_287) do
    L4_285(L9_290)
  end
  L8_289 = L3_284
  L5_286(L6_287, L7_288, L8_289)
  L5_286(L6_287)
  L8_289 = 0.3
  L9_290 = true
  L5_286(L6_287, L7_288, L8_289, L9_290)
end
function prototype.CancelTouch(A0_295)
  A0_295.rootNode:unregisterScriptTouchHandler()
end
function prototype.CancelTimer(A0_296)
  if A0_296.moveSchedulerId then
    CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(A0_296.moveSchedulerId)
    A0_296.moveSchedulerId = nil
  end
end
function prototype.MoveBackGround(A0_297, A1_298, A2_299)
  local L3_300, L4_301, L5_302, L6_303, L7_304, L8_305, L9_306, L10_307, L11_308, L12_309, L13_310, L14_311, L15_312
  L3_300 = _UPVALUE0_
  L3_300 = L3_300.class
  L4_301 = L3_300
  L3_300 = L3_300.new
  L5_302 = _UPVALUE1_
  L5_302 = L5_302.MOVE_ANI
  L6_303 = A0_297.rootNode
  L7_304 = ccp
  L8_305 = 0
  L9_306 = 0
  L15_312 = L7_304(L8_305, L9_306)
  L3_300 = L3_300(L4_301, L5_302, L6_303, L7_304, L8_305, L9_306, L10_307, L11_308, L12_309, L13_310, L14_311, L15_312, L7_304(L8_305, L9_306))
  L5_302 = L3_300
  L4_301 = L3_300.RunAnimation
  L4_301(L5_302)
  L4_301 = A0_297.moveDistance
  L5_302 = A0_297.curWave
  L6_303 = Logic
  L7_304 = L6_303
  L6_303 = L6_303.Get
  L8_305 = "AniMgr"
  L6_303 = L6_303(L7_304, L8_305)
  L7_304 = A0_297.rootNode
  L8_305 = L7_304
  L7_304 = L7_304.getChildByTag
  L9_306 = _UPVALUE2_
  L7_304 = L7_304(L8_305, L9_306)
  L9_306 = L7_304
  L8_305 = L7_304.getPosition
  L9_306 = L8_305(L9_306)
  L10_307 = math
  L10_307 = L10_307.ceil
  L11_308 = A0_297.totleWaves
  L11_308 = L11_308 / 3
  L10_307 = L10_307(L11_308)
  L10_307 = L10_307 * 3
  L11_308 = A0_297.totleWaves
  L11_308 = L10_307 - L11_308
  L12_309 = A0_297.curWave
  L11_308 = L11_308 + L12_309
  L11_308 = L4_301 * L11_308
  L12_309 = CCDelayTime
  L13_310 = L12_309
  L12_309 = L12_309.create
  L14_311 = 0.1
  L12_309 = L12_309(L13_310, L14_311)
  L13_310 = CCMoveTo
  L14_311 = L13_310
  L13_310 = L13_310.create
  L15_312 = A1_298
  L13_310 = L13_310(L14_311, L15_312, ccp(L8_305, -L11_308))
  function L14_311()
    _UPVALUE0_:RemoveAnimation()
    _UPVALUE1_()
  end
  L15_312 = L6_303.CreateSequence
  L15_312 = L15_312(L6_303, {L13_310, L14_311})
  L7_304:runAction(L15_312)
end
function prototype.AddCurrentWave(A0_313)
  A0_313.curWave = A0_313.curWave + 1
  A0_313.curWave = (A0_313.curWave - 1) % A0_313.totleWaves + 1
  Logic:Get("BattleShow"):SetCurWave(A0_313.curWave)
end
function prototype.SetCurrentWave(A0_314, A1_315)
  A0_314.curWave = A1_315
end
function prototype.InitTouch(A0_316)
  local L1_317, L2_318, L3_319, L4_320, L5_321, L6_322, L7_323, L8_324, L9_325, L10_326, L11_327, L12_328
  L4_320 = A0_316
  function L5_321(A0_329, A1_330)
    return A0_329:getPosition() - A0_329:getContentSize().width / 2 < A1_330.x and A0_329:getPosition() - A0_329:getContentSize().height / 2 < A1_330.y and A1_330.x < A0_329:getPosition() - A0_329:getContentSize().width / 2 + A0_329:getContentSize().width and A1_330.y < A0_329:getPosition() - A0_329:getContentSize().height / 2 + A0_329:getContentSize().height
  end
  function L6_322(A0_331)
    local L1_332, L2_333, L3_334, L4_335, L5_336
    for L4_335, L5_336 in L1_332(L2_333) do
      if _UPVALUE1_(L5_336, A0_331) then
        return L5_336
      end
    end
  end
  function L7_323(A0_337)
    local L1_338, L2_339, L3_340, L4_341
    L2_339 = A0_337
    L1_338 = A0_337.getTexture
    L1_338 = L1_338(L2_339)
    L3_340 = A0_337
    L2_339 = A0_337.getPosition
    L3_340 = L2_339(L3_340)
    L4_341 = CCSprite
    L4_341 = L4_341.create
    L4_341 = L4_341(L4_341, L1_338)
    _UPVALUE0_.rootNode:addChild(L4_341)
    L4_341:setPosition(ccp(L2_339, L3_340))
    return L4_341
  end
  function L8_324(A0_342)
    local L1_343
    L1_343 = Tw
    L1_343 = L1_343.Controller
    L1_343 = L1_343.load
    L1_343 = L1_343(L1_343, "BattleShowUnit", _UPVALUE0_.rootNode)
    L1_343:SetPosId(A0_342:GetPosId())
    L1_343:SetUnitInfo(A0_342:GetUnitInfo())
    L1_343:setPosition(A0_342:getPosition())
    L1_343:setAnchorPoint(A0_342:getAnchorPoint())
    _UPVALUE0_.rootNode:addChild(L1_343, 128)
    return L1_343
  end
  function L9_325(A0_344, A1_345)
    _UPVALUE0_ = _UPVALUE1_({x = A0_344, y = A1_345})
    if _UPVALUE0_ == nil or _UPVALUE0_:IsEnemy() then
      _UPVALUE0_ = nil
      return false
    end
    _UPVALUE2_ = _UPVALUE3_(_UPVALUE0_)
    _UPVALUE4_ = {
      x = _UPVALUE2_:getPosition()
    }
    _UPVALUE0_:SetVisible(false)
    return true
  end
  function L10_326(A0_346, A1_347)
    if _UPVALUE0_ and _UPVALUE1_ then
      _UPVALUE0_:setPosition(A0_346, A1_347)
    end
  end
  function L11_327(A0_348, A1_349)
    local L2_350
    L2_350 = _UPVALUE0_
    if L2_350 then
      L2_350 = _UPVALUE1_
      if L2_350 then
        L2_350 = _UPVALUE2_
        L2_350 = L2_350({x = A0_348, y = A1_349})
        if L2_350 and not L2_350:IsEnemy() then
          _UPVALUE3_:ChangeUnitPos(_UPVALUE4_, L2_350)
        end
      end
    end
    L2_350 = _UPVALUE4_
    L2_350 = L2_350.SetVisible
    L2_350(L2_350, true)
    L2_350 = _UPVALUE3_
    L2_350 = L2_350.rootNode
    L2_350 = L2_350.removeChild
    L2_350(L2_350, _UPVALUE0_, true)
    L2_350 = nil
    _UPVALUE0_ = L2_350
    L2_350 = nil
    _UPVALUE4_ = L2_350
    L2_350 = nil
    _UPVALUE1_ = L2_350
  end
  function L12_328(A0_351, A1_352, A2_353)
    if A0_351 == CCTOUCHBEGAN then
      return _UPVALUE0_(A1_352, A2_353)
    elseif A0_351 == CCTOUCHMOVED then
      return _UPVALUE1_(A1_352, A2_353)
    else
      return _UPVALUE2_(A1_352, A2_353)
    end
  end
  A0_316.rootNode:registerScriptTouchHandler(L12_328)
  A0_316.rootNode:setTouchEnabled(true)
end
function prototype.SetEmbattle(A0_354)
  local L1_355, L2_356, L3_357, L4_358
  L1_355 = A0_354.embattlePosInfo
  if L1_355 == nil then
    return
  end
  L1_355 = A0_354.embattlePosInfo
  L1_355 = L1_355.src
  L2_356 = A0_354.embattlePosInfo
  L2_356 = L2_356.dst
  L4_358 = L1_355
  L3_357 = L1_355.GetUnitInfo
  L3_357 = L3_357(L4_358)
  L4_358 = L2_356.GetUnitInfo
  L4_358 = L4_358(L2_356)
  L1_355:SetUnitInfo(L4_358)
  L2_356:SetUnitInfo(L3_357)
  A0_354.embattlePosInfo = nil
end
function prototype.ChangeUnitPos(A0_359, A1_360, A2_361)
  local L3_362, L4_363, L5_364
  function L3_362(A0_365)
    local L1_366, L2_367, L3_368
    L1_366 = string
    L1_366 = L1_366.match
    L2_367 = A0_365
    L3_368 = "(%d+)"
    L1_366 = L1_366(L2_367, L3_368)
    L2_367 = tonumber
    L3_368 = L1_366
    L2_367 = L2_367(L3_368)
    L1_366 = L2_367
    if L1_366 then
      L2_367 = math
      L2_367 = L2_367.floor
      L3_368 = L1_366 % 3
      L2_367 = L2_367(L3_368)
      L3_368 = math
      L3_368 = L3_368.floor
      L3_368 = L3_368(L1_366 / 3)
      return {L2_367, L3_368}
    end
  end
  L4_363 = {}
  L4_363.src = A1_360
  L4_363.dst = A2_361
  A0_359.embattlePosInfo = L4_363
  L5_364 = A1_360
  L4_363 = A1_360.GetPosId
  L4_363 = L4_363(L5_364)
  L5_364 = A2_361.GetPosId
  L5_364 = L5_364(A2_361)
  Logic:Get("Hero"):PostSetEmbattle(L3_362(L4_363), L3_362(L5_364))
end
function prototype.ShowAttackersHpProgress(A0_369, A1_370)
  for _FORV_5_, _FORV_6_ in ipairs(A0_369.attackers) do
    _FORV_6_:ShowHpPrg(A1_370)
  end
end
function prototype.ShowDefenders(A0_371, A1_372)
  local L2_373
  for _FORV_5_, _FORV_6_ in L2_373(Logic:Get("RoleView"):GetAllRoles()) do
    if _FORV_6_:IsEnemy() then
      _FORV_6_:SetVisible(A1_372)
      _FORV_6_:ShowHpPrg(A1_372)
      _FORV_6_:RunOpacity(0.3, A1_372)
    end
  end
end
function prototype.onBattleAcc(A0_374, A1_375, A2_376)
  local L3_377, L4_378, L5_379, L6_380, L7_381
  L3_377 = 0
  L4_378 = nil
  L5_379 = Logic
  L6_380 = L5_379
  L5_379 = L5_379.Get
  L7_381 = "Lock"
  L5_379 = L5_379(L6_380, L7_381)
  L6_380 = L5_379
  L5_379 = L5_379.GetStatusByLockId
  L7_381 = Logic
  L7_381 = L7_381.Lock
  L7_381 = L7_381.LOCK_ID
  L7_381 = L7_381.SPEED_UP
  L5_379 = L5_379(L6_380, L7_381)
  if L5_379 then
    L6_380 = Logic
    L7_381 = L6_380
    L6_380 = L6_380.Get
    L6_380 = L6_380(L7_381, "Lock")
    L7_381 = L6_380
    L6_380 = L6_380.GetOpenLevelAndBattle
    L7_381 = L6_380(L7_381, Logic.Lock.LOCK_ID.SPEED_UP)
    L4_378 = L7_381
    L3_377 = L6_380
  end
  L6_380 = Logic
  L7_381 = L6_380
  L6_380 = L6_380.Get
  L6_380 = L6_380(L7_381, "PlayerInfo")
  L7_381 = L6_380
  L6_380 = L6_380.GetPlayerLevel
  L6_380 = L6_380(L7_381)
  L6_380 = L6_380 or 0
  if L3_377 > L6_380 then
    L7_381 = CCControlEventTouchDown
    if A2_376 == L7_381 then
      if nil ~= L4_378 and "" ~= L4_378 then
        L7_381 = TwGetStr
        L7_381 = L7_381(105403, L3_377)
        L7_381 = L7_381 .. "\n" .. TwGetStr(105401, L4_378)
        Prompt:PopTip(L7_381)
      else
        L7_381 = Prompt
        L7_381 = L7_381.PopTip
        L7_381(L7_381, TwGetStr(105402, L3_377))
      end
    end
    L7_381 = CCControlEventTouchUpOutside
    if A2_376 ~= L7_381 then
      L7_381 = CCControlEventTouchUpInside
      if A2_376 ~= L7_381 then
        L7_381 = CCControlEventTouchCancel
      end
    elseif A2_376 == L7_381 then
      L7_381 = Logic
      L7_381 = L7_381.Get
      L7_381 = L7_381(L7_381, "SureConfirm")
      L7_381 = L7_381.FireEvent
      L7_381(L7_381, Logic.SureConfirm.EVT.CLOSE_POPTIP)
    end
  else
    L7_381 = CCControlEventTouchUpInside
    if A2_376 == L7_381 then
      L7_381 = Logic
      L7_381 = L7_381.Get
      L7_381 = L7_381(L7_381, "BattleShow")
      L7_381 = L7_381.AddAcc
      L7_381(L7_381)
      L7_381 = A0_374.BattleAcc
      L7_381(A0_374)
    end
  end
end
function prototype.BattleAcc(A0_382)
  local L1_383, L2_384
  L1_383 = Logic
  L2_384 = L1_383
  L1_383 = L1_383.Get
  L1_383 = L1_383(L2_384, "BattleShow")
  L2_384 = L1_383
  L1_383 = L1_383.GetAcc
  L1_383 = L1_383(L2_384)
  L2_384 = CCDirector
  L2_384 = L2_384.sharedDirector
  L2_384 = L2_384(L2_384)
  L2_384 = L2_384.getScheduler
  L2_384 = L2_384(L2_384)
  L2_384 = L2_384.setTimeScale
  L2_384(L2_384, L1_383)
  L2_384 = _UPVALUE0_
  L2_384 = L2_384.ACC_IMG
  L2_384 = L2_384[L1_383]
  if L2_384 and CCSprite:create(L2_384) then
    A0_382.mImgAcc:setDisplayFrame(CCSprite:create(L2_384):displayFrame())
  end
end
function prototype.ResetAcc(A0_385)
  CCDirector:sharedDirector():getScheduler():setTimeScale(1)
end
function prototype.QuitBattle(A0_386)
  A0_386:ResetAcc()
end
function prototype.GetExistUnits(A0_387, A1_388)
  local L2_389, L3_390, L4_391, L5_392, L6_393, L7_394
  L2_389 = {}
  for L6_393, L7_394 in L3_390(L4_391) do
    if L7_394:IsExist() then
      table.insert(L2_389, L7_394)
    end
  end
  return L2_389
end
function prototype.InitDisplayDemog(A0_395)
  local L1_396, L2_397, L3_398, L4_399, L5_400
  L1_396 = {}
  L2_397 = A0_395.bIsInDemog
  if not L2_397 then
    return L1_396
  end
  L2_397 = Logic
  L3_398 = L2_397
  L2_397 = L2_397.Get
  L4_399 = "Devil"
  L2_397 = L2_397(L3_398, L4_399)
  L3_398 = L2_397
  L2_397 = L2_397.GetFullPower
  L2_397 = L2_397(L3_398)
  L3_398 = Logic
  L4_399 = L3_398
  L3_398 = L3_398.Get
  L5_400 = "Devil"
  L3_398 = L3_398(L4_399, L5_400)
  L4_399 = L3_398
  L3_398 = L3_398.GetIsAllAct
  L3_398 = L3_398(L4_399)
  function L4_399(A0_401, A1_402)
    local L2_403, L3_404, L4_405, L5_406, L6_407
    L2_403 = {}
    for L6_407 = 0, A0_401 do
      table.insert(L2_403, A1_402)
    end
    return L2_403
  end
  if L3_398 then
    L5_400 = A0_395.GetExistUnits
    L5_400 = L5_400(A0_395, A0_395.attackers)
    table.insert(L1_396, {
      owner = L5_400,
      info = {
        showEffect = _UPVALUE0_.DEMOG_SHOW_EFFECT.ALL_ATTACK,
        myselfStarInfo = L4_399(#L5_400, L2_397),
        precision = 0.01
      }
    })
  end
  function L5_400()
    local L0_408, L1_409, L2_410, L3_411, L4_412, L5_413, L6_414, L7_415
    L0_408 = {}
    L4_412 = _UPVALUE0_
    L4_412 = L4_412.attackers
    L7_415 = L2_410(L3_411, L4_412)
    for L4_412, L5_413 in L1_409(L2_410, L3_411, L4_412, L5_413, L6_414, L7_415, L2_410(L3_411, L4_412)) do
      L6_414 = Logic
      L7_415 = L6_414
      L6_414 = L6_414.Get
      L6_414 = L6_414(L7_415, "Hero")
      L7_415 = L6_414
      L6_414 = L6_414.GetHeroInfoByBaseId
      L6_414 = L6_414(L7_415, L5_413:GetUnitInfo().model)
      if L6_414 then
        L7_415 = L6_414.star
      else
        if not L7_415 then
          L7_415 = 1
      end
      else
        L7_415 = L7_415 or L6_414.star
      end
      table.insert(L0_408, Logic:Get("Devil"):GetStarUpByCardStar(L7_415))
    end
    return L0_408
  end
  table.insert(L1_396, {
    owner = A0_395:GetExistUnits(A0_395.attackers),
    info = {
      showEffect = _UPVALUE0_.DEMOG_SHOW_EFFECT.DEVIL_RESTRAIN,
      myselfStarInfo = L5_400()
    }
  })
  return L1_396
end
function prototype.InitDisplayCombs(A0_416)
  local L1_417, L2_418, L3_419, L4_420
  L1_417 = A0_416.parser
  L2_418 = L1_417
  L1_417 = L1_417.GetAttackerCombs
  L1_417 = L1_417(L2_418)
  L2_418 = A0_416.parser
  L3_419 = L2_418
  L2_418 = L2_418.GetDefenderCombs
  L2_418 = L2_418(L3_419)
  function L3_419(A0_421, A1_422, A2_423)
    local L3_424, L4_425, L5_426, L6_427, L7_428, L8_429
    L3_424 = {}
    for L7_428, L8_429 in L4_425(L5_426) do
      if L8_429:GetUnitInfo() and _UPVALUE0_:IsType(L8_429:GetUnitInfo().model, A0_421, A1_422) then
        table.insert(L3_424, L8_429)
      end
    end
    return L3_424
  end
  function L4_420(A0_430, A1_431)
    local L2_432, L3_433, L4_434, L5_435, L6_436, L7_437, L8_438, L9_439
    L2_432 = {}
    if A0_430 ~= nil then
    elseif L3_433 then
      return L2_432
    end
    for L6_436, L7_437 in L3_433(L4_434) do
      L8_438 = KFDBGetRecord
      L9_439 = "AurasSetting"
      L8_438 = L8_438(L9_439, L7_437)
      if L8_438 then
        L9_439 = _UPVALUE0_
        L9_439 = L9_439(L8_438.target, L8_438.unit, A1_431)
        if not table.empty(L9_439) then
          table.insert(L2_432, {owner = L9_439, info = L8_438})
        end
      end
    end
    return L2_432
  end
  A0_416.attackersCombsInfo = L4_420(L1_417, A0_416:GetExistUnits(A0_416.attackers))
  A0_416.defendersCombsInfo = L4_420(L2_418, A0_416:GetExistUnits(A0_416.defenders))
  A0_416.attackersCombsInfo = list.concat(A0_416.attackersCombsInfo, A0_416:InitDisplayDemog())
end
function prototype.StartDisplayCombs(A0_440)
  local L1_441
  L1_441 = A0_440.DisplayCombs
  L1_441(A0_440, A0_440.attackersCombsInfo, true)
  L1_441 = A0_440.DisplayCombs
  L1_441(A0_440, A0_440.defendersCombsInfo, false)
  function L1_441(A0_442)
    local L1_443, L2_444, L3_445, L4_446, L5_447, L6_448, L7_449
    for L4_446, L5_447 in L1_443(L2_444) do
      L6_448 = L5_447.rootNode
      L7_449 = L6_448
      L6_448 = L6_448.getChildByTag
      L6_448 = L6_448(L7_449, _UPVALUE0_.NODE_TIPS_TAG)
      if L6_448 then
        L7_449 = L6_448.getChildByTag
        L7_449 = L7_449(L6_448, 128)
        if L7_449 and tolua.getpeer(L7_449) then
          L7_449:dispose()
        end
        L5_447.rootNode:removeChild(L6_448, true)
      end
      L7_449 = L5_447.rootNode
      L7_449 = L7_449.removeChildByTag
      L7_449(L7_449, _UPVALUE0_.NODE_TIPS_TAG, true)
      L7_449 = L5_447.rootNode
      L7_449 = L7_449.removeChildByTag
      L7_449(L7_449, _UPVALUE0_.NODE_TIPS_TAG + 1, true)
    end
  end
  L1_441(A0_440:GetExistUnits(A0_440.attackers))
  L1_441(A0_440:GetExistUnits(A0_440.defenders))
  A0_440:DelayTime(0.5)
end
function prototype.DisplayCombs(A0_450, A1_451, A2_452)
  local L3_453, L4_454, L5_455, L6_456, L7_457, L8_458, L9_459, L10_460, L11_461, L12_462, L13_463, L14_464, L15_465, L16_466
  function L3_453(A0_467, A1_468)
    _UPVALUE0_.rootNode:reorderChild(A0_467, 0)
    _UPVALUE1_.class:new(_UPVALUE2_.COMB_UP, A0_467):AttachCard(A0_467:GetUnitInfo())
    _UPVALUE1_.class:new(_UPVALUE2_.COMB_UP, A0_467):RunAnimation(nil, A1_468)
  end
  function L4_454(A0_469, A1_470)
  end
  L5_455 = Utils
  L5_455 = L5_455.Synchroniser
  L5_455 = L5_455.new
  L5_455 = L5_455(L6_456)
  L6_456(L7_457)
  for L9_459, L10_460 in L6_456(L7_457) do
    L11_461 = L10_460.info
    for L15_465, L16_466 in L12_462(L13_463) do
      L3_453(L16_466, L5_455)
    end
    L12_462(L13_463)
    L15_465 = L10_460.owner
    L16_466 = L5_455
    L12_462(L13_463, L14_464, L15_465, L16_466)
    for L15_465, L16_466 in L12_462(L13_463) do
      L4_454(L16_466, L5_455)
    end
    L12_462(L13_463)
  end
end
function prototype.ShowReliefTip(A0_471)
  local L1_472, L2_473
  L1_472 = A0_471.bIsInMultiFight
  if not L1_472 then
    return
  end
  L1_472 = Utils
  L1_472 = L1_472.Synchroniser
  L2_473 = L1_472
  L1_472 = L1_472.new
  L1_472 = L1_472(L2_473)
  L2_473 = {}
  L2_473.showEffect = _UPVALUE0_.TIP_SHWO_EFFECT.RELIEF
  A0_471:ShowTipsAndActions(L2_473, {}, L1_472)
  L1_472:Sync()
end
function prototype.ShowCombsTips(A0_474, A1_475, A2_476, A3_477)
  A0_474:ShowTipsAndActions(A1_475, A2_476, A3_477)
end
function prototype.ShowTipsAndActions(A0_478, A1_479, A2_480, A3_481)
  local L4_482, L5_483, L6_484, L7_485, L8_486, L9_487, L10_488, L11_489
  L4_482 = CCSprite
  L5_483 = L4_482
  L4_482 = L4_482.create
  L6_484 = _UPVALUE0_
  L6_484 = L6_484.COMB_PATH
  L6_484 = L6_484 .. L7_485 .. L8_486
  L4_482 = L4_482(L5_483, L6_484)
  L5_483 = _UPVALUE1_
  L5_483 = L5_483.class
  L6_484 = L5_483
  L5_483 = L5_483.new
  L10_488 = 0
  L11_489 = 0
  L11_489 = L9_487(L10_488, L11_489)
  L5_483 = L5_483(L6_484, L7_485, L8_486, L9_487, L10_488, L11_489, L9_487(L10_488, L11_489))
  L6_484 = L5_483.GetChild
  L6_484 = L6_484(L7_485, L8_486)
  L6_484 = L6_484.setDisplayFrame
  L11_489 = L8_486(L9_487)
  L6_484(L7_485, L8_486, L9_487, L10_488, L11_489, L8_486(L9_487))
  L6_484 = L5_483.GetChild
  L6_484 = L6_484(L7_485, L8_486)
  L6_484 = L6_484.setDisplayFrame
  L11_489 = L8_486(L9_487)
  L6_484(L7_485, L8_486, L9_487, L10_488, L11_489, L8_486(L9_487))
  L6_484 = ccBlendFunc
  L6_484 = L6_484()
  L6_484.dst = 1
  L6_484.src = L7_485
  L7_485(L8_486, L9_487)
  L10_488 = A3_481
  L7_485(L8_486, L9_487, L10_488)
  L10_488 = A2_480
  L11_489 = A3_481
  L7_485(L8_486, L9_487, L10_488, L11_489)
  L7_485(L8_486)
  L7_485(L8_486)
  for L10_488, L11_489 in L7_485(L8_486) do
    _UPVALUE1_.class:new(_UPVALUE2_.COMB_ACT, L11_489):AttachCard(L11_489:GetUnitInfo())
    _UPVALUE1_.class:new(_UPVALUE2_.COMB_ACT, L11_489):RunAnimationAutoRemove(A3_481:Join())
  end
  L7_485(L8_486)
end
function prototype.ShowAddValueTips(A0_490, A1_491, A2_492, A3_493)
  local L4_494, L5_495, L6_496, L7_497, L8_498, L9_499, L10_500, L11_501, L12_502, L13_503
  if A1_491 ~= nil then
  elseif L4_494 == nil then
    return
  end
  for L7_497, L8_498 in L4_494(L5_495) do
    L9_499 = _UPVALUE0_
    L9_499 = L9_499.class
    L10_500 = L9_499
    L9_499 = L9_499.new
    L11_501 = _UPVALUE1_
    L11_501 = L11_501.TIP_BLINK
    L12_502 = L8_498
    L9_499 = L9_499(L10_500, L11_501, L12_502)
    L11_501 = L9_499
    L10_500 = L9_499.RunAnimationAutoRemove
    L10_500(L11_501)
  end
  L4_494(L5_495, L6_496)
  for L7_497, L8_498 in L4_494(L5_495) do
    L9_499 = L8_498.rootNode
    L10_500 = L9_499
    L9_499 = L9_499.getChildByTag
    L11_501 = _UPVALUE2_
    L11_501 = L11_501.NODE_TIPS_TAG
    L9_499 = L9_499(L10_500, L11_501)
    if L9_499 == nil then
      L10_500 = CCNode
      L11_501 = L10_500
      L10_500 = L10_500.create
      L10_500 = L10_500(L11_501)
      L9_499 = L10_500
      L10_500 = L8_498.rootNode
      L11_501 = L10_500
      L10_500 = L10_500.addChild
      L12_502 = L9_499
      L13_503 = 999
      L10_500(L11_501, L12_502, L13_503, _UPVALUE2_.NODE_TIPS_TAG)
      L11_501 = L9_499
      L10_500 = L9_499.setContentSize
      L12_502 = CCSize
      L13_503 = 30
      L13_503 = L12_502(L13_503, 30)
      L10_500(L11_501, L12_502, L13_503, L12_502(L13_503, 30))
      L11_501 = L9_499
      L10_500 = L9_499.setPosition
      L12_502 = ccp
      L13_503 = 90
      L13_503 = L12_502(L13_503, 165)
      L10_500(L11_501, L12_502, L13_503, L12_502(L13_503, 165))
      L11_501 = L9_499
      L10_500 = L9_499.setAnchorPoint
      L12_502 = ccp
      L13_503 = 0
      L13_503 = L12_502(L13_503, 0)
      L10_500(L11_501, L12_502, L13_503, L12_502(L13_503, 0))
      L10_500 = CCSprite
      L11_501 = L10_500
      L10_500 = L10_500.create
      L12_502 = _UPVALUE2_
      L12_502 = L12_502.IMG_SRC
      L12_502 = L12_502.MULTIPLY
      L10_500 = L10_500(L11_501, L12_502)
      L12_502 = L10_500
      L11_501 = L10_500.setScale
      L13_503 = 0.75
      L11_501(L12_502, L13_503)
      L12_502 = L9_499
      L11_501 = L9_499.addChild
      L13_503 = L10_500
      L11_501(L12_502, L13_503)
      L12_502 = L10_500
      L11_501 = L10_500.setAnchorPoint
      L13_503 = ccp
      L13_503 = L13_503(1, 0)
      L11_501(L12_502, L13_503, L13_503(1, 0))
      L11_501 = CCNode
      L12_502 = L11_501
      L11_501 = L11_501.create
      L11_501 = L11_501(L12_502)
      L12_502 = L8_498.rootNode
      L13_503 = L12_502
      L12_502 = L12_502.addChild
      L12_502(L13_503, L11_501, 100, _UPVALUE2_.NODE_TIPS_TAG + 1)
      L13_503 = L11_501
      L12_502 = L11_501.setContentSize
      L12_502(L13_503, L8_498:getContentSize())
      L12_502 = _UPVALUE0_
      L12_502 = L12_502.class
      L13_503 = L12_502
      L12_502 = L12_502.new
      L12_502 = L12_502(L13_503, _UPVALUE1_.TIP_FIRE, L11_501)
      L13_503 = L12_502.RunAnimation
      L13_503(L12_502, nil)
      L13_503 = LabelAtlas
      L13_503 = L13_503.prototype
      L13_503 = L13_503.new
      L13_503 = L13_503(L13_503)
      L13_503:setPrecision(0.1, 1)
      L13_503:create(0, "LARGE_NUM", L9_499)
      L13_503.rootNode = L13_503:Owner()
      tolua.setpeer(L13_503:Owner(), L13_503)
    end
  end
  for L7_497, L8_498 in L4_494(L5_495) do
    L9_499 = L8_498.rootNode
    L10_500 = L9_499
    L9_499 = L9_499.getChildByTag
    L11_501 = _UPVALUE2_
    L11_501 = L11_501.NODE_TIPS_TAG
    L9_499 = L9_499(L10_500, L11_501)
    if L9_499 ~= nil then
      L10_500 = A1_491.myselfStarInfo
      L10_500 = L10_500[L7_497]
      L12_502 = L9_499
      L11_501 = L9_499.getChildByTag
      L13_503 = 128
      L11_501 = L11_501(L12_502, L13_503)
      if L11_501 then
        L12_502 = tolua
        L12_502 = L12_502.getpeer
        L13_503 = L11_501
        L12_502 = L12_502(L13_503)
        if L12_502 then
          L12_502 = tonumber
          L13_503 = L11_501.getValue
          L13_503 = L13_503(L11_501)
          L12_502 = L12_502(L13_503, L13_503(L11_501))
          L12_502 = L12_502 == 0 and L10_500 or L12_502 * L10_500
          L13_503 = L11_501.setCallback
          L13_503(L11_501, A3_493:Join())
          L13_503 = L11_501.setValueAni
          L13_503(L11_501, L12_502, 100)
        end
      end
    end
  end
  L4_494(L5_495)
end
function prototype.ShowRoundTips(A0_504)
  if A0_504.curWave == A0_504.totleWaves then
    if A0_504.bIsInArena or A0_504.bIsInDemog then
    else
      _UPVALUE0_.class:new(_UPVALUE1_.BATTLE_BOSS, A0_504, ccp(0, 0)):RunAnimationSync(true)
    end
    return
  end
  _UPVALUE0_.class:new(_UPVALUE1_.BATTLE_ROUND, A0_504, ccp(0, 0)):RunAnimationSync(true)
end
function prototype.IsType(A0_505, A1_506, A2_507, A3_508)
  if A2_507 == "ALL" then
    return true
  end
  if A2_507 == "UNIT_SAME_ID" then
    return Logic:Get("Hero"):GetHeroInfoByBaseId(A1_506) and tonumber(Logic:Get("Hero"):GetHeroInfoByBaseId(A1_506).sameNameId) == tonumber(A3_508)
  end
  return Logic:Get("Hero"):GetHeroInfoByBaseId(A1_506) and ({
    UNIT_RACE = "race",
    UNIT_SEX = "sex",
    UNIT_TYPE = "type"
  })[A2_507] and Logic:Get("Hero"):GetHeroInfoByBaseId(A1_506)[({
    UNIT_RACE = "race",
    UNIT_SEX = "sex",
    UNIT_TYPE = "type"
  })[A2_507]] == A3_508
end
function prototype.GetEffectINIData(A0_509)
  local L1_510
  L1_510 = "ini/effect.ini"
  A0_509.effectFile = Tw.TexturePreloader:getInstance():getFiles(L1_510)
end
function prototype.ClearEffectINIData(A0_511)
  local L1_512
  A0_511.effectFile = nil
end
function prototype.GetTextureFiles(A0_513)
  local L1_514, L2_515, L3_516, L4_517, L5_518, L6_519, L7_520, L8_521, L9_522, L10_523
  L1_514 = "images/Effect/"
  function L2_515(A0_524, A1_525)
    local L2_526, L3_527, L4_528, L5_529, L6_530, L7_531, L8_532, L9_533, L10_534, L11_535, L12_536, L13_537
    L2_526 = KFDBGetRecord
    L3_527 = "SkillConfig"
    L4_528 = A0_524
    L2_526 = L2_526(L3_527, L4_528)
    L3_527 = require
    L4_528 = "BattleShow.SkillMap"
    L3_527 = L3_527(L4_528)
    L3_527 = L3_527.Conduct
    if L2_526 then
      L4_528 = L2_526.conduct
    else
      L4_528 = L4_528 or 0
    end
    L5_529 = L3_527[L4_528]
    L9_533 = "atkeffect"
    L10_534 = "defact"
    L11_535 = "defeffect"
    L12_536 = "mageffect"
    L13_537 = "fbeffect"
    for L9_533, L10_534 in L6_530(L7_531) do
      L11_535 = require
      L12_536 = "BattleShow.SkillMap"
      L11_535 = L11_535(L12_536)
      L11_535 = L11_535.EffectConfig
      L12_536 = L5_529[L10_534]
      L12_536 = L11_535[L12_536]
      if L12_536 then
        L13_537 = string
        L13_537 = L13_537.match
        L13_537 = L13_537(L12_536.name, "(%w+)$")
        table.insert(A1_525, L13_537)
      end
    end
  end
  L3_516 = {}
  for L7_520, L8_521 in L4_517(L5_518, L6_519, L7_520, L8_521, L9_522, L10_523, L5_518(L6_519)) do
    for _FORV_12_, _FORV_13_ in L9_522(L10_523) do
      L2_515(_FORV_13_.skill, L3_516)
    end
  end
  for L9_522, L10_523 in L6_519(L7_520) do
  end
  return L5_518
end
function prototype.TextureCachePreLoad(A0_538)
  local L1_539, L2_540, L3_541, L4_542, L5_543, L6_544, L7_545
  L2_540 = A0_538
  L1_539 = A0_538.TextureCacheRemove
  L1_539(L2_540)
  L2_540 = A0_538
  L1_539 = A0_538.GetTextureFiles
  L1_539 = L1_539(L2_540)
  A0_538.imgTextureFiles = L1_539
  L1_539 = Tw
  L1_539 = L1_539.TexturePreloader
  L2_540 = L1_539
  L1_539 = L1_539.getInstance
  L1_539 = L1_539(L2_540)
  L2_540 = L1_539.getTextures
  L2_540 = L2_540(L3_541, L4_542)
  A0_538.imgTextureFiles = L2_540
  L2_540 = CCTextureCache
  L2_540 = L2_540.sharedTextureCache
  L2_540 = L2_540(L3_541)
  for L6_544, L7_545 in L3_541(L4_542) do
    L2_540:addImageAsync(L7_545)
  end
end
function prototype.TextureCacheRemove(A0_546)
  if A0_546.imgTextureFiles == nil then
    return
  end
  A0_546.imgTextureFiles = nil
end
function prototype.ShowReinforcementsTip(A0_547)
  local L1_548, L2_549, L3_550, L4_551, L5_552, L6_553, L7_554, L8_555, L9_556, L10_557, L11_558
  L1_548 = Logic
  L2_549 = L1_548
  L1_548 = L1_548.Get
  L3_550 = "BattleShow"
  L1_548 = L1_548(L2_549, L3_550)
  L2_549 = L1_548
  L1_548 = L1_548.GetFriendInfo
  L1_548 = L1_548(L2_549)
  if L1_548 ~= nil then
    L2_549 = L1_548.name
  elseif L2_549 == nil then
    return
  end
  function L2_549(A0_559)
    local L1_560
    L1_560 = _UPVALUE0_
    L1_560 = L1_560.RANK_COLOR
    L1_560 = L1_560[A0_559]
    L1_560 = L1_560 or _UPVALUE0_.RANK_COLOR[1]
    return string.format("#%02x%02x%02x", L1_560[1], L1_560[2], L1_560[3])
  end
  L3_550 = TwGetStr
  L4_551 = 107028
  L3_550 = L3_550(L4_551)
  L4_551 = TwGetStr
  L5_552 = 107030
  L4_551 = L4_551(L5_552)
  L5_552 = TwGetStr
  L6_553 = 107029
  L5_552 = L5_552(L6_553)
  L6_553 = Logic
  L7_554 = L6_553
  L6_553 = L6_553.Get
  L8_555 = "Hero"
  L6_553 = L6_553(L7_554, L8_555)
  L7_554 = L6_553
  L6_553 = L6_553.GetHeroInfoByBaseId
  L8_555 = L1_548.baseId
  L6_553 = L6_553(L7_554, L8_555)
  if L6_553 == nil then
    return
  end
  L7_554 = L2_549
  L8_555 = L6_553.rank
  L7_554 = L7_554(L8_555)
  L8_555 = "<font SIZE='40' color='#00ff00' >%s</font>"
  L9_556 = "<font SIZE='40' color='#ffffff' >%s</font>"
  L10_557 = "<font SIZE='40' color='#ffff00' >%d%s</font>"
  L11_558 = "<font SIZE='40' color='%s' >%s</font>"
  L8_555 = L8_555 .. L9_556 .. L10_557 .. L11_558
  L9_556 = string
  L9_556 = L9_556.format
  L10_557 = L8_555
  L11_558 = L1_548.name
  L9_556 = L9_556(L10_557, L11_558, L3_550, L6_553.star, L5_552, L7_554, L6_553.name)
  L10_557 = string
  L10_557 = L10_557.format
  L11_558 = "<font SIZE='40' color='#ffff00' >%s</font>"
  L10_557 = L10_557(L11_558, L4_551)
  L4_551 = L10_557
  L10_557 = _UPVALUE1_
  L10_557 = L10_557.class
  L11_558 = L10_557
  L10_557 = L10_557.new
  L10_557 = L10_557(L11_558, _UPVALUE2_.FRIEND_TIP, A0_547, ccp(0, 0))
  function L11_558()
    _UPVALUE0_:RemoveAnimation()
  end
  L10_557:SetWaitSignByDefaultAniName(L11_558)
  L10_557:GetChild("mRichText"):setString(L9_556)
  L10_557:GetChild("mRichText2"):setString(L4_551)
  L10_557:RunAnimation()
end
;({}).dropItems = {
  card = {
    idx = 1,
    amt = 0,
    text = "mStaCard",
    ani = "ENEMY_CARD",
    ctrler = "mCard",
    rewardType = {
      Logic.Reward.REWARDS_TYPE.HERO,
      Logic.Reward.REWARDS_TYPE.EXP_CARD,
      Logic.Reward.REWARDS_TYPE.COIN_CARD,
      Logic.Reward.REWARDS_TYPE.TREASURE,
      Logic.Reward.REWARDS_TYPE.EQUIP
    }
  },
  fragment = {
    idx = 2,
    amt = 0,
    text = "mStaFrame",
    ani = "ENEMY_FRAME",
    ctrler = "mFrame",
    rewardType = {
      Logic.Reward.REWARDS_TYPE.FRAGMENT
    }
  },
  coin = {
    idx = 3,
    amt = 0,
    text = "mStaCoin",
    ani = "ENEMY_COIN",
    ctrler = "",
    rewardType = {
      Logic.Reward.REWARDS_TYPE.CURRENCY
    }
  },
  soul = {
    idx = 4,
    amt = 0,
    text = "mStaSoul",
    ani = "ENEMY_SOUL",
    ctrler = "mSoul",
    rewardType = {
      Logic.Reward.REWARDS_TYPE.SOUL_STONE
    }
  }
}
;({}).Init = function(A0_561, A1_562, A2_563, A3_564)
  local L4_565, L5_566, L6_567, L7_568, L8_569, L9_570, L10_571, L11_572, L12_573, L13_574, L14_575, L15_576, L16_577, L17_578, L18_579, L19_580, L20_581
  if not A2_563 then
    L4_565 = {}
    A2_563 = L4_565
  end
  if not A3_564 then
    L4_565 = {}
    A3_564 = L4_565
  end
  L4_565 = A3_564.rewards
  L4_565 = L4_565 or {}
  L5_566 = A3_564.coins
  L5_566 = L5_566 or 0
  for L9_570, L10_571 in L6_567(L7_568) do
    L10_571.amt = L11_572
    for L14_575, L15_576 in L11_572(L12_573) do
      for L19_580, L20_581 in L16_577(L17_578) do
        A0_561:IterRewards(L20_581, function(A0_582)
          local L1_583, L2_584
          L1_583 = _UPVALUE0_
          if A0_582 == L1_583 then
            L1_583 = _UPVALUE1_
            L1_583 = L1_583.CURRENCY
            if A0_582 ~= L1_583 then
              L1_583 = _UPVALUE2_
              L2_584 = _UPVALUE2_
              L2_584 = L2_584.amt
              L2_584 = L2_584 - 1
              L1_583.amt = L2_584
              L1_583 = _UPVALUE2_
              L2_584 = _UPVALUE2_
              L2_584 = L2_584.amt
              if L2_584 < 0 then
                L2_584 = 0
              elseif not L2_584 then
                L2_584 = _UPVALUE2_
                L2_584 = L2_584.amt
              end
              L1_583.amt = L2_584
            end
          end
        end)
      end
    end
    L11_572(L12_573, L13_574)
  end
  L6_567.amt = L7_568
  if L7_568 < 0 then
  else
  end
  L6_567.amt = L7_568
  A0_561.belongUI = A1_562
end
;({}).Display = function(A0_585)
  for _FORV_4_, _FORV_5_ in pairs(A0_585.dropItems) do
    A0_585.belongUI[_FORV_5_.text]:setString(tostring(_FORV_5_.amt))
  end
end
;({}).GetUnitsAnimat = function(A0_586, A1_587, A2_588, A3_589)
  local L4_590, L6_591
  L4_590 = {}
  if nil == A1_587 then
    return L4_590
  end
  function L6_591(A0_592)
    for _FORV_4_, _FORV_5_ in pairs(_UPVALUE0_.dropItems) do
      for _FORV_9_, _FORV_10_ in ipairs(_FORV_5_.rewardType) do
        if _FORV_10_ == A0_592 then
          return _FORV_4_
        end
      end
    end
    return nil
  end
  A0_586:IterRewards(A1_587, function(A0_593, A1_594, A2_595)
    local L3_596, L4_597, L5_598
    L3_596 = _UPVALUE0_
    L4_597 = A0_593
    L3_596 = L3_596(L4_597)
    L4_597 = 1
    L5_598 = _UPVALUE1_
    L5_598 = L5_598(A1_594, A2_595)
    if nil ~= L3_596 and A0_593 ~= _UPVALUE2_.CURRENCY then
      _UPVALUE3_[L5_598] = _UPVALUE4_:GetAnimat(L3_596, L4_597)
    else
      table.insert(_UPVALUE5_, L5_598)
    end
  end)
  if 0 ~= #{} and A2_588 >= 0 then
    if math.floor(math.random(1, #{})) < 1 then
    end
    L4_590[({})[1 or math.floor(math.random(1, #{}))]] = A0_586:GetAnimat("coin", A2_588)
  end
  return L4_590
end
;({}).IterRewards = function(A0_599, A1_600, A2_601)
  local L3_602, L4_603, L5_604, L6_605, L7_606, L8_607, L9_608, L10_609, L11_610, L12_611
  for L6_605, L7_606 in L3_602(L4_603) do
    for L11_610, L12_611 in L8_607(L9_608) do
      A2_601(L12_611, L11_610, L6_605)
    end
  end
end
;({}).GetAnimat = function(A0_612, A1_613, A2_614)
  local L4_615
  function L4_615(A0_616)
    for _FORV_4_, _FORV_5_ in pairs(_UPVALUE0_.dropItems) do
      if nil ~= _FORV_5_.ctrler and "" ~= _FORV_5_.ctrler then
        A0_616:SetChildVisibleByName(_FORV_5_.ctrler, false)
      end
    end
  end
  return function(A0_617, A1_618)
    local L2_619, L3_620
    L2_619 = _UPVALUE0_
    L2_619 = L2_619.dropItems
    L3_620 = _UPVALUE1_
    L2_619 = L2_619[L3_620]
    L3_620 = _UPVALUE2_
    L3_620 = L3_620.class
    L3_620 = L3_620.new
    L3_620 = L3_620(L3_620, _UPVALUE3_[L2_619.ani], A0_617, A1_618)
    _UPVALUE4_(L3_620)
    L3_620:SetChildVisibleByName(L2_619.ctrler, true)
    L3_620:RunAnimationSync(true)
    L2_619.amt = L2_619.amt + _UPVALUE5_
    _UPVALUE0_:Display()
  end
end
function prototype.onBtnAtkerArtifact(A0_621, A1_622, A2_623)
  _UPVALUE0_:OnEvent(A2_623, A0_621, true)
end
function prototype.onBtnDeferArtifact(A0_624, A1_625, A2_626)
  _UPVALUE0_:OnEvent(A2_626, A0_624, false)
end
;({}).OnEvent = function(A0_627, A1_628, A2_629, A3_630)
  local L4_631
  L4_631 = 0
  if A3_630 then
    L4_631 = Logic:Get("Artifact"):GetArtLevel()
  else
    L4_631 = Logic:Get("BattleShow"):GetDefenderArtifactLevel()
  end
  if L4_631 and L4_631 < 0 then
    return
  end
  if A1_628 == CCControlEventTouchDown then
    L4_631 = L4_631 or 0
    A0_627:Display(L4_631, A2_629)
  end
  if A1_628 == CCControlEventTouchUpOutside or A1_628 == CCControlEventTouchUpInside or A1_628 == CCControlEventTouchCancel then
    A0_627:Close()
  end
end
;({}).Display = function(A0_632, A1_633, A2_634)
  A0_632.tipAni = _UPVALUE0_.class:new("Animation/BattleShowArtifactTip", A2_634, nil, 999)
  A0_632.tipAni:RunAnimation()
  A0_632:Refresh(A1_633)
end
;({}).Close = function(A0_635)
  if nil ~= A0_635.tipAni then
    A0_635.tipAni:RemoveAnimation()
  end
  A0_635.tipAni = nil
end
;({}).Refresh = function(A0_636, A1_637)
  local L2_638, L3_639, L4_640, L5_641, L6_642, L7_643, L8_644, L9_645
  L2_638 = A0_636.tipAni
  if nil == L2_638 then
    return
  end
  L2_638 = A0_636.tipAni
  L2_638 = L2_638.GetChild
  L2_638 = L2_638(L3_639, L4_640)
  L2_638 = L2_638.create
  L2_638(L3_639, L4_640, L5_641)
  L2_638 = A0_636.tipAni
  L2_638 = L2_638.GetChild
  L2_638 = L2_638(L3_639, L4_640)
  L2_638 = L2_638.setAlign
  L2_638(L3_639, L4_640, L5_641)
  L2_638 = A0_636.tipAni
  L2_638 = L2_638.GetChild
  L2_638 = L2_638(L3_639, L4_640)
  L2_638 = L2_638.setValue
  L2_638(L3_639, L4_640)
  L2_638 = {}
  for L6_642 = 7, 12 do
    L7_643 = string
    L7_643 = L7_643.format
    L8_644 = "%d_%d"
    L9_645 = A1_637
    L7_643 = L7_643(L8_644, L9_645, L6_642)
    L8_644 = KFDBGetRecord
    L9_645 = "ArtifactLevelSetting"
    L8_644 = L8_644(L9_645, L7_643)
    if L8_644 then
      L9_645 = {}
      L9_645.star = L6_642
      L9_645.currDesr = L8_644.desr
      L9_645.nextDesr = ""
      table.insert(L2_638, L9_645)
    end
  end
  L3_639(L4_640, L5_641)
end
