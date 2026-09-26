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
  Logic:Get("TreasureRoom"):SetGemScene(true)
  self.ttfTime:setStyle(kCCLabelTTFStyleOutline)
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.ttfTitle:setString(giftInfo.name)
  self.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  local MAX_ITEM = 6
  for i = 1, MAX_ITEM do
    local str = string.format("ccbItem%d", i)
    if self[str] then
      self[str]:setVisible(false)
    end
  end
  Logic:Get("TreasureRoom"):PostLoadGemRoom()
  Logic:Get("TreasureRoom"):On(Logic.TreasureRoom.EVT.LOAD_TREASUREROOM, self:Event("onLoadTreasureRoom"))
end
function prototype:onExit()
  Logic:Get("TreasureRoom"):SetGemScene(false)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnCharge(sender, event)
  SceneHelper:pushScene("GiftTreasureShow", self.rootNode)
end
function prototype:onBtnRefresh(sender, event)
  local refreshTime = Logic:Get("TreasureRoom"):GetCoolTime() or 0
  local diffTime = Logic:Get("System"):DiffTime(refreshTime / 1000)
  if diffTime > 0 then
    local minutes = math.ceil(diffTime / 60)
    local maxColdTime = Logic:Get("Egg"):GetCongifValueByKey("GEMROOM:COOLTIME_LIMIT")
    if minutes > maxColdTime then
      self:PostClearCoolTime()
      return
    end
    if Logic:Get("TreasureRoom"):IsColdDown() then
      self:PostClearCoolTime()
      return
    end
    Logic:Get("TreasureRoom"):PostGemRefresh()
    return
  end
  Logic:Get("TreasureRoom"):PostGemRefresh()
end
function prototype:PostClearCoolTime()
  local cost = Logic:Get("Egg"):GetCongifValueByKey("GEMROOM:CLEAR_COOL_TIME_COST")
  local text = TwGetStr(105307, cost)
  Prompt:ConfirmRecord(self, "", text, self.PostClearColdTime, Prompt.PROMPT_TYPE.SELECT, nil, Logic.SureConfirm.RECORD_TYPE.GEMROOM_REFRESH)
end
function prototype:PostClearColdTime()
  local playerMoney = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  local cost = Logic:Get("Egg"):GetCongifValueByKey("GEMROOM:CLEAR_COOL_TIME_COST")
  if playerMoney < cost then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Logic:Get("TreasureRoom"):PostClearCoolTime()
end
function prototype:onLoadTreasureRoom()
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
  self.nodRefresh:setVisible(false)
  local refreshTime = Logic:Get("TreasureRoom"):GetCoolTime()
  if refreshTime then
    local diffTime = Logic:Get("System"):DiffTime(refreshTime / 1000)
    local countDown = Logic:Get("System"):SecToDay(diffTime)
    if diffTime > 0 then
      self.nodRefresh:setVisible(true)
      local color = Logic:Get("TreasureRoom"):IsColdDown() and ccc3(255, 0, 0) or ccc3(255, 255, 255)
      countDown.hour = countDown.hour + countDown.day * 24
      local str = TwGetStr(102008, countDown.hour or 0, countDown.min or 0, countDown.sec or 0)
      self.ttfTime:setColor(color)
      self.ttfTime:setString(str)
      return
    end
  end
end
