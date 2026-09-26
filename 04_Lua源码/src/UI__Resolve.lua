module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onQuitBottent(sender, event)
  SceneHelper:runWithScene("Compose", self.rootNode)
end
function prototype:onExplainBottent()
end
function prototype:onEnter()
  super.onEnter(self)
  Logic:Get("Hero"):On(Logic.Hero.EVT.ALL_HEROS, self:Event("RefrashItem"))
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  self.ttfNum:setString(wallet[string.lower("FRAGMENT")])
  local allGift = Logic:Get("Hero"):GetFragmentHero()
  if next(allGift) == nil then
    self.btnLeft:setEnabled(false)
    self.btnRight:setEnabled(false)
    self.ttfPage:setString(1 .. "/" .. 1)
    return
  end
  if allGift then
    self.allGift = allGift
    self.page = math.ceil(#self.allGift / Logic.Compose.MAX_LIST)
    self.data = self.allGift
    self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pCList, self.page)
    self.tableViewControl.tableView:runUIAnimat()
    if self.page == 1 then
      self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
    end
    self.m_pCList:addChild(self.tableViewControl.tableView)
  end
  self.lockSplit = Logic:Get("Lock"):checkStatusById("SPLIT_HERO")
  if self.lockSplit then
    local path = "images/newfont/splitDisable.png"
    local spr = CCSprite:create(path)
    if spr then
      self.sprLeft:setDisplayFrame(spr:displayFrame())
    end
  end
end
function prototype:RefrashItem()
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  self.ttfNum:setString(wallet[string.lower("FRAGMENT")])
  local allGift = Logic:Get("Hero"):GetFragmentHero()
  if next(allGift) == nil then
    self.btnLeft:setEnabled(false)
    self.btnRight:setEnabled(false)
  end
  self.allGift = allGift
  self.data = self.allGift
  self.page = math.ceil(#self.allGift / Logic.Compose.MAX_LIST)
  self.tableViewControl:RequireUpdateWithoutAnimat(self.page, true)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(588, 164)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local idx = index + 1
  local lstIdx = idx + (curPage - 1) * Logic.Compose.MAX_LIST
  local key = self.allGift[lstIdx]
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ResolveItem", self.rootNode)
    subScene:ReFrashReward(Logic:Get("Hero"):GetHeroInfoById(key))
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):ReFrashReward(Logic:Get("Hero"):GetHeroInfoById(key))
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.page == 0 then
    self.page = 1
  end
  self.ttfPage:setString(curPage .. "/" .. self.page)
  if #self.allGift == 0 then
    return 0
  end
  if self.page == curPage then
    local num = #self.allGift - (self.page - 1) * Logic.Hero.MAX_HEROS_PER_PAGE
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
