module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onEnter()
  super.onEnter(self)
  local heroCard, skillCard, heroInfo, SkillInfo = Logic:Get("Hero"):GetCardByTypeForSkill()
  if not heroCard then
    self.btnLeft:setEnabled(false)
    self.btnRight:setEnabled(false)
    return
  end
  local allHeros = heroInfo
  if allHeros then
    Logic:Get("Hero"):SortHerosByChoice(allHeros, Logic.Hero.SORT_CHOICE.HERO_SKILL)
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
    local lastPage = Logic:Get("Hero"):getHeroUpSkillPage()
    if lastPage > self.page then
      lastPage = self.page
    end
    self.tableViewControl:TurnPageTo(lastPage, true, true)
    self.lstHeros:addChild(self.tableViewControl.tableView)
  end
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:popScene()
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 117)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("HeroUpSkillSeleItem", self.rootNode)
    subScene.pHeroItem:RefreshHeros(self.heros[(curPage - 1) * Logic.Hero.MAX_HEROS_PER_PAGE + index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2)
    cell:getChildByTag(2).pHeroItem:RefreshHeros(self.heros[(curPage - 1) * Logic.Hero.MAX_HEROS_PER_PAGE + index + 1])
  end
  return cell
end
function prototype:actionFinish(tableView)
  local cell = tableView:cellAtIndex(0)
  if cell == nil then
    return
  end
  local item = cell:getChildByTag(2)
  if item == nil then
    return
  end
  item:updateGuide()
end
function prototype:numberOfCellsInTableView(curPage)
  self.staPage:setString(curPage .. "/" .. self.page)
  if self.page == curPage then
    return #self.heros - (self.page - 1) * Logic.Hero.MAX_HEROS_PER_PAGE
  else
    return Logic.Hero.MAX_HEROS_PER_PAGE
  end
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
  Logic:Get("Hero"):setHeroUpSkillPage(curPage)
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:onBtnLeft()
  self.tableViewControl:TurnPage(-1)
end
function prototype:onBtnRight()
  self.tableViewControl:TurnPage(1)
end
