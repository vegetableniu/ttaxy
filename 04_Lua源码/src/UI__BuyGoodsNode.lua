module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:initialize(...)
  super.initialize(self, ...)
  self.idGoods = nil
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfPrice:setStyle(kCCLabelTTFStyleOutline)
  self.ttfContent1:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTime:setStyle(kCCLabelTTFStyleOutline)
  self.ttfFeedBack:setStyle(kCCLabelTTFStyleOutline)
  self.ttfDesr:setStyle(kCCLabelTTFStyleOutline)
  self:createGoodsImg()
end
function prototype:ReFreshInfo(idGoods, lstIdx)
  if nil == idGoods then
    return false
  end
  self:clearUI()
  local goodsInfo = Logic:Get("Recharge"):GetChargeGoodsInfo(idGoods)
  if nil == goodsInfo then
    self:setVisible(false)
    return
  end
  self:setVisible(true)
  self.idGoods = idGoods
  self.ttfName:setString(goodsInfo.name)
  local price = Logic:Get("System"):IsUseShowPrice() and goodsInfo.showcount or goodsInfo.price
  if not Logic:Get("System"):IsOperator("ilovewebgame") and not Logic:Get("System"):IsOperator("tstore") or not price then
    price = price / 100
  end
  if Logic:Get("System"):IsChannel("korifree") then
    self.ttfPrice:setString(TwGetStr(103097, Logic:Get("System"):GetMoneyStr(price)))
  else
    self.ttfPrice:setString(TwGetStr(103065, Logic:Get("System"):GetMoneyStr(price)))
  end
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  local charge = wallet.totalCharge or 0
  if charge > 0 then
    self.ttfContent1:setString(goodsInfo.desc)
  else
    self.ttfContent1:setString(goodsInfo.firstDesc)
  end
  local bLockBuy = Logic:Get("Recharge"):IsLockBuy()
  self.btnBuy:setEnabled(not bLockBuy)
  local reward = json.decode(goodsInfo.reward)
  local playerInfo = Logic:Get("PlayerInfo"):GetPlayerAllInfo()
  local vipInfo = playerInfo.vip
  if vipInfo ~= nil then
    local haveTime
    if goodsInfo.typeCard == 0 then
      local boolVip = Logic:Get("PlayerInfo"):IsMonVip()
      if vipInfo.vipTime then
        haveTime = Logic:Get("System"):SecToDay(Logic:Get("System"):DiffTime(vipInfo.vipTime / 1000))
      end
      self:setSurplusDay(boolVip, haveTime, reward)
    elseif goodsInfo.typeCard == 2 then
      local boolVip = Logic:Get("PlayerInfo"):IsWeekVip()
      if vipInfo.weekTime then
        haveTime = Logic:Get("System"):SecToDay(Logic:Get("System"):DiffTime(vipInfo.weekTime / 1000))
      end
      self:setSurplusDay(boolVip, haveTime, reward)
    elseif goodsInfo.typeCard == 3 then
      local boolVip = Logic:Get("PlayerInfo"):IsSuperMonVip()
      if vipInfo.monsthTime then
        local diffTime = Logic:Get("System"):DiffTime(vipInfo.monsthTime / 1000)
        haveTime = Logic:Get("System"):SecToDay(diffTime)
      end
      self:setSurplusDay(boolVip, haveTime, reward)
    end
  end
  self:setAdInfo(goodsInfo, lstIdx)
end
function prototype:setAdInfo(goodsInfo, lstIdx)
  if Logic:Get("Gift"):IsOpenActivity("OLD_USER_CHARGE_TREBLE") or Logic:Get("Gift"):IsOpenActivity("NEW_USER_CHARGE_TREBLE") then
    if lstIdx <= 3 then
      self:clearUI()
      self.btnBuy:setVisible(false)
      self.sprGoodImg:setVisible(false)
      self.sprBg:setVisible(false)
    else
      self.ttfName:setString(goodsInfo.activeCharge or "")
      self.ttfContent1:setString(goodsInfo.activeGiftRate or "")
      self.ttfFeedBack:setString(goodsInfo.activeGift or "")
      local x = self.ttfName:getPositionX() + self.ttfName:getContentSize().width + 5
      self.ttfFeedBack:setPositionX(x)
    end
    if lstIdx == 3 then
      local spr = CCSprite:create("images/Activity/chargeTrible.png")
      if spr then
        self.sprAdv:setDisplayFrame(spr:displayFrame())
      end
      local strTab = Logic:Get("Gift"):GetTimeStrByType("OLD_USER_CHARGE_TREBLE")
      if not table.empty(strTab or {}) then
        self.ttfTime:setString(TwGetStr(103362, strTab[1]))
        return
      end
      local strTab = Logic:Get("Gift"):GetTimeStrByType("NEW_USER_CHARGE_TREBLE")
      if not table.empty(strTab or {}) then
        self.ttfTime:setString(TwGetStr(103362, strTab[1]))
      end
    end
  end
end
function prototype:setSurplusDay(boolVip, haveTime, reward)
  if boolVip then
    local day = 0
    if haveTime == nil then
      return
    end
    if haveTime.day < 1 then
      if 0 < haveTime.min or 0 < haveTime.hour then
        day = 1
      end
    else
      day = haveTime.day
    end
    local str = TwGetStr(103135, day)
    for i = 1, #reward do
      if reward[i].type ~= nil and reward[i].type == "VIP_TIME" then
        self.btnBuy:setEnabled(false)
        self.ttfProgress:setString(str)
        self.ttfProgress:setStyle(kCCLabelTTFStyleOutline)
      end
    end
  else
    for i = 1, #reward do
      if reward[i].type ~= nil and reward[i].type == "VIP_TIME" then
        local str = ""
        self.ttfProgress:setString(str)
        self.ttfProgress:setStyle(kCCLabelTTFStyleOutline)
      end
    end
  end
end
function prototype:clearUI()
  self.ttfName:setString("")
  self.ttfPrice:setString("")
  self.ttfContent1:setString("")
  self.ttfProgress:setString("")
  self.ttfTime:setString("")
  self.ttfFeedBack:setString("")
  self.ttfDesr:setString("")
  self.btnBuy:setEnabled(true)
  self.btnBuy:setVisible(true)
  self.sprGoodImg:setVisible(true)
  self.sprBg:setVisible(true)
  local spr = CCSprite:create("images/public/clarity05.png")
  if spr then
    self.sprAdv:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:createGoodsImg()
  local strGoods = "images/Other/xianyu.png"
  local goodsInfo = Logic:Get("Recharge"):GetChargeGoodsInfo(self.idGoods)
  if goodsInfo ~= nil then
    if goodsInfo.typeCard == 0 then
      strGoods = "images/Other/monVip.png"
    elseif goodsInfo.typeCard == 2 then
      strGoods = "images/Other/weekVip.png"
    elseif goodsInfo.typeCard == 3 then
      strGoods = "images/Other/seasonVip.png"
    end
  end
  local ccSprite = CCSprite:create(strGoods)
  if ccSprite then
    self.sprGoodImg:setDisplayFrame(ccSprite:displayFrame())
  end
end
function prototype:onBtnBugGood()
  if Logic:Get("System"):IsOperator("ilovewebgame") then
    local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
    local charge = wallet.totalCharge or 0
    local goodsInfo = Logic:Get("Recharge"):GetChargeGoodsInfo(self.idGoods)
    if (goodsInfo.typeCard == 0 or goodsInfo.typeCard == 2) and charge <= 0 then
      Logic:Get("SureConfirm"):SetAni(true)
      Prompt:Confirm(self, 0, TwGetStr(103099), self.OpenRechargeWap)
    else
      self:OpenRechargeWap()
    end
  else
    self:OpenRechargeWap()
  end
end
function prototype:OpenRechargeWap()
  if CTwUtil.E_TP_WIN32 == CTwUtil:GetPlatform() then
    local loginInfo = Logic:Get("Login"):GetLoginInfo()
    if nil ~= loginInfo and 11111 ~= loginInfo.port then
      os.execute("cmd /c start iexplore http://opx014.9yuonline.com:443/manager/mtcharge.jsp__")
    else
      os.execute("cmd /c start iexplore http://192.168.10.160:6000/manager/mtcharge.jsp")
    end
    return
  end
  if Logic:Get("System"):IsCloseCharge() then
    Prompt:Tip(10126)
    return
  end
  if nil == self.idGoods then
    return
  end
  if not Logic:Get("System"):IsOperator("appstore") then
    Logic:Get("Recharge"):BuyGoods(self.idGoods)
    return
  end
  local goodsInfo = Logic:Get("Recharge"):GetChargeGoodsInfo(self.idGoods)
  local serverInfo = Logic:Get("Login"):GetLoginInfo()
  local userName = Logic:Get("PlayerInfo"):GetPlayerName() or ""
  if nil == serverInfo or nil == goodsInfo then
    return
  end
  local rechargeData = {
    accountId = serverInfo.account,
    userName = userName,
    goodsId = goodsInfo.id,
    goodsCount = 1,
    serverId = serverInfo.server,
    serverName = serverInfo.name,
    goodsName = goodsInfo.name,
    goodsPrice = goodsInfo.price,
    goodsDiscount = goodsInfo.discount
  }
  Logic:Get("Sdk"):Recharge(rechargeData)
end
