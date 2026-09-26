require("socket")
module((...), package.seeall)
listener = objectlua.Object:extend()
function listener:onReady()
end
function listener:onReceived(data)
  return 0
end
function listener:onClosed()
end
class = objectlua.Object:extend()
class:include(Events.Tracer)
function class:initialize(host, port, listener)
  super.initialize(self)
  Events.Tracer.initialize(self)
  local socket, err = self:connect(host, port)
  if socket == nil then
    log4msg:warn(err)
    return
  end
  self.ready = false
  self.socket = socket
  self.dataSend = ""
  self.dataRecv = ""
  self.listener = listener
  Singleton(Timer):Repeat(10, self:Event("TIMER_TICK", "tick"))
end
function class:dispose()
  self:cleanup()
  Events.Tracer.dispose(self)
  super.dispose(self)
end
function class:send(data)
  self.dataSend = self.dataSend .. data
end
function class:connect(host, port)
  local tcp, err = socket.tcp()
  if tcp == nil then
    return nil, err
  end
  tcp:settimeout(0)
  local _, err = tcp:connect(host, port)
  if err ~= "timeout" then
    return nil, err
  end
  return tcp
end
function class:cleanup()
  self:EventTracer():Cancel("TIMER_TICK")
  if self.socket ~= nil then
    self.socket:close()
    self.socket = nil
  end
  self.ready = false
  self.dataSend = ""
  self.dataRecv = ""
end
function class:tick()
  assert(self.socket ~= nil)
  local sockets = {
    self.socket
  }
  local recvt, sendt = socket.select(sockets, sockets, 0)
  if not self.ready then
    if sendt[self.socket] ~= nil then
      self.ready = true
      self.listener:onReady()
    end
    return
  end
  local closed = false
  if sendt[self.socket] ~= nil then
    closed = self:doSend() or closed
  end
  if recvt[self.socket] ~= nil then
    closed = self:doRecv() or closed
  end
  if closed then
    self:cleanup()
    self.listener:onClosed()
  end
end
function class:doSend()
  if #self.dataSend == 0 then
    return false
  end
  local all, err, partial = self.socket:send(self.dataSend)
  self.dataSend = string.sub(self.dataSend, (all or partial) + 1)
  return all == nil and err ~= "timeout"
end
function class:doRecv()
  local all, err, partial = self.socket:receive("*a")
  self.dataRecv = self.dataRecv .. (all or partial)
  local size = self.listener:onReceived(self.dataRecv)
  if size > 0 then
    self.dataRecv = string.sub(self.dataRecv, size + 1)
  end
  return all == nil and err ~= "timeout"
end
