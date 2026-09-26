module((...), package.seeall)
Event = objectlua.Object:subclass()
function Event:initialize(name, callback, tracer)
  self.name = name
  self.tracer = tracer
  self.callback = callback
end
function Event:dispose()
  if self.handle then
    self:unbind()
  end
end
function Event:bind(handle, data)
  self.handle = handle
  self.data = data
  self.tracer:bind(self)
end
function Event:unbind()
  self.tracer:unbind(self)
  self.handle:unbind(self, self.data)
end
function Event:fire(...)
  return false ~= self.callback(...)
end
function Event:GetName()
  return self.name
end
EventTracer = objectlua.Object:subclass()
function EventTracer:initialize()
  self.events = {}
end
function EventTracer:dispose()
  for k, v in pairs(self.events) do
    k:dispose()
  end
end
function EventTracer:bind(event)
  self.events[event] = event
end
function EventTracer:unbind(event)
  self.events[event] = nil
end
function EventTracer:Clear()
  for k, v in pairs(self.events) do
    k:unbind()
  end
end
function EventTracer:Exist(name)
  for k, v in pairs(self.events) do
    if k:GetName() == name then
      return true
    end
  end
  return false
end
function EventTracer:Cancel(name)
  for k, v in pairs(self.events) do
    if k:GetName() == name then
      return k:unbind()
    end
  end
end
EventHandle = objectlua.Object:subclass()
function EventHandle:initialize()
  assert(self.class ~= EventHandle)
end
function EventHandle:unbind(event, data)
  assert(false)
end
EventSet = EventHandle:subclass()
function EventSet:initialize()
  self.events = {}
end
function EventSet:dispose()
end
function EventSet:bind(event, data)
  if not self.events[data] then
    self.events[data] = event
  elseif getmetatable(self.events[data]) then
    local old = self.events[data]
    self.events[data] = {
      [old] = old,
      [event] = event
    }
  else
    self.events[data][event] = event
  end
  event:bind(self, data)
end
function EventSet:unbind(event, data)
  if self.events[data] == nil then
    return
  end
  if getmetatable(self.events[data]) then
    self.events[data] = nil
  elseif self.events[data][event] then
    self.events[data][event] = nil
    if table.empty(self.events[data]) then
      self.events[data] = nil
    end
  end
end
function EventSet:fire(data, ...)
  if not self.events[data] then
    return false
  end
  if getmetatable(self.events[data]) then
    return self.events[data]:fire(...)
  end
  local ret = false
  for k, v in pairs(table.clone(self.events[data])) do
    ret = v:fire(...) or ret
  end
  return ret
end
Tracer = objectlua.Mixin:new()
function Tracer:initialize()
  self.eventTracer = EventTracer:new()
end
function Tracer:dispose()
  self.eventTracer:dispose()
end
function Tracer:Event(name, callback)
  assert(name ~= nil)
  callback = callback or name
  assert(name == nil or type(name) == "string", debug.traceback())
  if name ~= nil and self.eventTracer:Exist(name) then
    Log(debug.traceback("Dumplicate event name!", 2))
    self.eventTracer:Cancel(name)
  end
  if type(callback) == "string" then
    assert(type(self[callback]) == "function")
    callback = bind(self[callback], self)
  end
  assert(type(callback) == "function", debug.traceback("Dumplicate event name!", 2))
  return Event:new(name, callback, self.eventTracer)
end
function Tracer:EventTracer()
  return self.eventTracer
end
