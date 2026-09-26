module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype.initialize(A0_0)
  super.initialize(A0_0)
end
function prototype.onNodeLoaded(A0_1, A1_2, A2_3)
end
function prototype.onEnter(A0_4)
  super.onEnter(A0_4)
  if A0_4.btnEnter then
    A0_4.btnEnter:setVisible(false)
    A0_4.btnEnter:setEnabled(false)
  end
  A0_4.data = require("FabaoTranslate").GetSelectList()
  A0_4.page = math.ceil(#A0_4.data / Logic.Talisman.MAX_FABAO_PER_PAGE)
  A0_4.page = A0_4.page == 0 and 1 or A0_4.page
  A0_4.tableViewControl = TableViewEx.prototype:createList(A0_4, A0_4.lstFabao, A0_4.page)
  A0_4.lstFabao:addChild(A0_4.tableViewControl.tableView)
  if A0_4.imgNumBg then
    A0_4.imgNumBg:setVisible(false)
  end
  if A0_4.staFabaoNum then
    A0_4.staFabaoNum:setVisible(false)
  end
  Logic:Get("Compose"):On(Logic.Compose.EVT.SELECT_CARD, A0_4:Event("onSelectCard"))
end
function prototype.onSelectCard(A0_5)
  if require("FabaoTranslate").GetPickMode() == "advanceMaterial" then
    A0_5.data = require("FabaoTranslate").GetSelectList()
    A0_5.page = math.ceil(#A0_5.data / Logic.Talisman.MAX_FABAO_PER_PAGE)
    A0_5.page = A0_5.page == 0 and 1 or A0_5.page
    if A0_5.tableViewControl then
      A0_5.tableViewControl:RequireUpdateWithoutAnimat()
    end
    return
  end
  if require("FabaoTranslate").GetSelect() then
    SceneHelper:popScene()
    return
  end
  A0_5.tableViewControl:RequireUpdateWithoutAnimat()
end
function prototype.onBtnReturn(A0_6)
  SceneHelper:popScene()
end
function prototype.onBtnEnter(A0_7)
  local L1_8
end
function prototype.onBtnLeft(A0_9)
  if A0_9.tableViewControl ~= nil then
    A0_9.tableViewControl:TurnPage(-1)
  end
end
function prototype.onBtnRight(A0_10)
  if A0_10.tableViewControl ~= nil then
    A0_10.tableViewControl:TurnPage(1)
  end
end
function prototype.cellSizeForTable(A0_11, ...)
  return CCSizeMake(563, 117)
end
function prototype.tableCellAtIndex(A0_13, A1_14, A2_15, A3_16, A4_17)
  local L5_18, L6_19
  L5_18 = A0_13.data
  L6_19 = A4_17 - 1
  L6_19 = L6_19 * Logic.Talisman.MAX_FABAO_PER_PAGE
  L6_19 = L6_19 + A2_15
  L6_19 = L6_19 + 1
  L5_18 = L5_18[L6_19]
  if not A3_16 then
    L6_19 = CCTableViewCellEx
    L6_19 = L6_19.create
    L6_19 = L6_19(L6_19)
    A3_16 = L6_19
    L6_19 = Tw
    L6_19 = L6_19.Controller
    L6_19 = L6_19.load
    L6_19 = L6_19(L6_19, "FabaoTransSelectItem", A0_13.rootNode)
    L6_19:ReFrashInfo(L5_18)
    A3_16:addChild(L6_19, 0, 2)
  else
    L6_19 = A3_16.getChildByTag
    L6_19 = L6_19(A3_16, 2)
    L6_19 = L6_19.ReFrashInfo
    L6_19(L6_19, L5_18)
  end
  return A3_16
end
function prototype.numberOfCellsInTableView(A0_20, A1_21)
  local L2_22, L3_23
  L2_22 = A0_20.staPage
  if L2_22 then
    L2_22 = A0_20.staPage
    L3_23 = L2_22
    L2_22 = L2_22.setString
    L2_22(L3_23, string.format("%d/%d", A1_21 or 1, A0_20.page or 1))
  end
  L2_22 = A0_20.data
  if L2_22 ~= nil then
    L2_22 = A0_20.data
    L2_22 = #L2_22
  elseif L2_22 == 0 then
    L2_22 = 0
    return L2_22
  end
  L2_22 = A0_20.page
  if L2_22 == A1_21 then
    L2_22 = A0_20.data
    L2_22 = #L2_22
    L3_23 = A0_20.page
    L3_23 = L3_23 - 1
    L3_23 = L3_23 * Logic.Talisman.MAX_FABAO_PER_PAGE
    L2_22 = L2_22 - L3_23
    return L2_22
  else
    L2_22 = Logic
    L2_22 = L2_22.Talisman
    L2_22 = L2_22.MAX_FABAO_PER_PAGE
    return L2_22
  end
end
function prototype.tableCellTouched(A0_24, A1_25, A2_26)
end
function prototype.tablePageTurn(A0_27, A1_28)
  A0_27.tableViewControl:RequireUpdate()
end
