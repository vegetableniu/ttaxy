module("list", package.seeall)
require("base")
require("table_ext")
function elems(l)
  local n = 0
  return function(l)
    n = n + 1
    if n <= #l then
      return l[n]
    end
  end, l, true
end
function relems(l)
  local n = #l + 1
  return function(l)
    n = n - 1
    if n > 0 then
      return l[n]
    end
  end, l, true
end
function map(f, l)
  return _G.map(f, elems, l)
end
function mapWith(f, l)
  return _G.map(compose(f, unpack), elems, l)
end
function filter(p, l)
  return _G.filter(p, elems, l)
end
function slice(l, from, to)
  local m = {}
  local len = #l
  from = from or 1
  to = to or len
  if from < 0 then
    from = from + len + 1
  end
  if to < 0 then
    to = to + len + 1
  end
  for i = from, to do
    table.insert(m, l[i])
  end
  return m
end
function tail(l)
  return slice(l, 2)
end
function foldl(f, e, l)
  return _G.fold(f, e, elems, l)
end
function foldr(f, e, l)
  return _G.fold(function(x, y)
    return f(y, x)
  end, e, relems, l)
end
function cons(l, x)
  return {
    x,
    unpack(l)
  }
end
function append(l, x)
  local r = {
    unpack(l)
  }
  table.insert(r, x)
  return r
end
function concat(...)
  local r = {}
  for _, l in ipairs({
    ...
  }) do
    for _, v in ipairs(l) do
      table.insert(r, v)
    end
  end
  return r
end
function rep(l, n)
  local r = {}
  for i = 1, n do
    r = list.concat(r, l)
  end
  return r
end
function reverse(l)
  local m = {}
  for i = #l, 1, -1 do
    table.insert(m, l[i])
  end
  return m
end
function transpose(ls)
  local ms, len = {}, #ls
  for i = 1, math.max(unpack(map(function(l)
    return #l
  end, ls))) do
    ms[i] = {}
    for j = 1, len do
      ms[i][j] = ls[j][i]
    end
  end
  return ms
end
function zipWith(f, ls)
  return mapWith(f, transpose(ls))
end
function project(f, l)
  return map(function(t)
    return t[f]
  end, l)
end
function enpair(t)
  local ls = {}
  for i, v in pairs(t) do
    table.insert(ls, {i, v})
  end
  return ls
end
function depair(ls)
  local t = {}
  for _, v in ipairs(ls) do
    t[v[1]] = v[2]
  end
  return t
end
function flatten(l)
  local m = {}
  for _, v in ipairs(l) do
    if type(v) == "table" then
      m = concat(m, flatten(v))
    else
      table.insert(m, v)
    end
  end
  return m
end
function shape(s, l)
  l = flatten(l)
  local size = 1
  local zero
  for i, v in ipairs(s) do
    if v == 0 then
      if zero then
        return nil
      else
        zero = i
      end
    else
      size = size * v
    end
  end
  if zero then
    s[zero] = math.ceil(#l / size)
  end
  local function fill(i, d)
    if d > #s then
      return l[i], i + 1
    else
      local t = {}
      for j = 1, s[d] do
        local e
        e, i = fill(i, d + 1)
        table.insert(t, e)
      end
      return t, i
    end
  end
  return (fill(1, 1))
end
function indexKey(f, l)
  local m = {}
  for i, v in ipairs(l) do
    local k = v[f]
    if k then
      m[k] = i
    end
  end
  return m
end
function indexValue(f, l)
  local m = {}
  for i, v in ipairs(l) do
    local k = v[f]
    if k then
      m[k] = v
    end
  end
  return m
end
permuteOn = indexValue
metatable = {
  __concat = list.concat,
  __append = list.append
}
function new(l)
  return setmetatable(l, metatable)
end
_G.op[".."] = list.concat
