module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
REWARDS_TYPE = TypeDef("com.eyu.mt.module.reward.model.RewardType")
function prototype:onEnter()
end
function prototype:RefreshInfo(reward)
  if reward == nil then
    return
  end
  self.ccbHeroInfo:setVisible(false)
  self.ccbTreaInfo:setVisible(false)
  self.ccbArmor:setVisible(false)
  if reward.rewardType == REWARDS_TYPE.HERO then
    self:showResult(reward)
  elseif reward.rewardType == REWARDS_TYPE.FRAGMENT then
    self:showResult(reward)
  elseif reward.rewardType == REWARDS_TYPE.EQUIPMENT or reward.rewardType == REWARDS_TYPE.EQUIPMENT_FRAGMENT then
    self.ccbArmor:setVisible(true)
    self.ccbArmor:refreshArmorInfo(reward.baseId, nil, true)
  else
    self.ccbTreaInfo:setVisible(true)
    self.ccbTreaInfo:ReFrashHeroInfo(reward)
  end
end
function prototype:showResult(reward)
  local rec = Logic:Get("Hero"):GetHeroInfoByBaseId(reward.baseId)
  if rec == nil then
    return
  end
  if rec.card == "HERO" then
    self.ccbHeroInfo:ReFrashHeroInfo(reward)
    self.ccbHeroInfo:setVisible(true)
  else
    self.ccbTreaInfo:setVisible(true)
    self.ccbTreaInfo:ReFrashHeroInfo(reward)
  end
end
