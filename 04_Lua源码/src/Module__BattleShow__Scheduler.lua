module((...), package.seeall)
class = objectlua.Object:subclass()
function class:initialize()
  super.initialize(self)
  self:addScheduler()
end
function class:dispose()
  self:removeScheduler()
  super.dispose(self)
end
function class:addScheduler()
  local defaultScheduler = CCDirector:sharedDirector():getScheduler()
  local battleSched = CCScheduler:new()
  battleSched:retain()
  local actionManager = CCActionManager:new()
  battleSched:scheduleUpdateForTarget(actionManager, 0, false)
  self.actionManager = actionManager
  self.battleSched = battleSched
end
function class:removeScheduler()
  if self.battleSched ~= nil then
    self.battleSched:release()
    self.battleSched = nil
  end
end
function class:getScheduler()
  return self.battleSched
end
function class:setSpeed(value)
  self.battleSched:setTimeScale(value)
end
function class:setupActionMgr(node, notRecur)
  if node == nil then
    return
  end
  node:setActionManager(self.actionManager)
  if notRecur then
    return
  end
  local children = node:getChildren()
  if children ~= nil then
    for i = 1, children:count() do
      local child = children:objectAtIndex(i - 1)
      child = tolua.cast(child, "CCNode")
      self:setupActionMgr(child, notRecur)
    end
  end
end
