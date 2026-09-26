module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTitle:setColor(ccColor3B(187, 255, 0))
  self.ttfTitle:setString(TwGetStr(103001))
  self.ttfBuyTimes:setString(TwGetStr(105330))
  self.ttfGetMore:setString(TwGetStr(105321))
  self.ttfBuyOne:setString(TwGetStr(105331))
  self.ttfMaxBuy:setString(TwGetStr(105332))
  self.ttfCancel:setString(TwGetStr(103003))
  local fightTimes = Logic:Get("Fight"):GetFightTimes()
  local times = Logic:Get("Fight"):GetLeaveBuyTimes()
  local cost = Logic:Get("Fight"):GetBuyTimesCost() or 0
  local totalTimes, totalCost = Logic:Get("Fight"):GetTotalBuyTimesAndCost()
  local str = ""
  if times and fightTimes then
    if fightTimes > 0 then
      str = TwGetStr(105309, cost)
    else
      str = TwGetStr(105308) .. TwGetStr(105309, cost)
    end
    if totalTimes > 1 then
      str = str .. TwGetStr(105327, totalCost or 0, totalTimes or 0)
    end
    self.ttfContent:setString(str)
    local x = self.ttfBuyTimes:getPositionX() + self.ttfBuyTimes:getContentSize().width
    self.ttfLeaveBuyTimes:setPositionX(x)
    self.ttfLeaveBuyTimes:setString(times)
  end
end
function prototype:onBtnBuyOnceClicked(sender, event)
  local leaveBuyTimes = Logic:Get("Fight"):GetLeaveBuyTimes()
  if leaveBuyTimes <= 0 then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    local str = TwGetStr(10078) .. "\n" .. TwGetStr(105321)
    Prompt:Confirm(Logic:Get("Main"), "", str, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    SceneHelper:removePrompt(self.rootNode)
    return
  end
  local playerMoney = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  local cost = Logic:Get("Fight"):GetBuyTimesCost() or 1
  if playerMoney >= cost then
    MsgArena:Post("BUY_DEFY_TIMES", {num = 1})
  else
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
  end
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnMaxBuyClicked(sender, event)
  local leaveBuyTimes = Logic:Get("Fight"):GetLeaveBuyTimes()
  if leaveBuyTimes > 0 then
    local playerMoney = Logic:Get("PlayerInfo"):GetPlayerAllJade()
    if playerMoney then
      local buyTimes, cost = Logic:Get("Fight"):GetTotalBuyTimesAndCost()
      if buyTimes >= 1 then
        if leaveBuyTimes <= buyTimes then
          MsgArena:Post("BUY_DEFY_TIMES", {num = leaveBuyTimes})
        else
          MsgArena:Post("BUY_DEFY_TIMES", {num = buyTimes})
        end
      else
        Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
        Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
      end
    end
  else
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    local str = TwGetStr(10078) .. "\n" .. TwGetStr(105321)
    Prompt:Confirm(Logic:Get("Main"), "", str, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
  end
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnCancel(sender, event)
  SceneHelper:removePrompt(self.rootNode)
end
