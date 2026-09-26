module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("Logic.Compose")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onBtnReturn()
  SceneHelper:runWithScene("Gift", self.rootNode)
end
function prototype:onEnter()
  super.onEnter(self)
  Logic:Get("Gift"):On(Logic.Gift.EVT.REFRESH_GIFT, self:Event("RefrashGiftVipInfo"))
  Logic:Get("Gift"):HasRewardGift(nil, true)
  Logic:Get("Gift"):SetGiftInfoType("Gift")
  local allGift = Logic:Get("Gift"):GetCanShowGif()
  self.allGiftIdTable = Logic:Get("Gift"):GetIntegrateID()
  if table.empty(self.allGiftIdTable) then
    self.ttfPage:setString(1 .. "/" .. 1)
    return
  end
  if allGift then
    self.allGift = allGift
    self.page = math.ceil(#self.allGiftIdTable / Logic.Compose.MAX_LIST)
    self.data = self.allGift
    self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pCList, self.page)
    local offset = self:getTableViewOffset()
    if offset ~= nil then
      self.tableViewControl.tableView:setTableViewOffset(offset)
    end
    self.tableViewControl.tableView:runUIAnimat()
    if self.page == 1 then
      self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
    end
    self.m_pCList:addChild(self.tableViewControl.tableView)
  end
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz", self.sprRight, ccp(35, 19), 0, nil, nil)
  if self.ani then
    self.ani:RunAni()
  end
end
function prototype:RefrashGiftVipInfo()
  local allGift = Logic:Get("Gift"):GetCanShowGif()
  self.allGiftIdTable = Logic:Get("Gift"):GetIntegrateID()
  self.allGift = allGift
  self.data = self.allGift
  self.page = math.ceil(#self.allGiftIdTable / Logic.Compose.MAX_LIST)
  self.tableViewControl:RequireUpdate(self.page)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(588, 164)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local idx = index + 1
  local lstIdx = idx + (curPage - 1) * Logic.Compose.MAX_LIST
  local key = self.allGiftIdTable[lstIdx]
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("GiftItem", self.rootNode)
    subScene:RefreshVipReward(self.allGift[key], index)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):RefreshVipReward(self.allGift[key], index)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.page == 0 then
    self.page = 1
  end
  self.ttfPage:setString(curPage .. "/" .. self.page)
  if #self.allGiftIdTable == 0 then
    return 0
  end
  if self.page == curPage then
    local num = #self.allGiftIdTable - (self.page - 1) * Logic.Hero.MAX_HEROS_PER_PAGE
    return num
  else
    return Logic.Compose.MAX_LIST
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:actionFinish(tableView)
  if not Logic:Get("Guide"):isGuiding() then
    return
  end
  local idx = self:getTableViewOffset()
  if idx == nil then
    return
  end
  local cell = tableView:cellAtIndex(idx - 1)
  if cell == nil then
    return
  end
  local item = cell:getChildByTag(2)
  if item == nil then
    return
  end
  item:updateGuide()
end
function prototype:onBtnLeft()
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onBtnRight()
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(1)
  end
end
function prototype:getTableViewOffset()
  return nil
end
function prototype:onBtnRecharge(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
