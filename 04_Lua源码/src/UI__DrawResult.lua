module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  self.staDrawAwardTip:setStyle(kCCLabelTTFStyleOutline)
  self.staDrawAward:setStyle(kCCLabelTTFStyleOutline)
  self.staNextDrawLevel:setStyle(kCCLabelTTFStyleOutline)
  self.staGetAwardWay:setStyle(kCCLabelTTFStyleOutline)
  self.staNextDrawLevelTip:setStyle(kCCLabelTTFStyleOutline)
  self.btnReturn:setVisible(false)
  self.sprReturn:setVisible(false)
  self.staDrawAwardTip:setString(TwGetStr(108010))
  local drawResultId = Logic:Get("Draw"):getDrawResultId()
  local drawInfo = KFDBGetRecordByIdx("RouletteLotteryConfig", drawResultId)
  local color = ccColor3B(255, 255, 255)
  if drawInfo == nil and next(drawInfo) == nil then
    return
  end
  local str = drawInfo.rewardName .. "*" .. drawInfo.rewardNum
  if drawInfo.showType == "HERO" then
    color = Logic:Get("Hero"):getColorByBaseId(drawInfo.showId)
  elseif drawInfo.showType == "REAL_GOODS" then
    color = ccColor3B(255, 255, 0)
  else
    color = Logic:Get("Lottery"):GetHeroRankColor3(tonumber(drawInfo.showId))
  end
  self.staDrawAward:setColor(color)
  self.staDrawAward:setString(str)
  local str = ""
  if drawInfo.showType == "REAL_GOODS" then
    str = TwGetStr(108014)
  end
  self.staGetAwardWay:setString(str)
  local level = Logic:Get("Draw"):getNextDrawLevel()
  if level > 0 then
    self.staNextDrawLevelTip:setString(TwGetStr(108011))
    self.staNextDrawLevel:setString(TwGetStr(108015, level))
  end
  self:SetBackGround()
  Singleton(Timer):Repeat(3000, self:Event("setBtnVisible"))
end
function prototype:SetBackGround()
  local bgSp = CCSprite:create("images/BattleShow/fightResult_bg.png")
  local bgTexture, bgTextureRect = Logic:Get("HeroCardInfo"):GetCardTexture(bgSp, nil, false, CCSize(640, 833))
  self.mspBg:setTexture(bgTexture)
  self.mspBg:setTextureRect(bgTextureRect)
end
function prototype:onBtnReturn()
  Logic:Get("Guide"):check()
  if not Logic:Get("Guide"):isGuiding() then
    local divilData = Logic:Get("Devil"):GetHasDemog()
    if divilData then
      MsgDemog:Post("REFRESH_DEMOG")
      Logic:Get("Devil"):SetHasDemog(false)
    end
  end
  Logic:Get("Main"):SetFuncVisible(true)
  SceneHelper:removeScene("DrawResult")
  Logic:Get("Facebook"):OpenFaceBook()
end
function prototype:setBtnVisible()
  self.btnReturn:setVisible(true)
  self.sprReturn:setVisible(true)
end
