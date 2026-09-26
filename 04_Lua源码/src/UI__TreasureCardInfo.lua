module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local CARD_SIZE_WIDTH = 122
function prototype:onEnter()
end
function prototype:ReFrashHeroInfo(heroInfo)
  local fdb_baseHero = Logic:Get("HeroCardInfo"):kdbBaseHero(heroInfo.baseId)
  if fdb_baseHero == nil then
    return
  end
  self:createHeroCard(heroInfo.baseId, heroInfo.fra)
  if heroInfo.fra ~= nil then
    local fraName = TwGetStr(103134)
    self.name:setString(heroInfo.itemName or "")
  else
    self.name:setString(fdb_baseHero.name or "")
  end
  local color = Logic:Get("Hero"):getColorByBaseId(heroInfo.baseId)
  self.name:setColor(color)
  self.ttfGet:setColor(ccColor3B(255, 0, 0))
  self.ttfGet:setString(ReplaceStringTab(fdb_baseHero.gain or ""))
  self.ttfUse:setDimensions(CCSize(500, 0))
  self.ttfUse:setHorizontalAlignment(kCCTextAlignmentLeft)
  local text2 = fdb_baseHero.description or ""
  text2 = ReplaceStringTab(text2)
  self.ttfUse:setString(text2 or "")
end
function prototype:createHeroCard(baseId, fra)
  if baseId == nil then
    return
  end
  local node = Logic:Get("HeroCardInfo"):createHeroCard(baseId, nil, fra)
  if node == nil then
    return
  end
  local cardSz = node:getContentSize()
  node:setScale(1 * (CARD_SIZE_WIDTH / cardSz.width))
  node:setAnchorPoint(CCPoint(0.5, 0.5))
  self.layer:addChild(node)
  node:setPosition(self.head:getPosition())
end
