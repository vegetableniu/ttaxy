module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("Logic.Compose")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnReturn()
  SceneHelper:runWithScene("GiftActivityInfoConsume", self.rootNode)
end
function prototype:onEnter()
  super.onEnter(self)
  Logic:Get("Consume"):On(Logic.Consume.EVT.CAN_SHOW_REWARD_LIST, self:Event("RefrashRewardInfo"))
  Logic:Get("Consume"):initConsumeList()
  self.canShowRewardList = Logic:Get("Consume"):getCanShowRewardList() or {}
  self.data = self.canShowRewardList
  self.page = math.ceil(#self.canShowRewardList / Logic.Compose.MAX_LIST)
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pCList, self.page)
  if self.page == 1 then
    self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  end
  self.tableViewControl.tableView:runUIAnimat()
  self.m_pCList:addChild(self.tableViewControl.tableView)
end
function prototype:RefrashRewardInfo()
  Logic:Get("Consume"):initConsumeList()
  self.canShowRewardList = Logic:Get("Consume"):getCanShowRewardList() or {}
  self.data = self.canShowRewardList
  self.page = math.ceil(#self.canShowRewardList / Logic.Compose.MAX_LIST)
  self.tableViewControl:RequireUpdate(self.page, true, true)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(588, 164)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local lstIdx = index + 1 + (curPage - 1) * Logic.Compose.MAX_LIST
  local key = self.canShowRewardList[lstIdx]
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ConsumeGiftItem", self.rootNode)
    subScene:ReFrashReward(key, index)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):ReFrashReward(key, index)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.page == 0 then
    self.page = 1
  end
  self.ttfPage:setString(curPage .. "/" .. self.page)
  if #self.canShowRewardList == 0 then
    return 0
  end
  if self.page == curPage then
    local num = #self.canShowRewardList - (self.page - 1) * Logic.Hero.MAX_HEROS_PER_PAGE
    return num
  else
    return Logic.Compose.MAX_LIST
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:onBtnLeft()
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onBtnRight()
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(1)
  end
end
