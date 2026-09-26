module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = Tw.Controller.prototype:extend()
local WIN_WIDTH, WIN_HEIGHT = 569, 160
local FRIENDNAMESIZE = 12
local FONT_SIZE = 29
function prototype:initialize()
  super.initialize(self)
  Logic:Get("Sect"):On(Logic.Sect.EVT.GET_MENPAI_LIST_OK, self:Event("refresh"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.APPLY_OR_NOT_OK, self:Event("updateData"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.LIST_INVITE_MENPAI_OK, self:Event("playFlag"))
  local rec = KFDBGetRecord("ConfigValue", "MENPAI:LIST_PAGE_SIZE")
  self.pageCount = rec and tonumber(rec.content) or 10
  self.data = {}
  self.seekName = nil
end
function prototype:onEnter()
  super.onEnter(self)
  self.staPageNum:setStyle(kCCLabelTTFStyleOutline)
  self.labTips:setStyle(kCCLabelTTFStyleOutline)
  self.maxPage = math.ceil(#self.data / self.pageCount)
  self.maxPage = self.maxPage < 1 and 1 or self.maxPage
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pCList, self.maxPage == 0 and 1 or self.maxPage, true)
  self.m_pCList:addChild(self.tableViewControl.tableView)
  self:setLR()
  self.edtSectName:setMaxLens(FRIENDNAMESIZE)
  self.edtSectName:setFontSize(FONT_SIZE)
  Logic:Get("Sect"):PostGetMenpaiList(self.seekName, 1)
  Logic:Get("Sect"):PostListInviteMenpai(1)
end
function prototype:refresh(data)
  if not self.seekName and data.count == 0 then
    self.labTips:setString(TwGetStr(110009))
  else
    self.labTips:setString("")
  end
  if not data then
    return
  end
  if self.seekName and data.count == 0 then
    Prompt:Fail(TwGetStr(110105))
    return
  end
  self.maxPage = math.ceil(data.count / data.size)
  self.maxPage = self.maxPage < 1 and 1 or self.maxPage
  self:setLR()
  self.data = data.data
  self.tableViewControl:RequireUpdate(self.maxPage)
end
function prototype:updateData(Sect)
  if not Sect or next(Sect) == nil then
    return
  end
  for k, v in pairs(self.data) do
    if Sect.id == v.id then
      self.data[k] = Sect
      self.tableViewControl:RequireUpdate(self.maxPage, false)
      self.tableViewControl.tableView:setTableViewOffset(k)
      return
    end
  end
end
function prototype:playFlag()
  local inviteNum = Logic:Get("Sect"):getInviteNum()
  if not inviteNum then
    return
  end
  if inviteNum ~= 0 then
    self.imgFlag:removeAllChildrenWithCleanup(true)
    Logic:Get("AniMgr"):RunCCBAni("UI/uinew", self.imgFlag, nil, 1, nil, nil, nil, -1)
    self.imgFlag:setVisible(true)
  end
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
  SceneHelper:runWithScene("Home", self.rootNode)
end
function prototype:onBtnSeekSect(sender, event)
  self.seekName = self.edtSectName:getString()
  local flag = Logic:Get("Sect"):checkSpecial(self.seekName)
  if not flag then
    Prompt:Fail(10075)
    return
  end
  Logic:Get("Sect"):PostGetMenpaiList(self.seekName, 1)
  self.tableViewControl:TurnPageTo(1)
end
function prototype:onRightClicked(sender, event)
  SceneHelper:runWithScene("SectCreat", self.rootNode)
end
function prototype:OnBtnInvite(sender, event)
  SceneHelper:runWithScene("SectInviteList", self.rootNode)
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
function prototype:cellSizeForTable()
  return CCSizeMake(WIN_WIDTH, WIN_HEIGHT)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("SectListItem", self.rootNode)
    subScene:refreshInfo(self.data[index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):refreshInfo(self.data[index + 1])
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
  Logic:Get("Sect"):PostGetMenpaiList(self.seekName, curPage)
  self.data = {}
  self.tableViewControl:RequireUpdate()
end
