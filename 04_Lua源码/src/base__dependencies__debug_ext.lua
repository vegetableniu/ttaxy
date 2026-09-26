module("debug", package.seeall)
require("debug_init")
require("io_ext")
require("string_ext")
function say(n, ...)
  local level = 1
  local arg = {
    n,
    ...
  }
  if type(arg[1]) == "number" then
    level = arg[1]
    table.remove(arg, 1)
  end
  if _DEBUG and (type(_DEBUG) == "table" and type(_DEBUG.level) == "number" and level <= _DEBUG.level or level <= 1) then
    io.writeline(io.stderr, table.concat(list.map(tostring, arg), "\t"))
  end
end
getmetatable(_M).__call = function(self, ...)
  say(...)
end
local level = 0
function trace(event)
  local t = getinfo(3)
  local s = " >>> " .. string.rep(" ", level)
  if t ~= nil and t.currentline >= 0 then
    s = s .. t.short_src .. ":" .. t.currentline .. " "
  end
  t = getinfo(2)
  if event == "call" then
    level = level + 1
  else
    level = math.max(level - 1, 0)
  end
  if t.what == "main" then
    if event == "call" then
      s = s .. "begin " .. t.short_src
    else
      s = s .. "end " .. t.short_src
    end
  elseif t.what == "Lua" then
    s = s .. event .. " " .. (t.name or "(Lua)") .. " <" .. t.linedefined .. ":" .. t.short_src .. ">"
  else
    s = s .. event .. " " .. (t.name or "(C)") .. " [" .. t.what .. "]"
  end
  io.writeline(io.stderr, s)
end
if type(_DEBUG) == "table" and _DEBUG.call then
  sethook(trace, "cr")
end
