module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
require("TableViewEx")
RET = Enum({"OK", "CANCEL"})
local MEMBER_TYPE = TypeDef("com.eyu.mt.module.menpai.model.JobType")
function prototype:onEnter()
  self.btnLeft:setVisible(false)
  self.btnRight:setVisible(false)
  self.labPage:setString("1/1")
  self.curPage = 1
  Logic:Get("Sect"):PostGetPartnerList(1)
  Logic:Get("Sect"):On(Logic.Sect.EVT.GET_PARTNER_LIST, self:Event("refreshPartnerList"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.KICKUSER_FINISHED, self:Event("OnEvtKickUser"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.GRANT_FINISHED, self:Event("onEvtGrant"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.DEMISE_FINISHED, self:Event("onEvtDemise"))
end
function prototype:onBtnReturn(sender, event)
  if Logic:Get("Sect"):isFromMain() then
    Logic:Get("Sect"):setIsFromMain(false)
    SceneHelper:runWithScene("SectMain", self.rootNode)
  else
    SceneHelper:runWithScene("SectManage", self.rootNode)
  end
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
function prototype:stopGrabTight(clickType)
  if clickType == RET.OK then
    Logic:Get("Sect"):PostStopGrabRight()
  elseif clickType == RET.CANCEL then
  end
end
local sortByLastLogin = function(a, b)
  return a.lastLogin <= b.lastLogin
end
function prototype:refreshPartnerList()
  self.data = Logic:Get("Sect"):GetMemberList()
  if self.data.data and not table.empty(self.data.data) then
    self.page = math.ceil(self.data.count / self.data.size)
    self.labPage:setString(string.format("%d/%d", self.data.page, self.page))
    self:setLR()
    if not self.tableViewControl then
      self.tableViewControl = TableViewEx.prototype:createList(self, self.lstMember, self.page, true)
      self.lstMember:addChild(self.tableViewControl.tableView)
    end
    self.tableViewControl:RequireUpdate()
  end
end
function prototype:OnEvtKickUser()
  if self.data == nil or self.data.data == nil then
    return
  end
  if table.empty(self.data.data) then
    self.curPage = self.curPage > 1 and self.curPage - 1 or 1
    Logic:Get("Sect"):PostGetPartnerList(self.curPage)
  else
    self:refreshPartnerList()
  end
end
function prototype:setLR()
  if self.page then
    local enable = self.page ~= 1
    self.btnLeft:setVisible(enable)
    self.btnRight:setVisible(enable)
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 130)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("SectMemberItem", self.rootNode)
    subScene:refresh(self.data.data[index + 1])
    cell:addChild(subScene, 1, 2)
  else
    cell:getChildByTag(2):refresh(self.data.data[index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  self.curPage = curPage or 1
  if self.data.data then
    return #self.data.data
  else
    return 0
  end
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.labPage:setString(string.format("%d/%d", curPage, self.page))
  Logic:Get("Sect"):PostGetPartnerList(curPage)
end
function prototype:onEvtGrant()
  self.data = Logic:Get("Sect"):GetMemberList()
  self.tableViewControl.tableView:refreshData()
end
function prototype:onEvtDemise()
  self.data = Logic:Get("Sect"):GetMemberList()
  self.tableViewControl.tableView:refreshData()
end
