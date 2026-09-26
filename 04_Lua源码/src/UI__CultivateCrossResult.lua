module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter(...)
  local heroId, state = Logic:Get("Cultivate"):GetCrossHeroInfo()
  self:refreshCard(heroId, state)
  self:refreshCrossingData(heroId)
  self:runAni()
end
function prototype:refreshCard(heroId, state)
  local hero = Logic:Get("Hero"):GetHeroInfoById(heroId)
  self.hero = hero
  local nodeCard = Logic:Get("HeroCardInfo"):createHeroCardForByFight(hero.baseId)
  local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(nodeCard)
  self.sprCard:setTexture(texture)
  self.sprCard:setTextureRect(textureRect)
  local path = "images/Cultivate/state_" .. state .. ".png"
  local spr = CCSprite:create(path)
  if spr then
    self.sprState:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:refreshCrossingData(heroId)
  local addInfos = Logic:Get("Cultivate"):GetCrossingData(heroId)
  if not addInfos then
    return
  end
  if not self.tableViewControl then
    self.tableViewControl = TableViewEx.prototype:createList(self, self.lstView, 1)
    self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
    self.lstView:addChild(self.tableViewControl.tableView)
  end
  self.data = addInfos
  self.tableViewControl:RequireUpdate()
end
function prototype:runAni()
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIdj02", self.layer, ccp(320, 480), 0, nil, 1)
  if self.ani then
    self.ani:RunAni(nil, nil, bind(self.aniEnd, self))
  end
end
function prototype:aniEnd()
  self.cover:setVisible(false)
  self.ani:RemoveAnimation()
end
function prototype:onBtnCard(...)
  if not self.hero then
    return
  end
  Logic:Get("HeroCardInfo"):OpenHeroInfo(self.hero)
end
function prototype:onBtnClose(...)
  SceneHelper:removeScene("CultivateCrossResult")
end
function prototype:cellSizeForTable()
  return CCSizeMake(540, 40)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local idx = index + 1
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("CultivateCrossItem", self.rootNode)
    subScene:refresh(self.data[idx])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):refresh(self.data[idx])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if not self.data then
    return 0
  end
  return #self.data
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
end
