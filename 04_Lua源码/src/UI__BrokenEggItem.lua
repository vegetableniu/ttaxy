module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfDesr:setStyle(kCCLabelTTFStyleOutline)
  self.ttfReward:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:Refrash(tab)
  if tab == nil then
    return
  end
  self.ttfName:setString(tab.name)
  local x = self.ttfName:getPositionX() + self.ttfName:getContentSize().width
  self.ttfDesr:setPositionX(x)
  self.ttfDesr:setString(TwGetStr(110503))
  if not table.empty(tab.rewardResults or {}) then
    local reward
    for k, v in pairs(tab.rewardResults) do
      if v.type ~= Logic.Reward.REWARDS_TYPE.TOKEN_COIN then
        reward = v
        break
      end
    end
    local str = Logic:Get("Reward"):RewardTreaTip(reward or tab.rewardResults[1])
    self.ttfReward:setString(str)
    local reward = tab.rewardResults[1]
    local map = Logic:Get("Reward"):createMap(reward)
    local data = {}
    if map[reward.type] then
      data.showType = map[reward.type].showType[reward.code + 1] or ""
      data.showId = map[reward.type].showId[reward.code + 1] or 4
    end
    local color
    if Logic.Gift.SHOW_TYPES[data.showType] then
      color = Logic:Get("Lottery"):GetHeroRankColor3(data.showId)
    else
      color = Logic:Get("Hero"):getColorByBaseId(tab.rewardResults[1].code)
    end
    if not color then
      return
    end
    self.ttfReward:setColor(color)
  end
end
