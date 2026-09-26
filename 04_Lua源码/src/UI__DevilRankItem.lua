module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:RefreshRank(rankInfo, rankType)
  if rankInfo == nil or next(rankInfo) == nil then
    return
  end
  self.rankInfo = rankInfo
  self.rankType = rankType
  self.heroInfo = {
    baseId = rankInfo.leaderBaseId,
    level = rankInfo.leaderLevel,
    powerSkill = rankInfo.powerSkill
  }
  local iconPath = Logic:Get("Hero"):GetHeroImage(self.heroInfo.baseId)
  local spriteIcon = CCSprite:create(iconPath)
  if spriteIcon then
    self.heroIcon:setDisplayFrame(spriteIcon:displayFrame())
  end
  local strBg, strStar = Logic:Get("Hero"):GetHeroBgImage(self.heroInfo.baseId)
  local spriteBg = CCSprite:create(strBg)
  if spriteBg then
    self.iconBg:setDisplayFrame(spriteBg:displayFrame())
  end
  self.staPraiseNum:setStyle(kCCLabelTTFStyleOutline)
  self.staRankTip:setStyle(kCCLabelTTFStyleOutline)
  self.staRank:setStyle(kCCLabelTTFStyleOutline)
  self.staValue:setStyle(kCCLabelTTFStyleOutline)
  self.staName:setStyle(kCCLabelTTFStyleOutline)
  if self.rankType == Logic.Devil.RANK_TYPE.FEATSRANK then
    self.staValue:setString(TwGetStr(105514, rankInfo.rankValue))
    if rankInfo.canPraise then
      self.btnPraise:setVisible(true)
    else
      self.btnPraise:setVisible(false)
    end
    if rankInfo.praiseNum > 0 then
      self.staPraiseNum:setVisible(true)
      self.staPraiseNum:setString(TwGetStr(105576, rankInfo.praiseNum))
    else
      self.staPraiseNum:setVisible(false)
    end
  end
  if self.rankType == Logic.Devil.RANK_TYPE.DAMAGERANK then
    self.staValue:setString(TwGetStr(105515, rankInfo.rankValue))
    self.staPraiseNum:setVisible(false)
    self.btnPraise:setVisible(false)
  end
  self.staRankTip:setString(TwGetStr(105519))
  self.staRank:setString(rankInfo.rank)
  local name = Logic:Get("PlayerInfo"):GetPlayerName()
  if name == rankInfo.name then
    self.staName:setColor(ccColor3B(255, 0, 0))
  else
    self.staName:setColor(ccColor3B(255, 255, 255))
  end
  self.staName:setString(rankInfo.name)
  if rankInfo.level then
    self.nodeLevel:create(0, "YELLOW_E_NUM")
    self.nodeLevel:setAlign("CENTER", "CENTER")
    self.nodeLevel:setValue(rankInfo.level)
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.iconBg, self.heroInfo.baseId, nil, nil, true)
end
function prototype:onBtnHeroImage()
  Logic:Get("Devil"):setRankType(self.rankType)
  Logic:Get("Devil"):SendMsgRankGroupInfo(self.rankInfo.id)
end
function prototype:onBtnPraise()
  if self.name == self.rankInfo.name then
    Prompt:Fail(TwGetStr(105578))
    return
  end
  if self.rankInfo.id then
    MsgDemog:Post("PRAISE_RANK", {
      id = self.rankInfo.id
    })
  end
end
