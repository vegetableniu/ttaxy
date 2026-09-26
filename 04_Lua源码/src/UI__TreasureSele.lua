module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onEnter()
  super.onEnter(self)
  Logic:Get("Treasure"):On(Logic.Treasure.EVT.REFRESH_CONFIG, self:Event("RefreshConfig"))
  self.pnlConfirm:setAnchorPoint(CCPoint(0, 0))
  local treasSure = Logic:Get("Treasure"):GetHeroSeleCur()
  Logic:Get("Treasure"):SetSeleTreaIds(treasSure)
  local id = Logic:Get("Hero"):GetTotalSkillCard()
  if not id then
    self.btnLeft:setEnabled(false)
    self.btnRight:setEnabled(false)
    return
  end
  local allHeros = Logic:Get("Treasure"):GetTreaByHero()
  if table.empty(allHeros) then
    self.btnLeft:setEnabled(false)
    self.btnRight:setEnabled(false)
  end
  if not table.empty(allHeros) then
    Logic:Get("Hero"):SortHerosByChoice(allHeros, Logic.Hero.SORT_CHOICE.HERO_SKILL_CARD)
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
    local lastPage = Logic:Get("Hero"):getTreasurePage()
    if lastPage > self.page then
      lastPage = self.page
    end
    self.tableViewControl:TurnPageTo(lastPage, true, true)
    self.lstHeros:addChild(self.tableViewControl.tableView)
  end
  self.pnlConfirm:setVisible(false)
end
function prototype:onExit()
  Logic:Get("Main"):SetFuncVisible(true)
end
function prototype:onBtnReturn()
  local a = {}
  Logic:Get("Treasure"):SetSeleTreaIds(a)
  SceneHelper:popScene()
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 117)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("TreasureSeleItem", self.rootNode)
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
  Logic:Get("Hero"):setTreasurePage(curPage)
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:RefreshConfig()
  local num = 0
  local seleTrea = Logic:Get("Treasure"):GetSeleTrea()
  Logic:Get("Main"):SetFuncVisible(false)
  for k, v in pairs(seleTrea) do
    num = num + 1
  end
  if num >= 5 then
    self.tableViewControl:RequireUpdateWithoutAnimat(self.page)
  end
  if table.empty(seleTrea) then
    self.pnlConfirm.staNum:setString(0)
    self.pnlConfirm.staTotal:setString(0)
    self.pnlConfirm:setVisible(true)
  else
    self:CountTrea(seleTrea)
    self.pnlConfirm:setVisible(true)
  end
  self.pnlConfirm:updateGuide()
end
function prototype:CountTrea(seleTrea)
  local hero = Logic:Get("Treasure"):GetHeroInfo()
  local fdbSkill = Logic:Get("HeroCardInfo"):kdbSkillConfig(hero.powerSkill)
  if fdbSkill ~= nil then
    local money = 0
    local expNum = 0
    for k, v in pairs(seleTrea) do
      local treaInfo = Logic:Get("Hero"):GetHeroInfoById(k)
      if treaInfo ~= nil then
        local treaBase = Logic:Get("Hero"):GetHeroInfoByBaseId(treaInfo.baseId)
        expNum = expNum + tonumber(treaBase.baseExp)
        money = money + fdbSkill.costCoins
      end
    end
    self.pnlConfirm.staNum:setString(money)
    self.pnlConfirm.staTotal:setString(expNum)
  end
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
