module((...), package.seeall)
require("Logic")
EVT = Enum({
  "REFRESH_RECHARGE_LIST"
})
class = Logic.class:subclass()
function class:initialize()
  super.initialize(self)
  self.lstRecharge = nil
  self.lockBuy = false
  self.recharge = {}
  self.orderIdUsed = {}
  MsgPlayer:On("ORDER", self:Event("OnGetOrderId"))
end
function class:dispose()
  super.dispose(self)
end
function class:BuyGoods(goodsId, count)
  if not Singleton(GameStage):IsStage("Normal") then
    return
  end
  if nil == goodsId then
    return
  end
  if nil == self:GetChargeGoodsInfo(goodsId) then
    return
  end
  count = count or 1
  if Logic:Get("System"):IsOperator("myapp") then
    local goodsInfo = Logic:Get("Recharge"):GetChargeGoodsInfo(goodsId)
    if goodsInfo.typeCard == 1 then
      local count = "1"
      local serverInfo = Logic:Get("Login"):GetLoginInfo()
      local userName = Logic:Get("PlayerInfo"):GetPlayerName() or ""
      if nil == serverInfo or nil == goodsInfo then
        return
      end
      local rechargeData = {
        orderId = "",
        accountId = serverInfo.account,
        userName = userName,
        goodsId = goodsInfo.id,
        goodsCount = count,
        serverId = serverInfo.server,
        serverName = serverInfo.name,
        goodsName = goodsInfo.name,
        goodsPrice = goodsInfo.price,
        goodsDiscount = goodsInfo.discount,
        money = 0,
        currencyCount = goodsInfo.discount / 10,
        goodsType = goodsInfo.typeCard,
        urlParams = ""
      }
      rechargeData.operaterOrderId = ""
      rechargeData.goodsImageUrl = ""
      Logic:Get("Sdk"):Recharge(rechargeData)
      return
    end
  end
  if Logic:Get("System"):IsOperator("wo") then
    local strMac = Logic:Get("System"):GetMacAddr() or ""
    local strUuid = Logic:Get("System"):GetUniqueId() or ""
    strMac = string.gsub(strMac, ":", "")
    local versionName = CVariableSystem:GetSingleton():GetSysVariable(GV_VERSION)
    local strConfig = Logic:Get("System"):GetOperatorItemFromFile("sdkInfo", "config.dat")
    MsgPlayer:Post("ORDER", {
      goods = goodsId,
      amount = count,
      imei = strUuid,
      mac = strMac,
      channel = strConfig.channel,
      version = versionName
    })
  else
    MsgPlayer:Post("ORDER", {goods = goodsId, amount = count})
  end
end
function class:OnGetOrderId(code, data)
  if Logic:Get("MsgAssist"):OnMsgResult("MsgPlayer", code) then
    return
  end
  if nil == data or nil == data.addition then
    return
  end
  local splite = string.find(data.addition, "*")
  if nil == splite or splite < 1 then
    return
  end
  local goodsId = string.sub(data.addition, 1, splite - 1)
  if nil == goodsId then
    return
  end
  local count = string.sub(data.addition, splite + 1)
  local goodsInfo = Logic:Get("Recharge"):GetChargeGoodsInfo(goodsId)
  local serverInfo = Logic:Get("Login"):GetLoginInfo()
  local userName = Logic:Get("PlayerInfo"):GetPlayerName() or ""
  if nil == serverInfo or nil == goodsInfo then
    return
  end
  local rechargeData = {
    orderId = data.serial,
    accountId = serverInfo.account,
    userName = userName,
    goodsId = goodsInfo.id,
    goodsCount = count,
    serverId = serverInfo.server,
    serverName = serverInfo.name,
    goodsName = goodsInfo.name,
    goodsPrice = goodsInfo.price,
    goodsDiscount = goodsInfo.discount,
    money = data.money,
    currencyCount = goodsInfo.discount / 10,
    goodsType = goodsInfo.typeCard,
    urlParams = data.url or "",
    extension = goodsInfo.extension or ""
  }
  if Logic:Get("System"):IsOperator("wo") then
    rechargeData.orderId = data.uniPayOrder
  end
  rechargeData.orderId = tostring(rechargeData.orderId)
  local bCombineOrderId = Logic:Get("System"):IsUseCombineOrderId()
  if bCombineOrderId then
    rechargeData.orderId = rechargeData.serverId .. "_" .. rechargeData.orderId
  end
  local operatorId = Logic:Get("System"):GetOperator("operatorId")
  rechargeData.operaterOrderId = "0000000000000000"
  rechargeData.operaterOrderId = rechargeData.operaterOrderId .. operatorId .. tostring(serverInfo.server) .. tostring(data.serial)
  if Logic:Get("System"):IsOperator("oppo") then
    rechargeData.goodsName = "*" .. goodsInfo.name
  end
  if self.orderIdUsed[data.serial] then
    log4misc:warn("orderid already used:" .. data.serial)
    return
  end
  self.orderIdUsed[data.serial] = true
  if not Logic:Get("System"):IsOperator("appstore") then
    Logic:Get("Sdk"):Recharge(rechargeData)
  else
    Logic:Get("Sdk"):OnGetOrderId(rechargeData)
  end
end
function class:SetLockBuy(bLock)
  self.lockBuy = bLock
  self:FireEvent(EVT.REFRESH_RECHARGE_LIST)
end
function class:IsLockBuy()
  return self.lockBuy
end
function class:LockUI(time)
  time = time or 30000
  self:SetLockBuy(true)
  self:EventTracer():Cancel("FORCE_UNLOCK")
  Singleton(Timer):After(time, self:Event("FORCE_UNLOCK", function()
    self:SetLockBuy(false)
  end))
end
function class:UnLockUI()
  if self:EventTracer():Exist("FORCE_UNLOCK") then
    self:EventTracer():Cancel("FORCE_UNLOCK")
  end
  self:SetLockBuy(false)
end
function class:GetChargeGoodsType()
  local CHANNEL_TYPE = {
    appstore = 1,
    twkk = 2,
    mmbill = 3,
    taiwsqios = 6,
    appstoreJS = 7,
    korifree = 21,
    korifreeSK = 22,
    korifreeKT = 23
  }
  local OPERATOR_TYPE = {
    u6 = 4,
    appchina = 5,
    myapp = 8,
    wo = 9
  }
  local operator = Logic:Get("System"):GetOperatorName()
  if nil ~= operator and nil ~= OPERATOR_TYPE[operator] then
    return OPERATOR_TYPE[operator]
  end
  local channel = Logic:Get("System"):GetChannel()
  if nil ~= channel and nil ~= CHANNEL_TYPE[channel] then
    return CHANNEL_TYPE[channel]
  end
  return 0
end
function class:GetChargeData()
  self.recharge = {}
  self.lstRecharge = {}
  local goodsType = self:GetChargeGoodsType()
  for i = 1, KFDBGetRecordAmt("ChargeGoods") do
    local info = KFDBGetRecordByIdx("ChargeGoods", i)
    if info.isapp == goodsType then
      table.insert(self.lstRecharge, info.id)
      local weekVipB = Logic:Get("PlayerInfo"):IsWeekVip()
      if weekVipB and info.typeCard == 2 then
        info.sort = 299
      end
      local MonVipB = Logic:Get("PlayerInfo"):IsMonVip()
      if MonVipB and info.typeCard == 0 then
        info.sort = 298
      end
      local seasonVip = Logic:Get("PlayerInfo"):IsSuperMonVip()
      if seasonVip and info.typeCard == 3 then
        info.sort = 297
      end
      self.recharge[info.id] = info
    end
  end
  table.sort(self.lstRecharge, function(l, r)
    local lInfo = self:GetChargeGoodsInfo(l)
    local rInfo = self:GetChargeGoodsInfo(r)
    if lInfo ~= nil and rInfo ~= nil and lInfo.sort ~= nil and rInfo.sort ~= nil then
      return lInfo.sort > rInfo.sort
    else
      return false
    end
  end)
end
function class:GetChargeGoods()
  self:GetChargeData()
  return self.lstRecharge
end
function class:GetChargeGoodsInfo(idGoods)
  if nil == self.recharge or table.empty(self.recharge) then
    self:GetChargeData()
  end
  local info = idGoods and self.recharge[idGoods] or nil
  if nil == info then
    log4misc:warn("GetChargeGoodsInfo failed:" .. (idGoods and idGoods or "id is nil"))
  end
  return info
end
