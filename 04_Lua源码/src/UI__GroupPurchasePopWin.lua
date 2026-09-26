module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local CLARITY_PATH = "images/public/clarity05.png"
local DEFAULT_BG = "images/public/herobg.png"
function prototype:onEnter()
  self.orgPrice:setStyle(kCCLabelTTFStyleOutline)
  self.groupPrice:setStyle(kCCLabelTTFStyleOutline)
  for i = 1, 5 do
    local param = string.format("ttfCount%d", i)
    if self[param] then
      self[param]:setStyle(kCCLabelTTFStyleOutline)
    end
  end
  Logic:Get("GroupPurchase"):On(Logic.GroupPurchase.EVT.BUY_GOOD_OK, self:Event("refreshBtnState"))
  self.rewards = Logic:Get("GroupPurchase"):getChooseDetails()
  self.orgPrice:setString(TwGetStr(111051, self.rewards.original or 0))
  self.groupPrice:setString(TwGetStr(111052, self.rewards.now or 0))
  self:refreshRewardInfo()
  if self.rewards then
    local hasBuy = Logic:Get("GroupPurchase"):hasBuy(self.rewards.id)
    self.btnBuy:setEnabled(not hasBuy)
  end
end
function prototype:refreshBtnState()
  self.btnBuy:setEnabled(false)
end
function prototype:onBuyBtnClicked(sender, event)
  if not self.btnBuy:isEnabled() then
    return
  end
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  local xianyu = wallet.gift + wallet.inter + wallet.gold
  if xianyu < self.rewards.now then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  Logic:Get("SureConfirm").btnText.ok = TwGetStr(105219)
  Prompt:Confirm(self, "", TwGetStr(111049, self.rewards.now), self.buyGoods, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onCloseBtnClicked(sender, event)
  SceneHelper:popScene()
end
function prototype:buyGoods()
  Logic:Get("GroupPurchase"):PostBuyGoods(self.rewards.id)
end
function prototype:createCardImg(tabShowType, tabShowId)
  if not table.empty(tabShowType or {}) then
  elseif table.empty(tabShowId or {}) then
    return
  end
  for i = 1, 5 do
    local bgStr = string.format("img%d", i)
    local iconStr = string.format("imgBg%d", i)
    local data = {}
    if tabShowType[i] and tabShowId[i] and self[bgStr] and self[iconStr] then
      data.showId = tabShowId[i] or 1
      data.showType = tabShowType[i] or "OTHER"
      self:createImg(data, self[iconStr], self[bgStr])
    end
  end
end
function prototype:createImg(giftInfo, bgNode, IconNode)
  local spr = Logic:Get("Gift"):createImg(giftInfo)
  if spr ~= nil then
    bgNode:setDisplayFrame(spr:displayFrame())
    local strGoods = Logic:Get("Gift"):createGoodsImg(giftInfo)
    if strGoods ~= nil then
      local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(strGoods)
      IconNode:setTexture(texture)
      IconNode:setTextureRect(textureRect)
    end
  end
end
function prototype:refreshRewardInfo()
  self:clear()
  self:createCardImg(self.rewards.goodsShowTypeId, self.rewards.goodsShowIds)
  for i = 1, 5 do
    local param = string.format("ttfCount%d", i)
    if self[param] then
      self[param]:setString(self.rewards.goodsShowCounts[i] or "")
    end
  end
end
function prototype:clear()
  local spr = CCSprite:create(CLARITY_PATH)
  local bgSpr = CCSprite:create(DEFAULT_BG)
  if not spr or not bgSpr then
    return
  end
  for i = 1, 5 do
    local strBg = string.format("imgBg%d", i)
    local str = string.format("img%d", i)
    if self[strBg] then
      self[strBg]:setDisplayFrame(bgSpr:displayFrame())
    end
    if self[str] then
      self[str]:setDisplayFrame(spr:displayFrame())
    end
  end
end
function prototype:onBtn1Clicked(sender, event)
  self:showHeroInfo(1)
end
function prototype:onBtn2Clicked(sender, event)
  self:showHeroInfo(2)
end
function prototype:onBtn3Clicked(sender, event)
  self:showHeroInfo(3)
end
function prototype:onBtn4Clicked(sender, event)
  self:showHeroInfo(4)
end
function prototype:onBtn5Clicked(sender, event)
  self:showHeroInfo(5)
end
function prototype:showHeroInfo(index)
  if self.rewards == nil or self.rewards.goodsShowIds == nil or table.empty(self.rewards) or index > #self.rewards.goodsShowIds then
    return
  end
  local goodsId = tonumber(self.rewards.goodsShowIds[index])
  if self.rewards.goodsShowTypeId[index] == "HERO" then
    Logic:Get("HeroCardInfo"):PromptHeroInfoById(goodsId)
  elseif self.rewards.goodsShowTypeId[index] == "FRAGMENT" then
    local fraConfig = Logic:Get("Compose"):kdbItemConfig(goodsId)
    if fraConfig ~= nil then
      Logic:Get("HeroCardInfo"):PromptHeroInfoById(fraConfig.baseId)
    end
  elseif self.rewards.goodsShowTypeId[index] == "TALISMAN" then
    Logic:Get("HeroCardInfo"):OpenTailsmanByID(goodsId)
  end
end
