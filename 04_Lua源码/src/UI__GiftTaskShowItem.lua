module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:refreshInfo(data)
  if table.empty(data) then
    return
  end
  self.ttfCumulate:setStyle(kCCLabelTTFStyleOutline)
  self.ttfFeat:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCumulate:setString(TwGetStr(110915))
  self.ttfFeat:setString(data.feats)
  local _, color = Logic:Get("Gift"):GetColorByGift(data)
  local fntColor = color ~= "ff8600" and "00ff00" or color
  local reward = TwGetStr(110914, fntColor, data.desc or "")
  local str = TwGetStr(110914, "ffffff", TwGetStr(110916, reward))
  self.ttfReward:setString(str)
end
