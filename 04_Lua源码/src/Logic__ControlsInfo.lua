require("Logic")
module((...), package.seeall)
class = Logic.class:subclass()
function class:initialize()
  super.initialize(self)
end
function class:SaveControlInfo(control)
  self.obj = control
  self.width = control:getContentSize().width * control:getScaleX()
  self.height = control:getContentSize().height * control:getScaleY()
  local parent = control:getParent()
  local pos = {
    x = control:getPositionX(),
    y = control:getPositionY()
  }
  repeat
    if parent then
      pos.x = pos.x + parent:getPositionX() - (parent:getPositionX() ~= 0 and parent:getAnchorPoint().x * self.width or 0)
      pos.y = pos.y + parent:getPositionY() - (parent:getPositionX() ~= 0 and parent:getAnchorPoint().y * self.height or 0)
      parent = parent:getParent()
    end
  until parent == nil
  self.x = pos.x
  self.y = pos.y - control:getAnchorPoint().y * self.height
end
function class:Clear()
  self.obj = nil
  self.x = 0
  self.y = 0
  self.width = 0
  self.height = 0
end
