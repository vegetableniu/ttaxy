local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = require
L0_0("BtnPosition")
L0_0 = BtnPosition
L0_0 = L0_0.prototype
L0_0 = L0_0.extend
L0_0 = L0_0(L0_0)
prototype = L0_0
L0_0 = "images/public/exp_bg.png"
function prototype.onEnter(A0_1, A1_2, A2_3)
  local L3_4, L4_5, L5_6, L6_7
  L3_4(L4_5)
  for L6_7 = 1, L4_5.MAXSWALLOW_NUM do
    A0_1[string.format("ccbHero%d", L6_7)]:setAnchorPoint(CCPoint(0, 0))
  end
  L3_4(L4_5, L5_6)
  L3_4(L4_5, L5_6)
  for L6_7 = 1, L4_5.MAXSWALLOW_NUM do
    if A0_1[string.format("ccbHero%d", L6_7)] then
      A0_1[string.format("ccbHero%d", L6_7)].imgAdd:setVisible(false)
      A0_1[string.format("ccbHero%d", L6_7)].btnHero:setEnabled(false)
      A0_1[string.format("ccbHero%d", L6_7)].btnBg:setVisible(false)
    end
  end
  L3_4(L4_5, L5_6)
  L6_7 = 104275
  L6_7 = L5_6(L6_7, 0)
  L3_4(L4_5, L5_6, L6_7, L5_6(L6_7, 0))
  L6_7 = 104276
  L6_7 = L5_6(L6_7, 0)
  L3_4(L4_5, L5_6, L6_7, L5_6(L6_7, 0))
  L6_7 = 104277
  L6_7 = L5_6(L6_7, 0)
  L3_4(L4_5, L5_6, L6_7, L5_6(L6_7, 0))
  L6_7 = 104278
  L6_7 = L5_6(L6_7, 0)
  L3_4(L4_5, L5_6, L6_7, L5_6(L6_7, 0))
  L3_4(L4_5, L5_6)
  L3_4(L4_5, L5_6)
  L6_7 = "HERO:HERO_UPGRADE_LEVEL_LIMIT"
  if L4_5 then
    L6_7 = L4_5.content
    if L3_4 < L5_6 then
      L6_7 = L5_6
      L5_6(L6_7, A0_1.btnUpgrade:getPositionX() + 130)
      L6_7 = L5_6
      L5_6(L6_7, A0_1.imgHeroUpgrade:getPositionX() + 130)
      L6_7 = L5_6
      L5_6(L6_7, false)
      L6_7 = L5_6
      L5_6(L6_7, false)
    end
  end
  A0_1.bSwallow = false
  A0_1.fullExp = 0
  A0_1.swallowHeroExp = 0
  L6_7 = L5_6
  L6_7 = L5_6
  L5_6(L6_7, Logic.Hero.EVT.SWALLOW_HERO, A0_1:Event("OnSwallowHero"))
  L6_7 = L5_6
  L6_7 = L5_6
  L5_6(L6_7, Logic.Hero.EVT.OPT_UPGRADEHERO_SET, A0_1:Event("OnOptUpgradeSet"))
  L6_7 = L5_6
  L6_7 = L5_6
  L5_6(L6_7, Logic.Hero.EVT.OPT_SWALLOWHERO_SET, A0_1:Event("OnOptSwallowSet"))
end
function prototype.bindAnimationMgr(A0_8)
  local L1_9
  L1_9 = true
  return L1_9
end
function prototype.completedAnimationSequenceNamed(A0_10, A1_11)
  if A1_11 ~= "Default Timeline" then
    return
  end
  A0_10:updateGuide()
end
function prototype.OnOptUpgradeSet(A0_12)
  local L1_13, L2_14, L3_15, L4_16, L5_17, L6_18, L7_19, L8_20, L9_21
  L1_13 = A0_12.btnUpgrade
  L2_14 = L1_13
  L1_13 = L1_13.setEnabled
  L1_13(L2_14, L3_15)
  L1_13 = A0_12.btnAutoSelect
  L2_14 = L1_13
  L1_13 = L1_13.setEnabled
  L1_13(L2_14, L3_15)
  L1_13 = Logic
  L2_14 = L1_13
  L1_13 = L1_13.Get
  L1_13 = L1_13(L2_14, L3_15)
  L2_14 = L1_13
  L1_13 = L1_13.GetUpgradeHero
  L1_13 = L1_13(L2_14)
  L2_14 = Logic
  L2_14 = L2_14.Get
  L2_14 = L2_14(L3_15, L4_16)
  L2_14 = L2_14.GetHeroInfoById
  L2_14 = L2_14(L3_15, L4_16)
  if L2_14 then
  elseif not L3_15 then
    return
  end
  A0_12.currentLevel = L3_15
  A0_12.upgrade = L2_14
  L3_15(L4_16, L5_17)
  L3_15(L4_16, L5_17)
  L3_15(L4_16)
  L3_15(L4_16, L5_17)
  L3_15(L4_16)
  for L6_18 = 1, L4_16.MAXSWALLOW_NUM do
    L7_19 = string
    L7_19 = L7_19.format
    L8_20 = "ccbHero%d"
    L9_21 = L6_18
    L7_19 = L7_19(L8_20, L9_21)
    L8_20 = A0_12[L7_19]
    if L8_20 then
      L8_20 = A0_12[L7_19]
      L8_20 = L8_20.imgAdd
      L9_21 = L8_20
      L8_20 = L8_20.setVisible
      L8_20(L9_21, true)
      L8_20 = "images/public/clarity05.png"
      if L8_20 then
        L9_21 = A0_12[L7_19]
        L9_21 = L9_21.btnHero
        L9_21 = L9_21.setBackgroundSpriteForState
        L9_21(L9_21, CCScale9Sprite:create(L8_20), CCControlStateNormal)
        L9_21 = A0_12[L7_19]
        L9_21 = L9_21.btnHero
        L9_21 = L9_21.setBackgroundSpriteForState
        L9_21(L9_21, CCScale9Sprite:create(L8_20), CCControlStateHighlighted)
        L9_21 = A0_12[L7_19]
        L9_21 = L9_21.btnHero
        L9_21 = L9_21.setBackgroundSpriteForState
        L9_21(L9_21, CCScale9Sprite:create(L8_20), CCControlStateDisabled)
        L9_21 = "images/public/clarity05.png"
        A0_12[L7_19].btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(L9_21), CCControlStateNormal)
        A0_12[L7_19].btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(L9_21), CCControlStateHighlighted)
        A0_12[L7_19].btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(L9_21), CCControlStateDisabled)
      end
      L9_21 = A0_12[L7_19]
      L9_21 = L9_21.btnHero
      L9_21 = L9_21.setEnabled
      L9_21(L9_21, true)
      L9_21 = A0_12[L7_19]
      L9_21 = L9_21.btnBg
      L9_21 = L9_21.setVisible
      L9_21(L9_21, true)
    end
  end
  if L3_15 then
    L6_18 = L3_15
    L7_19 = true
    L4_16(L5_17, L6_18, L7_19)
  end
  if L4_16 then
    L6_18 = "HeroCardInfo"
    L6_18 = L2_14.baseId
    L7_19 = 200
    L6_18 = L4_16
    L7_19 = CCPoint
    L8_20 = 0.5
    L9_21 = 0.5
    L9_21 = L7_19(L8_20, L9_21)
    L5_17(L6_18, L7_19, L8_20, L9_21, L7_19(L8_20, L9_21))
    L6_18 = L5_17
    L7_19 = L4_16
    L8_20 = 0
    L9_21 = 0
    L5_17(L6_18, L7_19, L8_20, L9_21)
    L6_18 = L5_17
    L6_18 = A0_12.btnHeroSelect
    L7_19 = L6_18
    L6_18 = L6_18.getContentSize
    L6_18 = L6_18(L7_19)
    L8_20 = L4_16
    L7_19 = L4_16.setPosition
    L9_21 = ccp
    L9_21 = L9_21(L5_17.width / 2, L5_17.height / 2)
    L7_19(L8_20, L9_21, L9_21(L5_17.width / 2, L5_17.height / 2))
  end
  L6_18 = "Hero"
  L6_18 = L2_14.baseId
  L7_19 = L2_14.level
  L6_18 = L5_17
  L7_19 = _UPVALUE0_
  L8_20 = _UPVALUE1_
  L9_21 = _UPVALUE2_
  L5_17(L6_18, L7_19, L8_20, L9_21)
  L6_18 = L5_17
  L7_19 = L2_14.exp
  L7_19 = 100 * L7_19
  L7_19 = L7_19 / L4_16
  L8_20 = false
  L9_21 = false
  L5_17(L6_18, L7_19, L8_20, L9_21, 0, 2000)
  A0_12.bSwallow = true
  L6_18 = L5_17
  L7_19 = TwGetStr
  L8_20 = 104154
  L7_19 = L7_19(L8_20)
  L8_20 = CCControlStateNormal
  L5_17(L6_18, L7_19, L8_20)
  L6_18 = L5_17
  L7_19 = TwGetStr
  L8_20 = 104154
  L7_19 = L7_19(L8_20)
  L8_20 = CCControlStateHighlighted
  L5_17(L6_18, L7_19, L8_20)
  L6_18 = L5_17
  L7_19 = TwGetStr
  L8_20 = 104154
  L7_19 = L7_19(L8_20)
  L8_20 = CCControlStateDisabled
  L5_17(L6_18, L7_19, L8_20)
  L6_18 = L5_17
  L7_19 = false
  L5_17(L6_18, L7_19)
  L6_18 = A0_12
  L5_17(L6_18)
end
function prototype.OnOptSwallowSet(A0_22)
  local L1_23, L2_24, L3_25, L4_26, L5_27, L6_28, L7_29, L8_30, L9_31, L10_32, L11_33
  L1_23 = Logic
  L2_24 = L1_23
  L1_23 = L1_23.Get
  L1_23 = L1_23(L2_24, L3_25)
  L2_24 = L1_23
  L1_23 = L1_23.GetSwallowHero
  L1_23 = L1_23(L2_24)
  if not L1_23 then
    return
  end
  L2_24 = A0_22.btnUpgrade
  L2_24 = L2_24.setEnabled
  L2_24(L3_25, L4_26)
  L2_24 = {}
  for L6_28, L7_29 in L3_25(L4_26) do
    if L7_29 then
      if L8_30 then
        L11_33 = L8_30
        L9_31(L10_32, L11_33)
      end
    end
  end
  A0_22.swallow = L2_24
  for L7_29 = 1, L5_27.MAXSWALLOW_NUM do
    if L8_30 then
      if L8_30 then
        L11_33 = false
        L9_31(L10_32, L11_33)
        L11_33 = "Hero"
        L11_33 = L2_24[L7_29]
        L11_33 = L11_33.baseId
        if L9_31 then
          L11_33 = L10_32
          L10_32(L11_33, CCScale9Sprite:create(L9_31), CCControlStateNormal)
          L11_33 = L10_32
          L10_32(L11_33, CCScale9Sprite:create(L9_31), CCControlStateHighlighted)
          L11_33 = L10_32
          L10_32(L11_33, CCScale9Sprite:create(L9_31), CCControlStateDisabled)
        end
        L11_33 = L10_32
        L11_33 = L10_32
        if L10_32 then
          L11_33 = A0_22[L8_30]
          L11_33 = L11_33.btnBg
          L11_33 = L11_33.setBackgroundSpriteForState
          L11_33(L11_33, CCScale9Sprite:create(L10_32), CCControlStateNormal)
          L11_33 = A0_22[L8_30]
          L11_33 = L11_33.btnBg
          L11_33 = L11_33.setBackgroundSpriteForState
          L11_33(L11_33, CCScale9Sprite:create(L10_32), CCControlStateHighlighted)
          L11_33 = A0_22[L8_30]
          L11_33 = L11_33.btnBg
          L11_33 = L11_33.setBackgroundSpriteForState
          L11_33(L11_33, CCScale9Sprite:create(L10_32), CCControlStateDisabled)
        end
        L11_33 = Logic
        L11_33 = L11_33.Get
        L11_33 = L11_33(L11_33, "Hero")
        L11_33 = L11_33.GetHeroSwallowExp
        L11_33 = L11_33(L11_33, L2_24[L7_29].baseId, L2_24[L7_29].level)
        if L11_33 then
          A0_22.swallowExp = L3_25
        end
      end
    else
      L11_33 = true
      L9_31(L10_32, L11_33)
      if L9_31 then
        L11_33 = L10_32
        L10_32(L11_33, CCScale9Sprite:create(L9_31), CCControlStateNormal)
        L11_33 = L10_32
        L10_32(L11_33, CCScale9Sprite:create(L9_31), CCControlStateHighlighted)
        L11_33 = L10_32
        L10_32(L11_33, CCScale9Sprite:create(L9_31), CCControlStateDisabled)
      end
      L11_33 = A0_22[L8_30]
      L11_33 = L11_33.btnBg
      L11_33 = L11_33.setBackgroundSpriteForState
      L11_33(L11_33, CCScale9Sprite:create(L10_32), CCControlStateNormal)
      L11_33 = A0_22[L8_30]
      L11_33 = L11_33.btnBg
      L11_33 = L11_33.setBackgroundSpriteForState
      L11_33(L11_33, CCScale9Sprite:create(L10_32), CCControlStateHighlighted)
      L11_33 = A0_22[L8_30]
      L11_33 = L11_33.btnBg
      L11_33 = L11_33.setBackgroundSpriteForState
      L11_33(L11_33, CCScale9Sprite:create(L10_32), CCControlStateDisabled)
    end
  end
  L7_29 = L6_28
  L7_29 = L6_28
  L11_33 = L6_28(L7_29)
  L7_29 = "Hero"
  L7_29 = L4_26.baseId
  if L5_27 then
    L7_29 = L5_27.level
    if L6_28 == L7_29 then
      return
    end
  end
  if L4_26 then
    L7_29 = L6_28
    L7_29 = L6_28
    L7_29 = L4_26.exp
    L7_29 = L6_28 - L7_29
    if L3_25 < L7_29 then
      L7_29 = A0_22.ccbInfoView
      L7_29 = L7_29.SetNextLevel
      L7_29(L8_30, L9_31)
      L7_29 = A0_22.ccbInfoView
      L7_29 = L7_29.RefreshInfo
      L7_29(L8_30, L9_31, L10_32)
      L7_29 = A0_22.prgTest
      L7_29 = L7_29.setVisible
      L7_29(L8_30, L9_31, L10_32)
      L7_29 = A0_22.prgTest
      L7_29 = L7_29.setValue
      L11_33 = false
      L7_29(L8_30, L9_31, L10_32, L11_33, 0, 2000)
      L7_29 = A0_22.prgTest
      L7_29 = L7_29.setValue
      L11_33 = false
      L7_29(L8_30, L9_31, L10_32, L11_33, 0, 3000)
      L7_29 = A0_22.prgTest
      L7_29 = L7_29.twinkleProgress
      L7_29(L8_30, L9_31, L10_32)
    else
      L7_29 = A0_22.prgTest
      L7_29 = L7_29.setVisible
      L7_29(L8_30, L9_31, L10_32)
      L7_29 = A0_22.prgTest
      L7_29 = L7_29.setValue
      L11_33 = false
      L7_29(L8_30, L9_31, L10_32, L11_33, 0, 2000)
      L7_29 = A0_22.prgTest
      L7_29 = L7_29.setValue
      L11_33 = false
      L7_29(L8_30, L9_31, L10_32, L11_33, 0, 3000)
      L7_29 = A0_22.prgTest
      L7_29 = L7_29.twinkleProgress
      L7_29(L8_30, L9_31, L10_32)
      L7_29 = 0
      for L11_33 = L4_26.level, L9_31(L10_32) do
        L7_29 = L7_29 + Logic:Get("Hero"):GetHeroNextExp(L4_26.baseId, L11_33)
        if L7_29 == L3_25 then
          A0_22.ccbInfoView:SetNextLevel(L11_33 + 1)
          A0_22.ccbInfoView:RefreshInfo(true, L11_33 + 1)
        elseif L3_25 < L7_29 and Logic:Get("Hero"):GetHeroInfoByBaseId(L4_26.baseId) and Logic:Get("Hero"):GetHeroInfoByBaseId(L4_26.baseId).level then
          if L11_33 > Logic:Get("Hero"):GetHeroInfoByBaseId(L4_26.baseId).level then
            A0_22.ccbInfoView:SetNextLevel(Logic:Get("Hero"):GetHeroInfoByBaseId(L4_26.baseId).level)
            A0_22.ccbInfoView:RefreshInfo(true, Logic:Get("Hero"):GetHeroInfoByBaseId(L4_26.baseId).level)
            break
          end
          A0_22.ccbInfoView:SetNextLevel(L11_33)
          A0_22.ccbInfoView:RefreshInfo(true, L11_33)
          break
        end
        if L11_33 == KFDBGetRecordAmt("HeroLevelConfig") and L3_25 > L7_29 then
          A0_22.ccbInfoView:SetNextLevel(Logic:Get("Hero"):GetHeroInfoByBaseId(L4_26.baseId).level)
          A0_22.ccbInfoView:RefreshInfo(true, Logic:Get("Hero"):GetHeroInfoByBaseId(L4_26.baseId).level)
        end
      end
    end
  end
  L7_29 = L6_28
  L6_28(L7_29, L8_30)
  L7_29 = L6_28
  L6_28(L7_29, L8_30)
  L7_29 = L6_28
  L6_28(L7_29)
  L7_29 = A0_22
  L6_28(L7_29)
end
function prototype.OnSwallowHero(A0_34, A1_35)
  local L2_36, L3_37, L4_38, L5_39, L6_40, L7_41, L8_42, L9_43, L10_44, L11_45, L12_46, L13_47
  L2_36(L3_37, L4_38)
  L2_36(L3_37)
  L2_36(L3_37, L4_38)
  L2_36(L3_37, L4_38)
  L2_36(L3_37)
  for L5_39 = 1, L3_37.MAXSWALLOW_NUM do
    if L7_41 then
      L9_43 = true
      L7_41(L8_42, L9_43)
      L9_43 = true
      L7_41(L8_42, L9_43)
      L9_43 = true
      L7_41(L8_42, L9_43)
    end
  end
  L2_36(L3_37)
  if A1_35 then
    L5_39 = A1_35.level
    if L2_36 ~= 0 then
      L5_39 = false
      L3_37(L4_38, L5_39, L6_40)
      L5_39 = A1_35.exp
      L5_39 = 100 * L5_39
      L5_39 = L5_39 / L2_36
      L3_37(L4_38, L5_39)
    else
      L5_39 = false
      L3_37(L4_38, L5_39, L6_40)
      L5_39 = 0
      L3_37(L4_38, L5_39)
    end
  end
  if not L2_36 then
    if A1_35 then
      A0_34.upgrade = A1_35
    end
    L2_36(L3_37)
    return
  end
  L5_39 = "AniMgr"
  L5_39 = "UI/uiyxsj"
  A0_34.ani = L3_37
  L5_39 = "imgLevelTip"
  L5_39 = false
  L3_37(L4_38, L5_39)
  L5_39 = "staLevel"
  L5_39 = false
  L3_37(L4_38, L5_39)
  L5_39 = "imgAttackTip"
  L5_39 = false
  L3_37(L4_38, L5_39)
  L5_39 = "staAttack"
  L5_39 = false
  L3_37(L4_38, L5_39)
  L5_39 = "imgLifeTip"
  L5_39 = false
  L3_37(L4_38, L5_39)
  L5_39 = "staLife"
  L5_39 = false
  L3_37(L4_38, L5_39)
  L5_39 = "imgBg1"
  L5_39 = false
  L3_37(L4_38, L5_39)
  L5_39 = "imgBg2"
  L5_39 = false
  L3_37(L4_38, L5_39)
  L5_39 = "imgBg3"
  L5_39 = false
  L3_37(L4_38, L5_39)
  L5_39 = "HeroCardInfo"
  L5_39 = A0_34.upgrade
  L5_39 = L5_39.baseId
  L5_39 = L4_38
  L5_39 = L4_38
  L13_47 = L7_41(L8_42)
  L5_39 = L4_38(L5_39, L6_40, L7_41, L8_42, L9_43, L10_44, L11_45, L12_46, L13_47, L7_41(L8_42))
  L6_40(L7_41, L8_42)
  L6_40(L7_41, L8_42)
  for L9_43 = 1, 6 do
    L10_44 = string
    L10_44 = L10_44.format
    L11_45 = "imgHero%d"
    L12_46 = L9_43
    L10_44 = L10_44(L11_45, L12_46)
    L11_45 = A0_34.swallow
    L11_45 = L11_45[L9_43]
    if L11_45 then
      L11_45 = A0_34.ani
      L12_46 = L11_45
      L11_45 = L11_45.GetChild
      L13_47 = L10_44
      L11_45 = L11_45(L12_46, L13_47)
      L12_46 = L11_45
      L11_45 = L11_45.setVisible
      L13_47 = true
      L11_45(L12_46, L13_47)
      L11_45 = Logic
      L12_46 = L11_45
      L11_45 = L11_45.Get
      L13_47 = "HeroCardInfo"
      L11_45 = L11_45(L12_46, L13_47)
      L12_46 = L11_45
      L11_45 = L11_45.createHeroCardForByFight
      L13_47 = A0_34.swallow
      L13_47 = L13_47[L9_43]
      L13_47 = L13_47.baseId
      L11_45 = L11_45(L12_46, L13_47)
      L12_46 = Logic
      L13_47 = L12_46
      L12_46 = L12_46.Get
      L12_46 = L12_46(L13_47, "HeroCardInfo")
      L13_47 = L12_46
      L12_46 = L12_46.GetCardTexture
      L13_47 = L12_46(L13_47, L11_45, A0_34.ani:GetChild(L10_44):getContentSize())
      A0_34.ani:GetChild(L10_44):setTexture(L12_46)
      A0_34.ani:GetChild(L10_44):setTextureRect(L13_47)
    else
      L11_45 = A0_34.ani
      L12_46 = L11_45
      L11_45 = L11_45.GetChild
      L13_47 = L10_44
      L11_45 = L11_45(L12_46, L13_47)
      L12_46 = L11_45
      L11_45 = L11_45.setVisible
      L13_47 = false
      L11_45(L12_46, L13_47)
    end
  end
  L9_43 = "HeroCardInfo"
  L9_43 = L6_40
  L11_45 = L6_40
  L10_44 = L6_40.getContentSize
  L13_47 = L10_44(L11_45)
  L9_43 = A0_34.ani
  L10_44 = L9_43
  L9_43 = L9_43.GetChild
  L11_45 = "imgOut"
  L9_43 = L9_43(L10_44, L11_45)
  L10_44 = L9_43
  L9_43 = L9_43.setTexture
  L11_45 = L7_41
  L9_43(L10_44, L11_45)
  L9_43 = A0_34.ani
  L10_44 = L9_43
  L9_43 = L9_43.GetChild
  L11_45 = "imgOut"
  L9_43 = L9_43(L10_44, L11_45)
  L10_44 = L9_43
  L9_43 = L9_43.setTextureRect
  L11_45 = L8_42
  L9_43(L10_44, L11_45)
  L9_43 = A0_34.ani
  L10_44 = L9_43
  L9_43 = L9_43.SetCloseCallback
  L11_45 = A0_34
  L12_46 = A0_34.onBtnCloseAni
  L9_43(L10_44, L11_45, L12_46)
  L9_43 = A0_34.ani
  L10_44 = L9_43
  L9_43 = L9_43.GetChild
  L11_45 = "btnClose"
  L9_43 = L9_43(L10_44, L11_45)
  L10_44 = L9_43
  L9_43 = L9_43.setEnabled
  L11_45 = false
  L9_43(L10_44, L11_45)
  L9_43 = A0_34.ani
  L10_44 = L9_43
  L9_43 = L9_43.SetWaitSignByDefaultAniName
  function L11_45()
    local L0_48, L1_49, L2_50, L3_51, L4_52, L5_53
    L0_48 = _UPVALUE0_
    L0_48 = L0_48.ani
    L1_49 = L0_48
    L0_48 = L0_48.GetChild
    L2_50 = "btnClose"
    L0_48 = L0_48(L1_49, L2_50)
    L1_49 = L0_48
    L0_48 = L0_48.setEnabled
    L2_50 = false
    L0_48(L1_49, L2_50)
    L0_48 = Logic
    L1_49 = L0_48
    L0_48 = L0_48.Get
    L2_50 = "BGSound"
    L0_48 = L0_48(L1_49, L2_50)
    L1_49 = L0_48
    L0_48 = L0_48.PlayEffect
    L2_50 = "audio/heroupgrade.mp3"
    L0_48(L1_49, L2_50)
    L0_48 = _UPVALUE0_
    L0_48 = L0_48.ani
    L1_49 = L0_48
    L0_48 = L0_48.GetChild
    L2_50 = "prgExp"
    L0_48 = L0_48(L1_49, L2_50)
    L1_49 = L0_48
    L0_48 = L0_48.createProgress
    L2_50 = _UPVALUE1_
    L3_51 = _UPVALUE2_
    L0_48(L1_49, L2_50, L3_51)
    L0_48 = _UPVALUE0_
    L0_48 = L0_48.ani
    L1_49 = L0_48
    L0_48 = L0_48.GetChild
    L2_50 = "imgLevelTip"
    L0_48 = L0_48(L1_49, L2_50)
    L1_49 = L0_48
    L0_48 = L0_48.setVisible
    L2_50 = true
    L0_48(L1_49, L2_50)
    L0_48 = _UPVALUE0_
    L0_48 = L0_48.ani
    L1_49 = L0_48
    L0_48 = L0_48.GetChild
    L2_50 = "staLevel"
    L0_48 = L0_48(L1_49, L2_50)
    L1_49 = L0_48
    L0_48 = L0_48.setVisible
    L2_50 = true
    L0_48(L1_49, L2_50)
    L0_48 = _UPVALUE0_
    L0_48 = L0_48.ani
    L1_49 = L0_48
    L0_48 = L0_48.GetChild
    L2_50 = "imgAttackTip"
    L0_48 = L0_48(L1_49, L2_50)
    L1_49 = L0_48
    L0_48 = L0_48.setVisible
    L2_50 = true
    L0_48(L1_49, L2_50)
    L0_48 = _UPVALUE0_
    L0_48 = L0_48.ani
    L1_49 = L0_48
    L0_48 = L0_48.GetChild
    L2_50 = "staAttack"
    L0_48 = L0_48(L1_49, L2_50)
    L1_49 = L0_48
    L0_48 = L0_48.setVisible
    L2_50 = true
    L0_48(L1_49, L2_50)
    L0_48 = _UPVALUE0_
    L0_48 = L0_48.ani
    L1_49 = L0_48
    L0_48 = L0_48.GetChild
    L2_50 = "imgLifeTip"
    L0_48 = L0_48(L1_49, L2_50)
    L1_49 = L0_48
    L0_48 = L0_48.setVisible
    L2_50 = true
    L0_48(L1_49, L2_50)
    L0_48 = _UPVALUE0_
    L0_48 = L0_48.ani
    L1_49 = L0_48
    L0_48 = L0_48.GetChild
    L2_50 = "staLife"
    L0_48 = L0_48(L1_49, L2_50)
    L1_49 = L0_48
    L0_48 = L0_48.setVisible
    L2_50 = true
    L0_48(L1_49, L2_50)
    L0_48 = _UPVALUE0_
    L0_48 = L0_48.ani
    L1_49 = L0_48
    L0_48 = L0_48.GetChild
    L2_50 = "imgBg1"
    L0_48 = L0_48(L1_49, L2_50)
    L1_49 = L0_48
    L0_48 = L0_48.setVisible
    L2_50 = true
    L0_48(L1_49, L2_50)
    L0_48 = _UPVALUE0_
    L0_48 = L0_48.ani
    L1_49 = L0_48
    L0_48 = L0_48.GetChild
    L2_50 = "imgBg2"
    L0_48 = L0_48(L1_49, L2_50)
    L1_49 = L0_48
    L0_48 = L0_48.setVisible
    L2_50 = true
    L0_48(L1_49, L2_50)
    L0_48 = _UPVALUE0_
    L0_48 = L0_48.ani
    L1_49 = L0_48
    L0_48 = L0_48.GetChild
    L2_50 = "imgBg3"
    L0_48 = L0_48(L1_49, L2_50)
    L1_49 = L0_48
    L0_48 = L0_48.setVisible
    L2_50 = true
    L0_48(L1_49, L2_50)
    L0_48 = _UPVALUE0_
    L0_48 = L0_48.ani
    L1_49 = L0_48
    L0_48 = L0_48.GetChild
    L2_50 = "imgGai"
    L0_48 = L0_48(L1_49, L2_50)
    L1_49 = L0_48
    L0_48 = L0_48.setVisible
    L2_50 = false
    L0_48(L1_49, L2_50)
    L0_48 = _UPVALUE0_
    L0_48 = L0_48.ani
    L1_49 = L0_48
    L0_48 = L0_48.GetChild
    L2_50 = "imgBody"
    L0_48 = L0_48(L1_49, L2_50)
    L1_49 = L0_48
    L0_48 = L0_48.setVisible
    L2_50 = false
    L0_48(L1_49, L2_50)
    L0_48 = Logic
    L1_49 = L0_48
    L0_48 = L0_48.Get
    L2_50 = "Hero"
    L0_48 = L0_48(L1_49, L2_50)
    L1_49 = L0_48
    L0_48 = L0_48.GetHeroNextExp
    L2_50 = _UPVALUE0_
    L2_50 = L2_50.upgrade
    L2_50 = L2_50.baseId
    L3_51 = _UPVALUE0_
    L3_51 = L3_51.upgrade
    L3_51 = L3_51.level
    L0_48 = L0_48(L1_49, L2_50, L3_51)
    L1_49 = Logic
    L2_50 = L1_49
    L1_49 = L1_49.Get
    L3_51 = "Hero"
    L1_49 = L1_49(L2_50, L3_51)
    L2_50 = L1_49
    L1_49 = L1_49.GetHeroNextExp
    L3_51 = _UPVALUE3_
    L3_51 = L3_51.baseId
    L4_52 = _UPVALUE3_
    L4_52 = L4_52.level
    L1_49 = L1_49(L2_50, L3_51, L4_52)
    L2_50 = _UPVALUE0_
    L2_50 = L2_50.ani
    L3_51 = L2_50
    L2_50 = L2_50.GetChild
    L4_52 = "prgExp"
    L2_50 = L2_50(L3_51, L4_52)
    L3_51 = L2_50
    L2_50 = L2_50.setMoveCallBack
    L4_52 = bind
    L5_53 = _UPVALUE0_
    L5_53 = L5_53.SetLv
    L5_53 = L4_52(L5_53, _UPVALUE0_)
    L2_50(L3_51, L4_52, L5_53, L4_52(L5_53, _UPVALUE0_))
    L2_50 = _UPVALUE0_
    L3_51 = _UPVALUE0_
    L3_51 = L3_51.upgrade
    L3_51 = L3_51.level
    L2_50.bgLv = L3_51
    L2_50 = _UPVALUE0_
    L2_50 = L2_50.upgrade
    L2_50 = L2_50.exp
    L2_50 = L0_48 - L2_50
    L3_51 = _UPVALUE0_
    L3_51 = L3_51.swallowExp
    if L2_50 > L3_51 then
      L2_50 = Logic
      L3_51 = L2_50
      L2_50 = L2_50.Get
      L4_52 = "Hero"
      L2_50 = L2_50(L3_51, L4_52)
      L3_51 = L2_50
      L2_50 = L2_50.GetHeroLifeAndAttack
      L4_52 = _UPVALUE3_
      L4_52 = L4_52.baseId
      L5_53 = _UPVALUE3_
      L5_53 = L5_53.level
      L3_51 = L2_50(L3_51, L4_52, L5_53)
      L4_52 = _UPVALUE0_
      L4_52 = L4_52.ani
      L5_53 = L4_52
      L4_52 = L4_52.GetChild
      L4_52 = L4_52(L5_53, "staAttack")
      L5_53 = L4_52
      L4_52 = L4_52.create
      L4_52(L5_53, L3_51)
      L4_52 = _UPVALUE0_
      L4_52 = L4_52.ani
      L5_53 = L4_52
      L4_52 = L4_52.GetChild
      L4_52 = L4_52(L5_53, "staLife")
      L5_53 = L4_52
      L4_52 = L4_52.create
      L4_52(L5_53, L2_50)
      L4_52 = _UPVALUE0_
      L4_52 = L4_52.ani
      L5_53 = L4_52
      L4_52 = L4_52.GetChild
      L4_52 = L4_52(L5_53, "staLevel")
      L5_53 = L4_52
      L4_52 = L4_52.create
      L4_52(L5_53, _UPVALUE3_.level)
      L4_52 = _UPVALUE0_
      L4_52 = L4_52.ani
      L5_53 = L4_52
      L4_52 = L4_52.GetChild
      L4_52 = L4_52(L5_53, "prgExp")
      L5_53 = L4_52
      L4_52 = L4_52.setValue
      L4_52(L5_53, 100 * _UPVALUE0_.upgrade.exp / L0_48)
      L4_52 = _UPVALUE0_
      L4_52 = L4_52.ani
      L5_53 = L4_52
      L4_52 = L4_52.GetChild
      L4_52 = L4_52(L5_53, "prgExp")
      L5_53 = L4_52
      L4_52 = L4_52.setValue
      L4_52(L5_53, 100 * _UPVALUE3_.exp / L1_49, true, 0, 1000)
      L4_52 = _UPVALUE0_
      L5_53 = _UPVALUE3_
      L4_52.upgrade = L5_53
    else
      L2_50 = Logic
      L3_51 = L2_50
      L2_50 = L2_50.Get
      L4_52 = "Hero"
      L2_50 = L2_50(L3_51, L4_52)
      L3_51 = L2_50
      L2_50 = L2_50.GetHeroLifeAndAttack
      L4_52 = _UPVALUE0_
      L4_52 = L4_52.upgrade
      L4_52 = L4_52.baseId
      L5_53 = _UPVALUE0_
      L5_53 = L5_53.upgrade
      L5_53 = L5_53.level
      L3_51 = L2_50(L3_51, L4_52, L5_53)
      L4_52 = Logic
      L5_53 = L4_52
      L4_52 = L4_52.Get
      L4_52 = L4_52(L5_53, "Hero")
      L5_53 = L4_52
      L4_52 = L4_52.GetHeroLifeAndAttack
      L5_53 = L4_52(L5_53, _UPVALUE3_.baseId, _UPVALUE3_.level)
      if L2_50 and L3_51 and L4_52 and L5_53 then
        _UPVALUE0_.ani:GetChild("staAttack"):create(L3_51)
        _UPVALUE0_.ani:GetChild("staLife"):create(L2_50)
        _UPVALUE0_.ani:GetChild("staLevel"):create(_UPVALUE0_.upgrade.level)
        _UPVALUE0_.ani:GetChild("staAttack"):setValueAni(L5_53, 2000)
        _UPVALUE0_.ani:GetChild("staLife"):setValueAni(L4_52, 2000)
      end
      _UPVALUE0_.ani:GetChild("prgExp"):setValue(100 * _UPVALUE0_.upgrade.exp / L0_48)
      if L1_49 == 0 then
        _UPVALUE0_.ani:GetChild("prgExp"):setValue(0, true, _UPVALUE3_.level - _UPVALUE0_.currentLevel, 2000)
      else
        _UPVALUE0_.ani:GetChild("prgExp"):setValue(100 * _UPVALUE3_.exp / L1_49, true, _UPVALUE3_.level - _UPVALUE0_.currentLevel, 2000)
      end
      _UPVALUE0_.currentLevel = _UPVALUE3_.level
      _UPVALUE0_.upgrade = _UPVALUE3_
    end
    L2_50 = Logic
    L3_51 = L2_50
    L2_50 = L2_50.Get
    L4_52 = "HeroCardInfo"
    L2_50 = L2_50(L3_51, L4_52)
    L3_51 = L2_50
    L2_50 = L2_50.AddShanCard
    L4_52 = _UPVALUE0_
    L4_52 = L4_52.ani
    L5_53 = L4_52
    L4_52 = L4_52.GetChild
    L4_52 = L4_52(L5_53, "imgOut")
    L5_53 = _UPVALUE0_
    L5_53 = L5_53.upgrade
    L5_53 = L5_53.baseId
    L2_50(L3_51, L4_52, L5_53)
  end
  L12_46 = 5000
  L9_43(L10_44, L11_45, L12_46)
  L9_43 = A0_34.ani
  L10_44 = L9_43
  L9_43 = L9_43.RunAnimationWithoutWait
  L9_43(L10_44)
end
function prototype.SetLv(A0_54, A1_55, A2_56)
  local L3_57, L4_58
  L3_57 = Progress
  L3_57 = L3_57.CALL_BACK_TYPE
  L3_57 = L3_57.MOVE_FINISH
  if A2_56 == L3_57 then
    L3_57 = A0_54.ani
    L4_58 = L3_57
    L3_57 = L3_57.GetChild
    L3_57 = L3_57(L4_58, "staLevel")
    L4_58 = L3_57
    L3_57 = L3_57.setValue
    L3_57(L4_58, A0_54.upgrade.level)
    L3_57 = A0_54.ani
    L4_58 = L3_57
    L3_57 = L3_57.GetChild
    L3_57 = L3_57(L4_58, "btnClose")
    L4_58 = L3_57
    L3_57 = L3_57.setEnabled
    L3_57(L4_58, true)
    L3_57 = CCSprite
    L4_58 = L3_57
    L3_57 = L3_57.create
    L3_57 = L3_57(L4_58, "images/font/click_go_on.png")
    if L3_57 ~= nil then
      L4_58 = A0_54.ani
      L4_58 = L4_58.GetLayer
      L4_58 = L4_58(L4_58)
      L4_58 = L4_58.addChild
      L4_58(L4_58, L3_57, 0, 10)
      L4_58 = Logic
      L4_58 = L4_58.Get
      L4_58 = L4_58(L4_58, "Gift")
      L4_58 = L4_58.fadetoSpr
      L4_58 = L4_58(L4_58)
      L3_57:runAction(CCRepeatForever:create(L4_58))
      L3_57:setPosition(A0_54.ani:GetChild("ttfGoOn"):getPosition())
    end
  else
    L3_57 = Progress
    L3_57 = L3_57.CALL_BACK_TYPE
    L3_57 = L3_57.PASS_END
    if A2_56 == L3_57 then
      L3_57 = A0_54.bgLv
      if L3_57 then
        L3_57 = A0_54.ani
        L4_58 = L3_57
        L3_57 = L3_57.GetChild
        L3_57 = L3_57(L4_58, "staLevel")
        L4_58 = L3_57
        L3_57 = L3_57.setValue
        L3_57(L4_58, A0_54.bgLv + 1)
        L3_57 = A0_54.bgLv
        L3_57 = L3_57 + 1
        A0_54.bgLv = L3_57
      end
    end
  end
end
function prototype.onBtnCloseAni(A0_59)
  if A0_59.ani then
    A0_59.ani:RemoveAnimation()
    A0_59.ani = nil
  end
  if Logic:Get("Hero"):GetHeroInfoByBaseId(A0_59.upgrade.baseId) and Logic:Get("Hero"):GetHeroInfoByBaseId(A0_59.upgrade.baseId).level == A0_59.upgrade.level then
    if Logic:Get("Hero"):GetHeroInfoByBaseId(A0_59.upgrade.baseId).nextId == -1 then
      Prompt:Confirm(A0_59, "", 104159)
    elseif not Logic:Get("Hero"):isGuideLevel() then
      Prompt:Confirm(A0_59, "", 104155)
    end
  end
  if Logic:Get("Hero"):isGuideLevel() then
    Logic:Get("Hero"):setGuideLevel(false)
    Logic:Get("Guide"):check()
  end
end
function prototype.onBtnReturn(A0_60, A1_61, A2_62)
  SceneHelper:runWithScene("Home", A0_60.rootNode)
end
function prototype.onBtnHeroSelect(A0_63)
  if A0_63.bSwallow then
    SceneHelper:pushScene("HeroSwallowSelect", A0_63.rootNode)
  else
    SceneHelper:pushScene("HeroUpgradeSelect", A0_63.rootNode)
  end
end
function prototype.onBtnHeroSelectBig(A0_64)
  Logic:Get("Main"):CuMengMainGuide("LevelUp", "SelectHeroWait")
  Logic:Get("Guide"):done("LevelUp", "SelectHeroWait")
  Logic:Get("Guide"):done("FightLevelUp", "SelectHeroWait")
  SceneHelper:pushScene("HeroUpgradeSelect", A0_64.rootNode)
end
function prototype.onBtnUpgrade(A0_65)
  local L1_66, L2_67, L3_68, L4_69, L5_70, L6_71, L7_72, L8_73
  L1_66 = Logic
  L2_67 = L1_66
  L1_66 = L1_66.Get
  L3_68 = "Guide"
  L1_66 = L1_66(L2_67, L3_68)
  L2_67 = L1_66
  L1_66 = L1_66.isGuiding
  L1_66 = L1_66(L2_67)
  if L1_66 then
    L1_66 = Logic
    L2_67 = L1_66
    L1_66 = L1_66.Get
    L3_68 = "Hero"
    L1_66 = L1_66(L2_67, L3_68)
    L2_67 = L1_66
    L1_66 = L1_66.setGuideLevel
    L3_68 = true
    L1_66(L2_67, L3_68)
  end
  L1_66 = Logic
  L2_67 = L1_66
  L1_66 = L1_66.Get
  L3_68 = "Main"
  L1_66 = L1_66(L2_67, L3_68)
  L2_67 = L1_66
  L1_66 = L1_66.CuMengMainGuide
  L3_68 = "LevelUp"
  L4_69 = "LevelUp"
  L1_66(L2_67, L3_68, L4_69)
  L1_66 = Logic
  L2_67 = L1_66
  L1_66 = L1_66.Get
  L3_68 = "Guide"
  L1_66 = L1_66(L2_67, L3_68)
  L2_67 = L1_66
  L1_66 = L1_66.done
  L3_68 = "LevelUp"
  L4_69 = "LevelUp"
  L1_66(L2_67, L3_68, L4_69)
  L1_66 = Logic
  L2_67 = L1_66
  L1_66 = L1_66.Get
  L3_68 = "Guide"
  L1_66 = L1_66(L2_67, L3_68)
  L2_67 = L1_66
  L1_66 = L1_66.done
  L3_68 = "FightLevelUp"
  L4_69 = "LevelUp"
  L1_66(L2_67, L3_68, L4_69)
  L1_66 = Logic
  L2_67 = L1_66
  L1_66 = L1_66.Get
  L3_68 = "Hero"
  L1_66 = L1_66(L2_67, L3_68)
  L2_67 = L1_66
  L1_66 = L1_66.CheckCanUpdate
  L1_66 = L1_66(L2_67)
  if not L1_66 then
    L1_66 = Prompt
    L2_67 = L1_66
    L1_66 = L1_66.ConfirmLeft
    L3_68 = A0_65
    L4_69 = 106014
    L1_66(L2_67, L3_68, L4_69, L5_70)
    return
  end
  L1_66 = Logic
  L2_67 = L1_66
  L1_66 = L1_66.Get
  L3_68 = "Hero"
  L1_66 = L1_66(L2_67, L3_68)
  L2_67 = L1_66
  L1_66 = L1_66.GetUpgradeHero
  L1_66 = L1_66(L2_67)
  L2_67 = Logic
  L3_68 = L2_67
  L2_67 = L2_67.Get
  L4_69 = "Hero"
  L2_67 = L2_67(L3_68, L4_69)
  L3_68 = L2_67
  L2_67 = L2_67.GetHeroInfoById
  L4_69 = L1_66
  L2_67 = L2_67(L3_68, L4_69)
  if L2_67 then
    L3_68 = Logic
    L4_69 = L3_68
    L3_68 = L3_68.Get
    L3_68 = L3_68(L4_69, L5_70)
    L4_69 = L3_68
    L3_68 = L3_68.GetHeroInfoByBaseId
    L3_68 = L3_68(L4_69, L5_70)
    if L3_68 then
      L4_69 = L2_67.level
      if L4_69 == L5_70 then
        L4_69 = L3_68.nextId
        if L4_69 == -1 then
          L4_69 = Prompt
          L4_69 = L4_69.Confirm
          L8_73 = 104159
          L4_69(L5_70, L6_71, L7_72, L8_73)
          return
        else
          L4_69 = Prompt
          L4_69 = L4_69.Confirm
          L8_73 = 104155
          L4_69(L5_70, L6_71, L7_72, L8_73)
          return
        end
      end
    end
  end
  L3_68 = Logic
  L4_69 = L3_68
  L3_68 = L3_68.Get
  L3_68 = L3_68(L4_69, L5_70)
  L4_69 = L3_68
  L3_68 = L3_68.GetSwallowHero
  L3_68 = L3_68(L4_69)
  L4_69 = {}
  for L8_73, _FORV_9_ in L5_70(L6_71) do
    if L8_73 then
      table.insert(L4_69, L8_73)
    end
  end
  if L1_66 and L3_68 then
    L8_73 = L4_69
    L5_70(L6_71, L7_72, L8_73)
  end
end
function prototype.onExit(A0_74)
  A0_74.prgTest:stopTwinkle()
  Logic:Get("Hero"):ClearUpgradeHero()
  Logic:Get("Hero"):ClearSwallowHero()
end
function prototype.onBtnAutoSelect(A0_75)
  local L1_76
  L1_76 = A0_75.upgrade
  if L1_76 ~= nil then
    L1_76 = next
    L1_76 = L1_76(A0_75.upgrade)
  elseif L1_76 == nil then
    L1_76 = Prompt
    L1_76 = L1_76.Fail
    L1_76(L1_76, TwGetStr(104162))
    return
  end
  L1_76 = A0_75.isSwallowHeroListFull
  L1_76 = L1_76(A0_75)
  if L1_76 then
    L1_76 = Prompt
    L1_76 = L1_76.Fail
    L1_76(L1_76, TwGetStr(104163))
    return
  end
  A0_75.fullExp = 0
  A0_75.swallowHeroExp = 0
  L1_76 = Logic
  L1_76 = L1_76.Get
  L1_76 = L1_76(L1_76, "Hero")
  L1_76 = L1_76.upgradeHeroFullExp
  L1_76 = L1_76(L1_76, A0_75.upgrade)
  A0_75.fullExp = L1_76
  L1_76 = A0_75.fullExp
  if L1_76 == 0 then
    L1_76 = A0_75.upgradeHeroMaxLevelTip
    L1_76(A0_75)
    return
  end
  L1_76 = Logic
  L1_76 = L1_76.Get
  L1_76 = L1_76(L1_76, "Hero")
  L1_76 = L1_76.AllSwallowHeroExp
  L1_76 = L1_76(L1_76)
  A0_75.swallowHeroExp = L1_76
  L1_76 = A0_75.fullExp
  if L1_76 ~= 0 then
    L1_76 = A0_75.swallowHeroExp
    if L1_76 >= A0_75.fullExp then
      L1_76 = Prompt
      L1_76 = L1_76.Fail
      L1_76(L1_76, TwGetStr(104164))
      return
    end
  end
  L1_76 = A0_75.AutoSelectSwallowHero
  L1_76 = L1_76(A0_75)
  if L1_76 ~= nil and next(L1_76) ~= nil then
    A0_75:addSwallowHero(L1_76)
    Logic:Get("Hero"):SwapHero(false)
    A0_75:OnOptSwallowSet()
  else
    Prompt:Fail(TwGetStr(104161))
  end
end
function prototype.upgradeHeroMaxLevelTip(A0_77)
  local L1_78
  L1_78 = {}
  L1_78.ok = TwGetStr(103086)
  Logic:Get("SureConfirm"):SetAni(true)
  Logic:Get("SureConfirm"):SetBtnText(L1_78)
  Prompt:Confirm(A0_77, "", 104155, A0_77.gotoEvoUI, Prompt.PROMPT_TYPE.SELECT)
end
function prototype.gotoEvoUI(A0_79)
  Logic:Get("ExplainEquip"):setEvolutionType(Logic.ExplainEquip.EVO_TYPE.MATERIAL_EVO)
  SceneHelper:runWithScene("HeroEvolution", A0_79.rootNode)
end
function prototype.isSwallowHeroListFull(A0_80)
  local L1_81
  L1_81 = Logic
  L1_81 = L1_81.Get
  L1_81 = L1_81(L1_81, "Hero")
  L1_81 = L1_81.GetSwallowHero
  L1_81 = L1_81(L1_81)
  for _FORV_6_, _FORV_7_ in pairs(L1_81) do
    if _FORV_7_ then
    end
  end
  if 0 + 1 == 6 then
    return true
  end
  return false
end
function prototype.addSwallowHero(A0_82, A1_83)
  local L2_84
  for _FORV_5_ = 1, #A1_83 do
    if A0_82.fullExp ~= 0 and A0_82.swallowHeroExp >= A0_82.fullExp then
      break
    end
    if Logic:Get("Hero"):GetHeroSwallowExp(A1_83[_FORV_5_].baseId, A1_83[_FORV_5_].level) then
      A0_82.swallowHeroExp = A0_82.swallowHeroExp + Logic:Get("Hero"):GetHeroSwallowExp(A1_83[_FORV_5_].baseId, A1_83[_FORV_5_].level)
    end
    Logic:Get("Hero"):AddSwallowHero(A1_83[_FORV_5_].id)
  end
  if L2_84 ~= 0 then
    if L2_84 >= 1000 then
      L2_84(L2_84, TwGetStr(104165))
    end
  end
end
function prototype.AutoSelectSwallowHero(A0_85)
  local L1_86, L2_87, L3_88, L4_89, L5_90, L6_91, L7_92, L8_93, L9_94, L10_95, L11_96, L12_97, L13_98, L14_99
  L1_86 = Logic
  L2_87 = L1_86
  L1_86 = L1_86.Get
  L1_86 = L1_86(L2_87, L3_88)
  L2_87 = L1_86
  L1_86 = L1_86.GetUnbattlingHero
  L1_86 = L1_86(L2_87)
  L2_87 = Logic
  L2_87 = L2_87.Get
  L2_87 = L2_87(L3_88, L4_89)
  L2_87 = L2_87.GetUpgradeHero
  L2_87 = L2_87(L3_88)
  for L6_91 = 1, #L1_86 do
    if L7_92 == L2_87 then
      L7_92(L8_93, L9_94)
      break
    end
  end
  if L1_86 and L3_88 then
    for L7_92 = 1, #L3_88 do
      L8_93(L9_94, L10_95)
    end
  end
  if not L4_89 then
    return
  end
  for L9_94 = 1, #L4_89 do
    if L10_95 == false then
      L10_95(L11_96, L12_97)
    end
  end
  L6_91(L7_92, L8_93)
  for L12_97, L13_98 in L9_94(L10_95) do
    L14_99 = L13_98.id
    L14_99 = L8_93[L14_99]
    if L14_99 then
    end
  end
  for L13_98, L14_99 in L10_95(L11_96) do
    if L7_92 == 6 then
      break
    end
    if Logic:Get("Hero"):GetHeroInfoByBaseId(L14_99.baseId).funcFlag and bit.band(Logic:Get("Hero"):GetHeroInfoByBaseId(L14_99.baseId).funcFlag, 1) == 1 and not L8_93[L14_99.id] then
      table.insert(L9_94, L14_99)
    end
  end
  return L9_94
end
function prototype.SortHerosByChoice(A0_100, A1_101)
  if not A1_101 then
    return
  end
  table.sort(A1_101, function(A0_102, A1_103)
    if not Logic:Get("Hero"):GetHeroInfoByBaseId(A0_102.baseId) or not Logic:Get("Hero"):GetHeroInfoByBaseId(A1_103.baseId) then
      return false
    elseif Logic:Get("Hero"):GetHeroInfoByBaseId(A0_102.baseId).card == Logic:Get("Hero"):GetHeroInfoByBaseId(A1_103.baseId).card then
      if Logic:Get("Hero"):GetHeroInfoByBaseId(A0_102.baseId).star == Logic:Get("Hero"):GetHeroInfoByBaseId(A1_103.baseId).star then
        if Logic:Get("Hero"):GetHeroInfoByBaseId(A0_102.baseId).card == "EXP_CARD" and tonumber(Logic:Get("Hero"):GetHeroInfoByBaseId(A0_102.baseId).baseExp) ~= tonumber(Logic:Get("Hero"):GetHeroInfoByBaseId(A1_103.baseId).baseExp) then
          return tonumber(Logic:Get("Hero"):GetHeroInfoByBaseId(A0_102.baseId).baseExp) < tonumber(Logic:Get("Hero"):GetHeroInfoByBaseId(A1_103.baseId).baseExp)
        end
        if A0_102.baseId == A1_103.baseId then
          return A0_102.id > A1_103.id
        else
          return A0_102.baseId > A1_103.baseId
        end
      else
        return Logic:Get("Hero"):GetHeroInfoByBaseId(A0_102.baseId).star < Logic:Get("Hero"):GetHeroInfoByBaseId(A1_103.baseId).star
      end
    else
      return Logic:Get("Hero"):GetHeroInfoByBaseId(A1_103.baseId).card == "EXP_CARD"
    end
  end)
end
function prototype.updateGuide(A0_104)
  Logic:Get("Guide"):lockTouch("LevelUp", "SelectHeroWait", A0_104.btnHeroSelect)
  Logic:Get("Guide"):lockTouch("LevelUp", "SelectMaterialWait", A0_104.ccbHero1.btnHero)
  Logic:Get("Guide"):lockTouch("LevelUp", "LevelUp", A0_104.btnUpgrade)
  Logic:Get("Guide"):lockTouch("FightLevelUp", "SelectHeroWait", A0_104.btnHeroSelect)
  Logic:Get("Guide"):lockTouch("FightLevelUp", "SelectMaterialWait", A0_104.ccbHero1.btnHero)
  Logic:Get("Guide"):lockTouch("FightLevelUp", "LevelUp", A0_104.btnUpgrade)
end
