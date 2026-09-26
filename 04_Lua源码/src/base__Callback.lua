local _G = _G
local mt = {__mode = "v"}
module((...), package.seeall)
function new(self, obj, method)
  return class:new(obj, method)
end
