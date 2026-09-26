module((...), package.seeall)
local Scheduler = require("BattleShow.Scheduler")
local Define = require("BattleShow.BattleDefine")
class = objectlua.Object:subclass()
function class:initialize()
  self.defaultSched = CCDirector:sharedDirector():getScheduler()
  self.actionSched = Scheduler.class:new()
  self.effectSched = Scheduler.class:new()
  self.defaultSched:scheduleUpdateForTarget(self.actionSched:getScheduler(), 0, false)
  self.defaultSched:scheduleUpdateForTarget(self.effectSched:getScheduler(), 0, false)
end
function class:dispose()
  super.dispose(self)
  self.actionSched:dispose()
  self.effectSched:dispose()
end
function class:setSpeed(type, value)
  if type == Define.SCHED.ACTION then
    self.actionSched:setSpeed(value)
  end
  if type == Define.SCHED.EFFECT then
    self.effectSched:setSpeed(value)
  end
end
function class:setupActionMgr(type, node, notRecur)
  if type == Define.SCHED.ACTION then
    self.actionSched:setupActionMgr(node, notRecur)
  end
  if type == Define.SCHED.EFFECT then
    self.effectSched:setupActionMgr(node, notRecur)
  end
end
