module((...), package.seeall)
class = objectlua.Object:subclass()
local DEFAULT_PARAMS = {
  fade = 2,
  minSeg = 50,
  stroke = 50,
  color = {
    255,
    255,
    0
  },
  path = "images/streak.png",
  blend = nil
}
function class:initialize(child, owner, params, sequence)
  super.initialize(self)
  params = params or {}
  self.params = {}
  self.params.fade = params.fade or DEFAULT_PARAMS.fade
  self.params.minSeg = params.minSeg or DEFAULT_PARAMS.minSeg
  self.params.stroke = params.stroke or DEFAULT_PARAMS.stroke
  self.params.color = params.color or DEFAULT_PARAMS.color
  self.params.path = params.path or DEFAULT_PARAMS.path
  self.params.blend = params.blend
  self.sequence = sequence
  self:Start(child, owner)
end
function class:Remove()
  if nil == self.motionStreakActions then
    return
  end
  CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(self.motionStreakActions.id)
  self:SetAliveTime(self.params.fade, self.motionStreakActions.streak, self.motionStreakActions.owner)
  self.motionStreakActions = nil
end
function class:Start(child, owner)
  if nil == child or nil == owner then
    return
  end
  local color = ccColor3B(unpack(self.params.color))
  local streak = CCMotionStreak:create(self.params.fade, self.params.minSeg, self.params.stroke, color, self.params.path)
  streak:setFastMode(true)
  if self.params.blend then
    local blendFunc = ccBlendFunc()
    blendFunc.src, blendFunc.dst = unpack(self.params.blend)
    streak:setBlendFunc(blendFunc)
  end
  owner:addChild(streak)
  local function cbk()
    local pos = child:convertToWorldSpaceAR(ccp(0, 0))
    streak:setPosition(pos)
  end
  local id = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(cbk, 0, false)
  self.motionStreakActions = {
    id = id,
    streak = streak,
    owner = owner
  }
  if self.sequence then
    streak:runAction(self.sequence)
  end
end
function class:SetAliveTime(time, streak, owner)
  local id
  local function cbk()
    owner:removeChild(streak, true)
    if nil ~= id then
      CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(id)
    end
  end
  id = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(cbk, time, false)
end
