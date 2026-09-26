module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
end
function prototype:RefreshExchangeInfo(exchangeInfo)
  if exchangeInfo == nil or next(exchangeInfo) == nil then
    return
  end
  self.exchangeInfo = exchangeInfo
  local iconPath = Logic:Get("Hero"):GetHeroImage(self.exchangeInfo.heroId)
  local spriteIcon = CCSprite:create(iconPath)
  if spriteIcon then
    self.iconImage:setDisplayFrame(spriteIcon:displayFrame())
  end
  local strBg, strStar = Logic:Get("Hero"):GetHeroBgImage(self.exchangeInfo.heroId)
  local spriteBg = CCSprite:create(strBg)
  if spriteBg then
    self.iconBg:setDisplayFrame(spriteBg:displayFrame())
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.iconImage, self.exchangeInfo.heroId)
  self.staName:setStyle(kCCLabelTTFStyleOutline)
  self.staTip:setStyle(kCCLabelTTFStyleOutline)
  self.staCost:setStyle(kCCLabelTTFStyleOutline)
  self.exchangeHeroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(self.exchangeInfo.heroId) or {}
  self.staName:setColor(ccColor3B(255, 255, 255))
  self.staName:setString(self.exchangeHeroInfo.name)
  local bFeat = self.exchangeInfo.costItems ~= nil and self.exchangeInfo.costItems ~= ""
  local tFeats = json.decode(self.exchangeInfo.costItems or "") or {}
  if bFeat then
    self.feats = tFeats[1].amount or 0
  end
  self.staTip:setString(TwGetStr(105543))
  self.sprPrim:setVisible(not bFeat)
  self.sprFeat:setVisible(bFeat)
  local num = bFeat and self.feats or self.exchangeInfo.fragment
  self.staCost:setString("*" .. num)
  if exchangeInfo.limit == 1 then
    self.sprOnceExchange:setPositionX(self.staName:getPositionX() + self.staName:getContentSize().width)
    self.sprOnceExchange:setVisible(true)
  else
    self.sprOnceExchange:setVisible(false)
  end
end
function prototype:sendExchangeId(ret)
  if ret ~= Prompt.RET.OK then
    return
  end
  Logic:Get("Devil"):SendMsgFragmentExchange(self.exchangeInfo.id)
end
function prototype:onBtnExchange()
  local fragmentNum = Logic:Get("Devil"):GetFragment()
  local demogFeats = Logic:Get("PlayerInfo"):GetFeatNum()
  local bPrim = self.exchangeInfo.fragment ~= nil and self.exchangeInfo.fragment ~= ""
  local bFeat = self.exchangeInfo.costItems ~= nil and self.exchangeInfo.costItems ~= ""
  local canExchange = false
  local strTip = ""
  if bPrim then
    if fragmentNum < self.exchangeInfo.fragment then
      local str = TwGetStr(105545)
      Prompt:Confirm(self, 103001, str)
      return
    else
      local isBagFull = Logic:Get("Hero"):IsBagEnough()
      if isBagFull then
        SceneHelper:pushPrompt("BattleTip")
        return
      end
      strTip = TwGetStr(105547) .. TwGetStr(105544, self.exchangeInfo.fragment) .. TwGetStr(105548, self.exchangeHeroInfo.name)
      canExchange = true
    end
  end
  if bFeat then
    local feats = self.feats
    if demogFeats < feats then
      local str = TwGetStr(105593)
      Prompt:Confirm(self, 103001, str)
      return
    else
      local isBagFull = Logic:Get("Hero"):IsBagEnough()
      if isBagFull then
        SceneHelper:pushPrompt("BattleTip")
        return
      end
      strTip = TwGetStr(105547) .. TwGetStr(105592, feats) .. TwGetStr(105548, self.exchangeHeroInfo.name)
      canExchange = true
    end
  end
  if canExchange then
    Prompt:Select(self, 105550, strTip, self.sendExchangeId, Prompt.PROMPT_TYPE.SELECT)
  end
end
function prototype:onBtnImage()
  Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.exchangeInfo.heroId)
end
