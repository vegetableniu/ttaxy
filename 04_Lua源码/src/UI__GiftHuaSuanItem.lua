module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfFeedBack:setStyle(kCCLabelTTFStyleOutline)
  self.ttfDays:setStyle(kCCLabelTTFStyleOutline)
  self.ttfUnit:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCost:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLimit:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:fresh(data)
  if table.empty(data or {}) then
    return
  end
  self:clear()
  self.data = data
  self.ttfName:setString(data.name)
  self.ccbIcon:ReFreshByGift(data)
  self.ttfCost:setString(data.costs)
  self.ttfUnit:setString(TwGetStr(103009))
  self:showLimit(data)
  self.ttfFeedBack:setString(data.feedBack or "")
  self.ttfDays:setString(data.duration or 0)
  local bool = Logic:Get("JuHuaSuan"):HasBuyed(data.id)
  self.nodBuy:setVisible(not bool)
  self.sprHasBuy:setVisible(bool)
  if bool then
    self.ttfCost:setString("")
    self.ttfUnit:setString("")
  end
end
function prototype:showLimit(data)
  local logic = Logic:Get("PlayerInfo")
  local vip = {
    week = {
      str = TwGetStr(110805),
      func = bind(logic.IsWeekVip, logic)
    },
    month = {
      str = TwGetStr(110804),
      func = bind(logic.hasMonthVipFunc, logic)
    }
  }
  local str = ""
  if vip[data.vip] and not vip[data.vip]:func() then
    str = str .. vip[data.vip].str
  end
  local level = logic:GetPlayerLevel()
  if data.level > 0 and level < data.level then
    if "" ~= str then
      str = str .. "\n"
    end
    str = str .. TwGetStr(105311, data.level)
  end
  if "" ~= str then
    str = str .. TwGetStr(110806)
  end
  self.ttfLimit:setString(str)
end
function prototype:clear()
  self.ttfName:setString("")
  self.ttfFeedBack:setString("")
  self.ttfCost:setString("")
  self.ttfLimit:setString("")
  self.ttfDays:setString("")
  self.ttfUnit:setString("")
end
function prototype:onBtnBuy(sender, event)
  local level = Logic:Get("PlayerInfo"):GetPlayerLevel()
  if level < self.data.level then
    Prompt:Fail(105238)
    return
  end
  local logic = Logic:Get("PlayerInfo")
  local vip = {
    week = {
      str = TwGetStr(110805) .. TwGetStr(110806),
      func = bind(logic.IsWeekVip, logic)
    },
    month = {
      str = TwGetStr(110804) .. TwGetStr(110806),
      func = bind(logic.hasMonthVipFunc, logic)
    }
  }
  if vip[self.data.vip] and not vip[self.data.vip]:func() then
    Prompt:Fail(vip[self.data.vip].str)
    return
  end
  local money = logic:GetPlayerAllJade()
  if money < self.data.costs then
    Logic:Get("Main"):PromptCharge()
    return
  end
  if Logic:Get("JuHuaSuan"):CanBuy(self.data.id) then
    local str = TwGetStr(110808, self.data.costs, self.data.name, self.data.feedBack, self.data.duration)
    Prompt:Confirm(self, "", str, self.onConfirmBuy, Prompt.PROMPT_TYPE.SELECT)
    return
  end
end
function prototype:onConfirmBuy()
  Logic:Get("JuHuaSuan"):PostBuyGoods(self.data.id)
end
