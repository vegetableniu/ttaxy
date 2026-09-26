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
  self.ttfRank:setStyle(kCCLabelTTFStyleOutline)
  self.ttfRankReward:setStyle(kCCLabelTTFStyleOutline)
  self.ttfAtLeast:setStyle(kCCLabelTTFStyleOutline)
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
  self.ttfRank:setColor(ccColor3B(255, 255, 255))
  self.ttfRank:setString(strText)
  self.ttfRankReward:setColor(ccColor3B(79, 249, 32))
  self.ttfRankReward:setString(ReplaceStringTab(self.rewardInfo.name))
  self.ttfAtLeast:setString("")
  if rewardInfo.consumeLimit and 0 < rewardInfo.consumeLimit then
    self.ttfAtLeast:setString(TwGetStr(108058, rewardInfo.consumeLimit))
  end
end
