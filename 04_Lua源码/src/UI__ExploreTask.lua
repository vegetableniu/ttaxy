require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.cost = 0
  self.data = Logic:Get("Explore"):getCurrTask()
  local rec = KFDBGetRecord("TaskPlace", self.data.point)
  self.ttfTitle:setString(rec.taskName or "")
  self:changeBtnStatues()
  self.tableViewControl = TableViewEx.prototype:createList(self, self.nodList, 1)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.nodList:addChild(self.tableViewControl.tableView)
  Logic:Get("Explore"):On(Logic.Explore.EVT.OWNER_FIGHT_SCORE, self:Event("onOwnerFightScore"))
  Logic:Get("Explore"):On(Logic.Explore.EVT.EXECUTE_TASK, self:Event("onExecuteTask"))
end
function prototype:onBtnReturn(sender, event)
  Logic:Get("Explore"):clearSelect("ALL")
  SceneHelper:removeScene("ExploreTask", self.rootNode)
end
function prototype:onBtnCover(sender, event)
end
function prototype:onBtnBg(sender, event)
end
function prototype:onBtnAction(sender, event)
  local bCardFull = Logic:Get("Explore"):IsCardFull()
  if not bCardFull then
    Prompt:Fail(115244)
    return
  end
  local friends = Logic:Get("Explore"):getSelectFriends()
  if not table.empty(friends) then
    local rec = KFDBGetRecord("TaskStarConfig", self.data.star) or {}
    self.cost = table.size(friends) * (rec.hireFriendCosts or 0)
    Prompt:Confirm(self, "", TwGetStr(115239, self.cost), self.onConfirmHireFriend, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  local systemCards = Logic:Get("Explore"):getSystemCards()
  if not table.empty(systemCards) then
    self.cost = 0
    for k, card in pairs(systemCards) do
      self.cost = self.cost + card.costs
    end
    Prompt:Confirm(self, "", TwGetStr(115240, self.cost), self.onConfirmHireSystem, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  Logic:Get("Explore"):postExecuteTask(self.data.id)
end
function prototype:onConfirmHireFriend()
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  if self.cost > wallet.copper then
    Prompt:Fail(103031)
    return
  end
  Logic:Get("Explore"):postExecuteTask(self.data.id)
end
function prototype:onConfirmHireSystem()
  if Logic:Get("PlayerInfo"):IsMoneyEnough(self.cost) then
    Logic:Get("Explore"):postExecuteTask(self.data.id)
    return
  end
  Logic:Get("Main"):PromptCharge()
end
function prototype:onBtnCover(sender, event)
end
function prototype:onOwnerFightScore()
  self:changeBtnStatues()
  self.tableViewControl:RequireUpdate()
end
function prototype:changeBtnStatues()
  local bCardFull = Logic:Get("Explore"):IsCardFull()
  local normalPath = "images/Moon/btnBlueNormal.png"
  local disablePath = "images/Moon/btnBlueDisabled.png"
  local normal = bCardFull and normalPath or disablePath
  local selected = bCardFull and normalPath or disablePath
  self.btnAction:setBackgroundSpriteForState(CCScale9Sprite:create(normal), CCControlStateNormal)
  self.btnAction:setBackgroundSpriteForState(CCScale9Sprite:create(selected), CCControlStateHighlighted)
end
function prototype:onExecuteTask()
  SceneHelper:removeScene("ExploreTask", self.rootNode)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 875)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local tag = 2
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ExploreTaskItem", self.rootNode)
    cell:addChild(subScene, 0, tag)
  end
  cell:getChildByTag(tag):Refresh(self.data)
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
