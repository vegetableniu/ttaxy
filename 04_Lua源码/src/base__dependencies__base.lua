module("base", package.seeall)
_G.op = {}
require("table_ext")
require("list")
require("string_ext")
function _G.metamethod(x, n)
  local _, m = pcall(function(x)
    return getmetatable(x)[n]
  end, x)
  if type(m) ~= "function" then
    m = nil
  end
  return m
end
function _G.render(x, open, close, elem, pair, sep, roots)
  local function stop_roots(x)
    return roots[x] or render(x, open, close, elem, pair, sep, table.clone(roots))
  end
  roots = roots or {}
  if type(x) ~= "table" or metamethod(x, "__tostring") then
    return elem(x)
  else
    local s = strbuf.new()
    s = s .. open(x)
    roots[x] = elem(x)
    local i, v
    for j, w in pairs(x) do
      s = s .. sep(x, i, v, j, w) .. pair(x, j, w, stop_roots(j), stop_roots(w))
      i, v = j, w
    end
    s = s .. sep(x, i, v, nil, nil) .. close(x)
    return s:tostring()
  end
end
_G._tostring = tostring
local _tostring = tostring
function _G.tostring(x)
  return render(x, function()
    return "{"
  end, function()
    return "}"
  end, _tostring, function(t, _, _, i, v)
    return i .. "=" .. v
  end, function(_, i, _, j)
    if i and j then
      return ","
    end
    return ""
  end)
end
function _G.prettytostring(t, indent, spacing)
  indent = indent or "\t"
  spacing = spacing or ""
  return render(t, function()
    local s = spacing .. "{"
    spacing = spacing .. indent
    return s
  end, function()
    spacing = string.gsub(spacing, indent .. "$", "")
    return spacing .. "}"
  end, function(x)
    if type(x) == "string" then
      return string.format("%q", x)
    else
      return tostring(x)
    end
  end, function(x, i, v, is, vs)
    local s = spacing .. "["
    if type(i) == "table" then
      s = s .. "\n"
    end
    s = s .. is
    if type(i) == "table" then
      s = s .. "\n"
    end
    s = s .. "] ="
    if type(v) == "table" then
      s = s .. "\n"
    else
      s = s .. " "
    end
    s = s .. vs
    return s
  end, function(_, i)
    local s = "\n"
    if i then
      s = "," .. s
    end
    return s
  end)
end
function _G.totable(x)
  local m = metamethod(x, "__totable")
  if m then
    return m(x)
  elseif type(x) == "table" then
    return x
  else
    return nil
  end
end
function _G.pickle(x)
  if type(x) == "string" then
    return string.format("%q", x)
  elseif type(x) == "number" or type(x) == "boolean" or type(x) == "nil" then
    return tostring(x)
  else
    x = totable(x) or x
    if type(x) == "table" then
      local s, sep = "{", ""
      for i, v in pairs(x) do
        s = s .. sep .. "[" .. pickle(i) .. "]=" .. pickle(v)
        sep = ","
      end
      s = s .. "}"
      return s
    else
      die("cannot pickle " .. tostring(x))
    end
  end
end
function _G.id(...)
  return ...
end
function _G.pack(...)
  return {
    ...
  }
end
function _G.bind(f, ...)
  local fix = {
    ...
  }
  return function(...)
    return f(unpack(list.concat(fix, {
      ...
    })))
  end
end
function _G.curry(f, n)
  if n <= 1 then
    return f
  else
    return function(x)
      return curry(bind(f, x), n - 1)
    end
  end
end
function _G.compose(...)
  local arg = {
    ...
  }
  local fns, n = arg, #arg
  return function(...)
    local arg = {
      ...
    }
    for i = n, 1, -1 do
      arg = {
        fns[i](unpack(arg))
      }
    end
    return unpack(arg)
  end
end
function _G.eval(s)
  return loadstring("return " .. s)()
end
function _G.ripairs(t)
  return function(t, n)
    n = n - 1
    if n > 0 then
      return n, t[n]
    end
  end, t, #t + 1
end
function _G.nodes(tr)
  local function visit(n, p)
    if type(n) == "table" then
      coroutine.yield("branch", p, n)
      for i, v in pairs(n) do
        table.insert(p, i)
        visit(v, p)
        table.remove(p)
      end
      coroutine.yield("join", p, n)
    else
      coroutine.yield("leaf", p, n)
    end
  end
  return coroutine.wrap(visit), tr, {}
end
function _G.collect(i, ...)
  local t = {}
  for e in i(...) do
    table.insert(t, e)
  end
  return t
end
function _G.map(f, i, ...)
  local t = {}
  for e in i(...) do
    local r = f(e)
    if r then
      table.insert(t, r)
    end
  end
  return t
end
function _G.filter(p, i, ...)
  local t = {}
  for e in i(...) do
    if p(e) then
      table.insert(t, e)
    end
  end
  return t
end
function _G.fold(f, d, i, ...)
  local r = d
  for e in i(...) do
    r = f(r, e)
  end
  return r
end
function _G.assert(v, f, ...)
  if not v then
    if f == nil then
      f = "assertion failed!"
    end
    error(string.format(f, ...), 2)
  end
  return v
end
function _G.warn(...)
  if prog.name then
    io.stderr:write(prog.name .. ":")
  end
  if prog.file then
    io.stderr:write(prog.file .. ":")
  end
  if prog.line then
    io.stderr:write(tostring(prog.line) .. ":")
  end
  if prog.name or prog.file or prog.line then
    io.stderr:write(" ")
  end
  io.writeline(io.stderr, string.format(...))
end
function _G.die(...)
  warn(unpack(arg))
  error()
end
_G.op["[]"] = function(t, s)
  return t[s]
end
_G.op["+"] = function(a, b)
  return a + b
end
_G.op["-"] = function(a, b)
  return a - b
end
_G.op["*"] = function(a, b)
  return a * b
end
_G.op["/"] = function(a, b)
  return a / b
end
_G.op["and"] = function(a, b)
  return a and b
end
_G.op["or"] = function(a, b)
  return a or b
end
_G.op["not"] = function(a)
  return not a
end
_G.op["=="] = function(a, b)
  return a == b
end
_G.op["~="] = function(a, b)
  return a ~= b
end
