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
L0_0 = "images/TempleSeekTreasure/ttf_tip.png"
TREASHOW_TYPE = {
  RaffleShow = "CircleLottery",
  FoolsdayShow = "FoolsDayActivity",
  TreasureShow = "GiftTreasure"
}
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
  L2_9 = L2_9.setString
  L2_9(L3_10, L4_11)
  L2_9 = A0_7.ttfTitle
  L3_10 = L2_9
  L2_9 = L2_9.setStyle
  L2_9(L3_10, L4_11)
  L2_9 = Logic
  L3_10 = L2_9
  L2_9 = L2_9.Get
  L2_9 = L2_9(L3_10, L4_11)
  L3_10 = L2_9
  L2_9 = L2_9.getTreasureShowStr
  L2_9 = L2_9(L3_10)
  if L2_9 then
    L3_10 = Logic
    L3_10 = L3_10.Get
    L3_10 = L3_10(L4_11, L5_12)
    L3_10 = L3_10.GetPlayerLevel
    L3_10 = L3_10(L4_11)
    if L4_11 then
      L10_17 = L7_14(L8_15)
      L5_12(L6_13, L7_14, L8_15, L9_16, L10_17, L7_14(L8_15))
    end
    for L9_16 = 1, L7_14(L8_15) do
      L10_17 = KFDBGetRecordByIdx
      L10_17 = L10_17(L2_9, L9_16)
      if L10_17 and L10_17.minLevel and L10_17.maxLevel and L3_10 >= L10_17.minLevel and L3_10 <= L10_17.maxLevel then
        if L10_17 and A0_7[string.format("ccbTrea%d", L5_12)] then
          A0_7[string.format("ccbTrea%d", L5_12)]:ReFreshByGift(L10_17)
        elseif A0_7[string.format("ccbTrea%d", L5_12)] then
          A0_7[string.format("ccbTrea%d", L5_12)]:setVisible(false)
        end
      end
    end
    return
  end
  L3_10 = nil
  if L4_11 == "SWEET_HOUSE" then
    L3_10 = L4_11
  elseif L4_11 == "GEM_ROOM" then
    L3_10 = L4_11
  end
  if L3_10 then
    for L7_14 = 1, 12 do
      L9_16 = "ccbTrea%d"
      L10_17 = L7_14
      L9_16 = L3_10[L7_14]
      if L9_16 then
        L10_17 = A0_7[L8_15]
        if L10_17 then
          L10_17 = A0_7[L8_15]
          L10_17 = L10_17.ReFreshByGift
          L10_17(L10_17, L9_16)
          L10_17 = A0_7[L8_15]
          L10_17 = L10_17.setVisible
          L10_17(L10_17, true)
        end
      else
        L10_17 = A0_7[L8_15]
        if L10_17 then
          L10_17 = A0_7[L8_15]
          L10_17 = L10_17.setVisible
          L10_17(L10_17, false)
        end
      end
    end
    if L4_11 == "SWEET_HOUSE" then
      if L5_12 then
        L6_13(L7_14, L8_15)
        L9_16 = L5_12
        L10_17 = L8_15(L9_16)
        L6_13(L7_14, L8_15, L9_16, L10_17, L8_15(L9_16))
      end
    end
    return
  end
  for L7_14 = 1, L5_12(L6_13) do
    L9_16 = "TreasureShow"
    L10_17 = L7_14
    L9_16 = string
    L9_16 = L9_16.format
    L10_17 = "ccbTrea%d"
    L9_16 = L9_16(L10_17, L7_14)
    if L8_15 then
      L10_17 = A0_7[L9_16]
      if L10_17 then
        L10_17 = A0_7[L9_16]
        L10_17 = L10_17.ReFreshByGift
        L10_17(L10_17, L8_15)
      end
    else
      L10_17 = A0_7[L9_16]
      if L10_17 then
        L10_17 = A0_7[L9_16]
        L10_17 = L10_17.setVisible
        L10_17(L10_17, false)
      end
    end
  end
  if L4_11 == "SWEET_HOUSE" then
    if L5_12 then
      L6_13(L7_14, L8_15)
      L9_16 = L5_12
      L10_17 = L8_15(L9_16)
      L6_13(L7_14, L8_15, L9_16, L10_17, L8_15(L9_16))
    end
  end
end
function prototype.onExit(A0_18)
  Logic:Get("Raffle"):setTreasureShowStr(nil)
end
function prototype.onBtnReturn(A0_19, A1_20, A2_21)
  if Logic:Get("Raffle"):getTreasureShowStr() then
    Logic:Get("Raffle"):setTreasureShowStr(nil)
    SceneHelper:runWithScene(TREASHOW_TYPE[Logic:Get("Raffle"):getTreasureShowStr()], A0_19.rootNode)
    return
  end
  SceneHelper:removeScene("GiftTreasureShow")
end
