module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  self.ttfCoin:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:Refresh(data)
  if table.empty(data or {}) then
    return
  end
  self.data = data
  self.ccbIcon:ReFreshByGift(data)
  self.ttfCoin:setString(data.costStr or "")
  local path = Logic:Get("TreasureRoom"):GetCurrencyPath(data.costTypes)
  local spr = CCSprite:create(path)
  if spr then
    self.sprIcon:setDisplayFrame(spr:displayFrame())
  end
  self:showDiscount()
  local bExchange = Logic:Get("Preciousroom"):IsExchanged(data.position)
  self.isExchanged:setVisible(bExchange and true)
end
function prototype:showDiscount()
  self.nodDiscount:setVisible(false)
  if self.data.discount and self.data.discount > 0 then
    self.nodDiscount:setVisible(true)
    local path = "images/MallRace/discount" .. self.data.discount .. ".png"
    local spr = CCSprite:create(path)
    if spr then
      self.sprDiscount:setDisplayFrame(spr:displayFrame())
    end
  end
end
function prototype:onBtnExchange(sender, event)
  local refreshTime = Logic:Get("Preciousroom"):GetPreciousInfo().time
  if refreshTime then
    local diffTime = Logic:Get("System"):DiffTime(refreshTime / 1000)
    if diffTime < 0 then
      Prompt:Confirm(self, "", TwGetStr(110620), self.PostLoadShop, Prompt.PROMPT_TYPE.CONFIRM)
      return
    end
  end
  local bExchange = Logic:Get("Preciousroom"):IsExchanged(self.data.position)
  if bExchange then
    Prompt:Fail(110618)
    return
  end
  local info = Logic:Get("TreasureRoom"):GetCurrencyInfo(self.data.costTypes)
  if info.amount < self.data.cost then
    if info.type == "GOLD" then
      Logic:Get("Main"):PromptCharge()
    elseif info.type == "COPPER" then
      Prompt:Fail(103031)
    else
      Prompt:Fail(TwGetStr(105762, info.name or ""))
    end
    return
  end
  Prompt:Confirm(self, "", TwGetStr(110622, self.data.cost, info.name or "", self.data.name or ""), self.PostExchange, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:PostExchange()
  Logic:Get("Preciousroom"):PostExchange(self.data.position)
end
function prototype:PostLoadShop()
  Logic:Get("Preciousroom"):PostLoadShop()
end
