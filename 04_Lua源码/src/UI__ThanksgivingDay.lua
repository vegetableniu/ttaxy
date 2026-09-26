module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local materialId = {1, 2}
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  self.eatCount = 0
  self:createLabel()
  self:scrollViewCreate()
  self:setHeroImg()
  self:setLabValue()
  Logic:Get("ThanksgivingDay"):On(Logic.ThanksgivingDay.EVT.LOAD_TURKEY, self:Event("onLoadTurkey"))
  Logic:Get("ThanksgivingDay"):On(Logic.ThanksgivingDay.EVT.REFRESH_INFO, self:Event("onRefreshInfo"))
  Logic:Get("ThanksgivingDay"):PostLoadTurkey()
end
function prototype:onLoadTurkey()
  self:onRefreshInfo()
  self:refreshPost()
end
function prototype:onRefreshInfo()
  self.trukeyInfo = Logic:Get("ThanksgivingDay"):getTurkeyInfo()
  if table.empty(self.trukeyInfo or {}) then
    return
  end
  self.labMaterial1:setValue(self.trukeyInfo.materials[materialId[1]] or 0)
  self.labMaterial2:setValue(self.trukeyInfo.materials[materialId[2]] or 0)
  self.labTurkey:setValue(self.trukeyInfo.turkeys)
end
function prototype:onBtnRecharge(sender, Event)
  local activity = Logic:Get("Gift"):GetActivityByType("CHARGE_RETURN")
  Logic:Get("Gift"):SetActivityGift(activity[1])
  SceneHelper:runWithScene("ThanksgivingDayCharge", self.rootNode)
end
function prototype:onBtnReturn(sender, Event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnBuy(sender, Event)
  SceneHelper:pushPrompt("ThanksgivingDayBuy")
end
function prototype:onBtnMakeTurkey(sender, Event)
  local material1 = self.trukeyInfo.materials[self.costMaterials[1].code] or 0
  local material2 = self.trukeyInfo.materials[self.costMaterials[2].code] or 0
  local cost1 = self.costMaterials[1].amount or 1
  local cost2 = self.costMaterials[2].amount or 1
  local canMakeCount1 = math.floor(material1 / cost1)
  local canMakeCount2 = math.floor(material2 / cost2)
  self.count = math.min(canMakeCount1, canMakeCount2)
  local rec = KFDBGetRecord("ConfigValue", "TURKEY:COST_CURRENCY")
  local cost = rec and tonumber(rec.content) or 0
  if 0 >= self.count then
    Prompt:ConfirmRecord(self, "", TwGetStr(108760, cost * 10), self.postMakeTurkeyByCurrency, Prompt.PROMPT_TYPE.SELECT, nil, Logic.SureConfirm.RECORD_TYPE.MAKET_URKEY)
    return
  end
  Prompt:Select(self, "", TwGetStr(108761, self.count * cost1, self.count * cost2, self.count), self.postMakeTurkey, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onBtnEatOneTimes(sender, Event)
  if self.trukeyInfo == nil then
    return
  end
  if self.trukeyInfo.turkeys <= 0 then
    Prompt:Tip(108762)
    return
  end
  self.eatCount = 1
  Prompt:ConfirmRecord(self, "", TwGetStr(108763), self.postEatTurkey, Prompt.PROMPT_TYPE.SELECT, nil, Logic.SureConfirm.RECORD_TYPE.EAT_URKEY)
end
function prototype:onBtnEatTenTimes(sender, Event)
  if self.trukeyInfo == nil then
    return
  end
  if self.trukeyInfo.turkeys < 10 then
    Prompt:Tip(108762)
    return
  end
  self.eatCount = 10
  Prompt:ConfirmRecord(self, "", TwGetStr(108763), self.postEatTurkey, Prompt.PROMPT_TYPE.SELECT, nil, Logic.SureConfirm.RECORD_TYPE.EAT_URKEY)
end
function prototype:onBtnHero(sender, Event)
  local heroInfo = {
    exp = 0,
    id = 68719480211,
    level = 75,
    baseId = self.baseId or 1,
    powerSkill = 0
  }
  Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(heroInfo)
end
function prototype:setHeroImg()
  local rec = KFDBGetRecord("ConfigValue", "TURKEY:SHOW_BASEID")
  self.baseId = rec.content
  if not self.baseId then
    return
  end
  local objNode = self.btnHero:getChildByTag(0)
  if objNode then
    self.btnHero:removeChild(objNode, true)
  end
  local node = Logic:Get("HeroCardInfo"):createHeroCard(self.baseId, 180)
  node:setAnchorPoint(CCPoint(0.5, 0.5))
  self.btnHero:addChild(node, 0, 0)
  local btnCz = self.btnHero:getContentSize()
  local nodeCz = self.btnHero:getContentSize()
  node:setPosition(ccp(btnCz.width / 2, btnCz.height / 2))
end
function prototype:createLabel()
  self.labMaterial1:create(0, "GREEN_NUM")
  self.labMaterial1:setAlign("LEFT", "CENTER")
  self.labMaterial2:create(0, "GREEN_NUM")
  self.labMaterial2:setAlign("LEFT", "CENTER")
  self.labTurkey:create(0, "GREEN_NUM")
  self.labTurkey:setAlign("LEFT", "CENTER")
  self.labCost1:create(0, "GREEN_NUM")
  self.labCost1:setAlign("LEFT", "CENTER")
  self.labCost2:create(0, "GREEN_NUM")
  self.labCost2:setAlign("LEFT", "CENTER")
  self.labMaterialCost1:create(0, "GREEN_NUM")
  self.labMaterialCost1:setAlign("LEFT", "CENTER")
  self.labMaterialCost2:create(0, "GREEN_NUM")
  self.labMaterialCost2:setAlign("LEFT", "CENTER")
end
function prototype:setLabValue()
  local rec = KFDBGetRecord("ConfigValue", "TURKEY:COST_MATERIALS")
  self.costMaterials = json.decode(rec and rec.content or "") or {}
  for k, v in pairs(self.costMaterials) do
    local labMaterialCost = string.format("labMaterialCost%d", materialId[k])
    if self[labMaterialCost] then
      self[labMaterialCost]:setValue(v.amount)
    end
  end
  self.labCost1:setValue(1)
  self.labCost2:setValue(10)
end
function prototype:createGroupList()
  local list = {}
  for i = 1, KFDBGetRecordAmt("MoonExSetting") do
    local rec = KFDBGetRecordByIdx("MoonExSetting", i)
    if rec and not list[rec.group] then
      list[rec.group] = rec
    end
  end
  return list
end
function prototype:scrollViewCreate()
  local container = Tw.Controller:load("PostCommonItem", self.rootNode)
  local scroll = CCScrollViewEx:create(CCSizeMake(480, 32))
  scroll:setDirection(kCCScrollViewDirectionHorizontal)
  scroll:setClippingToBounds(true)
  scroll:setTouchEnabled(false)
  scroll:setContainer(container)
  scroll:updateInset()
  self.scrollTag = scroll:getTag()
  self.nodAdv:addChild(scroll)
end
function prototype:refreshPost()
  local info = Logic:Get("ThanksgivingDay"):getChat()
  local scroll = tolua.cast(self.nodAdv:getChildByTag(self.scrollTag), "CCScrollViewEx")
  if not scroll then
    return
  end
  local container = scroll:getContainer()
  local params = {
    sizeW = 480,
    sizeH = 15,
    strNum = 108767
  }
  container:initRewards(info, params)
end
function prototype:onMoonInfo()
  self:onExchange()
  local scroll = tolua.cast(self.nodAdv:getChildByTag(self.scrollTag), "CCScrollViewEx")
  if not scroll then
    return
  end
  local container = scroll:getContainer()
  container:initRewards()
end
function prototype:postMakeTurkey(ret)
  if ret == Prompt.RET.OK then
    Logic:Get("ThanksgivingDay"):PostMakeTurkey(self.count)
  end
end
function prototype:postMakeTurkeyByCurrency()
  local rec = KFDBGetRecord("ConfigValue", "TURKEY:COST_CURRENCY")
  local cost = rec and tonumber(rec.content) or 0
  local totalCost = cost * 10
  local playerMoney = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if totalCost > playerMoney then
    Logic:Get("Main"):PromptCharge()
    SceneHelper:removePrompt(self.rootNode)
    return
  end
  Logic:Get("ThanksgivingDay"):PostMakeTurkeyByCurrency(10)
end
function prototype:postEatTurkey()
  Logic:Get("ThanksgivingDay"):PostEatTurkey(self.eatCount)
end
