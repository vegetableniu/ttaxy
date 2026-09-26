module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("Logic.Compose")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onBtnReturn()
  SceneHelper:runWithScene("GiftActivityInfoConsume", self.rootNode)
end
function prototype:onBtnRecharge(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
function prototype:onEnter()
  super.onEnter(self)
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz", self.sprRight, ccp(35, 19), 0, nil, nil)
  if self.ani then
    self.ani:RunAni()
  end
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.rankRewardInfo = {}
  for i = 1, KFDBGetRecordAmt("ScoreRankReward") do
    local rec = KFDBGetRecordByIdx("ScoreRankReward", i)
    if rec and rec.activityId == giftInfo.id then
      table.insert(self.rankRewardInfo, rec)
    end
  end
  if self.rankRewardInfo == nil then
    return
  end
  self.data = self.rankRewardInfo
  self.page = 1
  self.tableViewControl = TableViewEx.prototype:createList(self, self.rankRewardList, self.page, false)
  self.tableViewControl.tableView:runUIAnimat()
  self.rankRewardList:addChild(self.tableViewControl.tableView)
  self.content:setString(TwGetStr(108057))
  self.content2:setString(TwGetStr(108059))
  self:onTimer()
  if not self.eventTracer:Exist("onTimer") then
    Singleton(Timer):Repeat(1000, self:Event("onTimer"))
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(480, 70)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ConsumeRewardItem", self.rootNode)
    subScene:RefreshReward(self.data[index + 1], index)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):RefreshReward(self.data[index + 1], index)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.rankRewardInfo == nil or next(self.rankRewardInfo) == nil then
    return 0
  end
  return #self.rankRewardInfo
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
function prototype:onBtnCheckRank(sender, event)
  SceneHelper:runWithScene("ConsumeRank", self.rootNode)
end
function prototype:onTimer()
  local closeTime = Logic:Get("Consume"):getCloseTime()
  if closeTime and closeTime ~= 0 then
    local diffTime = Logic:Get("System"):DiffTime(closeTime / 1000)
    closeTime = Logic:Get("System"):SecToDay(diffTime)
    if closeTime and diffTime > 0 then
      closeTime.hour = closeTime.hour + closeTime.day * 24
      local str = string.format("%02d:%02d:%02d", closeTime.hour or 0, closeTime.min or 0, closeTime.sec or 0)
      self.ttfCloseTime:setString(str)
    else
      self.ttfCloseTime:setString("")
    end
  else
    self.ttfCloseTime:setString("")
  end
end
