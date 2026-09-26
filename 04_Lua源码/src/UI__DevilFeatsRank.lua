module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local IMG_MYRANK_PATH = "images/Devil/myRanking.png"
local IMG_RANKT_PATH = "images/Devil/rankTop.png"
local MAX_RANK_PER_PAGE = 5
function prototype:initialize()
  super.initialize(self)
  self.page = 1
  self.rankTop = {}
  self.myRank = {}
  self.rankData = {}
end
function prototype:onEnter()
  super.onEnter(self)
  Logic:Get("Devil"):On(Logic.Devil.EVT.GET_FEATS_RANK, self:Event("RefreshFeatsRank"))
  if not self.eventTracer:Exist("onShowHeroGroup") then
    Logic:Get("Devil"):On(Logic.Devil.EVT.GET_RANK_GROUP_INFO, self:Event("onShowHeroGroup"))
  end
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstRank, self.page)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.lstRank:addChild(self.tableViewControl.tableView)
  self:RefreshFeatsRank()
end
function prototype:RefreshFeatsRank()
  self.rankTop = Logic:Get("Devil"):GetFeatsRankTop()
  self.myRank = Logic:Get("Devil"):GetFeatsRankMyRank()
  local isRankTop = Logic:Get("Devil"):getIsRankTop()
  if self.myRank ~= nil and next(self.myRank) ~= nil and not isRankTop then
    self.rankData = self.myRank
    self:setRankTopImage()
    self.tableViewControl:RequireUpdate()
  elseif self.rankTop ~= nil and next(self.rankTop) ~= nil then
    self.rankData = self.rankTop
    Logic:Get("Devil"):setIsRankTop(true)
    self:setMyRankImage()
    self.tableViewControl:RequireUpdate()
  else
    self:setRankTopImage()
  end
end
function prototype:setRankTopImage()
  local spriteIcon = CCSprite:create(IMG_RANKT_PATH)
  if spriteIcon then
    self.ImageIcon:setDisplayFrame(spriteIcon:displayFrame())
  end
end
function prototype:setMyRankImage()
  local spriteIcon = CCSprite:create(IMG_MYRANK_PATH)
  if spriteIcon then
    self.ImageIcon:setDisplayFrame(spriteIcon:displayFrame())
  end
end
function prototype:onShowHeroGroup()
  SceneHelper:pushScene("DevilHeroGroupView", self.rootNode)
end
function prototype:onBtnReturn()
  SceneHelper:runWithScene("DevilMain", self.rootNode)
end
function prototype:onBtnHarmRank()
  local curTime = os.time()
  local lastTime = Logic:Get("Devil"):getRequestDamageRankTime()
  if curTime - lastTime > 60 then
    MsgDemog:Post("MAX_DAMAGE_RANK")
  end
  Logic:Get("Devil"):setIsRankTop(false)
  SceneHelper:runWithScene("DevilHarmRank", self.rootNode)
end
function prototype:onBtnMyRank()
  if self.myRank ~= nil and next(self.myRank) ~= nil then
    local isRankTop = Logic:Get("Devil"):getIsRankTop()
    if not isRankTop then
      self.rankData = self.rankTop
      Logic:Get("Devil"):setIsRankTop(true)
      self:setMyRankImage()
      self.tableViewControl:RequireUpdate()
    else
      self.rankData = self.myRank
      Logic:Get("Devil"):setIsRankTop(false)
      self:setRankTopImage()
      self.tableViewControl:RequireUpdate()
    end
  elseif self.rankTop ~= nil and next(self.rankTop) ~= nil then
    Prompt:Tip(TwGetStr(105529))
  end
end
function prototype:onBtnPrimExchange()
  Logic:Get("Devil"):setRankType(Logic.Devil.RANK_TYPE.FEATSRANK)
  SceneHelper:runWithScene("DevilPrimordialExchange", self.rootNode)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 117)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("DevilRankItem", self.rootNode)
    subScene.pRankItem:RefreshRank(self.rankData[(curPage - 1) * MAX_RANK_PER_PAGE + index + 1], Logic.Devil.RANK_TYPE.FEATSRANK)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2).pRankItem:RefreshRank(self.rankData[(curPage - 1) * MAX_RANK_PER_PAGE + index + 1], Logic.Devil.RANK_TYPE.FEATSRANK)
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
