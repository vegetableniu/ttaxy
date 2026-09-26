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
  self.nodCost:create(0, "YELLOW_E_NUM")
  self.nodCost:setAlign("RIGHT", "CENTER")
  local titlePath = Logic:Get("CultivateShop"):GetTitlePath()
  local spr = CCSprite:create(titlePath)
  if spr then
    self.sprTitle:setDisplayFrame(spr:displayFrame())
  end
  self.data = {}
  self.tableViewControl = TableViewEx.prototype:createList(self, self.nodList, 1)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.nodList:addChild(self.tableViewControl.tableView)
  Logic:Get("CultivateShop"):On(Logic.CultivateShop.EVT.GET_INFO, self:Event("onGetInfo"))
  Logic:Get("CultivateShop"):PostGetInfo()
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:removeScene("CultivateExchange", self.rootNode)
end
function prototype:onBtnCharge(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
function prototype:onBtnBg(sender, event)
end
function prototype:onBtnRefresh(sender, event)
  if table.empty(self.shopInfo or {}) then
    return
  end
  local maxRefreshTimes = Logic:Get("Egg"):GetCongifValueByKey("CULTIVATESHOP:BUY_REFRESH_LIMIT")
  if maxRefreshTimes <= self.shopInfo.costRefreshTimes then
    Prompt:Fail(110901)
    return
  end
  local cost = self:GetRefreshCost()
  local jade = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if cost > jade then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Prompt:ConfirmRecord(self, "", TwGetStr(110621, cost), self.PostRefresh, Prompt.PROMPT_TYPE.SELECT, nil, "CULT_REFRESH")
end
function prototype:PostRefresh()
  Logic:Get("CultivateShop"):PostCostRefresh()
end
function prototype:onGetInfo()
  self.shopInfo = Logic:Get("CultivateShop"):GetShopInfo()
  local cost = self:GetRefreshCost()
  self.nodCost:setValue(cost)
  self:RefreshTime()
  self:RefreshList()
  if not self.eventTracer:Exist("RefreshTime") then
    Singleton(Timer):Repeat(1000, self:Event("RefreshTime"))
  end
end
function prototype:RefreshList()
  self.data = {}
  local exchanged = table.invert(self.shopInfo.exchanges or {})
  for idx, id in ipairs(self.shopInfo.onItems) do
    local rec = KFDBGetRecord("ShopItemSetting", id) or {}
    rec.isExchanged = exchanged[idx] and true or false
    table.insert(self.data, rec)
  end
  self.tableViewControl:RequireUpdate()
end
function prototype:GetRefreshCost()
  if table.empty(self.shopInfo or {}) then
    return 0
  end
  local rec = KFDBGetRecord("ConfigValue", "CULTIVATESHOP:BUY_REFRESH_COSTS")
  local recTab = json.decode(rec.content or "[]") or {}
  local idx = self.shopInfo.costRefreshTimes + 1
  if idx > #recTab then
    idx = #recTab or idx
  end
  return recTab[idx] or 0
end
function prototype:RefreshTime()
  self.ttfTime:setString("")
  local refreshTime = self.shopInfo.autoRefreshDate
  if refreshTime then
    local diffTime = Logic:Get("System"):DiffTime(refreshTime / 1000)
    local countDown = Logic:Get("System"):SecToDay(diffTime)
    if diffTime > 0 then
      countDown.hour = countDown.hour + countDown.day * 24
      local str = string.format("%02d:%02d:%02d", countDown.hour or 0, countDown.min or 0, countDown.sec or 0)
      self.ttfTime:setString(str)
    end
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(399, 97)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local idx = index + 1
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("CultivateExchangeItem", self.rootNode)
    cell:addChild(subScene, 0, 2)
  end
  cell:getChildByTag(2):refreshGood(self.data[idx], idx)
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  return #self.data
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
