require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
module((...), package.seeall)
prototype = BtnPosition.prototype:extend()
function prototype:onEnter()
  super.onEnter(self)
  self.data = self:createList()
  self.tableViewControl = TableViewEx.prototype:createList(self, self.nodList, 1)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.nodList:addChild(self.tableViewControl.tableView)
end
function prototype:createList()
  local list = {}
  local currTask = Logic:Get("Explore"):getCurrTask()
  for i = 1, KFDBGetRecordAmt("ExploreVirtualCard") do
    local rec = KFDBGetRecordByIdx("ExploreVirtualCard", i)
    if rec and rec.star == currTask.star then
      table.insert(list, rec)
    end
  end
  return list
end
function prototype:onBtnReturn(sender, event)
  Logic:Get("Explore"):clearSelect("SYSTEM")
  SceneHelper:removeScene("ExploreSystem", self.rootNode)
end
function prototype:onBtnConfirm(sender, event)
  local cards = Logic:Get("Explore"):getSystemCards()
  if table.empty(cards or {}) then
    self:onConfirmSelect()
    return
  end
  Prompt:Confirm(self, "", TwGetStr(115231), self.onConfirmSelect, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onConfirmSelect()
  Logic:Get("Explore"):FireEvent(Logic.Explore.EVT.CARD_CHANGED)
  SceneHelper:removeScene("ExploreSystem", self.rootNode)
end
function prototype:onBtnBg(sender, event)
end
function prototype:selectedCard(id, data)
  Logic:Get("Explore"):selectedCard(id, data, "SYSTEM")
  self.tableViewControl:RequireUpdateWithoutAnimat()
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 121)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local tag = 2
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ExploreSystemItem", self.rootNode)
    cell:addChild(subScene, 0, tag)
  end
  cell:getChildByTag(tag):Refresh(self.data[index + 1], self)
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if table.empty(self.data or {}) then
    return 0
  end
  return #self.data
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
