module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local MAX_ITEM_COUNT = 5
local MAX_COMBO_COUNT = 3
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  local player = Logic:Get("Fight"):GetOwn()
  local enemy = Logic:Get("Fight"):GetEnemy()
  if player and enemy then
    self:setBgImg()
    self.ttfPlayerName:setString(player.name)
    self.ttfPlayerLv:setString(TwGetStr(105311, player.level))
    self.ttfPlayerPower:setString(player.battleEffect)
    local artLv = Logic:Get("Artifact"):GetArtLevel()
    if artLv and artLv >= 0 then
      self.nodPlayerArtLv:create(0, "YELLOW_E_NUM")
      self.nodPlayerArtLv:setAlign("CENTER", "CENTER")
      self.nodPlayerArtLv:setValue(artLv)
    end
    self.ttfFighterName:setString(enemy.name)
    self.ttfEnemyLv:setString(TwGetStr(105311, enemy.level))
    self.ttfEnemyPower:setString(enemy.battleEffect)
    if enemy.artifactLevel and 0 <= enemy.artifactLevel then
      self.nodEnemyArtLv:create(0, "YELLOW_E_NUM")
      self.nodEnemyArtLv:setAlign("CENTER", "CENTER")
      self.nodEnemyArtLv:setValue(enemy.artifactLevel)
    end
    self.data = Logic:Get("Fight"):GetGroupData()
    self.tableViewControl = TableViewEx.prototype:createList(self, self.lstCompare, #self.data)
    self.tableViewControl:RequireUpdate()
    self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionHorizontal)
    self.lstCompare:addChild(self.tableViewControl.tableView)
  end
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnCloseClicked(sender, event)
  SceneHelper:popScene()
end
function prototype:onBtnLeft(sender, event)
  if self.tableViewControl then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onBtnRight(sender, event)
  if self.tableViewControl then
    self.tableViewControl:TurnPage(1)
  end
end
function prototype:setBgImg()
  local path = "images/public/bg_fightResult.png"
  local spr = CCSprite:create(path)
  for i = 1, 2 do
    local str = string.format("sprBg%d", i)
    if self[str] and spr then
      self[str]:setSpriteFrame(spr:displayFrame())
      self[str]:setContentSize(CCSizeMake(280, 713))
    end
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 180)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("FightCompareList", self.rootNode)
    subScene:ReFrashFighterInfo(self.data[curPage])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):ReFrashFighterInfo(self.data[curPage])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.data and self.data[curPage] and next(self.data[curPage]) ~= nil then
    return 1
  else
    return 0
  end
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
