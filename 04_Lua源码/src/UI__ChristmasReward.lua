module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
ITEM_WIDTH = 246
function prototype:onEnter()
  super.onEnter(self)
  self:setTitleInfo()
  self.drawData = self:getDrawData()
  self:straHeroMove()
end
function prototype:getDrawData()
  local result = {cardLevel = "", cardID = ""}
  result.cardLevel = "[75, 75]"
  result.cardID = "[5507, 5507]"
  return result
end
function prototype:setTitleInfo()
  self.fiveRankTitle:setString(self:getStrForRankDescribe())
  self.fiveRankTitle:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
end
function prototype:getStrForRankDescribe()
  local resultStr = ""
  resultStr = KFDBGetRecord("LanguageSetting", 50001)
  if nil == resultStr then
    return ""
  end
  return resultStr.content
end
function prototype:onBtnBackCliecked(sender, event)
  SceneHelper:popScene()
end
function prototype:straHeroMove()
  local x = 0
  local y = 0
  if self.drawData.cardID == nil then
    return
  end
  local level = json.decode(self.drawData.cardLevel)
  local levelDouble = level
  for i = 1, #level do
    table.insert(levelDouble, level[i])
  end
  local baseId = json.decode(self.drawData.cardID)
  self.baseIdDouble = baseId
  for i = 1, #baseId do
    table.insert(self.baseIdDouble, baseId[i])
  end
  for i = 1, #self.baseIdDouble do
    local str = string.format("subScene%d", i)
    self[str] = Tw.Controller:load("LotteryMove", self.rootNode)
  end
  local container = CCNode:create()
  container:setContentSize(CCSizeMake(246 * #self.baseIdDouble / 2, 280))
  for i = 1, #self.baseIdDouble do
    local str = string.format("subScene%d", i)
    if self[str] then
      self[str]:setHero(self.baseIdDouble[i], levelDouble[i])
      self[str]:setPosition(ccp(x + i * ITEM_WIDTH, y))
      container:addChild(self[str])
    end
  end
  local scroll = CCScrollViewEx:create(CCSizeMake(246, 280))
  scroll:setDirection(kCCScrollViewDirectionHorizontal)
  scroll:setClippingToBounds(true)
  scroll:setTouchEnabled(false)
  scroll:setContainer(container)
  scroll:updateInset()
  self.scrollTag = scroll:getTag()
  self.lstCard:addChild(scroll)
  self.layer:setTouchEnabled(true)
  self.layer:registerScriptTouchHandler(bind(self.onTouch, self), false, 300, true)
  scroll:getContainer():setPositionX(scroll:getContentOffset().x - (#self.baseIdDouble / 2 + 1) * ITEM_WIDTH)
  self:moveItem()
end
function prototype:moveItem()
  local scroll = tolua.cast(self.lstCard:getChildByTag(self.scrollTag), "CCScrollViewEx")
  if scroll == nil then
    return
  end
  local container = scroll:getContainer()
  local arr1 = CCArray:create()
  arr1:addObject(CCCallFuncN:create(function()
    if scroll:getContentOffset().x <= -(#self.baseIdDouble - 1) * ITEM_WIDTH then
      container:setPositionX(-((#self.baseIdDouble / 2 - 1) * ITEM_WIDTH))
    else
      container:setPositionX(container:getPositionX() - 0.5)
    end
  end))
  container:runAction(CCRepeatForever:create(CCSequence:create(arr1)))
end
function prototype:onTouch(eventType, pos)
  if eventType == CCTOUCHBEGAN and self:isTouchInScoreView(pos) then
    self:onTouchBegined(pos)
  elseif eventType == CCTOUCHENDED then
    self:onTouchEnded(pos)
  end
end
function prototype:onTouchBegined(pos)
  local scroll = tolua.cast(self.lstCard:getChildByTag(self.scrollTag), "CCScrollViewEx")
  if scroll == nil then
    return
  end
  local container = scroll:getContainer()
  if self:isTouchInScoreView(pos) then
    self.startPos = pos
    container:stopAllActions()
  end
end
function prototype:onTouchEnded(pos)
  if not self:isTouchInScoreView(self.startPos) then
    return
  end
  self.timer = Logic:Get("System"):GetTime()
  if not self.eventTracer:Exist("runActionAgain") then
    Singleton(Timer):Repeat(1000, self:Event("runActionAgain"))
  end
  if math.abs(self.startPos[1] - pos[1]) <= 20 and 20 >= math.abs(self.startPos[2] - pos[2]) and self:isTouchInScoreView(pos) then
    self:clickHeroIcon(pos)
    self.startPos = nil
    return
  end
  local scroll = tolua.cast(self.lstCard:getChildByTag(self.scrollTag), "CCScrollViewEx")
  if scroll == nil then
    return
  end
  local container = scroll:getContainer()
  local currX = scroll:getContentOffset().x
  local scrollX = math.ceil(currX / ITEM_WIDTH) * ITEM_WIDTH
  local moveToX = 0
  local actionMoveTo
  if self.startPos[1] > pos[1] then
    moveToX = scrollX - ITEM_WIDTH
  elseif self.startPos[1] < pos[1] then
    moveToX = scrollX + ITEM_WIDTH
    if moveToX >= -ITEM_WIDTH then
      moveToX = -ITEM_WIDTH
    end
  end
  actionMoveTo = CCMoveTo:create(0.5, ccp(moveToX, scroll:getContentOffset().y))
  local arr1 = CCArray:create()
  arr1:addObject(actionMoveTo)
  if moveToX >= -ITEM_WIDTH then
    local function setPos()
      container:setPositionX(-((#self.baseIdDouble / 2 + 1) * ITEM_WIDTH))
    end
    arr1:addObject(CCCallFuncN:create(setPos))
  end
  if moveToX < -(#self.baseIdDouble - 1) * ITEM_WIDTH then
    local function setPos()
      container:setPositionX(-(#self.baseIdDouble / 2 * ITEM_WIDTH))
    end
    arr1:addObject(CCCallFuncN:create(setPos))
  end
  if arr1 then
    container:runAction(CCSequence:create(arr1))
  end
  self.startPos = nil
end
function prototype:runActionAgain()
  local currTime = Logic:Get("System"):GetTime()
  if Logic:Get("System"):DiffTime(currTime, self.timer) >= 2 then
    self:EventTracer():Cancel("runActionAgain")
    self:moveItem()
  end
end
function prototype:isTouchInScoreView(pos)
  if pos == nil or table.empty(pos) or pos[1] == nil or pos[2] == nil then
    return false
  end
  local x = self.lstCard:getPositionX()
  local y = self.lstCard:getPositionY()
  local width = self.lstCard:getContentSize().width
  local height = self.lstCard:getContentSize().height
  if x <= pos[1] and pos[1] <= x + width and y <= pos[2] and pos[2] <= y + height then
    return true
  end
  return false
end
function prototype:clickHeroIcon(pos)
  if pos == nil or table.empty(pos) then
    return
  end
  local scroll = tolua.cast(self.lstCard:getChildByTag(self.scrollTag), "CCScrollViewEx")
  if scroll == nil then
    return
  end
  local container = scroll:getContainer()
  for i = 1, #self.baseIdDouble do
    local str = string.format("subScene%d", i)
    if self[str] then
      local x = scroll:getContentOffset().x + self[str]:getPositionX()
      local width = self[str]:getContentSize().width
      if x <= pos[1] and pos[1] <= x + width then
        self[str]:onBtnHeroInfo()
        return
      end
    end
  end
end
