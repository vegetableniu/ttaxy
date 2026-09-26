local RoleView = require("Scene.RoleView")
module((...), package.seeall)
local internal
class = objectlua.Object:subclass()
function class:initialize(mgr, data, view)
  super.initialize(self)
  self.mgr = mgr
  self.data = data
  self.view = view
  self.fStand = nil
  self.moveSpeed = 0.3
end
function class:dispose()
  super.dispose(self)
end
function class:GetView()
  return self.view
end
function class:Dir(dir)
  return self.mgr:Call(function()
    self.view:SetDir(dir)
  end)
end
function class:Exec(action)
  self.mgr:Exec(self, action)
end
function class:Clear(action)
  self.mgr:Clear(self, action)
end
function class:FStand()
  if self.fStand ~= nil then
    self.mgr:Clear(self, self.fStand)
    self.fStand = nil
  end
  self.fStand = self.mgr:Repeat(self:ActionImpl(RoleView.ACTION.FSTAND))
  self:Exec(self.fStand)
end
function class:Action(action)
  if nil ~= self.fStand then
    local clear = self.mgr:Do(function()
      self.mgr:Clear(self, self.fStand)
      self.fStand = nil
    end)
    return self.mgr:Seq(clear, self:ActionImpl(action))
  end
  return self:ActionImpl(action)
end
function class:ActionImpl(action)
  local exec = self.mgr:Call(function()
    self.view:SetAction(action)
  end)
  local delay = self.view:CalcActionTime(action)
  local wait = self.mgr:Wait(delay > 0 and delay or 5000)
  return self.mgr:Seq(exec, wait)
end
function class:SetMoveSpeed(speed)
  if speed < 0 then
    return
  end
  self.moveSpeed = speed
end
function class:GetMoveSpeed()
  return self.moveSpeed
end
function class:Goto(x, y)
  local start = self.view:GetPos()
  local stop = {x = x, y = y}
  local turn = self:Dir(internal:CalcDir(start, stop))
  local time = internal:CalcMoveTime(start, stop, self.moveSpeed)
  local move = self.mgr:Create(Tw.Scene.MoveTo, time, TwPoint(x, y))
  return turn, move
end
function class:Attack()
  return self:Action(RoleView.ACTION.ATTACK)
end
function class:Magic()
  return self:Action(RoleView.ACTION.MAGIC)
end
function class:Hit()
  return self:Action(RoleView.ACTION.HIT1)
end
function class:Die()
  return self.mgr:Create(Tw.Scene.FadeOut, 1000)
end
function class:FadeOut(time)
  return self.mgr:Create(Tw.Scene.FadeOut, 1000)
end
function class:FadeIn(time)
  return self.mgr:Create(Tw.Scene.FadeIn, 1000)
end
internal = {}
function internal:CalcDir(start, stop)
  local amount = table.size(RoleView.DIR)
  local all = math.pi * 2
  local rad = math.atan2(start.y - stop.y, stop.x - start.x)
  local revise = rad + all * (1 + 1 / amount / 2)
  local _, fractional = math.modf(revise / all)
  return math.modf(fractional * amount) + 1
end
function internal:CalcMoveTime(start, stop, speed)
  if 0 == speed then
    return 0
  end
  local x = stop.x - start.x
  local y = stop.y - start.y
  local dist = x * x + y * y
  return math.sqrt(dist) / speed
end
