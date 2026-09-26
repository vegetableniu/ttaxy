module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
require("Logic.Reward")
prototype = BtnPosition.prototype:extend()
function prototype:initialize()
  super.initialize(self)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onEnter()
  super.onEnter(self)
  self.imgArrowHead:setVisible(false)
  self.imgAdd2:setVisible(false)
  self.ttfDesr:setStyle(kCCLabelTTFStyleOutline)
  self.costMoney:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCost:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCost2:setStyle(kCCLabelTTFStyleOutline)
  self.ttfMoney2:setStyle(kCCLabelTTFStyleOutline)
  self.ttfDesr:setString(TwGetStr(105761))
  Logic:Get("Compose"):On(Logic.Compose.EVT.SELECT_CARD, self:Event("onSelectCard"))
  Logic:Get("Compose"):On(Logic.Compose.EVT.SWAP, self:Event("onSwapSuccess"))
end
function prototype:onExit()
  Logic:Get("Compose"):SetSelectCard(nil)
  Logic:Get("Compose"):SetTargetCard(nil)
  Logic:Get("Compose"):SetUnitRace(Logic.Compose.UNITRACE.XIAN)
end
function prototype:onSelectCard()
  self:Clear()
  local selectCard = Logic:Get("Compose"):GetSelectCard()
  if selectCard then
    self.imgAdd2:setVisible(true)
    local cardNode = Logic:Get("HeroCardInfo"):GetSprCard(selectCard.baseId)
    local texture = Logic:Get("HeroCardInfo"):GetCardTexture(cardNode)
    if texture then
      self.sprSelect:setTexture(texture)
      self.sprSelect:setTextureRect(cardNode:getTextureRect())
      Logic:Get("HeroCardInfo"):AddShanCard(self.sprSelect, selectCard.baseId)
    end
  end
  local targetCard = Logic:Get("Compose"):GetTargetCard()
  if targetCard then
    local cardNode = Logic:Get("HeroCardInfo"):GetSprCard(targetCard.baseId)
    local texture = Logic:Get("HeroCardInfo"):GetCardTexture(cardNode)
    if texture then
      self.sprTarget:setTexture(texture)
      self.sprTarget:setTextureRect(cardNode:getTextureRect())
      Logic:Get("HeroCardInfo"):AddShanCard(self.sprTarget, targetCard.baseId)
    end
  end
  if selectCard and targetCard then
    self.imgArrowHead:setVisible(true)
    local fra, cost = Logic:Get("Compose"):GetChangeCost()
    local rec = KFDBGetRecord("ConfigValue", "ITEM:SWAP_COST_FRAGMENT_TYPES")
    local currencyType = json.decode(rec.content or "[]")
    local logic = Logic.Reward
    local currencyName = logic.CURRENCY_TYPE_NAME[logic.CURRENCY_TYPE[currencyType[1] or 1]]
    self.ttfCost2:setString(TwGetStr(103202, TwGetStr(currencyName)))
    self.ttfMoney2:setString(fra)
    local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
    local fraMoney = wallet[string.lower(currencyType[1])]
    if fra > fraMoney then
      self.ttfMoney2:setColor(ccc3(255, 0, 0))
    end
    rec = KFDBGetRecord("ConfigValue", "ITEM:SWAP_COST_TYPES")
    currencyType = json.decode(rec.content or "[]")
    currencyName = logic.CURRENCY_TYPE_NAME[logic.CURRENCY_TYPE[currencyType[1]]]
    self.ttfCost:setString(TwGetStr(103202, TwGetStr(currencyName)))
    self.costMoney:setString(cost)
    local otherMoney = wallet[string.lower(currencyType[1])]
    if cost > otherMoney then
      self.costMoney:setColor(ccc3(255, 0, 0))
    end
  end
end
function prototype:Clear()
  local spr = CCSprite:create("images/public/clarity05.png")
  if spr then
    self.sprSelect:setDisplayFrame(spr:displayFrame())
    self.sprTarget:setDisplayFrame(spr:displayFrame())
    Logic:Get("HeroCardInfo"):ClearShanCard(self.sprSelect)
    Logic:Get("HeroCardInfo"):ClearShanCard(self.sprTarget)
  end
  self.costMoney:setString("")
  self.costMoney:setColor(ccc3(0, 255, 0))
  self.ttfCost:setString("")
  self.ttfMoney2:setString("")
  self.ttfMoney2:setColor(ccc3(0, 255, 0))
  self.ttfCost2:setString("")
  self.imgAdd2:setVisible(false)
end
function prototype:onSwapSuccess()
  local runningScene = SceneHelper:getRootLayer()
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/uiyxsj", runningScene, nil, 1)
  local spr = CCSprite:create("images/Effect/UIhl/xj.png")
  self.ani:GetChild("imgLevelTip"):setDisplayFrame(spr:displayFrame())
  self.ani:GetChild("imgLevelTip"):setAnchorPoint(CCPoint(0.5, 0.5))
  self.ani:GetChild("imgLevelTip"):setVisible(false)
  self.ani:GetChild("staLevel"):setVisible(false)
  self.ani:GetChild("imgAttackTip"):setVisible(false)
  self.ani:GetChild("staAttack"):setVisible(false)
  self.ani:GetChild("imgLifeTip"):setVisible(false)
  self.ani:GetChild("staLife"):setVisible(false)
  self.ani:GetChild("imgBg1"):setVisible(false)
  self.ani:GetChild("imgBg2"):setVisible(false)
  self.ani:GetChild("imgBg3"):setVisible(false)
  self.ani:GetChild("btnClose"):setEnabled(false)
  self.ani:SetCloseCallback(self, self.onBtnCloseAni)
  Logic:Get("BGSound"):SwitchMusic("audio/up.mp3", false)
  self.ani:SetWaitSignByDefaultAniName(function()
    self:aniFrontEnd()
  end, 5000)
  local selectCard = Logic:Get("Compose"):GetSelectCard()
  local targetCard = Logic:Get("Compose"):GetTargetCard()
  self:setAniCardItem(selectCard.baseId, "imgIn", true)
  self:setAniCardItem(targetCard.baseId, "imgOut", true)
  for i = 1, 6 do
    local str = string.format("imgHero%d", i)
    local node = self.ani:GetChild(str)
    if node then
      node:setVisible(false)
    end
  end
  self.ani:RunAnimationWithoutWait(nil, nil, bind(self.aniEnd, self))
end
function prototype:setAniCardItem(baseId, aniItem, IsBig)
  local cardNode = Logic:Get("HeroCardInfo"):createHeroCardForByFight(baseId)
  local texture, textureRect = 0, 0
  if IsBig then
    texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(cardNode, cardNode:getContentSize())
  else
    texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(cardNode, self.ani:GetChild(aniItem):getContentSize())
  end
  self.ani:GetChild(aniItem):setTexture(texture)
  self.ani:GetChild(aniItem):setTextureRect(textureRect)
end
function prototype:onBtnCloseAni()
  self.ani:RemoveAnimation()
  Logic:Get("BGSound"):stopAllEffect()
  Logic:Get("BGSound"):PlayBGMusic()
  Logic:Get("Compose"):SetSelectCard(nil)
  Logic:Get("Compose"):SetTargetCard(nil)
  self:onSelectCard()
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
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("Hero", self.rootNode)
end
function prototype:onBtnChange(sender, event)
  local selectCard = Logic:Get("Compose"):GetSelectCard()
  local targetCard = Logic:Get("Compose"):GetTargetCard()
  if not selectCard or not targetCard then
    return
  end
  local fra, cost = Logic:Get("Compose"):GetChangeCost()
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  local rec = KFDBGetRecord("ConfigValue", "ITEM:SWAP_COST_FRAGMENT_TYPES")
  local currencyType = json.decode(rec.content or "[]")
  local fraMoney = wallet[string.lower(currencyType[1])]
  if fra > fraMoney then
    Prompt:Fail(TwGetStr(105582))
    return
  end
  rec = KFDBGetRecord("ConfigValue", "ITEM:SWAP_COST_TYPES")
  currencyType = json.decode(rec.content or "[]")
  local otherMoney
  if currencyType[1] == "GOLD" or currencyType[1] == "INTER" or currencyType[1] == "GIFT" then
    otherMoney = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  else
    otherMoney = wallet[string.lower(currencyType[1] or "COPPER")]
  end
  if cost > otherMoney then
    if currencyType[1] == "GOLD" or currencyType[1] == "INTER" or currencyType[1] == "GIFT" then
      Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
      Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    else
      local currencyName = Logic.Reward.CURRENCY_TYPE_NAME[Logic.Reward.CURRENCY_TYPE[currencyType[1] or "COPPER"]]
      Prompt:Fail(TwGetStr(105762, TwGetStr(currencyName)))
    end
    return
  end
  Logic:Get("Compose"):PostSwap()
end
function prototype:onBtnSelect(sender, event)
  SceneHelper:pushScene("HeroTransSelect", self.rootNode)
end
function prototype:onBtnTarget(sender, event)
  local selectCard = Logic:Get("Compose"):GetSelectCard()
  if selectCard then
    SceneHelper:pushScene("HeroTransTarget", self.rootNode)
  end
end
