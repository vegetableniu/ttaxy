module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onNodeLoaded(node, loader)
end
function prototype:onEnter()
  super.onEnter(self)
  Logic:Get("Main"):SetFuncVisible(false)
  self.staNumTip:setString(TwGetStr(104273))
  self.staPointTip:setString(TwGetStr(104274))
  self.staNumTip:setStyle(kCCLabelTTFStyleOutline)
  self.staPointTip:setStyle(kCCLabelTTFStyleOutline)
  Logic:Get("Hero"):InitTeamerHero()
  Logic:Get("Hero"):GetBattleHeroCopy()
  local unbattling = Logic:Get("Hero"):GetUnbattlingHero(true, true)
  local battling = Logic:Get("Hero"):GetBattlingHero()
  local id = unbattling
  for i = 1, #battling do
    table.insert(id, battling[i])
  end
  local allHeros = Logic:Get("Hero"):GetHeroInfosByIds(id)
  if allHeros then
    Logic:Get("Hero"):SortHerosByChoice(allHeros, Logic.Hero.SORT_CHOICE.HERO_TEAMER, true)
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
    local offset = self:getTableViewOffset()
    if offset ~= nil then
      self.tableViewControl.tableView:setTableViewOffset(offset)
    end
    self.tableViewControl.tableView:runUIAnimat()
    self.lstHeros:addChild(self.tableViewControl.tableView)
  end
  local battleHeros = Logic:Get("Hero"):GetBattlingHero()
  if battleHeros then
    self.staNums:setStyle(kCCLabelTTFStyleOutline)
    self.staNums:setString(tonumber(#battleHeros))
  end
  local nTotalPoints = Logic:Get("Hero"):GetLeadership()
  local nCurrentPoints = Logic:Get("Hero"):GetBattlingLeadership()
  if nTotalPoints and nCurrentPoints then
    self.staPoints:setStyle(kCCLabelTTFStyleOutline)
    self.staPoints:setString(nCurrentPoints .. "/" .. nTotalPoints)
  end
  Logic:Get("Hero"):On(Logic.Hero.EVT.HERO_CURRENT, self:Event("OnTeamerChange"))
  Logic:Get("Hero"):On(Logic.Hero.EVT.OPT_TEAMER_SELECT, self:Event("OnOptTeamerSelect"))
end
function prototype:OnTeamerChange()
  if Logic:Get("Hero"):isChangingTeam() then
    Logic:Get("Hero"):setChangingTeam(false)
    Logic:Get("Guide"):check()
  end
  SceneHelper:runWithScene("Home", self.rootNode)
end
function prototype:OnOptTeamerSelect()
  local teamerHero = Logic:Get("Hero"):GetTeamerHero()
  local num = 1
  for _, _ in pairs(teamerHero) do
    num = num + 1
  end
  self.staNums:setString(num - 1)
  local nTotalPoints = Logic:Get("Hero"):GetLeadership()
  local nCurrentPoints = 0
  for k, _ in pairs(teamerHero) do
    local heroInfo = Logic:Get("Hero"):GetHeroInfoById(k)
    if heroInfo then
      local info = Logic:Get("Hero"):GetHeroInfoByBaseId(heroInfo.baseId)
      if info then
        nCurrentPoints = nCurrentPoints + info.leadership
      end
    end
  end
  self.staPoints:setString(nCurrentPoints .. "/" .. nTotalPoints)
  self.tableViewControl:RequireUpdateWithoutAnimat()
  self:updateGuide()
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
function prototype:onExit()
  Logic:Get("Hero"):InitTeamerHero()
  Logic:Get("Main"):SetFuncVisible(true)
end
function prototype:onConfirm()
  if Logic:Get("Guide"):isActive("Team", "Confirm") then
    Logic:Get("Hero"):setChangingTeam(true)
    Logic:Get("Guide"):done("Team", "Confirm")
  end
  local teamerHero = Logic:Get("Hero"):GetTeamerHero()
  local herosId = {}
  for k, v in pairs(teamerHero) do
    if v then
      table.insert(herosId, k)
    end
  end
  local totalShip = Logic:Get("Hero"):GetLeadership()
  local currentShip = 0
  local teamer = Logic:Get("Hero"):GetHeroInfosByIds(herosId)
  if teamer then
    for i = 1, #teamer do
      local info = Logic:Get("Hero"):GetHeroInfoByBaseId(teamer[i].baseId)
      if info and info.leadership then
        currentShip = currentShip + info.leadership
      end
    end
  end
  if totalShip < currentShip then
    Prompt:Fail(TwGetStr(103070))
    return
  end
  local battlingId = Logic:Get("Hero"):GetBattlingHero()
  if #herosId == #battlingId then
    local num = 0
    for i = 1, #herosId do
      for j = 1, #battlingId do
        if herosId[i] == battlingId[j] then
          num = num + 1
        end
      end
    end
    if num == #herosId then
      SceneHelper:runWithScene("Home", self.rootNode)
      return
    end
  end
  Logic:Get("Hero"):PostSetHeroCurrent(1, herosId)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 117)
end
function prototype:tableCellAtIndex(tb, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("HeroSelectItem", self.rootNode)
    subScene.pHeroItem:RefreshHeros(Logic.Hero.EVT.HERO_CURRENT, self.heros[(curPage - 1) * Logic.Hero.MAX_HEROS_PER_PAGE + index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2).pHeroItem:RefreshHeros(Logic.Hero.EVT.HERO_CURRENT, self.heros[(curPage - 1) * Logic.Hero.MAX_HEROS_PER_PAGE + index + 1])
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
  if not Logic:Get("Guide"):isActive("Team") then
    return
  end
  local heroes = {}
  heroes[Guide.Team.HERO1] = true
  heroes[Guide.Team.HERO2] = true
  heroes[Guide.Team.HERO3] = true
  local leaderId = Logic:Get("Hero"):GetLeaderId()
  local battleHero = Logic:Get("Hero"):GetBattlingHero()
  local idx
  for i, hero in ipairs(self.heros) do
    if heroes[hero.baseId] and hero.id ~= leaderId then
      for j = 1, #battleHero do
        if battleHero[j] ~= hero.id then
          idx = i
          break
        end
      end
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
end
function prototype:getTableViewOffset()
  if Logic:Get("Guide"):isActive("Team", "SelectHero") then
    local heroes = {}
    heroes[Guide.Team.HERO1] = true
    heroes[Guide.Team.HERO2] = true
    heroes[Guide.Team.HERO3] = true
    local heroInfo = Logic:Get("Hero"):GetAllHeroInfo()
    local leaderId = Logic:Get("Hero"):GetLeaderId()
    local battleHero = Logic:Get("Hero"):GetBattlingHero()
    for i, v in ipairs(self.heros) do
      if heroes[v.baseId] and v.id ~= leaderId then
        for j = 1, #battleHero do
          if battleHero[j] ~= v.id then
            return i
          end
        end
      end
    end
  end
  return nil
end
function prototype:updateGuide()
  Logic:Get("Guide"):lockTouch("Team", "Confirm", self.btnConfim)
end
