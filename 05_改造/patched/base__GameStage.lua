require("Events")
require("Render")
module((...), package.seeall)
class = objectlua.Object:subclass()
class:include(Events.Tracer)
function class:initialize(...)
  super.initialize(self)
  Events.Tracer.initialize(self)
  self.eventSet = Events.EventSet:new()
end
function class:On(type, event)
  self.eventSet:bind(event, type)
end
function class:FireEvent(type, ...)
  self.eventSet:fire(type, ...)
end
function class:dispose()
  self.eventSet:dispose()
  Events.Tracer.dispose(self)
  super.dispose(self)
end
function class:OnStageActive()
  assert(false)
end
function class:OnStageClose()
  assert(false)
end
function class:OnOperateEvent(type, x, y)
  return false
end
function class:ChangeGameViewSize(type, x, y)
end
function class:OnStageRenderLayer()
end
local mgr = objectlua.Object:subclass()
function mgr:initialize(...)
  self:Setup("Null")
end
function mgr:finalize()
end
function mgr:ChgStage(type, ...)
  log4misc:warn("[PATCH] ChgStage -> " .. tostring(type))
  if self:IsStage(type) then
    return
  end
  self:Teardown()
  self:Setup(type, ...)
end
function mgr:IsStage(type)
  return self.type == type
end
function mgr:GetStage()
  return self.stage
end
function mgr:OnOperateEvent(type, x, y)
  return self.stage:OnOperateEvent(type, x, y)
end
function mgr:ChangeGameViewSize(w, h)
  return self.stage:ChangeGameViewSize(w, h)
end
function mgr:GetType()
  return self.type
end
function mgr:Setup(type, ...)
  self.type = type
  self.stage = require("GameStage" .. self.type).class:new(...)
  self.stage:OnStageActive()
  self.stage:OnStageRenderLayer()
end
function mgr:Teardown()
  self.stage:OnStageClose()
  self.stage:dispose()
  self.stage = nil
  self.type = nil
end
instance = mgr:new()
