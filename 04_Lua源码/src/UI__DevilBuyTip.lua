module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local path = "images/public/selcet2.png"
function prototype:onEnter()
  self:AddClicked(self.sprTip1)
  self.type = 0
  self.cost = 0
  local data = Logic:Get("Devil"):GetBuyEnergyType()
  for i = 1, #data do
    local str = string.format("ttfTip%d", i)
    if self[str] then
      self[str]:setString(TwGetStr(105565, data[i]))
    end
  end
  self:refreshCost()
  Logic:Get("Devil"):On(Logic.Devil.EVT.BUY_SUCCESSED, self:Event("onBuySuccess"))
end
function prototype:onMenuClose(sender, event)
end
function prototype:onBtnSure(sender, event)
  if Logic:Get("Devil"):isEnergyFull() then
    Prompt:Fail(TwGetStr(105572))
    return
  end
  if self.cost > 0 then
    local playerMoney = Logic:Get("PlayerInfo"):GetPlayerAllJade()
    if playerMoney < self.cost then
      Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
      Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
      SceneHelper:removePrompt(self.rootNode)
      return
    end
  end
  local leaveBuyTime = Logic:Get("Devil"):GetLeaveBuyTimes()
  local buyEnergy = Logic:Get("Devil"):GetBuyCnt() or 1
  local buyTimes = 0
  local bEnough = false
  if leaveBuyTime <= 0 then
    bEnough = true
  else
    local buyTimeTab = Logic:Get("Devil"):GetBuyEnergyType()
    if buyTimeTab and not table.empty(buyTimeTab) then
      buyTimes = math.ceil(buyTimeTab[self.type + 1] / buyEnergy)
      if leaveBuyTime < buyTimes then
        bEnough = true
      end
    end
  end
  if bEnough then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    local str = TwGetStr(105568, leaveBuyTime * buyEnergy)
    Prompt:Confirm(Logic:Get("Main"), "", str, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    SceneHelper:removePrompt(self.rootNode)
    return
  end
  Logic:Get("Devil"):PostBuyEnergy(self.type)
end
function prototype:onBtnCancelClicked(sender, event)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnTipClicked(sender, event)
  if sender == self.btnTip1 then
    self:AddClicked(self.sprTip1)
    self.type = 0
  elseif sender == self.btnTip2 then
    self:AddClicked(self.sprTip2)
    self.type = 1
  elseif sender == self.btnTip3 then
    self:AddClicked(self.sprTip3)
    self.type = 2
  end
  self:refreshCost()
end
function prototype:AddClicked(node)
  if node == nil then
    return
  end
  local lockChild = self.layer:getChildByTag(100)
  if lockChild ~= nil then
    self.layer:removeChildByTag(100, true)
  end
  local spr = CCSprite:create(path)
  if spr then
    spr:setAnchorPoint(CCPoint(0.5, 0.5))
    local x = node:getPositionX()
    local y = node:getPositionY()
    spr:setPosition(ccp(x, y))
    self.layer:addChild(spr, 10, 100)
  end
end
function prototype:refreshCost()
  local cost = Logic:Get("Devil"):GetBuyCost(self.type)
  if cost > 0 then
    self.cost = cost
    self.ttfCost:setString(TwGetStr(105566, cost))
  end
end
function prototype:onBuySuccess()
  SceneHelper:removePrompt(self.rootNode)
end
