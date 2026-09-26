module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  self.data = {}
  for i = 1, KFDBGetRecordAmt("NPCLevelConfig") do
    local rec = KFDBGetRecordByIdx("NPCLevelConfig", i)
    if rec then
      table.insert(self.data, rec)
    end
  end
  local info = Logic:Get("Explore"):GetExploreVo()
  self.labLevel:create(info.level, "GREEN_NUM")
  self.labLevel:setAlign("LEFT", "CENTER")
  self.page = #self.data
  self.tableViewControl = TableViewEx.prototype:createList(self, self.nodItems, self.page)
  self.nodItems:addChild(self.tableViewControl.tableView)
  self.tableViewControl:TurnPageTo(info.level, true, true)
end
function prototype:onExit()
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:removeScene("ExploreShow", self.rootNode)
end
function prototype:onBtnLeft(sender, event)
  if self.tableViewControl then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onBtnRight(sender, event)
  if self.tableViewControl then
    self.tableViewControl:TurnPage(1)
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(560, 430)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local tag = 2
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ExploreShowItem", self.rootNode)
    cell:addChild(subScene, 0, tag)
  end
  cell:getChildByTag(tag):Refresh(self.data[curPage], self.type)
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  self.ttfPage:setString(curPage .. "/" .. self.page)
  self.labLevel:setValue(curPage)
  return 1
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
