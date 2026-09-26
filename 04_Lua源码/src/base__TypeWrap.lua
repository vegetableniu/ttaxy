module((...), package.seeall)
local internal = {}
function AsFloat(self, var)
  return internal.wrapper.Float:new(var)
end
function IsFloat(self, var)
  return var.class == internal.wrapper.Float
end
function AsInt64(self, var)
  return internal.wrapper.Int64:new(var)
end
function IsInt64(self, var)
  return var.class == internal.wrapper.Int64
end
function AsArray(self, var)
  return internal.wrapper.Array:new(var)
end
function IsArray(self, var)
  return var.class == internal.wrapper.Array
end
local Wrapper = objectlua.Object:subclass()
function Wrapper:initialize(var)
  self.var = var
end
function Wrapper:Get()
  return self.var
end
internal.wrapper = {
  Float = Wrapper:subclass(),
  Int64 = Wrapper:subclass(),
  Array = Wrapper:subclass()
}
