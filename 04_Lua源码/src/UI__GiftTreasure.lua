module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  self.ttfTime:setStyle(kCCLabelTTFStyleOutline)
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.ttfTitle:setString(giftInfo.name)
  self.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  self.nodCost:create(0, "YELLOW_E_NUM")
  self.nodCost:setAlign("RIGHT", "CENTER")
  local MAX_ITEM = 6
  for i = 1, MAX_ITEM do
    local str = string.format("ccbItem%d", i)
    if self[str] then
      self[str]:setVisible(false)
    end
  end
  Logic:Get("TreasureRoom"):PostLoadTreasureRoom()
  Logic:Get("TreasureRoom"):On(Logic.TreasureRoom.EVT.LOAD_TREASUREROOM, self:Event("onLoadTreasureRoom"))
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnCharge(sender, event)
  SceneHelper:pushScene("GiftTreasureShow", self.rootNode)
end
function prototype:onBtnRefresh(sender, event)
  local cost = Logic:Get("TreasureRoom"):GetRefreshCost()
  local jade = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if cost > jade then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Prompt:ConfirmRecord(self, "", TwGetStr(110621, cost), self.PostRefresh, Prompt.PROMPT_TYPE.SELECT, nil, Logic.SureConfirm.RECORD_TYPE.TREASUREROOM_REFRESH)
end
function prototype:PostRefresh()
  Logic:Get("TreasureRoom"):PostRefresh()
end
function prototype:onLoadTreasureRoom()
  local cost = Logic:Get("TreasureRoom"):GetRefreshCost()
  self.nodCost:setValue(cost)
  self:RefreshTime()
  self:RefreshList()
  if not self.eventTracer:Exist("RefreshTime") then
    Singleton(Timer):Repeat(1000, self:Event("RefreshTime"))
  end
end
function prototype:RefreshList()
  local list = Logic:Get("TreasureRoom"):GetTreasureList()
  local MAX_ITEM = 6
  for i = 1, MAX_ITEM do
    local str = string.format("ccbItem%d", i)
    if self[str] then
      self[str]:setVisible(true)
      self[str]:Refresh(list[i])
    end
  end
end
function prototype:RefreshTime()
  self.ttfTime:setString("")
  local refreshTime = Logic:Get("TreasureRoom"):GetRefreshTime()
  if refreshTime then
    local diffTime = Logic:Get("System"):DiffTime(refreshTime / 1000)
    local countDown = Logic:Get("System"):SecToDay(diffTime)
    if diffTime > 0 then
      countDown.hour = countDown.hour + countDown.day * 24
      local str = TwGetStr(110603, countDown.hour or 0, countDown.min or 0, countDown.sec or 0)
      self.ttfTime:setString(str)
      return
    end
  end
end
