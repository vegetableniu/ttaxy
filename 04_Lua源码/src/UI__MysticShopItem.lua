module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local RET = Enum({"OK", "CANCEL"})
local REWARDS_TYPE = TypeDef("com.eyu.mt.module.reward.model.RewardType")
function prototype:onEnter()
  self.ttfGift:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCost:setStyle(kCCLabelTTFStyleOutline)
  self.ttfGold:setStyle(kCCLabelTTFStyleOutline)
  self.ttfSell:setStyle(kCCLabelTTFStyleOutline)
  self.ttfNum:setStyle(kCCLabelTTFStyleOutline)
  self.ttfSell:setString(TwGetStr(111138))
end
function prototype:refresh(pos, id)
  if not pos or not id then
    return
  end
  self.pos = pos
  local rec = Logic:Get("MysticShop"):GetRewardFromXls(id)
  if not rec or table.empty(rec) then
    return
  end
  local giftConfig = {
    showType = rec.showType,
    showId = rec.showId
  }
  self.baseId = rec.showId
  self.type = rec.showType
  self.showId = rec.showId
  self:refreshImage(giftConfig)
  self.gift = rec.name or ""
  self.amount = tonumber(rec.amount) or 0
  self.ttfGift:setString(rec.name or "")
  self.ttfNum:setString(rec.amount or "")
  self.ttfCost:setString(rec.cost or 0)
  self.cost = rec.cost or 0
  local color = Logic:Get("Armor"):getColorByBaseId(rec.showId)
  self.ttfGift:setColor(color)
  local hasExchanged = false
  local exchangedList = Logic:Get("MysticShop"):GetExchangedResult()
  for _, v in ipairs(exchangedList) do
    if v == pos then
      hasExchanged = true
      break
    end
  end
  self.sprBuy:setVisible(hasExchanged)
  self.btnExchanged:setVisible(not hasExchanged)
  self.sprExchanged:setVisible(not hasExchanged)
end
function prototype:refreshImage(giftConfig)
  local sprBg = Logic:Get("Gift"):createImg(giftConfig)
  if sprBg then
    self.sprBg:setDisplayFrame(sprBg:displayFrame())
  end
  local visible = giftConfig.showType == "EQUIPMENT_MATERIAL"
  self.sprPlus:setVisible(not visible)
  self.sprFra:setVisible(not visible)
  if giftConfig.showType == "EQUIPMENT_MATERIAL" then
    local reward = {code = 0}
    local map = Logic:Get("Reward"):createMap(reward)
    local showType = map[REWARDS_TYPE[giftConfig.showType]].showType
    giftConfig.showType = showType[giftConfig.showId + 1]
  end
  local sprIcon = Logic:Get("Gift"):createGoodsImg(giftConfig)
  if sprIcon then
    self.sprIcon:setDisplayFrame(sprIcon:displayFrame())
  end
  if giftConfig.showType == "EQUIPMENT_FRAGMENT" then
    local sprFra = Logic:Get("Compose"):GetJigsawImg()
    if sprFra then
      self.sprFra:setDisplayFrame(sprFra:displayFrame())
    end
  else
    local sprClarity = CCSprite:create("images/public/clarity05.png")
    if sprClarity then
      self.sprFra:setDisplayFrame(sprClarity:displayFrame())
    end
  end
  local rec = Logic:Get("Armor"):getArmorInfoByBaseId(self.baseId) or {}
  if rec.star and 0 < rec.star then
    self.sprPlus:setVisible(true)
    local path = string.format("images/Equip/%d.png", rec.star)
    local spr = CCSprite:create(path)
    if spr then
      self.sprPlus:setDisplayFrame(spr:displayFrame())
    end
  end
end
function prototype:onBtnItem(sender, event)
end
function prototype:onBtnIcon(sender, event)
  if not self.type then
    return
  end
  if self.type == "HERO" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.baseId)
  elseif self.type == "FRAGMENT" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.baseId, true)
  elseif self.type == "EQUIPMENT" then
    Logic:Get("Armor"):openArmorDetails(self.baseId)
  elseif self.type == "EQUIPMENT_FRAGMENT" then
    Logic:Get("Armor"):openArmorDetails(self.baseId, true)
  elseif self.type == "EQUIPMENT_MATERIAL" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.showId + 802)
  end
end
function prototype:onBtnExchange(sender, event)
  local isOld = Logic:Get("MysticShop"):GetIsOld()
  if isOld then
    Prompt:Confirm(self, "", 111256, function()
      Logic:Get("MysticShop"):PostLoadShop()
    end)
    return
  end
  local function comfirmExchage(self, ret)
    if ret == RET.OK then
      Logic:Get("MysticShop"):PostExchange(self.pos)
    end
  end
  local currency = Logic:Get("MysticShop"):GetCurrency()
  if currency < self.cost then
    Prompt:Confirm(self, "", 111133)
    return
  end
  local info = TwGetStr(111131, self.cost, self.amount, self.gift)
  Prompt:Select(self, "", info, comfirmExchage)
end
