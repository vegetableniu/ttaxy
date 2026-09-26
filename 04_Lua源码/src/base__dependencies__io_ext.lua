module("io", package.seeall)
require("base")
require("package_ext")
local file_metatable = getmetatable(io.stdin)
function readlines(h)
  if h == nil then
    h = input()
  elseif _G.type(h) == "string" then
    h = io.open(h)
  end
  local l = {}
  for line in h:lines() do
    table.insert(l, line)
  end
  h:close()
  return l
end
file_metatable.readlines = readlines
function writeline(h, ...)
  if io.type(h) ~= "file" then
    io.write(h, "\n")
    h = io.output()
  end
  for _, v in ipairs({
    ...
  }) do
    h:write(v, "\n")
  end
end
file_metatable.writeline = writeline
function splitdir(path)
  return string.split(path, package.dirsep)
end
function catfile(...)
  return table.concat({
    ...
  }, package.dirsep)
end
function catdir(...)
  return (string.gsub(catfile(...), "^$", package.dirsep))
end
function shell(c)
  local h = io.popen(c)
  local o
  if h then
    o = h:read("*a")
    h:close()
  end
  return o
end
function processFiles(f)
  if #arg == 0 then
    table.insert(arg, "-")
  end
  for i, v in ipairs(arg) do
    if v == "-" then
      io.input(io.stdin)
    else
      io.input(v)
    end
    prog.file = v
    f(v, i)
  end
end
