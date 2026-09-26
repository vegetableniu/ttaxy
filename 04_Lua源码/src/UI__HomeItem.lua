local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = Tw
L0_0 = L0_0.Controller
L0_0 = L0_0.prototype
L0_0 = L0_0.extend
L0_0 = L0_0(L0_0)
prototype = L0_0
L0_0 = "images/Main/skillLock.png"
BTN = {
  "btnCard",
  "btnSkill",
  "btnAchievement",
  "btnCompose",
  "btnDevil",
  "btnActivity",
  "btnReward",
  "btnSystem"
}
NEW_TIP = {
  "imgFullCard",
  "imgNewSkill",
  "imgNewAchieve",
  "imgNewCompose",
  "imgNewDevil",
  "imgNewActivity",
  "imgNewFriend",
  "imgNewSystem"
}
function prototype.onEnter(A0_1)
  if not A0_1:EventTracer():Exist("updateGuide") then
    Logic:Get("Guide"):On(Logic.Guide.EVT.STEP, A0_1:Event("updateGuide"))
  end
end
function prototype.RefreshItem(A0_2, A1_3, A2_4)
  A0_2:initializeBTN()
  A0_2.btnItem = A1_3
  for _FORV_6_ = 1, #A1_3 do
    A0_2:SetBtnImg(BTN[_FORV_6_], A1_3[_FORV_6_])
  end
  _FOR_(_FOR_)
  A0_2:StaLock(A2_4)
end
function prototype.initializeBTN(A0_5)
  for _FORV_4_ = 1, #BTN do
    A0_5[BTN[_FORV_4_]]:setVisible(false)
  end
  for _FORV_4_ = 1, #NEW_TIP do
    A0_5[NEW_TIP[_FORV_4_]]:setVisible(false)
  end
  if _FOR_ then
    A0_5.ani1:RemoveAnimation()
    A0_5.ani1 = nil
  end
  if A0_5.ani2 then
    A0_5.ani2:RemoveAnimation()
  end
  if A0_5.aniDemog ~= nil then
    A0_5.aniDemog:RemoveAnimation()
    A0_5.aniDemog = nil
  end
  if A0_5.aniGhost ~= nil then
    A0_5.aniGhost:RemoveAnimation()
    A0_5.aniGhost = nil
  end
end
function prototype.SetBtnImg(A0_6, A1_7, A2_8)
  if Logic:Get("Home"):GetBtnImg(A2_8) == nil and Logic:Get("Home"):GetBtnImg(A2_8).normal and Logic:Get("Home"):GetBtnImg(A2_8).select and Logic:Get("Home"):GetBtnImg(A2_8).disable then
    return
  end
  A0_6[A1_7]:setVisible(true)
  A0_6[A1_7]:setBackgroundSpriteForState(CCScale9Sprite:create(Logic:Get("Home"):GetBtnImg(A2_8).normal), CCControlStateNormal)
  A0_6[A1_7]:setBackgroundSpriteForState(CCScale9Sprite:create(Logic:Get("Home"):GetBtnImg(A2_8).select), CCControlStateHighlighted)
  A0_6[A1_7]:setBackgroundSpriteForState(CCScale9Sprite:create(Logic:Get("Home"):GetBtnImg(A2_8).disable), CCControlStateDisabled)
end
function prototype.clearLock(A0_9)
  for _FORV_4_, _FORV_5_ in pairs(BTN) do
    A0_9:removeLock(A0_9[_FORV_5_], _UPVALUE0_)
  end
end
function prototype.StaLock(A0_10, A1_11)
  A0_10:lockBtn(A1_11, "ACHIEVEMENT", "btnAchievement", _UPVALUE0_)
  A0_10.achStatus = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.ACHIEVEMENT)
  A0_10:lockBtn(A1_11, "SKILL", "btnSkill", _UPVALUE0_)
  A0_10.skillStatus = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.SKILL)
  A0_10:lockBtn(A1_11, "ACTIVITY", "btnActivity", _UPVALUE0_)
  A0_10.activityStatus = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.ACTIVITY)
  A0_10:lockBtn(A1_11, "DEMOG", "btnDevil", _UPVALUE0_)
  A0_10.devilStatus = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.DEMOG)
  A0_10.aniDemog = nil
  A0_10:lockBtn(A1_11, "MENPAI", "btnBang", _UPVALUE0_)
  A0_10:lockBtn(A1_11, "WORLD_CHAT", "btnChat", _UPVALUE0_)
  A0_10:lockBtn(A1_11, "EQUIP", "btnArmor", _UPVALUE0_)
  A0_10:lockBtn(A1_11, "CULTIVATE", "btnCultivate", _UPVALUE0_)
  A0_10:lockBtn(A1_11, "HERO_COST_RANK_UP", "btnSoaring", _UPVALUE0_)
  if Logic:Get("Devil"):checkNewDemogAct() then
    A0_10:ChangeDevilIcon()
  end
end
function prototype.LockSecondPage(A0_12)
  A0_12:onLockFabao()
end
function prototype.onLockAchievement(A0_13, A1_14)
  local L2_15, L3_16
  if A1_14 then
    L2_15 = CCScale9Sprite:create(_UPVALUE0_.lock)
    L3_16 = CCScale9Sprite:create(_UPVALUE0_.lock)
    A0_13:addLock(A0_13.btnAchievement, _UPVALUE1_)
  else
    L2_15 = CCScale9Sprite:create(_UPVALUE0_.normal)
    L3_16 = CCScale9Sprite:create(_UPVALUE0_.select)
    A0_13:removeLock(A0_13.btnAchievement, _UPVALUE1_)
  end
  if L2_15 and L3_16 then
    A0_13.btnAchievement:setBackgroundSpriteForState(L2_15, CCControlStateNormal)
    A0_13.btnAchievement:setBackgroundSpriteForState(L3_16, CCControlStateHighlighted)
  end
end
function prototype.onLockSkill(A0_17, A1_18)
  local L2_19, L3_20
  if A1_18 then
    L2_19 = CCScale9Sprite:create(_UPVALUE0_.lock)
    L3_20 = CCScale9Sprite:create(_UPVALUE0_.lock)
    A0_17:addLock(A0_17.btnSkill, _UPVALUE1_)
  else
    L2_19 = CCScale9Sprite:create(_UPVALUE0_.normal)
    L3_20 = CCScale9Sprite:create(_UPVALUE0_.select)
    A0_17:removeLock(A0_17.btnSkill, _UPVALUE1_)
  end
  if L2_19 and L3_20 then
    A0_17.btnSkill:setBackgroundSpriteForState(L2_19, CCControlStateNormal)
    A0_17.btnSkill:setBackgroundSpriteForState(L3_20, CCControlStateHighlighted)
  end
end
function prototype.onLockActivity(A0_21, A1_22)
  local L2_23, L3_24
  if A1_22 then
    L2_23 = CCScale9Sprite:create(_UPVALUE0_.lock)
    L3_24 = CCScale9Sprite:create(_UPVALUE0_.lock)
    A0_21:addLock(A0_21.btnActivity, _UPVALUE1_)
  else
    L2_23 = CCScale9Sprite:create(_UPVALUE0_.normal)
    L3_24 = CCScale9Sprite:create(_UPVALUE0_.select)
    A0_21:removeLock(A0_21.btnActivity, _UPVALUE1_)
  end
  if L2_23 and L3_24 then
    A0_21.btnActivity:setBackgroundSpriteForState(L2_23, CCControlStateNormal)
    A0_21.btnActivity:setBackgroundSpriteForState(L3_24, CCControlStateHighlighted)
  end
end
function prototype.onLockDevil(A0_25, A1_26)
  local L2_27, L3_28
  if A1_26 then
    L2_27 = CCScale9Sprite:create(_UPVALUE0_.lock)
    L3_28 = CCScale9Sprite:create(_UPVALUE0_.lock)
    A0_25:addLock(A0_25.btnDevil, _UPVALUE1_)
  else
    L2_27 = CCScale9Sprite:create(_UPVALUE0_.normal)
    L3_28 = CCScale9Sprite:create(_UPVALUE0_.select)
    A0_25:removeLock(A0_25.btnDevil, _UPVALUE1_)
  end
  if L2_27 and L3_28 then
    A0_25.btnDevil:setBackgroundSpriteForState(L2_27, CCControlStateNormal)
    A0_25.btnDevil:setBackgroundSpriteForState(L3_28, CCControlStateHighlighted)
  end
end
function prototype.onLockMenpai(A0_29)
  local L1_30, L2_31, L3_32
  L1_30 = Logic
  L2_31 = L1_30
  L1_30 = L1_30.Get
  L3_32 = "Lock"
  L1_30 = L1_30(L2_31, L3_32)
  L2_31 = L1_30
  L1_30 = L1_30.checkStatusById
  L3_32 = "MENPAI"
  L1_30 = L1_30(L2_31, L3_32)
  L2_31, L3_32 = nil, nil
  if L1_30 then
    L2_31 = CCScale9Sprite:create(Logic.Home.ITEM_BG_IMG.btnBang.disable)
    L3_32 = CCScale9Sprite:create(Logic.Home.ITEM_BG_IMG.btnBang.disable)
    A0_29:addLock(A0_29.btnCompose, _UPVALUE0_)
  else
    L2_31 = CCScale9Sprite:create(Logic.Home.ITEM_BG_IMG.btnBang.normal)
    L3_32 = CCScale9Sprite:create(Logic.Home.ITEM_BG_IMG.btnBang.select)
    A0_29:removeLock(A0_29.btnCompose, _UPVALUE0_)
  end
  if L2_31 and L3_32 then
    A0_29.btnCompose:setBackgroundSpriteForState(L2_31, CCControlStateNormal)
    A0_29.btnCompose:setBackgroundSpriteForState(L3_32, CCControlStateHighlighted)
  end
end
function prototype.onLockFabao(A0_33)
  A0_33:lockBtn("TALISMAN", "btnTail", A0_33.btnAchievement, _UPVALUE0_)
end
function prototype.lockBtn(A0_34, A1_35, A2_36, A3_37, A4_38)
  local L5_39, L6_40, L7_41, L8_42, L9_43, L10_44, L11_45
  if not A1_35 or not A2_36 or not A3_37 or not A4_38 then
    return
  end
  L5_39 = Logic
  L6_40 = L5_39
  L5_39 = L5_39.Get
  L7_41 = "Home"
  L5_39 = L5_39(L6_40, L7_41)
  L6_40 = L5_39
  L5_39 = L5_39.GetBtnPos
  L7_41 = A3_37
  L7_41 = L5_39(L6_40, L7_41)
  if L5_39 ~= A1_35 then
    return
  end
  L8_42 = A0_34[L7_41]
  L9_43 = Logic
  L10_44 = L9_43
  L9_43 = L9_43.Get
  L11_45 = "Lock"
  L9_43 = L9_43(L10_44, L11_45)
  L10_44 = L9_43
  L9_43 = L9_43.checkStatusById
  L11_45 = A2_36
  L9_43 = L9_43(L10_44, L11_45)
  L10_44, L11_45 = nil, nil
  if L9_43 then
    L10_44 = CCScale9Sprite:create(Logic.Home.ITEM_BG_IMG[A3_37].disable)
    L11_45 = CCScale9Sprite:create(Logic.Home.ITEM_BG_IMG[A3_37].disable)
    A0_34:addLock(L8_42, A4_38)
  else
    L10_44 = CCScale9Sprite:create(Logic.Home.ITEM_BG_IMG[A3_37].normal)
    L11_45 = CCScale9Sprite:create(Logic.Home.ITEM_BG_IMG[A3_37].select)
    A0_34:removeLock(L8_42, A4_38)
  end
  if L10_44 and L11_45 then
    L8_42:setBackgroundSpriteForState(L10_44, CCControlStateNormal)
    L8_42:setBackgroundSpriteForState(L11_45, CCControlStateHighlighted)
  end
end
function prototype.showLockTip(A0_46, A1_47, A2_48)
  local L3_49
  if nil ~= A2_48 and "" ~= A2_48 then
    L3_49 = TwGetStr
    L3_49 = L3_49(105403, A1_47)
    L3_49 = L3_49 .. "\n" .. TwGetStr(105401, A2_48)
    Prompt:PopTip(L3_49)
  else
    L3_49 = Prompt
    L3_49 = L3_49.PopTip
    L3_49(L3_49, TwGetStr(105402, A1_47))
  end
end
function prototype.closeLockTip(A0_50, A1_51)
  if A1_51 == CCControlEventTouchUpOutside or A1_51 == CCControlEventTouchUpInside or A1_51 == CCControlEventTouchCancel then
    Logic:Get("SureConfirm"):FireEvent(Logic.SureConfirm.EVT.CLOSE_POPTIP)
  end
end
function prototype.addLock(A0_52, A1_53, A2_54, A3_55)
  local L4_56, L5_57, L6_58, L7_59
  if A1_53 and A2_54 then
    L5_57 = A1_53
    L4_56 = A1_53.getChildByTag
    L6_58 = A2_54
    L4_56 = L4_56(L5_57, L6_58)
    if L4_56 ~= nil then
      return
    end
    if A3_55 then
      L5_57 = CCSprite
      L6_58 = L5_57
      L5_57 = L5_57.create
      L7_59 = A3_55
      L5_57 = L5_57(L6_58, L7_59)
    elseif not L5_57 then
      L5_57 = CCSprite
      L6_58 = L5_57
      L5_57 = L5_57.create
      L7_59 = _UPVALUE0_
      L5_57 = L5_57(L6_58, L7_59)
    end
    if nil == L5_57 then
      return
    end
    L7_59 = L5_57
    L6_58 = L5_57.setAnchorPoint
    L6_58(L7_59, CCPoint(0.5, 0.5))
    L7_59 = A1_53
    L6_58 = A1_53.getContentSize
    L6_58 = L6_58(L7_59)
    L6_58 = L6_58.width
    L6_58 = L6_58 / 2
    L7_59 = A1_53.getContentSize
    L7_59 = L7_59(A1_53)
    L7_59 = L7_59.height
    L7_59 = L7_59 / 2
    L5_57:setPosition(ccp(L6_58, L7_59))
    A1_53:addChild(L5_57, 10, A2_54)
  end
end
function prototype.removeLock(A0_60, A1_61, A2_62)
  if A1_61 and A2_62 and A1_61:getChildByTag(A2_62) ~= nil then
    A1_61:removeChildByTag(A2_62, true)
  end
end
function prototype.ChangeDevilIcon(A0_63)
  local L1_64, L2_65
  if Logic:Get("Devil"):checkNewDemogAct() then
    L1_64 = CCScale9Sprite:create(_UPVALUE0_.EPIC_NORMAL)
    L2_65 = CCScale9Sprite:create(_UPVALUE0_.EPIC_SELECT)
  else
    L1_64 = CCScale9Sprite:create(_UPVALUE0_.normal)
    L2_65 = CCScale9Sprite:create(_UPVALUE0_.select)
  end
  if L1_64 and L2_65 then
    A0_63.btnDevil:setBackgroundSpriteForState(L1_64, CCControlStateNormal)
    A0_63.btnDevil:setBackgroundSpriteForState(L2_65, CCControlStateHighlighted)
  end
end
function prototype.updateGuide(A0_66)
  if A0_66.opening or not Logic:Get("Guide"):isGuiding() then
    return
  end
  if Logic:Get("Guide"):isActive("Achievement", "Start") then
    Logic:Get("Achievement"):setGuideAchieve(true)
  end
  if Logic:Get("Guide"):isActive("Achievement", "Start") then
    A0_66:guideLockBtnItem("Achievement", "btnAchievement")
  end
  if Logic:Get("Guide"):isActive("Activity", "Start") then
    A0_66:guideLockBtnItem("Activity", "btnActivity")
  end
  if Logic:Get("Guide"):isActive("Treasure", "Start") then
    A0_66:guideLockBtnItem("Treasure", "btnSkill")
  end
  if Logic:Get("Guide"):isActive("EquipEquip", "Start") then
    A0_66:guideLockBtnItem("EquipEquip", "btnArmor")
  end
  if Logic:Get("Guide"):isActive("EquipFetterOne", "Start") and not SceneHelper:isExistScene("ArmorMain") then
    SceneHelper:runWithScene("ArmorMain", A0_66.rootNode)
    Logic:Get("PlayerInfo"):FireEvent(Logic.PlayerInfo.EVT.CHECK_MAINBTN_STATE, false)
  end
  Logic:Get("Guide"):lockTouch("Talisman", "Start", A0_66.btnAchievement)
  if Logic:Get("Guide"):isActive("TreasureDraw", "Start") and not SceneHelper:isExistScene("Treasure") then
    SceneHelper:runWithScene("Treasure", A0_66.rootNode)
    Logic:Get("PlayerInfo"):FireEvent(Logic.PlayerInfo.EVT.CHECK_MAINBTN_STATE, false)
  end
  if Logic:Get("Guide"):isActive("SkillUpgrade", "Start") and not SceneHelper:isExistScene("Treasure") then
    SceneHelper:runWithScene("Treasure", A0_66.rootNode)
    Logic:Get("PlayerInfo"):FireEvent(Logic.PlayerInfo.EVT.CHECK_MAINBTN_STATE, false)
  end
  if Logic:Get("Guide"):isActive("TalismanDraw", "Start") and not SceneHelper:isExistScene("FabaoLookFor") then
    SceneHelper:runWithScene("FabaoLookFor", A0_66.rootNode)
    Logic:Get("PlayerInfo"):FireEvent(Logic.PlayerInfo.EVT.CHECK_MAINBTN_STATE, false)
  end
  if Logic:Get("Guide"):isActive("TalismanEquip", "Start") and not SceneHelper:isExistScene("FabaoHome") then
    SceneHelper:runWithScene("FabaoHome", A0_66.rootNode)
    Logic:Get("PlayerInfo"):FireEvent(Logic.PlayerInfo.EVT.CHECK_MAINBTN_STATE, false)
  end
end
function prototype.guideLockBtnItem(A0_67, A1_68, A2_69)
  if Logic:Get("Home"):GetBtnPos(A2_69) == nil then
    return
  end
  Logic:Get("Guide"):lockTouch(A1_68, "Start", A0_67[Logic:Get("Home"):GetBtnPos(A2_69)])
end
function prototype.updateGuideDra(A0_70)
  Logic:Get("Guide"):lockTouch("EquipEquip", "Start", A0_70.btnDevil)
end
function prototype.NewTip(A0_71, A1_72)
  A0_71.btnStop = true
  A0_71:onNewFriend(A1_72)
  A0_71:OnGotNewDemog(A1_72)
  A0_71:OnGotNewGhost(A1_72)
  A0_71:onNewAchievement(A1_72)
end
function prototype.onNewFriend(A0_73, A1_74)
  local L2_75, L3_76, L4_77, L5_78, L6_79
  L2_75 = Logic
  L3_76 = L2_75
  L2_75 = L2_75.Get
  L4_77 = "Home"
  L2_75 = L2_75(L3_76, L4_77)
  L3_76 = L2_75
  L2_75 = L2_75.GetBtnPos
  L4_77 = "btnReward"
  L4_77 = L2_75(L3_76, L4_77)
  if L2_75 ~= A1_74 then
    return
  end
  L5_78 = A0_73.btnStop
  if L5_78 then
    L5_78 = Logic
    L6_79 = L5_78
    L5_78 = L5_78.Get
    L5_78 = L5_78(L6_79, "Friend")
    L6_79 = L5_78
    L5_78 = L5_78.GetFriendPrompt
    L5_78 = L5_78(L6_79)
    if L5_78 then
      L5_78 = NEW_TIP
      L5_78 = L5_78[L3_76]
      L5_78 = A0_73[L5_78]
      L6_79 = L5_78
      L5_78 = L5_78.setVisible
      L5_78(L6_79, true)
      L5_78 = NEW_TIP
      L5_78 = L5_78[L3_76]
      L5_78 = A0_73[L5_78]
      L6_79 = L5_78
      L5_78 = L5_78.setAnchorPoint
      L5_78(L6_79, CCPoint(0.5, 0.5))
      L5_78 = NEW_TIP
      L5_78 = L5_78[L3_76]
      L5_78 = A0_73[L5_78]
      L6_79 = L5_78
      L5_78 = L5_78.getPositionX
      L5_78 = L5_78(L6_79)
      L6_79 = NEW_TIP
      L6_79 = L6_79[L3_76]
      L6_79 = A0_73[L6_79]
      L6_79 = L6_79.getPositionY
      L6_79 = L6_79(L6_79)
      if A0_73.ani1 == nil then
        A0_73.ani1 = Logic:Get("AniMgr"):RunCCBAni("UI/uinew", A0_73, ccp(L5_78, L6_79), 0.9)
      end
    end
  else
    L5_78 = A0_73.ani1
    if L5_78 then
      L5_78 = A0_73.ani1
      L6_79 = L5_78
      L5_78 = L5_78.RemoveAnimation
      L5_78(L6_79)
      A0_73.ani1 = nil
    end
    L5_78 = NEW_TIP
    L5_78 = L5_78[L3_76]
    L5_78 = A0_73[L5_78]
    L6_79 = L5_78
    L5_78 = L5_78.setVisible
    L5_78(L6_79, false)
  end
end
function prototype.OnShowFullCardTip(A0_80)
  local L1_81
  L1_81 = A0_80.imgFullCard
  L1_81 = L1_81.removeAllChildrenWithCleanup
  L1_81(L1_81, true)
  L1_81 = Logic
  L1_81 = L1_81.Get
  L1_81 = L1_81(L1_81, "Hero")
  L1_81 = L1_81.IsBagEnough
  L1_81 = L1_81(L1_81)
  if L1_81 then
    Logic:Get("AniMgr"):RunCCBAni("UI/uinew", A0_80.imgFullCard, nil, 1, nil, nil, nil, -1)
  end
  A0_80.imgFullCard:setVisible(L1_81)
end
function prototype.onNewCompose(A0_82)
  local L1_83
  L1_83 = A0_82.imgNewCompose
  L1_83 = L1_83.removeAllChildrenWithCleanup
  L1_83(L1_83, true)
  L1_83 = Logic
  L1_83 = L1_83.Get
  L1_83 = L1_83(L1_83, "Compose")
  L1_83 = L1_83.GetHasCompose
  L1_83 = L1_83(L1_83)
  if L1_83 then
    Logic:Get("AniMgr"):RunCCBAni("UI/uinew", A0_82.imgNewCompose, nil, 1, nil, nil, nil, -1)
  end
  A0_82.imgNewCompose:setVisible(L1_83)
end
function prototype.onNewMenpai(A0_84, A1_85)
  A0_84[NEW_TIP[Logic:Get("Home"):GetBtnPos("btnAchievement")]]:removeAllChildrenWithCleanup(true)
  if Logic:Get("Home"):GetBtnPos("btnAchievement") ~= A1_85 then
    return
  end
  if Logic:Get("Sect"):IsPrayNew() then
    Logic:Get("AniMgr"):RunCCBAni("UI/uinew", A0_84[NEW_TIP[Logic:Get("Home"):GetBtnPos("btnAchievement")]], nil, 1, nil, nil, nil, -1)
    A0_84[NEW_TIP[Logic:Get("Home"):GetBtnPos("btnAchievement")]]:setVisible(true)
  end
end
function prototype.onNewAchievement(A0_86, A1_87)
  local L2_88, L3_89, L4_90, L5_91, L6_92, L7_93
  L2_88 = Logic
  L3_89 = L2_88
  L2_88 = L2_88.Get
  L4_90 = "Home"
  L2_88 = L2_88(L3_89, L4_90)
  L3_89 = L2_88
  L2_88 = L2_88.GetBtnPos
  L4_90 = "btnAchievement"
  L4_90 = L2_88(L3_89, L4_90)
  if L2_88 ~= A1_87 then
    return
  end
  L5_91 = Logic
  L6_92 = L5_91
  L5_91 = L5_91.Get
  L7_93 = "Achievement"
  L5_91 = L5_91(L6_92, L7_93)
  L6_92 = L5_91
  L5_91 = L5_91.GetAchievePro
  L5_91 = L5_91(L6_92)
  if L5_91 then
    L6_92 = A0_86.achStatus
    if not L6_92 then
      L6_92 = A0_86.btnStop
      if L6_92 then
        L6_92 = NEW_TIP
        L6_92 = L6_92[L3_89]
        L6_92 = A0_86[L6_92]
        L7_93 = L6_92
        L6_92 = L6_92.setVisible
        L6_92(L7_93, true)
        L6_92 = NEW_TIP
        L6_92 = L6_92[L3_89]
        L6_92 = A0_86[L6_92]
        L7_93 = L6_92
        L6_92 = L6_92.setAnchorPoint
        L6_92(L7_93, CCPoint(0.5, 0.5))
        L6_92 = NEW_TIP
        L6_92 = L6_92[L3_89]
        L6_92 = A0_86[L6_92]
        L7_93 = L6_92
        L6_92 = L6_92.getPositionX
        L6_92 = L6_92(L7_93)
        L7_93 = NEW_TIP
        L7_93 = L7_93[L3_89]
        L7_93 = A0_86[L7_93]
        L7_93 = L7_93.getPositionY
        L7_93 = L7_93(L7_93)
        A0_86.ani2 = Logic:Get("AniMgr"):RunCCBAni("UI/uinew", A0_86, ccp(L6_92, L7_93), 0.9)
      end
    end
  else
    L6_92 = A0_86.ani2
    if L6_92 then
      L6_92 = A0_86.ani2
      L7_93 = L6_92
      L6_92 = L6_92.RemoveAnimation
      L6_92(L7_93)
    end
    L6_92 = NEW_TIP
    L6_92 = L6_92[L3_89]
    L6_92 = A0_86[L6_92]
    L7_93 = L6_92
    L6_92 = L6_92.setVisible
    L6_92(L7_93, false)
  end
end
function prototype.OnGotNewDemog(A0_94, A1_95)
  local L2_96, L3_97, L4_98, L5_99, L6_100, L7_101
  L2_96 = Logic
  L3_97 = L2_96
  L2_96 = L2_96.Get
  L4_98 = "Home"
  L2_96 = L2_96(L3_97, L4_98)
  L3_97 = L2_96
  L2_96 = L2_96.GetBtnPos
  L4_98 = "btnDevil"
  L4_98 = L2_96(L3_97, L4_98)
  if L2_96 ~= A1_95 then
    return
  end
  L5_99 = A0_94.devilStatus
  if L5_99 then
    return
  end
  L5_99 = Logic
  L6_100 = L5_99
  L5_99 = L5_99.Get
  L7_101 = "Devil"
  L5_99 = L5_99(L6_100, L7_101)
  L6_100 = L5_99
  L5_99 = L5_99.GetPushDemog
  L5_99 = L5_99(L6_100)
  if L5_99 then
    L6_100 = A0_94.imgNewDevil
    L7_101 = L6_100
    L6_100 = L6_100.setVisible
    L6_100(L7_101, true)
    L6_100 = A0_94.imgNewDevil
    L7_101 = L6_100
    L6_100 = L6_100.getPositionX
    L6_100 = L6_100(L7_101)
    L7_101 = A0_94.imgNewDevil
    L7_101 = L7_101.getPositionY
    L7_101 = L7_101(L7_101)
    if A0_94.aniDemog == nil then
      A0_94.aniDemog = Logic:Get("AniMgr"):RunCCBAni("UI/uinew", A0_94, ccp(L6_100, L7_101), 1)
    end
  else
    L6_100 = A0_94.imgNewDevil
    L7_101 = L6_100
    L6_100 = L6_100.setVisible
    L6_100(L7_101, false)
    L6_100 = A0_94.aniDemog
    if L6_100 ~= nil then
      L6_100 = A0_94.aniDemog
      L7_101 = L6_100
      L6_100 = L6_100.RemoveAnimation
      L6_100(L7_101)
      A0_94.aniDemog = nil
    end
  end
end
function prototype.OnGotNewGhost(A0_102, A1_103)
  if Logic:Get("Home"):GetBtnPos("btnBang") ~= A1_103 then
    return
  end
  A0_102[NEW_TIP[Logic:Get("Home"):GetBtnPos("btnBang")]]:setVisible(false)
  if A0_102.aniGhost ~= nil then
    A0_102.aniGhost:RemoveAnimation()
    A0_102.aniGhost = nil
  end
  if Logic:Get("Lock"):checkStatusById("MENPAI") then
    return
  end
end
function prototype.onBtnHero(A0_104, A1_105, A2_106)
  if Logic:Get("Home"):GetBtnObj(A0_104.btnItem[1]) ~= nil then
    Logic:Get("Home"):GetBtnObj(A0_104.btnItem[1]).func(A1_105, A2_106)
  end
end
function prototype.onBtnSkillCollege(A0_107, A1_108, A2_109)
  if Logic:Get("Home"):GetBtnObj(A0_107.btnItem[2]) ~= nil then
    Logic:Get("Home"):GetBtnObj(A0_107.btnItem[2]).func(A1_108, A2_109)
  end
end
function prototype.onBtnPic(A0_110, A1_111, A2_112)
  if Logic:Get("Home"):GetBtnObj(A0_110.btnItem[3]) ~= nil then
    Logic:Get("Home"):GetBtnObj(A0_110.btnItem[3]).func(A1_111, A2_112)
  end
end
function prototype.onBtnFragment(A0_113, A1_114, A2_115)
  if Logic:Get("Home"):GetBtnObj(A0_113.btnItem[4]) ~= nil then
    Logic:Get("Home"):GetBtnObj(A0_113.btnItem[4]).func(A1_114, A2_115)
  end
end
function prototype.onBtnDevil(A0_116, A1_117, A2_118)
  if Logic:Get("Home"):GetBtnObj(A0_116.btnItem[5]) ~= nil then
    Logic:Get("Home"):GetBtnObj(A0_116.btnItem[5]).func(A1_117, A2_118)
  end
end
function prototype.onBtnActivity(A0_119, A1_120, A2_121)
  if Logic:Get("Home"):GetBtnObj(A0_119.btnItem[6]) ~= nil then
    Logic:Get("Home"):GetBtnObj(A0_119.btnItem[6]).func(A1_120, A2_121)
  end
end
function prototype.onBtnFriend(A0_122, A1_123, A2_124)
  if Logic:Get("Home"):GetBtnObj(A0_122.btnItem[7]) ~= nil then
    Logic:Get("Home"):GetBtnObj(A0_122.btnItem[7]).func(A1_123, A2_124)
  end
end
function prototype.onBtnSystem(A0_125, A1_126, A2_127)
  if Logic:Get("Home"):GetBtnObj(A0_125.btnItem[8]) ~= nil then
    Logic:Get("Home"):GetBtnObj(A0_125.btnItem[8]).func(A1_126, A2_127)
  end
end
