require("Events")
require("protocol")
module((...), package.seeall)
local internal = {}
EVT = Enum({
  "RECEIVE_MSG",
  "RECEIVE_MSG_ERROR_CODE",
  "SEND_MSG"
})
local class = objectlua.Object:subclass()
class:include(Events.Tracer)
function class:initialize()
  super.initialize(self)
  Events.Tracer.initialize(self)
  self.ignorErrorLst = {}
  self.eventSet = Events.EventSet:new()
  local data = CTwFilePack.Open("db/describe.dat")
  data = Tw.QuickLZ.Inflate(data)
  data = Tw.Zlib.Inflate(data)
  self.codes, self.codeIdx = internal:ExtraTypeCode(data)
  self:On(0, 1, self:Event("TYPE_CODE", function(code, data)
    data = Tw.QuickLZ.Inflate(data)
    data = Tw.Zlib.Inflate(data)
    self.codes, self.codeIdx = internal:ExtraTypeCode(data)
  end))
end
function class:dispose()
  self.eventSet:dispose()
  Events.Tracer.dispose(self)
  super.dispose(self)
end
function class:Setup(...)
  internal:Setup(...)
end
function class:Import(...)
  internal:Import(...)
end
function class:Send(mod, cmd, data, login)
  if nil ~= data then
    data = protocol.encode(self.codes, mod, cmd, data)
  end
  Singleton(NetMgr):queue(mod, cmd, data, login)
end
function class:OnEvent(type, event)
  self.eventSet:bind(event, type)
end
function class:On(mod, cmd, event, bIgnorError)
  local eventId = internal:MakeEventId(mod, cmd)
  self.eventSet:bind(event, eventId)
  self.ignorErrorLst[eventId] = bIgnorError == nil or bIgnorError == true
end
function class:OnReceived(params)
  local mod = params.mod
  local cmd = params.cmd
  local data = params.content
  local attachment = params.attachment
  if not params.raw and nil ~= data then
    data = protocol.decode(self.codeIdx, mod, cmd, data)
  end
  if type(data) ~= "table" or nil == getmetatable(data) then
    if type(data) == "number" then
      data = {code = data, content = data}
    end
    if type(data) ~= "table" or data.code == nil then
      data = {code = 0, content = data}
    end
  end
  self.eventSet:fire(EVT.RECEIVE_MSG, data.code, data.content, attachment)
  local eventId = internal:MakeEventId(mod, cmd)
  if 0 ~= data.code and self.ignorErrorLst[eventId] then
    local evtData = {
      name = internal:GetMsgName(eventId),
      mod = mod,
      cmd = cmd,
      code = data.code,
      content = data.content,
      attachment = attachment
    }
    self.eventSet:fire(EVT.RECEIVE_MSG_ERROR_CODE, evtData)
    return
  end
  return self.eventSet:fire(eventId, data.code, data.content, attachment)
end
internal.MASK_CMD = 10000
internal.eventKey2MsgName = {}
function internal:MakeEventId(mod, cmd)
  debug.traceback()
  if type(cmd) ~= "number" then
    debug.traceback()
  end
  assert(math.abs(cmd) * 2 < self.MASK_CMD, "Unaccepted cmd <%d>", cmd)
  return mod * self.MASK_CMD + (cmd + 5000) % self.MASK_CMD
end
function internal:GetMsgName(eventKey)
  return internal.eventKey2MsgName[eventKey]
end
function internal:ExtraTypeCode(data)
  local codes = {
    object = {},
    enum = {}
  }
  local codeIdx = {
    object = {},
    enum = {}
  }
  local pos = 1
  local function read(fmt)
    assert(pos + struct.size(">!1" .. fmt) <= #data + 1)
    local ret
    ret, pos = struct.unpack(">!1" .. fmt, data, pos)
    return ret
  end
  while pos <= #data do
    local flag = read("B")
    if flag == 0 then
      local def = {
        values = {}
      }
      def.code = read("I2")
      def.name = read("c" .. read("I2"))
      for i = 1, read("I2") do
        def.values[i] = read("c" .. read("I2"))
      end
      codes.enum[def.name] = def
      codeIdx.enum[def.code] = def
    end
    if flag == 1 then
      local def = {
        fields = {}
      }
      def.code = read("I2")
      def.name = read("c" .. read("I2"))
      for i = 1, read("I2") do
        def.fields[i] = read("c" .. read("I2"))
      end
      codes.object[def.name] = def
      codeIdx.object[def.code] = def
    end
  end
  assert(pos == #data + 1)
  return codes, codeIdx
end
local mt = {}
mt.__index = mt
mt.Singleton = _G.Singleton
function mt:On(cmd, event, bIgnorError)
  Singleton(NetMsg):On(self.mod, self.cmd[cmd][1], event, bIgnorError)
end
function mt:Post(cmd, data)
  Singleton(NetMsg):Send(self.mod, self.cmd[cmd][1], data)
end
function mt:PostPrior(cmd, data)
  Singleton(NetMsg):Send(self.mod, self.cmd[cmd][1], data, true)
end
function internal:Setup(...)
  local name = (...)
  protocol.setup(name)
  local mod = _G[name]
  local old = getmetatable(mod)
  setmetatable(mt, old)
  setmetatable(mod, mt)
end
function internal:Import(...)
  protocol.import(...)
  local msgName = (...)
  local mod = _G[msgName]
  for cmdName, cmdInfo in pairs(mod.cmd or {}) do
    local eventKey = internal:MakeEventId(mod.mod, cmdInfo[1])
    internal.eventKey2MsgName[eventKey] = msgName
  end
end
instance = class:new()
