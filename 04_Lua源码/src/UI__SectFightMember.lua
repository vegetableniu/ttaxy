module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
require("TableViewEx")
local MAX_PER_PAGE = 10
function prototype:onEnter()
  local joinFightInfo = Logic:Get("Sect"):GetCountryFightJoinedInfo()
  if table.empty(joinFightInfo or {}) then
    return
  end
  if table.empty(joinFightInfo.ownTeam or {}) then
    return
  end
  self.joinFightMember = Logic:Get("Sect"):fightMemberSort(joinFightInfo.ownTeam)
  self.data = self.joinFightMember
  self.page = math.ceil(#self.joinFightMember / MAX_PER_PAGE)
  if self.page == 0 then
    self.page = 1
  end
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstMember, self.page)
  self.lstMember:addChild(self.tableViewControl.tableView)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnLeft(sender, event)
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onBtnRight(sender, event)
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(1)
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 130)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("SectMemberItem", self.rootNode)
    subScene:refresh(self.data[(curPage - 1) * MAX_PER_PAGE + index + 1])
    cell:addChild(subScene, 1, 2)
  else
    cell:getChildByTag(2):refresh(self.data[(curPage - 1) * MAX_PER_PAGE + index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  self.curPage = curPage or 1
  self.labPage:setString(string.format("%d/%d", curPage, self.page))
  if table.empty(self.data or {}) then
    return 0
  end
  if self.page == curPage then
    return #self.data - (self.page - 1) * MAX_PER_PAGE
  else
    return MAX_PER_PAGE
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
