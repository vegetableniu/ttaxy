module((...), package.seeall)
local get = function(table, key)
  local mt = getmetatable(table)
  return mt.ptr[key]
end
local set = function(table, key, val)
  local mt = getmetatable(table)
  mt.ptr[key] = val
end
function Wrap(self, ref, ptr)
  local mt = {}
  mt.ref = ref
  mt.ptr = ptr
  mt.__index = get
  mt.__newindex = set
  return setmetatable({}, mt)
end
function Ref(self, wrapper)
  local mt = getmetatable(wrapper)
  return mt.ref
end
function Ptr(self, wrapper)
  local mt = getmetatable(wrapper)
  return mt.ptr
end
