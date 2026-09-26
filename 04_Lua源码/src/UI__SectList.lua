module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = Tw.Controller.prototype:extend()
local WIN_WIDTH, WIN_HEIGHT = 569, 160
local SPR_SEEK = "images/Corps/ttf_ss.png"
local SPR_BID = "images/Corps/ttf_jj.png"
local FRIENDNAMESIZE = 12
local FONT_SIZE = 29
function prototype:initialize()
  super.initialize(self)
  Logic:Get("Sect"):On(Logic.Sect.EVT.GET_MENPAI_LIST_OK, self:Event("refresh"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.EXITSECTBID, self:Event("showTableView"))
  local rec = KFDBGetRecord("ConfigValue", "MENPAI:LIST_PAGE_SIZE")
  self.pageCount = rec and tonumber(rec.content) or 10
  self.data = {}
  self.seekName = nil
end
function prototype:onEnter()
  super.onEnter(self)
  self.showSeekFun = false
  self.layerBid:setVisible(false)
  self.layerSeek:setVisible(false)
  self.staPageNum:setStyle(kCCLabelTTFStyleOutline)
  self.labTopBid:setStyle(kCCLabelTTFStyleOutline)
  self.labSelfBid:setStyle(kCCLabelTTFStyleOutline)
  self.seekSectName:setMaxLens(FRIENDNAMESIZE)
  self.seekSectName:setFontSize(FONT_SIZE)
  self.maxPage = math.ceil(#self.data / self.pageCount)
  self.maxPage = self.maxPage < 1 and 1 or self.maxPage
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pCList, self.maxPage, true)
  self.m_pCList:addChild(self.tableViewControl.tableView)
  self:setLR()
  Logic:Get("Sect"):PostGetMenpaiList(nil, 1)
end
function prototype:refresh(data)
  self.layerSeek:setVisible(self.showSeekFun)
  self.layerBid:setVisible(not self.showSeekFun)
  if self.seekName and data.count == 0 then
    Prompt:Fail(TwGetStr(110105))
    return
  end
  self.maxPage = math.ceil(data.count / data.size)
  self.maxPage = self.maxPage < 1 and 1 or self.maxPage
  self:setLR()
  self.data = data.data
  self.labTopBid:setString(tostring(data.firstBid or 0))
  self.labSelfBid:setString(tostring(data.ownBid or 0))
  self.tableViewControl:RequireUpdate(self.maxPage)
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
function prototype:onRightClicked(sender, event)
  self.showSeekFun = not self.showSeekFun
  self.layerSeek:setVisible(self.showSeekFun)
  self.layerBid:setVisible(not self.showSeekFun)
  if self.showSeekFun then
    local spr = CCSprite:create(SPR_BID)
    if spr then
      self.sprRight:setDisplayFrame(spr:displayFrame())
    end
  else
    local spr = CCSprite:create(SPR_SEEK)
    if spr then
      self.sprRight:setDisplayFrame(spr:displayFrame())
    end
  end
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
function prototype:showTableView()
  self.tableViewControl.tableView:setVisible(true)
end
function prototype:cellSizeForTable()
  return CCSizeMake(WIN_WIDTH, WIN_HEIGHT)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("SectListItem", self.rootNode)
    subScene:refreshInfo(self.data[index + 1], true)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):refreshInfo(self.data[index + 1], true)
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
function prototype:onBidClick(sender, event)
  local job = Logic:Get("Sect"):getSectInfo().job
  if Logic:Get("Sect"):checkAuth(job, "BID") then
    SceneHelper:pushPrompt("SectBid", self.rootNode)
    self.tableViewControl.tableView:setVisible(false)
  else
    Prompt:Tip(TwGetStr(110150))
  end
end
function prototype:onSeekSect(sender, event)
  self.seekName = self.seekSectName:getString()
  Logic:Get("Sect"):PostGetMenpaiList(self.seekName, 1)
  self.tableViewControl:TurnPageTo(1)
end
