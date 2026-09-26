module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onEnter()
  super.onEnter(self)
  self:initTableViewData()
  self.tableViewControl = TableViewEx.prototype:createList(self, self.nodList, 1)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.nodList:addChild(self.tableViewControl.tableView)
end
function prototype:onBtnReturn()
  SceneHelper:removeScene("CultivateShop", self.rootNode)
end
function prototype:onBtnRecharge(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
function prototype:onBtnBg(sender, event)
end
function prototype:initTableViewData()
  self.data = {}
  for i = 1, KFDBGetRecordAmt("ShopSetting") do
    local rec = KFDBGetRecordByIdx("ShopSetting", i)
    table.insert(self.data, rec)
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(561, 121)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local idx = index + 1
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("CultivateShopItem", self.rootNode)
    cell:addChild(subScene, 0, 2)
  end
  cell:getChildByTag(2):refreshItem(self.data[idx])
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  return #self.data
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
