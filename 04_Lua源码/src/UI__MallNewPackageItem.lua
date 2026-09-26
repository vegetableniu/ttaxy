module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local CLARITY_PATH = "images/public/clarity05.png"
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfDiscount:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLock2:setStyle(kCCLabelTTFStyleOutline)
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
  self.ttfDiscount:setString(TwGetStr(105282, self.data.cost))
  local tabShowType = self.data.showTypes
  local tabShowId = self.data.showIds
  self:createCardImg(tabShowType, tabShowId)
  for i, v in ipairs(self.data.counts) do
    local param = string.format("ttfNum%d", i)
    if self[param] then
      self[param]:setString(v)
    end
  end
  local curId = Logic:Get("CheapBuy"):getCurId()
  local charge = Logic:Get("CheapBuy"):getCharge()
  if self.data.canBuy then
    self.nodBtn:setVisible(true)
    if self.data.charge > 0 and charge < self.data.charge then
      self.nodBtn:setVisible(false)
      self.sprHasBuy:setVisible(false)
      self.ttfLock2:setString(TwGetStr(108605, self.data.charge))
    end
    local playerLevel = Logic:Get("PlayerInfo"):GetPlayerLevel()
    if playerLevel < self.data.level then
      self.nodBtn:setVisible(false)
      self.sprHasBuy:setVisible(false)
      self.ttfLock2:setString(TwGetStr(108602, self.data.level))
    end
    return
  end
  if self.data.hasBuy then
    self.sprHasBuy:setVisible(true)
  else
    self.nodBtn:setVisible(false)
    self.sprHasBuy:setVisible(false)
    local giftName = Logic:Get("CheapBuy"):lastGiftName(self.data.id)
    if self.data.charge <= 0 then
      self.ttfLock:setString(TwGetStr(108601, giftName))
      self.ttfLock:setPosition(ccp(451, 99))
      return
    end
    self.ttfLock:setString(TwGetStr(108603, giftName, TwGetStr(108604), TwGetStr(108607, self.data.charge)))
    self.ttfLock:setPosition(ccp(470, 99))
  end
end
function prototype:Clear()
  self.ttfLock:setString("")
  self.ttfLock2:setString("")
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
  self.nodBtn:setVisible(false)
  self.sprHasBuy:setVisible(false)
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
  local data = Logic:Get("Mall"):getCheapBuyInfo()
  if Logic:Get("Mall"):IsOverTimeByData(data) then
    Prompt:Fail(TwGetStr(105539))
    return
  end
  local charge = Logic:Get("CheapBuy"):getCharge()
  if self.data.charge > 0 and charge < self.data.charge then
    Prompt:Fail(TwGetStr(108606))
    return
  end
  local money = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if money < self.data.cost then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  Prompt:Confirm(self, "", TwGetStr(105283, self.data.cost or 0), self.onConfirmBuy, Prompt.PROMPT_TYPE.SELECT)
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
    return
  end
  if self.data.showTypes[idx] == "TALISMAN" then
    Logic:Get("HeroCardInfo"):OpenTailsmanByID(self.data.showIds[idx])
  end
end
function prototype:onConfirmBuy()
  Logic:Get("CheapBuy"):PostBuyGoods(self.data.id)
end
