module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local STUFF_GAP = 50
local HERO_GAP = 50
function prototype:onEnter(...)
  self.totalHeight = 0
  self.cardHeight = 0
  self.stuffHeight = 0
  self.sprBgHero:setAnchorPoint(ccp(0.5, 1))
  self.sprBgStuff:setAnchorPoint(ccp(0.5, 1))
end
function prototype:refresh(baseId)
  self:refreshUseCard(baseId)
  self:refreshSrcStuff(baseId)
  self:adaptPos()
end
function prototype:refreshUseCard(baseId)
  local heroInfos = Logic:Get("Cultivate"):GetHerosByPillId(baseId)
  local posY = -80
  local height = 0
  for i, v in ipairs(heroInfos) do
    local ccbItem = Tw.Controller:load("CultivatePillHeroItem", self.rootNode)
    if ccbItem then
      ccbItem:refresh(v.hero, v.state)
      ccbItem:setPosition(ccp(0, posY))
      self.nodeHero:addChild(ccbItem)
    end
    posY = posY - 80
    height = height + 80
  end
  self.cardHeight = height
  if height == 0 then
    self.cardHeight = -HERO_GAP
    self.nodeHero:setVisible(false)
    return
  end
  local size = self.sprBgHero:getContentSize()
  self.sprBgHero:setContentSize(CCSizeMake(size.width, height + 40))
end
function prototype:refreshSrcStuff(baseId)
  local rec = Logic:Get("Cultivate"):GetPillInfoByBaseId(baseId)
  local tMaterials = json.decode(rec.materials or "") or {}
  local posY = -80
  local height = 0
  for k, v in pairs(tMaterials) do
    local ccbItem = Tw.Controller:load("CultivatePillStuffItem", self.rootNode)
    if ccbItem then
      ccbItem:refresh(k, v)
      ccbItem:setPosition(ccp(0, posY))
      self.nodeStuff:addChild(ccbItem)
    end
    posY = posY - 80
    height = height + 80
  end
  self.stuffHeight = height
  if height == 0 then
    self.stuffHeight = -STUFF_GAP
    self.nodeStuff:setVisible(false)
    return
  end
  self.stuffHeight = self.stuffHeight + 40
  local size = self.sprBgStuff:getContentSize()
  self.sprBgStuff:setContentSize(CCSizeMake(size.width, height + 40))
end
function prototype:adaptPos()
  self.totalHeight = self.cardHeight + self.stuffHeight + HERO_GAP + STUFF_GAP
  self.nodeStuff:setPositionY(self.totalHeight - STUFF_GAP)
  self.nodeHero:setPositionY(self.cardHeight)
  local oldSize = self.layer:getContentSize()
  self.layer:setContentSize(CCSizeMake(oldSize.width, self.totalHeight))
end
function prototype:getSize()
  return self.layer:getContentSize()
end
