module("getopt", package.seeall)
require("base")
require("list")
require("string_ext")
require("object")
require("io_ext")
function getOpt(argIn, options)
  local noProcess
  local argOut, optOut, errors = {
    [0] = argIn[0]
  }, {}, {}
  local function getArg(o, opt, arg, oldarg)
    if o.type == nil then
      if arg ~= nil then
        table.insert(errors, "option `" .. opt .. "' doesn't take an argument")
      end
    else
      if arg == nil and argIn[1] and string.sub(argIn[1], 1, 1) ~= "-" then
        arg = argIn[1]
        table.remove(argIn, 1)
      end
      if arg == nil and o.type == "Req" then
        table.insert(errors, "option `" .. opt .. "' requires an argument `" .. o.var .. "'")
        return nil
      end
    end
    if o.func then
      return o.func(arg, oldarg)
    end
    return arg or 1
  end
  local function parseOpt(opt, arg)
    local o = options.name[opt]
    if o ~= nil then
      optOut[o.name[1]] = getArg(o, opt, arg, optOut[o.name[1]])
    else
      table.insert(errors, "unrecognized option `-" .. opt .. "'")
    end
  end
  while argIn[1] do
    local v = argIn[1]
    table.remove(argIn, 1)
    local _, _, dash, opt = string.find(v, "^(%-%-?)([^=-][^=]*)")
    local _, _, arg = string.find(v, "=(.*)$")
    if v == "--" then
      noProcess = 1
    elseif dash == nil or noProcess then
      table.insert(argOut, v)
    else
      parseOpt(opt, arg)
    end
  end
  return argOut, optOut, errors
end
_G.Option = Object({
  _init = {
    "name",
    "desc",
    "type",
    "var",
    "func"
  }
})
function _G.Options(t)
  local name = {}
  for _, v in ipairs(t) do
    for j, s in pairs(v.name) do
      if name[s] then
        warn("duplicate option '%s'", s)
      end
      name[s] = v
    end
  end
  t.name = name
  return t
end
function usageInfo(header, optDesc, pageWidth)
  pageWidth = pageWidth or 78
  local fmtOpt = function(opt)
    local fmtName = function(o)
      return "-" .. o
    end
    local function fmtArg()
      if opt.type == nil then
        return ""
      elseif opt.type == "Req" then
        return "=" .. opt.var
      else
        return "[=" .. opt.var .. "]"
      end
    end
    local textName = list.map(fmtName, opt.name)
    textName[1] = textName[1] .. fmtArg()
    return {
      table.concat({
        table.concat(textName, ", ")
      }, ", "),
      opt.desc
    }
  end
  local sameLen = function(xs)
    local n = math.max(unpack(list.map(string.len, xs)))
    for i, v in pairs(xs) do
      xs[i] = string.sub(v .. string.rep(" ", n), 1, n)
    end
    return xs, n
  end
  local paste = function(x, y)
    return "  " .. x .. "  " .. y
  end
  local wrapper = function(w, i)
    return function(s)
      return string.wrap(s, w, i, 0)
    end
  end
  local optText = ""
  if #optDesc > 0 then
    local cols = list.transpose(list.map(fmtOpt, optDesc))
    local width
    cols[1], width = sameLen(cols[1])
    cols[2] = list.map(wrapper(pageWidth, width + 4), cols[2])
    optText = [[


]] .. table.concat(list.mapWith(paste, list.transpose({
      sameLen(cols[1]),
      cols[2]
    })), "\n")
  end
  return header .. optText
end
function usage()
  local name = prog.name
  prog.name = nil
  local usage, purpose, notes = "[OPTION...] FILE...", "", ""
  if prog.usage then
    usage = prog.usage
  end
  if prog.purpose then
    purpose = "\n" .. prog.purpose
  end
  if prog.notes then
    notes = [[


]]
    if not string.find(prog.notes, "\n") then
      notes = notes .. string.wrap(prog.notes)
    else
      notes = notes .. prog.notes
    end
  end
  warn(getopt.usageInfo("Usage: " .. name .. " " .. usage .. purpose, options) .. notes)
end
function processArgs()
  local totArgs = #arg
  options = Options(list.concat(options or {}, {
    Option({
      {"version", "v"},
      "show program version"
    }),
    Option({
      {
        "help",
        "h",
        "?"
      },
      "show this help"
    })
  }))
  local errors
  _G.arg, opt, errors = getopt.getOpt(arg, options)
  if (opt.version or opt.help) and prog.banner then
    io.stderr:write(prog.banner .. "\n")
  end
  if #errors > 0 or opt.help then
    local name = prog.name
    prog.name = nil
    if #errors > 0 then
      warn(table.concat(errors, "\n") .. "\n")
    end
    prog.name = name
    getopt.usage()
    if #errors > 0 then
      error()
    end
  end
  if opt.version or opt.help then
    os.exit()
  end
end
_G.options = nil
if type(_DEBUG) == "table" and _DEBUG.std then
  function out(o)
    return o or io.stdout
  end
  options = Options({
    Option({
      {"verbose", "v"},
      "verbosely list files"
    }),
    Option({
      {
        "version",
        "release",
        "V",
        "?"
      },
      "show version info"
    }),
    Option({
      {"output", "o"},
      "dump to FILE",
      "Opt",
      "FILE",
      out
    }),
    Option({
      {"name", "n"},
      "only dump USER's files",
      "Req",
      "USER"
    })
  })
  function test(cmdLine)
    local nonOpts, opts, errors = getopt.getOpt(cmdLine, options)
    if #errors == 0 then
      print("options=" .. tostring(opts) .. "  args=" .. tostring(nonOpts) .. "\n")
    else
      print(table.concat(errors, "\n") .. "\n" .. getopt.usageInfo("Usage: foobar [OPTION...] FILE...", options))
    end
  end
  prog = {name = "foobar"}
  test({"foo", "-v"})
  test({
    "foo",
    "--",
    "-v"
  })
  test({
    "-o",
    "-?",
    "-name",
    "bar",
    "--name=baz"
  })
  test({"-foo"})
end
