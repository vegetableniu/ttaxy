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
function prototype.onEnter(A0_1)
  super.onEnter(A0_1)
  Logic:Get("Guide"):On(Logic.Guide.EVT.STEP, A0_1:Event("updateGuide"))
  Logic:Get("Treasure"):On(Logic.Treasure.EVT.REFRESH_TREA, A0_1:Event("visibelSeleTrea"))
  Logic:Get("Treasure"):On(Logic.Treasure.EVT.REFRESH_SELE_HERO, A0_1:Event("SetStage"))
  Logic:Get("Hero"):On(Logic.Hero.EVT.HERO_SKILL_UP, A0_1:Event("RefreshSkillUpAffter"))
  A0_1.ttfSkillTitle:setString(TwGetStr(103109))
  A0_1.ttfTitleMoney:setString(TwGetStr(103111))
  A0_1.ttfCostExpTitle:setString(TwGetStr(103112))
  A0_1.ttfSkillDesRed:setString(TwGetStr(103113))
  A0_1.mPrgHp:createProgress(_UPVALUE0_, _UPVALUE1_, _UPVALUE2_)
  A0_1:setVisibleTip(false)
  A0_1:setVisibleAllTff(false)
  A0_1:setVisibleTreaTff(false)
  A0_1.btnAutoSelect:setEnabled(false)
end
function prototype.onExit(A0_2)
  local L1_3
  L1_3 = {}
  Logic:Get("Treasure"):SetHeroSeleCur(L1_3)
end
function prototype.bindAnimationMgr(A0_4)
  local L1_5
  L1_5 = true
  return L1_5
end
function prototype.completedAnimationSequenceNamed(A0_6, A1_7)
  if A1_7 == "Move Timeline" then
    A0_6:updateGuide()
    A0_6.hero = Logic:Get("Treasure"):GetHeroInfo()
    A0_6.ttfPrgHp:setVisible(false)
    A0_6.btnUpgrade:setEnabled(false)
    if A0_6.hero == nil then
      return
    end
    A0_6.btnAutoSelect:setEnabled(true)
    A0_6:setSeleHeroCard(A0_6.hero)
    A0_6:setSkill(A0_6.hero)
    A0_6:visibelSeleTrea()
  end
end
function prototype.RefreshSkillUpAffter(A0_8, A1_9)
  A0_8:ShowAni()
  A0_8:SetStage(A1_9)
  A0_8:visibelSeleTrea()
end
function prototype.setVisibleTip(A0_10, A1_11)
  local L2_12
  L2_12 = {
    "tip1",
    "tip2",
    "tip3",
    "tip4",
    "tip5",
    "tip6"
  }
  for _FORV_7_ = 1, #L2_12 do
    A0_10[L2_12[_FORV_7_]]:setVisible(A1_11)
    A0_10[({
      "card1",
      "card2",
      "card3",
      "card4",
      "card5",
      "card6"
    })[_FORV_7_]]:setEnabled(A1_11)
  end
  _FOR_:setEnabled(A1_11)
end
function prototype.SetStage(A0_13, A1_14)
  A0_13.heroPro = Logic:Get("Treasure"):GetHeroClone()
  A0_13.hero = Logic:Get("Treasure"):GetHeroInfo()
  A0_13.hero = Logic:Get("Hero"):GetHeroInfoById(A0_13.hero.id)
  A0_13:setSeleHeroCard(A0_13.hero)
  A0_13:setSkill(A0_13.hero, A1_14)
  A0_13.btnAutoSelect:setEnabled(true)
  Logic:Get("Guide"):check()
end
function prototype.visibelSeleTrea(A0_15)
  local L1_16, L2_17, L3_18, L4_19, L5_20, L6_21, L7_22, L8_23, L9_24, L10_25
  L1_16 = {
    L2_17,
    L3_18,
    L4_19,
    L5_20,
    L6_21,
    L7_22
  }
  L7_22 = "card6"
  for L5_20 = 1, #L1_16 do
    L7_22 = L6_21
    L8_23 = L5_20
    if L6_21 ~= nil then
      L7_22 = A0_15.layer
      L8_23 = L7_22
      L7_22 = L7_22.removeChildByTag
      L9_24 = L5_20
      L10_25 = true
      L7_22(L8_23, L9_24, L10_25)
    end
  end
  if L3_18 then
    L3_18(L4_19, L5_20)
    L3_18(L4_19, L5_20)
  else
    L3_18(L4_19, L5_20)
    L3_18(L4_19, L5_20)
  end
  for L7_22, L8_23 in L4_19(L5_20) do
    L9_24 = Logic
    L10_25 = L9_24
    L9_24 = L9_24.Get
    L9_24 = L9_24(L10_25, "Hero")
    L10_25 = L9_24
    L9_24 = L9_24.GetHeroInfoById
    L9_24 = L9_24(L10_25, L7_22)
    L10_25 = Logic
    L10_25 = L10_25.Get
    L10_25 = L10_25(L10_25, "Treasure")
    L10_25 = L10_25.GetSprTrea
    L10_25 = L10_25(L10_25, L9_24.baseId)
    A0_15.layer:addChild(L10_25, 0, L3_18)
    L10_25:setAnchorPoint(CCPoint(0.5, 0.5))
    L10_25:setPosition(A0_15[L1_16[L3_18]]:getPosition())
  end
  L4_19(L5_20)
end
function prototype.CountTrea(A0_26, A1_27)
  local L2_28, L3_29, L4_30, L5_31, L6_32
  L2_28 = 0
  for L6_32, _FORV_7_ in L3_29(L4_30) do
    if Logic:Get("Hero"):GetHeroInfoById(L6_32) ~= nil then
      L2_28 = L2_28 + tonumber(Logic:Get("Hero"):GetHeroInfoByBaseId(Logic:Get("Hero"):GetHeroInfoById(L6_32).baseId).baseExp)
    end
  end
  L6_32 = L2_28
  L4_30(L5_31, L6_32)
  if L4_30 == 0 then
    L3_29.exps = 1
  end
  L6_32 = math
  L6_32 = L6_32.floor
  L6_32 = L6_32(100 * (A0_26.hero.skillExp + L2_28) / tonumber(L3_29.exps))
  L4_30(L5_31, L6_32, true)
  L6_32 = true
  L4_30(L5_31, L6_32, 500)
end
function prototype.setSkill(A0_33, A1_34, A2_35)
  A0_33:setVisibleAllTff(true)
  A0_33.ttfSkillName:setString(TwGetStr(103040, Logic:Get("HeroCardInfo"):kdbSkillConfig(A1_34.powerSkill).skillname or ""))
  A0_33.ttfSkillLvl:setStyle(kCCLabelTTFStyleOutline)
  A0_33.ttfSkillLvl:setString(Logic:Get("HeroCardInfo"):kdbSkillConfig(A1_34.powerSkill).level .. "/" .. Logic:Get("HeroCardInfo"):kdbSkillConfig(A1_34.powerSkill).maxlev)
  A0_33.ttfSkillDesRed:setStyle(kCCLabelTTFStyleOutline)
  A0_33.ttfSkillDesRed:setDimensions(CCSize(200, 0))
  A0_33.ttfSkillDesRed:setString(Logic:Get("HeroCardInfo"):kdbSkillConfig(A1_34.powerSkill).effectdesc)
  if Logic:Get("HeroCardInfo"):kdbSkillConfig(A1_34.powerSkill).level == Logic:Get("HeroCardInfo"):kdbSkillConfig(A1_34.powerSkill).maxlev then
    A0_33.mPrgHp:setValue(100, false)
    A0_33.ttfSkillLvl:setString("MAX")
    A0_33.ttfSkillOdds:setString(tonumber(Logic:Get("HeroCardInfo"):kdbSkillConfig(A1_34.powerSkill).exps))
    A0_33.ttfMoney:setString(tonumber(Logic:Get("HeroCardInfo"):kdbSkillConfig(A1_34.powerSkill).maxExps))
  end
  if 0 < Logic:Get("HeroCardInfo"):kdbSkillConfig(A1_34.powerSkill).exps then
    if A2_35 then
      if Logic:Get("HeroCardInfo"):kdbSkillConfig(A1_34.powerSkill).exps ~= 0 then
        A0_33.mPrgHp:setValue(math.floor(100 * A1_34.skillExp / tonumber(Logic:Get("HeroCardInfo"):kdbSkillConfig(A1_34.powerSkill).exps)), false)
      end
    elseif Logic:Get("HeroCardInfo"):kdbSkillConfig(A1_34.powerSkill).exps ~= 0 then
      A0_33.mPrgHp:setValue(math.floor(100 * A1_34.skillExp / tonumber(Logic:Get("HeroCardInfo"):kdbSkillConfig(A1_34.powerSkill).exps)), false)
    end
    A0_33.ttfPrgHp:setStyle(kCCLabelTTFStyleOutline)
    A0_33.ttfPrgHp:setString(math.floor(100 * A1_34.skillExp / tonumber(Logic:Get("HeroCardInfo"):kdbSkillConfig(A1_34.powerSkill).exps)) .. "%")
    A0_33.ttfSkillOdds:setString(tonumber(Logic:Get("HeroCardInfo"):kdbSkillConfig(A1_34.powerSkill).exps) - A1_34.skillExp)
    A0_33.ttfMoney:setString(tonumber(Logic:Get("HeroCardInfo"):kdbSkillConfig(A1_34.powerSkill).maxExps) - A1_34.skillExp)
  else
  end
end
function prototype.setVisibleAllTff(A0_36, A1_37)
  A0_36.ttfSkillName:setVisible(A1_37)
  A0_36.ttfSkillLvl:setVisible(A1_37)
  A0_36.ttfLvlTitel:setVisible(A1_37)
  A0_36.ttfSkillDesRed:setVisible(A1_37)
  A0_36.mPrgHp:setVisible(A1_37)
  A0_36:setVisibleTreaTff(A1_37)
end
function prototype.setVisibleTreaTff(A0_38, A1_39)
  A0_38.ttfSkillTitle:setStyle(kCCLabelTTFStyleOutline)
  A0_38.ttfSkillOdds:setStyle(kCCLabelTTFStyleOutline)
  A0_38.ttfTitleMoney:setStyle(kCCLabelTTFStyleOutline)
  A0_38.ttfMoney:setStyle(kCCLabelTTFStyleOutline)
  A0_38.ttfCostExpTitle:setStyle(kCCLabelTTFStyleOutline)
  A0_38.ttfCostExp:setStyle(kCCLabelTTFStyleOutline)
  A0_38.ttfSkillTitle:setVisible(A1_39)
  A0_38.ttfSkillOdds:setVisible(A1_39)
  A0_38.ttfTitleMoney:setVisible(A1_39)
  A0_38.ttfMoney:setVisible(A1_39)
  A0_38.ttfCostExpTitle:setVisible(A1_39)
  A0_38.ttfCostExp:setVisible(A1_39)
end
function prototype.onBtnReturn(A0_40)
  local L1_41
  L1_41 = {}
  Logic:Get("Treasure"):SetHeroSeleCur(L1_41)
  SceneHelper:popScene()
end
function prototype.onBtnHeroSelectBig(A0_42)
  Logic:Get("Guide"):done("SkillUpgrade", "SelectHeroWait")
  SceneHelper:pushScene("HeroUpSkillSele", A0_42.rootNode)
end
function prototype.onBtnHeroSelect(A0_43)
  if not Logic:Get("Hero"):IsHasSkillCard("SKILL_CARD") then
    Prompt:Tip(TwGetStr(103053))
    return
  end
  Logic:Get("Guide"):done("SkillUpgrade", "SelectTreasureWait")
  SceneHelper:pushScene("TreasureSele", A0_43.rootNode)
end
function prototype.onBtnUpgrade(A0_44)
  local L1_45, L2_46, L3_47, L4_48, L5_49, L6_50
  L1_45 = Logic
  L2_46 = L1_45
  L1_45 = L1_45.Get
  L1_45 = L1_45(L2_46, L3_47)
  L2_46 = L1_45
  L1_45 = L1_45.setGuideFight
  L1_45(L2_46, L3_47)
  L1_45 = Logic
  L2_46 = L1_45
  L1_45 = L1_45.Get
  L1_45 = L1_45(L2_46, L3_47)
  L2_46 = L1_45
  L1_45 = L1_45.done
  L1_45(L2_46, L3_47, L4_48)
  L1_45 = {}
  A0_44.treaInfo = L1_45
  L1_45 = {}
  L2_46 = Logic
  L2_46 = L2_46.Get
  L2_46 = L2_46(L3_47, L4_48)
  L2_46 = L2_46.GetHeroSeleCur
  L2_46 = L2_46(L3_47)
  for L6_50, _FORV_7_ in L3_47(L4_48) do
    table.insert(L1_45, L6_50)
    A0_44.treaInfo[L6_50] = Logic:Get("Hero"):GetHeroInfoById(L6_50)
  end
  L6_50 = L1_45
  L3_47(L4_48, L5_49, L6_50)
end
function prototype.onBtnAutoSelect(A0_51)
  local L1_52
  L1_52 = {}
  Logic:Get("Treasure"):SetHeroSeleCur(L1_52)
  Logic:Get("Treasure"):SetAutoSelect()
  A0_51:visibelSeleTrea()
end
function prototype.setSeleHeroCard(A0_53, A1_54)
  local L2_55, L3_56
  L2_55 = A0_53.layer
  L3_56 = L2_55
  L2_55 = L2_55.getChildByTag
  L2_55 = L2_55(L3_56, 97)
  if L2_55 ~= nil then
    L3_56 = A0_53.layer
    L3_56 = L3_56.removeChildByTag
    L3_56(L3_56, 97, true)
    L3_56 = {}
    Logic:Get("Treasure"):SetHeroSeleCur(L3_56)
    A0_53:visibelSeleTrea()
  end
  L3_56 = Logic
  L3_56 = L3_56.Get
  L3_56 = L3_56(L3_56, "HeroCardInfo")
  L3_56 = L3_56.createHeroCard
  L3_56 = L3_56(L3_56, A1_54.baseId, 200)
  if L3_56 == nil then
    return
  end
  A0_53:setVisibleTip(true)
  L3_56:setAnchorPoint(CCPoint(0.5, 0.5))
  A0_53.layer:addChild(L3_56, 0, 97)
  L3_56:setPosition(A0_53.btnHeroSelect:getPosition())
end
function prototype.ShowAni(A0_57)
  local L1_58, L2_59, L3_60, L4_61, L5_62, L6_63, L7_64, L8_65, L9_66, L10_67, L11_68, L12_69, L13_70, L14_71, L15_72, L16_73, L17_74
  L1_58 = Logic
  L2_59 = L1_58
  L1_58 = L1_58.Get
  L3_60 = "Treasure"
  L1_58 = L1_58(L2_59, L3_60)
  L2_59 = L1_58
  L1_58 = L1_58.GetHeroClone
  L1_58 = L1_58(L2_59)
  A0_57.heroPro = L1_58
  L1_58 = Logic
  L2_59 = L1_58
  L1_58 = L1_58.Get
  L3_60 = "Treasure"
  L1_58 = L1_58(L2_59, L3_60)
  L2_59 = L1_58
  L1_58 = L1_58.GetHeroInfo
  L1_58 = L1_58(L2_59)
  A0_57.hero = L1_58
  L1_58 = Logic
  L2_59 = L1_58
  L1_58 = L1_58.Get
  L3_60 = "Hero"
  L1_58 = L1_58(L2_59, L3_60)
  L2_59 = L1_58
  L1_58 = L1_58.GetHeroInfoById
  L3_60 = A0_57.hero
  L3_60 = L3_60.id
  L1_58 = L1_58(L2_59, L3_60)
  A0_57.hero = L1_58
  L1_58 = Logic
  L2_59 = L1_58
  L1_58 = L1_58.Get
  L3_60 = "Treasure"
  L1_58 = L1_58(L2_59, L3_60)
  L2_59 = L1_58
  L1_58 = L1_58.GetHeroInfo
  L1_58 = L1_58(L2_59)
  L2_59 = Logic
  L3_60 = L2_59
  L2_59 = L2_59.Get
  L4_61 = "Treasure"
  L2_59 = L2_59(L3_60, L4_61)
  L3_60 = L2_59
  L2_59 = L2_59.GetHeroSeleCur
  L2_59 = L2_59(L3_60)
  L3_60 = table
  L3_60 = L3_60.empty
  L4_61 = L2_59
  L3_60 = L3_60(L4_61)
  if L3_60 then
    return
  end
  L3_60 = Logic
  L4_61 = L3_60
  L3_60 = L3_60.Get
  L5_62 = "System"
  L3_60 = L3_60(L4_61, L5_62)
  L4_61 = L3_60
  L3_60 = L3_60.IsUpgradeAniEnabled
  L3_60 = L3_60(L4_61)
  if not L3_60 then
    L3_60 = {}
    L4_61 = Logic
    L5_62 = L4_61
    L4_61 = L4_61.Get
    L6_63 = "Treasure"
    L4_61 = L4_61(L5_62, L6_63)
    L5_62 = L4_61
    L4_61 = L4_61.SetHeroSeleCur
    L6_63 = L3_60
    L4_61(L5_62, L6_63)
    L5_62 = A0_57
    L4_61 = A0_57.onBtnCloseAni
    L4_61(L5_62)
    return
  end
  L3_60 = SceneHelper
  L4_61 = L3_60
  L3_60 = L3_60.getRootLayer
  L3_60 = L3_60(L4_61)
  L4_61 = Logic
  L5_62 = L4_61
  L4_61 = L4_61.Get
  L6_63 = "AniMgr"
  L4_61 = L4_61(L5_62, L6_63)
  L5_62 = L4_61
  L4_61 = L4_61.NewCCB
  L6_63 = "UI/uiyxsj"
  L7_64 = L3_60
  L8_65 = nil
  L4_61 = L4_61(L5_62, L6_63, L7_64, L8_65, L9_66)
  A0_57.ani = L4_61
  L4_61 = A0_57.ani
  L5_62 = L4_61
  L4_61 = L4_61.GetChild
  L6_63 = "imgLevelTip"
  L4_61 = L4_61(L5_62, L6_63)
  L5_62 = L4_61
  L4_61 = L4_61.setVisible
  L6_63 = false
  L4_61(L5_62, L6_63)
  L4_61 = A0_57.ani
  L5_62 = L4_61
  L4_61 = L4_61.GetChild
  L6_63 = "staLevel"
  L4_61 = L4_61(L5_62, L6_63)
  L5_62 = L4_61
  L4_61 = L4_61.setVisible
  L6_63 = false
  L4_61(L5_62, L6_63)
  L4_61 = A0_57.ani
  L5_62 = L4_61
  L4_61 = L4_61.GetChild
  L6_63 = "imgAttackTip"
  L4_61 = L4_61(L5_62, L6_63)
  L5_62 = L4_61
  L4_61 = L4_61.setVisible
  L6_63 = false
  L4_61(L5_62, L6_63)
  L4_61 = A0_57.ani
  L5_62 = L4_61
  L4_61 = L4_61.GetChild
  L6_63 = "staAttack"
  L4_61 = L4_61(L5_62, L6_63)
  L5_62 = L4_61
  L4_61 = L4_61.setVisible
  L6_63 = false
  L4_61(L5_62, L6_63)
  L4_61 = A0_57.ani
  L5_62 = L4_61
  L4_61 = L4_61.GetChild
  L6_63 = "imgLifeTip"
  L4_61 = L4_61(L5_62, L6_63)
  L5_62 = L4_61
  L4_61 = L4_61.setVisible
  L6_63 = false
  L4_61(L5_62, L6_63)
  L4_61 = A0_57.ani
  L5_62 = L4_61
  L4_61 = L4_61.GetChild
  L6_63 = "staLife"
  L4_61 = L4_61(L5_62, L6_63)
  L5_62 = L4_61
  L4_61 = L4_61.setVisible
  L6_63 = false
  L4_61(L5_62, L6_63)
  L4_61 = A0_57.ani
  L5_62 = L4_61
  L4_61 = L4_61.GetChild
  L6_63 = "imgBg1"
  L4_61 = L4_61(L5_62, L6_63)
  L5_62 = L4_61
  L4_61 = L4_61.setVisible
  L6_63 = false
  L4_61(L5_62, L6_63)
  L4_61 = A0_57.ani
  L5_62 = L4_61
  L4_61 = L4_61.GetChild
  L6_63 = "imgBg2"
  L4_61 = L4_61(L5_62, L6_63)
  L5_62 = L4_61
  L4_61 = L4_61.setVisible
  L6_63 = false
  L4_61(L5_62, L6_63)
  L4_61 = A0_57.ani
  L5_62 = L4_61
  L4_61 = L4_61.GetChild
  L6_63 = "imgBg3"
  L4_61 = L4_61(L5_62, L6_63)
  L5_62 = L4_61
  L4_61 = L4_61.setVisible
  L6_63 = false
  L4_61(L5_62, L6_63)
  L4_61 = A0_57.ani
  L5_62 = L4_61
  L4_61 = L4_61.GetChild
  L6_63 = "btnClose"
  L4_61 = L4_61(L5_62, L6_63)
  L5_62 = L4_61
  L4_61 = L4_61.setEnabled
  L6_63 = false
  L4_61(L5_62, L6_63)
  L4_61 = Logic
  L5_62 = L4_61
  L4_61 = L4_61.Get
  L6_63 = "HeroCardInfo"
  L4_61 = L4_61(L5_62, L6_63)
  L5_62 = L4_61
  L4_61 = L4_61.createHeroCardForByFight
  L6_63 = L1_58.baseId
  L4_61 = L4_61(L5_62, L6_63)
  L5_62 = Logic
  L6_63 = L5_62
  L5_62 = L5_62.Get
  L7_64 = "HeroCardInfo"
  L5_62 = L5_62(L6_63, L7_64)
  L6_63 = L5_62
  L5_62 = L5_62.GetCardTexture
  L7_64 = L4_61
  L8_65 = L4_61.getContentSize
  L17_74 = L8_65(L9_66)
  L6_63 = L5_62(L6_63, L7_64, L8_65, L9_66, L10_67, L11_68, L12_69, L13_70, L14_71, L15_72, L16_73, L17_74, L8_65(L9_66))
  L7_64 = A0_57.ani
  L8_65 = L7_64
  L7_64 = L7_64.GetChild
  L7_64 = L7_64(L8_65, L9_66)
  L8_65 = L7_64
  L7_64 = L7_64.setTexture
  L7_64(L8_65, L9_66)
  L7_64 = A0_57.ani
  L8_65 = L7_64
  L7_64 = L7_64.GetChild
  L7_64 = L7_64(L8_65, L9_66)
  L8_65 = L7_64
  L7_64 = L7_64.setTextureRect
  L7_64(L8_65, L9_66)
  L7_64 = 1
  L8_65 = {}
  for L12_69 = 1, 6 do
    L13_70 = string
    L13_70 = L13_70.format
    L14_71 = "imgHero%d"
    L15_72 = L12_69
    L13_70 = L13_70(L14_71, L15_72)
    L8_65[L12_69] = L13_70
    L13_70 = A0_57.ani
    L14_71 = L13_70
    L13_70 = L13_70.GetChild
    L15_72 = L8_65[L12_69]
    L13_70 = L13_70(L14_71, L15_72)
    L14_71 = L13_70
    L13_70 = L13_70.setVisible
    L15_72 = false
    L13_70(L14_71, L15_72)
  end
  for L12_69, L13_70 in L9_66(L10_67) do
    L14_71 = A0_57.treaInfo
    L14_71 = L14_71[L12_69]
    L15_72 = A0_57.ani
    L16_73 = L15_72
    L15_72 = L15_72.GetChild
    L17_74 = L8_65[L7_64]
    L15_72 = L15_72(L16_73, L17_74)
    L16_73 = L15_72
    L15_72 = L15_72.setVisible
    L17_74 = true
    L15_72(L16_73, L17_74)
    if L14_71 then
      L15_72 = A0_57.ani
      L16_73 = L15_72
      L15_72 = L15_72.GetChild
      L17_74 = L8_65[L7_64]
      L15_72 = L15_72(L16_73, L17_74)
      L16_73 = L15_72
      L15_72 = L15_72.setVisible
      L17_74 = true
      L15_72(L16_73, L17_74)
      L15_72 = Logic
      L16_73 = L15_72
      L15_72 = L15_72.Get
      L17_74 = "HeroCardInfo"
      L15_72 = L15_72(L16_73, L17_74)
      L16_73 = L15_72
      L15_72 = L15_72.createHeroCardForByFight
      L17_74 = L14_71.baseId
      L15_72 = L15_72(L16_73, L17_74)
      L16_73 = Logic
      L17_74 = L16_73
      L16_73 = L16_73.Get
      L16_73 = L16_73(L17_74, "HeroCardInfo")
      L17_74 = L16_73
      L16_73 = L16_73.GetCardTexture
      L17_74 = L16_73(L17_74, L15_72, A0_57.ani:GetChild("imgOut"):getContentSize())
      A0_57.ani:GetChild(L8_65[L7_64]):setTexture(L16_73)
      A0_57.ani:GetChild(L8_65[L7_64]):setTextureRect(L17_74)
    else
      L15_72 = A0_57.ani
      L16_73 = L15_72
      L15_72 = L15_72.GetChild
      L17_74 = L8_65[L7_64]
      L15_72 = L15_72(L16_73, L17_74)
      L16_73 = L15_72
      L15_72 = L15_72.setVisible
      L17_74 = false
      L15_72(L16_73, L17_74)
    end
    L7_64 = L7_64 + 1
  end
  L12_69 = "HeroCardInfo"
  L12_69 = L9_66
  L14_71 = L9_66
  L13_70 = L9_66.getContentSize
  L17_74 = L13_70(L14_71)
  L12_69 = A0_57.ani
  L13_70 = L12_69
  L12_69 = L12_69.GetChild
  L14_71 = "imgOut"
  L12_69 = L12_69(L13_70, L14_71)
  L13_70 = L12_69
  L12_69 = L12_69.setTexture
  L14_71 = L10_67
  L12_69(L13_70, L14_71)
  L12_69 = A0_57.ani
  L13_70 = L12_69
  L12_69 = L12_69.GetChild
  L14_71 = "imgOut"
  L12_69 = L12_69(L13_70, L14_71)
  L13_70 = L12_69
  L12_69 = L12_69.setTextureRect
  L14_71 = L11_68
  L12_69(L13_70, L14_71)
  L12_69 = A0_57.ani
  L13_70 = L12_69
  L12_69 = L12_69.SetCloseCallback
  L14_71 = A0_57
  L15_72 = A0_57.onBtnCloseAni
  L12_69(L13_70, L14_71, L15_72)
  L12_69 = Logic
  L13_70 = L12_69
  L12_69 = L12_69.Get
  L14_71 = "HeroCardInfo"
  L12_69 = L12_69(L13_70, L14_71)
  L13_70 = L12_69
  L12_69 = L12_69.kdbSkillConfig
  L14_71 = A0_57.heroPro
  L14_71 = L14_71.powerSkill
  L12_69 = L12_69(L13_70, L14_71)
  L13_70 = Logic
  L14_71 = L13_70
  L13_70 = L13_70.Get
  L15_72 = "HeroCardInfo"
  L13_70 = L13_70(L14_71, L15_72)
  L14_71 = L13_70
  L13_70 = L13_70.kdbSkillConfig
  L15_72 = A0_57.hero
  L15_72 = L15_72.powerSkill
  L13_70 = L13_70(L14_71, L15_72)
  if L13_70 == nil or L12_69 == nil then
    L14_71 = A0_57.heroPro
    L14_71 = L14_71.powerSkill
    if L14_71 ~= nil then
      L14_71 = A0_57.hero
      L14_71 = L14_71.powerSkill
      if L14_71 ~= nil then
        L14_71 = log4misc
        L15_72 = L14_71
        L14_71 = L14_71.warn
        L16_73 = "self.heroPro.powerSkill:"
        L17_74 = A0_57.heroPro
        L17_74 = L17_74.powerSkill
        L16_73 = L16_73 .. L17_74
        L14_71(L15_72, L16_73)
        L14_71 = log4misc
        L15_72 = L14_71
        L14_71 = L14_71.warn
        L16_73 = "self.hero.powerSkill:"
        L17_74 = A0_57.hero
        L17_74 = L17_74.powerSkill
        L16_73 = L16_73 .. L17_74
        L14_71(L15_72, L16_73)
      end
    else
      L14_71 = log4misc
      L15_72 = L14_71
      L14_71 = L14_71.warn
      L16_73 = "self.heroPro.powerSkill and self.hero.powerSkill : nil    "
      L14_71(L15_72, L16_73)
    end
    return
  end
  L14_71 = A0_57.ani
  L15_72 = L14_71
  L14_71 = L14_71.SetWaitSignByDefaultAniName
  function L16_73()
    local L0_75, L1_76, L2_77
    L0_75 = Logic
    L1_76 = L0_75
    L0_75 = L0_75.Get
    L2_77 = "BGSound"
    L0_75 = L0_75(L1_76, L2_77)
    L1_76 = L0_75
    L0_75 = L0_75.PlayEffect
    L2_77 = "audio/skillupgrade.mp3"
    L0_75(L1_76, L2_77)
    L0_75 = _UPVALUE0_
    L0_75 = L0_75.ani
    L1_76 = L0_75
    L0_75 = L0_75.GetChild
    L2_77 = "prgExp"
    L0_75 = L0_75(L1_76, L2_77)
    L1_76 = L0_75
    L0_75 = L0_75.createProgress
    L2_77 = _UPVALUE1_
    L0_75(L1_76, L2_77, _UPVALUE2_)
    L0_75 = _UPVALUE0_
    L0_75 = L0_75.ani
    L1_76 = L0_75
    L0_75 = L0_75.GetChild
    L2_77 = "imgLevelTip"
    L0_75 = L0_75(L1_76, L2_77)
    L1_76 = L0_75
    L0_75 = L0_75.setVisible
    L2_77 = true
    L0_75(L1_76, L2_77)
    L0_75 = _UPVALUE0_
    L0_75 = L0_75.ani
    L1_76 = L0_75
    L0_75 = L0_75.GetChild
    L2_77 = "staLevel"
    L0_75 = L0_75(L1_76, L2_77)
    L1_76 = L0_75
    L0_75 = L0_75.setVisible
    L2_77 = true
    L0_75(L1_76, L2_77)
    L0_75 = _UPVALUE0_
    L0_75 = L0_75.ani
    L1_76 = L0_75
    L0_75 = L0_75.GetChild
    L2_77 = "imgBg1"
    L0_75 = L0_75(L1_76, L2_77)
    L1_76 = L0_75
    L0_75 = L0_75.setVisible
    L2_77 = true
    L0_75(L1_76, L2_77)
    L0_75 = _UPVALUE0_
    L0_75 = L0_75.ani
    L1_76 = L0_75
    L0_75 = L0_75.GetChild
    L2_77 = "prgExp"
    L0_75 = L0_75(L1_76, L2_77)
    L1_76 = L0_75
    L0_75 = L0_75.setMoveCallBack
    L2_77 = bind
    L2_77 = L2_77(_UPVALUE0_.SetLv, _UPVALUE0_)
    L0_75(L1_76, L2_77, L2_77(_UPVALUE0_.SetLv, _UPVALUE0_))
    L0_75 = math
    L0_75 = L0_75.max
    L1_76 = _UPVALUE3_
    L1_76 = L1_76.level
    L2_77 = _UPVALUE4_
    L2_77 = L2_77.level
    L1_76 = L1_76 - L2_77
    L2_77 = 0
    L0_75 = L0_75(L1_76, L2_77)
    L1_76 = 0
    L2_77 = _UPVALUE4_
    L2_77 = L2_77.exps
    if L2_77 ~= 0 then
      L2_77 = math
      L2_77 = L2_77.floor
      L2_77 = L2_77(100 * _UPVALUE0_.heroPro.skillExp / tonumber(_UPVALUE4_.exps))
      L1_76 = L2_77
      if L1_76 < 0 then
        L1_76 = 0
      end
    end
    L2_77 = 0
    if _UPVALUE3_.exps ~= 0 then
      L2_77 = math.floor(100 * _UPVALUE0_.hero.skillExp / tonumber(_UPVALUE3_.exps))
      if L2_77 < 0 then
        L2_77 = 0
      end
    end
    _UPVALUE0_.lv = _UPVALUE4_.level
    _UPVALUE0_.nextLv = _UPVALUE3_.level
    if _UPVALUE3_.level == _UPVALUE4_.level then
      _UPVALUE0_.ani:GetChild("prgExp"):setValue(L1_76)
      _UPVALUE0_.ani:GetChild("prgExp"):setValue(L2_77, true, 0, 1000)
      _UPVALUE0_.ani:GetChild("staLevel"):create(_UPVALUE3_.level)
    else
      _UPVALUE0_.ani:GetChild("prgExp"):setValue(L1_76)
      _UPVALUE0_.ani:GetChild("prgExp"):setValue(L2_77, true, L0_75, 1000)
      _UPVALUE0_.ani:GetChild("staLevel"):create(_UPVALUE4_.level)
    end
    Logic:Get("HeroCardInfo"):AddShanCard(_UPVALUE0_.ani:GetChild("imgOut"), _UPVALUE0_.hero.baseId)
  end
  L17_74 = 5000
  L14_71(L15_72, L16_73, L17_74)
  L14_71 = A0_57.ani
  L15_72 = L14_71
  L14_71 = L14_71.RunAnimationWithoutWait
  L14_71(L15_72)
  L14_71 = {}
  L15_72 = Logic
  L16_73 = L15_72
  L15_72 = L15_72.Get
  L17_74 = "Treasure"
  L15_72 = L15_72(L16_73, L17_74)
  L16_73 = L15_72
  L15_72 = L15_72.SetHeroSeleCur
  L17_74 = L14_71
  L15_72(L16_73, L17_74)
end
function prototype.SetLv(A0_78, A1_79, A2_80)
  local L3_81, L4_82
  L3_81 = Progress
  L3_81 = L3_81.CALL_BACK_TYPE
  L3_81 = L3_81.MOVE_FINISH
  if A2_80 == L3_81 then
    L3_81 = A0_78.ani
    L4_82 = L3_81
    L3_81 = L3_81.GetChild
    L3_81 = L3_81(L4_82, "staLevel")
    L4_82 = L3_81
    L3_81 = L3_81.setValue
    L3_81(L4_82, A0_78.nextLv)
    L3_81 = A0_78.ani
    L4_82 = L3_81
    L3_81 = L3_81.GetChild
    L3_81 = L3_81(L4_82, "btnClose")
    L4_82 = L3_81
    L3_81 = L3_81.setEnabled
    L3_81(L4_82, true)
    L3_81 = CCSprite
    L4_82 = L3_81
    L3_81 = L3_81.create
    L3_81 = L3_81(L4_82, "images/font/click_go_on.png")
    if L3_81 ~= nil then
      L4_82 = A0_78.ani
      L4_82 = L4_82.GetLayer
      L4_82 = L4_82(L4_82)
      L4_82 = L4_82.addChild
      L4_82(L4_82, L3_81, 0, 10)
      L4_82 = Logic
      L4_82 = L4_82.Get
      L4_82 = L4_82(L4_82, "Gift")
      L4_82 = L4_82.fadetoSpr
      L4_82 = L4_82(L4_82)
      L3_81:runAction(CCRepeatForever:create(L4_82))
      L3_81:setPosition(A0_78.ani:GetChild("ttfGoOn"):getPosition())
    end
  else
    L3_81 = Progress
    L3_81 = L3_81.CALL_BACK_TYPE
    L3_81 = L3_81.PASS_END
    if A2_80 == L3_81 then
      L3_81 = A0_78.ani
      L4_82 = L3_81
      L3_81 = L3_81.GetChild
      L3_81 = L3_81(L4_82, "staLevel")
      L4_82 = L3_81
      L3_81 = L3_81.setValue
      L3_81(L4_82, A0_78.lv + 1)
      L3_81 = A0_78.lv
      L3_81 = L3_81 + 1
      A0_78.lv = L3_81
    end
  end
end
function prototype.onBtnCloseAni(A0_83)
  Logic:Get("Treasure"):setHeroClone(A0_83.hero)
  if A0_83.ani then
    A0_83.ani:RemoveAnimation()
    A0_83.ani = nil
  end
  if Logic:Get("Fight"):isGuideFight() then
    Logic:Get("Fight"):setGuideFight(false)
    Logic:Get("Guide"):check()
  end
end
function prototype.updateGuide(A0_84)
  Logic:Get("Guide"):lockTouch("SkillUpgrade", "SelectHeroWait", A0_84.btnHeroSelect)
  Logic:Get("Guide"):lockTouch("SkillUpgrade", "SelectTreasureWait", A0_84.card1)
  Logic:Get("Guide"):lockTouch("SkillUpgrade", "Upgrade", A0_84.btnUpgrade)
end
