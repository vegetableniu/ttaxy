local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = objectlua
L0_0 = L0_0.Object
L0_0 = L0_0.subclass
L0_0 = L0_0(L0_0)
class = L0_0
L0_0 = class
L0_0.baseScale = 0.7
L0_0 = require
L0_0 = L0_0("BattleShow.BattleDefine")
function class.initialize(A0_1)
  super.initialize(A0_1)
end
function class.Create(A0_2, A1_3, A2_4, A3_5)
  local L4_6, L5_7, L6_8, L7_9
  if A2_4 == nil and A1_3 == nil then
    return
  end
  L4_6 = CCSprite
  L5_7 = L4_6
  L4_6 = L4_6.create
  L4_6 = L4_6(L5_7)
  L5_7 = nil
  if A1_3 == 0 or A1_3 == nil then
    L6_8 = type
    L7_9 = A2_4
    L6_8 = L6_8(L7_9)
    if L6_8 == "string" then
      L6_8 = string
      L6_8 = L6_8.sub
      L7_9 = A2_4
      L6_8 = L6_8(L7_9, 1, 5)
      if L6_8 == "text:" then
        L6_8 = CCLabelTTF
        L7_9 = L6_8
        L6_8 = L6_8.create
        L6_8 = L6_8(L7_9, string.sub(A2_4, 6), "Helvetica", 26)
        L5_7 = L6_8
        L7_9 = L5_7
        L6_8 = L5_7.setColor
        L6_8(L7_9, ccc3(255, 70, 90))
      end
    else
      L6_8 = CCSprite
      L7_9 = L6_8
      L6_8 = L6_8.create
      L6_8 = L6_8(L7_9, A2_4)
      L5_7 = L6_8
    end
  else
    if not A3_5 then
      L6_8 = FONT
      A3_5 = L6_8.HURT
    end
    L6_8 = math
    L6_8 = L6_8.abs
    L7_9 = A1_3
    L6_8 = L6_8(L7_9)
    A1_3 = L6_8
    L6_8 = CCLabelBMFont
    L7_9 = L6_8
    L6_8 = L6_8.create
    L6_8 = L6_8(L7_9, tostring(A1_3), A3_5)
    L5_7 = L6_8
    if A2_4 ~= nil then
      L6_8 = CCSprite
      L7_9 = L6_8
      L6_8 = L6_8.create
      L6_8 = L6_8(L7_9, A2_4)
      L7_9 = L6_8.setAnchorPoint
      L7_9(L6_8, ccp(0.5, 0.5))
      L7_9 = L6_8.setScale
      L7_9(L6_8, 0.8)
      L7_9 = L5_7.getContentSize
      L7_9 = L7_9(L5_7)
      L7_9 = L7_9.height
      L6_8:setPosition(ccp(0, L7_9))
      L4_6:addChild(L6_8, 999)
    end
  end
  L7_9 = L5_7
  L6_8 = L5_7.setAnchorPoint
  L6_8(L7_9, ccp(0.5, 0.5))
  L7_9 = L4_6
  L6_8 = L4_6.addChild
  L6_8(L7_9, L5_7, 999)
  return L4_6
end
function class.Out(A0_10, A1_11, A2_12, A3_13, A4_14)
  local L5_15, L6_16, L7_17, L8_18, L9_19, L10_20, L11_21
  if A4_14 then
    L5_15 = _UPVALUE0_
    L5_15 = L5_15.class
    L6_16 = L5_15
    L5_15 = L5_15.new
    L7_17 = _UPVALUE1_
    L7_17 = L7_17.ANI
    L7_17 = L7_17.BIG_HARM
    L9_19 = A2_12
    L8_18 = A2_12.getParent
    L8_18 = L8_18(L9_19)
    L9_19 = ccp
    L11_21 = A2_12
    L10_20 = A2_12.getPosition
    L11_21 = L10_20(L11_21)
    L9_19 = L9_19(L10_20, L11_21, L10_20(L11_21))
    L10_20 = _UPVALUE1_
    L10_20 = L10_20.LAYER_LEVEL
    L10_20 = L10_20.EFF
    L5_15 = L5_15(L6_16, L7_17, L8_18, L9_19, L10_20)
    L7_17 = L5_15
    L6_16 = L5_15.RunAnimationAutoRemove
    L6_16(L7_17)
  end
  L6_16 = A2_12
  L5_15 = A2_12.getParent
  L5_15 = L5_15(L6_16)
  L6_16 = L5_15
  L5_15 = L5_15.addChild
  L7_17 = A1_11
  L8_18 = 99
  L5_15(L6_16, L7_17, L8_18)
  L6_16 = A0_10
  L5_15 = A0_10.GetOutPutPos3
  L7_17 = A2_12
  L5_15 = L5_15(L6_16, L7_17)
  L7_17 = A1_11
  L6_16 = A1_11.setPosition
  L8_18 = ccp
  L9_19 = L5_15.x
  L10_20 = L5_15.y
  L11_21 = L8_18(L9_19, L10_20)
  L6_16(L7_17, L8_18, L9_19, L10_20, L11_21, L8_18(L9_19, L10_20))
  L7_17 = A1_11
  L6_16 = A1_11.setVisible
  L8_18 = true
  L6_16(L7_17, L8_18)
  L7_17 = A1_11
  L6_16 = A1_11.setOpacity
  L8_18 = 255
  L6_16(L7_17, L8_18)
  L7_17 = A1_11
  L6_16 = A1_11.setScale
  L8_18 = 1
  L6_16(L7_17, L8_18)
  L6_16 = CCArray
  L7_17 = L6_16
  L6_16 = L6_16.create
  L6_16 = L6_16(L7_17)
  L7_17 = CCScaleTo
  L8_18 = L7_17
  L7_17 = L7_17.create
  L9_19 = 0.13999999999999999
  L10_20 = 3 * A3_13
  L7_17 = L7_17(L8_18, L9_19, L10_20)
  L8_18 = CCScaleTo
  L9_19 = L8_18
  L8_18 = L8_18.create
  L10_20 = 0.13999999999999999
  L11_21 = 1.5 * A3_13
  L8_18 = L8_18(L9_19, L10_20, L11_21)
  L9_19 = CCDelayTime
  L10_20 = L9_19
  L9_19 = L9_19.create
  L11_21 = 0.7
  L9_19 = L9_19(L10_20, L11_21)
  L10_20 = CCScaleTo
  L11_21 = L10_20
  L10_20 = L10_20.create
  L10_20 = L10_20(L11_21, 0.13999999999999999, 0)
  L11_21 = CCHide
  L11_21 = L11_21.create
  L11_21 = L11_21(L11_21)
  L6_16:addObject(L7_17)
  L6_16:addObject(L8_18)
  L6_16:addObject(L9_19)
  L6_16:addObject(L10_20)
  L6_16:addObject(L11_21)
  L6_16:addObject(CCCallFuncN:create(function()
    _UPVALUE0_:getParent():removeChild(_UPVALUE1_, true)
  end))
  A1_11:runAction(CCSequence:create(L6_16))
end
function class.GetOutPutPos3(A0_22, A1_23)
  local L2_24
  L2_24 = A0_22.baseScale
  return {
    x = A1_23:getPosition() + math.random(-30 * L2_24, 30 * L2_24),
    y = A1_23:getPosition() + math.random(-30 * L2_24, 30 * L2_24)
  }
end
function class.GetOutPutPos2(A0_25, A1_26)
  return {
    x = A1_26:getPosition() - A1_26:getContentSize().width * A1_26:getScale() / 2 + math.random(A1_26:getContentSize().width * A1_26:getScale() / 4, 3 * (A1_26:getContentSize().width * A1_26:getScale()) / 4),
    y = A1_26:getPosition() - A1_26:getContentSize().height * A1_26:getScale() / 2 + math.random(A1_26:getContentSize().height * A1_26:getScale() / 4, 3 * (A1_26:getContentSize().height * A1_26:getScale()) / 4)
  }
end
function class.GetOutPutPos(A0_27, A1_28)
  local L2_29, L3_30, L4_31, L5_32, L6_33, L7_34, L8_35, L9_36, L10_37, L11_38, L12_39, L13_40, L14_41, L15_42
  L3_30 = A1_28
  L2_29 = A1_28.getContentSize
  L2_29 = L2_29(L3_30)
  L3_30 = L2_29.width
  L4_31 = L2_29.height
  L5_32 = L3_30 / 2
  L6_33 = L4_31 / 2
  L7_34 = L3_30 * 0.3333333333333333
  L8_35 = L4_31 * 0.6666666666666666
  L9_36 = L3_30 * 0.3333333333333333
  L10_37 = L4_31 * 0.3333333333333333
  L11_38 = L3_30 * 0.6666666666666666
  L12_39 = L4_31 * 0.6666666666666666
  L13_40 = L3_30 * 0.6666666666666666
  L14_41 = L4_31 * 0.3333333333333333
  L15_42 = {}
  table.insert(L15_42, {x = L5_32, y = L6_33})
  table.insert(L15_42, {x = L7_34, y = L8_35})
  table.insert(L15_42, {x = L9_36, y = L10_37})
  table.insert(L15_42, {x = L11_38, y = L12_39})
  table.insert(L15_42, {x = L13_40, y = L14_41})
  return L15_42[math.random(1, 5)]
end
