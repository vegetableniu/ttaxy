require("bit")
require("struct")
module((...), package.seeall)
local internal = {}
TYPES = {
  OBJECT = 240,
  STRING = 224,
  ARRAY = 208,
  MAP = 192,
  BYTE_ARRAY = 176,
  DATE_TIME = 160,
  COLLECTION = 144,
  ENUM = 80,
  BOOLEAN = 32,
  NUMBER = 16,
  NULL = 1,
  UNKOWN = 0
}
function setup(...)
  return internal:Setup(...)
end
function import(...)
  return internal:Import(...)
end
function encode(codes, mod, cmd, data)
  return internal:Encode(codes, mod, cmd, data)
end
function decode(codes, mod, cmd, data)
  return internal:Decode(codes, mod, cmd, data)
end
function getType(name)
  return internal:GetType(name)
end
local MASK = {
  TYPE = 240,
  SIGNAL = 7,
  X80 = 128,
  X08 = 8
}
local NUMBER = {
  INT32 = 1,
  INT64 = 2,
  FLOAT = 3,
  DOUBLE = 4
}
local typeid = {
  bool = {},
  int = {},
  long = {},
  double = {},
  const = {},
  date = {},
  string = {},
  bytearray = {},
  enum = {},
  array = {},
  map = {},
  object = {}
}
local Writer = objectlua.Object:subclass()
function Writer:initialize(types, codes, typeinfo, var)
  super.initialize(self)
  self.types = types
  self.codes = codes
  self.refStr = {}
  self.refObj = {}
  self.buffer = {}
  self.result = self:Write(typeinfo, var)
end
function Writer:finalize()
  super.finalize(self)
end
function Writer:GetResult()
  return self.result
end
function Writer:Write(typeinfo, var)
  self:WriteImpl(typeinfo, var)
  return table.concat(self.buffer)
end
function Writer:findString(str)
  return self.refStr[str]
end
function Writer:refString(str)
  self.refStr[str] = table.size(self.refStr) + 1
end
function Writer:findObject(obj)
  return self.refObj[obj]
end
function Writer:refObject(obj)
  self.refObj[obj] = table.size(self.refObj) + 1
end
function Writer:WriteByte(byte)
  table.insert(self.buffer, struct.pack(">!1B", byte))
end
function Writer:WriteBytes(bytes)
  table.insert(self.buffer, struct.pack(">!1c" .. #bytes, bytes))
end
local NumberRanges = {
  math.pow(256, 0),
  math.pow(256, 1),
  math.pow(256, 2),
  math.pow(256, 3),
  math.pow(256, 4),
  math.pow(256, 5),
  math.pow(256, 6),
  math.pow(256, 7),
  math.pow(256, 8)
}
function Writer:WriteVarInt(val)
  assert(val >= 0)
  if val < MASK.X80 then
    self:WriteByte(val)
    return
  end
  local bytes = 0
  repeat
    bytes = bytes + 1
    assert(bytes <= #NumberRanges)
  until val < NumberRanges[bytes + 1]
  self:WriteByte(bit.bor(MASK.X80, bytes))
  for i = 1, bytes do
    local mod = math.mod(val, NumberRanges[bytes - i + 1])
    self:WriteByte((val - mod) / NumberRanges[bytes - i + 1])
    val = mod
  end
end
function Writer:WriteImpl(typeinfo, var)
  if var == nil then
    return self:WriteNull()
  end
  if typeinfo == typeid.bool then
    return self:WriteBoolean(var)
  end
  if typeinfo == typeid.long then
    return self:WriteId(var)
  end
  if typeinfo == typeid.int or typeinfo == typeid.double or typeinfo == typeid.const then
    return self:WriteNumber(var)
  end
  if typeinfo == typeid.date then
    return self:WriteDate(var)
  end
  if typeinfo == typeid.string then
    return self:WriteString(var)
  end
  if typeinfo == typeid.bytearray then
    return self:WriteByteArray(var)
  end
  if typeinfo == typeid.object then
    return self:WriteObject(typeinfo, var)
  end
  local mt = getmetatable(typeinfo)
  if mt == nil then
    if typeinfo[1] then
      return self:WriteImpl(typeinfo[1], var)
    end
    if nil == next(typeinfo) then
      return
    end
    return self:WriteMap(typeinfo, var)
  end
  if mt == typeid.enum then
    return self:WriteEnum(typeinfo, var)
  end
  if mt == typeid.array then
    return self:WriteArray(typeinfo, var)
  end
  if mt == typeid.map then
    return self:WriteMap(typeinfo, var)
  end
  if mt == typeid.object then
    return self:WriteObject(typeinfo, var)
  end
  assert(false)
end
function Writer:WriteNull()
  self:WriteByte(TYPES.NULL)
end
function Writer:WriteBoolean(var)
  assert(type(var) == "boolean")
  local data = TYPES.BOOLEAN
  data = bit.bor(data, var and 1 or 0)
  self:WriteByte(data)
end
function Writer:WriteNumber(var)
  assert(type(var) == "number")
  local flag = TYPES.NUMBER
  if var < 0 then
    flag = bit.bor(flag, MASK.X08)
  end
  if string.find(tostring(var), "%.") then
    flag = bit.bor(flag, NUMBER.FLOAT)
    self:WriteByte(flag)
    self:WriteVarInt(math.abs(var))
    return
  end
  if math.abs(var) < 2147483647 then
    flag = bit.bor(flag, NUMBER.INT32)
    self:WriteByte(flag)
    self:WriteVarInt(math.abs(var))
    return
  end
  flag = bit.bor(flag, NUMBER.INT64)
  self:WriteByte(flag)
  self:WriteVarInt(math.abs(var))
end
function Writer:WriteId(var)
  assert(type(var) == "string")
  return self:WriteBytes(var)
end
function Writer:WriteDate(var)
  assert(type(var) == "number")
  local flag = TYPES.DATE_TIME
  self:WriteByte(flag)
  self:WriteVarInt(var / 1000)
end
function Writer:WriteString(var)
  assert(type(var) == "string")
  local flag = TYPES.STRING
  local ref = self:findString(var)
  if ref then
    flag = bit.bor(flag, 1)
    self:WriteByte(flag)
    self:WriteVarInt(ref)
    return
  end
  self:refString(var)
  local utf8 = var
  self:WriteByte(flag)
  self:WriteVarInt(#utf8)
  self:WriteBytes(utf8)
end
function Writer:WriteByteArray(var)
  assert(type(var) == "table")
  local flag = TYPES.BYTE_ARRAY
  self:WriteVarInt(#var)
  self:WriteBytes(var)
end
function Writer:WriteEnum(typeinfo, var)
  assert(type(var) == "number")
  local flag = TYPES.ENUM
  self:WriteByte(flag)
  local code = self.codes.enum[self.types.type2name[typeinfo]].code
  self:WriteVarInt(code)
  self:WriteVarInt(var)
end
function Writer:WriteArray(typeinfo, var)
  assert(type(var) == "table")
  local flag = TYPES.ARRAY
  local ref = self:findObject(var)
  if ref then
    flag = bit.bor(flag, 1)
    self:WriteByte(flag)
    self:WriteVarInt(ref)
    return
  end
  self:refObject(var)
  self:WriteByte(flag)
  self:WriteVarInt(#var)
  for _, v in ipairs(var) do
    self:WriteImpl(typeinfo.valueType, v)
  end
end
function Writer:WriteMap(typeinfo, var)
  assert(type(var) == "table")
  local flag = TYPES.MAP
  local ref = self:findObject(var)
  if ref then
    flag = bit.bor(flag, 1)
    self:WriteByte(flag)
    self:WriteVarInt(ref)
    return
  end
  self:refObject(var)
  self:WriteByte(flag)
  if getmetatable(typeinfo) ~= typeid.map then
    self:WriteVarInt(table.size(typeinfo))
    for k, v in pairs(typeinfo) do
      self:WriteImpl(typeid.string, k)
      self:WriteImpl(v, var[k])
    end
  else
    self:WriteVarInt(table.size(var))
    for k, v in pairs(var) do
      self:WriteImpl(typeinfo.keyType, k)
      self:WriteImpl(typeinfo.valueType, v)
    end
  end
end
function Writer:WriteObject(typeinfo, var)
  assert(type(var) == "table")
  local flag = TYPES.OBJECT
  local ref = self:findObject(var)
  if ref then
    flag = bit.bor(flag, 1)
    self:WriteByte(flag)
    self:WriteVarInt(ref)
    return
  end
  assert(typeinfo ~= typeid.object)
  self:refObject(var)
  local name = self.types.type2name[typeinfo]
  local info = self.codes.object[name]
  self:WriteByte(flag)
  self:WriteVarInt(info.code)
  self:WriteByte(#info.fields)
  for _, v in ipairs(info.fields) do
    self:WriteImpl(typeinfo[v], var[v])
  end
end
local Reader = objectlua.Object:subclass()
function Reader:initialize(types, codes, buffer)
  super.initialize(self)
  self.types = types
  self.codes = codes
  self.buffer = buffer
  self.idx = 0
  self.refStr = {}
  self.refObj = {}
  self.result = self:Read()
end
function Reader:finalize()
  super.finalize(self)
end
function Reader:GetResult()
  return self.result
end
function Reader:Read()
  return self:ReadImpl()
end
function Reader:getString(idx)
  return self.refStr[idx]
end
function Reader:refString(str)
  self.refStr[#self.refStr + 1] = str
end
function Reader:getObject(idx)
  return self.refObj[idx]
end
function Reader:refObject(obj)
  self.refObj[#self.refObj + 1] = obj
end
function Reader:PeekByte()
  assert(self.idx + 1 <= #self.buffer)
  return string.byte(self.buffer, self.idx + 1)
end
function Reader:ReadByte()
  assert(self.idx + 1 <= #self.buffer)
  self.idx = self.idx + 1
  return string.byte(self.buffer, self.idx)
end
function Reader:ReadBytes(size)
  assert(self.idx + size <= #self.buffer)
  local idx = self.idx + 1
  self.idx = self.idx + size
  return string.sub(self.buffer, idx, idx + size - 1)
end
function Reader:ReadVarInt()
  local tag = self:ReadByte()
  if tag < MASK.X80 then
    return tag
  end
  local val = 0
  for i = 1, bit.band(tag, MASK.SIGNAL) do
    val = val * 256 + self:ReadByte()
  end
  return val
end
function Reader:ReadId(prefix)
  local tag = self:ReadByte()
  local head = string.char(prefix, tag)
  local bytes = tag < MASK.X80 and 0 or bit.band(tag, MASK.SIGNAL)
  return head .. self:ReadBytes(bytes)
end
function Reader:ReadFmt(fmt)
  local size = struct.size(fmt)
  local data = self:ReadBytes(size)
  return struct.unpack(fmt, data)
end
function Reader:ReadImpl()
  local flag = self:PeekByte()
  local typeid = bit.band(flag, MASK.TYPE)
  if flag == TYPES.NULL then
    return self:ReadNull()
  end
  if typeid == TYPES.BOOLEAN then
    return self:ReadBoolean()
  end
  if typeid == TYPES.NUMBER then
    return self:ReadNumber()
  end
  if typeid == TYPES.DATE_TIME then
    return self:ReadDate()
  end
  if typeid == TYPES.STRING then
    return self:ReadString()
  end
  if typeid == TYPES.BYTE_ARRAY then
    return self:ReadByteArray()
  end
  if typeid == TYPES.ENUM then
    return self:ReadEnum()
  end
  if typeid == TYPES.COLLECTION then
    return self:ReadCollection()
  end
  if typeid == TYPES.ARRAY then
    return self:ReadArray()
  end
  if typeid == TYPES.MAP then
    return self:ReadMap()
  end
  if typeid == TYPES.OBJECT then
    return self:ReadObject()
  end
  assert(false)
end
function Reader:ReadNull()
  local flag = self:ReadByte()
  assert(flag == TYPES.NULL)
  return nil
end
function Reader:ReadBoolean()
  local flag = self:ReadByte()
  assert(bit.band(flag, MASK.TYPE) == TYPES.BOOLEAN)
  local val = bit.band(flag, MASK.SIGNAL)
  if val == 0 then
    return false
  end
  if val == 1 then
    return true
  end
  assert(false, "Unknown signal (%d)", val)
end
function Reader:ReadNumber()
  local flag = self:ReadByte()
  assert(bit.band(flag, MASK.TYPE) == TYPES.NUMBER)
  local sign = bit.band(flag, MASK.X08) == 0 and 1 or -1
  local typeNumber = bit.band(flag, MASK.SIGNAL)
  if typeNumber == NUMBER.INT32 then
    return sign * self:ReadVarInt()
  end
  if typeNumber == NUMBER.INT64 then
    return self:ReadId(flag)
  end
  if typeNumber == NUMBER.FLOAT then
    return sign * self:ReadFmt(">!1f")
  end
  if typeNumber == NUMBER.DOUBLE then
    return sign * self:ReadFmt(">!1d")
  end
  assert(false)
end
function Reader:ReadDate()
  local flag = self:ReadByte()
  assert(bit.band(flag, MASK.TYPE) == TYPES.DATE_TIME)
  local dat = self:ReadVarInt()
  return dat * 1000
end
function Reader:ReadString()
  local flag = self:ReadByte()
  assert(bit.band(flag, MASK.TYPE) == TYPES.STRING)
  local tag = bit.band(flag, MASK.SIGNAL)
  if tag == 1 then
    local idx = self:ReadVarInt()
    return self:getString(idx)
  end
  if tag == 0 then
    local len = self:ReadVarInt()
    local str = self:ReadBytes(len)
    self:refString(str)
    return str
  end
  if tag == 2 then
    local len = self:ReadVarInt()
    local str = self:ReadBytes(len)
    self:refString(str)
    return str
  end
  assert(false)
end
function Reader:ReadByteArray()
  local flag = self:ReadByte()
  assert(bit.band(flag, MASK.TYPE) == TYPES.BYTE_ARRAY)
  local len = self:ReadVarInt()
  return self:ReadBytes(len)
end
function Reader:ReadEnum()
  local flag = self:ReadByte()
  assert(bit.band(flag, MASK.TYPE) == TYPES.ENUM)
  self:ReadVarInt()
  local ordinal = self:ReadVarInt()
  return ordinal
end
function Reader:ReadCollection()
  local flag = self:ReadByte()
  assert(bit.band(flag, MASK.TYPE) == TYPES.COLLECTION)
  local tag = bit.band(flag, MASK.SIGNAL)
  if tag == 1 then
    local ref = self:ReadVarInt()
    return self:getObject(ref)
  end
  local array = {}
  self:refObject(array)
  local len = self:ReadVarInt()
  for i = 1, len do
    array[i] = self:ReadImpl()
  end
  return array
end
function Reader:ReadArray()
  local flag = self:ReadByte()
  assert(bit.band(flag, MASK.TYPE) == TYPES.ARRAY)
  local tag = bit.band(flag, MASK.SIGNAL)
  if tag == 1 then
    local ref = self:ReadVarInt()
    return self:getObject(ref)
  end
  local array = {}
  self:refObject(array)
  local len = self:ReadVarInt()
  for i = 1, len do
    array[i] = self:ReadImpl()
  end
  return array
end
function Reader:ReadMap()
  local flag = self:ReadByte()
  assert(bit.band(flag, MASK.TYPE) == TYPES.MAP)
  local tag = bit.band(flag, MASK.SIGNAL)
  if tag == 1 then
    local ref = self:ReadVarInt()
    return self:getObject(ref)
  end
  local map = {}
  self:refObject(map)
  local size = self:ReadVarInt()
  for i = 1, size do
    local key = self:ReadImpl()
    local val = self:ReadImpl()
    map[key] = val
  end
  return map
end
function Reader:ReadObject()
  local flag = self:ReadByte()
  assert(bit.band(flag, MASK.TYPE) == TYPES.OBJECT)
  local tag = bit.band(flag, MASK.SIGNAL)
  if tag == 1 then
    local ref = self:ReadVarInt()
    return self:getObject(ref)
  end
  local obj = {}
  self:refObject(obj)
  local code = self:ReadVarInt()
  local info = self.codes.object[code]
  local typeinfo = self.types.name2type[info.name]
  local size = self:ReadVarInt()
  for i = 1, size do
    obj[info.fields[i]] = self:ReadImpl()
  end
  if info.name == "com.eyu.common.utils.model.Result" then
    setmetatable(obj, typeid.object)
  end
  return obj
end
local mt = {}
mt.__index = mt
mt.bool = typeid.bool
mt.int = typeid.int
mt.long = typeid.long
mt.double = typeid.double
mt.date = typeid.date
mt.string = typeid.string
mt.object = typeid.object
function mt.enum(t)
  return setmetatable(table.invert(t), typeid.enum)
end
function mt.const(t)
  return setmetatable(t, typeid.const)
end
function mt.array(t)
  return setmetatable({valueType = t}, typeid.array)
end
function mt.map(k, v)
  return setmetatable({keyType = k, valueType = v}, typeid.map)
end
function mt.class(t)
  return setmetatable(t, typeid.object)
end
internal.prefix = "com.eyu.mt.module"
internal.mods = {}
internal.types = {
  name2type = {},
  type2name = {}
}
function internal:Setup(...)
  setmetatable(_G[(...)], mt)
end
function internal:Import(...)
  local name = (...)
  local nameFixed = string.lower(string.sub(name, 4, 4)) .. string.sub(name, 5)
  local mod = _G[name]
  if mod.mod then
    self.mods[mod.mod] = mod
  end
  for k, v in pairs(mod.types) do
    if getmetatable(v) == nil then
      setmetatable(v, typeid.object)
    end
    local full = internal.prefix .. "." .. nameFixed .. "." .. k
    self.types.name2type[full] = v
    self.types.type2name[v] = full
  end
  if mod.mod then
    for k, v in pairs(mod.cmd) do
      v[2] = self:RemapTypeKeyValue(v[2])
    end
  end
  for k, v in pairs(mod.types) do
    if getmetatable(v) == typeid.object then
      mod.types[k] = self:RemapType(v)
    end
  end
end
function internal:RemapType(typeinfo)
  if type(typeinfo) == "string" then
    return internal:RemapTypeString(typeinfo)
  end
  local mt = getmetatable(typeinfo)
  if mt == typeid.array then
    return internal:RemapTypeArray(typeinfo)
  end
  if mt == typeid.map then
    return internal:RemapTypeMap(typeinfo)
  end
  if mt == typeid.object then
    return internal:RemapTypeKeyValue(typeinfo)
  end
  return typeinfo
end
function internal:RemapTypeArray(typeinfo)
  typeinfo.valueType = self:RemapType(typeinfo.valueType)
  return typeinfo
end
function internal:RemapTypeMap(typeinfo)
  typeinfo.keyType = self:RemapType(typeinfo.keyType)
  typeinfo.valueType = self:RemapType(typeinfo.valueType)
  return typeinfo
end
function internal:RemapTypeKeyValue(typeinfo)
  for k, v in pairs(typeinfo) do
    typeinfo[k] = self:RemapType(v)
  end
  return typeinfo
end
function internal:RemapTypeString(typeinfo)
  if not self.types.name2type[typeinfo] then
    local pattern = string.format("^%s%%.([^.]+)%%..+$", self.prefix)
    local mod = string.gsub(typeinfo, pattern, "%1")
    local first = string.sub(mod, 1, 1)
    local rest = string.sub(mod, 2)
    require("Msg" .. string.upper(first) .. rest)
  end
  assert(self.types.name2type[typeinfo], "Undefined type! [%s]", typeinfo)
  return self.types.name2type[typeinfo]
end
function internal:Encode(codes, mod, cmd, data)
  local m = self.mods[mod]
  for k, v in pairs(m.cmd) do
    if v[1] == cmd then
      cmd = k
    end
  end
  local typeinfo = m.cmd[cmd][2]
  return Writer:new(self.types, codes, typeinfo, data):GetResult()
end
function internal:Decode(codes, mod, cmd, data)
  local m = self.mods[mod]
  for k, v in pairs(m.cmd) do
    if v[1] == cmd then
      cmd = k
    end
  end
  return Reader:new(self.types, codes, data):GetResult()
end
function internal:GetType(name)
  return self.types.name2type[name]
end
_G.TypeDef = getType
_G.ID = {
  [0] = "\018\000",
  [-1] = "\026\001"
}
function Id2Str(id)
  if id == nil then
    return
  end
  local idx = 0
  local buffer = id
  local function readByte()
    idx = idx + 1
    return string.byte(buffer, idx)
  end
  local flag = readByte()
  local sign = bit.band(flag, MASK.X08) == 0 and 1 or -1
  local tag = readByte()
  if tag < MASK.X80 then
    return
  end
  local val = 0
  local lastByte = 0
  for i = 1, bit.band(tag, MASK.SIGNAL) do
    if i == bit.band(tag, MASK.SIGNAL) then
      lastByte = readByte()
    else
      val = val * 256 + readByte()
    end
  end
  local cutBit = 8
  local font = math.floor(val / math.pow(10, cutBit)) * 256
  local back = val % math.pow(10, cutBit) * 256 + lastByte
  font = font + math.floor(back / math.pow(10, cutBit))
  back = string.format("%08d", back % math.pow(10, cutBit))
  font = sign * font
  local result = tostring(font) .. tostring(back)
  return result
end
