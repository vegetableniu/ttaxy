module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype.initialize(A0_0)
  super.initialize(A0_0)
  A0_0.titleinfo = {}
  A0_0.data = {}
end
function prototype.cellSizeForTable(A0_1, ...)
  return CCSizeMake(563, 120)
end
function prototype.tableCellAtIndex(A0_3, A1_4, A2_5, A3_6, A4_7)
  local L5_8
  if not A3_6 then
    L5_8 = CCTableViewCellEx
    L5_8 = L5_8.create
    L5_8 = L5_8(L5_8)
    A3_6 = L5_8
    L5_8 = Tw
    L5_8 = L5_8.Controller
    L5_8 = L5_8.load
    L5_8 = L5_8(L5_8, "ActivityNode", A0_3.rootNode)
    L5_8:ReFrashInfo(A0_3.titleinfo[A2_5 + 1], A2_5)
    A3_6:addChild(L5_8, 0, 2)
  else
    L5_8 = A3_6.getChildByTag
    L5_8 = L5_8(A3_6, 2)
    L5_8 = L5_8.ReFrashInfo
    L5_8(L5_8, A0_3.titleinfo[A2_5 + 1], A2_5)
  end
  return A3_6
end
function prototype.numberOfCellsInTableView(A0_9, A1_10)
  local L2_11
  L2_11 = A0_9.data
  L2_11 = L2_11[A1_10]
  L2_11 = #L2_11
  return L2_11
end
function prototype.getcurActiveId(A0_12, A1_13)
  local L2_14, L3_15
  L2_14 = 1
  L3_15 = ""
  for _FORV_7_, _FORV_8_ in pairs(A0_12.titleinfo) do
    if A1_13 == L2_14 then
      L3_15 = _FORV_7_
      return L3_15
    end
    L2_14 = L2_14 + 1
  end
  return L3_15
end
function prototype.tableCellTouched(A0_16, A1_17, A2_18)
end
function prototype.tablePageTurn(A0_19, A1_20)
  A0_19.tableViewControl:RequireUpdate()
end
function prototype.onEnter(A0_21)
  super.onEnter(A0_21)
  A0_21.sprRight:setVisible(false)
  A0_21.imgBtnRightBg:setVisible(false)
  Logic:Get("Activity"):On(Logic.Activity.EVT.REFRESH_ACTIVE_COPY, A0_21:Event("refrashUITime"))
  A0_21:refrash()
end
function prototype.refrashUITime(A0_22)
  A0_22:getNewTimes()
  A0_22.tableViewControl.tableView:refreshData()
end
function prototype.getNewTimes(A0_23)
  A0_23.titleinfo = A0_23:getAllActivityInfo()
  A0_23.data = {
    A0_23.titleinfo
  }
end
function prototype.refrash(A0_24)
  A0_24.titleinfo = A0_24:getAllActivityInfo()
  A0_24.data = {
    A0_24.titleinfo
  }
  A0_24:createList()
end
function prototype.createList(A0_25)
  local L1_26
  L1_26 = TableViewEx
  L1_26 = L1_26.prototype
  L1_26 = L1_26.createList
  L1_26 = L1_26(L1_26, A0_25, A0_25.lstActivity, 1)
  A0_25.tableViewControl = L1_26
  L1_26 = A0_25.getTableViewOffset
  L1_26 = L1_26(A0_25)
  if L1_26 ~= nil then
    A0_25.tableViewControl.tableView:setTableViewOffset(L1_26)
  end
  A0_25.tableViewControl.tableView:runUIAnimat()
  A0_25.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  A0_25.lstActivity:addChild(A0_25.tableViewControl.tableView)
end
function prototype.getAllActivityInfo(A0_27)
  local L1_28, L2_29, L3_30, L4_31, L5_32, L6_33, L7_34
  L1_28 = Logic
  L2_29 = L1_28
  L1_28 = L1_28.Get
  L1_28 = L1_28(L2_29, L3_30)
  L2_29 = L1_28
  L1_28 = L1_28.IsLockTowerListMode
  L1_28 = L1_28(L2_29)
  if L1_28 then
    L1_28 = {}
    L2_29 = {
      L3_30,
      L4_31,
      L5_32,
      L6_33,
      L7_34,
      "CLX06"
    }
    L6_33 = "CLX04"
    L7_34 = "CLX05"
    for L6_33, L7_34 in L3_30(L4_31) do
      if Logic:Get("Activity"):getCampaignInfo(L7_34) then
        table.insert(L1_28, {
          activeId = L7_34,
          name = Logic:Get("Activity"):getEachGrpNameAndAward(L7_34)
        })
      end
    end
    return L1_28
  end
  L1_28 = {}
  L2_29 = Logic
  L2_29 = L2_29.Get
  L2_29 = L2_29(L3_30, L4_31)
  L2_29 = L2_29.getActiveInfoForUI
  L2_29 = L2_29(L3_30)
  L1_28 = L2_29
  return L1_28
end
function prototype.onBtnReturn(A0_35, A1_36, A2_37)
  if Logic:Get("Rebirth"):IsLockTowerListMode() then
    Logic:Get("Rebirth"):SetLockTowerListMode(false)
    SceneHelper:runWithScene("Artifact", A0_35.rootNode)
    return
  end
  if Logic:Get("Battle"):IsOpenActivityInBattleCopy() then
    Logic:Get("Battle"):setOpenActivityInBattleCopy(false)
    SceneHelper:runWithScene("BattleCopy", A0_35.rootNode)
    return
  end
  SceneHelper:runWithScene("Home", A0_35.rootNode)
end
function prototype.onBtnActivityList(A0_38, A1_39, A2_40)
  do return end
  SceneHelper:pushScene("ActivityList", A0_38.rootNode)
end
function prototype.actionFinish(A0_41, A1_42)
  if not Logic:Get("Guide"):isGuiding() then
    return
  end
  if A0_41:getTableViewOffset() == nil then
    return
  end
  if A1_42:cellAtIndex(A0_41:getTableViewOffset() - 1) == nil then
    return
  end
  if A1_42:cellAtIndex(A0_41:getTableViewOffset() - 1):getChildByTag(2) == nil then
    return
  end
  A1_42:cellAtIndex(A0_41:getTableViewOffset() - 1):getChildByTag(2):updateGuide()
end
function prototype.getTableViewOffset(A0_43)
  if Logic:Get("Guide"):isActive("Activity", "SelectCampaign") then
    for _FORV_5_ = 1, #A0_43:getAllActivityInfo() do
      if A0_43:getAllActivityInfo()[_FORV_5_].activeId == "CA02" then
        return _FORV_5_
      end
    end
  end
end
