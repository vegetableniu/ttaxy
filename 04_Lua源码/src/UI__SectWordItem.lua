module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local GAP = 10
local XGAP = 20
function prototype:onEnter()
end
function prototype:refreshInfo(info, width)
  self.info = info
  self.height = 0
  local iconH = 0
  local nameH = 0
  local dateH = 0
  local messageH = 0
  local iconPath = Logic:Get("Hero"):GetHeroImage(info.baseId)
  local spriteIcon = CCSprite:create(iconPath)
  if spriteIcon then
    self.fighterIcon:setDisplayFrame(spriteIcon:displayFrame())
  end
  local imgBg = Logic:Get("Hero"):GetHeroBgImage(info.baseId)
  local sprBg = CCSprite:create(imgBg)
  if sprBg then
    self.spriteRank:setDisplayFrame(sprBg:displayFrame())
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.fighterIcon, info.baseId)
  iconH = self.spriteRank:getContentSize().height
  self.nodeLevel:create(0, "YELLOW_E_NUM")
  self.nodeLevel:setAlign("LEFT", "CENTER")
  self.nodeLevel:setValue(info.level)
  if info.playerId == Logic:Get("PlayerInfo"):GetPlayerId() then
    self.staName:setColor(ccColor3B(0, 255, 0))
  else
    self.staName:setColor(ccColor3B(157, 235, 226))
  end
  self.staName:setString(info.name)
  nameH = self.staName:getContentSize().height
  local dateT = Logic:Get("System"):GetTimeDate(info.date / 1000)
  if dateT then
    local dateStr = string.format("%02d/%02d %02d:%02d:%02d", dateT.month, dateT.day, dateT.hour, dateT.min, dateT.sec)
    self.staDate:setString(dateStr)
  end
  dateH = self.staDate:getContentSize().height
  local messageW = width - self.staShow:getPositionX() - GAP - XGAP
  self.staShow:setString(info.message)
  if messageW < self.staShow:getContentSize().width then
    self.staShow:setDimensions(CCSize(messageW, 0))
  end
  messageH = self.staShow:getContentSize().height + 3 * GAP
  local textH = nameH > dateH and nameH or dateH
  textH = textH + messageH + GAP
  self.height = iconH < textH and textH or iconH
  local x = self.spriteRank:getPositionX()
  local ry = self.spriteRank:getPositionY()
  local y
  self.spriteRank:setPosition(ccp(x, self.height))
  x = self.fighterIcon:getPositionX()
  y = self.height - ry + self.fighterIcon:getPositionY()
  self.fighterIcon:setPosition(ccp(x, y))
  x = self.speLevel:getPositionX()
  y = self.height - ry + self.speLevel:getPositionY()
  self.speLevel:setPosition(ccp(x, y))
  x = self.nodeLevel:getPositionX()
  y = self.height - ry + self.nodeLevel:getPositionY()
  self.nodeLevel:setPosition(ccp(x, y))
  x = self.btnHeroImage:getPositionX()
  self.btnHeroImage:setPosition(ccp(x, self.height))
  x = self.staName:getPositionX()
  self.staName:setPosition(ccp(x, self.height - GAP / 2))
  x = self.staDate:getPositionX()
  self.staDate:setPosition(ccp(x, self.height - GAP / 2))
  local sizeW = self.staShow:getPositionX() - self.spdBg:getPositionX() + self.spdBg:getContentSize().width / 2
  sizeW = sizeW + self.staShow:getContentSize().width + XGAP
  if not (sizeW > 90) or not sizeW then
    sizeW = 90
  end
  self.spdBg:setContentSize(CCSize(sizeW, messageH))
  x = self.staShow:getPositionX() + self.spdBg:getContentSize().width / 2 - XGAP
  y = nameH > dateH and nameH or dateH
  y = self.height - y - GAP
  local bgHeight = self.spdBg:getContentSize().height
  self.spdBg:setPosition(ccp(x, y - bgHeight / 2))
  self.sprTale:setPosition(ccp(self.sprTale:getPositionX(), y - bgHeight / 2))
  local staShowHeight = self.staShow:getContentSize().height
  x = self.staShow:getPositionX()
  self.staShow:setPosition(ccp(x, y - bgHeight / 2 + staShowHeight / 2))
end
function prototype:getContentSizeH()
  return self.height
end
function prototype:onBtnHeroImage(sender, event)
  if self.info == nil then
    return
  end
  local heroInfo = {
    level = self.info.level or 1,
    baseId = self.info.baseId or 1,
    powerSkill = tonumber(self.info.skill) or 1
  }
  if Logic:Get("Sect"):getEnterWord() then
    Logic:Get("HeroCardInfo"):PromptHeroInfoByNparma(heroInfo)
  else
    Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(heroInfo)
  end
end
