module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local NUMS_PER_PAGE = 15
local MAX_SELECTED = 4
function prototype:onEnter()
  super.onEnter(self)
  self:init()
  Logic:Get("Exchange"):On(Logic.Exchange.EVT.MSG_UPDATE_LIST, self:Event("OnUpdateList"))
  local ids = Logic:Get("Exchange"):GetExchangeId()
  local data = Logic:Get("Exchange"):GetComsumeList(ids[#ids])
  self:updateTbv(data)
  self:OnUpdateList()
end
function prototype:onExit()
end
function prototype:init()
  Logic:Get("Exchange"):loadToTempCards()
  self.ttfPage:setStyle(kCCLabelTTFStyleOutline)
  self.ttfNum:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:updateTbv(data)
  if not data then
    return
  end
  self.data = data
  self.allNums = #data or 0
  self.allPage = math.ceil(self.allNums / NUMS_PER_PAGE) or 0
  if not self.tableViewControl then
    self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pList, self.allPage)
    if self.tableViewControl then
      self.curPage = 1
      self.ttfPage:setString("1/" .. self.allPage)
      self.m_pList:addChild(self.tableViewControl.tableView)
    end
  end
  if self.tableViewControl then
    self.tableViewControl:RequireUpdate()
  end
end
function prototype:onBtnConfirm(...)
  Logic:Get("Exchange"):loadToCards()
  Logic:Get("Exchange"):PostPopTip()
  SceneHelper:removeScene("ExchangeChoose")
end
function prototype:onBtnReturn(...)
  SceneHelper:removeScene("ExchangeChoose")
end
function prototype:numberOfCellsInTableView(curPage)
  if curPage == 0 then
    return 0
  end
  if curPage ~= self.allPage then
    return NUMS_PER_PAGE
  end
  return self.allNums - (curPage - 1) * NUMS_PER_PAGE
end
function prototype:cellSizeForTable()
  return CCSizeMake(580, 120)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local idx = (curPage - 1) * NUMS_PER_PAGE + index + 1
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ExchangeChooseItem", self.rootNode)
    subScene:refresh(self.data[idx], self.bFull)
    cell:addChild(subScene, 0, 1)
  else
    cell:getChildByTag(1):refresh(self.data[idx], self.bFull)
  end
  return cell
end
function prototype:tablePageTurn(curPage)
  self.curPage = curPage
  self.ttfPage:setString(curPage .. "/" .. self.allPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:tableCellTouched()
end
function prototype:OnUpdateList()
  local _, count = Logic:Get("Exchange"):GetSelectedCards()
  self.bFull = count >= MAX_SELECTED
  if self.tableViewControl then
    self.tableViewControl:RequireUpdateWithoutAnimat()
  end
  self.ttfNum:setString(TwGetStr(114001, count or 0))
  self.nodeConfirm:setVisible(self.bFull)
end
