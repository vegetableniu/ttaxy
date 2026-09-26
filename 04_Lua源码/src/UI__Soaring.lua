module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onEnter()
  super.onEnter(self)
  self.aniInfo = {}
  self.btnBegin:setEnabled(false)
  self.costMoneyTitle:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCurrLevel:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCurrLife:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCurrAttack:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCurrLeadership:setStyle(kCCLabelTTFStyleOutline)
  self.ttfNewLevel:setStyle(kCCLabelTTFStyleOutline)
  self.ttfNewLife:setStyle(kCCLabelTTFStyleOutline)
  self.ttfNewAttack:setStyle(kCCLabelTTFStyleOutline)
  self.ttfNewLeadership:setStyle(kCCLabelTTFStyleOutline)
  self.imgArrowHead:setVisible(false)
  Logic:Get("Soaring"):createSameIdMap()
  Logic:Get("Soaring"):On(Logic.Soaring.EVT.SELECTED_CARD, self:Event("onSelectCard"))
  Logic:Get("Soaring"):On(Logic.Soaring.EVT.SOARING_SUCCESSED, self:Event("onSoaringSuccessed"))
end
function prototype:onExit()
  Logic:Get("Soaring"):setSelectedCard({})
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("Home", self.rootNode)
end
function prototype:onBtnSelectHero(sender, event)
  SceneHelper:pushScene("SoaringSelect", self.rootNode)
end
function prototype:onBtnRight(sender, event)
  local selectedInfo = Logic:Get("Soaring"):getSelectedCard()
  if table.empty(selectedInfo) then
    return
  end
  local rightInfo = self:getSoaringId(selectedInfo.baseId)
  Logic:Get("HeroCardInfo"):OpenHeroInfoById(rightInfo.code)
end
function prototype:onBtnBegin(sender, event)
  local selectedInfo = Logic:Get("Soaring"):getSelectedCard()
  local result = Logic:Get("Soaring"):canSoaring(selectedInfo)
  local moneyType = Logic.Reward.CURRENCY_CODE[self.currencyCode]
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  local money = wallet[string.lower(moneyType)]
  if money < self.currencyCost then
    local currencyName = Logic.Reward.CURRENCY_TYPE_NAME[self.currencyCode]
    Prompt:Fail(TwGetStr(105762, TwGetStr(currencyName)))
    return
  end
  if result == Logic.Soaring.METRIAL_RESULT.LEVEL_NOT_ENOUGH then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(100061)
    Prompt:Confirm(self, nil, self:getErroStr(1035), self.onLevelUp, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  if result == Logic.Soaring.METRIAL_RESULT.METRIAL_NOT_ENOUGH then
    Prompt:Fail(self:getErroStr(1035))
    return
  end
  if result == Logic.Soaring.METRIAL_RESULT.ENOUGH then
    SceneHelper:pushScene("SoaringConfirm", self.rootNode)
  end
end
function prototype:getErroStr(settingId)
  local rec = KFDBGetRecord("LanguageSetting", settingId or 0) or {}
  local str = ReplaceStringTab(rec.content or "")
  return str
end
function prototype:onLevelUp()
  SceneHelper:runWithScene("HeroUpgrade", self.rootNode)
end
function prototype:clearInfo()
  self.leftCardTag = 1
  self.rightCardTag = 2
  self.layer:removeChildByTag(self.leftCardTag, true)
  self.layer:removeChildByTag(self.rightCardTag, true)
  self.btnBegin:setEnabled(false)
  self.ttfCurrLevel:setString("")
  self.ttfCurrLife:setString("")
  self.ttfCurrAttack:setString("")
  self.ttfCurrLeadership:setString("")
  self.ttfNewLevel:setString("")
  self.ttfNewLife:setString("")
  self.ttfNewAttack:setString("")
  self.ttfNewLeadership:setString("")
  self.costMoneyTitle:setString("")
  local ccbs = list.map(function(index)
    return self["ccbCard" .. index]
  end, table.indices(list.rep({0}, 5)))
  for i, ccb in ipairs(ccbs) do
    ccb:setInitInfo()
  end
end
function prototype:getSoaringId(costRankId)
  local rec = KFDBGetRecord("HeroCostRankUp", costRankId or 0)
  if table.empty(rec or {}) then
    return
  end
  local rewardInfo = KFDBGetRecord("RewardConfig", rec.rewardId or 0) or {}
  if table.empty(rewardInfo) then
    log4temp:warn("rewardInfo not found, id:" .. rec.rewardId)
  end
  return json.decode(rewardInfo.fixed or "[]")[1] or {}
end
function prototype:onSelectCard()
  self.leftCardTag = 1
  self.rightCardTag = 2
  self.layer:removeChildByTag(self.leftCardTag, true)
  self.layer:removeChildByTag(self.rightCardTag, true)
  local selectedInfo = Logic:Get("Soaring"):getSelectedCard()
  if table.empty(selectedInfo) then
    self.imgArrowHead:setVisible(false)
    self.btnBegin:setEnabled(false)
    return
  end
  self.btnBegin:setEnabled(true)
  self.imgArrowHead:setVisible(true)
  local rightInfo = self:getSoaringId(selectedInfo.baseId)
  if table.empty(rightInfo) then
    return
  end
  local leftcard = Logic:Get("HeroCardInfo"):createHeroCard(selectedInfo.baseId, 200)
  local rightcard = Logic:Get("HeroCardInfo"):createHeroCard(rightInfo.code, 200)
  local cardTable = {}
  cardTable.imgIn = selectedInfo.baseId
  cardTable.imgOut = rightInfo.code
  self.aniInfo.card = cardTable
  leftcard:setAnchorPoint(CCPoint(0.5, 0.5))
  rightcard:setAnchorPoint(CCPoint(0.5, 0.5))
  self.layer:addChild(leftcard, 0, self.leftCardTag)
  self.layer:addChild(rightcard, 0, self.rightCardTag)
  leftcard:setPosition(self.btnSelecthero:getPosition())
  rightcard:setPosition(self.btnright:getPosition())
  self:setHeroInfo()
  self:refreshCost()
  self:refreshMetrial()
end
function prototype:setHeroInfo()
  local selectedInfo = Logic:Get("Soaring"):getSelectedCard()
  local rightInfo = self:getSoaringId(selectedInfo.baseId)
  local metrial = Logic:Get("Soaring"):getMetrialById(selectedInfo.baseId)
  local leftHeroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(selectedInfo.baseId)
  local rightHeroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(rightInfo.code)
  local lLife, lAttack = Logic:Get("Hero"):GetHeroLifeAndAttack(selectedInfo.baseId, selectedInfo.level)
  local rLife, rAttack = Logic:Get("Hero"):GetHeroLifeAndAttack(rightHeroInfo.id, 1)
  local minLevel = metrial[leftHeroInfo.sameNameId].minLevel
  local color = minLevel <= selectedInfo.level and ccc3(0, 255, 0) or ccc3(255, 0, 0)
  self.ttfCurrLevel:setString(selectedInfo.level .. "/" .. leftHeroInfo.level)
  self.ttfCurrLevel:setColor(color)
  self.ttfCurrLife:setString(lLife or "")
  self.ttfCurrAttack:setString(lAttack or "")
  self.ttfCurrLeadership:setString(leftHeroInfo.leadership)
  self.ttfNewLevel:setString(1 .. "/" .. rightHeroInfo.level)
  self.ttfNewLife:setString(rLife or "")
  self.ttfNewAttack:setString(rAttack or "")
  self.ttfNewLeadership:setString(rightHeroInfo.leadership)
end
function prototype:refreshCost()
  local selectedInfo = Logic:Get("Soaring"):getSelectedCard()
  local rec = KFDBGetRecord("HeroCostRankUp", selectedInfo.baseId or 0) or {}
  local cost = json.decode(rec.costItems or "[]")
  local logic = require("Reward")
  self.currencyCode = cost[1].code
  self.currencyCost = cost[1].amount
  local currencyName = logic.CURRENCY_TYPE_NAME[cost[1].code]
  self.costMoneyTitle:setString(TwGetStr(103202, TwGetStr(currencyName)) .. cost[1].amount)
end
function prototype:refreshMetrial()
  local selectedInfo = Logic:Get("Soaring"):getSelectedCard()
  local metrial = Logic:Get("Soaring"):getMetrialById(selectedInfo.baseId)
  local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(selectedInfo.baseId)
  metrial[heroInfo.sameNameId] = nil
  local metriallist = {}
  for k, v in pairs(metrial) do
    table.insert(metriallist, v)
  end
  local ccbs = list.map(function(index)
    return self["ccbCard" .. index]
  end, table.indices(list.rep({0}, 5)))
  for i, ccb in ipairs(ccbs) do
    self["HeroNotEnough" .. i]:setStyle(kCCLabelTTFStyleOutline)
    self["HeroNotEnough" .. i]:setString("")
    if metriallist[i] then
      local data = {}
      data.showType = "HERO"
      data.showId = metriallist[i].baseId
      local currCnt = #metriallist[i].list
      data.amount = currCnt .. "/" .. metriallist[i].amount
      ccb:ReFreshByGift(data)
      local isNotEnough = metriallist[i].amount > #metriallist[i].list
      local str = isNotEnough and TwGetStr(104265) or ""
      local color = isNotEnough and ccc3(255, 0, 0) or ccc3(0, 255, 0)
      ccb:setTtfColor(color)
      self["HeroNotEnough" .. i]:setString(str)
    else
      ccb:setInitInfo()
    end
  end
end
function prototype:onSoaringSuccessed()
  self:clearInfo()
  local runningScene = SceneHelper:getRootLayer()
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/uiyxsj", runningScene, nil, 1)
  self.ani:GetChild("imgLevelTip"):setVisible(false)
  self.ani:GetChild("staLevel"):setVisible(false)
  self.ani:GetChild("imgAttackTip"):setVisible(false)
  self.ani:GetChild("staAttack"):setVisible(false)
  self.ani:GetChild("imgLifeTip"):setVisible(false)
  self.ani:GetChild("staLife"):setVisible(false)
  self.ani:GetChild("imgBg1"):setVisible(false)
  self.ani:GetChild("imgBg2"):setVisible(false)
  self.ani:GetChild("imgBg3"):setVisible(false)
  self:setAniCard()
  self.ani:SetCloseCallback(self, self.onBtnCloseAni)
  self.ani:GetChild("btnClose"):setEnabled(false)
  Logic:Get("BGSound"):SwitchMusic("audio/up.mp3", false)
  self.ani:SetWaitSignByDefaultAniName(function()
    self.ani:GetChild("imgGai"):setVisible(false)
    self.ani:GetChild("imgBody"):setVisible(false)
    self.ani:GetChild("ttfTip"):setString(TwGetStr(115460))
    self.ani:GetChild("ricTip"):setString(self:getSuccessStr())
    self:aniFrontEnd()
  end, 5000)
  self.ani:RunAnimationWithoutWait()
end
function prototype:getSuccessStr()
  local str = ""
  local _, inCardColor = Logic:Get("Gift"):GetColorByGift({
    showType = "HERO",
    showId = self.aniInfo.card.imgIn
  })
  local _, outCardColor = Logic:Get("Gift"):GetColorByGift({
    showType = "HERO",
    showId = self.aniInfo.card.imgOut
  })
  local inCardInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(self.aniInfo.card.imgIn)
  local outCardInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(self.aniInfo.card.imgOut)
  str = TwGetStr(115461, inCardColor, inCardInfo.name, outCardColor, outCardInfo.name)
  return str
end
function prototype:setAniCard()
  self:setAniCardItem(self.aniInfo.card.imgIn, "imgIn", true)
  self:setAniCardItem(self.aniInfo.card.imgOut, "imgOut", true)
  local costMetrial = Logic:Get("Soaring"):getCostMetrials()
  local MAX_IMAGE_COUNT = 6
  for i = 1, MAX_IMAGE_COUNT do
    if costMetrial[i] then
      self:setAniCardItem(costMetrial[i], "imgHero" .. i, false)
    else
      self.ani:GetChild("imgHero" .. i):setVisible(false)
    end
  end
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
function prototype:onBtnCloseAni()
  self.ani:RemoveAnimation()
  Logic:Get("BGSound"):stopAllEffect()
  Logic:Get("BGSound"):PlayBGMusic()
end
