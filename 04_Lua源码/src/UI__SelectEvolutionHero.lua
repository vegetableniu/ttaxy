module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local EVO_TYPE = Enum({
  "MATERIAL_EVO",
  "PAY_MONEY_EVO"
})
function prototype:initialize()
  super.initialize(self)
  self.heros = {}
  self.data = {}
end
function sortFunc(currHero, nextHero)
  if currHero.cardInfo == nil or nextHero.cardInfo == nil then
    return true
  end
  return Logic:Get("ExplainEquip"):EvolutionSortCondition(currHero, currHero.cardInfo, nextHero, nextHero.cardInfo)
end
function prototype:sortAllEvolutionHeros(allEvolutionHeros)
  table.sort(allEvolutionHeros, sortFunc)
  return allEvolutionHeros
end
function prototype:onEnter()
  super.onEnter(self)
  local allEvolutionHeros = Logic:Get("Hero"):GetEvolutionHero()
  if #allEvolutionHeros == 0 then
    self.staPage:setString("0/0")
    return
  end
  self.heros = self:sortAllEvolutionHeros(allEvolutionHeros)
  self.data = {
    self.heros
  }
  local int, fra = math.modf(#self.heros / Logic.Hero.MAX_HEROS_PER_PAGE)
  local page = 1
  if fra == 0 and int ~= 0 then
    page = int
  else
    page = int + 1
  end
  self.page = page
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstEvolutionHero, page)
  local oldPage = Logic:Get("ExplainEquip"):getCurPage()
  if page < oldPage then
    oldPage = page
  end
  self.tableViewControl:TurnPageTo(oldPage, true, true)
  self.tableViewControl.tableView:runUIAnimat()
  self.lstEvolutionHero:addChild(self.tableViewControl.tableView)
end
function prototype:onBtnReturn()
  SceneHelper:popScene()
end
function prototype:onBtnLeftTurn()
  self.tableViewControl:TurnPage(-1)
end
function prototype:onBtnRightTurn()
  self.tableViewControl:TurnPage(1)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 117)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("SelectEvolutionnode", self.rootNode)
    subScene:RefreshHeros(Logic.Hero.EVT.LEADER_CHANGE, self.heros[(curPage - 1) * Logic.Hero.MAX_HEROS_PER_PAGE + index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):RefreshHeros(Logic.Hero.EVT.LEADER_CHANGE, self.heros[(curPage - 1) * Logic.Hero.MAX_HEROS_PER_PAGE + index + 1])
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
function prototype:actionFinish(tableView)
  if not Logic:Get("Guide"):isGuiding() then
    return
  end
  local idx, guideId
  if Logic:Get("Guide"):isActive("Evolution", "SelectHero") then
    guideId = Guide.Evolution.HERO
  end
  if Logic:Get("Guide"):isActive("FightEvolution", "SelectHero") then
    guideId = Guide.FightEvolution.HERO
  end
  if guideId == nil then
    return
  end
  for i, hero in ipairs(self.heros) do
    if hero.baseId == guideId then
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
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
  Logic:Get("ExplainEquip"):setCurPage(curPage)
end
