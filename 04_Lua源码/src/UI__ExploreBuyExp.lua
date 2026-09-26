module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
RET = Logic.SureConfirm.RET
MAX_NUM_LEN = 10
function prototype:onEnter()
  local info = Logic:Get("Explore"):GetExploreVo()
  local cost = Logic:Get("Egg"):GetCongifValueByKey("EXPLORE:BUY_EXP_COST_BASE")
  local rec = KFDBGetRecord("NPCLevelConfig", info.level) or {}
  self.minBuyUnit = Logic:Get("Egg"):GetCongifValueByKey("EXPLORE:BUY_EXP_COUNT")
  local params = {}
  params.title = 115228
  params.content = TwGetStr(115229, self.minBuyUnit)
  params.cost = 1 / cost
  params.amount = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  params.max = rec.exp - info.exp
  params.currencyName = TwGetStr(103009)
  local btnText = Logic:Get("SureConfirm"):GetBtnText()
  self.ani = Logic:Get("SureConfirm"):GetAniBool()
  self:setConfirm(params)
  self:setBtnText(btnText)
  Logic:Get("SureConfirm"):SetConfirmNil()
end
function prototype:onExit()
  Logic:Get("SureConfirm"):clear()
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:setConfirm(params)
  self.title:setStyle(kCCLabelTTFStyleOutline)
  self.title:setHorizontalAlignment(kCCTextAlignmentCenter)
  local str = TwGetStr(103001)
  str = not params.title or type(params.title) == "string" and params.title or TwGetStr(params.title)
  self.title:setString(str)
  self.content:setString(params.content)
  self.cost = params.cost
  self.amount = params.amount
  self.cnt = self.minBuyUnit
  self.maxBuyCnt = math.floor(self.amount / self.cost)
  local rec = KFDBGetRecord("ConfigValue", "PLAYER:TOKEN_COIN_EXCHANGE_MAX_NUM")
  local max = rec and tonumber(rec.content) or 1
  self.max = params.max and params.max or max
  self.ttfNum:setStyle(kCCLabelTTFStyleOutline)
  self.ttfNum:setString(self.cnt)
  self.ttfCurrency:setStyle(kCCLabelTTFStyleOutline)
  str = type(params.currencyName) == "string" and params.currencyName or TwGetStr(params.currencyName)
  self.currencyName = str
  self.ttfCurrency:setString(TwGetStr(105923, str))
  self.ttfCost:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCost:setString(self.cost * self.cnt)
  if params.currencyPath then
    local spr = CCSprite:create(params.currencyPath)
    if spr then
      self.sprCurrency:setDisplayFrame(spr:displayFrame())
    end
  end
end
function prototype:setBtnText(btnText)
  local strOk = nil ~= btnText.ok and btnText.ok or TwGetStr(103002)
  self.btnSureOne:setString(strOk)
  local strCancel = nil ~= btnText.cancel and btnText.cancel or TwGetStr(103003)
  self.btnCancel:setString(strCancel)
end
function prototype:onBtnSure(node, loader)
  if self.cnt > self.max then
    Prompt:Fail(TwGetStr(10156, self.max))
    self:addCnt(self.maxBuyCnt)
    return
  end
  if self.cnt > self.maxBuyCnt then
    SceneHelper:removePrompt(self.rootNode)
    if string.find(TwGetStr(103009), self.currencyName) then
      Logic:Get("Main"):PromptCharge()
      return
    end
    Prompt:Fail(TwGetStr(105916, self.currencyName or ""))
    return
  end
  local actionScaleTo = CCScaleTo:create(0.1, 0.3)
  local arr1 = CCArray:create()
  if not self.ani then
    arr1:addObject(actionScaleTo)
  end
  arr1:addObject(CCCallFuncN:create(function()
    MsgExplore:Post("BUY_NPC_EXP", self.cnt)
    Logic:Get("SureConfirm"):SetAni(false)
    SceneHelper:removePrompt(self.rootNode)
  end))
  self.layer:runAction(CCSequence:create(arr1))
end
function prototype:onBtnCancel(node, loader)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onMenuClose(node, loader)
end
function prototype:onBtnAdd()
  self:addCnt(self.minBuyUnit)
end
function prototype:onBtnAddMax()
  self:addCnt(self.maxBuyCnt)
end
function prototype:onBtnReduce()
  self:addCnt(-self.minBuyUnit)
end
function prototype:addCnt(cnt)
  self.cnt = self.cnt + cnt
  self.cnt = self.cnt < self.minBuyUnit and self.minBuyUnit or self.cnt
  self.cnt = self.cnt > self.max and self.max or self.cnt
  self.cnt = self.cnt > self.maxBuyCnt and self.maxBuyCnt or self.cnt
  self.ttfNum:setString(self.cnt)
  self.ttfCost:setString(self.cost * self.cnt)
end
