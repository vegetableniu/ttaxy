module((...), package.seeall)
class = objectlua.Object:subclass()
function class:initialize(mgr)
  super.initialize(self)
  self.mgr = mgr
end
function class:dispose()
  super.dispose(self)
end
function class:Mgr()
  return self.mgr
end
function class:Exec(proxy, action)
  local node = proxy
  if proxy.GetView ~= nil then
    node = proxy:GetView():GetSceneNode()
  end
  self.mgr:Add(node, action)
end
function class:Clear(proxy, action)
  local node = proxy
  if proxy.GetView ~= nil then
    node = proxy:GetView():GetSceneNode()
  end
  if action ~= nil then
    self.mgr:Del(node, action)
  else
    self.mgr:Del(node)
  end
end
function class:Seq(...)
  local seq = self:Create(Tw.Scene.Sequence)
  for _, v in ipairs({
    ...
  }) do
    seq:Append(v)
  end
  return seq
end
function class:Spawn(...)
  local spawn = self:Create(Tw.Scene.Spawn)
  for _, v in ipairs({
    ...
  }) do
    spawn:Append(v)
  end
  return spawn
end
function class:Keyframe()
  return self:Create(Tw.Scene.Keyframe)
end
function class:Wait(var)
  if type(var) == "number" then
    return self:Create(Tw.Scene.Delay, var)
  end
  return self:Create(Tw.Scene.Wait, var)
end
function class:Repeat(action, condition)
  if condition == nil then
    return self:Create(Tw.Scene.RepeatForever, action)
  end
  return self:Create(Tw.Scene.RepeatUntil, action, condition)
end
function class:Do(func)
  local callable = TwHostHelperAction:MakeCallback(self, func)
  return self:Create(Tw.Scene.Callback, self.mgr, callable)
end
function class:Call(func)
  local callable = TwHostHelperAction:MakeCallback(self, func)
  return self:Create(Tw.Scene.CallbackQuick, callable)
end
function class:Create(class, ...)
  local ptr = class:new(...)
  local ref = Tw.Scene.ActionRef(ptr)
  return TwSharedPtr:Wrap(ref, ptr)
end
