module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local RANK_REWARD_PATH = "images/Fight/fontRankReward1.png"
local RANK_PATH = "images/newfont/checkRank.png"
local MY_RANK_PATH = "images/Devil/myRanking.png"
local RANK_TOP_PATH = "images/Devil/rankTop.png"
local TITLE_REWARD_PATH = "images/newfont/titleReward.png"
local TITLE_RANK = "images/Fight/fontRankTitle.png"
local TITLE_REWARD = "images/Fight/fontRankReward1.png"
local RANK_POX_Y = 285
local REWARD_POX_Y = 265
local NODE_RIGHT_X = 480
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  self.ttfReward:setStyle(kCCLabelTTFStyleOutline)
  Logic:Get("Pvp"):On(Logic.Pvp.EVT.UPDATE_RANK_LIST, self:Event("updateRankList"))
  self.rankType = Logic:Get("Pvp"):GetRankType()
  if self.rankType == Logic.Pvp.RANK_TYPE.ALL_RANK then
    self:loadAllRank()
  elseif self.rankType == Logic.Pvp.RANK_TYPE.MY_RANK then
    self:loadMyRank()
  elseif self.rankType == Logic.Pvp.RANK_TYPE.RANK_REWARD then
    self:loadRankReward()
  end
  self.data = {}
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstRank, 1)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.lstRank:addChild(self.tableViewControl.tableView)
  self.tableViewControl.tableView:runUIAnimat()
  MsgPvp:Post("GET_RANK_LIST")
end
function prototype:onExit()
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:loadAllRank()
  self.sprBg:setVisible(false)
  self.lstRank:setPositionY(RANK_POX_Y)
  self.ttfReward:setString("")
  local sprTitle = CCSprite:create(TITLE_RANK)
  if sprTitle then
    self.sprTitle:setDisplayFrame(sprTitle:displayFrame())
  end
  local spr = CCSprite:create(RANK_REWARD_PATH)
  if spr then
    self.sprLeftBtn:setDisplayFrame(spr:displayFrame())
  end
  spr = CCSprite:create(MY_RANK_PATH)
  if spr then
    self.sprRightBtn:setDisplayFrame(spr:displayFrame())
  end
  local list = Logic:Get("Pvp"):GetAllRankList()
  self.data = list
end
function prototype:loadMyRank()
  self.sprBg:setVisible(false)
  self.lstRank:setPositionY(RANK_POX_Y)
  self.ttfReward:setString("")
  local sprTitle = CCSprite:create(TITLE_RANK)
  if sprTitle then
    self.sprTitle:setDisplayFrame(sprTitle:displayFrame())
  end
  local spr = CCSprite:create(RANK_REWARD_PATH)
  if spr then
    self.sprLeftBtn:setDisplayFrame(spr:displayFrame())
  end
  spr = CCSprite:create(RANK_TOP_PATH)
  if spr then
    self.sprRightBtn:setDisplayFrame(spr:displayFrame())
  end
  local list = Logic:Get("Pvp"):GetMyRankList()
  self.data = list
end
function prototype:loadRankReward()
  self.sprBg:setVisible(true)
  self.lstRank:setPositionY(REWARD_POX_Y)
  self.ttfReward:setString(TwGetStr(105802))
  local sprTitle = CCSprite:create(TITLE_REWARD)
  if sprTitle then
    self.sprTitle:setDisplayFrame(sprTitle:displayFrame())
  end
  local spr = CCSprite:create(TITLE_REWARD_PATH)
  if spr then
    self.sprLeftBtn:setDisplayFrame(spr:displayFrame())
  end
  spr = CCSprite:create(RANK_PATH)
  if spr then
    self.sprRightBtn:setDisplayFrame(spr:displayFrame())
  end
  self.data = {}
  for i = 1, KFDBGetRecordAmt("RankRewardConfig") do
    local rec = KFDBGetRecordByIdx("RankRewardConfig", i)
    if rec then
      table.insert(self.data, rec)
    end
  end
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("PvpMain", self.rootNode)
end
function prototype:onBtnFeatsRank(sender, event)
  if self.rankType == Logic.Pvp.RANK_TYPE.ALL_RANK then
    Logic:Get("Pvp"):SetRankType(Logic.Pvp.RANK_TYPE.RANK_REWARD)
    self.rankType = Logic.Pvp.RANK_TYPE.RANK_REWARD
  elseif self.rankType == Logic.Pvp.RANK_TYPE.MY_RANK then
    Logic:Get("Pvp"):SetRankType(Logic.Pvp.RANK_TYPE.RANK_REWARD)
    self.rankType = Logic.Pvp.RANK_TYPE.RANK_REWARD
  elseif self.rankType == Logic.Pvp.RANK_TYPE.RANK_REWARD then
    SceneHelper:runWithScene("PvpTitle", self.rootNode)
    return
  end
  self:updateRankList()
end
function prototype:onBtnMyRank(sender, event)
  if self.rankType == Logic.Pvp.RANK_TYPE.ALL_RANK then
    local list = Logic:Get("Pvp"):GetMyRankList()
    if list == nil or table.empty(list) then
      Prompt:Fail(TwGetStr(105529))
      return
    end
    Logic:Get("Pvp"):SetRankType(Logic.Pvp.RANK_TYPE.MY_RANK)
    self.rankType = Logic.Pvp.RANK_TYPE.MY_RANK
  elseif self.rankType == Logic.Pvp.RANK_TYPE.MY_RANK then
    Logic:Get("Pvp"):SetRankType(Logic.Pvp.RANK_TYPE.ALL_RANK)
    self.rankType = Logic.Pvp.RANK_TYPE.ALL_RANK
  elseif self.rankType == Logic.Pvp.RANK_TYPE.RANK_REWARD then
    Logic:Get("Pvp"):SetRankType(Logic.Pvp.RANK_TYPE.ALL_RANK)
    self.rankType = Logic.Pvp.RANK_TYPE.ALL_RANK
  end
  self:updateRankList()
end
function prototype:cellSizeForTable(...)
  if self.rankType == Logic.Pvp.RANK_TYPE.RANK_REWARD then
    return CCSizeMake(563, 35)
  end
  return CCSizeMake(563, 120)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("PvpRankItem", self.rootNode)
    subScene:RefreshRewardInfo(self.data[index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):RefreshRewardInfo(self.data[index + 1])
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
function prototype:updateRankList()
  if self.rankType == Logic.Pvp.RANK_TYPE.ALL_RANK then
    self:loadAllRank()
  elseif self.rankType == Logic.Pvp.RANK_TYPE.MY_RANK then
    self:loadMyRank()
  elseif self.rankType == Logic.Pvp.RANK_TYPE.RANK_REWARD then
    self:loadRankReward()
  end
  self.tableViewControl:RequireUpdate()
end
