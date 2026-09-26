module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
require("TableViewEx")
require("table_ext")
function prototype.initialize(A0_0, ...)
  local L2_2, L3_3, L4_4
  L2_2 = super
  L2_2 = L2_2.initialize
  L3_3 = A0_0
  L4_4 = ...
  L2_2(L3_3, L4_4)
  L2_2 = {}
  A0_0.rankRewardInfo = L2_2
  L2_2 = {}
  A0_0.data = L2_2
end
function prototype.dispose(A0_5, ...)
  super.dispose(A0_5)
end
function prototype.onEnter(A0_7)
  local L1_8, L2_9, L3_10, L4_11, L5_12, L6_13, L7_14
  L1_8 = A0_7.ttfState
  L2_9 = L1_8
  L1_8 = L1_8.setString
  L7_14 = L3_10(L4_11)
  L1_8(L2_9, L3_10, L4_11, L5_12, L6_13, L7_14, L3_10(L4_11))
  L1_8 = Logic
  L2_9 = L1_8
  L1_8 = L1_8.Get
  L1_8 = L1_8(L2_9, L3_10)
  L2_9 = L1_8
  L1_8 = L1_8.getActiveId
  L1_8 = L1_8(L2_9)
  L2_9 = Logic
  L2_9 = L2_9.Get
  L2_9 = L2_9(L3_10, L4_11)
  L2_9 = L2_9.getRankGroupId
  L2_9 = L2_9(L3_10)
  if L2_9 and L2_9 > 0 then
    L1_8 = L3_10
  end
  for L6_13 = 1, L4_11(L5_12) do
    L7_14 = KFDBGetRecordByIdx
    L7_14 = L7_14("DamageRankReward", L6_13)
    if L7_14 and L7_14.activeId == L1_8 then
      table.insert(A0_7.rankRewardInfo, L7_14)
    end
  end
  if not L3_10 then
    L3_10(L4_11, L5_12)
  end
  A0_7.data = L3_10
  L6_13 = A0_7.harmRewardInfo
  L7_14 = 1
  A0_7.tableViewControl = L3_10
  L3_10(L4_11)
  L3_10(L4_11, L5_12)
  L3_10(L4_11, L5_12)
end
function prototype.cellSizeForTable(A0_15, ...)
  return CCSizeMake(563, 50)
end
function prototype.tableCellAtIndex(A0_17, A1_18, A2_19, A3_20, A4_21)
  local L5_22
  if not A3_20 then
    L5_22 = CCTableViewCellEx
    L5_22 = L5_22.create
    L5_22 = L5_22(L5_22)
    A3_20 = L5_22
    L5_22 = Tw
    L5_22 = L5_22.Controller
    L5_22 = L5_22.load
    L5_22 = L5_22(L5_22, "DevilRewardItem", A0_17.rootNode)
    L5_22:RefreshReward(A0_17.rankRewardInfo[A2_19 + 1])
    A3_20:addChild(L5_22, 0, 2)
  else
    L5_22 = A3_20.getChildByTag
    L5_22 = L5_22(A3_20, 2)
    L5_22 = L5_22.RefreshReward
    L5_22(L5_22, A0_17.rankRewardInfo[A2_19 + 1])
  end
  return A3_20
end
function prototype.numberOfCellsInTableView(A0_23, A1_24)
  local L2_25
  L2_25 = A0_23.data
  L2_25 = L2_25[A1_24]
  L2_25 = #L2_25
  return L2_25
end
function prototype.tableCellTouched(A0_26, A1_27, A2_28)
end
function prototype.tablePageTurn(A0_29, A1_30)
  A0_29.tableViewControl:RequireUpdate()
end
function prototype.onBtnFeatsReward(A0_31)
  Logic:Get("Devil"):FireEvent(Logic.Devil.EVT.PAGE_CHANGE, 2)
end
function prototype.onBtnCard(A0_32)
  Logic:Get("Devil"):FireEvent(Logic.Devil.EVT.PAGE_CHANGE, 4)
end
