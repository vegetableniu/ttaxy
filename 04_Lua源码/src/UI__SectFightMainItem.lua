module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:onEnter()
end
function prototype:refresh(info)
  if info == nil then
    return
  end
  for i = 1, 4 do
    local ccb = string.format("cityMap%d", i)
    if self[ccb] then
      self[ccb]:refresh(info[i])
    end
  end
end
