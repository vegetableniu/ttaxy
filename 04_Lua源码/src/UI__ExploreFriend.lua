require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
module((...), package.seeall)
local MAX_ITEMS = 20
prototype = BtnPosition.prototype:extend()
function prototype:onEnter()
  super.onEnter(self)
  self.cards = {}
  self:refreshCostAndLimit()
  self.data = {}
  self.tableViewControl = TableViewEx.prototype:createList(self, self.nodList, 1)
  self.nodList:addChild(self.tableViewControl.tableView)
  Logic:Get("Explore"):On(Logic.Explore.EVT.GET_FRIEND_CARDS, self:Event("onGetFriendCards"))
  Logic:Get("Explore"):postGetFriendCards()
end
function prototype:refreshCostAndLimit()
  local currTask = Logic:Get("Explore"):getCurrTask()
  local rec = KFDBGetRecord("TaskStarConfig", currTask.star) or {}
  self.ttfCost:setStyle(kCCLabelTTFStyleOutline)
  self.ttfMaxFriends:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCost:setString(rec.hireFriendCosts)
  self.ttfMaxFriends:setString(rec.hireFriendLimit)
end
function prototype:onBtnReturn(sender, event)
  Logic:Get("Explore"):clearSelect("FRIEND")
  SceneHelper:removeScene("ExploreFriend", self.rootNode)
end
function prototype:onBtnConfirm(sender, event)
  local cards = Logic:Get("Explore"):getSelectFriends()
  if table.empty(cards or {}) then
    self:onConfirmSelect()
    return
  end
  Prompt:Confirm(self, "", TwGetStr(115231), self.onConfirmSelect, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onConfirmSelect()
  Logic:Get("Explore"):FireEvent(Logic.Explore.EVT.CARD_CHANGED)
  SceneHelper:removeScene("ExploreFriend", self.rootNode)
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
function prototype:onGetFriendCards()
  self.data = Logic:Get("Explore"):getFriendCards()
  for i, v in ipairs(self.data) do
    v.fit = Logic:Get("Explore"):getFitSuccessTable(v.baseId)
  end
  table.sort(self.data, function(lp, rp)
    if #lp.fit ~= #rp.fit then
      return #lp.fit > #rp.fit
    end
    local infoA = Logic:Get("Hero"):GetHeroInfoByBaseId(lp.baseId)
    local infoB = Logic:Get("Hero"):GetHeroInfoByBaseId(rp.baseId)
    if infoA.rank ~= infoB.rank then
      return infoA.rank > infoB.rank
    end
    return infoA.star > infoB.star
  end)
  self.page = math.ceil(#self.data / MAX_ITEMS)
  self.tableViewControl:RequireUpdate(self.page)
end
function prototype:selectedCard(id, data)
  Logic:Get("Explore"):selectedCard(id, data, "FRIEND")
  self.tableViewControl:RequireUpdateWithoutAnimat()
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 121)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local tag = 2
  local idx = index + 1 + (curPage - 1) * MAX_ITEMS
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ExploreSelectItem", self.rootNode)
    cell:addChild(subScene, 0, tag)
  end
  cell:getChildByTag(tag):Refresh(self.data[idx], self, "FRIEND")
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if table.empty(self.data or {}) then
    return 0
  end
  self.ttfPage:setString(curPage .. "/" .. self.page)
  if self.page == curPage then
    local num = #self.data - (self.page - 1) * MAX_ITEMS
    return num
  end
  return MAX_ITEMS
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
