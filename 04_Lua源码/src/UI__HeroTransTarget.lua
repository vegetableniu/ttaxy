module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local MAX_PER_PAGE = 20
local map = {
  "XIAN",
  "LING",
  "YAO"
}
function prototype:initialize()
  super.initialize(self)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onEnter()
  super.onEnter(self)
  self.data = Logic:Get("Compose"):GetTargetList()
  self.page = math.ceil(#self.data / MAX_PER_PAGE)
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstCard, self.page)
  if self.page < 2 then
    self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  end
  self.lstCard:addChild(self.tableViewControl.tableView)
  self.tableViewControl.tableView:runUIAnimat()
  self:setBtnStatus()
  Logic:Get("Compose"):On(Logic.Compose.EVT.SELECT_CARD, self:Event("onSelectCard"))
end
function prototype:setBtnStatus()
  local unitrace = Logic:Get("Compose"):GetUnitRace()
  for i, v in ipairs(map) do
    local str = string.format("btnRace%d", i)
    local sprNormal, sprSelect, sprDisable
    if unitrace == Logic.Compose.UNITRACE[v] then
      sprNormal = CCScale9Sprite:create("images/public/btnRaceSelect.png")
      sprSelect = CCScale9Sprite:create("images/public/btnRaceSelect.png")
      sprDisable = CCScale9Sprite:create("images/public/btnRaceSelect.png")
    else
      sprNormal = CCScale9Sprite:create("images/public/btnRaceNormal.png")
      sprSelect = CCScale9Sprite:create("images/public/btnRaceNormal.png")
      sprDisable = CCScale9Sprite:create("images/public/btnRaceNormal.png")
    end
    if self[str] then
      self[str]:setBackgroundSpriteForState(sprNormal, CCControlStateNormal)
      self[str]:setBackgroundSpriteForState(sprSelect, CCControlStateHighlighted)
      self[str]:setBackgroundSpriteForState(sprDisable, CCControlStateDisabled)
    end
  end
end
function prototype:onSelectCard()
  local targetCard = Logic:Get("Compose"):GetTargetCard()
  if targetCard then
    SceneHelper:popScene()
    return
  end
  self.tableViewControl:RequireUpdateWithoutAnimat()
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:popScene()
end
function prototype:onBtnLeft(sender, event)
end
function prototype:onBtnRight(sender, event)
end
function prototype:onBtnRace(sender, event)
  local lingLock = Logic:Get("Lock"):checkStatusById("CARD_SWAP_LING")
  if sender == self.btnRace2 and lingLock then
    if event == CCControlEventTouchDown then
      Logic:Get("Lock"):showLockTipById("CARD_SWAP_LING")
    end
    Logic:Get("Lock"):closeLockTip(event)
    return
  end
  local yaoLock = Logic:Get("Lock"):checkStatusById("CARD_SWAP_YAO")
  if sender == self.btnRace3 and yaoLock then
    if event == CCControlEventTouchDown then
      Logic:Get("Lock"):showLockTipById("CARD_SWAP_YAO")
    end
    Logic:Get("Lock"):closeLockTip(event)
    return
  end
  if event ~= CCControlEventTouchUpInside then
    return
  end
  local idx = 0
  for i = 1, 3 do
    local str = string.format("btnRace%d", i)
    if self[str] == sender then
      idx = i
      break
    end
  end
  local unitrace = Logic:Get("Compose"):GetUnitRace()
  if unitrace == Logic.Compose.UNITRACE[map[idx]] then
    return
  end
  Logic:Get("Compose"):SetUnitRace(Logic.Compose.UNITRACE[map[idx]])
  self:setBtnStatus()
  self.data = Logic:Get("Compose"):GetTargetList()
  self.page = math.ceil(#self.data / MAX_PER_PAGE)
  self.tableViewControl:RequireUpdate(self.page, true, true)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 117)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local lstIdx = index + 1 + (curPage - 1) * MAX_PER_PAGE
  local key = self.data[lstIdx]
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("HeroTransTargetItem", self.rootNode)
    subScene:RefreshInfo(key)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):RefreshInfo(key)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.data == nil or table.empty(self.data) then
    return 0
  end
  self.ttfPage:setString(string.format("%d/%d", curPage or 1, self.page or 1))
  if self.page == curPage then
    return #self.data - (self.page - 1) * MAX_PER_PAGE
  else
    return MAX_PER_PAGE
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
