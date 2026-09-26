require("Events")
module((...), package.seeall)
local mgr = {}
function Get(self, name)
  name = "Logic." .. name
  local logic = mgr.logics[name]
  if logic ~= nil then
    assert(logic, "loop or previous error loading logic '%s'", name)
    return logic
  end
  mgr.logics[name] = false
  mgr.logics[name] = require(name).class:new()
  return mgr.logics[name]
end
function Reset(self)
  for k, v in pairs(mgr.logics) do
    mgr.logics[k] = nil
    if type(v) == "table" then
      v:dispose()
    end
  end
end
class = objectlua.Object:subclass()
class:include(Events.Tracer)
function class:initialize()
  super.initialize(self)
  Events.Tracer.initialize(self)
  self.eventSet = Events.EventSet:new()
end
function class:dispose()
  self.eventSet:dispose()
  Events.Tracer.dispose(self)
  super.dispose(self)
end
function class:On(type, event)
  self.eventSet:bind(event, type)
end
function class:Off(type, event)
  self.eventSet:unbind(event, type)
end
function class:FireEvent(type, ...)
  self.eventSet:fire(type, ...)
end
mgr.logics = {}
