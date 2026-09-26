module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local DEFAULT_ITEM = 10
local RESET_POS_TYPE = {RESET_TOP = 0, RESET_OLD_POS = 1}
function prototype:initialize(...)
  super.initialize(self, ...)
  self.data = {}
  self.devilCnt = 0
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  Logic:Get("Sect"):On(Logic.Sect.EVT.ON_LIST_DEMOG, self:Event("refresh"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.GET_DEMOG_REWARD_OK, self:Event("OnUpdateDemogList"))
  self.curPage = 1
  self.inScene = true
  self.btnLeft:setVisible(false)
  self.btnRight:setVisible(false)
  Logic:Get("Sect"):PostListDemog(1)
end
function prototype:onExit()
  self.inScene = false
end
function prototype:refresh()
  self.data = Logic:Get("Sect"):GetDemogListInfo()
  if self.data and self.data.count ~= 0 and not self.tableViewControl then
    self.page = math.ceil(self.data.count / self.data.size)
    self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pList, self.page, true)
    self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
    self.m_pList:addChild(self.tableViewControl.tableView)
    if not self.eventTracer:Exist("onTimer") then
      Singleton(Timer):Repeat(1000, self:Event("onTimer"))
    end
  end
  self:setLR()
  if self.tableViewControl then
    self.tableViewControl:RequireUpdate()
  else
    self.sprPage:setVisible(false)
  end
end
function prototype:setLR()
  if self.page then
    local enable = self.page ~= 1
    self.btnLeft:setVisible(enable)
    self.btnRight:setVisible(enable)
  end
end
function prototype:OnUpdateDemogList()
  self.curPage = 1
  Logic:Get("Sect"):PostListDemog(1)
end
function prototype:onBtnReturnClicked(sender, event)
  SceneHelper:runWithScene("SectDemogMain", self.rootNode)
end
function prototype:onSummonBtn(sender, event)
  Logic:Get("Sect"):setFromDemogList(true)
  SceneHelper:runWithScene("SectCallDevil", self.rootNode)
end
function prototype:onBtnLeftClicked(sender, event)
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onBtnRightClicked(sender, event)
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(1)
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(560, 140)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local info = self.data.data[index + 1]
  if info == nil then
    return
  end
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("SectDemogListItem", self.rootNode)
    subScene:refresh(info)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):refresh(info)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.data == nil or self.data.count == 0 then
    return 0
  end
  self.page = math.ceil(self.data.count / self.data.size)
  self.ttfPage:setString(curPage .. "/" .. self.page)
  if self.page == curPage then
    local num = self.data.count - (self.page - 1) * self.data.size
    return num
  else
    return self.data.size
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.curPage = curPage
  Logic:Get("Sect"):PostListDemog(curPage)
end
function prototype:onTimer()
  self.tableViewControl.tableView:refreshData()
end
