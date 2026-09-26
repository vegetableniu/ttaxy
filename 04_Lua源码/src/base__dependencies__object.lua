module("object", package.seeall)
require("table_ext")
_G.Object = {
  _init = {},
  _clone = function(self, values)
    local object = table.merge(self, table.rearrange(self._init, values))
    return setmetatable(object, object)
  end,
  __call = function(...)
    return (...)._clone(...)
  end
}
setmetatable(Object, Object)
