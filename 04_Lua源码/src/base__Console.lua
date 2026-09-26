local _G = _G
module((...), package.seeall)
_G[string.lower(...)] = _G[(...)]._M
class = objectlua.Object:subclass()
function class:initialize(...)
end
function class:Input(line)
  local func, err = loadstring(line, "Console")
  if not func then
    return err
  end
  local _, msg = pcall(func)
  return msg
end
Singleton = class:new()
env = {
  new = function(self)
    CEnvInstanceMgr:GetSingleton():New()
  end,
  exit = function(self)
    CEnvInstanceMgr:GetSingleton():Exit()
  end,
  prev = function(self)
    CEnvInstanceMgr:GetSingleton():Prev()
  end,
  next = function(self)
    CEnvInstanceMgr:GetSingleton():Next()
  end
}
