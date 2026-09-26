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
  local mallData = Logic:Get("Preciousroom"):GetMallData()
  self.ttfDesr:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTitle:setString(mallData.title)
  self.ttfDesr:setString(mallData.desInPage)
  local showTemplete = {
    XIAN = "images/MallRace/xian.png",
    LING = "images/MallRace/ling.png",
    YAO = "images/MallRace/yao.png"
  }
  if showTemplete[mallData.showTemplete] then
    local spr = CCSprite:create(showTemplete[mallData.showTemplete])
    if spr then
      self.sprShowGirl:setDisplayFrame(spr:displayFrame())
    end
  end
  self.nodCost:create(0, "YELLOW_E_NUM")
  self.nodCost:setAlign("RIGHT", "CENTER")
  local MAX_ITEM = 6
  for i = 1, MAX_ITEM do
    local str = string.format("ccbItem%d", i)
    if self[str] then
      self[str]:setVisible(false)
    end
  end
  Logic:Get("Preciousroom"):PostLoadShop()
  Logic:Get("Preciousroom"):On(Logic.Preciousroom.EVT.LOAD_SHOP, self:Event("onLoadShop"))
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("Mall", self.rootNode)
end
function prototype:onBtnCharge(sender, event)
  SceneHelper:runWithScene("MallRaceShopShow", self.rootNode)
end
function prototype:onLoadShop()
  local cost = Logic:Get("Preciousroom"):GetRefreshCost()
  self.nodCost:setValue(cost)
  local info = Logic:Get("Preciousroom"):GetPreciousInfo()
  if info.time then
    self.nodRefresh:setVisible(true)
  else
    self.nodRefresh:setVisible(false)
  end
  if self:IsCanRefresh() then
    self.ccnodeButton:setVisible(true)
    self.ccnodeGold:setVisible(true)
    self.nodRefresh:setPosition(ccp(400, 275))
  else
    self.ccnodeButton:setVisible(false)
    self.ccnodeGold:setVisible(false)
    self.nodRefresh:setPosition(ccp(330, 213))
  end
  self:RefreshTime()
  self:RefreshList()
  if not self.eventTracer:Exist("RefreshTime") then
    Singleton(Timer):Repeat(1000, self:Event("RefreshTime"))
  end
end
function prototype:IsCanRefresh(...)
  local mallinfo = Logic:Get("Preciousroom"):GetMallData() or {}
  if table.empty(mallinfo) then
    return false
  end
  local info = KFDBGetRecord("ConfigValue", "PRECIOUSROOM:CAN_REFRESH")
  if table.empty(info or {}) then
    log4misc:warn("assign to undeclared variable 'PRECIOUSROOM:CAN_REFRESH'")
    return
  end
  local content = json.decode(info.content) or {}
  local key = tostring(mallinfo.id)
  return content[key]
end
function prototype:RefreshList()
  local list = Logic:Get("Preciousroom"):GetPreciousInfo()
  local MAX_ITEM = 6
  for i = 1, MAX_ITEM do
    local rec = KFDBGetRecord("PrRewardCost", list.treasures[i])
    if rec then
      rec.position = i
      local str = string.format("ccbItem%d", i)
      if self[str] then
        self[str]:setVisible(true)
        self[str]:Refresh(rec)
      end
    end
  end
end
function prototype:RefreshTime()
  self.ttfTime:setString("")
  local info = Logic:Get("Preciousroom"):GetPreciousInfo()
  local refreshTime = info.time
  if refreshTime then
    local diffTime = Logic:Get("System"):DiffTime(refreshTime / 1000)
    local countDown = Logic:Get("System"):SecToDay(diffTime)
    if diffTime > 0 then
      countDown.hour = countDown.hour + countDown.day * 24
      local str = TwGetStr(102008, countDown.hour or 0, countDown.min or 0, countDown.sec or 0)
      self.ttfTime:setString(str)
      return
    end
  end
end
function prototype:onBtnRefresh(sender, event)
  local cost = Logic:Get("Preciousroom"):GetRefreshCost()
  local jade = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if cost > jade then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Prompt:ConfirmRecord(self, "", TwGetStr(110621, cost), self.PostRefresh, Prompt.PROMPT_TYPE.SELECT, nil, Logic.SureConfirm.RECORD_TYPE.TREASUREROOM_REFRESH)
end
function prototype:PostRefresh()
  Logic:Get("Preciousroom"):PostRefresh()
end
