module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local CLARITY_PATH = "images/public/clarity05.png"
local IMG = {
  "images/Mall/sellOut.png",
  "images/Mall/overLimit.png"
}
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfDiscount:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLimit1:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLimit2:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTime:setStyle(kCCLabelTTFStyleOutline)
  self.ttfPrice:setStyle(kCCLabelTTFStyleOutline)
  self.ttfNum:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLock:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:Refrash(data)
  if data == nil then
    return
  end
  self.data = data
  self:Clear()
  self:setName()
  self.ttfDiscount:setString(TwGetStr(105246, self.data.goodInfo.original))
  self.ttfPrice:setString(TwGetStr(105246, self.data.goodInfo.cost))
  self:createCardImg(self.data.goodInfo.showType, self.data.goodInfo.showId)
  self.ttfNum:setString(self.data.goodInfo.count)
  if self.eventTracer:Exist("onRefreshTime") then
    self.eventTracer:Cancel("onRefreshTime")
  end
  if self.data.canBuy then
    if not self.eventTracer:Exist("onRefreshTime") then
      Singleton(Timer):Repeat(1000, self:Event("onRefreshTime"))
    end
    self:onRefreshTime()
  else
    local tabStart = Logic:Get("System"):GetTimeDate(self.data.goodInfo.start)
    local tabEnd = Logic:Get("System"):GetTimeDate(self.data.goodInfo.endTime)
    self.strTime = TwGetStr(102003, tabStart.hour, tabStart.min) .. "-" .. TwGetStr(102003, tabEnd.hour, tabEnd.min)
    self.ttfTime:setString(TwGetStr(108620, self.strTime))
  end
  local isLimit = false
  local isSaleAll = false
  if self.data.goodList.buyCount >= self.data.goodInfo.single and self.data.goodInfo.single > 0 then
    isLimit = true
  end
  if 0 >= self.data.goodList.totalLeft then
    isSaleAll = true
  end
  if isLimit or isSaleAll then
    self.nodBtn:setVisible(false)
  else
    self.sprHasBuy:setVisible(false)
  end
  if isLimit then
    self:setImg(2)
  end
  if self.data.goodList.buyCount >= 0 then
    self.ttfLimit2:setString(TwGetStr(108623, self.data.goodInfo.single))
  end
  if 0 < self.data.goodList.totalLeft then
    self.ttfLimit1:setString(TwGetStr(108622, self.data.goodList.totalLeft))
  else
    self.ttfLimit1:setString(TwGetStr(108622, 0))
    self:setImg(1)
  end
end
function prototype:Clear()
  self.ttfLimit1:setString("")
  self.ttfLimit2:setString("")
  self.ttfName:setString("")
  self.ttfDiscount:setString("")
  self.ttfPrice:setString("")
  self.ttfTime:setString("")
  self.ttfNum:setString("")
  self.ttfLock:setString("")
  local spr = CCSprite:create(CLARITY_PATH)
  if spr == nil then
    return
  end
  self.sprBg:setDisplayFrame(spr:displayFrame())
  Logic:Get("HeroCardInfo"):ClearShanCardSmall(self.sprBg)
  self.sprCard:setDisplayFrame(spr:displayFrame())
  self.nodBtn:setVisible(true)
  self.sprHasBuy:setVisible(true)
end
function prototype:setImg(index)
  local spr = CCSprite:create(IMG[index])
  if spr then
    self.sprHasBuy:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:setName()
  local color = ccc3(255, 255, 255)
  local rank = tonumber(self.data.goodInfo.showId)
  if self.data.goodInfo.showType == "TALISMAN" then
    local rec = KFDBGetRecord("TalismanSetting", rank)
    color = Logic:Get("Hero"):getColorByBaseId(rec.baseId)
  elseif self.data.goodInfo.showType == "HERO" then
    color = Logic:Get("Hero"):getColorByBaseId(rank)
  elseif self.data.goodInfo.showType == "EQUIPMENT" or self.data.goodInfo.showType == "EQUIPMENT_FRAGMENT" then
    color = Logic:Get("Armor"):getColorByBaseId(rank)
  else
    color = Logic:Get("Lottery"):GetHeroRankColor3(rank)
  end
  self.ttfName:setColor(color)
  self.ttfName:setString(self.data.goodInfo.desc or "")
end
function prototype:onRefreshTime()
  local diffTime = Logic:Get("System"):DiffTime(self.data.goodInfo.endTime)
  local starTime = Logic:Get("System"):SecToDay(diffTime)
  if starTime and diffTime > 0 then
    self.ttfTime:setString(TwGetStr(108621, TwGetStr(102008, starTime.hour, starTime.min, starTime.sec)))
  else
    self.ttfTime:setString(TwGetStr(108621, TwGetStr(102008, 0, 0, 0)))
  end
end
function prototype:createCardImg(showType, showId)
  local data = {}
  data.showId = showId
  data.showType = showType or "OTHER"
  self:createImg(data, self.sprBg, self.sprCard)
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
function prototype:onBtnBuy(sender, event)
  local data = Logic:Get("Mall"):getSuperGoodInfo()
  if Logic:Get("Mall"):IsOverTimeByData(data) then
    Prompt:Fail(TwGetStr(105539))
    return
  end
  local canBuy = Logic:Get("SuperGift"):compareTime(self.data.goodInfo.start, self.data.goodInfo.endTime)
  if not canBuy then
    Prompt:Fail(TwGetStr(108624, self.strTime))
    return
  end
  local money = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if money < self.data.goodInfo.cost then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  Logic:Get("SuperGift"):setSendGoodId(self.data.goodList.id)
  Prompt:Confirm(self, "", TwGetStr(105283, self.data.goodInfo.cost or 0), self.onConfirmBuy, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onBtnHero(sender, event)
  if self.data.goodInfo.showType == "HERO" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.data.goodInfo.showId)
    return
  end
  if self.data.goodInfo.showType == "FRAGMENT" then
    local fraConfig = Logic:Get("Compose"):kdbItemConfig(self.data.goodInfo.showId)
    if fraConfig ~= nil then
      Logic:Get("HeroCardInfo"):OpenHeroInfoById(fraConfig.baseId, true)
    end
    return
  end
  if self.data.goodInfo.showType == "TALISMAN" then
    Logic:Get("HeroCardInfo"):OpenTailsmanByID(self.data.goodInfo.showId)
  end
  if self.data.goodInfo.showType == "EQUIPMENT" or self.data.goodInfo.showType == "EQUIPMENT_FRAGMENT" then
    Logic:Get("Armor"):openArmorDetails(self.data.goodInfo.showId, self.data.goodInfo.showType == "EQUIPMENT_FRAGMENT")
  end
end
function prototype:onConfirmBuy()
  if self.data.goodInfo.mallId then
    Logic:Get("SuperGift"):PostBuyGoods(self.data.goodInfo.mallId)
  end
end
