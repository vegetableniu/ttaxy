require("Timer")
module((...), package.seeall)
local Define = require("BattleShow.BattleDefine")
local OutPutN = require("BattleShow.OutPut.Normal")
local OutPutS = require("BattleShow.OutPut.Simple")
local OutPutC = require("BattleShow.OutPut.Combs")
class = objectlua.Object:subclass()
class:include(Events.Tracer)
local INTERVAL = 0.05
local NORMAL = 20
local COMBS = 4
function class:initialize(target)
  super.initialize(self)
  Events.Tracer.initialize(self)
  self.target = target
  self.rootNode = target.rootNode
  self.formation = {}
  self.state = "EMPTY"
end
function class:dispose()
  Singleton(Timer):unbind(self.process)
  if self:EventTracer():Exist("OUT_PUT_EVENT") then
    self:EventTracer():Cancel("OUT_PUT_EVENT")
  end
  Events.Tracer.dispose(self)
  super.dispose(self)
end
function class:export(hp, status, pType, combs)
  local msg = {
    hp = hp,
    status = status,
    pType = pType,
    combs = combs
  }
  table.insert(self.formation, msg)
  if self.state == "EMPTY" then
    self.state = "START"
    self:thread()
  end
end
function class:thread()
  self.count = 0
  if self:EventTracer():Exist("OUT_PUT_EVENT") then
    self:EventTracer():Cancel("OUT_PUT_EVENT")
  end
  self.process = Singleton(Timer):Repeat(INTERVAL * 1000, self:Event("OUT_PUT_EVENT", "output"))
end
function class:output()
  local msg = self.formation[1]
  local bCombs = type(msg.combs) == "table" and msg.combs.bCombs == true
  local interval = bCombs and COMBS or NORMAL
  local scaleInterval = math.ceil(interval / self:getSpeed())
  self.count = self.count + 1
  if math.fmod(self.count, scaleInterval) ~= 1 then
    return
  end
  local param = bCombs and msg.combs.times or nil
  self:dispatch(msg.hp, msg.status, msg.pType, param)
  table.remove(self.formation, 1)
  if table.empty(self.formation) then
    Singleton(Timer):unbind(self.process)
    self.process = nil
    self.state = "EMPTY"
  end
end
function class:dispatch(hp, status, pType, count)
  if status == nil then
    local errorMsg = hp == nil and pType == nil and "msg info empty!!" or "status is nil !!"
    log4battle:warn(errorMsg)
    status = Define.CStatus:new(0)
  end
  if type(count) == "number" then
    if count < 0 then
      count = 0 or count
    end
    OutPutC.class:new(hp, self.rootNode, status, count)
  elseif pType ~= nil then
    self:display(hp, status, pType)
  else
    OutPutN.class:new(hp, self.rootNode, status)
  end
end
function class:getSpeed()
  local scheduler = CCDirector:sharedDirector():getScheduler()
  return scheduler:getTimeScale()
end
function class:display(hp, status, pType)
  local function NormalPutOut()
    OutPutN.class:new(hp, self.rootNode, status)
  end
  local info = KFDBGetRecord("PassiveConduct", pType)
  if not info then
    NormalPutOut()
    return
  end
  if info.path == nil or info.path == "" then
    NormalPutOut()
    return
  end
  if info.style == "Battle" then
    NormalPutOut()
    return
  end
  if info.style == "OutPut" then
    OutPutS.class:new(hp, self.rootNode, info.path, status)
  end
  if info.style == "Effect" then
    local ani = CCBAni.class:new(info.path, self.rootNode, nil, LAYER_LEVEL.EFF)
    ani:RunAnimationAutoRemove()
    NormalPutOut()
  end
end
