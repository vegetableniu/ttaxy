module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
end
function prototype:ReFrashReward(str, index)
  local color = {
    ccColor3B(255, 255, 255),
    ccColor3B(0, 255, 0),
    ccColor3B(102, 204, 255),
    ccColor3B(127, 0, 127),
    ccColor3B(255, 255, 0),
    ccColor3B(174, 95, 0),
    ccColor3B(0, 0, 0)
  }
  if str.targetLevel then
    self.ttfName:setString(str.targetLevel)
  end
  if str.content then
    self.ttfReward:setString(str.content)
  end
  if str.showid then
    self.ttfReward:setColor(color[tonumber(str.showid)])
  end
  if index ~= 1 then
    self.ttfReward:setStyle(kCCLabelTTFStyleOutline)
  else
    self.ttfReward:setStyle(kCCLabelTTFStyleSimple)
  end
  if str.showtype then
    self.img_spr:setVisible(true)
    local imgStr = Logic:Get("Artifact"):GetIconByShowType(str.showtype)
    local imgSpr = CCSprite:create(imgStr)
    if imgSpr ~= nil then
      self.img_spr:setDisplayFrame(imgSpr:displayFrame())
    end
  else
    self.img_spr:setVisible(false)
  end
end
