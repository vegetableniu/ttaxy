module((...), package.seeall)
local PROGRESS_BG = "images/public/progress1.png"
local PROGRESS_FRONT = "images/public/progress2.png"
local PROGRESS_THUMB = "images/public/progress_thumb.png"
local MOVIE_INTERVAL_TIME = 30
local DEFAULT_RUN_ONCE_TIME = 400
local MIN_VALUE = 0
local MAX_VALUE = 100
CALL_BACK_TYPE = Enum({
  "MOVE_FINISH",
  "PASS_END"
})
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
  self.slider = nil
  self.opacityAction = nil
  self.moveAction = nil
  self.moveCallBack = nil
  self.controller = {}
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:setMoveCallBack(callback)
  self.moveCallBack = callback
end
function prototype:getOpacity()
  if nil == self.slider then
    return 0
  end
  return self.slider:getOpacity()
end
function prototype:setOpacity(value, time)
  if nil == self.slider then
    return
  end
  if self.opacityAction then
    self:stopAction(self.opacityAction)
    self.opacityAction = nil
  end
  if nil == time or time <= 0 then
    self.slider:setOpacity(value)
    return
  end
  self.opacityAction = CCFadeTo:create(time / 1000, value)
  self:runAction(self.opacityAction)
end
function prototype:setValue(value, bHasMovie, upLevels, allTime)
  if nil == self.slider then
    return
  end
  if bHasMovie then
    if nil == allTime or allTime <= 0 then
      allTime = 0 or allTime
    end
    if nil == upLevels or upLevels <= 0 then
      upLevels = 0 or upLevels
    end
    local param = {upLevels = upLevels, allTime = allTime}
    self:playMove(value, param)
  else
    self:stopMove()
    self.slider:setValue(value)
  end
end
function prototype:getValue()
  return self.slider and self.slider:getValue() or 0
end
function prototype:setVisible(bVisible)
  if nil == self.slider then
    return
  end
  self.slider:setVisible(bVisible)
end
function prototype:isVisible()
  if nil == self.slider then
    return false
  end
  return self.slider:isVisible()
end
function prototype:setBackgroundSprite(img)
  if nil == self.slider or nil == img or "" == img then
    return false
  end
  self.slider:setBackgroundSprite(CCSprite:create(img))
end
function prototype:setProgressSprite(img)
  if nil == self.slider or nil == img or "" == img then
    return false
  end
  self.slider:setProgressSprite(CCSprite:create(img))
end
function prototype:setThumbSprite(img)
  if nil == self.slider or nil == img or "" == img then
    return false
  end
  self.slider:setThumbSprite(CCSprite:create(img))
end
function prototype:setBackgroundSpriteVisible(visible)
  if nil == self.slider then
    return false
  end
  visible = visible or false
  self.slider:setBackgroundSpriteVisible(visible)
end
function prototype:setProgressSpriteVisible(visible)
  if nil == self.slider then
    return false
  end
  visible = visible or false
  self.slider:setProgressSpriteVisible(visible)
end
function prototype:setThumbSpriteVisible(visible)
  if nil == self.slider then
    return false
  end
  visible = visible or false
  self.slider:setThumbSpriteVisible(visible)
end
function prototype:createProgress(bg, front, node)
  node = node or self.rootNode
  local slider = CCControlSlider:create(bg or PROGRESS_BG, front or PROGRESS_FRONT, PROGRESS_THUMB)
  local nodePos = node:getPositionLua()
  local nodeSize = node:getContentSize()
  local proPos = slider:getPositionLua()
  local proSize = slider:getContentSize()
  local scaleW = nodeSize.width / proSize.width
  local scaleH = nodeSize.height / proSize.height
  slider:setScaleX(scaleW)
  slider:setScaleY(scaleH)
  slider:setContentSize(nodeSize)
  slider:setAnchorPoint(CCPoint(0, 0))
  slider:ignoreAnchorPointForPosition(true)
  slider:setPosition(CCPoint(0, 0))
  slider:setMinimumValue(MIN_VALUE)
  slider:setMaximumValue(MAX_VALUE)
  slider:setValue(0)
  slider:setEnabled(false)
  slider:setOpacity(255)
  self.slider = slider
  node:addChild(slider)
end
function prototype:runAction(action)
  if nil == action or self.slider == nil then
    return
  end
  self.slider:runAction(action)
end
function prototype:stopAction(action)
  if nil == action or self.slider == nil then
    return
  end
  self.slider:stopAction(action)
end
function prototype:playMove(value, param)
  if self.moveAction then
    self:stopMove()
  end
  self:parseMoveData(value, param)
  local arrAction = CCArray:create()
  arrAction:addObject(CCDelayTime:create(MOVIE_INTERVAL_TIME / 1000))
  arrAction:addObject(CCCallFuncN:create(function()
    self:processMove()
  end))
  local seq = CCSequence:create(arrAction)
  self.moveAction = CCRepeatForever:create(seq)
  self:runAction(self.moveAction)
end
function prototype:stopMove()
  if self.moveCallBack and self.moveAction then
    self.moveCallBack(self, CALL_BACK_TYPE.MOVE_FINISH)
  end
  self.controller = {}
  if self.moveAction then
    self:stopAction(self.moveAction)
    self.moveAction = nil
  end
end
function prototype:parseMoveData(tgtValue, param)
  local MIN_VALUE_PER_TIME_SPLIT = 0.3
  local MIN_LEVEL_SPLIT = 3
  local SPLIT_TIME_2 = 300
  local SPLIT_LEVELS_2 = 2
  local function SplitData(startValue, tgtValue, upLevels, allTime, allValue)
    local data1 = {}
    local data2 = {}
    if allValue / allTime < MIN_VALUE_PER_TIME_SPLIT or upLevels < MIN_LEVEL_SPLIT then
      data1.startValue = startValue
      data1.tgtValue = tgtValue
      data1.allValue = allValue
      data1.allTime = allTime
      data1.upLevels = upLevels
      data1.tgtValue = tgtValue
      data1.bFakeShow = false
      return data1, data2
    end
    local value2 = MAX_VALUE + tgtValue
    local time2 = SPLIT_TIME_2
    local upLevels2 = SPLIT_LEVELS_2
    local value1 = MAX_VALUE - startValue + (upLevels - upLevels2 - 1) * MAX_VALUE
    local time1 = allTime - time2
    local upLevels1 = upLevels - upLevels2
    data1.startValue = startValue
    data1.tgtValue = math.fmod(startValue + value1, MAX_VALUE)
    data1.allValue = value1
    data1.allTime = time1
    data1.upLevels = upLevels1
    data1.bFakeShow = true
    data2.startValue = data1.tgtValue
    data2.tgtValue = tgtValue
    data2.allValue = value2
    data2.allTime = time2
    data2.upLevels = upLevels2
    data2.bFakeShow = false
    return data1, data2
  end
  local startValue = self:getValue()
  local upLevels = param.upLevels or 0
  if upLevels == 0 and tgtValue < startValue then
    upLevels = 1
  end
  local allValue = MAX_VALUE - startValue + (upLevels - 1) * MAX_VALUE + tgtValue
  local allTime = param.allTime or allValue / MAX_VALUE * DEFAULT_RUN_ONCE_TIME
  local data1, data2 = SplitData(startValue, tgtValue, upLevels, allTime, allValue)
  table.insert(self.controller, {
    data = data1,
    stage = self:makeStage(data1)
  })
  if nil ~= data2 and not table.empty(data2) then
    table.insert(self.controller, {data = data2})
  end
end
function prototype:makeStage(stageData)
  local stage = {}
  local dataProcess = {}
  dataProcess.passedValue = 0
  dataProcess.upLevelTimes = 0
  dataProcess.stepValue = stageData.allValue / (stageData.allTime / MOVIE_INTERVAL_TIME)
  stage.dataProcess = dataProcess
  local FAKE_STEP = 13
  local showProcess = {}
  showProcess.curValue = self:getValue()
  if stageData.bFakeShow then
    showProcess.stepValue = math.min(FAKE_STEP, dataProcess.stepValue)
  else
    local stepValue = (stageData.allValue + stageData.startValue - self:getValue()) / (stageData.allTime / MOVIE_INTERVAL_TIME)
    showProcess.stepValue = stepValue
  end
  stage.showProcess = showProcess
  return stage
end
function prototype:processMove()
  if nil == self.controller or table.empty(self.controller) then
    self:stopMove()
    return
  end
  if not self:processData(self.controller[1]) then
    return
  end
  self:processShow(self.controller[1])
end
function prototype:stageEnd(tgtValue)
  if nil == self.controller or #self.controller <= 1 then
    self.slider:setValue(tgtValue)
    self:stopMove()
    return
  end
  if self.moveCallBack then
    self.moveCallBack(self, CALL_BACK_TYPE.PASS_END)
  end
  table.remove(self.controller, 1)
end
function prototype:processData(stageInfo)
  if nil == stageInfo or nil == stageInfo.data then
    return false
  end
  if nil == stageInfo.stage then
    stageInfo.stage = self:makeStage(stageInfo.data)
  end
  local origionData = stageInfo.data
  local dataProcess = stageInfo.stage.dataProcess
  local upLevelTimes = dataProcess.upLevelTimes
  local passedValue = dataProcess.passedValue
  if passedValue >= origionData.allValue then
    self:stageEnd(origionData.tgtValue)
    return false
  end
  passedValue = passedValue + dataProcess.stepValue
  if passedValue >= origionData.allValue then
    passedValue = origionData.allValue
  end
  local newUpLevel = math.modf((origionData.startValue + passedValue) / MAX_VALUE)
  if self.moveCallBack and upLevelTimes < newUpLevel then
    for i = 1, newUpLevel - upLevelTimes do
      self.moveCallBack(self, CALL_BACK_TYPE.PASS_END)
    end
  end
  dataProcess.passedValue = passedValue
  dataProcess.upLevelTimes = newUpLevel
  return true
end
function prototype:processShow(stageInfo)
  if nil == stageInfo or nil == stageInfo.data or nil == stageInfo.stage then
    return
  end
  local showProcess = stageInfo.stage.showProcess
  if nil == showProcess then
    return
  end
  local origionData = stageInfo.data
  local dataProcess = stageInfo.stage.dataProcess
  if nil == dataProcess then
    return
  end
  local bLastTime = #self.controller == 1 and dataProcess.upLevelTimes >= origionData.upLevels
  local nextValue = math.fmod(showProcess.curValue + showProcess.stepValue, MAX_VALUE)
  if bLastTime and nextValue >= origionData.tgtValue then
    nextValue = origionData.tgtValue
  end
  self.slider:setValue(nextValue)
  showProcess.curValue = nextValue
end
function prototype:stopAllActions()
  self.slider:stopAllActions()
end
