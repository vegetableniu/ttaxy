module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
CARD_RACE = Enum({
  "XIAN",
  "LING",
  "YAO"
})
local MAX_HEROS_PER_PAGE = 15
function prototype:onEnter()
  super.onEnter(self)
  local heroInfo = Logic:Get("Hero"):GetAllHeroInfo()
  if not heroInfo then
    return
  end
  local id = Logic:Get("Hero"):GetHeroTableFromMap(heroInfo.heros)
  if not id then
    return
  end
  local allHeros = Logic:Get("Hero"):GetHeroInfosByIds(id)
  self.heros = allHeros
  self:initHeroInfo()
  if table.empty(self.heros or {}) then
    return
  end
  self:sortHeros()
  self.data = {
    self.heros
  }
  local int, fra = math.modf(#self.heros / MAX_HEROS_PER_PAGE)
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
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.SELECT_HERO, self:Event("onSelectHero"))
end
function prototype:onExit()
  Logic:Get("Cultivate"):setFromBattle(false)
end
function prototype:initHeroInfo()
  local isFromCultivateFlage = Logic:Get("Cultivate"):getFromRecultivateFlage()
  local tmpHero = {}
  local rec = KFDBGetRecord("ConfigValue", "CULTIVATE:RE_CULTIVATE_STATE_LIMIT")
  local limitRealm = rec and tonumber(rec.content) or 1
  for k, v in pairs(self.heros) do
    local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(v.baseId)
    if heroInfo and heroInfo.card == "HERO" and Logic:Get("Cultivate"):canCultivateByBaseId(v.baseId) then
      if isFromCultivateFlage then
        local state = Logic:Get("Cultivate"):getCutivateStateById(v.id)
        if limitRealm <= state then
          v.isRebuild = true
          v.bundary = Logic:Get("Cultivate"):getCutivateStateById(v.id)
          table.insert(tmpHero, v)
        end
      else
        v.isRebuild = false
        v.isMax = Logic:Get("Cultivate"):isMaxState(v.baseId, v.id)
        v.canSwallow, v.canCompose = Logic:Get("Cultivate"):canSwallowElixir(v.id, v.baseId)
        v.canCross = Logic:Get("Cultivate"):isSwallowAllElixir(v.id)
        v.bundary = Logic:Get("Cultivate"):getCutivateStateById(v.id)
        local rec = Logic:Get("Cultivate"):getCutivateInfo(v.bundary, heroInfo.type)
        local elixirs = json.decode(rec and rec.elixirs or "") or {}
        local elixir = {}
        for k1, v1 in pairs(elixirs) do
          local tmp = {}
          local canCompose = Logic:Get("Cultivate"):canComposeElixirByBaseId(v1)
          tmp.canCompose = canCompose
          tmp.baseId = v1
          tmp.position = k1
          tmp.heroId = v.id
          table.insert(elixir, tmp)
        end
        v.elixirs = elixir
        table.insert(tmpHero, v)
      end
    end
  end
  if isFromCultivateFlage then
    local spr = CCSprite:create("images/Cultivate/chongxiukapai.png")
    if spr then
      self.sprTitle:setDisplayFrame(spr:displayFrame())
    end
    self.nodeBtn:setVisible(false)
  end
  self.nodeBtn:setVisible(false)
  self.heros = tmpHero
end
function prototype:sortHeros()
  table.sort(self.heros, function(param1, param2)
    local info1 = Logic:Get("Hero"):GetHeroInfoByBaseId(param1.baseId)
    local info2 = Logic:Get("Hero"):GetHeroInfoByBaseId(param2.baseId)
    if not info1 or not info2 then
      return false
    end
    local state1 = Logic:Get("Cultivate"):getCutivateStateById(param1.id)
    local state2 = Logic:Get("Cultivate"):getCutivateStateById(param2.id)
    local canSwallow1 = param1.canSwallow and 2 or 99
    local canSwallow2 = param2.canSwallow and 2 or 99
    local canCross1 = param1.canCross and 1 or 99
    local canCross2 = param2.canCross and 1 or 99
    local canCompose1 = param1.canCompose and 3 or 99
    local canCompose2 = param2.canCompose and 3 or 99
    local canOperate1 = math.min(canSwallow1, canCross1, canCompose1)
    local canOperate2 = math.min(canSwallow2, canCross2, canCompose2)
    if param1.isMax then
      canOperate1 = 99
    end
    if param2.isMax then
      canOperate2 = 99
    end
    if param1.isRebuild then
      canOperate1 = 0
    end
    if param2.isRebuild then
      canOperate2 = 0
    end
    if canOperate1 == canOperate2 then
      if state1 == state2 then
        if info1.rank == info2.rank then
          return param1.baseId > param2.baseId
        else
          return info1.rank > info2.rank
        end
      else
        return state1 > state2
      end
    else
      return canOperate1 < canOperate2
    end
  end)
end
function prototype:onSelectHero()
  local isFromCultivateFlage = Logic:Get("Cultivate"):getFromRecultivateFlage()
  if not isFromCultivateFlage and Logic:Get("Cultivate"):isFromBattle() then
    SceneHelper:removeScene("CultivateSelectHero")
    SceneHelper:pushScene("Cultivate", self.rootNode)
    return
  end
  SceneHelper:removeScene("CultivateSelectHero")
end
function prototype:onBtnLeft()
  self.tableViewControl:TurnPage(-1)
end
function prototype:onBtnRight()
  self.tableViewControl:TurnPage(1)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:removeScene("CultivateSelectHero")
end
function prototype:onBtnRebuild(sender, event)
  Logic:Get("Cultivate"):setFromBattle(false)
  SceneHelper:pushScene("CultivateRebuild", self.rootNode)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 117)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  self.staPage:setString(string.format("%d/%d", curPage or 1, self.page or 1))
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("CultivateSelectHeroItem", self.rootNode)
    subScene.pHeroItem:RefreshHeros(self.heros[(curPage - 1) * MAX_HEROS_PER_PAGE + index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2)
    cell:getChildByTag(2).pHeroItem:RefreshHeros(self.heros[(curPage - 1) * MAX_HEROS_PER_PAGE + index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.page == curPage then
    return #self.heros - (self.page - 1) * MAX_HEROS_PER_PAGE
  else
    return MAX_HEROS_PER_PAGE
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
