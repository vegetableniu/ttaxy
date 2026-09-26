module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local ITEM_WIDTH = 601
local ITEM_HEIGHT = 570
local PATH = "images/Devil/ExchangeSmall.png"
local RANK_PATH = "images/Devil/rankingSmall.png"
local TITLE_PATH = {
  NORMAL = "images/Devil/devilInvade.png",
  EPIC = "images/Devil/epicDevilInvade.png"
}
function prototype:initialize(...)
  super.initialize(self, ...)
  self.tabPosY = {}
  self.subScene4 = nil
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  Logic:Get("Devil"):On(Logic.Devil.EVT.PAGE_CHANGE, self:Event("onPageChange"))
  self.subScene1 = Tw.Controller:load("DevilRewardCard", self.rootNode)
  self.subScene2 = Tw.Controller:load("DevilHarmReward", self.rootNode)
  self.subScene3 = Tw.Controller:load("DevilFeatsReward", self.rootNode)
  local spr
  if Logic:Get("Devil"):checkNewDemogAct() then
    spr = CCSprite:create(TITLE_PATH.EPIC)
    self:loadMainRankItem()
  else
    spr = CCSprite:create(TITLE_PATH.NORMAL)
    self:loadMainItem()
  end
  if spr then
    self.sprTitle:setDisplayFrame(spr:displayFrame())
  end
  local x = self.subScene4:getPositionX()
  local y = self.subScene4:getPositionY()
  local container = CCNode:create()
  container:setContentSize(CCSizeMake(ITEM_WIDTH, ITEM_HEIGHT))
  for i = 1, 4 do
    local str = string.format("subScene%d", i)
    if self[str] then
      table.insert(self.tabPosY, -(y + (i - 1) * ITEM_HEIGHT))
      self[str]:setPosition(ccp(x, y + (i - 1) * ITEM_HEIGHT))
      container:addChild(self[str])
    end
  end
  local sort = function(a, b)
    return a < b
  end
  table.sort(self.tabPosY, sort)
  local scroll = CCScrollViewEx:create(CCSizeMake(620, 565))
  scroll:setDirection(kCCScrollViewDirectionVertical)
  scroll:setClippingToBounds(true)
  scroll:setTouchEnabled(false)
  scroll:setContainer(container)
  scroll:updateInset()
  self.scrollTag = scroll:getTag()
  self.myNode:addChild(scroll)
  scroll:getContainer():setPositionY(scroll:getContentOffset().y - 3 * ITEM_HEIGHT)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:moveItem(page)
  if page == nil then
    return
  end
  if page <= 0 then
    page = 1
  end
  if page > #self.tabPosY then
    page = #self.tabPosY
  end
  local scroll = tolua.cast(self.myNode:getChildByTag(self.scrollTag), "CCScrollViewEx")
  if scroll == nil then
    return
  end
  local container = scroll:getContainer()
  container:runAction(CCMoveTo:create(0.5, ccp(scroll:getContentOffset().x, self.tabPosY[page])))
end
function prototype:loadMainRankItem()
  self.subScene4 = Tw.Controller:load("DevilMainEpicItem", self.rootNode)
end
function prototype:loadMainItem()
  self.subScene4 = Tw.Controller:load("DevilMainItem", self.rootNode)
end
function prototype:onBtnReturnClicked(sender, event)
  SceneHelper:runWithScene("Home", self.rootNode)
end
function prototype:onBtnRankClicked(sender, event)
  local curTime = os.time()
  local lastTime = Logic:Get("Devil"):getRequestFeatsRankTime()
  if curTime - lastTime > 60 then
    MsgDemog:Post("FEAT_RANK")
  end
  Logic:Get("Devil"):setIsRankTop(false)
  SceneHelper:runWithScene("DevilFeatsRank", self.rootNode)
end
function prototype:onPageChange(Page)
  self:moveItem(Page)
end
