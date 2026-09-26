module("set", package.seeall)
function member(s, e)
  return rawget(s, e) == true
end
function insert(s, e)
  rawset(s, e, true)
end
function delete(s, e)
  rawset(s, e, nil)
end
local metatable = {}
function new(l)
  local s = setmetatable({}, metatable)
  for _, e in ipairs(l) do
    insert(s, e)
  end
  return s
end
elements = pairs
function difference(s, t)
  local r = new({})
  for e in elements(s) do
    if not member(t, e) then
      insert(r, e)
    end
  end
  return r
end
function symmetric_difference(s, t)
  return difference(union(s, t), intersection(t, s))
end
function intersection(s, t)
  local r = new({})
  for e in elements(s) do
    if member(t, e) then
      insert(r, e)
    end
  end
  return r
end
function union(s, t)
  local r = new({})
  for e in elements(s) do
    insert(r, e)
  end
  for e in elements(t) do
    insert(r, e)
  end
  return r
end
function subset(s, t)
  for e in elements(s) do
    if not member(t, e) then
      return false
    end
  end
  return true
end
function propersubset(s, t)
  return subset(s, t) and not subset(t, s)
end
function equal(s, t)
  return subset(s, t) and subset(t, s)
end
metatable.__index = _M
metatable.__add = union
metatable.__sub = difference
metatable.__mul = intersection
metatable.__div = symmetric_difference
metatable.__le = subset
metatable.__lt = propersubset
