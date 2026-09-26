module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = Tw.Controller.prototype:extend()
local WIN_WIDTH, WIN_HEIGHT = 570, 150
local EDIT_SIZE = 24
local GAP = 20
function prototype:initialize()
  super.initialize(self)
  Logic:Get("Sect"):On(Logic.Sect.EVT.LIST_MESSAGE_OK, self:Event("refresh"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.GIVE_MESSAGE_OK, self:Event("update"))
  local rec = KFDBGetRecord("ConfigValue", "MENPAI:MESSAGE_PAGE_SIZE")
  self.pageCount = rec and tonumber(rec.content) or 10
  rec = KFDBGetRecord("ConfigValue", "MENPAI:MESSAGE_WORD_LIMIT")
  self.editMax = rec and tonumber(rec.content) or 0
  self.data = {}
  self.hasItem = false
  self.ItemHeight = 0
  self.curPage = 1
  self.refreshBtnClicked = false
end
function prototype:dispose(...)
  super.dispose(self)
  Logic:Get("Sect"):setEnterWord(false)
  Logic:Get("Sect"):FireEvent(Logic.Sect.EVT.SET_TABLEVIEW_TOUCH, true)
end
function prototype:onEnter()
  super.onEnter(self)
  self.staPageNum:setStyle(kCCLabelTTFStyleOutline)
  self.edtContent:setMaxLens(self.editMax)
  self.edtContent:setFontSize(EDIT_SIZE)
  self.edtContent:setMulLine(true)
  self.edtContent:setTouchPriority(-255)
  self.isTurnToLast = false
  self.maxPage = math.ceil(#self.data / self.pageCount)
  self.maxPage = self.maxPage < 1 and 1 or self.maxPage
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pCList, self.maxPage)
  self.m_pCList:addChild(self.tableViewControl.tableView)
  self:setLR()
  Logic:Get("Sect"):PostListMessage(1)
end
function prototype:refresh(data)
  if self.refreshBtnClicked then
    self.btnRefresh:setEnabled(false)
    self.refreshBtnClicked = false
  end
  if not data then
    return
  end
  self.maxPage = math.ceil(data.count / data.size)
  self.maxPage = self.maxPage < 1 and 1 or self.maxPage
  self:setLR()
  self:creteItem(data.data)
  local offset = #data.data
  self.tableViewControl:RequireUpdate(self.maxPage, false)
  if self.isTurnToLast then
    self.isTurnToLast = false
  else
    self.tableViewControl.tableView:runUIAnimat()
  end
  self.staPageNum:setString(string.format("%d/%d", self.curPage, self.maxPage))
  if not self.eventTracer:Exist("onTimer") then
    Singleton(Timer):Repeat(1000, self:Event("onTimer"))
  end
  self.tableViewControl.tableView:setTableViewOffset(offset)
end
function prototype:creteItem(data)
  self.ItemHeight = 0
  for i = #data, 1, -1 do
    self.ItemHeight = self.ItemHeight + GAP
    local subScene = Tw.Controller:load("SectWordItem", self.rootNode)
    subScene:refreshInfo(data[i], WIN_WIDTH)
    subScene:setPosition(ccp(0, self.ItemHeight))
    self.ItemHeight = self.ItemHeight + subScene:getContentSizeH()
    table.insert(self.data, subScene)
  end
  if #self.data == 0 then
    self.hasItem = false
  else
    self.ItemHeight = self.ItemHeight + GAP
    self.hasItem = true
  end
end
function prototype:update()
  if self.curPage > 1 then
    self.tableViewControl:TurnPage(1 - self.curPage)
    self.curPage = 1
  else
    Logic:Get("Sect"):PostListMessage(1)
  end
  self.isTurnToLast = true
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
function prototype:onBtnReturn(sender, event)
  if Logic:Get("Sect"):getEnterWord() then
    Logic:Get("Sect"):setEnterWord(false)
    Logic:Get("Sect"):FireEvent(Logic.Sect.EVT.SET_TABLEVIEW_TOUCH, true)
    SceneHelper:removePrompt(self.rootNode)
    return
  end
  SceneHelper:runWithScene("SectMain", self.rootNode)
end
function prototype:OnBtnSend(sender, event)
  local contentStr = self.edtContent:getString()
  if not contentStr or contentStr:gsub("%s+", "%s") == "" then
    return
  end
  contentStr = Logic:Get("Sect"):checkString(contentStr)
  self.edtContent:setString(contentStr)
  local callMax = KFDBGetRecord("ConfigValue", "MENPAI:MESSAGE_WORD_LIMIT")
  callMax = callMax and tonumber(callMax.content) or 100
  if callMax < getCodePointAmount(contentStr) then
    Prompt:Fail(TwGetStr(110133, callMax))
    return
  end
  Logic:Get("Sect"):PostGiveMessage(contentStr)
  self.edtContent:setString("")
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
  return CCSizeMake(WIN_WIDTH, self.ItemHeight or 0)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if next(self.data) == nil then
    return cell
  end
  if not cell then
    cell = CCTableViewCellEx:create()
    local itemNode = CCNode:create()
    for _, v in pairs(self.data) do
      itemNode:addChild(v)
    end
    cell:addChild(itemNode, 0, 2)
    self.data = {}
  else
    local itemNode = CCNode:create()
    for _, v in pairs(self.data) do
      itemNode:addChild(v)
    end
    cell:removeChildByTag(2, true)
    cell:addChild(itemNode, 0, 2)
    self.data = {}
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  curPage = curPage or 1
  if self.hasItem then
    return 1
  else
    return 0
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.curPage = curPage
  self.staPageNum:setString(string.format("%d/%d", curPage, self.maxPage))
  Logic:Get("Sect"):PostListMessage(curPage)
  self.data = {}
  self.hasItem = false
  self.tableViewControl:RequireUpdate(self.maxPage, false)
end
function prototype:onBtnRefresh(sender, event)
  if self.btnRefresh:isEnabled() then
    self.refreshBtnClicked = true
    local time = Logic:Get("System"):GetTime()
    Logic:Get("Sect"):setWordRefreshTime(time)
    if self.curPage > 1 then
      self.tableViewControl:TurnPage(1 - self.curPage)
      self.curPage = 1
    else
      Logic:Get("Sect"):PostListMessage(1)
    end
  else
    local lastRefreshTime = Logic:Get("Sect"):getWordRefreshTime()
    Prompt:Confirm(self, "", TwGetStr(110065, lastRefreshTime + 20 - Logic:Get("System"):GetTime()), nil, Prompt.PROMPT_TYPE.CONFIRM)
  end
end
function prototype:onTimer()
  local lastRefreshTime = Logic:Get("Sect"):getWordRefreshTime()
  if lastRefreshTime == nil or lastRefreshTime + 20 < Logic:Get("System"):GetTime() then
    self.btnRefresh:setEnabled(true)
  end
end
