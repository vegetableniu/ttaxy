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
  Logic:Get("PlayerInfo"):On(Logic.PlayerInfo.EVT.GET_CONSUME_RANK, self:Event("RefreshCostRank"))
  Logic:Get("PlayerInfo"):setPreFiveRank()
  local ccBtn = CCSprite:create(MY_RANK_PATH)
  self.sprRightBtn:setDisplayFrame(ccBtn:displayFrame())
  self.rankData = Logic:Get("PlayerInfo"):GetRankData()
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstRank, self.page)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.lstRank:addChild(self.tableViewControl.tableView)
end
function prototype:RefreshCostRank()
  self.rankData = Logic:Get("PlayerInfo"):GetRankData()
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
    local subScene = Tw.Controller:load("CostRankItem", self.rootNode)
    subScene.pRankItem:RefreshRank(self.rankData[(curPage - 1) * MAX_RANK_PER_PAGE + index + 1], index + 1)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2).pRankItem:RefreshRank(self.rankData[(curPage - 1) * MAX_RANK_PER_PAGE + index + 1], index + 1)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.rankData ~= nil and next(self.rankData) ~= nil then
    if self.page == curPage then
      return #self.rankData - (self.page - 1) * MAX_RANK_PER_PAGE
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
  SceneHelper:runWithScene("GiftActivityInfoCostReward", self.rootNode)
end
function prototype:onBtnMyRank(sender, event)
  if self.type ~= "my" then
    Logic:Get("PlayerInfo"):setPreFiveRank()
    local ccBtn = CCSprite:create(RANK_TOP_PATH)
    self.sprRightBtn:setDisplayFrame(ccBtn:displayFrame())
    self.type = "my"
  else
    Logic:Get("PlayerInfo"):setMyRankConsunm()
    local rankData = Logic:Get("PlayerInfo"):GetRankData()
    if table.empty(rankData) then
      return
    end
    local ccBtn = CCSprite:create(MY_RANK_PATH)
    self.sprRightBtn:setDisplayFrame(ccBtn:displayFrame())
    self.type = "Other"
  end
end
function prototype:onBtnFeatsRank(sender, event)
  SceneHelper:runWithScene("GiftActivityInfoCostReward", self.rootNode)
end
