module("strbuf", package.seeall)
local metatable = {}
function new()
  return setmetatable({}, metatable)
end
function concat(b, s)
  table.insert(b, s)
  return b
end
function tostring(b)
  return table.concat(b)
end
metatable.__index = _M
metatable.__concat = concat
metatable.__tostring = tostring
