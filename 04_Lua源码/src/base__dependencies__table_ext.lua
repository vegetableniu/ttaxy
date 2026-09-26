module("table", package.seeall)
local _sort = sort
function sort(t, c)
  _sort(t, c)
  return t
end
function empty(t)
  return not next(t)
end
function size(t)
  local n = 0
  for _ in pairs(t) do
    n = n + 1
  end
  return n
end
function indices(t)
  local u = {}
  for i, v in pairs(t) do
    insert(u, i)
  end
  return u
end
function values(t)
  local u = {}
  for i, v in pairs(t) do
    insert(u, v)
  end
  return u
end
function invert(t)
  local u = {}
  for i, v in pairs(t) do
    u[v] = i
  end
  return u
end
function rearrange(m, t)
  local r = clone(t)
  for i, v in pairs(m) do
    r[v] = t[i]
    r[i] = nil
  end
  return r
end
function clone(t, nometa)
  local u = {}
  if not nometa then
    setmetatable(u, getmetatable(t))
  end
  for i, v in pairs(t) do
    u[i] = v
  end
  return u
end
function merge(t, u)
  local r = clone(t)
  for i, v in pairs(u) do
    r[i] = v
  end
  return r
end
function new(x, t)
  return setmetatable(t or {}, {
    __index = function(t, i)
      return x
    end
  })
end
