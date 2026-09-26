module("string", package.seeall)
local old__index = getmetatable("").__index
getmetatable("").__index = function(s, i)
  if type(i) == "number" then
    return sub(s, i, i)
  elseif type(old__index) == "function" then
    return old__index(s, i)
  else
    return old__index[i]
  end
end
getmetatable("").__append = function(s, c)
  return s .. c
end
function caps(s)
  return (gsub(s, "(%w)([%w]*)", function(l, ls)
    return upper(l) .. ls
  end))
end
function chomp(s)
  return (gsub(s, [[

$]], ""))
end
function escapePattern(s)
  return (gsub(s, "(%W)", "%%%1"))
end
function escapeShell(s)
  return (gsub(s, "([ %(%)%\\%[%]\"'])", "\\%1"))
end
function ordinalSuffix(n)
  n = math.mod(n, 100)
  local d = math.mod(n, 10)
  if d == 1 and n ~= 11 then
    return "st"
  elseif d == 2 and n ~= 12 then
    return "nd"
  elseif d == 3 and n ~= 13 then
    return "rd"
  else
    return "th"
  end
end
local _format = format
function format(f, arg1, ...)
  if arg1 == nil then
    return f
  else
    return _format(f, arg1, ...)
  end
end
function pad(s, w, p)
  p = rep(p or " ", math.abs(w))
  if w < 0 then
    return sub(p .. s, w)
  end
  return sub(s .. p, 1, w)
end
function wrap(s, w, ind, ind1)
  w = w or 78
  ind = ind or 0
  ind1 = ind1 or ind
  assert(w > ind1 and w > ind, "the indents must be less than the line width")
  s = rep(" ", ind1) .. s
  local lstart, len = 1, len(s)
  while len - lstart > w - ind do
    local i = lstart + w - ind
    while lstart < i and sub(s, i, i) ~= " " do
      i = i - 1
    end
    local j = i
    while lstart < j and sub(s, j, j) == " " do
      j = j - 1
    end
    s = sub(s, 1, j) .. "\n" .. rep(" ", ind) .. sub(s, i + 1, -1)
    local change = ind + 1 - (i - j)
    lstart = j + change
    len = len + change
  end
  return s
end
function numbertosi(n)
  local SIprefix = {
    [-8] = "y",
    [-7] = "z",
    [-6] = "a",
    [-5] = "f",
    [-4] = "p",
    [-3] = "n",
    [-2] = "mu",
    [-1] = "m",
    [0] = "",
    [1] = "k",
    [2] = "M",
    [3] = "G",
    [4] = "T",
    [5] = "P",
    [6] = "E",
    [7] = "Z",
    [8] = "Y"
  }
  local t = format("% #.2e", n)
  local _, _, m, e = t:find(".(.%...)e(.+)")
  local man, exp = tonumber(m), tonumber(e)
  local siexp = math.floor(exp / 3)
  local shift = exp - siexp * 3
  local s = SIprefix[siexp] or "e" .. tostring(siexp)
  man = man * 10 ^ shift
  return tostring(man) .. s
end
function findl(s, p, init, plain)
  local pack = function(from, to, ...)
    return from, to, {
      ...
    }
  end
  return pack(p.find(s, p, init, plain))
end
function finds(s, p, init, plain)
  init = init or 1
  local l = {}
  local from, to, r
  repeat
    from, to, r = findl(s, p, init, plain)
    if from ~= nil then
      table.insert(l, {
        from,
        to,
        capt = r
      })
      init = to + 1
    end
  until not from
  return l
end
function gsubs(s, sub, n)
  local r = 0
  for i, v in pairs(sub) do
    local rep
    if n ~= nil then
      s, rep = gsub(s, i, v, n)
      r = r + rep
      n = n - rep
      if n == 0 then
        break
      end
    else
      s, rep = i.gsub(s, i, v)
      r = r + rep
    end
  end
  return s, r
end
function split(s, sep)
  local pairs = list.concat({0}, list.flatten(finds(s, sep)), {0})
  local l = {}
  for i = 1, #pairs, 2 do
    table.insert(l, sub(s, pairs[i] + 1, pairs[i + 1] - 1))
  end
  return l
end
function ltrim(s, r)
  r = r or "%s+"
  return (gsub(s, "^" .. r, ""))
end
function rtrim(s, r)
  r = r or "%s+"
  return (gsub(s, r .. "$", ""))
end
function trim(s, r)
  return rtrim(ltrim(s, r), r)
end
