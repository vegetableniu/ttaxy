require("Events")
module((...), package.seeall)
Listener = objectlua.Object:subclass()
function Listener:Block(block)
end
local class = objectlua.Object:subclass()
class:include(Events.Tracer)
function class:initialize()
  super.initialize(self)
  Events.Tracer.initialize(self)
  self.eventSet = Events.EventSet:new()
  self.listener = Listener:new()
end
function class:dispose()
  self.eventSet:dispose()
  Events.Tracer.dispose(self)
  super.dispose(self)
end
function class:setListener(listener)
  self.listener = listener
end
function class:Send(data, block)
  if nil == data then
    return
  end
  if block ~= false then
    assert(self.sending == nil)
    self.sending = data.uReqId
    self.listener:Block(true)
  end
  return ITwHttp:GetInstance():SendRequest(data)
end
function class:On(reqId, event)
  self.eventSet:bind(event, reqId)
end
function class:OnRespose(reqId, data)
  return self:OnRecv(reqId, 0, data)
end
function class:OnError(reqId, code)
  local code = code ~= 0 and code or -1
  return self:OnRecv(reqId, code, nil)
end
function class:OnRecv(reqId, code, data)
  if self.sending == reqId then
    self.sending = nil
    self.listener:Block(false)
  end
  return self.eventSet:fire(reqId, code, data)
end
instance = class:new()
