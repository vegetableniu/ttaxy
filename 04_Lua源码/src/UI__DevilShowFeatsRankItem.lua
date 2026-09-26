module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:RefrashRankInfo(rankInfo)
  self.featsRank = rankInfo
  if self.featsRank == nil or next(self.featsRank) == nil then
    return
  end
  self.staRank:setStyle(kCCLabelTTFStyleOutline)
  self.staName:setStyle(kCCLabelTTFStyleOutline)
  self.staFeats:setStyle(kCCLabelTTFStyleOutline)
  self.staPraiseNum:setStyle(kCCLabelTTFStyleOutline)
  local iconPath = Logic:Get("Hero"):GetHeroImage(self.featsRank.leaderBaseId)
  local spriteIcon = CCSprite:create(iconPath)
  if spriteIcon then
    self.sprImage:setDisplayFrame(spriteIcon:displayFrame())
  end
  local strBg, strStar = Logic:Get("Hero"):GetHeroBgImage(self.featsRank.leaderBaseId)
  local spriteBg = CCSprite:create(strBg)
  if spriteBg then
    self.sprImageBg:setDisplayFrame(spriteBg:displayFrame())
  end
  if self.featsRank.level then
    self.nodeLevel:create(0, "YELLOW_E_NUM")
    self.nodeLevel:setAlign("CENTER", "CENTER")
    self.nodeLevel:setValue(self.featsRank.level)
  end
  local str = ""
  if self.featsRank.rank == 1 then
    str = TwGetStr(105574, TwGetStr(102131))
  elseif self.featsRank.rank == 2 then
    str = TwGetStr(105574, TwGetStr(102132))
  elseif self.featsRank.rank == 3 then
    str = TwGetStr(105574, TwGetStr(102133))
  elseif self.featsRank.rank == 4 then
    str = TwGetStr(105574, TwGetStr(102134))
  elseif self.featsRank.rank == 5 then
    str = TwGetStr(105574, TwGetStr(102135))
  end
  self.staRank:setString(str)
  self.name = Logic:Get("PlayerInfo"):GetPlayerName()
  if self.name == self.featsRank.name then
    self.staName:setColor(ccColor3B(255, 0, 0))
  else
    self.staName:setColor(ccColor3B(255, 255, 255))
  end
  self.staName:setString(self.featsRank.name)
  if self.featsRank.vip then
    self.sprVip:setVisible(true)
  else
    self.sprVip:setVisible(false)
  end
  self.staFeats:setString(TwGetStr(105575, self.featsRank.rankValue))
  if 0 < self.featsRank.praiseNum then
    self.staPraiseNum:setVisible(true)
    self.staPraiseNum:setString(TwGetStr(105576, self.featsRank.praiseNum))
  else
    self.staPraiseNum:setVisible(false)
  end
  if self.featsRank.canPraise then
    self.btnPraise:setVisible(true)
    self.sprPraise:setVisible(true)
  else
    self.btnPraise:setVisible(false)
    self.sprPraise:setVisible(false)
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.sprImageBg, self.featsRank.leaderBaseId, nil, nil, true)
end
function prototype:onBtnPraise()
  if self.name == self.featsRank.name then
    Prompt:Fail(TwGetStr(105578))
    return
  end
  if self.featsRank.id then
    MsgDemog:Post("PRAISE_RANK", {
      id = self.featsRank.id
    })
  end
end
function prototype:onBtnImage()
  Logic:Get("Devil"):SendMsgRankGroupInfo(self.featsRank.id)
end
