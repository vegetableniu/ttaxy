module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local DESC_ID = 1016
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self.ttfDesc:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTip:setStyle(kCCLabelTTFStyleOutline)
  self.depositInfo = Logic:Get("Deposit"):getDepositInfo()
  self.saveJades = 0
  local rec = KFDBGetRecord("LanguageSetting", DESC_ID)
  local strDesc = ReplaceStringTab(rec.content)
  self.ttfDesc:setString(strDesc)
  local rates = Logic:Get("Deposit"):getKindsofRates()
  if rates and not table.empty(rates) then
    self.ttfTip:setString(TwGetStr(111081, rates[1].id or 0, rates[2].id or 0, rates[3].id or 0, rates[4].id or 0, rates[1].rate or 0, rates[2].rate or 0, rates[3].rate or 0, rates[4].rate or 0))
  end
  self:refreshDuraTime()
  if not self.eventTracer:Exist("refreshDuraTime") then
    Singleton(Timer):Repeat(1000, self:Event("refreshDuraTime"))
  end
  self.kindofLevels = Logic:Get("Deposit"):getKindsOfLevels()
  for i, v in ipairs(self.kindofLevels) do
    local str = string.format("labBtnTitle%d", i)
    if self[str] then
      self[str]:create(0, "YELLOW_E_NUM")
      self[str]:setAlign("LEFT", "CENTER")
      self[str]:setValue(v.amount or 0)
    end
  end
  local rec = KFDBGetRecord("ConfigValue", "DEPOSIT:ACTIVE_CHARGE_AMOUNT")
  self.conditionCharge = rec and tonumber(rec.content) or 0
  local activeCharge = self.depositInfo and self.depositInfo.activeCharge and self.depositInfo.activeCharge or 0
  local rec = KFDBGetRecord("ConfigValue", "DEPOSIT:ACTIVE_CONSUME_AMOUNT")
  self.consume = rec and tonumber(rec.content) or 0
  local activeConsume = self.depositInfo and self.depositInfo.activeConsume and self.depositInfo.activeConsume or 0
  self:setBtnState()
  if self.depositInfo and self.depositInfo.depositEndSeconds and self.depositInfo.depositEndSeconds == 0 then
    self.textRechargeTip:setString(TwGetStr(111105))
    return
  end
  if 0 < self.conditionCharge and activeCharge < self.conditionCharge then
    self.textRechargeTip:setString(TwGetStr(111084, self.conditionCharge - activeCharge))
    return
  end
  if 0 < self.consume and activeConsume < self.consume then
    self.textRechargeTip:setString(TwGetStr(111096, self.consume - activeConsume))
    return
  end
  self.textRechargeTip:setVisible(false)
end
function prototype:setBtnState()
  local canSaveJade = false
  if self.depositInfo and self.depositInfo.depositEndSeconds and self.depositInfo.depositEndSeconds == 0 then
    canSaveJade = false
  else
    if 0 < self.conditionCharge then
      local activeCharge = self.depositInfo and self.depositInfo.activeCharge and self.depositInfo.activeCharge or 0
      canSaveJade = activeCharge >= self.conditionCharge
    end
    if 0 < self.consume then
      local activeConsume = self.depositInfo and self.depositInfo.activeConsume and self.depositInfo.activeConsume or 0
      canSaveJade = activeConsume >= self.consume
    end
  end
  for i = 1, 5 do
    local btnStr = string.format("btn%d", i)
    if self[btnStr] then
      self[btnStr]:setEnabled(canSaveJade)
    end
  end
  self.btnCover:setVisible(not canSaveJade)
end
function prototype:refreshDuraTime()
  local endTime = Logic:Get("Deposit"):getSaveEndTime()
  local diffTime = Logic:Get("System"):DiffTime(endTime)
  local duraTime = Logic:Get("System"):SecToDay(diffTime)
  if duraTime and diffTime > 0 then
    self.ttfDuration:setString(TwGetStr(111083, TwGetStr(111091, duraTime.day or 0), TwGetStr(111091, duraTime.hour or 0), TwGetStr(111091, duraTime.min or 0), TwGetStr(111091, duraTime.sec or 0)))
  else
    self.ttfDuration:setString(TwGetStr(111095))
  end
end
function prototype:saveJadeByIndex(index)
  self.index = index
  local saveJades = self.kindofLevels and self.kindofLevels[index] and self.kindofLevels[index].amount or 0
  if index < #self.kindofLevels then
    local strTip = TwGetStr(111098, saveJades or 0)
    strTip = strTip .. TwGetStr(111099)
    Prompt:Confirm(self, "", strTip, self.saveWealth, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  local strTip = TwGetStr(111086, saveJades or 0)
  strTip = strTip .. TwGetStr(111099)
  Prompt:Confirm(self, "", strTip, self.saveWealth, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:saveWealth()
  local jade = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  local saveJades = self.kindofLevels and self.kindofLevels[self.index] and self.kindofLevels[self.index].amount or 0
  if jade < saveJades then
    Logic:Get("Main"):PromptCharge()
  else
    local id = self.kindofLevels and self.kindofLevels[self.index] and self.kindofLevels[self.index].id or 0
    Logic:Get("Deposit"):PostDeposit(id or 0)
  end
end
function prototype:onBtnCoverClicked(sender, event)
  if self.depositInfo and self.depositInfo.depositEndSeconds and self.depositInfo.depositEndSeconds == 0 then
    Prompt:Tip(TwGetStr(111105))
    return
  end
  local activeCharge = self.depositInfo and self.depositInfo.activeCharge and self.depositInfo.activeCharge or 0
  local needJades = self.conditionCharge - activeCharge
  if 0 < self.conditionCharge then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    Prompt:Confirm(Logic:Get("Main"), "", TwGetStr(111088, self.conditionCharge, needJades), Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  local activeConsume = self.depositInfo and self.depositInfo.activeConsume and self.depositInfo.activeConsume or 0
  needJades = self.consume - activeConsume
  Prompt:Fail(TwGetStr(111097, self.consume, needJades))
end
function prototype:onBtn1Clicked(sender, event)
  self:saveJadeByIndex(1)
end
function prototype:onBtn2Clicked(sender, event)
  self:saveJadeByIndex(2)
end
function prototype:onBtn3Clicked(sender, event)
  self:saveJadeByIndex(3)
end
