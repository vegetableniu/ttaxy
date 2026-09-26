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
  A0_7.ttfTitle:setString("\229\136\182\233\128\160\230\156\136\233\165\188")
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
  if table.empty(Logic:Get("Gift"):GetActivityByType("MOON_SHARE") or {}) then
    return
  end
  Logic:Get("Gift"):SetActivityGift(Logic:Get("Gift"):GetActivityByType("MOON_SHARE")[1])
  SceneHelper:runWithScene("MoonCakeExchange", A0_20.rootNode)
end
function prototype.onBtnBuyMaterial(A0_23, A1_24, A2_25)
  SceneHelper:pushPrompt("MoonCakeBuy", A0_23.rootNode)
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
  L5_31(L6_32, L7_33, L8_34, string.format("\230\152\175\229\144\166\232\138\177\232\180\185%d\228\187\189\230\156\136\233\165\188\230\157\144\230\150\153\229\144\136\230\136\144%d\228\184\170\230\156\136\233\165\188?", A0_26.makeCnt, A0_26.makeCnt), A0_26.composeMoonCake, L4_30)
end
function prototype.composeMoonCake(A0_35)
  _UPVALUE0_():PostComposeMoon(A0_35.makeCnt)
end
function prototype.IsMaterialEnough(A0_36, A1_37)
  local L2_38, L3_39
  L2_38 = _UPVALUE0_
  L2_38 = L2_38()
  L3_39 = L2_38
  L2_38 = L2_38.GetMoonCount
  L2_38 = L2_38(L3_39)
  L3_39 = 4
  for _FORV_7_ = 1, L3_39 do
    if not L2_38[_FORV_7_] or A1_37 > L2_38[_FORV_7_] then
      return false
    end
  end
  return _FOR_
end
function prototype.onMoonInfo(A0_40)
  local L1_41, L2_42, L3_43, L4_44, L5_45, L6_46
  L1_41 = _UPVALUE0_
  L1_41 = L1_41()
  L2_42 = L1_41
  L1_41 = L1_41.GetMoonCount
  L1_41 = L1_41(L2_42)
  L2_42 = 4
  for L6_46 = 1, L2_42 do
    if A0_40["nodMaterial" .. L6_46] then
      A0_40["nodMaterial" .. L6_46]:setValue(L1_41[L6_46] or 0)
    end
  end
  L3_43(L4_44, L5_45)
end
