module((...), package.seeall)
local CCBAni = require("BattleShow.CCBAnimation")
local Define = require("BattleShow.BattleDefine")
class = objectlua.Object:subclass()
function class:initialize(target, layer, effects)
  super.initialize(self)
  self.target = target
  self.layer = layer
  self.effects = effects
end
function class:dispose()
  super.dispose(self)
end
function class:Set()
end
function class:Add()
  self.color = CCLayerColor:create(ccc4(255, 255, 255, 100))
  self.layer:addChild(self.color)
  local size = self.layer:getContentSize()
  self.color:setContentSize(CCSizeMake(size.width / 2, size.height / 2))
  self.color:setPosition(ccp(size.width / 4, size.height / 4))
end
function class:Remove()
  if self.color then
    self.color:removeFromParentAndCleanup(true)
    self.color = nil
  end
end
function class:Active()
end
function class:Cancel()
end
function class:Change()
end
function class:GetType()
  return "Color"
end
