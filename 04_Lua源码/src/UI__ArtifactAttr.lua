module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:initialize()
  super.initialize(self)
end
function prototype:onEnter()
end
function prototype:ReFrashInfo(data)
  if data == nil then
    return
  end
  self.data = data
  for i = 1, 6 do
    local str = string.format("ccbItem%d", i)
    if self[str] then
      self[str]:ReFrashInfo(self.data[i])
    end
  end
  for i = 2, 6 do
    local str = string.format("ccbItem%d", i)
    local upItem = string.format("ccbItem%d", i - 1)
    if self[str] and self[upItem] then
      local upPosY = self[upItem].ttfCurrLv:getPositionY() - (130 - self[upItem].ttfCurrLv:getContentSize().height)
      local posY = self[upItem]:getPositionY() - upPosY - 20
      self[str]:setPositionY(posY)
    end
  end
end
