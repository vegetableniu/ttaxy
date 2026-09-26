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
  self.type = "TOP_RANK"
  local ccBtn = CCSprite:create(MY_RANK_PATH)
  if ccBtn then
    self.sprRightBtn:setDisplayFrame(ccBtn:displayFrame())
  end
  self.rankData = Logic:Get("GiftRank"):GetRankData()
  self.page = 1
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstRank, self.page)
  self.tableViewControl.tableView:runUIAnimat()
  self.lstRank:addChild(self.tableViewControl.tableView)
end
function prototype:onBtnReturn()
  SceneHelper:runWithScene("GiftCommonConsume", self.rootNode)
end
function prototype:onBtnMyRank(sender, event)
  if self.type == "TOP_RANK" then
    self.type = "OTHER"
  else
    self.type = "TOP_RANK"
  end
  self:changeBtnImg()
  if self.tableViewControl then
    self.tableViewControl:RequireUpdate()
  end
end
function prototype:onBtnFeatsRank(sender, event)
  SceneHelper:runWithScene("GiftCommonReward", self.rootNode)
end
function prototype:changeBtnImg()
  local spr
  if self.type == "TOP_RANK" then
    spr = CCSprite:create(MY_RANK_PATH)
  else
    spr = CCSprite:create(RANK_TOP_PATH)
  end
  if spr then
    self.sprRightBtn:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 117)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("GiftCommonRankItem", self.rootNode)
    local data = self.type == "TOP_RANK" and self.rankData.topList or self.rankData.nearList
    data = data or {}
    subScene.pRankItem:RefreshRank(data[index + 1], index + 1)
    cell:addChild(subScene, 0, 2)
  else
    local data = self.type == "TOP_RANK" and self.rankData.topList or self.rankData.nearList
    data = data or {}
    cell:getChildByTag(2).pRankItem:RefreshRank(data[index + 1], index + 1)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if table.empty(self.rankData or {}) then
    return 0
  end
  local data = self.type == "TOP_RANK" and self.rankData.topList or self.rankData.nearList
  data = data or {}
  if table.empty(data) then
    return 0
  end
  return #data
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
