module((...), package.seeall)
require("Logic")
require("SceneHelper")
require("protocol")
class = Logic.class:subclass()
ACTIVE_TYPE = Enum({"CHARGE", "FREE"})
EVT = Enum({"SUCCESSED"})
function class:initialize()
  super.initialize(self)
  self.blevelChange = false
  self.bCharge = false
  self.active = nil
  self.server = Logic:Get("System"):GetPhoneFeeSetting()
end
function class:dispose()
  super.dispose(self)
end
function class:SetLevelChange(blevelChange)
  self.blevelChange = blevelChange
end
function class:SetCharge(bCharge)
  self.bCharge = bCharge
end
function class:GetActive()
  return self.active
end
function class:IsActiveOver(chargeTime)
  local rec = KFDBGetRecord("ConfigValue", "KINGSOFT:START_TIME") or {}
  local time = Logic:Get("Mall"):GetItemTime(rec.content)
  if table.empty(time) then
    return true
  end
  time = os.time(time)
  if not time or Logic:Get("System"):DiffTime(time, chargeTime) > 0 then
    return true
  end
  rec = KFDBGetRecord("ConfigValue", "KINGSOFT:END_TIME") or {}
  time = Logic:Get("Mall"):GetItemTime(rec.content)
  if table.empty(time) then
    return true
  end
  time = os.time(time)
  if not time or Logic:Get("System"):DiffTime(time, chargeTime) < 0 then
    return true
  end
  return false
end
function class:CanShowCallFee()
  if not self.blevelChange then
    return false
  end
  if not Logic:Get("System"):IsOperator("appstore") then
    return false
  end
  if self:IsActiveOver() then
    return false
  end
  local level = Logic:Get("PlayerInfo"):GetPlayerLevel()
  local rec = KFDBGetRecord("ConfigValue", "KINGSOFT:FREE_CALLS_FEE") or {}
  local tab = json.decode(rec.content or "[]") or {}
  local free = Logic:Get("System"):GetSysVariableMisc("GV_FREE_CALLS_FEE")
  if free and free == tab.version then
    return false
  end
  if tab.level == level then
    self.active = ACTIVE_TYPE.FREE
    self:PostGetPhoneFee(nil)
    return false
  end
  local charge = Logic:Get("System"):GetSysVariableMisc("GV_CHARGE_CALLS_FEE")
  rec = KFDBGetRecord("ConfigValue", "KINGSOFT:CHARGE_CALLS_FEE") or {}
  tab = json.decode(rec.content or "[]") or {}
  if charge and charge == tab.version then
    return false
  end
  if tab.level == level then
    local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
    if wallet.totalCharge >= tab.chargeAmount then
      self.active = ACTIVE_TYPE.CHARGE
      return true
    end
    Prompt:Fail(110415)
  end
  return false
end
function class:CanShowChargeFee()
  if not self.bCharge then
    return false
  end
  if not Logic:Get("System"):IsOperator("appstore") then
    return false
  end
  if self:IsActiveOver() then
    return false
  end
  local charge = Logic:Get("System"):GetSysVariableMisc("GV_CHARGE_CALLS_FEE")
  local rec = KFDBGetRecord("ConfigValue", "KINGSOFT:CHARGE_CALLS_FEE") or {}
  local tab = json.decode(rec.content or "[]") or {}
  if charge and charge == tab.version then
    return false
  end
  local level = Logic:Get("PlayerInfo"):GetPlayerLevel()
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  if wallet.totalCharge >= tab.chargeAmount and level >= tab.level then
    self.active = ACTIVE_TYPE.CHARGE
    return true
  end
  return false
end
function class:IsShowLoginCallFee()
  local lastChargeTime = Logic:Get("PlayerInfo"):GetLastChargeDate()
  if not lastChargeTime then
    return false
  end
  self.bCharge = not self:IsActiveOver(lastChargeTime / 1000)
  local result = self:CanShowChargeFee()
  self.bCharge = false
  return result
end
function class:HttpRequest(strAction)
  local httpReq = ITwHttp.Request()
  httpReq.strHost = self.server.host
  httpReq.strMethod = "POST"
  httpReq.strAction = strAction
  httpReq.port = self.server.port
  return httpReq
end
function class:PostGetPhoneFee(phonenum)
  local operator = Logic:Get("System"):GetOperatorId()
  local userid = Logic:Get("PlayerInfo"):GetPlayerId()
  userid = protocol.Id2Str(userid) or userid
  local username = Logic:Get("Account"):GetUserId()
  local password = Logic:Get("Account"):GetPassword()
  local time = Logic:Get("System"):GetTime()
  local sign = CMd5(password .. self.server.loginKey .. time):GetResult()
  local chargeActLink = string.format(self.server.action, operator, userid, phonenum or 0, username, password, sign, time, self.active)
  local freeActLink = string.format(self.server.freeActLink, operator, userid, username, password, sign, time, self.active)
  local action = phonenum and chargeActLink or freeActLink
  local httpReq = self:HttpRequest(action)
  self:EventTracer():Cancel("PhoneFee")
  Singleton(NetHttp):On(httpReq.uReqId, self:Event("PhoneFee", "OnGetPhoneFee"))
  Singleton(NetHttp):Send(httpReq)
end
function class:OnGetPhoneFee(code, data)
  local result = json.decode(data or "[]") or {}
  if not result.code or result.code ~= 0 then
    self:OnError(result.code)
    return
  end
  local id = self.active == ACTIVE_TYPE.FREE and "KINGSOFT:FREE_CALLS_FEE" or "KINGSOFT:CHARGE_CALLS_FEE"
  local rec = KFDBGetRecord("ConfigValue", id) or {}
  local tab = json.decode(rec.content or "[]") or {}
  if self.active == ACTIVE_TYPE.FREE then
    Logic:Get("System"):SetSysVariableMisc("GV_FREE_CALLS_FEE", tab.version)
    return
  end
  if self.active == ACTIVE_TYPE.CHARGE then
    Logic:Get("System"):SetSysVariableMisc("GV_CHARGE_CALLS_FEE", tab.version)
  end
  self:FireEvent(EVT.SUCCESSED)
  Logic:Get("WeChat"):PhoneFee()
  Logic:Get("WeChat"):OpenWeChat()
end
function class:OnError(code)
  local ERR_RESULT = {
    [-1] = 10056,
    [-2] = 110416,
    [-3] = 110417,
    [-4] = 110418,
    [-5] = 110419,
    [-6] = 110420,
    [-7] = 110421,
    [-8] = 110422,
    [-9] = 110409,
    [-10] = 110423,
    [-11] = 111106
  }
  if self.active == ACTIVE_TYPE.FREE then
    log4misc:warn("Logic.PhoneFee:OnError" .. TwGetStr(ERR_RESULT[code]) or TwGetStr(110409))
    return
  end
  Prompt:Fail(ERR_RESULT[code] or TwGetStr(110409))
end
