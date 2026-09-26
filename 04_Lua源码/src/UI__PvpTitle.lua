module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
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
  for i = 1, KFDBGetRecordAmt("PVPBuff") do
    local rec = KFDBGetRecordByIdx("PVPBuff", i)
    if rec then
      table.insert(self.data, rec)
    end
  end
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pList, 1, false)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.m_pList:addChild(self.tableViewControl.tableView)
  self.tableViewControl.tableView:runUIAnimat()
end
function prototype:onExit()
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnReturn(sender, event)
  Logic:Get("Pvp"):SetRankType(Logic.Pvp.RANK_TYPE.RANK_REWARD)
  SceneHelper:runWithScene("PvpRank", self.rootNode)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 140)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("PvpTitleItem", self.rootNode)
    subScene:RefreshTitleInfo(self.data[index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):RefreshTitleInfo(self.data[index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.data == nil or table.empty(self.data) then
    return 0
  end
  return #self.data
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
