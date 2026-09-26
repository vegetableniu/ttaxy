local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = require
L0_0("BtnPosition")
L0_0 = Tw
L0_0 = L0_0.Controller
L0_0 = L0_0.prototype
L0_0 = L0_0.extend
L0_0 = L0_0(L0_0)
prototype = L0_0
L0_0 = {
  "btnHelmet",
  "btnArmour",
  "btnGloves",
  "btnTrousers",
  "btnShose",
  "btnright",
  "btnbeginevolution"
}
BTN_SET = L0_0
L0_0 = {
  "Helmetsprite",
  "Armoursprite",
  "Glovessprite",
  "Trouserssprite",
  "Shosesprite"
}
BNT_SPRITE = L0_0
L0_0 = {
  "cardQuality1",
  "cardQuality2",
  "cardQuality3",
  "cardQuality4",
  "cardQuality5"
}
QUALITY_CARD = L0_0
L0_0 = "images/public/clarity05.png"
EQUIP_BG_PATH = L0_0
L0_0 = {
  "imgHero1",
  "imgHero2",
  "imgHero3",
  "imgHero4",
  "imgHero5",
  "imgHero6"
}
HERO_NOT_ENOUGH_TITLE = {
  "HeroNotEnough1",
  "HeroNotEnough2",
  "HeroNotEnough3",
  "HeroNotEnough4",
  "HeroNotEnough5"
}
EQUIP_CARD_MAX = Logic:Get("CoordinatesSale"):getEquipCardMax()
HAVE_HERO_IMG = false
G_EQUIP_TAG = "TREASURE"
G_HERO_TAG = "HERO"
function prototype.initialize(A0_1)
  super.initialize(A0_1)
  A0_1.titleInfo = {}
  A0_1.aniInfo = {}
  A0_1.hero = {}
  A0_1.info = {}
  A0_1.nextheroinfo = {}
  A0_1.selectHeroTag = false
end
function prototype.onNodeLoaded(A0_2, A1_3, A2_4)
end
function prototype.onEnter(A0_5)
  local L1_6, L2_7
  L1_6 = super
  L1_6 = L1_6.onEnter
  L2_7 = A0_5
  L1_6(L2_7)
  L1_6 = A0_5.imgArrowHead
  L2_7 = L1_6
  L1_6 = L1_6.setVisible
  L1_6(L2_7, false)
  A0_5.AbilityEvolutionTag = true
  L1_6 = Logic
  L2_7 = L1_6
  L1_6 = L1_6.Get
  L1_6 = L1_6(L2_7, "Hero")
  L2_7 = L1_6
  L1_6 = L1_6.On
  L1_6(L2_7, Logic.Hero.EVT.RANK_UP, A0_5:Event("clearLeftHeroInfo"))
  L2_7 = A0_5
  L1_6 = A0_5.initBtn
  L1_6(L2_7)
  L1_6 = A0_5.costMoneyTitle
  L2_7 = L1_6
  L1_6 = L1_6.setStyle
  L1_6(L2_7, kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  L1_6 = Logic
  L2_7 = L1_6
  L1_6 = L1_6.Get
  L1_6 = L1_6(L2_7, "ExplainEquip")
  L2_7 = L1_6
  L1_6 = L1_6.getEvolutionType
  L1_6 = L1_6(L2_7)
  L2_7 = _UPVALUE0_
  L2_7 = L2_7.MATERIAL_EVO
  if L1_6 == L2_7 then
    L2_7 = 104264
  else
    L2_7 = L2_7 or 104280
  end
  A0_5.costMoneyTitle:setString(TwGetStr(L2_7))
  A0_5:initHeroNotEnoughTitle()
  for _FORV_6_ = 1, #HERO_NOT_ENOUGH_TITLE do
    A0_5[HERO_NOT_ENOUGH_TITLE[_FORV_6_]]:setString(TwGetStr(104265))
  end
  _FOR_(_FOR_)
  if A0_5:judgeEvoType() then
    A0_5.imgBtnLeftBg:setVisible(false)
    A0_5.evolutionFunctionSprite:setVisible(false)
    A0_5.btnEvolutionFunction:setEnabled(false)
  else
    A0_5:setEvolutionTypeSprite()
    A0_5.aniButton = Logic:Get("AniMgr"):NewCCB("UI/UIcz02", A0_5.evolutionFunctionSprite, ccp(46, 17), 0, nil, nil)
    if A0_5.aniButton and Logic:Get("ExplainEquip"):getEvolutionType() == _UPVALUE0_.PAY_MONEY_EVO then
      A0_5.aniButton:RemoveAnimation()
    end
  end
end
function prototype.setEvolutionTypeSprite(A0_8)
  local L1_9, L2_10
  L1_9 = "images/public/moneyEvo.png"
  L2_10 = "images/public/materialEvo.png"
  if Logic:Get("ExplainEquip"):getEvolutionType() == _UPVALUE0_.PAY_MONEY_EVO then
    L1_9 = "images/public/materialEvo.png"
    L2_10 = "images/public/moneyEvo.png"
  end
  if CCSprite:create(L1_9) then
    A0_8.evolutionFunctionSprite:setDisplayFrame(CCSprite:create(L1_9):displayFrame())
  end
  if CCSprite:create(L2_10) then
    A0_8.mainTitleSprite:setDisplayFrame(CCSprite:create(L2_10):displayFrame())
    A0_8.mainTitleSprite:setScale(1.5)
  end
end
function prototype.bindAnimationMgr(A0_11)
  local L1_12
  L1_12 = true
  return L1_12
end
function prototype.completedAnimationSequenceNamed(A0_13, A1_14)
  if A1_14 ~= "Default Timeline" then
    return
  end
  A0_13:updateGuide()
end
function prototype.onBtnReturn(A0_15, A1_16, A2_17)
  SceneHelper:runWithScene("Home", A0_15.rootNode)
end
function prototype.ReFrashHeroInfo(A0_18, A1_19)
  if A1_19 == nil or next(A1_19) == nil then
    return
  end
  A0_18.titleInfo = A1_19
  if CCSprite:create(A1_19.respath) then
    A0_18.strategynodeflag:setDisplayFrame(CCSprite:create(A1_19.respath):displayFrame())
  end
  A0_18.strategynodetitle1:setString(TwGetStr(A0_18.titleInfo.title1) or "")
  A0_18.strategynodetitle2:setString(TwGetStr(A0_18.titleInfo.title2) or "")
end
function prototype.onBtnSelectHero(A0_20, A1_21, A2_22)
  Logic:Get("Main"):CuMengMainGuide("Evolution", "SelectHeroWait")
  Logic:Get("Guide"):done("Evolution", "SelectHeroWait")
  Logic:Get("Guide"):done("FightEvolution", "SelectHeroWait")
  SceneHelper:pushScene("SelectEvolutionHero", A0_20.rootNode)
end
function prototype.onBtnRight(A0_23, A1_24, A2_25)
  local L3_26
  L3_26 = {}
  L3_26.level = A0_23.hero.level
  L3_26.baseId = A0_23.info.nextId
  L3_26.powerSkill = A0_23.hero.powerSkill
  Logic:Get("HeroCardInfo"):OpenHeroInfo(L3_26)
end
function prototype.onBtnHelmet(A0_27, A1_28, A2_29)
  A0_27:getExplainInfo(1)
end
function prototype.onBtnArmour(A0_30, A1_31, A2_32)
  A0_30:getExplainInfo(2)
end
function prototype.onBtnGloves(A0_33, A1_34, A2_35)
  A0_33:getExplainInfo(3)
end
function prototype.onBtnTrousers(A0_36, A1_37, A2_38)
  A0_36:getExplainInfo(4)
end
function prototype.onBtnShose(A0_39, A1_40, A2_41)
  A0_39:getExplainInfo(5)
end
function prototype.getExplainInfo(A0_42, A1_43)
  if Logic:Get("CoordinatesSale"):getEquipAndHeroInfo(A1_43) == nil or Logic:Get("CoordinatesSale"):getEquipAndHeroInfo(A1_43).displayCardInfo == nil then
    return
  end
  if Logic:Get("CoordinatesSale"):getEquipAndHeroInfo(A1_43).heroCard ~= nil and Logic:Get("CoordinatesSale"):getEquipAndHeroInfo(A1_43).heroCard.locked then
    Prompt:Fail(TwGetStr(106028))
    return
  end
  if Logic:Get("CoordinatesSale"):getEquipAndHeroInfo(A1_43).IsBattling then
    Prompt:Fail(TwGetStr(106027))
    return
  end
  if Logic:Get("CoordinatesSale"):getEquipAndHeroInfo(A1_43).displayCardInfo.card == "HERO" and Logic:Get("CoordinatesSale"):getEquipAndHeroInfo(A1_43).card ~= nil then
    Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(Logic:Get("CoordinatesSale"):getEquipAndHeroInfo(A1_43).card)
  else
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(Logic:Get("CoordinatesSale"):getEquipAndHeroInfo(A1_43).displayCardInfo.id)
  end
end
function prototype.IsBattlingWithEvolutionMaterial(A0_44)
  local L1_45, L2_46, L3_47, L4_48, L5_49, L6_50
  L1_45 = false
  L2_46 = ""
  for L6_50 = 1, #L4_48 do
    if nil ~= Logic:Get("CoordinatesSale"):getEquipAndHeroInfo(L6_50) and (Logic:Get("CoordinatesSale"):getEquipAndHeroInfo(L6_50).IsBattling or Logic:Get("CoordinatesSale"):getEquipAndHeroInfo(L6_50).heroCard ~= nil and Logic:Get("CoordinatesSale"):getEquipAndHeroInfo(L6_50).heroCard.locked) then
      if Logic:Get("CoordinatesSale"):getEquipAndHeroInfo(L6_50).displayCardInfo ~= nil and Logic:Get("CoordinatesSale"):getEquipAndHeroInfo(L6_50).displayCardInfo.card == "HERO" then
        L2_46 = TwGetStr(106059, Logic:Get("CoordinatesSale"):getEquipAndHeroInfo(L6_50).displayCardInfo.star) .. Logic:Get("CoordinatesSale"):getEquipAndHeroInfo(L6_50).displayCardInfo.name
      end
      L1_45 = true
    end
  end
  return L3_47, L4_48
end
function prototype.IsEnoughByBaseId(A0_51, A1_52, A2_53)
  local L3_54, L4_55
  L3_54 = 0
  L4_55 = Logic
  L4_55 = L4_55.Get
  L4_55 = L4_55(L4_55, "Hero")
  L4_55 = L4_55.GetTotalCardByBaseId
  L4_55 = L4_55(L4_55, tonumber(A1_52))
  L4_55 = Logic:Get("ExplainEquip"):removeSelf(L4_55)
  for _FORV_9_ = 1, #L4_55 do
    if Logic:Get("Hero"):CheckHeroBattleOrGroup(L4_55[_FORV_9_]) or Logic:Get("Hero"):GetHeroInfosByIds(L4_55)[_FORV_9_].locked then
      L3_54 = L3_54 + 1
    end
  end
  if #L4_55 < A2_53 + L3_54 then
    return false
  end
  return true
end
function prototype.onBtnBeginEvolution(A0_56, A1_57, A2_58)
  local L3_59, L4_60, L5_61, L6_62, L7_63, L8_64, L9_65, L10_66, L11_67, L12_68, L13_69, L14_70
  L3_59 = Logic
  L4_60 = L3_59
  L3_59 = L3_59.Get
  L5_61 = "Main"
  L3_59 = L3_59(L4_60, L5_61)
  L4_60 = L3_59
  L3_59 = L3_59.CuMengMainGuide
  L5_61 = "Evolution"
  L6_62 = "Evolution"
  L3_59(L4_60, L5_61, L6_62)
  L3_59 = Logic
  L4_60 = L3_59
  L3_59 = L3_59.Get
  L5_61 = "Guide"
  L3_59 = L3_59(L4_60, L5_61)
  L4_60 = L3_59
  L3_59 = L3_59.done
  L5_61 = "Evolution"
  L6_62 = "Evolution"
  L3_59(L4_60, L5_61, L6_62)
  L3_59 = Logic
  L4_60 = L3_59
  L3_59 = L3_59.Get
  L5_61 = "Guide"
  L3_59 = L3_59(L4_60, L5_61)
  L4_60 = L3_59
  L3_59 = L3_59.done
  L5_61 = "FightEvolution"
  L6_62 = "Evolution"
  L3_59(L4_60, L5_61, L6_62)
  L3_59 = Logic
  L4_60 = L3_59
  L3_59 = L3_59.Get
  L5_61 = "ExplainEquip"
  L3_59 = L3_59(L4_60, L5_61)
  L4_60 = L3_59
  L3_59 = L3_59.AnalyseCondition
  L5_61 = A0_56.hero
  L6_62 = A0_56.info
  L3_59 = L3_59(L4_60, L5_61, L6_62)
  L4_60 = Logic
  L5_61 = L4_60
  L4_60 = L4_60.Get
  L6_62 = "ExplainEquip"
  L4_60 = L4_60(L5_61, L6_62)
  L5_61 = L4_60
  L4_60 = L4_60.getEvolutionType
  L4_60 = L4_60(L5_61)
  L5_61 = _UPVALUE0_
  L5_61 = L5_61.PAY_MONEY_EVO
  if L4_60 == L5_61 then
    if 106012 == L3_59 then
      L4_60 = Logic
      L5_61 = L4_60
      L4_60 = L4_60.Get
      L6_62 = "ExplainEquip"
      L4_60 = L4_60(L5_61, L6_62)
      L5_61 = L4_60
      L4_60 = L4_60.setNoEnoughCondition
      L6_62 = TwGetStr
      L14_70 = L6_62(L7_63)
      L4_60(L5_61, L6_62, L7_63, L8_64, L9_65, L10_66, L11_67, L12_68, L13_69, L14_70, L6_62(L7_63))
      L4_60 = Logic
      L5_61 = L4_60
      L4_60 = L4_60.Get
      L6_62 = "ExplainEquip"
      L4_60 = L4_60(L5_61, L6_62)
      L5_61 = L4_60
      L4_60 = L4_60.setNoEnoughCondition
      L6_62 = TwGetStr
      L14_70 = L6_62(L7_63)
      L4_60(L5_61, L6_62, L7_63, L8_64, L9_65, L10_66, L11_67, L12_68, L13_69, L14_70, L6_62(L7_63))
      L4_60 = Logic
      L5_61 = L4_60
      L4_60 = L4_60.Get
      L6_62 = "ExplainEquip"
      L4_60 = L4_60(L5_61, L6_62)
      L5_61 = L4_60
      L4_60 = L4_60.setNoEnoughCondition
      L6_62 = TwGetStr
      L14_70 = L6_62(L7_63)
      L4_60(L5_61, L6_62, L7_63, L8_64, L9_65, L10_66, L11_67, L12_68, L13_69, L14_70, L6_62(L7_63))
      L4_60 = SceneHelper
      L5_61 = L4_60
      L4_60 = L4_60.pushPrompt
      L6_62 = "HeroEvolutionTip"
      L4_60(L5_61, L6_62, L7_63)
      return
    end
    L4_60 = Logic
    L5_61 = L4_60
    L4_60 = L4_60.Get
    L6_62 = "PlayerInfo"
    L4_60 = L4_60(L5_61, L6_62)
    L5_61 = L4_60
    L4_60 = L4_60.GetPlayerAllJade
    L4_60 = L4_60(L5_61)
    L5_61 = A0_56.info
    L5_61 = L5_61.costGold
    if L4_60 < L5_61 then
      L5_61 = Prompt
      L6_62 = L5_61
      L5_61 = L5_61.Confirm
      L10_66 = Logic
      L11_67 = L10_66
      L10_66 = L10_66.Get
      L12_68 = "Main"
      L10_66 = L10_66(L11_67, L12_68)
      L10_66 = L10_66.GotoRecharge
      L11_67 = Prompt
      L11_67 = L11_67.PROMPT_TYPE
      L11_67 = L11_67.SELECT
      L5_61(L6_62, L7_63, L8_64, L9_65, L10_66, L11_67)
      return
    end
    L5_61 = Logic
    L6_62 = L5_61
    L5_61 = L5_61.Get
    L5_61 = L5_61(L6_62, L7_63)
    L6_62 = L5_61
    L5_61 = L5_61.CheckHeroBattleOrGroup
    L5_61 = L5_61(L6_62, L7_63)
    if L5_61 then
      L6_62 = A0_56
      L5_61 = A0_56.IsOverstepLeadership
      L5_61 = L5_61(L6_62)
      if L5_61 then
        L5_61 = Prompt
        L6_62 = L5_61
        L5_61 = L5_61.Confirm
        L10_66 = 106025
        L10_66 = A0_56.callBackGoldRankUp
        L11_67 = Prompt
        L11_67 = L11_67.PROMPT_TYPE
        L11_67 = L11_67.SELECT
        L5_61(L6_62, L7_63, L8_64, L9_65, L10_66, L11_67)
        return
      end
    else
      L5_61 = Logic
      L6_62 = L5_61
      L5_61 = L5_61.Get
      L5_61 = L5_61(L6_62, L7_63)
      L6_62 = L5_61
      L5_61 = L5_61.PostRankUpByGold
      L5_61(L6_62, L7_63)
      return
    end
  end
  if 106012 == L3_59 then
    L4_60 = Logic
    L5_61 = L4_60
    L4_60 = L4_60.Get
    L6_62 = "ExplainEquip"
    L4_60 = L4_60(L5_61, L6_62)
    L5_61 = L4_60
    L4_60 = L4_60.setNoEnoughCondition
    L6_62 = TwGetStr
    L14_70 = L6_62(L7_63)
    L4_60(L5_61, L6_62, L7_63, L8_64, L9_65, L10_66, L11_67, L12_68, L13_69, L14_70, L6_62(L7_63))
    L4_60 = Logic
    L5_61 = L4_60
    L4_60 = L4_60.Get
    L6_62 = "ExplainEquip"
    L4_60 = L4_60(L5_61, L6_62)
    L5_61 = L4_60
    L4_60 = L4_60.setNoEnoughCondition
    L6_62 = TwGetStr
    L14_70 = L6_62(L7_63)
    L4_60(L5_61, L6_62, L7_63, L8_64, L9_65, L10_66, L11_67, L12_68, L13_69, L14_70, L6_62(L7_63))
    L4_60 = Logic
    L5_61 = L4_60
    L4_60 = L4_60.Get
    L6_62 = "ExplainEquip"
    L4_60 = L4_60(L5_61, L6_62)
    L5_61 = L4_60
    L4_60 = L4_60.setNoEnoughCondition
    L6_62 = TwGetStr
    L14_70 = L6_62(L7_63)
    L4_60(L5_61, L6_62, L7_63, L8_64, L9_65, L10_66, L11_67, L12_68, L13_69, L14_70, L6_62(L7_63))
    L4_60 = SceneHelper
    L5_61 = L4_60
    L4_60 = L4_60.pushPrompt
    L6_62 = "HeroEvolutionTip"
    L4_60(L5_61, L6_62, L7_63)
    return
  elseif 106014 == L3_59 then
    L4_60 = Logic
    L5_61 = L4_60
    L4_60 = L4_60.Get
    L6_62 = "ExplainEquip"
    L4_60 = L4_60(L5_61, L6_62)
    L5_61 = L4_60
    L4_60 = L4_60.setNoEnoughCondition
    L6_62 = TwGetStr
    L14_70 = L6_62(L7_63)
    L4_60(L5_61, L6_62, L7_63, L8_64, L9_65, L10_66, L11_67, L12_68, L13_69, L14_70, L6_62(L7_63))
    L4_60 = Logic
    L5_61 = L4_60
    L4_60 = L4_60.Get
    L6_62 = "ExplainEquip"
    L4_60 = L4_60(L5_61, L6_62)
    L5_61 = L4_60
    L4_60 = L4_60.setNoEnoughCondition
    L6_62 = TwGetStr
    L14_70 = L6_62(L7_63)
    L4_60(L5_61, L6_62, L7_63, L8_64, L9_65, L10_66, L11_67, L12_68, L13_69, L14_70, L6_62(L7_63))
    L4_60 = Logic
    L5_61 = L4_60
    L4_60 = L4_60.Get
    L6_62 = "ExplainEquip"
    L4_60 = L4_60(L5_61, L6_62)
    L5_61 = L4_60
    L4_60 = L4_60.setNoEnoughCondition
    L6_62 = TwGetStr
    L14_70 = L6_62(L7_63)
    L4_60(L5_61, L6_62, L7_63, L8_64, L9_65, L10_66, L11_67, L12_68, L13_69, L14_70, L6_62(L7_63))
    L4_60 = SceneHelper
    L5_61 = L4_60
    L4_60 = L4_60.pushPrompt
    L6_62 = "HeroEvolutionTip"
    L4_60(L5_61, L6_62, L7_63)
    return
  elseif 106013 == L3_59 then
    L4_60 = json
    L4_60 = L4_60.decode
    L5_61 = A0_56.info
    L5_61 = L5_61.costHeros
    L4_60 = L4_60(L5_61)
    L5_61 = Logic
    L6_62 = L5_61
    L5_61 = L5_61.Get
    L5_61 = L5_61(L6_62, L7_63)
    L6_62 = L5_61
    L5_61 = L5_61.setNoEnoughCondition
    L14_70 = L7_63(L8_64)
    L5_61(L6_62, L7_63, L8_64, L9_65, L10_66, L11_67, L12_68, L13_69, L14_70, L7_63(L8_64))
    L6_62 = A0_56
    L5_61 = A0_56.IsBattlingWithEvolutionMaterial
    L6_62 = L5_61(L6_62)
    if L5_61 then
      L10_66 = L7_63
      L8_64(L9_65, L10_66)
      return
    end
    for L10_66, L11_67 in L7_63(L8_64) do
      L13_69 = A0_56
      L12_68 = A0_56.IsEnoughByBaseId
      L14_70 = L10_66
      L12_68 = L12_68(L13_69, L14_70, L11_67)
      if not L12_68 then
        L12_68 = KFDBGetRecord
        L13_69 = "BaseHero"
        L14_70 = L10_66
        L12_68 = L12_68(L13_69, L14_70)
        L13_69 = L12_68.name
        L14_70 = TwGetStr
        L14_70 = L14_70(106058)
        L13_69 = L13_69 .. L14_70
        L14_70 = L12_68.card
        if L14_70 ~= "TREASURE" then
          L14_70 = TwGetStr
          L14_70 = L14_70(106059, L12_68.star)
          L13_69 = L14_70 .. L13_69
        end
        L14_70 = Logic
        L14_70 = L14_70.Get
        L14_70 = L14_70(L14_70, "ExplainEquip")
        L14_70 = L14_70.setNoEnoughCondition
        L14_70(L14_70, L13_69)
        L14_70 = TwGetStr
        L14_70 = L14_70(106055)
        L14_70 = L14_70 .. L12_68.gain
        Logic:Get("ExplainEquip"):setNoEnoughCondition(L14_70)
      end
    end
    L10_66 = nil
    L7_63(L8_64, L9_65, L10_66)
    return
  end
  L4_60 = Logic
  L5_61 = L4_60
  L4_60 = L4_60.Get
  L6_62 = "Hero"
  L4_60 = L4_60(L5_61, L6_62)
  L5_61 = L4_60
  L4_60 = L4_60.CheckHeroBattleOrGroup
  L6_62 = A0_56.hero
  L6_62 = L6_62.id
  L4_60 = L4_60(L5_61, L6_62)
  if L4_60 then
    L5_61 = A0_56
    L4_60 = A0_56.IsOverstepLeadership
    L4_60 = L4_60(L5_61)
    if L4_60 then
      L4_60 = TwGetStr
      L5_61 = 106025
      L4_60 = L4_60(L5_61)
      L5_61 = Prompt
      L6_62 = L5_61
      L5_61 = L5_61.Confirm
      L10_66 = A0_56.InteractiveWithServ
      L11_67 = Prompt
      L11_67 = L11_67.PROMPT_TYPE
      L11_67 = L11_67.SELECT
      L5_61(L6_62, L7_63, L8_64, L9_65, L10_66, L11_67)
    end
  else
    L5_61 = A0_56
    L4_60 = A0_56.InteractiveWithServ
    L4_60(L5_61)
  end
end
function prototype.callBackGoldRankUp(A0_71)
  Logic:Get("Hero"):PostRankUpByGold(A0_71.hero.id)
end
function prototype.InteractiveWithServ(A0_72)
  Logic:Get("Hero"):PostRankUp(A0_72.hero.id)
end
function prototype.IsOverstepLeadership(A0_73)
  local L1_74, L2_75
  L1_74 = Logic
  L2_75 = L1_74
  L1_74 = L1_74.Get
  L1_74 = L1_74(L2_75, "Hero")
  L2_75 = L1_74
  L1_74 = L1_74.GetLeadership
  L1_74 = L1_74(L2_75)
  L2_75 = Logic
  L2_75 = L2_75.Get
  L2_75 = L2_75(L2_75, "Hero")
  L2_75 = L2_75.GetHeroGroupId
  L2_75 = L2_75(L2_75)
  return L1_74 < Logic:Get("Hero"):GetLeadershipByGroupId(L2_75) - A0_73.info.leadership + A0_73.nextheroinfo.leadership
end
function prototype.setAniCardItem(A0_76, A1_77, A2_78, A3_79)
  local L4_80, L5_81, L6_82
  L4_80 = Logic
  L5_81 = L4_80
  L4_80 = L4_80.Get
  L6_82 = "HeroCardInfo"
  L4_80 = L4_80(L5_81, L6_82)
  L5_81 = L4_80
  L4_80 = L4_80.createHeroCardForByFight
  L6_82 = A1_77
  L4_80 = L4_80(L5_81, L6_82)
  L5_81 = 0
  L6_82 = 0
  if A3_79 then
    L5_81, L6_82 = Logic:Get("HeroCardInfo"):GetCardTexture(L4_80, L4_80:getContentSize())
  else
    L5_81, L6_82 = Logic:Get("HeroCardInfo"):GetCardTexture(L4_80, A0_76.ani:GetChild(A2_78):getContentSize())
  end
  A0_76.ani:GetChild(A2_78):setTexture(L5_81)
  A0_76.ani:GetChild(A2_78):setTextureRect(L6_82)
end
function prototype.setAniCard(A0_83)
  local L1_84, L2_85, L3_86, L4_87
  L4_87 = "imgIn"
  L1_84(L2_85, L3_86, L4_87, true)
  L4_87 = "imgOut"
  L1_84(L2_85, L3_86, L4_87, true)
  if L1_84 == L2_85 then
    for L4_87 = 1, #L2_85 do
      A0_83.ani:GetChild(_UPVALUE1_[L4_87]):setVisible(false)
    end
    return
  end
  for L4_87 = 1, L2_85.costCount do
    A0_83:setAniCardItem(A0_83.aniInfo.card[tostring(L4_87)], _UPVALUE1_[L4_87], false)
  end
  for L4_87 = L1_84 + 1, #L2_85 do
    A0_83.ani:GetChild(_UPVALUE1_[L4_87]):setVisible(false)
  end
end
function prototype.addAnimation(A0_88)
  local L1_89
  L1_89 = Logic
  L1_89 = L1_89.Get
  L1_89 = L1_89(L1_89, "System")
  L1_89 = L1_89.IsUpgradeAniEnabled
  L1_89 = L1_89(L1_89)
  if not L1_89 then
    L1_89 = A0_88.onBtnCloseAni
    L1_89(A0_88)
    return
  end
  L1_89 = SceneHelper
  L1_89 = L1_89.getRootLayer
  L1_89 = L1_89(L1_89)
  A0_88.ani = Logic:Get("AniMgr"):NewCCB("UI/uiyxsj", L1_89, nil, 1)
  A0_88.ani:GetChild("imgLevelTip"):setDisplayFrame(CCSprite:create("images/Effect/UIhl/xj.png"):displayFrame())
  A0_88.ani:GetChild("imgLevelTip"):setAnchorPoint(CCPoint(0.5, 0.5))
  A0_88.ani:GetChild("imgLevelTip"):setVisible(false)
  A0_88.ani:GetChild("staLevel"):setVisible(false)
  A0_88.ani:GetChild("imgAttackTip"):setVisible(false)
  A0_88.ani:GetChild("staAttack"):setVisible(false)
  A0_88.ani:GetChild("imgLifeTip"):setVisible(false)
  A0_88.ani:GetChild("staLife"):setVisible(false)
  A0_88.ani:GetChild("imgBg1"):setVisible(false)
  A0_88.ani:GetChild("imgBg2"):setVisible(false)
  A0_88.ani:GetChild("imgBg3"):setVisible(false)
  A0_88:setAniCard()
  A0_88.ani:SetCloseCallback(A0_88, A0_88.onBtnCloseAni)
  A0_88.ani:GetChild("btnClose"):setEnabled(false)
  Logic:Get("BGSound"):SwitchMusic("audio/up.mp3", false)
  A0_88.ani:SetWaitSignByDefaultAniName(function()
    local L0_90, L1_91, L2_92, L3_93
    L0_90 = _UPVALUE0_
    L0_90 = L0_90.ani
    L1_91 = L0_90
    L0_90 = L0_90.GetChild
    L2_92 = "imgLevelTip"
    L0_90 = L0_90(L1_91, L2_92)
    L1_91 = L0_90
    L0_90 = L0_90.setVisible
    L2_92 = true
    L0_90(L1_91, L2_92)
    L0_90 = _UPVALUE0_
    L0_90 = L0_90.ani
    L1_91 = L0_90
    L0_90 = L0_90.GetChild
    L2_92 = "staLevel"
    L0_90 = L0_90(L1_91, L2_92)
    L1_91 = L0_90
    L0_90 = L0_90.setVisible
    L2_92 = true
    L0_90(L1_91, L2_92)
    L0_90 = _UPVALUE0_
    L0_90 = L0_90.ani
    L1_91 = L0_90
    L0_90 = L0_90.GetChild
    L2_92 = "imgAttackTip"
    L0_90 = L0_90(L1_91, L2_92)
    L1_91 = L0_90
    L0_90 = L0_90.setVisible
    L2_92 = true
    L0_90(L1_91, L2_92)
    L0_90 = _UPVALUE0_
    L0_90 = L0_90.ani
    L1_91 = L0_90
    L0_90 = L0_90.GetChild
    L2_92 = "staAttack"
    L0_90 = L0_90(L1_91, L2_92)
    L1_91 = L0_90
    L0_90 = L0_90.setVisible
    L2_92 = true
    L0_90(L1_91, L2_92)
    L0_90 = _UPVALUE0_
    L0_90 = L0_90.ani
    L1_91 = L0_90
    L0_90 = L0_90.GetChild
    L2_92 = "imgLifeTip"
    L0_90 = L0_90(L1_91, L2_92)
    L1_91 = L0_90
    L0_90 = L0_90.setVisible
    L2_92 = true
    L0_90(L1_91, L2_92)
    L0_90 = _UPVALUE0_
    L0_90 = L0_90.ani
    L1_91 = L0_90
    L0_90 = L0_90.GetChild
    L2_92 = "staLife"
    L0_90 = L0_90(L1_91, L2_92)
    L1_91 = L0_90
    L0_90 = L0_90.setVisible
    L2_92 = true
    L0_90(L1_91, L2_92)
    L0_90 = _UPVALUE0_
    L0_90 = L0_90.ani
    L1_91 = L0_90
    L0_90 = L0_90.GetChild
    L2_92 = "imgBg1"
    L0_90 = L0_90(L1_91, L2_92)
    L1_91 = L0_90
    L0_90 = L0_90.setVisible
    L2_92 = true
    L0_90(L1_91, L2_92)
    L0_90 = _UPVALUE0_
    L0_90 = L0_90.ani
    L1_91 = L0_90
    L0_90 = L0_90.GetChild
    L2_92 = "imgBg2"
    L0_90 = L0_90(L1_91, L2_92)
    L1_91 = L0_90
    L0_90 = L0_90.setVisible
    L2_92 = true
    L0_90(L1_91, L2_92)
    L0_90 = _UPVALUE0_
    L0_90 = L0_90.ani
    L1_91 = L0_90
    L0_90 = L0_90.GetChild
    L2_92 = "imgBg3"
    L0_90 = L0_90(L1_91, L2_92)
    L1_91 = L0_90
    L0_90 = L0_90.setVisible
    L2_92 = true
    L0_90(L1_91, L2_92)
    L0_90 = _UPVALUE0_
    L0_90 = L0_90.ani
    L1_91 = L0_90
    L0_90 = L0_90.GetChild
    L2_92 = "imgGai"
    L0_90 = L0_90(L1_91, L2_92)
    L1_91 = L0_90
    L0_90 = L0_90.setVisible
    L2_92 = false
    L0_90(L1_91, L2_92)
    L0_90 = _UPVALUE0_
    L0_90 = L0_90.ani
    L1_91 = L0_90
    L0_90 = L0_90.GetChild
    L2_92 = "imgBody"
    L0_90 = L0_90(L1_91, L2_92)
    L1_91 = L0_90
    L0_90 = L0_90.setVisible
    L2_92 = false
    L0_90(L1_91, L2_92)
    L0_90 = Logic
    L1_91 = L0_90
    L0_90 = L0_90.Get
    L2_92 = "Hero"
    L0_90 = L0_90(L1_91, L2_92)
    L1_91 = L0_90
    L0_90 = L0_90.GetHeroLifeAndAttack
    L2_92 = _UPVALUE0_
    L2_92 = L2_92.hero
    L2_92 = L2_92.baseId
    L3_93 = _UPVALUE0_
    L3_93 = L3_93.hero
    L3_93 = L3_93.level
    L1_91 = L0_90(L1_91, L2_92, L3_93)
    L2_92 = Logic
    L3_93 = L2_92
    L2_92 = L2_92.Get
    L2_92 = L2_92(L3_93, "Hero")
    L3_93 = L2_92
    L2_92 = L2_92.GetHeroLifeAndAttack
    L3_93 = L2_92(L3_93, _UPVALUE0_.info.nextId, _UPVALUE0_.info.level)
    if L0_90 and L1_91 and L2_92 and L3_93 then
      _UPVALUE0_.ani:GetChild("staAttack"):create(L1_91)
      _UPVALUE0_.ani:GetChild("staLife"):create(L0_90)
      _UPVALUE0_.ani:GetChild("staLevel"):create(_UPVALUE0_.info.star)
      _UPVALUE0_.ani:GetChild("staAttack"):setCallback(bind(_UPVALUE0_.aniFrontEnd, _UPVALUE0_))
      _UPVALUE0_.ani:GetChild("staLevel"):setValueAni(_UPVALUE0_.nextheroinfo.star, 2000)
      _UPVALUE0_.ani:GetChild("staAttack"):setValueAni(L3_93, 2000)
      _UPVALUE0_.ani:GetChild("staLife"):setValueAni(L2_92, 2000)
    end
  end, 5000)
  A0_88.ani:RunAnimationWithoutWait()
end
function prototype.aniFrontEnd(A0_94)
  local L1_95, L2_96
  L1_95 = A0_94.ani
  L2_96 = L1_95
  L1_95 = L1_95.GetChild
  L1_95 = L1_95(L2_96, "btnClose")
  L2_96 = L1_95
  L1_95 = L1_95.setEnabled
  L1_95(L2_96, true)
  L1_95 = CCSprite
  L2_96 = L1_95
  L1_95 = L1_95.create
  L1_95 = L1_95(L2_96, "images/font/click_go_on.png")
  if L1_95 ~= nil then
    L2_96 = A0_94.ani
    L2_96 = L2_96.GetLayer
    L2_96 = L2_96(L2_96)
    L2_96 = L2_96.addChild
    L2_96(L2_96, L1_95, 0, 10)
    L2_96 = Logic
    L2_96 = L2_96.Get
    L2_96 = L2_96(L2_96, "Gift")
    L2_96 = L2_96.fadetoSpr
    L2_96 = L2_96(L2_96)
    L1_95:runAction(CCRepeatForever:create(L2_96))
    L1_95:setPosition(A0_94.ani:GetChild("ttfGoOn"):getPosition())
  end
end
function prototype.onBtnCloseAni(A0_97)
  if A0_97.ani then
    A0_97.ani:RemoveAnimation()
    A0_97.ani = nil
  end
  Logic:Get("BGSound"):stopAllEffect()
  Logic:Get("BGSound"):PlayBGMusic()
  if Logic:Get("Hero"):isEvoHunting() then
    Logic:Get("Hero"):setEvoHunting(false)
    Logic:Get("Guide"):check()
    return
  end
  Logic:Get("WeChat"):OpenWeChat()
end
function prototype.cleanLeftUI(A0_98)
  local L1_99, L2_100, L3_101, L4_102
  for L4_102 = 1, #L2_100 do
    A0_98:setEquipByStr(EQUIP_BG_PATH, L4_102)
    A0_98:setCardQuatilyByStr(EQUIP_BG_PATH, L4_102)
  end
  L4_102 = ""
  L1_99(L2_100, L3_101, L4_102, "", "", "")
  L4_102 = 255
  L4_102 = L3_101(L4_102, 255, 255)
  L1_99(L2_100, L3_101, L4_102, L3_101(L4_102, 255, 255))
  L4_102 = true
  L1_99(L2_100, L3_101, L4_102)
  for L4_102 = 1, #L2_100 do
    A0_98[BTN_SET[L4_102]]:setEnabled(false)
  end
end
function prototype.clearLeftHeroInfo(A0_103)
  A0_103:addAnimation()
  A0_103.imgArrowHead:setVisible(false)
  A0_103:cleanLeftUI()
end
function prototype.setPic(A0_104, A1_105)
  A0_104.selectHeroTag = true
  A0_104.imgArrowHead:setVisible(true)
  A0_104.aniInfo = {}
  A0_104:getHeroInfo(A1_105)
  if Logic:Get("ExplainEquip"):getEvolutionType() == _UPVALUE0_.MATERIAL_EVO then
    A0_104:getEquImg()
  end
end
function prototype.getHeroInfo(A0_106, A1_107)
  local L2_108, L3_109, L4_110, L5_111
  A0_106.hero = A1_107
  L2_108 = Logic
  L3_109 = L2_108
  L2_108 = L2_108.Get
  L4_110 = "Hero"
  L2_108 = L2_108(L3_109, L4_110)
  L3_109 = L2_108
  L2_108 = L2_108.GetHeroInfoByBaseId
  L4_110 = A1_107.baseId
  L2_108 = L2_108(L3_109, L4_110)
  A0_106.info = L2_108
  L2_108 = A0_106.info
  if L2_108 ~= nil then
    L3_109 = L2_108.nextId
  elseif L3_109 <= 0 then
    return
  end
  L3_109 = Logic
  L4_110 = L3_109
  L3_109 = L3_109.Get
  L5_111 = "Hero"
  L3_109 = L3_109(L4_110, L5_111)
  L4_110 = L3_109
  L3_109 = L3_109.GetHeroInfoByBaseId
  L5_111 = L2_108.nextId
  L3_109 = L3_109(L4_110, L5_111)
  if L3_109 == nil then
    return
  end
  A0_106.nextheroinfo = L3_109
  L5_111 = A0_106
  L4_110 = A0_106.getHeroCardImg
  L4_110(L5_111, L2_108)
  L4_110 = A0_106.btnright
  L5_111 = L4_110
  L4_110 = L4_110.setEnabled
  L4_110(L5_111, true)
  L5_111 = A0_106
  L4_110 = A0_106.setHeroInfo
  L4_110(L5_111, L2_108, L3_109)
  L4_110 = A0_106.costMoney
  L5_111 = L4_110
  L4_110 = L4_110.setStyle
  L4_110(L5_111, kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  L4_110 = Logic
  L5_111 = L4_110
  L4_110 = L4_110.Get
  L4_110 = L4_110(L5_111, "ExplainEquip")
  L5_111 = L4_110
  L4_110 = L4_110.getEvolutionType
  L4_110 = L4_110(L5_111)
  L5_111 = Logic
  L5_111 = L5_111.Get
  L5_111 = L5_111(L5_111, "ExplainEquip")
  L5_111 = L5_111.getEvolutionType
  L5_111 = L5_111(L5_111)
  if L5_111 == _UPVALUE0_.PAY_MONEY_EVO then
    L5_111 = A0_106.info
    L5_111 = L5_111.costGold
  elseif not L5_111 then
    L5_111 = A0_106.info
    L5_111 = L5_111.costCoins
  end
  A0_106.costMoney:setString(tostring(L5_111))
  A0_106.costMoney:setColor(ccc3(30, 240, 0))
  if Logic:Get("ExplainEquip"):getEvolutionType() == _UPVALUE0_.MATERIAL_EVO and A0_106.info.costCoins > Logic:Get("PlayerInfo"):GetPlayerMoney().copper then
    A0_106.costMoney:setColor(ccc3(255, 0, 0))
  end
  A0_106.btnbeginevolution:setEnabled(true)
end
function sortFuncForBattle(A0_112, A1_113)
  if not Logic:Get("Hero"):CheckHeroBattleOrGroup(A0_112) and Logic:Get("Hero"):CheckHeroBattleOrGroup(A1_113) then
    return true
  end
  return false
end
function prototype.sortforBattling(A0_114, A1_115)
  table.sort(A1_115, sortFuncForBattle)
  return A1_115
end
function prototype.removeSelf(A0_116, A1_117)
  local L2_118, L3_119, L4_120, L5_121, L6_122
  L2_118 = {}
  for L6_122 = 1, #A1_117 do
    if A0_116.hero.id == A1_117[L6_122] then
      table.remove(A1_117, L6_122)
      break
    end
  end
  L2_118 = A1_117
  return L2_118
end
function prototype.setAllCardImg(A0_123, A1_124)
  local L2_125, L3_126, L4_127, L5_128, L6_129, L7_130, L8_131, L9_132, L10_133, L11_134, L12_135, L13_136, L14_137, L15_138, L16_139
  L2_125 = A1_124
  L3_126 = {}
  if L4_127 ~= 0 then
    L3_126 = L4_127
  end
  L4_127(L5_128)
  for L7_130, L8_131 in L4_127(L5_128) do
    L9_132 = Logic
    L10_133 = L9_132
    L9_132 = L9_132.Get
    L11_134 = "Hero"
    L9_132 = L9_132(L10_133, L11_134)
    L10_133 = L9_132
    L9_132 = L9_132.GetTotalCardByBaseId
    L11_134 = tonumber
    L16_139 = L11_134(L12_135)
    L9_132 = L9_132(L10_133, L11_134, L12_135, L13_136, L14_137, L15_138, L16_139, L11_134(L12_135))
    L11_134 = A0_123
    L10_133 = A0_123.removeSelf
    L10_133 = L10_133(L11_134, L12_135)
    L9_132 = L10_133
    L11_134 = A0_123
    L10_133 = A0_123.sortforBattling
    L10_133 = L10_133(L11_134, L12_135)
    L9_132 = L10_133
    L10_133 = Logic
    L11_134 = L10_133
    L10_133 = L10_133.Get
    L10_133 = L10_133(L11_134, L12_135)
    L11_134 = L10_133
    L10_133 = L10_133.GetHeroInfosByIds
    L10_133 = L10_133(L11_134, L12_135)
    if L10_133 ~= nil then
      L11_134 = #L10_133
    else
      if L8_131 > L11_134 then
        A0_123.AbilityEvolutionTag = false
    end
    else
      L11_134 = A0_123.sortTotalHeros
      L11_134 = L11_134(L12_135, L13_136)
      L10_133 = L11_134
    end
    L11_134 = {}
    for L15_138, L16_139 in L12_135(L13_136) do
      if not Logic:Get("Hero"):CheckHeroBattleOrGroup(L10_133[L15_138].id) and not L16_139.locked then
        table.insert(L11_134, L16_139)
      end
    end
    for L15_138 = 1, L8_131 do
      L16_139 = EQUIP_CARD_MAX
      if A1_124 > L16_139 then
        return
      end
      L16_139 = BTN_SET
      L16_139 = L16_139[A1_124]
      L16_139 = A0_123[L16_139]
      L16_139 = L16_139.setEnabled
      L16_139(L16_139, true)
      L16_139 = Logic
      L16_139 = L16_139.Get
      L16_139 = L16_139(L16_139, "Hero")
      L16_139 = L16_139.GetHeroInfoByBaseId
      L16_139 = L16_139(L16_139, tonumber(L7_130))
      if L16_139 == nil then
        return
      end
      A0_123:setCardImg(L16_139, A1_124)
      if #L9_132 - L15_138 < 0 then
        Logic:Get("CoordinatesSale"):setEquipAndHeroInfo(A1_124, nil, L16_139, false, L10_133[L15_138])
        A0_123[HERO_NOT_ENOUGH_TITLE[A1_124]]:setVisible(true)
      elseif table.empty(L11_134) then
        A0_123[HERO_NOT_ENOUGH_TITLE[A1_124]]:setVisible(true)
        Logic:Get("CoordinatesSale"):setEquipAndHeroInfo(A1_124, L10_133[L15_138], L16_139, true, L10_133[L15_138])
      else
        Logic:Get("CoordinatesSale"):setEquipAndHeroInfo(A1_124, L11_134[L15_138], L16_139, false, L11_134[L15_138])
      end
      A1_124 = A1_124 + 1
    end
  end
  L2_125 = A1_124
  L4_127.costCount = L5_128
  return L2_125
end
function prototype.getEquImg(A0_140)
  local L1_141
  L1_141 = 1
  L1_141 = A0_140:setAllCardImg(L1_141)
  if A0_140:IsAbilityEvolution() then
    A0_140:updateGuide()
    A0_140.btnbeginevolution:setEnabled(true)
  end
end
function prototype.sortTotalHeros(A0_142, A1_143)
  table.sort(A1_143, sortFunc)
  return A1_143
end
function sortFunc(A0_144, A1_145)
  return A0_144.level < A1_145.level
end
function prototype.setCardImg(A0_146, A1_147, A2_148)
  local L3_149, L4_150
  if A1_147 == nil then
    L3_149 = #A1_147
    if L3_149 == 0 then
      return
    end
  end
  L3_149 = Logic
  L4_150 = L3_149
  L3_149 = L3_149.Get
  L3_149 = L3_149(L4_150, "Hero")
  L4_150 = L3_149
  L3_149 = L3_149.GetHeroImage
  L3_149 = L3_149(L4_150, A1_147.id, Logic.Hero.HEROIMG_SIZE.MIDDLE)
  L4_150 = A0_146.setEquipByStr
  L4_150(A0_146, L3_149, A2_148)
  L4_150 = Logic
  L4_150 = L4_150.Get
  L4_150 = L4_150(L4_150, "Hero")
  L4_150 = L4_150.GetHeroBgImage
  L4_150 = L4_150(L4_150, A1_147.id, Logic.Hero.HEROIMG_SIZE.MIDDLE, false)
  if L4_150 ~= nil then
    A0_146:setCardQuatilyByStr(L4_150, A2_148)
  end
  A0_146.aniInfo.card[tostring(A2_148)] = A1_147.id
end
function prototype.IsAbilityEvolution(A0_151)
  A0_151.AbilityEvolutionTag = 106011 == Logic:Get("ExplainEquip"):AnalyseCondition(A0_151.hero, A0_151.info)
  return A0_151.AbilityEvolutionTag
end
function prototype.setEquipByStr(A0_152, A1_153, A2_154)
  A0_152[BNT_SPRITE[A2_154]]:setDisplayFrame(CCSprite:create(A1_153):displayFrame())
  A0_152[BNT_SPRITE[A2_154]]:setAnchorPoint(CCPoint(0.5, 0.5))
end
function prototype.setCardQuatilyByStr(A0_155, A1_156, A2_157)
  A0_155[QUALITY_CARD[A2_157]]:setDisplayFrame(CCSprite:create(A1_156):displayFrame())
  A0_155[QUALITY_CARD[A2_157]]:setAnchorPoint(CCPoint(0.5, 0.5))
end
function prototype.initBtn(A0_158)
  local L1_159, L3_160
  for _FORV_4_ = 1, #L3_160 do
    A0_158[BTN_SET[_FORV_4_]]:setEnabled(false)
  end
end
function prototype.setHeroInfo(A0_161, A1_162, A2_163)
  local L3_164, L4_165, L5_166, L6_167, L7_168, L8_169
  L3_164 = Logic
  L4_165 = L3_164
  L3_164 = L3_164.Get
  L5_166 = "Hero"
  L3_164 = L3_164(L4_165, L5_166)
  L4_165 = L3_164
  L3_164 = L3_164.GetHeroLifeAndAttack
  L5_166 = A1_162.nextId
  L6_167 = A1_162.level
  L4_165 = L3_164(L4_165, L5_166, L6_167)
  L5_166 = KFDBGetRecord
  L6_167 = "SkillConfig"
  L7_168 = A0_161.hero
  L7_168 = L7_168.powerSkill
  L5_166 = L5_166(L6_167, L7_168)
  L6_167 = KFDBGetRecord
  L7_168 = "SkillConfig"
  L8_169 = A2_163.powerSkill
  L6_167 = L6_167(L7_168, L8_169)
  if nil == L5_166 or nil == L6_167 then
    return
  end
  if L3_164 and L4_165 then
    L7_168 = A0_161.rranktitle
    L8_169 = L7_168
    L7_168 = L7_168.setString
    L7_168(L8_169, tostring(A1_162.level) .. "/" .. tostring(A2_163.level))
    L7_168 = A0_161.rhealthtitle
    L8_169 = L7_168
    L7_168 = L7_168.setString
    L7_168(L8_169, tostring(L3_164))
    L7_168 = A0_161.rfighttitle
    L8_169 = L7_168
    L7_168 = L7_168.setString
    L7_168(L8_169, tostring(L4_165))
    L7_168 = A0_161.rLeaderTitle
    L8_169 = L7_168
    L7_168 = L7_168.setString
    L7_168(L8_169, tostring(A2_163.leadership))
  end
  L7_168 = Logic
  L8_169 = L7_168
  L7_168 = L7_168.Get
  L7_168 = L7_168(L8_169, "Hero")
  L8_169 = L7_168
  L7_168 = L7_168.GetHeroLifeAndAttack
  L8_169 = L7_168(L8_169, A0_161.hero.baseId, A0_161.hero.level)
  if L7_168 and L8_169 then
    A0_161:setLeftHeroInfo(tostring(A1_162.star), tostring(A0_161.hero.level) .. "/" .. tostring(A1_162.level), tostring(L7_168), tostring(L8_169), tostring(A1_162.leadership))
  end
end
function prototype.setLeftHeroInfo(A0_170, A1_171, A2_172, A3_173, A4_174, A5_175)
  if A0_170.selectHeroTag == true and 106012 == Logic:Get("ExplainEquip"):AnalyseCondition(A0_170.hero, A0_170.info) then
    A0_170.lranktitle:setColor(ccc3(255, 0, 0))
  end
  A0_170.lranktitle:setString(A2_172)
  A0_170.lhealthtitle:setString(A3_173)
  A0_170.lfighttitle:setString(A4_174)
  A0_170.lLeaderTitle:setString(A5_175)
end
function prototype.setRightHeroInfo(A0_176, A1_177, A2_178, A3_179, A4_180, A5_181)
  A0_176.rranktitle:setString(A1_177)
  A0_176.rRanktitle1:setString(A2_178)
  A0_176.rhealthtitle:setString(A3_179)
  A0_176.rfighttitle:setString(A4_180)
  A0_176.rLeaderTitle:setString(A5_181)
end
function prototype.getHeroCardImg(A0_182, A1_183)
  local L2_184, L3_185
  L2_184 = Logic
  L3_185 = L2_184
  L2_184 = L2_184.Get
  L2_184 = L2_184(L3_185, "HeroCardInfo")
  L3_185 = L2_184
  L2_184 = L2_184.createHeroCard
  L2_184 = L2_184(L3_185, A0_182.hero.baseId, 200)
  L3_185 = Logic
  L3_185 = L3_185.Get
  L3_185 = L3_185(L3_185, "HeroCardInfo")
  L3_185 = L3_185.createHeroCard
  L3_185 = L3_185(L3_185, A1_183.nextId, 200)
  ;({}).imgIn = A0_182.hero.baseId
  ;({}).imgOut = A1_183.nextId
  A0_182.aniInfo.card = {}
  A0_182.leftCardTag = 1
  A0_182.rightCardTag = 2
  L2_184:setAnchorPoint(CCPoint(0.5, 0.5))
  L3_185:setAnchorPoint(CCPoint(0.5, 0.5))
  if HAVE_HERO_IMG then
    A0_182.layer:removeChildByTag(A0_182.leftCardTag, true)
    A0_182.layer:removeChildByTag(A0_182.rightCardTag, true)
    A0_182:initAllInfo()
  end
  A0_182.layer:addChild(L2_184, 0, A0_182.leftCardTag)
  A0_182.layer:addChild(L3_185, 0, A0_182.rightCardTag)
  HAVE_HERO_IMG = true
  L2_184:setPosition(A0_182.btnselecthero:getPosition())
  L3_185:setPosition(A0_182.btnright:getPosition())
end
function prototype.initAllInfo(A0_186)
  local L1_187, L2_188, L3_189, L4_190
  for L4_190 = 1, #L2_188 do
    A0_186:setEquipByStr(EQUIP_BG_PATH, L4_190)
    A0_186:setCardQuatilyByStr(EQUIP_BG_PATH, L4_190)
  end
  L1_187(L2_188)
  L4_190 = ""
  L1_187(L2_188, L3_189, L4_190, "", "", "")
  L4_190 = 251
  L4_190 = L3_189(L4_190, 251, 90)
  L1_187(L2_188, L3_189, L4_190, L3_189(L4_190, 251, 90))
  L4_190 = ""
  L1_187(L2_188, L3_189, L4_190, "", "", "")
  for L4_190 = 1, #L2_188 do
    A0_186[HERO_NOT_ENOUGH_TITLE[L4_190]]:setVisible(false)
  end
  L1_187(L2_188, L3_189)
end
function prototype.initHeroNotEnoughTitle(A0_191)
  local L1_192, L3_193
  for _FORV_4_ = 1, #L3_193 do
    A0_191[HERO_NOT_ENOUGH_TITLE[_FORV_4_]]:setVisible(false)
  end
end
function prototype.InitTitleOutline(A0_194)
  local L1_195, L2_196, L3_197, L4_198, L5_199, L6_200, L7_201
  for L4_198 = 1, #L2_196 do
    L5_199 = _UPVALUE0_
    L5_199 = L5_199[L4_198]
    L5_199 = A0_194[L5_199]
    L6_200 = L5_199
    L5_199 = L5_199.setStyle
    L7_201 = kCCLabelTTFStyleOutline
    L5_199(L6_200, L7_201, ccc3(0, 0, 0))
  end
  for L4_198 = 1, #L2_196 do
    L5_199 = HERO_NOT_ENOUGH_TITLE
    L5_199 = L5_199[L4_198]
    L5_199 = A0_194[L5_199]
    L6_200 = L5_199
    L5_199 = L5_199.setStyle
    L7_201 = kCCLabelTTFStyleOutline
    L5_199(L6_200, L7_201, ccc3(0, 0, 0))
  end
end
function prototype.updateGuide(A0_202)
  if Logic:Get("Guide"):isActive("Evolution", "SelectHeroWait") then
    Logic:Get("Guide"):lockTouch(A0_202.btnselecthero)
  end
  if Logic:Get("Guide"):isActive("Evolution", "Evolution") then
    Logic:Get("Hero"):setEvoHunting(true)
    Logic:Get("Guide"):lockTouch(A0_202.btnbeginevolution)
  end
  if Logic:Get("Guide"):isActive("FightEvolution", "SelectHeroWait") then
    Logic:Get("Guide"):lockTouch(A0_202.btnselecthero)
  end
  if Logic:Get("Guide"):isActive("FightEvolution", "Evolution") then
    Logic:Get("Hero"):setEvoHunting(true)
    Logic:Get("Guide"):lockTouch(A0_202.btnbeginevolution)
  end
end
function prototype.onBtnEvolutionFunction(A0_203, A1_204, A2_205)
  A0_203.animationMgr:runAnimations("Default Timeline")
  if A0_203:judgeEvoType() then
    A0_203.imgBtnLeftBg:setVisible(false)
    A0_203.evolutionFunctionSprite:setVisible(false)
    A0_203.btnEvolutionFunction:setEnabled(false)
    Logic:Get("ExplainEquip"):setEvolutionType(_UPVALUE0_.MATERIAL_EVO)
    if CCSprite:create("images/font/HeroAdvaence.png") then
      A0_203.mainTitleSprite:setDisplayFrame(CCSprite:create("images/font/HeroAdvaence.png"):displayFrame())
      A0_203.mainTitleSprite:setScale(1)
    end
    return
  end
  if Logic:Get("ExplainEquip"):getEvolutionType() == _UPVALUE0_.MATERIAL_EVO then
    Logic:Get("ExplainEquip"):setEvolutionType(_UPVALUE0_.PAY_MONEY_EVO)
    A0_203.aniButton:RemoveAnimation()
    A0_203.costMoneyTitle:setString(TwGetStr(104280))
    A0_203:cleanAllNodeForUI()
  else
    Logic:Get("ExplainEquip"):setEvolutionType(_UPVALUE0_.MATERIAL_EVO)
    A0_203.aniButton = Logic:Get("AniMgr"):NewCCB("UI/UIcz02", A0_203.evolutionFunctionSprite, ccp(46, 17), 0, nil, nil)
    A0_203.costMoneyTitle:setString(TwGetStr(104264))
    A0_203:cleanAllNodeForUI()
  end
  A0_203:setEvolutionTypeSprite()
end
function prototype.cleanAllNodeForUI(A0_206)
  if A0_206.selectHeroTag == true then
    A0_206.layer:removeChildByTag(A0_206.leftCardTag, true)
    A0_206.layer:removeChildByTag(A0_206.rightCardTag, true)
  end
  A0_206:initAllInfo()
  A0_206.imgArrowHead:setVisible(false)
end
function prototype.judgeEvoType(A0_207)
  return Logic:Get("Lock"):checkStatusById("GOLD_EVOLUTION")
end
