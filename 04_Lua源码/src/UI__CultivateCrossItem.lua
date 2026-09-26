module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter(...)
  self.ttfAlter:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:refresh(data)
  if not data then
    return
  end
  local spr = Logic:Get("Cultivate"):getPropertySpr(data.propName)
  if spr then
    self.sprAlter:setDisplayFrame(spr:displayFrame())
  end
  local add = data.value
  local addPct = add < 10 and add ~= 0 and 100 * add .. "%" or add
  self.ttfAlter:setString("+" .. addPct)
end
