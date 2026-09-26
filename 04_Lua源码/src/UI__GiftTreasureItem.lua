module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  self.ttfCoin:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:setVisible(bool)
  self.ttfCoin:setVisible(bool)
  self.sprIcon:setVisible(bool)
  self.ccbIcon:setVisible(bool)
  self.nodBtn:setVisible(bool)
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
  self:showRare(data.rare == "true")
  local bExchange = Logic:Get("TreasureRoom"):IsExchanged(data.position)
  self.isExchanged:setVisible(bExchange and true)
end
function prototype:showRare(bool)
  self.sprRareBg:setVisible(bool)
  self.sprRare:setVisible(bool)
end
function prototype:onBtnExchange(sender, event)
  local refreshTime = Logic:Get("TreasureRoom"):GetRefreshTime()
  if refreshTime then
    local diffTime = Logic:Get("System"):DiffTime(refreshTime / 1000)
    if diffTime < 0 then
      Prompt:Confirm(self, "", TwGetStr(110620), self.PostLoadTreasureRoom, Prompt.PROMPT_TYPE.CONFIRM)
      return
    end
  end
  local bExchange = Logic:Get("TreasureRoom"):IsExchanged(self.data.position)
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
  Prompt:Confirm(self, "", TwGetStr(110622, self.data.cost, info.name or "", self.data.name or ""), self.PostOpenBoxByCurrency, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:PostOpenBoxByCurrency()
  if Logic:Get("TreasureRoom"):IsSetGemScene() then
    Logic:Get("TreasureRoom"):PostGemExchange(self.data.position)
    return
  end
  Logic:Get("TreasureRoom"):PostOpenBoxByCurrency(self.data.position)
end
function prototype:PostLoadTreasureRoom()
  if Logic:Get("TreasureRoom"):IsSetGemScene() then
    Logic:Get("TreasureRoom"):PostLoadGemRoom()
    return
  end
  Logic:Get("TreasureRoom"):PostLoadTreasureRoom()
end
