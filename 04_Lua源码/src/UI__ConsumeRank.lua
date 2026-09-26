module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local MY_RANK_PATH = "images/Devil/myRanking.png"
local RANK_TOP_PATH = "images/Devil/rankTop.png"
local MAX_RANK_PER_PAGE = 10
function prototype:initialize()
  super.initialize(self)
  self.page = 1
  self.rankData = {}
end
function prototype:onEnter()
  super.onEnter(self)
  self.type = "my"
  local ccBtn = CCSprite:create(MY_RANK_PATH)
  self.sprRightBtn:setDisplayFrame(ccBtn:displayFrame())
  self.rankData = Logic:Get("Consume"):getConsumeToprank()
  self.page = 1
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstRank, self.page)
  self.tableViewControl.tableView:runUIAnimat()
  self.lstRank:addChild(self.tableViewControl.tableView)
end
function prototype:RefreshCostRank()
  if self.tableViewControl ~= nil then
    self.tableViewControl:RequireUpdate(1)
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 117)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ConsumeRankItem", self.rootNode)
    subScene.pRankItem:RefreshRank(self.rankData[index + 1], index + 1)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2).pRankItem:RefreshRank(self.rankData[index + 1], index + 1)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.rankData ~= nil and next(self.rankData) ~= nil then
    if self.page == curPage then
      return #self.rankData
    else
      return MAX_RANK_PER_PAGE
    end
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
function prototype:onBtnReturn()
  SceneHelper:runWithScene("GiftActivityInfoConsumeReward", self.rootNode)
end
function prototype:onBtnMyRank(sender, event)
  if self.type ~= "my" then
    local rankData = Logic:Get("Consume"):getConsumeToprank() or {}
    if table.empty(rankData) then
      return
    end
    self.rankData = rankData
    local ccBtn = CCSprite:create(MY_RANK_PATH)
    self.sprRightBtn:setDisplayFrame(ccBtn:displayFrame())
    self.type = "my"
    if self.tableViewControl ~= nil then
      self.tableViewControl:RequireUpdate()
    end
  else
    local rankData = Logic:Get("Consume"):getConsumeOtherrank() or {}
    if table.empty(rankData) then
      return
    end
    self.rankData = rankData
    local ccBtn = CCSprite:create(RANK_TOP_PATH)
    self.sprRightBtn:setDisplayFrame(ccBtn:displayFrame())
    self.type = "Other"
    if self.tableViewControl ~= nil then
      self.tableViewControl:RequireUpdate()
    end
  end
end
function prototype:onBtnFeatsRank(sender, event)
  SceneHelper:runWithScene("GiftActivityInfoConsumeReward", self.rootNode)
end
