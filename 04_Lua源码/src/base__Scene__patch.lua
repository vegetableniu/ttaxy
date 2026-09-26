local OnCallback = function(data, destroy)
  if not destroy then
    return data.func and data.func() or false
  end
  if data.host ~= nil and data.func ~= nil then
    data.host.__CALLBACKS__[data.func] = nil
  end
end
local callback_data_mt = {__mode = "v"}
local function MakeAgent(host, func)
  local data = setmetatable({}, callback_data_mt)
  data.host, data.func = host, func
  local function agent(destroy)
    return OnCallback(data, destroy)
  end
  return agent
end
local backup = TwHostHelperAction.MakeCallback
function TwHostHelperAction:MakeCallback(host, func)
  local agent = MakeAgent(host, func)
  local callback = backup(self, agent)
  if callback ~= nil and not callback:isNull() then
    host.__CALLBACKS__ = host.__CALLBACKS__ or {}
    host.__CALLBACKS__[func] = func
  end
  return callback
end
local backup = Tw.Scene.ActionMgr.Add
function Tw.Scene.ActionMgr:Add(target, action)
  return backup(self, target, TwSharedPtr:Ref(action))
end
local backup = Tw.Scene.ActionMgr.Del
function Tw.Scene.ActionMgr:Del(target, action)
  if action then
    return backup(self, target, TwSharedPtr:Ref(action))
  else
    return backup(self, target)
  end
end
local backup = Tw.Scene.Sequence.Append
function Tw.Scene.Sequence:Append(action)
  return backup(TwSharedPtr:Ptr(self), TwSharedPtr:Ref(action))
end
local backup = Tw.Scene.Spawn.Append
function Tw.Scene.Spawn:Append(action)
  return backup(TwSharedPtr:Ptr(self), TwSharedPtr:Ref(action))
end
local backup = Tw.Scene.Wait.new
function Tw.Scene.Wait:new(action)
  return backup(self, TwSharedPtr:Ref(action))
end
local backup = Tw.Scene.RepeatForever.new
function Tw.Scene.RepeatForever:new(action)
  return backup(self, TwSharedPtr:Ref(action))
end
local backup = Tw.Scene.RepeatUntil.new
function Tw.Scene.RepeatUntil:new(action, condition)
  return backup(self, TwSharedPtr:Ref(action), TwSharedPtr:Ref(condition))
end
