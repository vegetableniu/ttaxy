module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:RefreshRank(rankInfo, index)
  if rankInfo == nil or index == nil then
    return
  end
  local iconPath = Logic:Get("Hero"):GetHeroImage(tonumber(rankInfo.baseId))
  if iconPath == nil or iconPath == "" then
    return
  end
  local spriteIcon = CCSprite:create(iconPath)
  if spriteIcon then
    self.heroIcon:setDisplayFrame(spriteIcon:displayFrame())
  end
  local strBg, strStar = Logic:Get("Hero"):GetHeroBgImage(tonumber(rankInfo.baseId))
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
  if rankInfo.palyerLevel then
    self.nodeLevel:create(0, "YELLOW_E_NUM")
    self.nodeLevel:setAlign("CENTER", "CENTER")
    self.nodeLevel:setValue(rankInfo.palyerLevel)
  end
  if rankInfo.level ~= nil then
    self.artLv:setString(TwGetStr(103306, rankInfo.level))
  end
  self.rank:setString(index)
  self.staName:setString(rankInfo.name)
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.iconBg, rankInfo.baseId, nil, nil, true)
end
function prototype:onBtnHeroImage()
end
