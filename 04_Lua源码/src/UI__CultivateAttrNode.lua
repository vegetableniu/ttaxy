module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:refreshAttribute(attributeInfo)
  self:clear()
  if attributeInfo == nil then
    return
  end
  local sprite = Logic:Get("Cultivate"):getPropertySpr(attributeInfo.propName)
  if sprite then
    self.sprAttribute:setDisplayFrame(sprite:displayFrame())
  end
  local attr = attributeInfo.value
  if attr > 0 then
    if attr < 10 then
      attr = "+" .. attributeInfo.value * 100 .. "%"
    else
      attr = "+" .. attributeInfo.value
    end
  end
  self.ttfAttribute:setString(attr)
end
function prototype:clear()
  local path = "images/public/clarity05.png"
  local sprite = CCSprite:create(path)
  if sprite then
    self.sprAttribute:setDisplayFrame(sprite:displayFrame())
    self.ttfAttribute:setString("")
  end
end
