module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
end
function prototype:ReFrashReward(str, index)
  if str == nil then
    self.ttfName:setString("")
    return
  end
  local color = {
    ccColor3B(128, 128, 128),
    ccColor3B(0, 255, 0),
    ccColor3B(102, 204, 255),
    ccColor3B(127, 0, 127),
    ccColor3B(255, 255, 0),
    ccColor3B(174, 95, 0),
    ccColor3B(0, 0, 0)
  }
  if str.strK > 7 then
    str.strK = 7
  end
  self.ttfName:setColor(color[str.strK])
  self.ttfName:setString(str.strR)
end
function prototype:refrashForHeroEvolution(str, index, isRedColor)
  if str == nil then
    self.ttfName:setString("")
    return
  end
  if isRedColor then
    self.ttfName:setColor(ccColor3B(255, 0, 0))
  else
    self.ttfName:setColor(ccColor3B(0, 0, 0))
  end
  self.ttfName:setString(str)
end
function prototype:ReFreshPrompt(str)
  self.ttfName:setString(str or "")
end
