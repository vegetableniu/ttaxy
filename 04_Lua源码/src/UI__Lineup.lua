require("SceneHelper")
require("TableViewEx")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  Logic:Get("Lineup"):createTalismanMap()
  Logic:Get("Lineup"):createArmorMap()
  self.tableViewControl = TableViewEx.prototype:createList(self, self.nodList, 1)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.nodList:addChild(self.tableViewControl.tableView)
  Logic:Get("Lineup"):On(Logic.Lineup.EVT.USE_TEAM, self:Event("onUseTeam"))
  Logic:Get("Lineup"):On(Logic.Lineup.EVT.UPDATE_TEAM_NAME, self:Event("onUpdateTeamName"))
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:removeScene("Lineup", self.rootNode)
end
function prototype:onBtnCover(sender, event)
end
function prototype:onBtnBg(sender, event)
end
function prototype:onUseTeam()
  SceneHelper:removeScene("Lineup", self.rootNode)
end
function prototype:onUpdateTeamName()
  self.tableViewControl:RequireUpdate()
end
function prototype:cellSizeForTable(...)
  local allItemsHeight = Logic:Get("Lineup"):getAllItemsHeight()
  return CCSizeMake(640, allItemsHeight)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local tag = 2
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("LineupItem", self.rootNode)
    cell:addChild(subScene, 0, tag)
  end
  cell:getChildByTag(tag):Refresh()
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  return 1
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
