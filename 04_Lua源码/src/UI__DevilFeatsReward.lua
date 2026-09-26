module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
require("TableViewEx")
require("table_ext")
function prototype.initialize(A0_0, ...)
  local L3_2, L4_3
  L3_2 = super
  L3_2 = L3_2.initialize
  L4_3 = A0_0
  L3_2(L4_3, ...)
end
function prototype.dispose(A0_4, ...)
  super.dispose(A0_4)
end
function prototype.onEnter(A0_6)
  local L1_7, L2_8, L3_9, L4_10, L5_11, L6_12, L7_13
  L1_7 = {}
  A0_6.rankRewardInfo = L1_7
  L1_7 = {}
  A0_6.data = L1_7
  L1_7 = A0_6.ttfState
  L2_8 = L1_7
  L1_7 = L1_7.setString
  L7_13 = L3_9(L4_10)
  L1_7(L2_8, L3_9, L4_10, L5_11, L6_12, L7_13, L3_9(L4_10))
  L1_7 = Logic
  L2_8 = L1_7
  L1_7 = L1_7.Get
  L1_7 = L1_7(L2_8, L3_9)
  L2_8 = L1_7
  L1_7 = L1_7.getActiveId
  L1_7 = L1_7(L2_8)
  L2_8 = Logic
  L2_8 = L2_8.Get
  L2_8 = L2_8(L3_9, L4_10)
  L2_8 = L2_8.getRankGroupId
  L2_8 = L2_8(L3_9)
  if L2_8 and L2_8 > 0 then
    L1_7 = L3_9
  end
  for L6_12 = 1, L4_10(L5_11) do
    L7_13 = KFDBGetRecordByIdx
    L7_13 = L7_13("FeatRankReward", L6_12)
    if L7_13 and L7_13.activeId == L1_7 then
      table.insert(A0_6.rankRewardInfo, L7_13)
    end
  end
  if not L3_9 then
    L3_9(L4_10, L5_11)
  end
  A0_6.data = L3_9
  L6_12 = A0_6.featsRewardInfo
  L7_13 = 1
  A0_6.tableViewControl = L3_9
  L3_9(L4_10)
  L3_9(L4_10, L5_11)
  L3_9(L4_10, L5_11)
end
function prototype.cellSizeForTable(A0_14, ...)
  return CCSizeMake(563, 48)
end
function prototype.tableCellAtIndex(A0_16, A1_17, A2_18, A3_19, A4_20)
  local L5_21
  if not A3_19 then
    L5_21 = CCTableViewCellEx
    L5_21 = L5_21.create
    L5_21 = L5_21(L5_21)
    A3_19 = L5_21
    L5_21 = Tw
    L5_21 = L5_21.Controller
    L5_21 = L5_21.load
    L5_21 = L5_21(L5_21, "DevilRewardItem", A0_16.rootNode)
    L5_21:RefreshReward(A0_16.rankRewardInfo[A2_18 + 1])
    A3_19:addChild(L5_21, 0, 2)
  else
    L5_21 = A3_19.getChildByTag
    L5_21 = L5_21(A3_19, 2)
    L5_21 = L5_21.RefreshReward
    L5_21(L5_21, A0_16.rankRewardInfo[A2_18 + 1])
  end
  return A3_19
end
function prototype.numberOfCellsInTableView(A0_22, A1_23)
  local L2_24
  L2_24 = A0_22.data
  L2_24 = L2_24[A1_23]
  L2_24 = #L2_24
  return L2_24
end
function prototype.tableCellTouched(A0_25, A1_26, A2_27)
end
function prototype.tablePageTurn(A0_28, A1_29)
  A0_28.tableViewControl:RequireUpdate()
end
function prototype.onBtnHarmReward(A0_30)
  Logic:Get("Devil"):FireEvent(Logic.Devil.EVT.PAGE_CHANGE, 3)
end
function prototype.onBtnReturnDevil(A0_31)
  Logic:Get("Devil"):FireEvent(Logic.Devil.EVT.PAGE_CHANGE, 1)
end
