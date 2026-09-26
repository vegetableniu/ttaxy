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
L0_0 = 1015
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
  local L1_8, L2_9, L3_10, L4_11, L5_12, L6_13, L7_14, L8_15, L9_16, L10_17
  L1_8 = super
  L1_8 = L1_8.onEnter
  L2_9 = A0_7
  L1_8(L2_9)
  L1_8 = Logic
  L2_9 = L1_8
  L1_8 = L1_8.Get
  L3_10 = "Gift"
  L1_8 = L1_8(L2_9, L3_10)
  L2_9 = L1_8
  L1_8 = L1_8.GetActivityGift
  L1_8 = L1_8(L2_9)
  L2_9 = A0_7.ttfTitle
  L3_10 = L2_9
  L2_9 = L2_9.setColor
  L7_14 = 18
  L10_17 = L4_11(L5_12, L6_13, L7_14)
  L2_9(L3_10, L4_11, L5_12, L6_13, L7_14, L8_15, L9_16, L10_17, L4_11(L5_12, L6_13, L7_14))
  L2_9 = A0_7.ttfTitle
  L3_10 = L2_9
  L2_9 = L2_9.setString
  L2_9(L3_10, L4_11)
  L2_9 = A0_7.ttfTitle
  L3_10 = L2_9
  L2_9 = L2_9.setStyle
  L2_9(L3_10, L4_11)
  L2_9 = KFDBGetRecord
  L3_10 = "LanguageSetting"
  L2_9 = L2_9(L3_10, L4_11)
  L3_10 = ReplaceStringTab
  L3_10 = L3_10(L4_11)
  L4_11(L5_12, L6_13)
  for L7_14 = 1, L5_12(L6_13) do
    L8_15 = KFDBGetRecordByIdx
    L9_16 = "SmashReward"
    L10_17 = L7_14
    L8_15 = L8_15(L9_16, L10_17)
    if L8_15 then
      L9_16 = _UPVALUE1_
      if L7_14 <= L9_16 then
        L9_16 = string
        L9_16 = L9_16.format
        L10_17 = "ccbIcon%d"
        L9_16 = L9_16(L10_17, L7_14)
        L10_17 = A0_7[L9_16]
        if L10_17 then
          L10_17 = L8_15
          if tonumber(L8_15.showId) == 6647 then
            L10_17 = {
              showType = L8_15.showType,
              showId = 5887,
              amount = L8_15.amount
            }
          end
          A0_7[L9_16]:ReFreshByGift(L10_17)
        end
      end
    end
  end
end
function prototype.onBtnReturn(A0_18, A1_19, A2_20)
  SceneHelper:runWithScene("BrokenEgg", A0_18.rootNode)
end
