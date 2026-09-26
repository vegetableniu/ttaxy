module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local PAGE_NUM = 20
local RESET_POS_TYPE = {RESET_TOP = 0, RESET_OLD_POS = 1}
function prototype:onEnter()
  local card = Logic:Get("Hero"):GetMenpaiCard()
  local cardInfoList = Logic:Get("Hero"):GetHeroInfosByIds(card)
  self.infoList = {}
  for i, v in ipairs(cardInfoList) do
    local rec = Logic:Get("Hero"):GetHeroInfoByBaseId(v.baseId)
    if rec and rec.nextId and rec.nextId > 0 then
      self.infoList[#self.infoList + 1] = v
    end
  end
  if table.empty(self.infoList) then
    self.ttfPage:setString("0/0")
    return
  end
  for k, v in pairs(self.infoList or {}) do
    if 0 <= Logic:Get("Sect"):checkCardEvolution(v.baseId) then
      v.sort = 1
    else
      v.sort = 2
    end
  end
  local sort = function(a, b)
    if a.sort == b.sort then
      return a.baseId < b.baseId
    end
    return a.sort < b.sort
  end
  table.sort(self.infoList, sort)
  self.checked = {}
  self.checkItems = {}
  self.curPage = 1
  self.page = math.ceil(#self.infoList / PAGE_NUM)
  self:initTurnLR()
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pListCard, self.page)
  self.m_pListCard:addChild(self.tableViewControl.tableView)
  self.tableViewControl:RequireUpdate()
  Logic:Get("Sect"):On(Logic.Sect.EVT.REFRESH_CARD_LIST, self:Event("refreshCardList"))
end
function prototype:initTurnLR()
  local visible = true
  if self.page == 1 then
    visible = false
  end
  self.btnLeft:setVisible(visible)
  self.btnRight:setVisible(visible)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("SectDemogCardMix", self.rootNode)
end
function prototype:onBtnLeftTurn(sender, event)
end
function prototype:onBtnRightTurn(sender, event)
end
function prototype:cellSizeForTable()
  return CCSizeMake(560, 120)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local idx = (self.curPage - 1) * PAGE_NUM + index + 1
  if not cell then
    cell = CCTableViewCellEx:create()
    local item = Tw.Controller:load("SectDemogCardItem", self.rootNode)
    item:refresh(self.infoList[idx], self.checkItems[index + 1] or false)
    cell:addChild(item, 1, 2)
  else
    cell:getChildByTag(2):refresh(self.infoList[idx], self.checkItems[index + 1] or false)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  local cellsNum = 0
  self.ttfPage:setString(curPage .. "/" .. self.page)
  if not table.empty(self.infoList) then
    if curPage < self.page then
      cellsNum = PAGE_NUM
    else
      cellsNum = #self.infoList - (curPage - 1) * PAGE_NUM
    end
  end
  self.cellsNum = cellsNum
  return cellsNum
end
function prototype:tablePageTurn(curPage)
  self.curPage = curPage
  self.tableViewControl:RequireUpdate()
end
function prototype:tableCellTouched(curPage)
end
function prototype:refreshCardList()
  self.checkItems = {}
  local preNum = (self.curPage - 1) * PAGE_NUM
  local checkedId = Logic:Get("Sect"):GetCheckedId()
  for i = 1, self.cellsNum do
    if self.infoList[preNum + i].id == checkedId then
      table.insert(self.checkItems, true)
    else
      table.insert(self.checkItems, false)
    end
  end
  self.tableViewControl:RequireUpdate(self.page, false, RESET_POS_TYPE.RESET_OLD_POS)
end
