module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local IMG_NUM = 5
local alphaPath = "images/public/clarity80.png"
local IMG_HERO_CARD = {
  "imgHero1",
  "imgHero2",
  "imgHero3",
  "imgHero4",
  "imgHero5",
  "imgHero6"
}
function prototype:onEnter()
  self.ttfCostText:setString(TwGetStr(110064))
  self.imgArrowHead:setVisible(false)
  self.ttfNotEnough1:setStyle(kCCLabelTTFStyleOutline)
  self.ttfNotEnough2:setStyle(kCCLabelTTFStyleOutline)
  self.ttfNotEnough3:setStyle(kCCLabelTTFStyleOutline)
  self.ttfNotEnough4:setStyle(kCCLabelTTFStyleOutline)
  self.ttfNotEnough5:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCostText:setStyle(kCCLabelTTFStyleOutline)
  self.ttfText1:setStyle(kCCLabelTTFStyleOutline)
  self.ttfText2:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCostMoney:setStyle(kCCLabelTTFStyleOutline)
  local mixList = Logic:Get("Sect"):GetCardMixList()
  self.mixList = mixList
  self:setCardImage()
  if table.empty(mixList) or #mixList < 5 then
    self.btnMix:setEnabled(false)
  else
    self.btnMix:setEnabled(true)
  end
  Logic:Get("Hero"):On(Logic.Hero.EVT.ON_RANKUP_MENPAICARD, self:Event("OnRankupMenpaiCard"))
end
function prototype:onExit()
  Logic:Get("Sect"):SetCheckedId()
  Logic:Get("Sect"):SetMixMenpaiCard(false)
end
function prototype:rankupAni()
  local rootLayer = SceneHelper:getRootLayer()
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/uiyxsj", rootLayer, nil, 1)
  if self.ani then
    do
      local spr = CCSprite:create("images/Effect/UIhl/xj.png")
      if spr then
        self.ani:GetChild("imgLevelTip"):setDisplayFrame(spr:displayFrame())
        self.ani:GetChild("imgLevelTip"):setAnchorPoint(CCPoint(0.5, 0.5))
      end
      self:enableInfoText(false)
      self.ani:GetChild("btnClose"):setEnabled(false)
      local _, baseId = Logic:Get("Sect"):GetCheckedId()
      if not baseId then
        return
      end
      local card = Logic:Get("HeroCardInfo"):createHeroCardForByFight(baseId)
      local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(card, card:getContentSize())
      self.ani:GetChild("imgIn"):setTexture(texture)
      self.ani:GetChild("imgIn"):setTextureRect(textureRect)
      texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(card, self.ani:GetChild(IMG_HERO_CARD[1]):getContentSize())
      for i = 1, #IMG_HERO_CARD do
        if i <= IMG_NUM - 1 then
          self.ani:GetChild(IMG_HERO_CARD[i]):setTexture(texture)
          self.ani:GetChild(IMG_HERO_CARD[i]):setTextureRect(textureRect)
        else
          self.ani:GetChild(IMG_HERO_CARD[i]):setVisible(false)
        end
      end
      local cardInfo = Logic:Get("Sect"):GetCardInfoByBaseId(baseId)
      if not cardInfo then
        return
      end
      local nextCardInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(cardInfo.nextId)
      card = Logic:Get("HeroCardInfo"):createHeroCardForByFight(cardInfo.nextId)
      texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(card, card:getContentSize())
      self.ani:GetChild("imgOut"):setTexture(texture)
      self.ani:GetChild("imgOut"):setTextureRect(textureRect)
      self.ani:SetCloseCallback(self, self.onCloseAniBtn)
      Logic:Get("BGSound"):SwitchMusic("audio/up.mp3", false)
      self.ani:SetWaitSignByDefaultAniName(function()
        self:enableInfoText(true)
        self.ani:GetChild("imgGai"):setVisible(false)
        self.ani:GetChild("imgBody"):setVisible(false)
        self.ani:GetChild("staAttack"):create(0)
        self.ani:GetChild("staLife"):create(0)
        self.ani:GetChild("staLevel"):create(cardInfo.star)
        self.ani:GetChild("staAttack"):setCallback(bind(self.aniFrontEnd, self))
        self.ani:GetChild("staLevel"):setValueAni(nextCardInfo.star, 2000)
        self.ani:GetChild("staAttack"):setValueAni(0, 2000)
        self.ani:GetChild("staLife"):setValueAni(0, 2000)
      end, 5000)
      self.ani:RunAnimationWithoutWait()
    end
  end
end
function prototype:aniFrontEnd()
  self.ani:GetChild("btnClose"):setEnabled(true)
  local ccSprite = CCSprite:create("images/font/click_go_on.png")
  if ccSprite ~= nil then
    self.ani:GetLayer():addChild(ccSprite, 0, 10)
    local seq1 = Logic:Get("Gift"):fadetoSpr()
    ccSprite:runAction(CCRepeatForever:create(seq1))
    ccSprite:setPosition(self.ani:GetChild("ttfGoOn"):getPosition())
  end
end
function prototype:enableInfoText(enable)
  self.ani:GetChild("imgLevelTip"):setVisible(enable)
  self.ani:GetChild("staLevel"):setVisible(enable)
  self.ani:GetChild("imgAttackTip"):setVisible(enable)
  self.ani:GetChild("staAttack"):setVisible(enable)
  self.ani:GetChild("imgLifeTip"):setVisible(enable)
  self.ani:GetChild("staLife"):setVisible(enable)
  self.ani:GetChild("imgBg1"):setVisible(enable)
  self.ani:GetChild("imgBg2"):setVisible(enable)
  self.ani:GetChild("imgBg3"):setVisible(enable)
end
function prototype:setCardImage()
  local _, baseId = Logic:Get("Sect"):GetCheckedId()
  if not baseId then
    return
  end
  local path = Logic:Get("Hero"):GetHeroImage(baseId)
  local p = Logic:Get("Hero"):GetHeroBgImage(baseId)
  local curInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(baseId)
  self.ttfText1:setString(self:getMixTipInfoByMixName(curInfo.name))
  self.ttfCostMoney:setString(curInfo.costCoins or -1)
  if curInfo.costHeros and curInfo.costHeros ~= nil then
    local cost = json.decode(curInfo.costHeros)
    self.material = {}
    for k, v in pairs(cost or {}) do
      for i = 1, v do
        table.insert(self.material, k)
      end
    end
  end
  local enough = {}
  for i = 1, IMG_NUM do
    if i <= #self.mixList then
      table.insert(enough, true)
    else
      table.insert(enough, false)
    end
  end
  if not table.empty(self.mixList) then
    local border = CCSprite:create(p)
    self.imgBorder1:setDisplayFrame(border:displayFrame())
    self.imgBorder2:setDisplayFrame(border:displayFrame())
    self.imgBorder3:setDisplayFrame(border:displayFrame())
    self.imgBorder4:setDisplayFrame(border:displayFrame())
    local card = Logic:Get("HeroCardInfo"):createHeroCardForByFight(baseId)
    local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(card, card:getContentSize())
    self.imgCard:setTexture(texture)
    self.imgCard:setTextureRect(textureRect)
    local img = CCSprite:create(path)
    self.imgCard1:setDisplayFrame(img:displayFrame())
    self.imgCard2:setDisplayFrame(img:displayFrame())
    self.imgCard3:setDisplayFrame(img:displayFrame())
    self.imgCard4:setDisplayFrame(img:displayFrame())
    self.ttfNotEnough1:setString(enough[2] and "" or TwGetStr(104265))
    self.ttfNotEnough2:setString(enough[3] and "" or TwGetStr(104265))
    self.ttfNotEnough3:setString(enough[4] and "" or TwGetStr(104265))
    self.ttfNotEnough4:setString(enough[5] and "" or TwGetStr(104265))
    if Logic:Get("Sect"):checkCardEvolution(baseId) then
      self.imgArrowHead:setVisible(true)
    end
    local cardInfo = Logic:Get("Sect"):GetCardInfoByBaseId(baseId)
    if not cardInfo then
      return
    end
    local nextCardBaseId = Logic:Get("Hero"):GetHeroInfoByBaseId(cardInfo.nextId)
    nextCardBaseId = nextCardBaseId and nextCardBaseId.id
    local nextCardInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(cardInfo.nextId)
    self.ttfText2:setString(self:getMixTipInfoByMixName(nextCardInfo and nextCardInfo.name))
    local card = Logic:Get("HeroCardInfo"):createHeroCardForByFight(nextCardBaseId)
    local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(card, card:getContentSize())
    self.imgEvolution:setTexture(texture)
    self.imgEvolution:setTextureRect(textureRect)
  end
end
function prototype:hideImageAndText()
  local alphaImg = CCSprite:create(alphaPath)
  self.imgBorder1:setDisplayFrame(alphaImg:displayFrame())
  self.imgBorder2:setDisplayFrame(alphaImg:displayFrame())
  self.imgBorder3:setDisplayFrame(alphaImg:displayFrame())
  self.imgBorder4:setDisplayFrame(alphaImg:displayFrame())
  self.imgCard:setDisplayFrame(alphaImg:displayFrame())
  self.imgCard1:setDisplayFrame(alphaImg:displayFrame())
  self.imgCard2:setDisplayFrame(alphaImg:displayFrame())
  self.imgCard3:setDisplayFrame(alphaImg:displayFrame())
  self.imgCard4:setDisplayFrame(alphaImg:displayFrame())
  self.imgCard5:setDisplayFrame(alphaImg:displayFrame())
  self.ttfNotEnough1:setString("")
  self.ttfNotEnough2:setString("")
  self.ttfNotEnough3:setString("")
  self.ttfNotEnough4:setString("")
  self.ttfNotEnough5:setString("")
  self.ttfText1:setString("")
  self.ttfText2:setString("")
  self.ttfCostMoney:setString("")
  self.material = {}
end
function prototype:onBtnChooseCard(sender, event)
  SceneHelper:runWithScene("SectDemogCardSelect", self.rootNode)
end
function prototype:onBtnRight(sender, event)
  local _, baseId = Logic:Get("Sect"):GetCheckedId()
  if not baseId then
    return
  end
  local curInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(baseId)
  if curInfo.nextId and curInfo.nextId ~= "" or curInfo.nextId ~= -1 then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(curInfo.nextId)
  end
end
function prototype:onBtnMix(sender, event)
  local _, baseId = Logic:Get("Sect"):GetCheckedId()
  if not baseId then
    return
  end
  local curInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(baseId)
  local cost = curInfo.costCoins or 0
  local money = Logic:Get("PlayerInfo"):GetPlayerMoney().copper or 0
  if cost > money then
    Prompt:Fail(TwGetStr(110031))
    return
  end
  Logic:Get("Sect"):SetMixMenpaiCard(true)
  local checkedId = Logic:Get("Sect"):GetCheckedId()
  Logic:Get("Sect"):PostRankUp(checkedId)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("SectDemogMain", self.rootNode)
end
function prototype:onBtnHelmet(sender, event)
  self:OpenCardByIdx(1)
end
function prototype:onBtnArmour(sender, event)
  self:OpenCardByIdx(2)
end
function prototype:onBtnGloves(sender, event)
  self:OpenCardByIdx(3)
end
function prototype:onBtnTrousers(sender, event)
  self:OpenCardByIdx(4)
end
function prototype:onBtnShose(sender, event)
  self:OpenCardByIdx(5)
end
function prototype:onBtnEvolutionFunction(sender, event)
end
function prototype:OnRankupMenpaiCard()
  self:rankupAni()
  Logic:Get("Sect"):SetCheckedId()
  Logic:Get("Sect"):SetMixMenpaiCard(false)
  self:hideImageAndText()
  self.imgArrowHead:setVisible(false)
end
function prototype:onCloseAniBtn()
  self.ani:RemoveAnimation()
  Logic:Get("BGSound"):stopAllEffect()
  Logic:Get("BGSound"):PlayBGMusic()
end
function prototype:getMixTipInfoByMixName(mixName)
  if mixName == TwGetStr(110055) then
    return TwGetStr(110063, mixName, TwGetStr(110043))
  elseif mixName == TwGetStr(110056) then
    return TwGetStr(110063, mixName, TwGetStr(110042))
  elseif mixName == TwGetStr(110057) then
    return TwGetStr(110063, mixName, TwGetStr(110041))
  else
    return ""
  end
end
function prototype:OpenCardByIdx(idx)
  if table.empty(self.material or {}) or idx == nil then
    return
  end
  if self.material[idx] == nil then
    return
  end
  Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.material[idx])
end
