module((...), package.seeall)
local internal = {}
function Def(self, ...)
  local module = _G[(...)]
  local type = module.TYPE
  local modules = internal.modules
  assert(nil == modules[type], "Duplicate msg type: %d", type)
  modules[type] = module
  setmetatable(module, internal.msgHelper)
end
function GetMsgInfo(self, type)
  return internal.modules[type]
end
internal.modules = {}
function internal:CalcMsgActId(msg, act)
  local i = 1
  for i, v in ipairs(msg.ACTS) do
    if v[1] == act then
      return i
    end
  end
  assert(false, "Can't find action(%s) in msg(%d)", act, msg.TYPE)
end
internal.msgHelper = {
  Post = function(self, act, data)
    local actId = internal:CalcMsgActId(self, act)
    Singleton(NetMsg):Send(self.TYPE, actId, data)
  end,
  On = function(self, act, event)
    local actId = internal:CalcMsgActId(self, act)
    Singleton(NetMsg):On(self.TYPE, actId, event)
  end
}
internal.msgHelper.__index = internal.msgHelper
