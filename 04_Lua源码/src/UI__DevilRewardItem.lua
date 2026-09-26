module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:RefreshReward(rewardInfo)
  if table.empty(rewardInfo) and next(rewardInfo) == nil then
    return
  end
  self.rewardInfo = rewardInfo
  local strText
  self.staList:setStyle(kCCLabelTTFStyleOutline)
  self.staReward:setStyle(kCCLabelTTFStyleOutline)
  if self.rewardInfo.lowRank ~= 0 then
    if self.rewardInfo.topRank ~= 0 then
      if self.rewardInfo.lowRank == self.rewardInfo.topRank then
        strText = TwGetStr(105512, self.rewardInfo.lowRank)
      else
        strText = TwGetStr(105517, self.rewardInfo.topRank, self.rewardInfo.lowRank)
      end
    else
      strText = TwGetStr(105512, self.rewardInfo.lowRank) .. "-"
    end
  end
  self.staList:setColor(ccColor3B(255, 255, 255))
  self.staList:setString(strText)
  self.staReward:setColor(ccColor3B(79, 249, 32))
  self.staReward:setString(self.rewardInfo.name)
end
