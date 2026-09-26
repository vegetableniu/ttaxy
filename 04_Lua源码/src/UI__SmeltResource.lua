module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local CURRENCY_TYPE = Enum(TypeDef("com.eyu.mt.module.currency.model.CurrencyType"))
local coin_img_path = {
  "images/smelt/img1.png",
  "images/smelt/img2.png"
}
function prototype:onEnter()
  Logic:Get("SmeltResource"):ClearSmeltList()
  self.smeltList = {}
  self.select = false
  self.pool = 1
  self.randomCount = 0
  self.minRandomCount = 0
  self.cost = 0
  Logic:Get("SmeltResource"):setPool(1)
  self:createCoinAndDescImg()
  self:setBtnStage()
  self:initTtf()
  Logic:Get("SmeltResource"):On(Logic.SmeltResource.EVT.REFRESH_UNIT, self:Event("OnRefreshCell"))
  Logic:Get("SmeltResource"):On(Logic.SmeltResource.EVT.EXCHANGE, self:Event("OnExchange"))
end
function prototype:onExit()
  Logic:Get("SmeltResource"):ClearSmeltList()
end
function prototype:refreshCell(data)
  local data = data or {}
  for i = 1, 5 do
    local strCell = string.format("cell%d", i)
    if self[strCell] then
      self[strCell]:refresh(data[i])
    end
  end
end
function prototype:createCoinAndDescImg()
  if self.pool == 1 then
    local sprIcon = CCSprite:create(coin_img_path[1])
    if sprIcon then
      self.sprCoin:setPositionY(530)
      self.sprCoin:setDisplayFrame(sprIcon:displayFrame())
    end
    local sprDesc = CCSprite:create("images/smelt/tip2.png")
    if sprDesc then
      self.sprTip:setVisible(false)
      self.sprTip:setDisplayFrame(sprDesc:displayFrame())
    end
    return
  end
  local sprIcon = CCSprite:create(coin_img_path[2])
  if sprIcon then
    self.sprCoin:setDisplayFrame(sprIcon:displayFrame())
    self.sprCoin:setPositionY(547)
  end
  local sprDesc = CCSprite:create("images/smelt/tip4.png")
  if sprDesc then
    self.sprTip:setDisplayFrame(sprDesc:displayFrame())
  end
end
function prototype:setBtnStage()
  local path_left = {
    "images/smelt/btn_nor_left.png",
    "images/smelt/btn_sel_left.png"
  }
  local path_right = {
    "images/smelt/btn_nor_right.png",
    "images/smelt/btn_sel_right.png"
  }
  local lock = Logic:Get("Lock"):checkStatusById("RecyclePool1")
  if lock then
    self.nodeBtn1:setVisible(false)
    self.nodeBtn2:setVisible(false)
    return
  end
  lock = Logic:Get("Lock"):checkStatusById("RecyclePool2")
  if lock then
    self.nodeBtn1:setVisible(true)
    self.nodeBtn2:setVisible(false)
  end
  if self.pool == 1 then
    self.btnSmelt1:setBackgroundSpriteForState(CCScale9Sprite:create(path_left[2]), CCControlStateNormal)
    self.btnSmelt2:setBackgroundSpriteForState(CCScale9Sprite:create(path_right[1]), CCControlStateNormal)
    return
  end
  self.btnSmelt1:setBackgroundSpriteForState(CCScale9Sprite:create(path_left[1]), CCControlStateNormal)
  self.btnSmelt2:setBackgroundSpriteForState(CCScale9Sprite:create(path_right[2]), CCControlStateNormal)
end
function prototype:initTtf()
  self.ttfCount1:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCount2:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCost:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCount1:setString(0)
  self.ttfCount2:setString(0)
  self.ttfCost:setString(0)
  self.labPer1:setString("")
  self.labPer2:setString("")
end
function prototype:onBtnFastAdd(sender, event)
  local tempSmeltIds, checkList = Logic:Get("SmeltResource"):autoCheck()
  local num1 = checkList and #checkList or 0
  local num2 = self.smeltList and #self.smeltList or 0
  if num1 == 0 then
    if num2 < 5 then
      Prompt:Confirm(self, "", 108810)
    else
      Prompt:Confirm(self, "", 108811)
    end
    return
  end
  self:refreshCell(tempSmeltIds)
  Logic:Get("SmeltResource"):finalySmeltList()
  self.smeltList = tempSmeltIds
  self:refreshInfo()
end
function prototype:onBtnSmelt(sender, event)
  local smeltList = Logic:Get("SmeltResource"):GetCheckedSmeltList()
  if table.empty(smeltList) then
    Prompt:Confirm(self, "", 108819)
    return
  end
  local jade = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if self.select and jade < self.cost then
    Logic:Get("Main"):PromptCharge()
    return
  end
  local smeltHero = {}
  local smeltEquip = {}
  local smeltFabao = {}
  for k, v in pairs(smeltList) do
    local info
    info = Logic:Get("Hero"):GetHeroInfoById(v)
    if info then
      table.insert(smeltHero, v)
    else
      info = Logic:Get("Talisman"):GetTailsmansByIds(v)
      if info then
        table.insert(smeltFabao, v)
      else
        info = Logic:Get("Armor"):getArmorInfoById(v)
        if info then
          table.insert(smeltEquip, v)
        end
      end
    end
  end
  local recycleThings = {}
  recycleThings.heroIds = smeltHero
  recycleThings.equipIds = smeltEquip
  recycleThings.talismanIds = smeltFabao
  Logic:Get("SmeltResource"):PostRecycle(self.select, recycleThings, self.fixCount)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnSmeltPurple(sender, event)
  self.pool = 1
  self.select = true
  self.randomCount = 0
  self.minRandomCount = 0
  Logic:Get("SmeltResource"):setPool(1)
  Logic:Get("SmeltResource"):ClearSmeltList()
  self:refreshCell()
  self:createCoinAndDescImg()
  self:setBtnStage()
  self:onBtnSelect()
  self:setPoolCoin()
  self:initTtf()
  self.smeltList = {}
end
function prototype:onBtnSmeltOrange(sender, event)
  self.pool = 2
  self.select = true
  self.randomCount = 0
  self.minRandomCount = 0
  Logic:Get("SmeltResource"):setPool(2)
  Logic:Get("SmeltResource"):ClearSmeltList()
  self:refreshCell()
  self:createCoinAndDescImg()
  self:setBtnStage()
  self:onBtnSelect()
  self:setPoolCoin()
  self:initTtf()
  self.smeltList = {}
end
function prototype:onBtnSelect(sender, event)
  if self.select then
    self.select = false
    self.sprSelect1:setVisible(true)
    self.sprSelect2:setVisible(false)
    if self.randomCount ~= 0 then
      self.labPer2:setString("30%")
      if self.smeltList and #self.smeltList == 1 then
        self.ttfCount2:setString(self.randomCount)
      else
        self.ttfCount2:setString(self.minRandomCount .. "~" .. self.randomCount)
      end
    end
    return
  end
  self.select = true
  self.sprSelect1:setVisible(false)
  self.sprSelect2:setVisible(true)
  if self.randomCount ~= 0 then
    self.labPer2:setString("100%")
    self.ttfCount2:setString(self.randomCount)
  end
end
function prototype:onBtnShop(sender, event)
  SceneHelper:runWithScene("SmeltResourceShop", self.rootNode)
end
function prototype:OnRefreshCell()
  local smeltList = Logic:Get("SmeltResource"):GetCheckedSmeltList()
  self.smeltList = smeltList or {}
  self:refreshCell(smeltList)
  self:refreshInfo()
end
function prototype:OnExchange()
  self.select = true
  self.smeltList = {}
  self.randomCount = 0
  self:refreshCell()
  self:onBtnSelect()
  self:initTtf()
end
function prototype:refreshInfo()
  self.cost = 0
  self.fixCount = 0
  self.randomCount = 0
  self.minRandomCount = 0
  local rate = 0
  local goldCount = 0
  local fixCode = 0
  local randomCode = 0
  for k, v in pairs(self.smeltList) do
    local info = Logic:Get("SmeltResource"):getSmeltInfoById(v)
    if info then
      rate = rate + info.rate or 0
      self.cost = self.cost + info.cost or 0
      self.fixCount = self.fixCount + info.fixCount.amount or 0
      self.randomCount = self.randomCount + info.randomCount.amount or 0
      goldCount = goldCount + info.goldCount.amount or 0
      fixCode = info.fixCount.code
      randomCode = info.randomCount.code
      if k == 1 then
        self.minRandomCount = info.randomCount.amount
      end
      if info.randomCount.amount < self.minRandomCount then
        self.minRandomCount = info.randomCount.amount
      end
    end
  end
  local str = ""
  if self.smeltList and #self.smeltList == 1 then
    str = self.minRandomCount
  else
    str = self.minRandomCount .. "~" .. self.randomCount
  end
  self.ttfCount1:setString(self.fixCount)
  self.ttfCost:setString(self.cost)
  self.labPer1:setString("100%")
  if self.select then
    self.labPer2:setString("100%")
    self.ttfCount2:setString(self.randomCount)
  else
    self.labPer2:setString("30%")
    self.ttfCount2:setString(str)
  end
  local path1 = Logic:Get("SmeltResource"):GetCoinPath(CURRENCY_TYPE[fixCode])
  local path2 = Logic:Get("SmeltResource"):GetCoinPath(CURRENCY_TYPE[randomCode])
  self:setPoolCoin(path1, path2)
end
function prototype:setPoolCoin(path1, path2)
  local path = {
    "images/smelt/icon1.png",
    "images/smelt/icon2.png"
  }
  local coin1 = 1
  local coin2 = 2
  if self.pool == 2 then
    coin1 = 2
  end
  local path1 = path1 or path[coin1]
  local sprIcon = CCSprite:create(path1)
  if sprIcon then
    self.sprCoin1:setDisplayFrame(sprIcon:displayFrame())
  end
  local path2 = path2 or path[coin2]
  sprIcon = CCSprite:create(path2)
  if sprIcon then
    self.sprCoin2:setDisplayFrame(sprIcon:displayFrame())
  end
end
