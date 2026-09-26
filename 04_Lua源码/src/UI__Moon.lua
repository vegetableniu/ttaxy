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
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.moon.model.MoonType")
function prototype.initialize(A0_1, ...)
  local L3_3, L4_4
  L3_3 = super
  L3_3 = L3_3.initialize
  L4_4 = A0_1
  L3_3(L4_4, ...)
end
function prototype.dispose(A0_5, ...)
  super.dispose(A0_5)
end
function prototype.onEnter(A0_7)
  super.onEnter(A0_7)
  A0_7.ttfTitle:setString(Logic:Get("Gift"):GetActivityGift().name)
  A0_7.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  A0_7:createLabel()
  _UPVALUE0_():On(_UPVALUE1_().MOON_INFO, A0_7:Event("onMoonInfo"))
  _UPVALUE0_():PostMoonInfo()
end
function prototype.createLabel(A0_8)
  local L1_9, L2_10, L3_11, L4_12, L5_13
  L1_9 = 4
  for L5_13 = 1, L1_9 do
    if A0_8["nodMaterial" .. L5_13] then
      A0_8["nodMaterial" .. L5_13]:create(0, "GREEN_NUM")
      A0_8["nodMaterial" .. L5_13]:setAlign("LEFT", "CENTER")
    end
  end
  L5_13 = "GREEN_NUM"
  L2_10(L3_11, L4_12, L5_13)
  L5_13 = "CENTER"
  L2_10(L3_11, L4_12, L5_13)
end
function prototype.onBtnReturn(A0_14, A1_15, A2_16)
  SceneHelper:runWithScene("GiftActivityList", A0_14.rootNode)
end
function prototype.onBtnRecharge(A0_17, A1_18, A2_19)
  Logic:Get("Main"):GotoRecharge()
end
function prototype.onBtnExchange(A0_20, A1_21, A2_22)
  if table.empty(Logic:Get("Gift"):GetActivityByType("SPRING_SHARE") or {}) then
    return
  end
  Logic:Get("Gift"):SetActivityGift(Logic:Get("Gift"):GetActivityByType("SPRING_SHARE")[1])
  SceneHelper:runWithScene("MoonExchange", A0_20.rootNode)
end
function prototype.onBtnBuyMaterial(A0_23, A1_24, A2_25)
  SceneHelper:pushPrompt("MoonBuy", A0_23.rootNode)
end
function prototype.onBtnMakeMoon(A0_26, A1_27, A2_28)
  local L3_29, L4_30, L5_31, L6_32, L7_33, L8_34
  L3_29 = {L4_30, L5_31}
  A0_26.makeCnt = 0
  for L7_33, L8_34 in L4_30(L5_31) do
    if A0_26["btnMakeMoon" .. L8_34] == A1_27 then
      A0_26.makeCnt = L8_34
      break
    end
  end
  if L4_30 <= 0 then
    return
  end
  L7_33 = A0_26.makeCnt
  if not L5_31 then
    L7_33 = 115009
    L5_31(L6_32, L7_33)
    return
  end
  L7_33 = A0_26
  L8_34 = ""
  L5_31(L6_32, L7_33, L8_34, TwGetStr(115006, A0_26.makeCnt, A0_26.makeCnt), A0_26.composeMoonCake, L4_30)
end
function prototype.composeMoonCake(A0_35)
  _UPVALUE0_():PostComposeMoon(A0_35.makeCnt)
end
function prototype.buyMoonCake(A0_36)
  _UPVALUE0_():PostBuyMoon(A0_36.makeCnt, _UPVALUE1_.MOON)
end
function prototype.IsMaterialEnough(A0_37, A1_38)
  local L2_39, L3_40
  L2_39 = _UPVALUE0_
  L2_39 = L2_39()
  L3_40 = L2_39
  L2_39 = L2_39.GetMoonCount
  L2_39 = L2_39(L3_40)
  L3_40 = 4
  for _FORV_7_ = 1, L3_40 do
    if not L2_39[_FORV_7_] or A1_38 > L2_39[_FORV_7_] then
      return false
    end
  end
  return _FOR_
end
function prototype.onMoonInfo(A0_41)
  local L1_42, L2_43, L3_44, L4_45, L5_46, L6_47
  L1_42 = _UPVALUE0_
  L1_42 = L1_42()
  L2_43 = L1_42
  L1_42 = L1_42.GetMoonCount
  L1_42 = L1_42(L2_43)
  L2_43 = 4
  for L6_47 = 1, L2_43 do
    if A0_41["nodMaterial" .. L6_47] then
      A0_41["nodMaterial" .. L6_47]:setValue(L1_42[L6_47] or 0)
    end
  end
  L3_44(L4_45, L5_46)
end
