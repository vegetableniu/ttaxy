module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onEnter()
  super.onEnter(self)
  local id = Logic:Get("Hero"):GetTotalHeroId()
  local allHeros = Logic:Get("Hero"):GetHeroInfosByIds(id)
  Logic:Get("Hero"):SortHerosByChoice(allHeros, Logic.Hero.SORT_CHOICE.HERO_TEAMER, true)
  if allHeros then
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
    local lastPage = Logic:Get("Hero"):getHeroUpgradePage()
    if lastPage > self.page then
      lastPage = self.page
    end
    self.tableViewControl:TurnPageTo(lastPage, true, true)
    self.lstHeros:addChild(self.tableViewControl.tableView)
  end
end
function prototype:onBtnLeft()
  self.tableViewControl:TurnPage(-1)
end
function prototype:onBtnRight()
  self.tableViewControl:TurnPage(1)
end
function prototype:onBtnReturn()
  SceneHelper:popScene()
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 117)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("HeroUpgradeSelectItem", self.rootNode)
    subScene.pHeroItem:RefreshHeros(self.heros[(curPage - 1) * Logic.Hero.MAX_HEROS_PER_PAGE + index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2)
    cell:getChildByTag(2).pHeroItem:RefreshHeros(self.heros[(curPage - 1) * Logic.Hero.MAX_HEROS_PER_PAGE + index + 1])
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
  Logic:Get("Hero"):setHeroUpgradePage(curPage)
end
function prototype:actionFinish(tableView)
  if not Logic:Get("Guide"):isGuiding() then
    return
  end
  local guideID
  if Logic:Get("Guide"):isActive("LevelUp", "SelectHero") then
    guideID = Guide.LevelUp.ID_HERO
  end
  if Logic:Get("Guide"):isActive("FightLevelUp", "SelectHero") then
    guideID = Guide.FightLevelUp.ID_HERO
  end
  if guideID == nil then
    return
  end
  local idx
  for i, hero in ipairs(self.heros) do
    if hero.baseId == guideID then
      idx = i
      break
    end
  end
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
