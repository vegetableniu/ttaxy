module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:setInfo(info)
  if info == nil then
    return
  end
  self.ttfRank:setString(TwGetStr(105512, info.rank or 0))
  self.ttfName:setString(info.name or "")
  self.ttfDamage:setString(TwGetStr(105513))
  self.ttfNum:setString(tostring(info.damage) or "0")
end
function prototype:setColor(color)
  if color == nil then
    return
  end
  self.ttfRank:setColor(color)
  self.ttfName:setColor(color)
  self.ttfDamage:setColor(color)
  self.ttfNum:setColor(color)
end
