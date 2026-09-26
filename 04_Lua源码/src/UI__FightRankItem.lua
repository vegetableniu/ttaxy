module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfRank:setStyle(kCCLabelTTFStyleOutline)
  self.ttfIntegral:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLevel:setStyle(kCCLabelTTFStyleOutline)
  self.ttfReward:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:RefreshRewardInfo(info)
  if info == nil then
    return
  end
  self.info = info
  self.rankLayer:setVisible(false)
  self.rewardLayer:setVisible(false)
  self.rankType = Logic:Get("Fight"):GetRankType()
  if self.rankType == Logic.Fight.RANK_TYPE.RANK_REWARD then
    self.rankLayer:setVisible(false)
    self.rewardLayer:setVisible(true)
    self:loadReward(info)
  else
    self.rankLayer:setVisible(true)
    self.rewardLayer:setVisible(false)
    self:loadRank(info)
  end
end
function prototype:onBtnHeroClicked()
  Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.info.leaderBaseId)
end
function prototype:loadReward(info)
  if info.topRank == 1 then
    self.ttfRewardRank:setString(TwGetStr(105512, info.topRank or 0))
  else
    self.ttfRewardRank:setString(TwGetStr(105517, info.topRank or 0, info.lowRank or 0))
  end
  self.ttfReward:setString(info.name or "")
end
function prototype:loadRank(info)
  local iconPath = Logic:Get("Hero"):GetHeroImage(info.leaderBaseId)
  local spriteIcon = CCSprite:create(iconPath)
  if spriteIcon then
    self.heroIcon:setDisplayFrame(spriteIcon:displayFrame())
  end
  local strBg, strStar = Logic:Get("Hero"):GetHeroBgImage(info.leaderBaseId)
  local spriteBg = CCSprite:create(strBg)
  if spriteBg then
    self.heroBg:setDisplayFrame(spriteBg:displayFrame())
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.heroIcon, info.leaderBaseId)
  local playerName = Logic:Get("PlayerInfo"):GetPlayerName()
  if info.userName == playerName then
    self.ttfName:setColor(ccColor3B(255, 0, 0))
  else
    self.ttfName:setColor(ccColor3B(255, 255, 255))
  end
  self.ttfName:setString(info.userName)
  self.ttfRank:setString(TwGetStr(105519) .. info.rank)
  self.ttfIntegral:setString(TwGetStr(105329, info.integral))
  self.ttfLevel:setString(TwGetStr(105305, info.level))
end
