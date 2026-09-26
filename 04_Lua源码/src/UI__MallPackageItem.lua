module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local CLARITY_PATH = "images/public/clarity05.png"
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfPrice:setStyle(kCCLabelTTFStyleOutline)
  self.ttfDiscount:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTip:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLock:setStyle(kCCLabelTTFStyleOutline)
  for i = 1, 3 do
    local param = string.format("ttfNum%d", i)
    if self[param] then
      self[param]:setStyle(kCCLabelTTFStyleOutline)
    end
  end
end
function prototype:Refrash(data)
  if data == nil then
    return
  end
  self.data = data
  self:Clear()
  self.ttfName:setString(data.name or "")
  local buyTimes = Logic:Get("PlayerInfo"):GetBetaBuyTimeById(self.data.id)
  local fullPriceIdx = buyTimes + 1
  if fullPriceIdx > #self.data.fullPrice then
    fullPriceIdx = #self.data.fullPrice or fullPriceIdx
  end
  self.ttfPrice:setString(TwGetStr(105281, self.data.fullPrice[fullPriceIdx] or 0))
  local priceIdx = buyTimes + 1
  if priceIdx > #self.data.price then
    priceIdx = #self.data.price or priceIdx
  end
  self.ttfDiscount:setString(TwGetStr(105282, self.data.price[priceIdx]))
  local tabShowType = self.data.showTypes
  local tabShowId = self.data.showIds
  self:createCardImg(tabShowType, tabShowId)
  for i, v in ipairs(self.data.counts) do
    local param = string.format("ttfNum%d", i)
    if self[param] then
      self[param]:setString(v)
    end
  end
  self.nodBtn:setVisible(buyTimes < data.limit)
  self.sprHasBuy:setVisible(not (buyTimes < data.limit))
  if Logic:Get("PlayerInfo"):IsNeedShowAniById(self.data.id) then
    local idx = self:GetMystCardIdx(self.data.showTypes)
    if idx > 0 then
      local color = Logic:Get("Lottery"):GetHeroRankColor3(self.data.showIds[idx])
      self.ttfTip:setColor(color)
    end
  end
  self.ttfTip:setString(data.desc or "")
  if Logic:Get("Lock"):checkStatusById(self.data.lockKey) then
    self.nodBtn:setVisible(false)
    self.sprHasBuy:setVisible(false)
    local level, battle = Logic:Get("Lock"):GetLevelAndBattleNames(self.data.lockKey)
    self.ttfLock:setString(TwGetStr(105402, level))
    self.ttfTip:setColor(ccc3(255, 255, 255))
  end
end
function prototype:Clear()
  self.ttfTip:setString("")
  local spr = CCSprite:create(CLARITY_PATH)
  if spr == nil then
    return
  end
  for i = 1, 3 do
    local iconStr = string.format("sprCard%d", i)
    local bgStr = string.format("sprBg%d", i)
    if self[bgStr] then
      self[bgStr]:setDisplayFrame(spr:displayFrame())
      Logic:Get("HeroCardInfo"):ClearShanCardSmall(self[bgStr])
    end
    if self[iconStr] then
      self[iconStr]:setDisplayFrame(spr:displayFrame())
    end
  end
  for i = 1, 3 do
    local param = string.format("ttfNum%d", i)
    if self[param] then
      self[param]:setString("")
    end
  end
  self.nodBtn:setVisible(true)
  self.sprHasBuy:setVisible(true)
  self.ttfLock:setString("")
end
function prototype:createCardImg(tabShowType, tabShowId)
  if not table.empty(tabShowType or {}) then
  elseif table.empty(tabShowId or {}) then
    return
  end
  for i = 1, 3 do
    local bgStr = string.format("sprCard%d", i)
    local iconStr = string.format("sprBg%d", i)
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
  Logic:Get("HeroCardInfo"):AddShanCardSmall(bgNode, giftInfo.showId)
end
function prototype:GetMystCardIdx(showTypes)
  for k, v in pairs(showTypes or {}) do
    if v == "MYSTCARD" then
      return k
    end
  end
  return 0
end
function prototype:onBtnBuy(sender, event)
  local data = Logic:Get("Mall"):GetOpenBetaData()
  if Logic:Get("Mall"):IsOverTimeByData(data) then
    Prompt:Fail(TwGetStr(105539))
    return
  end
  local buyTimes = Logic:Get("PlayerInfo"):GetBetaBuyTimeById(self.data.id)
  local priceIdx = buyTimes + 1
  if priceIdx > #self.data.price then
    priceIdx = #self.data.price or priceIdx
  end
  local money = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if money < self.data.price[priceIdx] then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  local buyTimes = Logic:Get("PlayerInfo"):GetBetaBuyTimeById(self.data.id)
  local priceIdx = buyTimes + 1
  if priceIdx > #self.data.price then
    priceIdx = #self.data.price or priceIdx
  end
  Prompt:Confirm(self, "", TwGetStr(105283, self.data.price[priceIdx] or 0), self.onConfirmBuy, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onBtnHero(sender, event)
  local idx = 0
  for i = 1, 3 do
    local str = string.format("btnHero%d", i)
    if sender == self[str] then
      idx = i
      break
    end
  end
  if self.data.showTypes[idx] == "HERO" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.data.showIds[idx])
    return
  end
  if self.data.showTypes[idx] == "FRAGMENT" then
    local fraConfig = Logic:Get("Compose"):kdbItemConfig(self.data.showIds[idx])
    if fraConfig ~= nil then
      Logic:Get("HeroCardInfo"):OpenHeroInfoById(fraConfig.baseId)
    end
  end
end
function prototype:onConfirmBuy()
  Logic:Get("PlayerInfo"):PostBuyOpenBetaGoods(self.data.id)
end
