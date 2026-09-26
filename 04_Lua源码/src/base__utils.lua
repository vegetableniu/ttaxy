math.randomseed(os.time())
string.nl = "\n"
string.bl = ""
function Enum(t)
  return table.invert(t)
end
function Singleton(class)
  return class.instance
end
function RunInCoroutine(f, ...)
  local thread = coroutine.create(f)
  local ret = pack(coroutine.resume(thread, ...))
  local succ = table.remove(ret, 1)
  if not succ then
    error(debug.traceback(thread, ret[1]))
  end
  return unpack(ret)
end
function dump(s)
  return string.gsub(s, ".", function(c)
    return string.format("%02X ", string.byte(c))
  end)
end
require("logging")
local reporterNull = function()
end
local reporter = reporterNull
local lastReportTime = 0
local cache = {}
local buildReport = function(msg)
  local server = Logic:Get("Login"):GetLoginInfo()
  local data = {
    time = os.time(),
    revision = Logic:Get("System"):GetResVer(),
    device = CVariableSystem:GetSingleton():GetSysVariable(GV_DEVICE_NAME),
    server = server ~= nil and server.name or "",
    msg = msg
  }
  local s = json.encode(data)
  s = base64.encode(s)
  s = string.gsub(s, ".", {
    ["+"] = "_",
    ["/"] = "-"
  })
  return s
end
local function report(msg, category)
  if category == "critical" then
    reporter(buildReport(msg))
  end
  local now = TimeGetTime()
  if now > lastReportTime + 86400000 then
    cache = {}
  end
  if #cache >= 5 then
    return
  end
  if table.invert(cache)[msg] ~= nil then
    return
  end
  lastReportTime = now
  table.insert(cache, msg)
  reporter(buildReport(msg))
end
function setupCrashReporter(new)
  reporter = new or reporterNull
end
local reviseLog = function(str)
  str = string.gsub(str, "\\", "/")
  str = string.gsub(str, "%.%.%.[^:]*assets/", "")
  str = string.gsub(str, "%.%.%.[^:]*%.app/", "")
  return str
end
local blackhole = function(...)
end
_G.decoda_output = _G.decoda_output or blackhole
function DbgDecoda(str)
  _G.decoda_output(str)
end
function Dbg(str)
  DbgPrtOut(str)
end
function Log(str, category)
  str = reviseLog(str)
  if category and not IsDevMode() then
    report(str, category)
  end
  WriteLog(str)
end
local dbgLogCount = 0
function DbgLog(fmt, ...)
  dbgLogCount = dbgLogCount + 1
  fmt = fmt or "<nil>"
  fmt = "[%04d-DEBUG]# " .. fmt
  WriteLog(reviseLog(string.format(fmt, dbgLogCount, ...)))
end
function KFDBGetRecordByPT(item)
  if nil == item then
    return
  end
  local record = KFDBGetRecord("Platform", item)
  if nil == record then
    return
  end
  local ptName = "win32"
  local platform = CTwUtil:GetPlatform()
  if CTwUtil.E_TP_MAC == platform then
    ptName = "ios"
  elseif CTwUtil.E_TP_ANDROID == platform then
    ptName = "android"
  end
  return record[ptName]
end
function IsDevMode()
  local devMode = KFDBGetRecordByPT("devMode")
  if nil ~= devMode and "0" ~= devMode then
    return true
  end
  return false
end
function getCodePointByteAmount(byte)
  assert(byte >= 0 and byte < 253)
  if byte < 192 then
    return 1
  end
  if byte < 224 then
    return 2
  end
  if byte < 240 then
    return 3
  end
  if byte < 248 then
    return 4
  end
  if byte < 252 then
    return 5
  end
  return 6
end
function getCodePointAmount(s)
  local amount = 0
  local i = 1
  while i <= #s do
    amount = amount + 1
    i = i + getCodePointByteAmount(string.byte(s, i))
  end
  return amount
end
function getStrShowWidth(s)
  local amount = 0
  local i = 1
  local byteAmount = 1
  while i <= #s do
    byteAmount = getCodePointByteAmount(string.byte(s, i))
    amount = amount + (byteAmount > 1 and 2 or 1)
    i = i + byteAmount
  end
  return amount
end
function getSubString(s, begPos, endPos)
  begPos = begPos or 1
  endPos = endPos or getCodePointAmount(s)
  local i = 1
  local from = 1
  local amount = 0
  while i <= #s do
    amount = amount + 1
    if amount == begPos then
      from = i
    end
    i = i + getCodePointByteAmount(string.byte(s, i))
    if endPos <= amount then
      return string.sub(s, from, i - 1)
    end
  end
  return string.sub(s, from, #s)
end
function getSubANSIString(s)
  if nil == s then
    return
  end
  return string.gsub(s, ".", function(c)
    if string.byte(c) < 0 or string.byte(c) > 127 then
      return ""
    end
    return c
  end)
end
function ReplaceStringTab(str)
  str = string.gsub(str, "\\n", "\n")
  str = string.gsub(str, "\\t", "\t")
  return str
end
function ChatMsgFilter(content)
  return string.gsub(content, [=[
[<>&
]]=], {
    ["<"] = "&lt;",
    [">"] = "&gt;",
    ["&"] = "&amp;",
    ["\n"] = "&nbsp;"
  })
end
local _G = _G
module((...), package.seeall)
tolua = _G.objectlua.Mixin:new()
function tolua:new(...)
  local instance = super.new(self, ...)
  local host = instance:getHost()
  _G.assert(host)
  instance.__host_tolua__ = host
  _G.tolua.setpeer(host, instance)
  return host
end
require("Utils.Synchroniser")
