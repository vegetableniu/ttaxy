module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:refresh(data)
  if not data then
    self:clear()
    return
  end
  self.data = data
  local baseId = data
  local path = Logic:Get("Armor"):getArmorImgBg(baseId)
  local sprBg = CCSprite:create(path)
  if sprBg then
    self.sprBg:setDisplayFrame(sprBg:displayFrame())
  end
  path = Logic:Get("Armor"):getArmorImg(baseId)
  local sprIcon = CCSprite:create(path)
  if sprIcon then
    self.sprArmor:setDisplayFrame(sprIcon:displayFrame())
  end
  local rec = Logic:Get("Armor"):getArmorInfoByBaseId(baseId) or {}
  if rec.star and rec.star > 0 then
    local path = string.format("images/Equip/%d.png", rec.star)
    local spr = CCSprite:create(path)
    if spr then
      self.sprPlus:setDisplayFrame(spr:displayFrame())
    end
  end
end
function prototype:clear()
  local sprBg = CCSprite:create("images/public/herobg.png")
  if sprBg then
    self.sprBg:setDisplayFrame(sprBg:displayFrame())
  end
end
function prototype:onBtnArmor(sender, event)
  if not self.data then
    return
  end
  Logic:Get("Armor"):openArmorDetails(self.data)
end
