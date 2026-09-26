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
L0_0 = Enum
L0_0 = L0_0(TypeDef("com.eyu.mt.module.moon.model.MoonType"))
function prototype.onEnter(A0_1)
  A0_1:AddClicked(A0_1.sprTip1)
  A0_1.type = 1
  A0_1.costs = json.decode((KFDBGetRecord("ConfigValue", "MOON:BUY_COST") or {}).content or "[]") or {}
  A0_1.buyCnt = json.decode((KFDBGetRecord("ConfigValue", "MOON:BUY_COUNT") or {}).content or "[]") or {}
  A0_1:createLabel()
  _UPVALUE0_():On(Logic.Moon.EVT.MOON_INFO, A0_1:Event("onMoonInfo"))
end
function prototype.onMenuClose(A0_2, A1_3, A2_4)
end
function prototype.onBtnSure(A0_5, A1_6, A2_7)
  local L3_8, L4_9, L5_10
  L3_8 = A0_5.costs
  L4_9 = _UPVALUE0_
  L5_10 = A0_5.type
  L4_9 = L4_9[L5_10]
  L3_8 = L3_8[L4_9]
  L3_8 = L3_8 or 0
  L4_9 = A0_5.buyCnt
  L5_10 = _UPVALUE0_
  L5_10 = L5_10[A0_5.type]
  L4_9 = L4_9[L5_10]
  L4_9 = L4_9 or 0
  L5_10 = L4_9 * L3_8
  if L5_10 > Logic:Get("PlayerInfo"):GetPlayerAllJade() then
    Logic:Get("Main"):PromptCharge()
    SceneHelper:removePrompt(A0_5.rootNode)
    return
  end
  _UPVALUE1_():PostBuyMoon(L4_9, A0_5.type)
end
function prototype.onBtnCancelClicked(A0_11, A1_12, A2_13)
  SceneHelper:removePrompt(A0_11.rootNode)
end
function prototype.onBtnTipClicked(A0_14, A1_15, A2_16)
  local L3_17, L4_18, L5_19, L6_20, L7_21
  L3_17 = 4
  for L7_21 = 1, L3_17 do
    if A0_14["btnTip" .. L7_21] == A1_15 then
      A0_14.type = L7_21
      break
    end
  end
  L7_21 = A0_14.type
  L4_18(L5_19, L6_20)
end
function prototype.createLabel(A0_22)
  local L1_23, L2_24, L3_25, L4_26, L5_27, L6_28, L7_29, L8_30, L9_31
  L1_23 = 4
  for L5_27 = 1, L1_23 do
    L6_28 = "nodMaterial"
    L7_29 = L5_27
    L6_28 = L6_28 .. L7_29
    L7_29 = "nodCost"
    L8_30 = L5_27
    L7_29 = L7_29 .. L8_30
    L8_30 = A0_22.costs
    L9_31 = _UPVALUE0_
    L9_31 = L9_31[L5_27]
    L8_30 = L8_30[L9_31]
    L8_30 = L8_30 or 0
    L9_31 = A0_22.buyCnt
    L9_31 = L9_31[_UPVALUE0_[L5_27]]
    L9_31 = L9_31 or 0
    if A0_22[L6_28] then
      A0_22[L6_28]:create(0, "GREEN_NUM")
      A0_22[L6_28]:setAlign("LEFT", "CENTER")
      A0_22[L6_28]:setValue(L9_31)
    end
    if A0_22[L7_29] then
      A0_22[L7_29]:create(0, "GREEN_NUM")
      A0_22[L7_29]:setAlign("LEFT", "CENTER")
      A0_22[L7_29]:setValue(L8_30 * L9_31)
    end
  end
end
function prototype.AddClicked(A0_32, A1_33)
  local L2_34, L3_35, L4_36, L5_37, L6_38, L7_39, L8_40, L9_41, L10_42
  L2_34 = "images/public/selcet1.png"
  L3_35 = "images/public/selcet2.png"
  L4_36 = 4
  for L8_40 = 1, L4_36 do
    L9_41 = "sprTip"
    L10_42 = L8_40
    L9_41 = L9_41 .. L10_42
    L10_42 = A0_32[L9_41]
    L10_42 = L10_42 == A1_33 and L3_35 or L2_34
    if CCSprite:create(L10_42) then
      A0_32[L9_41]:setDisplayFrame(CCSprite:create(L10_42):displayFrame())
    end
  end
end
function prototype.onMoonInfo(A0_43)
  SceneHelper:removePrompt(A0_43.rootNode)
end
