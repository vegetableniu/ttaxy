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
L0_0 = 145
function prototype.onEnter(A0_1)
  local L1_2, L2_3
  L1_2 = A0_1.levelTTF
  L2_3 = L1_2
  L1_2 = L1_2.setString
  L1_2(L2_3, TwGetStr(103102))
  L1_2 = A0_1.tongyuliTTF
  L2_3 = L1_2
  L1_2 = L1_2.setString
  L1_2(L2_3, TwGetStr(103103))
end
function prototype.ReFrashHeroInfo(A0_4, A1_5)
  local L2_6, L3_7, L4_8, L5_9, L6_10, L7_11, L8_12, L9_13, L10_14, L11_15, L12_16, L13_17
  if A1_5 ~= nil then
    L2_6 = next
    L3_7 = A1_5
    L2_6 = L2_6(L3_7)
  elseif L2_6 == nil then
    return
  end
  L2_6 = Logic
  L3_7 = L2_6
  L2_6 = L2_6.Get
  L4_8 = "HeroCardInfo"
  L2_6 = L2_6(L3_7, L4_8)
  L3_7 = L2_6
  L2_6 = L2_6.kdbBaseHero
  L4_8 = A1_5.baseId
  L2_6 = L2_6(L3_7, L4_8)
  if L2_6 == nil then
    return
  end
  L3_7 = L2_6.card
  if L3_7 ~= "HERO" then
    L3_7 = A0_4.name
    L4_8 = L3_7
    L3_7 = L3_7.setString
    L5_9 = L2_6.name
    L5_9 = L5_9 or ""
    L3_7(L4_8, L5_9)
    L4_8 = A0_4
    L3_7 = A0_4.createHeroCard
    L5_9 = A1_5.baseId
    L3_7(L4_8, L5_9)
    return
  end
  if L2_6 == nil then
    return
  end
  L4_8 = A0_4
  L3_7 = A0_4.createStar
  L5_9 = L2_6.star
  L3_7(L4_8, L5_9)
  L4_8 = A0_4
  L3_7 = A0_4.createHeroCard
  L5_9 = A1_5.baseId
  L6_10 = A1_5.fra
  L3_7(L4_8, L5_9, L6_10)
  L4_8 = A0_4
  L3_7 = A0_4.createPro
  L5_9 = A1_5.baseId
  L3_7(L4_8, L5_9)
  L4_8 = A0_4
  L3_7 = A0_4.createPhyle
  L5_9 = A1_5.baseId
  L3_7(L4_8, L5_9)
  L4_8 = A0_4
  L3_7 = A0_4.createSex
  L5_9 = A1_5.baseId
  L3_7(L4_8, L5_9)
  L3_7 = A1_5.fra
  if L3_7 ~= nil then
    L3_7 = TwGetStr
    L4_8 = 103134
    L3_7 = L3_7(L4_8)
    L4_8 = A0_4.name
    L5_9 = L4_8
    L4_8 = L4_8.setString
    L6_10 = A1_5.itemName
    L6_10 = L6_10 or ""
    L4_8(L5_9, L6_10)
  else
    L3_7 = A0_4.name
    L4_8 = L3_7
    L3_7 = L3_7.setString
    L5_9 = L2_6.name
    L5_9 = L5_9 or ""
    L3_7(L4_8, L5_9)
  end
  L3_7 = A0_4.level
  L4_8 = L3_7
  L3_7 = L3_7.setString
  L5_9 = A1_5.level
  L6_10 = "/"
  L7_11 = L2_6.level
  L5_9 = L5_9 .. L6_10 .. L7_11
  L5_9 = L5_9 or ""
  L3_7(L4_8, L5_9)
  L3_7 = A0_4.leader
  L4_8 = L3_7
  L3_7 = L3_7.setString
  L5_9 = L2_6.leadership
  L5_9 = L5_9 or ""
  L3_7(L4_8, L5_9)
  L3_7 = Logic
  L4_8 = L3_7
  L3_7 = L3_7.Get
  L5_9 = "Hero"
  L3_7 = L3_7(L4_8, L5_9)
  L4_8 = L3_7
  L3_7 = L3_7.GetHeroLifeAndAttack
  L5_9 = A1_5.baseId
  L6_10 = A1_5.level
  L4_8 = L3_7(L4_8, L5_9, L6_10)
  L5_9 = Logic
  L6_10 = L5_9
  L5_9 = L5_9.Get
  L7_11 = "HeroCardInfo"
  L5_9 = L5_9(L6_10, L7_11)
  L6_10 = L5_9
  L5_9 = L5_9.GetMyBUffEffect
  L7_11 = L2_6.type
  L8_12 = L2_6.star
  L5_9 = L5_9(L6_10, L7_11, L8_12)
  L6_10 = {}
  L6_10.ATTACK = ""
  L6_10.LIFE = ""
  L7_11 = L5_9.ATTACK
  if L7_11 ~= 0 then
    L7_11 = "(+"
    L8_12 = L5_9.ATTACK
    L9_13 = ")"
    L7_11 = L7_11 .. L8_12 .. L9_13
    L6_10.ATTACK = L7_11
  end
  L7_11 = L5_9.LIFE
  if L7_11 ~= 0 then
    L7_11 = "(+"
    L8_12 = L5_9.LIFE
    L9_13 = ")"
    L7_11 = L7_11 .. L8_12 .. L9_13
    L6_10.LIFE = L7_11
  end
  L7_11 = A0_4.attack
  L8_12 = L7_11
  L7_11 = L7_11.setString
  L9_13 = L4_8 or ""
  L7_11(L8_12, L9_13)
  L7_11 = A0_4.life
  L8_12 = L7_11
  L7_11 = L7_11.setString
  L9_13 = L3_7 or ""
  L7_11(L8_12, L9_13)
  L7_11 = A0_4.attAdd
  L8_12 = L7_11
  L7_11 = L7_11.setString
  L9_13 = L6_10.ATTACK
  L7_11(L8_12, L9_13)
  L7_11 = A0_4.lifeAdd
  L8_12 = L7_11
  L7_11 = L7_11.setString
  L9_13 = L6_10.LIFE
  L7_11(L8_12, L9_13)
  L7_11 = A0_4.evo
  L8_12 = L7_11
  L7_11 = L7_11.setStyle
  L9_13 = kCCLabelTTFStyleOutline
  L7_11(L8_12, L9_13)
  L7_11 = A0_4.evo
  L8_12 = L7_11
  L7_11 = L7_11.setString
  L9_13 = L2_6.nextDesc
  L7_11(L8_12, L9_13)
  L7_11 = A0_4.getCard
  L8_12 = L7_11
  L7_11 = L7_11.setColor
  L9_13 = ccColor3B
  L10_14 = 255
  L11_15 = 0
  L12_16 = 0
  L13_17 = L9_13(L10_14, L11_15, L12_16)
  L7_11(L8_12, L9_13, L10_14, L11_15, L12_16, L13_17, L9_13(L10_14, L11_15, L12_16))
  L7_11 = A0_4.getCard
  L8_12 = L7_11
  L7_11 = L7_11.setString
  L9_13 = L2_6.gain
  L9_13 = L9_13 or ""
  L7_11(L8_12, L9_13)
  L7_11 = A0_4.heroDes
  L8_12 = L7_11
  L7_11 = L7_11.setDimensions
  L9_13 = CCSize
  L10_14 = 550
  L11_15 = 0
  L13_17 = L9_13(L10_14, L11_15)
  L7_11(L8_12, L9_13, L10_14, L11_15, L12_16, L13_17, L9_13(L10_14, L11_15))
  L7_11 = A0_4.heroDes
  L8_12 = L7_11
  L7_11 = L7_11.setHorizontalAlignment
  L9_13 = kCCTextAlignmentLeft
  L7_11(L8_12, L9_13)
  L7_11 = A0_4.heroDes
  L8_12 = L7_11
  L7_11 = L7_11.setFontSize
  L9_13 = 20
  L7_11(L8_12, L9_13)
  L7_11 = A0_4.heroDes
  L8_12 = L7_11
  L7_11 = L7_11.setString
  L9_13 = L2_6.description
  L9_13 = L9_13 or ""
  L7_11(L8_12, L9_13)
  L7_11 = Logic
  L8_12 = L7_11
  L7_11 = L7_11.Get
  L9_13 = "HeroCardInfo"
  L7_11 = L7_11(L8_12, L9_13)
  L8_12 = L7_11
  L7_11 = L7_11.kdbSkillConfig
  L9_13 = A1_5.powerSkill
  L7_11 = L7_11(L8_12, L9_13)
  if L7_11 == nil then
    return
  end
  L8_12 = A0_4.iniSkillName
  L9_13 = L8_12
  L8_12 = L8_12.setString
  L10_14 = L7_11.skillname
  L8_12(L9_13, L10_14)
  L8_12 = L7_11.state
  L8_12 = L8_12 or {}
  L9_13 = L8_12.round
  L9_13 = L9_13 or 0
  L10_14 = L8_12.init
  L10_14 = L10_14 or 0
  L10_14 = L9_13 - L10_14
  if L10_14 <= 0 then
    L10_14 = 1
  end
  L11_15 = TwGetStr
  L12_16 = 103081
  L13_17 = L9_13
  L11_15 = L11_15(L12_16, L13_17)
  L12_16 = TwGetStr
  L13_17 = 103046
  L12_16 = L12_16(L13_17, L10_14)
  L11_15 = L11_15 .. L12_16
  L12_16 = A0_4.iniSkillInfo
  L13_17 = L12_16
  L12_16 = L12_16.setString
  L12_16(L13_17, L11_15)
  L12_16 = A0_4.iniSkillLvl
  L13_17 = L12_16
  L12_16 = L12_16.setString
  L12_16(L13_17, L7_11.level .. "/" .. L7_11.maxlev)
  L12_16 = A0_4.iniSkillDes
  L13_17 = L12_16
  L12_16 = L12_16.setDimensions
  L12_16(L13_17, CCSize(500, 0))
  L12_16 = A0_4.iniSkillDes
  L13_17 = L12_16
  L12_16 = L12_16.setHorizontalAlignment
  L12_16(L13_17, kCCTextAlignmentLeft)
  L12_16 = L7_11.skilldesc
  L12_16 = L12_16 or ""
  L13_17 = ReplaceStringTab
  L13_17 = L13_17(L12_16)
  L12_16 = L13_17
  L13_17 = A0_4.iniSkillDes
  L13_17 = L13_17.setString
  L13_17(L13_17, L12_16)
  L13_17 = A0_4.pasSkillDes
  L13_17 = L13_17.setDimensions
  L13_17(L13_17, CCSize(500, 0))
  L13_17 = A0_4.pasSkillDes
  L13_17 = L13_17.setHorizontalAlignment
  L13_17(L13_17, kCCTextAlignmentLeft)
  L13_17 = A0_4.pasSkillName
  L13_17 = L13_17.setString
  L13_17(L13_17, L2_6.skillname_3 or "")
  L13_17 = L2_6.skilldesc_3
  L13_17 = L13_17 or ""
  L13_17 = ReplaceStringTab(L13_17)
  A0_4.pasSkillDes:setString(L13_17 or "")
end
function prototype.createPro(A0_18, A1_19)
  local L2_20, L3_21, L4_22
  L2_20 = A0_18.layer
  L3_21 = L2_20
  L2_20 = L2_20.getChildByTag
  L4_22 = 96
  L2_20 = L2_20(L3_21, L4_22)
  if L2_20 ~= nil then
    L3_21 = A0_18.layer
    L4_22 = L3_21
    L3_21 = L3_21.removeChildByTag
    L3_21(L4_22, 96, true)
  end
  L3_21 = Logic
  L4_22 = L3_21
  L3_21 = L3_21.Get
  L3_21 = L3_21(L4_22, "Hero")
  L4_22 = L3_21
  L3_21 = L3_21.GetHeroProfessionImage
  L3_21 = L3_21(L4_22, A1_19)
  L4_22 = CCSprite
  L4_22 = L4_22.create
  L4_22 = L4_22(L4_22, L3_21)
  A0_18.layer:addChild(L4_22, 0, 96)
  L4_22:setPosition(A0_18.sprDepartment:getPosition())
end
function prototype.createPhyle(A0_23, A1_24)
  local L2_25, L3_26, L4_27, L5_28
  L2_25 = A0_23.layer
  L3_26 = L2_25
  L2_25 = L2_25.getChildByTag
  L4_27 = 98
  L2_25 = L2_25(L3_26, L4_27)
  if L2_25 ~= nil then
    L3_26 = A0_23.layer
    L4_27 = L3_26
    L3_26 = L3_26.removeChildByTag
    L5_28 = 98
    L3_26(L4_27, L5_28, true)
  end
  L3_26 = A0_23.layer
  L4_27 = L3_26
  L3_26 = L3_26.getChildByTag
  L5_28 = 80
  L3_26 = L3_26(L4_27, L5_28)
  if L3_26 ~= nil then
    L4_27 = A0_23.layer
    L5_28 = L4_27
    L4_27 = L4_27.removeChildByTag
    L4_27(L5_28, 80, true)
  end
  L4_27 = Logic
  L5_28 = L4_27
  L4_27 = L4_27.Get
  L4_27 = L4_27(L5_28, "HeroCardInfo")
  L5_28 = L4_27
  L4_27 = L4_27.GetHeroPhyleStr
  L4_27 = L4_27(L5_28, A1_24)
  L5_28 = CCSprite
  L5_28 = L5_28.create
  L5_28 = L5_28(L5_28, L4_27)
  A0_23.layer:addChild(L5_28, 0, 98)
  L5_28:setAnchorPoint(CCPoint(0.5, 0.5))
  L5_28:setPosition(A0_23.phyle:getPosition())
end
function prototype.createSex(A0_29, A1_30)
  local L2_31, L3_32, L4_33
  L2_31 = A0_29.layer
  L3_32 = L2_31
  L2_31 = L2_31.getChildByTag
  L4_33 = 97
  L2_31 = L2_31(L3_32, L4_33)
  if L2_31 ~= nil then
    L3_32 = A0_29.layer
    L4_33 = L3_32
    L3_32 = L3_32.removeChildByTag
    L3_32(L4_33, 97, true)
  end
  L3_32 = Logic
  L4_33 = L3_32
  L3_32 = L3_32.Get
  L3_32 = L3_32(L4_33, "HeroCardInfo")
  L4_33 = L3_32
  L3_32 = L3_32.GetHeroSexStr
  L3_32 = L3_32(L4_33, A1_30)
  L4_33 = CCSprite
  L4_33 = L4_33.create
  L4_33 = L4_33(L4_33, L3_32)
  A0_29.layer:addChild(L4_33, 0, 97)
  L4_33:setAnchorPoint(CCPoint(0, 0.5))
  L4_33:setPosition(A0_29.sex:getPosition())
end
function prototype.createHeroCard(A0_34, A1_35, A2_36)
  local L3_37, L4_38
  L3_37 = A0_34.layer
  L4_38 = L3_37
  L3_37 = L3_37.getChildByTag
  L3_37 = L3_37(L4_38, 2)
  if L3_37 ~= nil then
    L4_38 = A0_34.layer
    L4_38 = L4_38.removeChildByTag
    L4_38(L4_38, 2, true)
  end
  if A1_35 == nil then
    return
  end
  L4_38 = Logic
  L4_38 = L4_38.Get
  L4_38 = L4_38(L4_38, "HeroCardInfo")
  L4_38 = L4_38.createHeroCard
  L4_38 = L4_38(L4_38, A1_35, _UPVALUE0_, A2_36, nil, nil, true)
  if L4_38 == nil then
    return
  end
  L4_38:setScale(1 * (_UPVALUE0_ / L4_38:getContentSize().width))
  L4_38:setAnchorPoint(CCPoint(0.5, 0.5))
  A0_34.layer:addChild(L4_38, 0, 2)
  L4_38:setPosition(A0_34.herohead:getPosition())
end
function prototype.createCompose(A0_39)
  local L1_40
  L1_40 = Logic
  L1_40 = L1_40.Get
  L1_40 = L1_40(L1_40, "HeroCardInfo")
  L1_40 = L1_40.GetCompose
  L1_40 = L1_40(L1_40, _UPVALUE0_)
  L1_40:setScale(1 * (_UPVALUE0_ / L1_40:getContentSize().width))
  L1_40:setAnchorPoint(CCPoint(0.5, 0.5))
  A0_39.layer:addChild(L1_40)
  L1_40:setPosition(A0_39.herohead:getPosition())
end
function prototype.createSkill(A0_41, A1_42, A2_43)
  local L3_44, L4_45, L5_46, L6_47, L7_48, L8_49
  if A1_42 == nil or A2_43 == nil then
    return
  end
  L3_44 = CCSpriteBatchNode
  L3_44 = L3_44.create
  L3_44 = L3_44(L4_45, L5_46)
  if L3_44 == nil then
    return
  end
  L7_48 = 0
  L8_49 = 0
  L4_45(L5_46, L6_47, L7_48, L8_49)
  for L7_48 = 1, A2_43 do
    if L7_48 == A1_42 then
      L8_49 = CCSprite
      L8_49 = L8_49.create
      L8_49 = L8_49(L8_49, "data/HeroCardInfo/91.png")
      A0_41.layer:addChild(L8_49)
      L8_49:setAnchorPoint(CCPoint(0.5, 0.8))
      L8_49:setPosition(CCPoint(A0_41.sprSkillLVl:getPositionX() + (L8_49:getContentSize().width + 5) * (L7_48 - 1), A0_41.sprSkillLVl:getPositionY()))
    else
      L8_49 = CCSprite
      L8_49 = L8_49.createWithTexture
      L8_49 = L8_49(L8_49, L3_44:getTexture())
      L3_44:addChild(L8_49)
      L8_49:setAnchorPoint(CCPoint(0.5, 0.8))
      L8_49:setPosition(CCPoint(A0_41.sprSkillLVl:getPositionX() + (L8_49:getContentSize().width + 5) * (L7_48 - 1), A0_41.sprSkillLVl:getPositionY()))
    end
  end
end
function prototype.createStar(A0_50, A1_51)
  local L2_52
  L2_52 = "*"
  if A1_51 ~= 0 then
    for _FORV_6_ = 2, A1_51 do
      L2_52 = L2_52 .. "*"
    end
  end
  _FOR_:setString(L2_52)
end
