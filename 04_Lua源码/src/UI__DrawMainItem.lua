module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
end
function prototype:RefrashOtherDraw(otherDrawInfo)
  if otherDrawInfo == nil or next(otherDrawInfo) == nil then
    return
  end
  self.staPlayerName:setStyle(kCCLabelTTFStyleOutline)
  self.staDrawResult:setStyle(kCCLabelTTFStyleOutline)
  self.staPlayerName:setString(otherDrawInfo.userName)
  local rewardInfo = KFDBGetRecordByIdx("RouletteLotteryConfig", otherDrawInfo.configId)
  if rewardInfo ~= nil and next(rewardInfo) ~= nil then
    local str = rewardInfo.rewardName .. "*" .. rewardInfo.rewardNum
    self.staDrawResult:setString(str)
  end
end
