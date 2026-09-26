local L0_0
L0_0 = require
L0_0("SceneHelper")
L0_0 = require
L0_0("Logic.Battle")
L0_0 = module
L0_0((...), package.seeall)
L0_0 = Tw
L0_0 = L0_0.Controller
L0_0 = L0_0.prototype
L0_0 = L0_0.extend
L0_0 = L0_0(L0_0)
prototype = L0_0
L0_0 = {}
L0_0.SYSTEM = {
  normal = "images/Main/btnSystemNormal.png",
  select = "images/Main/btnSystemSelect.png",
  disable = "images/Main/btnSystemNormal.png"
}
L0_0.HOME = {
  normal = "images/Main/btnHomeNormal.png",
  select = "images/Main/btnHomeSelect.png",
  disable = "images/Main/btnHomeNormal.png"
}
function prototype.onEnter(A0_1, ...)
  Logic:Get("Guide"):On(Logic.Guide.EVT.STEP, A0_1:Event("updateGuide"))
  Logic:Get("Main"):On(Logic.Main.EVT.GOTO_HOME_PAGE, A0_1:Event("onGotoHomePage"))
  Logic:Get("PlayerInfo"):SetSystemBtnState(false)
  A0_1:SetSystemPic()
  Logic:Get("PlayerInfo"):On(Logic.PlayerInfo.EVT.CHECK_MAINBTN_STATE, A0_1:Event("onMainBtnState"))
  Logic:Get("Battle"):On(Logic.Battle.EVT.BATTLE_COMPLETED, A0_1:Event("OnBattleCompleted"))
  Logic:Get("PlayerInfo"):On(Logic.PlayerInfo.EVT.LEVEL_CHANGE, A0_1:Event("OnLevelChange"))
  Logic:Get("Login"):On(Logic.Login.EVT.LOGIN_COMPLETE, A0_1:Event("OnLoginComplete"))
  Logic:Get("Lock"):On(Logic.Lock.EVT.ENTER_WORLD, A0_1:Event("UpdateUiStatus"))
  A0_1:UpdateUiStatus()
  Logic:Get("Devil"):On(Logic.Devil.EVT.PUSH_NEW_REWARD, A0_1:Event("OnPushNewReward"))
  A0_1.ani = nil
  Logic:Get("Devil"):On(Logic.Devil.EVT.GOT_NEW_DEVIL, A0_1:Event("OnNewDemog"))
  Logic:Get("Friend"):On(Logic.Friend.EVT.NEW_FRIEND, A0_1:Event("onNewFriends"))
  Logic:Get("Achievement"):On(Logic.Achievement.EVT.NEW_ACHIEVE, A0_1:Event("onNewAchievements"))
  Logic:Get("Main"):On(Logic.Main.EVT.SHOW_NEW_TIP, A0_1:Event("OnGetNewTip"))
  Logic:Get("Compose"):On(Logic.Compose.EVT.NEW_COMPOSE, A0_1:Event("onNewCompose"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.HAS_NEW_DEMOG, A0_1:Event("OnNewGhost"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.CAN_JOIN_FIGHT, A0_1:Event("OnCanJoinFight"))
  A0_1:sendEmail()
end
function prototype.onMainBtnState(A0_3, A1_4)
  Logic:Get("PlayerInfo"):SetSystemBtnState(A1_4)
  A0_3:SetSystemPic()
end
function prototype.onBtnHome(A0_5, A1_6, A2_7)
  Logic:Get("Main"):CuMengMain("onBtnHome")
  SceneHelper:runWithScene("Home", A0_5.rootNode)
end
function prototype.onBtnCopy(A0_8, A1_9, A2_10)
  Logic:Get("Main"):CuMengMain("onBtnCopy")
  Logic:Get("PlayerInfo"):SetSystemBtnState(false)
  Logic:Get("Main"):CuMengMainGuide("EvolutionBattle", "Start")
  Logic:Get("Guide"):done("LevelUpBattle", "Start")
  Logic:Get("Guide"):done("EvolutionBattle", "Start")
  Logic:Get("Guide"):done("AchievementBattle", "Start")
  Logic:Get("Guide"):done("FightBattle", "Start")
  Logic:Get("Guide"):done("LotteryBattle", "Start")
  Logic:Get("Guide"):done("EquipElite", "Start")
  Logic:Get("Guide"):done("EquipFetterTwo", "Start")
  A0_8:SetSystemPic()
  SceneHelper:runWithScene("BattleCopy", A0_8.rootNode, nil, Logic:Get("Battle"):GetCurSelLayerType() ~= Logic.Battle.UI_LAYER_TYPE.CAMPAIGN)
end
function prototype.onBtnBattle(A0_11, A1_12, A2_13)
  local L3_14, L4_15, L5_16, L6_17, L7_18
  L3_14 = Logic
  L4_15 = L3_14
  L3_14 = L3_14.Get
  L5_16 = "Main"
  L3_14 = L3_14(L4_15, L5_16)
  L4_15 = L3_14
  L3_14 = L3_14.CuMengMain
  L5_16 = "onBtnFight"
  L3_14(L4_15, L5_16)
  L3_14 = A0_11.pvpStatus
  if L3_14 then
    L3_14 = CCControlEventTouchDown
    if A2_13 == L3_14 then
      L3_14 = Logic
      L4_15 = L3_14
      L3_14 = L3_14.Get
      L5_16 = "Lock"
      L3_14 = L3_14(L4_15, L5_16)
      L4_15 = L3_14
      L3_14 = L3_14.GetOpenLevelAndBattle
      L5_16 = Logic
      L5_16 = L5_16.Lock
      L5_16 = L5_16.LOCK_ID
      L5_16 = L5_16.PVP
      L4_15 = L3_14(L4_15, L5_16)
      L6_17 = A0_11
      L5_16 = A0_11.showLockTip
      L7_18 = L3_14
      L5_16(L6_17, L7_18, L4_15)
    end
    L4_15 = A0_11
    L3_14 = A0_11.closeLockTip
    L5_16 = A2_13
    L3_14(L4_15, L5_16)
    return
  end
  L3_14 = CCControlEventTouchUpInside
  if A2_13 == L3_14 then
    L3_14 = Logic
    L4_15 = L3_14
    L3_14 = L3_14.Get
    L5_16 = "Guide"
    L3_14 = L3_14(L4_15, L5_16)
    L4_15 = L3_14
    L3_14 = L3_14.done
    L5_16 = "FightPVP"
    L6_17 = "Start"
    L3_14(L4_15, L5_16, L6_17)
    L3_14 = Logic
    L4_15 = L3_14
    L3_14 = L3_14.Get
    L5_16 = "Guide"
    L3_14 = L3_14(L4_15, L5_16)
    L4_15 = L3_14
    L3_14 = L3_14.done
    L5_16 = "FightDrawGift"
    L6_17 = "Start"
    L3_14(L4_15, L5_16, L6_17)
    L3_14 = Logic
    L4_15 = L3_14
    L3_14 = L3_14.Get
    L5_16 = "Hero"
    L3_14 = L3_14(L4_15, L5_16)
    L4_15 = L3_14
    L3_14 = L3_14.ClearFiendInfo
    L3_14(L4_15)
    L3_14 = Logic
    L4_15 = L3_14
    L3_14 = L3_14.Get
    L5_16 = "PlayerInfo"
    L3_14 = L3_14(L4_15, L5_16)
    L4_15 = L3_14
    L3_14 = L3_14.SetSystemBtnState
    L5_16 = false
    L3_14(L4_15, L5_16)
    L4_15 = A0_11
    L3_14 = A0_11.SetSystemPic
    L3_14(L4_15)
    L3_14 = SceneHelper
    L4_15 = L3_14
    L3_14 = L3_14.runWithScene
    L5_16 = "FightPvp"
    L6_17 = A0_11.rootNode
    L3_14(L4_15, L5_16, L6_17)
  end
end
function prototype.onBtnGradeup(A0_19, A1_20, A2_21)
  local L3_22, L4_23, L5_24, L6_25, L7_26
  L3_22 = Logic
  L4_23 = L3_22
  L3_22 = L3_22.Get
  L5_24 = "Main"
  L3_22 = L3_22(L4_23, L5_24)
  L4_23 = L3_22
  L3_22 = L3_22.CuMengMain
  L5_24 = "onBtnLevelUp"
  L3_22(L4_23, L5_24)
  L3_22 = A0_19.upgradeStatus
  if L3_22 then
    L3_22 = CCControlEventTouchDown
    if A2_21 == L3_22 then
      L3_22 = Logic
      L4_23 = L3_22
      L3_22 = L3_22.Get
      L5_24 = "Lock"
      L3_22 = L3_22(L4_23, L5_24)
      L4_23 = L3_22
      L3_22 = L3_22.GetOpenLevelAndBattle
      L5_24 = Logic
      L5_24 = L5_24.Lock
      L5_24 = L5_24.LOCK_ID
      L5_24 = L5_24.UPGRADE
      L4_23 = L3_22(L4_23, L5_24)
      L6_25 = A0_19
      L5_24 = A0_19.showLockTip
      L7_26 = L3_22
      L5_24(L6_25, L7_26, L4_23)
    end
    L4_23 = A0_19
    L3_22 = A0_19.closeLockTip
    L5_24 = A2_21
    L3_22(L4_23, L5_24)
    return
  end
  L3_22 = CCControlEventTouchUpInside
  if A2_21 == L3_22 then
    L3_22 = Logic
    L4_23 = L3_22
    L3_22 = L3_22.Get
    L5_24 = "Main"
    L3_22 = L3_22(L4_23, L5_24)
    L4_23 = L3_22
    L3_22 = L3_22.CuMengMainGuide
    L5_24 = "LevelUp"
    L6_25 = "Start"
    L3_22(L4_23, L5_24, L6_25)
    L3_22 = Logic
    L4_23 = L3_22
    L3_22 = L3_22.Get
    L5_24 = "Guide"
    L3_22 = L3_22(L4_23, L5_24)
    L4_23 = L3_22
    L3_22 = L3_22.done
    L5_24 = "LevelUp"
    L6_25 = "Start"
    L3_22(L4_23, L5_24, L6_25)
    L3_22 = Logic
    L4_23 = L3_22
    L3_22 = L3_22.Get
    L5_24 = "Guide"
    L3_22 = L3_22(L4_23, L5_24)
    L4_23 = L3_22
    L3_22 = L3_22.done
    L5_24 = "FightLevelUp"
    L6_25 = "Start"
    L3_22(L4_23, L5_24, L6_25)
    L3_22 = Logic
    L4_23 = L3_22
    L3_22 = L3_22.Get
    L5_24 = "PlayerInfo"
    L3_22 = L3_22(L4_23, L5_24)
    L4_23 = L3_22
    L3_22 = L3_22.SetSystemBtnState
    L5_24 = false
    L3_22(L4_23, L5_24)
    L4_23 = A0_19
    L3_22 = A0_19.SetSystemPic
    L3_22(L4_23)
    L3_22 = SceneHelper
    L4_23 = L3_22
    L3_22 = L3_22.runWithScene
    L5_24 = "HeroUpgrade"
    L6_25 = A0_19.rootNode
    L3_22(L4_23, L5_24, L6_25)
  end
end
function prototype.onBtnEvovle(A0_27, A1_28, A2_29)
  local L3_30, L4_31, L5_32, L6_33, L7_34
  L3_30 = Logic
  L4_31 = L3_30
  L3_30 = L3_30.Get
  L5_32 = "Main"
  L3_30 = L3_30(L4_31, L5_32)
  L4_31 = L3_30
  L3_30 = L3_30.CuMengMain
  L5_32 = "onBtnEvovle"
  L3_30(L4_31, L5_32)
  L3_30 = A0_27.evovleStatus
  if L3_30 then
    L3_30 = CCControlEventTouchDown
    if A2_29 == L3_30 then
      L3_30 = Logic
      L4_31 = L3_30
      L3_30 = L3_30.Get
      L5_32 = "Lock"
      L3_30 = L3_30(L4_31, L5_32)
      L4_31 = L3_30
      L3_30 = L3_30.GetOpenLevelAndBattle
      L5_32 = Logic
      L5_32 = L5_32.Lock
      L5_32 = L5_32.LOCK_ID
      L5_32 = L5_32.EVOLUTION
      L4_31 = L3_30(L4_31, L5_32)
      L6_33 = A0_27
      L5_32 = A0_27.showLockTip
      L7_34 = L3_30
      L5_32(L6_33, L7_34, L4_31)
    end
    L4_31 = A0_27
    L3_30 = A0_27.closeLockTip
    L5_32 = A2_29
    L3_30(L4_31, L5_32)
    return
  end
  L3_30 = CCControlEventTouchUpInside
  if A2_29 == L3_30 then
    L3_30 = Logic
    L4_31 = L3_30
    L3_30 = L3_30.Get
    L5_32 = "Main"
    L3_30 = L3_30(L4_31, L5_32)
    L4_31 = L3_30
    L3_30 = L3_30.CuMengMainGuide
    L5_32 = "Evolution"
    L6_33 = "Start"
    L3_30(L4_31, L5_32, L6_33)
    L3_30 = Logic
    L4_31 = L3_30
    L3_30 = L3_30.Get
    L5_32 = "Guide"
    L3_30 = L3_30(L4_31, L5_32)
    L4_31 = L3_30
    L3_30 = L3_30.done
    L5_32 = "Evolution"
    L6_33 = "Start"
    L3_30(L4_31, L5_32, L6_33)
    L3_30 = Logic
    L4_31 = L3_30
    L3_30 = L3_30.Get
    L5_32 = "Guide"
    L3_30 = L3_30(L4_31, L5_32)
    L4_31 = L3_30
    L3_30 = L3_30.done
    L5_32 = "FightEvolution"
    L6_33 = "Start"
    L3_30(L4_31, L5_32, L6_33)
    L3_30 = Logic
    L4_31 = L3_30
    L3_30 = L3_30.Get
    L5_32 = "PlayerInfo"
    L3_30 = L3_30(L4_31, L5_32)
    L4_31 = L3_30
    L3_30 = L3_30.SetSystemBtnState
    L5_32 = false
    L3_30(L4_31, L5_32)
    L4_31 = A0_27
    L3_30 = A0_27.SetSystemPic
    L3_30(L4_31)
    L3_30 = Logic
    L4_31 = L3_30
    L3_30 = L3_30.Get
    L5_32 = "ExplainEquip"
    L3_30 = L3_30(L4_31, L5_32)
    L4_31 = L3_30
    L3_30 = L3_30.setEvolutionType
    L5_32 = Logic
    L5_32 = L5_32.ExplainEquip
    L5_32 = L5_32.EVO_TYPE
    L5_32 = L5_32.MATERIAL_EVO
    L3_30(L4_31, L5_32)
    L3_30 = SceneHelper
    L4_31 = L3_30
    L3_30 = L3_30.runWithScene
    L5_32 = "HeroEvolution"
    L6_33 = A0_27.rootNode
    L3_30(L4_31, L5_32, L6_33)
  end
end
function prototype.onBtnShop(A0_35, A1_36, A2_37)
  local L3_38, L4_39, L5_40, L6_41, L7_42
  L3_38 = Logic
  L4_39 = L3_38
  L3_38 = L3_38.Get
  L5_40 = "Main"
  L3_38 = L3_38(L4_39, L5_40)
  L4_39 = L3_38
  L3_38 = L3_38.CuMengMain
  L5_40 = "onBtnShop"
  L3_38(L4_39, L5_40)
  L3_38 = A0_35.mallStatus
  if L3_38 then
    L3_38 = CCControlEventTouchDown
    if A2_37 == L3_38 then
      L3_38 = Logic
      L4_39 = L3_38
      L3_38 = L3_38.Get
      L5_40 = "Lock"
      L3_38 = L3_38(L4_39, L5_40)
      L4_39 = L3_38
      L3_38 = L3_38.GetOpenLevelAndBattle
      L5_40 = Logic
      L5_40 = L5_40.Lock
      L5_40 = L5_40.LOCK_ID
      L5_40 = L5_40.MALL
      L4_39 = L3_38(L4_39, L5_40)
      L6_41 = A0_35
      L5_40 = A0_35.showLockTip
      L7_42 = L3_38
      L5_40(L6_41, L7_42, L4_39)
    end
    L4_39 = A0_35
    L3_38 = A0_35.closeLockTip
    L5_40 = A2_37
    L3_38(L4_39, L5_40)
    return
  end
  L3_38 = CCControlEventTouchUpInside
  if A2_37 == L3_38 then
    L3_38 = Logic
    L4_39 = L3_38
    L3_38 = L3_38.Get
    L5_40 = "Guide"
    L3_38 = L3_38(L4_39, L5_40)
    L4_39 = L3_38
    L3_38 = L3_38.done
    L5_40 = "Lottery"
    L6_41 = "Start"
    L3_38(L4_39, L5_40, L6_41)
    L3_38 = Logic
    L4_39 = L3_38
    L3_38 = L3_38.Get
    L5_40 = "Guide"
    L3_38 = L3_38(L4_39, L5_40)
    L4_39 = L3_38
    L3_38 = L3_38.done
    L5_40 = "EquipLottery"
    L6_41 = "Start"
    L3_38(L4_39, L5_40, L6_41)
    L3_38 = Logic
    L4_39 = L3_38
    L3_38 = L3_38.Get
    L5_40 = "PlayerInfo"
    L3_38 = L3_38(L4_39, L5_40)
    L4_39 = L3_38
    L3_38 = L3_38.SetSystemBtnState
    L5_40 = false
    L3_38(L4_39, L5_40)
    L4_39 = A0_35
    L3_38 = A0_35.SetSystemPic
    L3_38(L4_39)
    L3_38 = SceneHelper
    L4_39 = L3_38
    L3_38 = L3_38.runWithScene
    L5_40 = "Mall"
    L6_41 = A0_35.rootNode
    L3_38(L4_39, L5_40, L6_41)
  end
end
function prototype.SetSystemPic(A0_43)
  local L1_44
  L1_44 = {}
  L1_44 = _UPVALUE0_.HOME
  A0_43.btnSystem:setBackgroundSpriteForState(CCScale9Sprite:create(L1_44.normal), CCControlStateNormal)
  A0_43.btnSystem:setBackgroundSpriteForState(CCScale9Sprite:create(L1_44.select), CCControlStateHighlighted)
  A0_43.btnSystem:setBackgroundSpriteForState(CCScale9Sprite:create(L1_44.disable), CCControlStateDisabled)
end
function prototype.onGotoHomePage(A0_45)
  SceneHelper:runWithScene("Home", A0_45.rootNode)
  Logic:Get("PlayerInfo"):SetSystemBtnState(true)
  A0_45:SetSystemPic()
end
function prototype.updateGuide(A0_46)
  local L1_47, L2_48, L3_49, L4_50, L5_51, L6_52, L7_53, L8_54
  L1_47 = Logic
  L2_48 = L1_47
  L1_47 = L1_47.Get
  L1_47 = L1_47(L2_48, L3_49)
  L2_48 = L1_47.isGuiding
  L2_48 = L2_48(L3_49)
  if not L2_48 then
    return
  end
  L2_48 = L1_47.isActive
  L2_48 = L2_48(L3_49, L4_50, L5_51)
  if L2_48 then
    L2_48 = Singleton
    L2_48 = L2_48(L3_49)
    L2_48 = L2_48.After
    L7_53 = "onBtnCopy"
    L8_54 = L5_51(L6_52, L7_53)
    L2_48(L3_49, L4_50, L5_51, L6_52, L7_53, L8_54, L5_51(L6_52, L7_53))
    return
  end
  L2_48 = {
    L3_49,
    L4_50,
    L5_51,
    L6_52,
    L7_53,
    L8_54,
    {
      guide = "FightLevelUp",
      node = A0_46.btnGradeup
    },
    {
      guide = "FightEvolution",
      node = A0_46.btnEvolution
    },
    {
      guide = "FightBattle",
      node = A0_46.btnMission
    },
    {
      guide = "Lottery",
      node = A0_46.btnShop
    },
    {
      guide = "LotteryBattle",
      node = A0_46.btnMission
    },
    {
      guide = "EquipElite",
      node = A0_46.btnMission
    },
    {
      guide = "EquipLottery",
      node = A0_46.btnShop
    },
    {
      guide = "EquipFetterTwo",
      node = A0_46.btnMission
    }
  }
  L3_49.guide = "LevelUp"
  L3_49.node = L4_50
  L4_50.guide = "LevelUpBattle"
  L4_50.node = L5_51
  L5_51.guide = "Evolution"
  L5_51.node = L6_52
  L6_52.guide = "EvolutionBattle"
  L7_53 = A0_46.btnMission
  L6_52.node = L7_53
  L7_53 = {}
  L7_53.guide = "AchievementBattle"
  L8_54 = A0_46.btnMission
  L7_53.node = L8_54
  L8_54 = {}
  L8_54.guide = "FightPVP"
  L8_54.node = A0_46.btnFightPvp
  for L6_52, L7_53 in L3_49(L4_50) do
    L8_54 = L1_47.isActive
    L8_54 = L8_54(L1_47, L7_53.guide, "Start")
    if L8_54 then
      L8_54 = L1_47.lockTouch
      L8_54(L1_47, L7_53.node)
      return
    end
  end
  if L3_49 then
    if not L3_49 then
      L3_49(L4_50, L5_51)
    end
  end
  if L3_49 then
    if L3_49 then
      return
    end
  end
  if L3_49 then
    L3_49(L4_50, L5_51)
  end
  if L3_49 then
    if L3_49 then
      return
    end
  end
  if L3_49 then
    if L3_49 then
      return
    end
  end
  if L3_49 then
    if L3_49 then
      return
    end
  end
  if L3_49 then
    if L3_49 then
      return
    end
  end
  L7_53 = "Reinforc"
  L8_54 = "Treasure"
  for L7_53, L8_54 in L4_50(L5_51) do
    if L1_47:isActive(L8_54, "Start") then
      A0_46:onGotoHomePage()
      return
    end
  end
end
function prototype.onLockUpgrade(A0_55, A1_56)
  local L2_57, L3_58
  if A1_56 then
    L2_57 = CCScale9Sprite:create(_UPVALUE0_.lock)
    L3_58 = CCScale9Sprite:create(_UPVALUE0_.lock)
    A0_55:addLock(A0_55.btnGradeup, 96)
  else
    L2_57 = CCScale9Sprite:create(_UPVALUE0_.normal)
    L3_58 = CCScale9Sprite:create(_UPVALUE0_.select)
    A0_55:removeLock(A0_55.btnGradeup, 96)
  end
  if L2_57 and L3_58 then
    A0_55.btnGradeup:setBackgroundSpriteForState(L2_57, CCControlStateNormal)
    A0_55.btnGradeup:setBackgroundSpriteForState(L3_58, CCControlStateHighlighted)
  end
end
function prototype.onLockEvovle(A0_59, A1_60)
  local L2_61, L3_62
  if A1_60 then
    L2_61 = CCScale9Sprite:create(_UPVALUE0_.lock)
    L3_62 = CCScale9Sprite:create(_UPVALUE0_.lock)
    A0_59:addLock(A0_59.btnEvolution, 97)
  else
    L2_61 = CCScale9Sprite:create(_UPVALUE0_.normal)
    L3_62 = CCScale9Sprite:create(_UPVALUE0_.select)
    A0_59:removeLock(A0_59.btnEvolution, 97)
  end
  if L2_61 and L3_62 then
    A0_59.btnEvolution:setBackgroundSpriteForState(L2_61, CCControlStateNormal)
    A0_59.btnEvolution:setBackgroundSpriteForState(L3_62, CCControlStateHighlighted)
  end
end
function prototype.onLockPvp(A0_63, A1_64)
  local L2_65, L3_66
  if A1_64 then
    L2_65 = CCScale9Sprite:create(_UPVALUE0_.lock)
    L3_66 = CCScale9Sprite:create(_UPVALUE0_.lock)
    A0_63:addLock(A0_63.btnFightPvp, 98)
  else
    L2_65 = CCScale9Sprite:create(_UPVALUE0_.normal)
    L3_66 = CCScale9Sprite:create(_UPVALUE0_.select)
    A0_63:removeLock(A0_63.btnFightPvp, 98)
  end
  if L2_65 and L3_66 then
    A0_63.btnFightPvp:setBackgroundSpriteForState(L2_65, CCControlStateNormal)
    A0_63.btnFightPvp:setBackgroundSpriteForState(L3_66, CCControlStateHighlighted)
  end
end
function prototype.onLockMall(A0_67, A1_68)
  local L2_69, L3_70
  if A1_68 then
    L2_69 = CCScale9Sprite:create(_UPVALUE0_.lock)
    L3_70 = CCScale9Sprite:create(_UPVALUE0_.lock)
    A0_67:addLock(A0_67.btnShop, 99)
  else
    L2_69 = CCScale9Sprite:create(_UPVALUE0_.normal)
    L3_70 = CCScale9Sprite:create(_UPVALUE0_.select)
    A0_67:removeLock(A0_67.btnShop, 99)
  end
  if L2_69 and L3_70 then
    A0_67.btnShop:setBackgroundSpriteForState(L2_69, CCControlStateNormal)
    A0_67.btnShop:setBackgroundSpriteForState(L3_70, CCControlStateHighlighted)
  end
end
function prototype.showLockTip(A0_71, A1_72, A2_73)
  local L3_74
  if nil ~= A2_73 and "" ~= A2_73 then
    L3_74 = TwGetStr
    L3_74 = L3_74(105403, A1_72)
    L3_74 = L3_74 .. "\n" .. TwGetStr(105401, A2_73)
    Prompt:PopTip(L3_74)
  else
    L3_74 = Prompt
    L3_74 = L3_74.PopTip
    L3_74(L3_74, TwGetStr(105402, A1_72))
  end
end
function prototype.closeLockTip(A0_75, A1_76)
  if A1_76 == CCControlEventTouchUpOutside or A1_76 == CCControlEventTouchUpInside or A1_76 == CCControlEventTouchCancel then
    Logic:Get("SureConfirm"):FireEvent(Logic.SureConfirm.EVT.CLOSE_POPTIP)
  end
end
function prototype.addLock(A0_77, A1_78, A2_79)
  local L3_80, L4_81, L5_82, L6_83
  if A1_78 and A2_79 then
    L4_81 = A1_78
    L3_80 = A1_78.getChildByTag
    L5_82 = A2_79
    L3_80 = L3_80(L4_81, L5_82)
    if L3_80 ~= nil then
      return
    end
    L4_81 = CCSprite
    L5_82 = L4_81
    L4_81 = L4_81.create
    L6_83 = _UPVALUE0_
    L4_81 = L4_81(L5_82, L6_83)
    if nil == L4_81 then
      return
    end
    L6_83 = L4_81
    L5_82 = L4_81.setAnchorPoint
    L5_82(L6_83, CCPoint(0.5, 0.5))
    L6_83 = A1_78
    L5_82 = A1_78.getContentSize
    L5_82 = L5_82(L6_83)
    L5_82 = L5_82.width
    L5_82 = L5_82 / 2
    L6_83 = A1_78.getContentSize
    L6_83 = L6_83(A1_78)
    L6_83 = L6_83.height
    L6_83 = L6_83 / 2
    L6_83 = L6_83 + L4_81:getContentSize().height / 4
    L4_81:setPosition(ccp(L5_82, L6_83))
    A1_78:addChild(L4_81, 10, A2_79)
  end
end
function prototype.removeLock(A0_84, A1_85, A2_86)
  if A1_85 and A2_86 and A1_85:getChildByTag(A2_86) ~= nil then
    A1_85:removeChildByTag(A2_86, true)
  end
end
function prototype.OnLevelChange(A0_87)
  A0_87:checkLock()
end
function prototype.OnBattleCompleted(A0_88)
  A0_88:checkLock()
end
function prototype.OnLoginComplete(A0_89)
  A0_89:onGotoHomePage()
  A0_89:checkLock()
end
function prototype.UpdateUiStatus(A0_90)
  A0_90.upgradeStatus = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.UPGRADE)
  A0_90:onLockUpgrade(A0_90.upgradeStatus)
  A0_90.evovleStatus = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.EVOLUTION)
  A0_90:onLockEvovle(A0_90.evovleStatus)
  A0_90.pvpStatus = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.PVP)
  A0_90:onLockPvp(A0_90.pvpStatus)
  A0_90.mallStatus = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.MALL)
  A0_90:onLockMall(A0_90.mallStatus)
end
function prototype.checkLock(A0_91)
  Logic:Get("Lock"):CheckAllLocks()
  A0_91:UpdateUiStatus()
  A0_91:OnGetNewTip()
end
function prototype.OnPushNewReward(A0_92)
  Logic:Get("Gift"):HasRewardGift()
  if Logic:Get("Devil"):checkFeatReward() then
    SceneHelper:pushPrompt("DevilDrawTip", A0_92.rootNode)
  end
end
function prototype.onNewFriends(A0_93)
  A0_93:OnGetNewTip()
end
function prototype.onNewAchievements(A0_94)
  A0_94:OnGetNewTip()
end
function prototype.OnNewDemog(A0_95)
  A0_95:OnGetNewTip()
end
function prototype.OnNewGhost(A0_96)
  A0_96:OnGetNewTip()
end
function prototype.OnAllHeros(A0_97)
  A0_97:OnGetNewTip()
end
function prototype.onNewCompose(A0_98)
  A0_98:OnGetNewTip()
end
function prototype.OnCanJoinFight(A0_99)
  A0_99:OnGetNewTip()
end
function prototype.OnGetNewTip(A0_100)
  local L1_101, L2_102, L3_103, L4_104, L5_105, L6_106, L7_107, L8_108, L9_109, L10_110, L11_111
  L1_101 = Logic
  L2_102 = L1_101
  L1_101 = L1_101.Get
  L3_103 = "Friend"
  L1_101 = L1_101(L2_102, L3_103)
  L2_102 = L1_101
  L1_101 = L1_101.GetFriendPrompt
  L1_101 = L1_101(L2_102)
  L2_102 = Logic
  L3_103 = L2_102
  L2_102 = L2_102.Get
  L4_104 = "Achievement"
  L2_102 = L2_102(L3_103, L4_104)
  L3_103 = L2_102
  L2_102 = L2_102.GetAchievePro
  L2_102 = L2_102(L3_103)
  L3_103 = Logic
  L4_104 = L3_103
  L3_103 = L3_103.Get
  L5_105 = "Devil"
  L3_103 = L3_103(L4_104, L5_105)
  L4_104 = L3_103
  L3_103 = L3_103.GetPushDemog
  L3_103 = L3_103(L4_104)
  L4_104 = false
  L5_105 = false
  L6_106 = false
  L7_107 = false
  L8_108 = Logic
  L9_109 = L8_108
  L8_108 = L8_108.Get
  L10_110 = "Lock"
  L8_108 = L8_108(L9_109, L10_110)
  L9_109 = L8_108
  L8_108 = L8_108.GetStatusByLockId
  L10_110 = Logic
  L10_110 = L10_110.Lock
  L10_110 = L10_110.LOCK_ID
  L10_110 = L10_110.ACHIEVEMENT
  L8_108 = L8_108(L9_109, L10_110)
  A0_100.achStatus = L8_108
  L8_108 = Logic
  L9_109 = L8_108
  L8_108 = L8_108.Get
  L10_110 = "Lock"
  L8_108 = L8_108(L9_109, L10_110)
  L9_109 = L8_108
  L8_108 = L8_108.GetStatusByLockId
  L10_110 = Logic
  L10_110 = L10_110.Lock
  L10_110 = L10_110.LOCK_ID
  L10_110 = L10_110.DEMOG
  L8_108 = L8_108(L9_109, L10_110)
  A0_100.devilStatus = L8_108
  L8_108 = A0_100.achStatus
  if L8_108 then
    L2_102 = false
  end
  L8_108 = A0_100.devilStatus
  if L8_108 then
    L3_103 = false
  end
  if L1_101 or L2_102 or L3_103 or L4_104 or L5_105 or L6_106 or L7_107 then
    L8_108 = A0_100.btnSystem
    L9_109 = L8_108
    L8_108 = L8_108.getPositionX
    L8_108 = L8_108(L9_109)
    L8_108 = L8_108 + 30
    L9_109 = A0_100.btnSystem
    L10_110 = L9_109
    L9_109 = L9_109.getPositionY
    L9_109 = L9_109(L10_110)
    L9_109 = L9_109 + 38
    L10_110 = A0_100.ani
    if L10_110 == nil then
      L10_110 = Logic
      L11_111 = L10_110
      L10_110 = L10_110.Get
      L10_110 = L10_110(L11_111, "AniMgr")
      L11_111 = L10_110
      L10_110 = L10_110.RunCCBAni
      L10_110 = L10_110(L11_111, "UI/uinew", A0_100, ccp(L8_108, L9_109), 0.7)
      A0_100.ani = L10_110
    end
    L10_110 = A0_100.rootNode
    L11_111 = L10_110
    L10_110 = L10_110.getChildByTag
    L10_110 = L10_110(L11_111, 10)
    if L10_110 == nil then
      L11_111 = CCSprite
      L11_111 = L11_111.create
      L11_111 = L11_111(L11_111, "images/public/tip.png")
      A0_100.rootNode:addChild(L11_111, 0, 10)
      L11_111:setAnchorPoint(CCPoint(0.5, 0.5))
      L11_111:setPosition(ccp(L8_108, L9_109))
      L11_111:setScale(0.7)
    end
  else
    L8_108 = A0_100.ani
    if L8_108 ~= nil then
      L8_108 = A0_100.ani
      L9_109 = L8_108
      L8_108 = L8_108.RemoveAnimation
      L8_108(L9_109)
      A0_100.ani = nil
    end
    L8_108 = A0_100.rootNode
    L9_109 = L8_108
    L8_108 = L8_108.getChildByTag
    L10_110 = 10
    L8_108 = L8_108(L9_109, L10_110)
    if L8_108 ~= nil then
      L9_109 = A0_100.rootNode
      L10_110 = L9_109
      L9_109 = L9_109.removeChildByTag
      L11_111 = 10
      L9_109(L10_110, L11_111, true)
    end
  end
end
function prototype.sendEmail(A0_112)
  local L1_113, L2_114, L3_115, L4_116, L5_117, L6_118
  L1_113 = Logic
  L2_114 = L1_113
  L1_113 = L1_113.Get
  L3_115 = "Gift"
  L1_113 = L1_113(L2_114, L3_115)
  L2_114 = L1_113
  L1_113 = L1_113.IsSendEamin
  L3_115 = L1_113(L2_114)
  if L1_113 then
    L4_116 = Logic
    L5_117 = L4_116
    L4_116 = L4_116.Get
    L6_118 = "Email"
    L4_116 = L4_116(L5_117, L6_118)
    L5_117 = L4_116
    L4_116 = L4_116.SendNewEmain
    L6_118 = L2_114
    L4_116(L5_117, L6_118, false, nil, L3_115)
  else
    L4_116 = Logic
    L5_117 = L4_116
    L4_116 = L4_116.Get
    L6_118 = "System"
    L4_116 = L4_116(L5_117, L6_118)
    L5_117 = L4_116
    L4_116 = L4_116.GetUsrVariableMisc
    L6_118 = "UV_EMAIL"
    L4_116 = L4_116(L5_117, L6_118)
    if L4_116 ~= nil and L4_116 ~= "null" then
      L5_117 = json
      L5_117 = L5_117.decode
      L6_118 = L4_116
      L5_117 = L5_117(L6_118)
      L4_116 = L5_117
      L5_117 = table
      L5_117 = L5_117.empty
      L6_118 = L4_116
      L5_117 = L5_117(L6_118)
      if L5_117 then
        return
      end
      L5_117 = L4_116.content
      if L5_117 == nil then
        return
      end
      L5_117 = Logic
      L6_118 = L5_117
      L5_117 = L5_117.Get
      L5_117 = L5_117(L6_118, "Gift")
      L6_118 = L5_117
      L5_117 = L5_117.GetActivitysNameByIds
      L5_117 = L5_117(L6_118, L4_116.content)
      if L5_117 == "" then
        L6_118 = json
        L6_118 = L6_118.encode
        L6_118 = L6_118({})
        Logic:Get("System"):SetUsrVariableMisc("UV_EMAIL", L6_118)
        return
      end
      L6_118 = Logic
      L6_118 = L6_118.Get
      L6_118 = L6_118(L6_118, "Email")
      L6_118 = L6_118.SendNewEmain
      L6_118(L6_118, L5_117, L4_116.readed, L4_116.time, L4_116.content)
    end
  end
end
