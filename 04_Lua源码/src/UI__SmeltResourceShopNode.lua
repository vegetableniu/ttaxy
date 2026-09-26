module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:refreshInfo(data)
  self:clear()
  if data == nil then
    return
  end
  for k, v in pairs(data) do
    local str = string.format("ccbItem%d", k)
    if self[str] then
      self[str]:setVisible(true)
      self[str]:Refresh(v)
    end
  end
end
function prototype:clear()
  local MAX_ITEM = 4
  for i = 1, MAX_ITEM do
    local str = string.format("ccbItem%d", i)
    if self[str] then
      self[str]:setVisible(false)
    end
  end
end
