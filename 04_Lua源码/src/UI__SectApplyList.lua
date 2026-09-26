module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
require("Timer")
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
  Logic:Get("Sect"):On(Logic.Sect.EVT.LIST_APPLY_USER_OK, self:Event("refresh"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.CHECK_USER_OK, self:Event("update"))
  self.data = {}
  self.info = {}
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  self.staPageNum:setStyle(kCCLabelTTFStyleOutline)
  self.curPage = 1
  if self.info.count == nil then
    self.maxPage = 1
  else
    self.maxPage = math.ceil(self.info.count / self.info.size)
  end
  self.maxPage = 1 > self.maxPage and 1 or self.maxPage
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pCList, self.maxPage, true)
  self.m_pCList:addChild(self.tableViewControl.tableView)
  self:setLR()
  Logic:Get("Sect"):PostListApplyUser(1)
end
function prototype:refresh(data)
  if not data then
    return
  end
  self.info = data
  self.maxPage = math.ceil(data.count / data.size)
  self.maxPage = self.maxPage < 1 and 1 or self.maxPage
  self:setLR()
  self.data = data.data
  self.tableViewControl:RequireUpdate(self.maxPage)
end
function prototype:update()
  if self.data == nil then
    return
  end
  if #self.data == 1 then
    self.curPage = 1 < self.curPage and self.curPage - 1 or 1
  end
  Logic:Get("Sect"):PostListApplyUser(self.curPage)
end
function prototype:setLR()
  if self.maxPage and self.maxPage > 1 then
    self.imgPageLeft:setVisible(true)
    self.imgPageRight:setVisible(true)
  else
    self.imgPageLeft:setVisible(false)
    self.imgPageRight:setVisible(false)
  end
end
function prototype:onLeftClicked(sender, event)
  SceneHelper:runWithScene("SectManage", self.rootNode)
end
function prototype:onPrevPageBtnClicked(sender, event)
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onNextPageBtnClicked(sender, event)
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(1)
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(599, 123)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("SectApplyListItem", self.rootNode)
    subScene:reFrashInfo(self.data[index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):reFrashInfo(self.data[index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  curPage = curPage or 1
  self.staPageNum:setString(string.format("%d/%d", curPage, self.maxPage))
  if self.data and next(self.data) ~= nil then
    return #self.data
  else
    return 0
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.curPage = curPage
  Logic:Get("Sect"):PostListApplyUser(curPage)
  self.data = {}
  self.tableViewControl:RequireUpdate()
end
