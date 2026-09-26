require("Timer")
require("GameStage")
module((...), package.seeall)
class = objectlua.Object:subclass()
function class:initialize(...)
  super.initialize(self)
end
function class:dispose()
  super.dispose(self)
end
function class:OnStartup()
end
function class:OnShutdown()
end
function class:OnTick()
end
function class:OnOperateEvent(type, x, y)
  return false
end
function class:getMemCap()
  return nil
end
function class:ChangeGameViewSize(w, h)
end
local root = objectlua.Object:subclass()
root:include(Events.Tracer)
function root:initialize(...)
  super.initialize(self)
  Events.Tracer.initialize(self)
  self.shell = require("GameShell").class:new()
end
function root:dispose()
  Singleton(GameStage):finalize()
  self.shell:dispose()
  self.shell = nil
  Logic:Reset()
  Singleton(NetMsg):dispose()
  Singleton(NetMgr):dispose()
  Events.Tracer.dispose(self)
  super.dispose(self)
end
function root:OnSysStartup()
  self.shell:OnStartup()
  if CTwUtil:GetPlatform() ~= CTwUtil.E_TP_MAC then
    Singleton(Timer):Repeat(30000, self:Event("CheckMemory"))
  end
end
function root:OnSysShutdown()
  self.shell:OnShutdown()
end
function root:OnTick()
  Singleton(Timer):Process()
  self.shell:OnTick()
end
function root:OnOperateEvent(type, x, y)
  if Singleton(GameStage):OnOperateEvent(type, x, y) then
    return true
  end
  return self.shell:OnOperateEvent(type, x, y)
end
function root:OnMemoryLow()
  local tick = TimeGetTime()
  collectgarbage()
  collectgarbage()
  collectgarbage()
  CCDirector:sharedDirector():purgeCachedData()
end
function root:CheckMemory()
  local isBattleShow = self.shell:isBattleShow()
  if isBattleShow then
    return
  end
  local memInfo = CTwUtil:GetSingleton():GetCurrentMem()
  if memInfo.uMemAvailble < 33554432 then
    return self:OnMemoryLow()
  end
  if 262144000 < memInfo.uMemUsed then
    return self:OnMemoryLow()
  end
  return
end
function root:ChangeGameViewSize(w, h)
  Singleton(GameStage):ChangeGameViewSize(w, h)
  self.shell:ChangeGameViewSize(w, h)
end
function root:CheckOperate()
  self.shell:CheckOperate()
end
instance = root:new()
