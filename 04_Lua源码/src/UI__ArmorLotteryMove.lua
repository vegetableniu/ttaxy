module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:setArmor(baseId, level)
  self.baseId = baseId
  self.level = level
  local rec = Logic:Get("Armor"):getArmorInfoByBaseId(baseId)
  if rec then
    local color = Logic:Get("Armor"):getColorByBaseId(baseId)
    self.ttfName:setColor(color)
    self.ttfName:setString(rec.name)
    local sprArmor = Logic:Get("Armor"):createArmorCard(baseId)
    local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(sprArmor, sprArmor:getContentSize())
    if texture and textureRect then
      self.sprArmor:setTexture(texture)
      self.sprArmor:setTextureRect(textureRect)
      Logic:Get("Armor"):addStarLv(self.sprArmor, baseId)
    end
  end
end
function prototype:onBtnHeroInfo()
  Logic:Get("Armor"):openArmorDetails(self.baseId)
end
