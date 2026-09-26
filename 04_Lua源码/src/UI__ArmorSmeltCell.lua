module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local path_clarity = "images/public/clarity80.png"
local path_bg = "images/public/herobg.png"
function prototype:onEnter()
end
function prototype:refresh(data)
  self:clear()
  if not data then
    return
  end
  local path = Logic:Get("Armor"):getArmorImgBg(data)
  local sprBg = CCSprite:create(path)
  if sprBg then
    self.bg:setDisplayFrame(sprBg:displayFrame())
  end
  path = Logic:Get("Armor"):getArmorImg(data)
  local sprIcon = CCSprite:create(path)
  if sprIcon then
    self.icon:setDisplayFrame(sprIcon:displayFrame())
  end
  local rec = Logic:Get("Armor"):getArmorInfoByBaseId(data) or {}
  if rec.star and rec.star > 0 then
    self.sprPlus:setVisible(true)
    local path = string.format("images/Equip/%d.png", rec.star)
    local spr = CCSprite:create(path)
    if spr then
      self.sprPlus:setDisplayFrame(spr:displayFrame())
    end
  end
  self.sprAdd:setVisible(false)
end
function prototype:clear()
  local spr = CCSprite:create(path_clarity)
  if spr then
    self.icon:setDisplayFrame(spr:displayFrame())
  end
  spr = CCSprite:create(path_bg)
  if spr then
    self.bg:setDisplayFrame(spr:displayFrame())
  end
  self.sprPlus:setVisible(false)
  self.sprAdd:setVisible(true)
end
function prototype:onBtnChoose(sender, event)
  SceneHelper:pushScene("ArmorSmeltList", self.rootNode)
end
