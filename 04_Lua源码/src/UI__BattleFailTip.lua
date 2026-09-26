module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  local failReward, success = Logic:Get("BattleShow"):GetFailRewardAndResult()
  local failTimes = Logic:Get("Battle"):GetFailedTimes()
  if not table.empty(failReward or {}) then
  elseif table.empty(failReward.rewards or {}) then
    return
  end
  local sprIcon = Logic:Get("Reward"):GetImgByOneReward(failReward.rewards[1])
  if sprIcon then
    local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(sprIcon)
    self.sprIcon:setTexture(texture)
    self.sprIcon:setTextureRect(textureRect)
  end
  local bg = Logic:Get("Reward"):GetBgByOneReward(failReward.rewards[1])
  if bg then
    self.sprBg:setDisplayFrame(bg:displayFrame())
  end
  self.ttfAmount:setStyle(kCCLabelTTFStyleOutline)
  self.ttfAmount:setString(failReward.rewards[1].amount)
  if failTimes < 1 or failTimes > 3 then
    return
  end
  self.ttfDesr:setString(TwGetStr(104212 + failTimes))
end
function prototype:onExit()
end
function prototype:onBtnBg()
end
function prototype:onBtnConfirm()
  SceneHelper:removePrompt(self.rootNode)
end
