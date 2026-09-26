require("Events")
module((...), package.seeall)
class = Events.EventHandle:subclass()
function class:initialize()
  self.events = {}
end
function class:dispose()
end
function class:unbind(event, data)
  for i, v in ipairs(self.events) do
    if v.event == event then
      table.remove(self.events, i)
      break
    end
  end
end
function class:Process()
  local clock = TimeGetTime()
  while self.events[1] and clock >= self.events[1].clock do
    local item = self.events[1]
    table.remove(self.events, 1)
    self:Queue(item)
    if item.times == 1 then
      item.event:unbind()
    end
    if item.times ~= 0 then
      item.times = item.times - 1
    end
    item.event:fire()
  end
end
function class:After(time, event)
  return self:Repeat(time, event, 1)
end
function class:Repeat(interval, event, times)
  local item = {
    event = event,
    interval = interval,
    times = times or 0
  }
  event:bind(self)
  self:Queue(item)
  return event
end
function class:Queue(item)
  item.clock = TimeGetTime() + item.interval
  local index = 1
  for i, v in ipairs(self.events) do
    if v.clock > item.clock then
      break
    end
    index = i + 1
  end
  table.insert(self.events, index, item)
end
instance = class:new()
