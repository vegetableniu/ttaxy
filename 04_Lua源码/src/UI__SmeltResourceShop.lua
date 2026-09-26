module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local MAX_PER_PAGE = 4
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  self.ttfTime:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCount1:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCount2:setStyle(kCCLabelTTFStyleOutline)
  self.ttfPage:setStyle(kCCLabelTTFStyleOutline)
  self.nodeArrow:setVisible(false)
  self.page = 1
  self:setCount()
  self.nodCost:create(0, "YELLOW_E_NUM")
  self.nodCost:setAlign("RIGHT", "CENTER")
  self:createTableView()
  Logic:Get("SmeltResourceShop"):PostLoadShop()
  Logic:Get("SmeltResourceShop"):On(Logic.SmeltResourceShop.EVT.GET_INFO, self:Event("onGetInfo"))
  Logic:Get("SmeltResourceShop"):On(Logic.SmeltResourceShop.EVT.SET_TABLEVIEW_TOUCH, self:Event("onSetTableViewTouch"))
end
function prototype:createTableView()
  self.tableViewControl = TableViewEx.prototype:createList(self, self.nodeList, 1, false)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionHorizontal)
  self.tableViewControl:RequireUpdateWithoutAnimat(1)
  self.nodeList:addChild(self.tableViewControl.tableView)
end
function prototype:onBtnExchange(sender, event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnCharge(sender, event)
  SceneHelper:pushScene("SmeltResource", self.rootNode)
end
function prototype:onBtnLeft(sender, event)
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onBtnRight(sender, event)
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(1)
  end
end
function prototype:onBtnRefresh(sender, event)
  local info, isCurruccy = Logic:Get("SmeltResourceShop"):GetRefreshCost()
  if info.amount < info.cost then
    self:promptFailTip(info)
    return
  end
  self.isCurruccy = isCurruccy
  Prompt:ConfirmRecord(self, "", TwGetStr(108817, info.cost, info.name), self.PostRefresh, Prompt.PROMPT_TYPE.SELECT, nil, Logic.SureConfirm.RECORD_TYPE.TREASUREROOM_REFRESH)
end
function prototype:promptFailTip(info)
  if info.type == "GOLD" then
    Logic:Get("Main"):PromptCharge()
  elseif info.type == "COPPER" then
    Prompt:Fail(103031)
  else
    Prompt:Fail(TwGetStr(105762, info.name or ""))
  end
end
function prototype:PostRefresh()
  Logic:Get("SmeltResourceShop"):PostRefresh(self.isCurruccy)
end
function prototype:onGetInfo()
  self:RefreshList()
  self:setCount()
  self:setRefreshImg()
end
function prototype:onSetTableViewTouch(isTouch)
  if self.page == 1 then
    return
  end
  self.tableViewControl.tableView:setTouchEnabled(isTouch)
end
function prototype:setCount()
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  self.ttfCount1:setString(wallet.purple)
  self.ttfCount2:setString(wallet.orange)
end
function prototype:RefreshList()
  local list = Logic:Get("SmeltResourceShop"):GetGoodsList()
  self.page = math.ceil(#list / MAX_PER_PAGE) or 0
  if self.page == 0 then
    return
  end
  local tab = {}
  self.data = {}
  for k, v in pairs(list) do
    table.insert(tab, v)
    if k % 4 == 0 or k == #list then
      table.insert(self.data, tab)
      tab = {}
    end
  end
  if self.page == 1 then
    self.tableViewControl.tableView:setTouchEnabled(false)
    self.nodeArrow:setVisible(false)
    self.tableViewControl:RequireUpdateWithoutAnimat(self.page)
    return
  end
  self.nodeArrow:setVisible(true)
  self.tableViewControl:RequireUpdateWithoutAnimat(self.page)
end
function prototype:RefreshTime()
  self.ttfTime:setString("")
  local refreshTime = Logic:Get("SmeltResourceShop"):GetRefreshTime()
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
function prototype:setRefreshImg()
  local info, isCurruccy, img = Logic:Get("SmeltResourceShop"):GetRefreshCost()
  self.nodCost:setValue(info.cost)
  local spr = CCSprite:create(img)
  if spr then
    self.sprCoinIcon:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(500, 420)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("SmeltResourceShopNode", self.rootNode)
    subScene.layer:refreshInfo(self.data[(index + 1) * curPage])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2)
    cell:getChildByTag(2).layer:refreshInfo(self.data[(index + 1) * curPage])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  self.ttfPage:setString(curPage .. "/" .. self.page)
  if self.data == nil then
    return 0
  end
  return 1
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
