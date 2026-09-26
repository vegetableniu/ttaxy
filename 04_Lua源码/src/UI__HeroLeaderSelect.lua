module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onEnter()
  super.onEnter(self)
  self.staReturn:setStyle(kCCLabelTTFStyleOutline)
  local unbattling = Logic:Get("Hero"):GetUnbattlingHero(true, true)
  Logic:Get("Hero"):GetBattleHeroCopy()
  local bCurrent = Logic:Get("Hero"):GetTag()
  local id = unbattling
  if bCurrent then
    local battling = Logic:Get("Hero"):GetBattlingHero()
    for i = 1, #battling do
      table.insert(id, battling[i])
    end
  end
  local allHeros = Logic:Get("Hero"):GetHeroInfosByIds(id)
  if not allHeros or table.empty(allHeros) then
    return
  end
  Logic:Get("Hero"):SortHerosByChoice(allHeros, Logic.Hero.SORT_CHOICE.STAR_LOWER, true)
  self.heros = allHeros
  self.data = {
    self.heros
  }
  local int, fra = math.modf(#allHeros / Logic.Hero.MAX_HEROS_PER_PAGE)
  local page = 1
  if fra == 0 then
    page = int
  else
    page = int + 1
  end
  self.page = page
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstHeros, page)
  self.tableViewControl.tableView:runUIAnimat()
  self.lstHeros:addChild(self.tableViewControl.tableView)
  Logic:Get("Hero"):On(Logic.Hero.EVT.LEADER_CHANGE, self:Event("OnLeaderChange"))
end
function prototype:OnLeaderChange()
  local bCurrent = Logic:Get("Hero"):GetTag()
  if bCurrent then
    SceneHelper:runWithScene("Home", self.rootNode)
  else
    SceneHelper:runWithScene("HeroTeamTab", self.rootNode)
  end
end
function prototype:onBtnLeft()
  self.tableViewControl:TurnPage(-1)
end
function prototype:onBtnRight()
  self.tableViewControl:TurnPage(1)
end
function prototype:onBtnReturn()
  SceneHelper:runWithScene("Home", self.rootNode)
end
function prototype:onExit(...)
  Logic:Get("Hero"):SetCurrentLeaderTag(true)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 117)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("HeroSelectItem", self.rootNode)
    subScene.pHeroItem:RefreshHeros(Logic.Hero.EVT.LEADER_CHANGE, self.heros[(curPage - 1) * Logic.Hero.MAX_HEROS_PER_PAGE + index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2)
    cell:getChildByTag(2).pHeroItem:RefreshHeros(Logic.Hero.EVT.LEADER_CHANGE, self.heros[(curPage - 1) * Logic.Hero.MAX_HEROS_PER_PAGE + index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  self.staPage:setString(string.format("%d/%d", curPage or 1, self.page or 1))
  if self.page == curPage then
    return #self.heros - (self.page - 1) * Logic.Hero.MAX_HEROS_PER_PAGE
  else
    return Logic.Hero.MAX_HEROS_PER_PAGE
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
