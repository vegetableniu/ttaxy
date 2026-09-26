module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:refreshAttribute(attributeInfo, heroId)
  local sprite = Logic:Get("Cultivate"):getPropertySpr(attributeInfo.propName)
  if sprite then
    self.sprAttribute1:setDisplayFrame(sprite:displayFrame())
    self.sprAttribute1:setScale(0.8)
  end
  local sprArrow = CCSprite:create("images/Cultivate/arrow_right.png")
  if sprArrow then
    self.sprArrow:setDisplayFrame(sprArrow:displayFrame())
  end
  local curAttr = attributeInfo.value
  if curAttr > 0 then
    if curAttr < 10 then
      curAttr = "+" .. curAttr * 100 .. "%"
    else
      curAttr = "+" .. curAttr
    end
  end
  self.ttfAttribute1:setString(curAttr)
  self.ttfAttribute1:setColor(ccColor3B(174, 255, 0))
  self.sprArr:setVisible(false)
end
