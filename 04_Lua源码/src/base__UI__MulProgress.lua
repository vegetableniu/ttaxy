module((...), package.seeall)
require("Progress")
local CLARITY_IMG = "images/public/clarity80.png"
local PROGRESS_BG = "images/public/progress_bg.png"
local PROGRESS_FIRST = "images/public/progress_ft.png"
local PROGRESS_SECOND = "images/public/progress_ft2.png"
local DEFAULT_INTERVAL_TIME = 500
local DEFAULT_FULLWAIT_TIME = 200
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
  self.twinkleAction = {}
end
function prototype:dispose(...)
  if self.bgSlider then
    self.bgSlider:dispose()
  end
  if self.firstSlider then
    self.firstSlider:dispose()
  end
  if self.secondSlider then
    self.secondSlider:dispose()
  end
  super.dispose(self)
end
function prototype:onEnter()
end
function prototype:createProgress(bg, front1, front2)
  self.bgSlider = Progress.prototype:new()
  self.firstSlider = Progress.prototype:new()
  self.secondSlider = Progress.prototype:new()
  bg = bg or PROGRESS_BG
  self.bgSlider:createProgress(bg, CLARITY_IMG, self.rootNode)
  self.secondSlider:createProgress(bg, front2 or PROGRESS_SECOND, self.rootNode)
  self.firstSlider:createProgress(bg, front1 or PROGRESS_FIRST, self.rootNode)
  self.secondSlider:setBackgroundSpriteVisible(false)
  self.firstSlider:setBackgroundSpriteVisible(false)
  self.secondSlider:setVisible(false)
end
function prototype:setMoveCallBack(callback, bSecond, ...)
  local slider = bSecond and self.secondSlider or self.firstSlider
  if nil == slider then
    return
  end
  slider:setMoveCallBack(callback, ...)
end
function prototype:twinkleProgress(bSecond, interTime, fullWaitTime, allTime)
  self:stopTwinkle()
  local slider = bSecond and self.secondSlider or self.firstSlider
  if nil == slider then
    return
  end
  if self.twinkleAction[slider] then
    slider:stopAction(self.twinkleAction[slider])
    self.twinkleAction[slider] = nil
  end
  interTime = interTime or DEFAULT_INTERVAL_TIME
  fullWaitTime = fullWaitTime or DEFAULT_FULLWAIT_TIME
  local opacity = slider:getOpacity()
  local visible = slider:isVisible()
  slider:setVisible(true)
  slider:setOpacity(255)
  local arrAction = CCArray:create()
  arrAction:addObject(CCCallFuncN:create(function()
    slider:setOpacity(0, interTime)
  end))
  arrAction:addObject(CCDelayTime:create(interTime / 1000))
  arrAction:addObject(CCCallFuncN:create(function()
    slider:setOpacity(255, interTime)
  end))
  arrAction:addObject(CCDelayTime:create(interTime / 1000))
  arrAction:addObject(CCDelayTime:create(fullWaitTime / 1000))
  local seq = CCSequence:create(arrAction)
  local twinkleAction = CCRepeatForever:create(seq)
  slider:runAction(twinkleAction)
  local allAction = {twinkleAction}
  if allTime then
    local arrAction2 = CCArray:create()
    arrAction2:addObject(CCDelayTime:create(allTime / 1000))
    arrAction2:addObject(CCCallFuncN:create(function()
      slider:setOpacity(opacity)
      slider:setVisible(visible)
      self:stopTwinkle()
    end))
    local actionEnd = CCSequence:create(arrAction2)
    slider:runAction(actionEnd)
    allAction = {twinkleAction, actionEnd}
  end
  self.twinkleAction[slider] = allAction
end
function prototype:stopTwinkle()
  for slider, actions in pairs(self.twinkleAction) do
    for _, action in ipairs(actions) do
      slider:stopAction(action)
    end
  end
  self.twinkleAction = {}
end
function prototype:setOpacity(value, time, bSecond)
  value = value or 0
  if nil == bSecond then
    if self.bgSlider then
      self.bgSlider:setOpacity(value, time)
    end
    if self.firstSlider then
      self.firstSlider:setOpacity(value, time)
    end
    if self.secondSlider then
      self.secondSlider:setOpacity(value, time)
    end
    return
  end
  local slider = bSecond and self.secondSlider or self.firstSlider
  if nil == slider then
    return
  end
  slider:setOpacity(value, time)
end
function prototype:setValue(value, bSecond, bHasMovie, upLevels, allTime)
  local slider = bSecond and self.secondSlider or self.firstSlider
  if nil == slider then
    return
  end
  slider:setValue(value, bHasMovie, upLevels, allTime)
end
function prototype:getValue(bSecond)
  local slider = bSecond and self.secondSlider or self.firstSlider
  if nil == slider then
    return 0
  end
  return slider:getValue()
end
function prototype:setVisible(bVisible, bSecond)
  if nil == bSecond then
    if self.bgSlider then
      self.bgSlider:setVisible(bVisible)
    end
    if self.firstSlider then
      self.firstSlider:setVisible(bVisible)
    end
    if self.secondSlider then
      self.secondSlider:setVisible(bVisible)
    end
    return
  end
  local slider = bSecond and self.secondSlider or self.firstSlider
  if nil == slider then
    return
  end
  slider:setVisible(bVisible)
end
function prototype:isVisible(bSecond)
  local slider = bSecond and self.secondSlider or self.firstSlider
  if nil == slider then
    return
  end
  return slider:isVisible()
end
function prototype:runAction(bSecond, action)
  local slider = bSecond and self.secondSlider or self.firstSlider
  if nil == slider then
    return
  end
  return slider:runAction(action)
end
function prototype:stopAllActions(bSecond)
  local slider = bSecond and self.secondSlider or self.firstSlider
  if nil == slider then
    return
  end
  return slider:stopAllActions()
end
