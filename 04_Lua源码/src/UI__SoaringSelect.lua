module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local MAX_LIST_ITEM = 20
function prototype:onEnter()
  super.onEnter(self)
  self.data = Logic:Get("Soaring"):getSoaringList()
  self.page = math.ceil(#self.data / MAX_LIST_ITEM)
  self.tableViewControl = TableViewEx.prototype:createList(self, self.nodCardList, self.page)
  if self.page == 1 then
    self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  end
  self.nodCardList:addChild(self.tableViewControl.tableView)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:removeScene("SoaringSelect", self.rootNode)
end
function prototype:onBtnLeft(sender, event)
  if self.tableViewControl == nil then
    return
  end
  self.tableViewControl:TurnPage(-1)
end
function prototype:onBtnRight(sender, event)
  if self.tableViewControl == nil then
    return
  end
  self.tableViewControl:TurnPage(1)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(588, 120)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local lstIdx = index + 1 + (curPage - 1) * MAX_LIST_ITEM
  local singleData = self.data[lstIdx]
  local tag = 2
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("SoaringSelectItem", self.rootNode)
    cell:addChild(subScene, 0, tag)
  end
  cell:getChildByTag(tag):RefrashItem(singleData)
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if table.empty(self.data or {}) then
    return 0
  end
  self.ttfPage:setString(curPage .. "/" .. self.page)
  if self.page == curPage then
    local num = #self.data - (self.page - 1) * MAX_LIST_ITEM
    if num > MAX_LIST_ITEM then
      num = MAX_LIST_ITEM or num
    end
    return num
  end
  return MAX_LIST_ITEM
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
