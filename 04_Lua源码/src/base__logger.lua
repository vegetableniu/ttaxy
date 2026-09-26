module((...), package.seeall)
require("logging")
local LEVEL_ABBR = {
  DEBUG = "D",
  INFO = "I",
  WARN = "W",
  ERROR = "E",
  FATAL = "F"
}
local sn = 0
local function format(chan, level, log, uniq)
  local L = LEVEL_ABBR[level]
  if not uniq then
    return string.format("[%s-%s]# %s", L, chan, log)
  end
  sn = sn + 1
  return string.format("[%04d-%s-%s]# %s", sn, L, chan, log)
end
local function appender(chan, uniq)
  chan = string.upper(chan)
  return function(logger, level, log)
    local report = false
    if logging.WARN <= logging[level] then
      report = true
      log = debug.traceback(log, 4)
    end
    local text = format(chan, level, log, uniq)
    Dbg(text)
    Log(text, report)
    return text
  end
end
function Category(chan, level)
  local uniq = level == "DEBUG"
  local logger = logging.new(appender(chan, uniq))
  logger:setLevel(logging[level or "WARN"])
  _G["log4" .. chan] = logger
end
