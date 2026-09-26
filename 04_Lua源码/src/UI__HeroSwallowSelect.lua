module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onEnter()
  super.onEnter(self)
  local unbattleingHeroId = Logic:Get("Hero"):GetUnbattlingHero()
  self.imgNoSwallow:setVisible(false)
  local upgradeId = Logic:Get("Hero"):GetUpgradeHero()
  for i = 1, #unbattleingHeroId do
    if unbattleingHeroId[i] == upgradeId then
      table.remove(unbattleingHeroId, i)
      break
    end
  end
  local expCard = Logic:Get("Hero"):GetTotalExpCard()
  if unbattleingHeroId and expCard then
    for i = 1, #expCard do
      table.insert(unbattleingHeroId, expCard[i])
    end
  end
  if table.empty(unbattleingHeroId) then
    self.imgNoSwallow:setVisible(true)
    self.pnlConfirm:setVisible(false)
    self.staPage:setString("1/1")
    return
  end
  local unbattleingHero = Logic:Get("Hero"):GetHeroInfosByIds(unbattleingHeroId)
  if not unbattleingHero then
    return
  end
  local unlockedHero = {}
  for i = 1, #unbattleingHero do
    if unbattleingHero[i].locked == false then
      table.insert(unlockedHero, unbattleingHero[i])
    end
  end
  Logic:Get("Hero"):SortHerosByChoice(unlockedHero, Logic.Hero.SORT_CHOICE.HERO_SWALLOW)
  self.heros = unlockedHero
  self.data = {
    self.heros
  }
  if #self.heros == 0 then
    self.page = 1
  else
    local int, fra = math.modf(#unlockedHero / Logic.Hero.MAX_HEROS_PER_PAGE)
    local page = 1
    if fra == 0 then
      page = int
    else
      page = int + 1
    end
    self.page = page
  end
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstHeros, self.page)
  local lastPage = Logic:Get("Hero"):getHeroSwallowPage()
  if lastPage > self.page then
    lastPage = self.page
  end
  self.tableViewControl:TurnPageTo(lastPage, true, true)
  self.lstHeros:addChild(self.tableViewControl.tableView)
  local total = Logic:Get("Hero"):GetTotalExtendLimit()
  self.staBag:setString(TwGetStr(104153, #unlockedHero or 0, total or 0))
  self.pnlConfirm:setVisible(false)
  Logic:Get("Hero"):On(Logic.Hero.EVT.OPT_SWALLOW, self:Event("OnOptSwallow"))
end
function prototype:OnOptSwallow(swallowHero)
  if not swallowHero then
    return
  end
  local num = 0
  for k, v in pairs(swallowHero) do
    num = num + 1
  end
  if num == 0 then
    self.pnlConfirm:setVisible(false)
    Logic:Get("Main"):SetFuncVisible(true)
  else
    self.pnlConfirm:setVisible(true)
    self.tableViewControl:RequireUpdateWithoutAnimat()
    Logic:Get("Main"):SetFuncVisible(false)
  end
  local nCost = 0
  local nExp = 0
  for k, v in pairs(swallowHero) do
    local heroInfo = Logic:Get("Hero"):GetHeroInfoById(k)
    nExp = heroInfo and (nExp + Logic:Get("Hero"):GetHeroSwallowExp(heroInfo.baseId, heroInfo.level) or 0)
  end
  local upgradeId = Logic:Get("Hero"):GetUpgradeHero()
  local upgradeHero = Logic:Get("Hero"):GetHeroInfoById(upgradeId)
  if upgradeHero and upgradeHero.baseId then
    local info = Logic:Get("Hero"):GetHeroInfoByBaseId(upgradeHero.baseId)
    if info and info.coinRate then
      nCost = nExp * info.coinRate
    end
  end
  self.pnlConfirm.staCost:setString(nCost)
  self.pnlConfirm.staExp:setString(nExp)
  self.pnlConfirm.staCostTip:setStyle(kCCLabelTTFStyleOutline)
  self.pnlConfirm.staCost:setStyle(kCCLabelTTFStyleOutline)
  self.pnlConfirm.staExpTip:setStyle(kCCLabelTTFStyleOutline)
  self.pnlConfirm.staExp:setStyle(kCCLabelTTFStyleOutline)
  self.pnlConfirm.staCostTip:setString(TwGetStr(104270))
  self.pnlConfirm.staExpTip:setString(TwGetStr(104271))
  self:updateGuide()
  self.pnlConfirm:updateGuide()
end
function prototype:onBtnLeft()
  if self.tableViewControl then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onBtnRight()
  if self.tableViewControl then
    self.tableViewControl:TurnPage(1)
  end
end
function prototype:onBtnReturn()
  Logic:Get("Hero"):SwapHero(true)
  Logic:Get("Main"):SetFuncVisible(true)
  SceneHelper:popScene()
end
function prototype:onExit()
  Logic:Get("Main"):SetFuncVisible(true)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 117)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("HeroSwallowSelectItem", self.rootNode)
    subScene.pHeroItem:RefreshHeros(self.heros[(curPage - 1) * Logic.Hero.MAX_HEROS_PER_PAGE + index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2).pHeroItem:RefreshHeros(self.heros[(curPage - 1) * Logic.Hero.MAX_HEROS_PER_PAGE + index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  self.staPage:setString(string.format("%d/%d", curPage or 0, self.page or 1))
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
  Logic:Get("Hero"):setHeroSwallowPage(curPage)
end
function prototype:actionFinish(tableView)
  if not Logic:Get("Guide"):isGuiding() then
    return
  end
  local idx, guideID
  if Logic:Get("Guide"):isActive("LevelUp", "SelectMaterial") then
    guideID = Guide.LevelUp.ID_MATERIAL
  end
  if Logic:Get("Guide"):isActive("FightLevelUp", "SelectMaterial") then
    guideID = Guide.FightLevelUp.ID_MATERIAL
  end
  if guideID == nil then
    return
  end
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
function prototype:updateGuide()
  if not Logic:Get("Guide"):isGuiding() then
    return
  end
  local idx, guideID
  if Logic:Get("Guide"):isActive("LevelUp", "SelectMaterial2") then
    idx = 2
  end
  if Logic:Get("Guide"):isActive("LevelUp", "SelectMaterial3") then
    idx = 3
  end
  if Logic:Get("Guide"):isActive("LevelUp", "SelectMaterial4") then
    idx = 4
  end
  if Logic:Get("Guide"):isActive("LevelUp", "SelectMaterial5") then
    idx = 5
  end
  if idx == nil then
    return
  end
  local cell = self.tableViewControl.tableView:cellAtIndex(idx - 1)
  if cell == nil then
    return
  end
  local item = cell:getChildByTag(2)
  if item == nil then
    return
  end
  item:updateGuide()
end
