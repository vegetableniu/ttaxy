module((...), package.seeall)
require("BtnPosition")
local Reward = require("Logic.Reward")
local WIN_WIDTH, WIN_HEIGHT = 600, 80
prototype = BtnPosition.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  self:refresh()
end
function prototype:refresh()
  local campaignId = Logic:Get("Battle"):GetCurSelCampaign()
  local battleIdLst = {}
  local battleInfo = {}
  if campaignId then
    battleIdLst = Logic:Get("Battle"):GetBattleLst(campaignId)
  end
  if battleIdLst and not table.empty(battleIdLst) then
    for k, v in pairs(battleIdLst) do
      table.insert(battleInfo, Logic:Get("Battle"):GetBattleInfoById(v))
    end
  end
  self.data = {
    [1] = battleInfo
  }
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pCList, 1)
  self.tableViewControl.tableView:setVerticalFillOrder(kCCTableViewFillBottomUp)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.m_pCList:addChild(self.tableViewControl.tableView)
  self.tableViewControl:RequireUpdate(self.maxPage)
end
function prototype:onBtnReturn()
  SceneHelper:popScene()
  Logic:Get("Battle"):FireEvent(Logic.Battle.EVT.REOPEN_BATTLE_COPY)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(WIN_WIDTH, WIN_HEIGHT)
end
function prototype:tableCellAtIndex(tabl, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("CopyDropItem", self.rootNode)
    if self.data and not table.empty(self.data) and self.data[curPage] and self.data[curPage][index + 1] then
      subScene:showDropItemInfo(self.data[curPage][index + 1])
    end
    cell:addChild(subScene, 0, 2)
  elseif self.data and not table.empty(self.data) and self.data[curPage] and self.data[curPage][index + 1] then
    cell:getChildByTag(2):showDropItemInfo(self.data[curPage][index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.data and self.data[curPage] and next(self.data[curPage]) ~= nil then
    return #self.data[curPage]
  else
    return 0
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
