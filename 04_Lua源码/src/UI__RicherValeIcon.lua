require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.data = {}
  for i = 1, KFDBGetRecordAmt("MoBuffIcon") do
    local rec = KFDBGetRecordByIdx("MoBuffIcon", i)
    table.insert(self.data, rec)
  end
  table.sort(self.data, function(a, b)
    return a.sort > b.sort
  end)
  self.tableViewControl = TableViewEx.prototype:createList(self, self.nodList, 1)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.nodList:addChild(self.tableViewControl.tableView)
end
function prototype:onBtnBg(sender, event)
end
function prototype:onBtnClose(sender, event)
  SceneHelper:removeScene("RicherValeIcon", self.rootNode)
  Logic:Get("NewMonopoly"):FireEvent(Logic.NewMonopoly.EVT.SWITCH_DRAG, true)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(470, 115)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local tag = 2
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("RicherValeIconItem", self.rootNode)
    cell:addChild(subScene, 0, tag)
  end
  cell:getChildByTag(tag):refreshItem(self.data[index + 1])
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
