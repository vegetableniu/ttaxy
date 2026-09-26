module("tree", package.seeall)
require("list")
local metatable = {}
function new(t)
  return setmetatable(t or {}, metatable)
end
function metatable.__index(tr, i)
  if type(i) == "table" then
    return list.foldl(op["[]"], tr, i)
  else
    return rawget(tr, i)
  end
end
function metatable.__newindex(tr, i, v)
  if type(i) == "table" then
    for n = 1, #i - 1 do
      if type(tr[i[n]]) ~= "table" then
        tr[i[n]] = tree.new()
      end
      tr = tr[i[n]]
    end
    rawset(tr, i[#i], v)
  else
    rawset(tr, i, v)
  end
end
function clone(t, nometa)
  local r = {}
  if not nometa then
    setmetatable(r, getmetatable(t))
  end
  local d = {
    [t] = r
  }
  local function copy(o, x)
    for i, v in pairs(x) do
      if type(v) == "table" then
        if not d[v] then
          d[v] = {}
          if not nometa then
            setmetatable(d[v], getmetatable(v))
          end
          o[i] = copy(d[v], v)
        else
          o[i] = d[v]
        end
      else
        o[i] = v
      end
    end
    return o
  end
  return copy(r, t)
end
