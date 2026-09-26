module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local LEADER_PATH = "images/font/choseHeader.png"
local TEAMER_PATH = "images/font/choseMember.png"
function prototype:onNodeLoaded(node, loader)
end
function prototype:onEnter()
  super.onEnter(self)
  Logic:Get("Hero"):GetBattleHeroCopy()
  self.changeType = Logic:Get("Devil"):GetChangeType()
  self.group = Logic:Get("Devil"):GetChangeGroup()
  if self.changeType == Logic.Hero.EVT.LEADER_CHANGE then
    self:leaderSetting()
  elseif self.changeType == Logic.Hero.EVT.HERO_CURRENT then
    self:teamerSetting()
  end
  local int, fra = math.modf(#self.heros / Logic.Hero.MAX_HEROS_PER_PAGE)
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
end
function prototype:onExit()
  Logic:Get("Devil"):clearGroupHero()
  Logic:Get("Main"):SetFuncVisible(true)
  Logic:Get("Hero"):SetCurrentLeaderTag(true)
  Logic:Get("Devil"):FireEvent(Logic.Devil.EVT.REFRESH_GROUP_DATA)
end
function prototype:leaderSetting()
  self.btnBottom:setVisible(false)
  self.pnlConfirm:setVisible(false)
  self.staNumTip:setVisible(false)
  self.staNums:setVisible(false)
  self.staPointTip:setVisible(false)
  self.staPoints:setVisible(false)
  self.btnConfirm:setVisible(false)
  self.sprConfirm:setVisible(false)
  self.lstHeros:setContentSize(CCSize(575, 440))
  self:setTitle(LEADER_PATH)
  local unbattling = Logic:Get("Hero"):GetUnbattlingHero(true, true)
  local id = unbattling
  local allHeros = Logic:Get("Hero"):GetHeroInfosByIds(id)
  if not allHeros then
    return
  end
  Logic:Get("Hero"):SortHerosByChoice(allHeros, Logic.Hero.SORT_CHOICE.STAR_LOWER, false)
  Logic:Get("Devil"):InitGroupTeamerHero(self.group.heros.groupId)
  local teamerHeros = Logic:Get("Devil"):GetGroupTeamerHero()
  for k, _ in pairs(teamerHeros) do
    local hero = Logic:Get("Hero"):GetHeroInfoById(k)
    if hero then
      table.insert(allHeros, 1, hero)
    end
  end
  if self.group.heros.leaderId ~= ID[-1] then
    local leader = Logic:Get("Hero"):GetHeroInfoById(self.group.heros.leaderId)
    table.insert(allHeros, 1, leader)
  end
  self.heros = allHeros
  Logic:Get("Hero"):On(Logic.Hero.EVT.LEADER_CHANGE, self:Event("OnLeaderChange"))
end
function prototype:teamerSetting()
  self.sprLeaderBg:setVisible(false)
  self.sprLeaderDesc:setVisible(false)
  self:setTitle(TEAMER_PATH)
  Logic:Get("Main"):SetFuncVisible(false)
  self.staNumTip:setString(TwGetStr(104273))
  self.staPointTip:setString(TwGetStr(104274))
  self.staNumTip:setStyle(kCCLabelTTFStyleOutline)
  self.staPointTip:setStyle(kCCLabelTTFStyleOutline)
  Logic:Get("Devil"):InitGroupTeamerHero(self.group.heros.groupId)
  local teamerHeros = Logic:Get("Devil"):GetGroupTeamerHero()
  if teamerHeros then
    local num = 0
    for _, _ in pairs(teamerHeros) do
      num = num + 1
    end
    self.staNums:setStyle(kCCLabelTTFStyleOutline)
    self.staNums:setString(1 + num)
  end
  local nTotalPoints = Logic:Get("Hero"):GetLeadership()
  local nCurrentPoints = Logic:Get("Devil"):GetGroupLeadership()
  if nTotalPoints and nCurrentPoints then
    self.staPoints:setStyle(kCCLabelTTFStyleOutline)
    self.staPoints:setString(nCurrentPoints .. "/" .. nTotalPoints)
  end
  local bagHeroIds = Logic:Get("Hero"):GetUnbattlingHero(true, true)
  local allHeros = Logic:Get("Hero"):GetHeroInfosByIds(bagHeroIds)
  if allHeros then
    Logic:Get("Hero"):SortHerosByChoice(allHeros, Logic.Hero.SORT_CHOICE.HERO_TEAMER, false)
    for k, _ in pairs(teamerHeros) do
      local hero = Logic:Get("Hero"):GetHeroInfoById(k)
      if hero then
        table.insert(allHeros, 1, hero)
      end
    end
    if self.group.heros.leaderId ~= ID[-1] then
      local leader = Logic:Get("Hero"):GetHeroInfoById(self.group.heros.leaderId)
      table.insert(allHeros, 1, leader)
    end
    self.heros = allHeros
  end
  Logic:Get("Hero"):On(Logic.Hero.EVT.HERO_CURRENT, self:Event("OnTeamerChange"))
  Logic:Get("Hero"):On(Logic.Hero.EVT.OPT_TEAMER_SELECT, self:Event("OnOptTeamerSelect"))
end
function prototype:setTitle(path)
  if path == nil then
    return
  end
  local spr = CCSprite:create(path)
  if spr then
    self.sprTitle:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:OnTeamerChange()
  if Logic:Get("Hero"):isChangingTeam() then
    Logic:Get("Hero"):setChangingTeam(false)
  end
  SceneHelper:popScene()
end
function prototype:OnOptTeamerSelect()
  local teamerHero = Logic:Get("Devil"):GetGroupTeamerHero()
  local num = 1
  for _, _ in pairs(teamerHero) do
    num = num + 1
  end
  self.staNums:setString(num)
  local nTotalPoints = Logic:Get("Hero"):GetLeadership()
  local nCurrentPoints = Logic:Get("Devil"):GetGroupLeadership()
  self.staPoints:setString(nCurrentPoints .. "/" .. nTotalPoints)
  self.tableViewControl:RequireUpdateWithoutAnimat()
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
function prototype:onConfirm()
  local teamerHero = Logic:Get("Devil"):GetGroupTeamerHero()
  local herosId = {}
  for k, v in pairs(teamerHero) do
    if v then
      table.insert(herosId, k)
    end
  end
  local totalShip = Logic:Get("Hero"):GetLeadership()
  local currentShip = Logic:Get("Devil"):GetGroupLeadership()
  if totalShip < currentShip then
    Prompt:Fail(TwGetStr(103070))
    return
  end
  local oldTeam = Logic:Get("Devil"):GetOldTeamerHero()
  local battlingId = {}
  for k, v in pairs(oldTeam) do
    if v then
      table.insert(battlingId, k)
    end
  end
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
      SceneHelper:popScene()
      return
    end
  end
  table.insert(herosId, 1, self.group.heros.leaderId)
  Logic:Get("Hero"):PostSetHeroCurrent(self.group.heros.groupId, herosId)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 117)
end
function prototype:tableCellAtIndex(tb, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("DevilTeamerSelItem", self.rootNode)
    subScene.pHeroItem:RefreshHeros(self.changeType, self.heros[(curPage - 1) * Logic.Hero.MAX_HEROS_PER_PAGE + index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2).pHeroItem:RefreshHeros(self.changeType, self.heros[(curPage - 1) * Logic.Hero.MAX_HEROS_PER_PAGE + index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if table.empty(self.heros) then
    return 0
  end
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
function prototype:OnLeaderChange()
  SceneHelper:popScene()
end
