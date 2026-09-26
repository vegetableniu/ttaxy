module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:RefreshRank(rankInfo, index)
  if rankInfo == nil or index == nil then
    return
  end
  self.data = rankInfo
  local iconPath = Logic:Get("Hero"):GetHeroImage(tonumber(rankInfo.leaderBaseId))
  if iconPath == nil or iconPath == "" then
    return
  end
  local spriteIcon = CCSprite:create(iconPath)
  if spriteIcon then
    self.heroIcon:setDisplayFrame(spriteIcon:displayFrame())
  end
  local strBg, strStar = Logic:Get("Hero"):GetHeroBgImage(tonumber(rankInfo.leaderBaseId))
  if strBg == nil or strBg == "" then
    return
  end
  local spriteBg = CCSprite:create(strBg)
  if spriteBg then
    self.iconBg:setDisplayFrame(spriteBg:displayFrame())
  end
  self.artLv:setStyle(kCCLabelTTFStyleOutline)
  self.staName:setStyle(kCCLabelTTFStyleOutline)
  self.rank:setStyle(kCCLabelTTFStyleOutline)
  self.artLv:setColor(ccColor3B(0, 255, 0))
  self.nodLevel:create(0, "YELLOW_E_NUM")
  self.nodLevel:setValue(rankInfo.playerLevel)
  if rankInfo.score ~= nil then
    self.artLv:setString(TwGetStr(108051, rankInfo.score))
  end
  self.rank:setString(TwGetStr(110122, rankInfo.rank))
  self.staName:setString(rankInfo.name)
  local playerName = Logic:Get("PlayerInfo"):GetPlayerName()
  if playerName == rankInfo.name then
    self.staName:setColor(ccc3(255, 0, 0))
  else
    self.staName:setColor(ccc3(255, 255, 255))
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.iconBg, rankInfo.leaderBaseId, nil, nil, true)
end
function prototype:onBtnHeroImage()
  Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.data.leaderBaseId)
end
