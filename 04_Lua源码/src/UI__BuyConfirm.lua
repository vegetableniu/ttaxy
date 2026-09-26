module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
RET = Logic.SureConfirm.RET
MAX_NUM_LEN = 10
function prototype.onEnter(A0_0)
  local L1_1, L2_2
  L1_1 = Logic
  L2_2 = L1_1
  L1_1 = L1_1.Get
  L1_1 = L1_1(L2_2, "SureConfirm")
  L2_2 = L1_1
  L1_1 = L1_1.GetConfirm
  L1_1 = L1_1(L2_2)
  L2_2 = Logic
  L2_2 = L2_2.Get
  L2_2 = L2_2(L2_2, "SureConfirm")
  L2_2 = L2_2.GetBtnText
  L2_2 = L2_2(L2_2)
  A0_0.ani = Logic:Get("SureConfirm"):GetAniBool()
  A0_0:setConfirm(L1_1)
  A0_0:setBtnText(L2_2)
  Logic:Get("SureConfirm"):SetConfirmNil()
end
function prototype.onExit(A0_3)
  Logic:Get("SureConfirm"):clear()
end
function prototype.onNodeLoaded(A0_4, A1_5, A2_6)
end
function prototype.setConfirm(A0_7, A1_8)
  local L2_9, L3_10, L4_11, L5_12, L6_13
  L2_9 = A0_7.title
  L3_10 = L2_9
  L2_9 = L2_9.setStyle
  L4_11 = kCCLabelTTFStyleOutline
  L2_9(L3_10, L4_11)
  L2_9 = A0_7.title
  L3_10 = L2_9
  L2_9 = L2_9.setHorizontalAlignment
  L4_11 = kCCTextAlignmentCenter
  L2_9(L3_10, L4_11)
  L2_9 = TwGetStr
  L3_10 = 103001
  L2_9 = L2_9(L3_10)
  L3_10 = A1_8.title
  L3_10 = not L3_10 or L3_10(L4_11)
  L3_10 = A0_7.title
  L4_11 = L3_10
  L3_10 = L3_10.setString
  L5_12 = L2_9
  L3_10(L4_11, L5_12)
  L3_10 = A0_7.content
  L4_11 = L3_10
  L3_10 = L3_10.setString
  L5_12 = A1_8.content
  L3_10(L4_11, L5_12)
  L3_10 = A1_8.func
  if L3_10 then
    L3_10 = A1_8.func
    A0_7.func = L3_10
  end
  L3_10 = A1_8.cost
  A0_7.cost = L3_10
  L3_10 = A1_8.amount
  A0_7.amount = L3_10
  A0_7.cnt = 1
  L3_10 = math
  L3_10 = L3_10.floor
  L4_11 = A0_7.amount
  L5_12 = A0_7.cost
  L4_11 = L4_11 / L5_12
  L3_10 = L3_10(L4_11)
  A0_7.maxBuyCnt = L3_10
  L3_10 = KFDBGetRecord
  L4_11 = "ConfigValue"
  L5_12 = "PLAYER:TOKEN_COIN_EXCHANGE_MAX_NUM"
  L3_10 = L3_10(L4_11, L5_12)
  if L3_10 then
    L4_11 = tonumber
    L5_12 = L3_10.content
    L4_11 = L4_11(L5_12)
  else
    L4_11 = L4_11 or 1
  end
  L5_12 = A1_8.max
  if L5_12 then
    L5_12 = A1_8.max
  else
    L5_12 = L5_12 or L4_11
  end
  A0_7.max = L5_12
  L5_12 = A0_7.nodNum
  L6_13 = L5_12
  L5_12 = L5_12.setMaxLens
  L5_12(L6_13, MAX_NUM_LEN)
  L5_12 = A0_7.nodNum
  L6_13 = L5_12
  L5_12 = L5_12.setFontSize
  L5_12(L6_13, 24)
  L5_12 = A0_7.nodNum
  L6_13 = L5_12
  L5_12 = L5_12.setTouchPriority
  L5_12(L6_13, -255)
  L5_12 = A0_7.nodNum
  L6_13 = L5_12
  L5_12 = L5_12.getContentSize
  L5_12 = L5_12(L6_13)
  L5_12 = L5_12.width
  L5_12 = L5_12 / 2
  L6_13 = A0_7.nodNum
  L6_13 = L6_13.getContentSize
  L6_13 = L6_13(L6_13)
  L6_13 = L6_13.height
  L6_13 = L6_13 / 2
  A0_7.nodNum:setStyle(kCCLabelTTFStyleOutline)
  A0_7.nodNum:setAnchorPoint(CCPoint(0.5, 0.5))
  A0_7.nodNum:setPosition(ccp(L5_12, L6_13))
  A0_7.nodNum:setString(A0_7.cnt)
  A0_7.nodNum:setCallback(bind(A0_7.onEditTouchOutside, A0_7))
  A0_7.ttfCurrency:setStyle(kCCLabelTTFStyleOutline)
  L2_9 = type(A1_8.currencyName) == "string" and A1_8.currencyName or TwGetStr(A1_8.currencyName)
  A0_7.currencyName = L2_9
  A0_7.ttfCurrency:setString(TwGetStr(105923, L2_9))
  A0_7.ttfCost:setStyle(kCCLabelTTFStyleOutline)
  A0_7.ttfCost:setString(A0_7.cost * A0_7.cnt)
  if A1_8.currencyPath and CCSprite:create(A1_8.currencyPath) then
    if A1_8.currencyColor then
      CCSprite:create(A1_8.currencyPath):setColor(A1_8.currencyColor)
    end
    A0_7.sprCurrency:setDisplayFrame(CCSprite:create(A1_8.currencyPath):displayFrame())
    if A1_8.currencyColor then
      A0_7.sprCurrency:setColor(A1_8.currencyColor)
    end
  end
end
function prototype.setBtnText(A0_14, A1_15)
  local L2_16, L3_17
  L2_16 = A1_15.ok
  if nil ~= L2_16 then
    L2_16 = A1_15.ok
  elseif not L2_16 then
    L2_16 = TwGetStr
    L3_17 = 103002
    L2_16 = L2_16(L3_17)
  end
  L3_17 = A0_14.btnSureOne
  L3_17 = L3_17.setString
  L3_17(L3_17, L2_16)
  L3_17 = A1_15.cancel
  if nil ~= L3_17 then
    L3_17 = A1_15.cancel
  elseif not L3_17 then
    L3_17 = TwGetStr
    L3_17 = L3_17(103003)
  end
  A0_14.btnCancel:setString(L3_17)
end
function prototype.onBtnSure(A0_18, A1_19, A2_20)
  local L3_21, L4_22
  L3_21 = A0_18.cnt
  L4_22 = A0_18.max
  if L3_21 > L4_22 then
    L3_21 = Prompt
    L4_22 = L3_21
    L3_21 = L3_21.Fail
    L3_21(L4_22, TwGetStr(10156, A0_18.max))
    L4_22 = A0_18
    L3_21 = A0_18.addCnt
    L3_21(L4_22, A0_18.maxBuyCnt)
    return
  end
  L3_21 = A0_18.cnt
  L4_22 = A0_18.maxBuyCnt
  if L3_21 > L4_22 then
    L3_21 = SceneHelper
    L4_22 = L3_21
    L3_21 = L3_21.removePrompt
    L3_21(L4_22, A0_18.rootNode)
    L3_21 = string
    L3_21 = L3_21.find
    L4_22 = TwGetStr
    L4_22 = L4_22(103009)
    L3_21 = L3_21(L4_22, A0_18.currencyName)
    if L3_21 then
      L3_21 = Logic
      L4_22 = L3_21
      L3_21 = L3_21.Get
      L3_21 = L3_21(L4_22, "Main")
      L4_22 = L3_21
      L3_21 = L3_21.PromptCharge
      L3_21(L4_22)
      return
    end
    L3_21 = Prompt
    L4_22 = L3_21
    L3_21 = L3_21.Fail
    L3_21(L4_22, TwGetStr(105916, A0_18.currencyName or ""))
    return
  end
  L3_21 = CCScaleTo
  L4_22 = L3_21
  L3_21 = L3_21.create
  L3_21 = L3_21(L4_22, 0.1, 0.3)
  L4_22 = CCArray
  L4_22 = L4_22.create
  L4_22 = L4_22(L4_22)
  if not A0_18.ani then
    L4_22:addObject(L3_21)
  end
  L4_22:addObject(CCCallFuncN:create(function()
    if _UPVALUE0_.func then
      _UPVALUE0_.func(RET.OK, _UPVALUE0_.cnt)
    end
    Logic:Get("SureConfirm"):SetAni(false)
    SceneHelper:removePrompt(_UPVALUE0_.rootNode)
  end))
  A0_18.layer:runAction(CCSequence:create(L4_22))
end
function prototype.onBtnCancel(A0_23, A1_24, A2_25)
  SceneHelper:removePrompt(A0_23.rootNode)
end
function prototype.onMenuClose(A0_26, A1_27, A2_28)
end
function prototype.onBtnAdd(A0_29)
  A0_29:addCnt(1)
end
function prototype.onBtnAddMax(A0_30)
  A0_30:addCnt(A0_30.maxBuyCnt)
end
function prototype.onBtnReduce(A0_31)
  A0_31:addCnt(-1)
end
function prototype.addCnt(A0_32, A1_33)
  A0_32.cnt = A0_32.cnt + A1_33
  A0_32.cnt = A0_32.cnt < 1 and 1 or A0_32.cnt
  A0_32.cnt = A0_32.cnt > A0_32.max and A0_32.max or A0_32.cnt
  A0_32.cnt = A0_32.cnt > A0_32.maxBuyCnt and A0_32.maxBuyCnt or A0_32.cnt
  A0_32.nodNum:setString(A0_32.cnt)
  A0_32.ttfCost:setString(A0_32.cost * A0_32.cnt)
end
function prototype.onEditTouchOutside(A0_34, A1_35)
  local L2_36
  L2_36 = A0_34.nodNum
  L2_36 = L2_36.getString
  L2_36 = L2_36(L2_36)
  if "" == L2_36 or string.find(L2_36, "[^%d]") then
    A0_34.nodNum:setString(A0_34.cnt)
    return
  end
  A0_34.cnt = tonumber(L2_36)
  A0_34.ttfCost:setString(A0_34.cost * A0_34.cnt)
end
