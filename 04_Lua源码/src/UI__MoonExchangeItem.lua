module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype.onEnter(A0_0)
  local L1_1
end
function prototype.initRewards(A0_2)
  local L1_3, L2_4, L3_5, L4_6, L5_7, L6_8, L7_9, L8_10
  L1_3 = Logic
  L2_4 = L1_3
  L1_3 = L1_3.Get
  L1_3 = L1_3(L2_4, L3_5)
  L2_4 = L1_3.GetMoonPost
  L2_4 = L2_4(L3_5)
  if L3_5 then
    return
  end
  A0_2.posts = L3_5
  for L6_8, L7_9 in L3_5(L4_6) do
    L8_10 = A0_2.createSingleStr
    L8_10 = L8_10(A0_2, L7_9)
    table.insert(A0_2.posts, L8_10)
  end
  A0_2.currIdx = 1
  L3_5(L4_6)
end
function prototype.createSingleStr(A0_11, A1_12)
  local L2_13, L3_14, L4_15, L5_16, L6_17, L7_18, L8_19, L9_20, L10_21, L11_22, L12_23, L13_24
  L2_13 = {}
  for L6_17, L7_18 in L3_14(L4_15) do
    L8_19 = Logic
    L9_20 = L8_19
    L8_19 = L8_19.Get
    L10_21 = "Reward"
    L8_19 = L8_19(L9_20, L10_21)
    L9_20 = L8_19
    L8_19 = L8_19.RewardTreaTip
    L10_21 = L7_18
    L8_19 = L8_19(L9_20, L10_21)
    L9_20 = Logic
    L10_21 = L9_20
    L9_20 = L9_20.Get
    L11_22 = "Reward"
    L9_20 = L9_20(L10_21, L11_22)
    L10_21 = L9_20
    L9_20 = L9_20.createMap
    L11_22 = L7_18
    L9_20 = L9_20(L10_21, L11_22)
    L10_21 = {}
    L11_22 = L7_18.type
    L11_22 = L9_20[L11_22]
    if L11_22 then
      L11_22 = L7_18.type
      L11_22 = L9_20[L11_22]
      L11_22 = L11_22.showType
      L12_23 = L7_18.code
      L12_23 = L12_23 + 1
      L11_22 = L11_22[L12_23]
      L11_22 = L11_22 or ""
      L10_21.showType = L11_22
      L11_22 = L7_18.type
      L11_22 = L9_20[L11_22]
      L11_22 = L11_22.showId
      L12_23 = L7_18.code
      L12_23 = L12_23 + 1
      L11_22 = L11_22[L12_23]
      L11_22 = L11_22 or 4
      L10_21.showId = L11_22
    end
    L11_22 = Logic
    L12_23 = L11_22
    L11_22 = L11_22.Get
    L13_24 = "Gift"
    L11_22 = L11_22(L12_23, L13_24)
    L12_23 = L11_22
    L11_22 = L11_22.GetColorByGift
    L13_24 = L10_21
    L12_23 = L11_22(L12_23, L13_24)
    L13_24 = TwGetStr
    L13_24 = L13_24(110914, L12_23, L8_19 or "")
    table.insert(L2_13, L13_24)
  end
  L6_17 = "00fff6"
  L7_18 = A1_12.name
  L6_17 = 110914
  L7_18 = "fcff00"
  L8_19 = TwGetStr
  L9_20 = 115008
  L10_21 = L4_15
  L11_22 = L3_14
  L13_24 = L8_19(L9_20, L10_21, L11_22)
  return L5_16
end
function prototype.runAni(A0_25)
  local L1_26, L2_27, L3_28, L4_29, L5_30, L6_31, L7_32
  L1_26 = 450
  L2_27 = 15
  L3_28 = A0_25.nodText
  L4_29 = L3_28
  L3_28 = L3_28.setString
  L5_30 = A0_25.posts
  L6_31 = A0_25.currIdx
  L5_30 = L5_30[L6_31]
  L3_28(L4_29, L5_30)
  L3_28 = A0_25.nodText
  L4_29 = L3_28
  L3_28 = L3_28.setPositionX
  L5_30 = L1_26
  L3_28(L4_29, L5_30)
  L3_28 = A0_25.nodText
  L4_29 = L3_28
  L3_28 = L3_28.getContentSize
  L3_28 = L3_28(L4_29)
  L4_29 = ccp
  L5_30 = L3_28.width
  L5_30 = L1_26 - L5_30
  L6_31 = L2_27
  L4_29 = L4_29(L5_30, L6_31)
  L5_30 = L3_28.width
  L5_30 = L5_30 / 40
  L6_31 = {}
  L7_32 = CCMoveTo
  L7_32 = L7_32.create
  L7_32 = L7_32(L7_32, L5_30, L4_29)
  table.insert(L6_31, CCMoveTo:create(0, ccp(L1_26, L2_27)))
  table.insert(L6_31, L7_32)
  table.insert(L6_31, CCDelayTime:create(3))
  table.insert(L6_31, CCMoveTo:create(0, ccp(L1_26 + 1, L2_27)))
  table.insert(L6_31, CCCallFuncN:create(function()
    _UPVALUE0_.currIdx = _UPVALUE0_.currIdx + 1
    _UPVALUE0_.currIdx = _UPVALUE0_.currIdx > #_UPVALUE0_.posts and 1 or _UPVALUE0_.currIdx
    _UPVALUE0_:runAni()
  end))
  A0_25.nodText:runAction(Logic:Get("AniMgr"):CreateSequence(L6_31))
end
