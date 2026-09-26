require("Events")
require("TypeWrap")
module((...), package.seeall)
local internal = {}
function FromData(self, data)
  if TwDataHelper.IsBool(data) then
    return data:asBool()
  end
  if TwDataHelper.IsInt(data) then
    return data:asInt()
  end
  if TwDataHelper.IsInt64(data) then
    return data:asInt64()
  end
  if TwDataHelper.IsFloat(data) then
    return data:asFloat()
  end
  if TwDataHelper.IsString(data) then
    return data:asString()
  end
  if TwDataHelper.IsArray(data) then
    return internal.Array:FromData(data)
  end
  if TwDataHelper.IsMap(data) then
    return internal.Map:FromData(data)
  end
  assert(false)
end
function ToData(self, var)
  local tp = type(var)
  if tp == nil then
    return TwData()
  end
  if tp == "boolean" then
    return TwDataHelper.MakeBool(var)
  end
  if tp == "number" then
    return TwDataHelper.MakeInt(var)
  end
  if tp == "string" then
    return TwDataHelper.MakeString(var)
  end
  assert(tp == "table")
  if nil ~= var[1] then
    return internal.Array:ToData(var)
  end
  if TypeWrap:IsArray(var) then
    return internal.Array:ToData(var:Get())
  end
  if TypeWrap:IsFloat(var) then
    return TwDataHelper.MakeFloat(var:Get())
  end
  if TypeWrap:IsInt64(var) then
    return TwDataHelper.MakeInt64(var:Get())
  end
  return internal.Map:ToData(var)
end
internal.Array = {
  FromData = function(self, data)
    local t = {}
    for i = 1, data:Size() do
      table.insert(t, FromData(data[i - 1]))
    end
    return t
  end,
  ToData = function(self, var)
    local data = TwDataHelper:MakeArray()
    for _, v in ipairs(var) do
      data:AddChild(ToData(v))
    end
    return data
  end
}
internal.Map = {
  FromData = function(self, data)
    local t = {}
    local it = TwDataHelper.CMapIterator(data)
    while it:Next() do
      t[it:Key()] = FromData(self, it:Value())
    end
    return t
  end,
  ToData = function(self, var)
    local data = TwDataHelper.MakeMap()
    for k, v in pairs(var) do
      local item = ToData(self, v)
      data:AddChild(k, item)
    end
    return data
  end
}
