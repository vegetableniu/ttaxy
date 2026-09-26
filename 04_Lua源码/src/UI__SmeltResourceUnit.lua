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
  local info
  info = Logic:Get("Hero"):GetHeroInfoById(data)
  if info then
    self:createHeroImg(info)
    return
  end
  info = Logic:Get("Talisman"):GetTailsmansByIds(data)
  if info then
    self:createFabaoImg(info)
    return
  end
  info = Logic:Get("Armor"):getArmorInfoById(data)
  if info then
    self:createEquipImg(info)
  end
end
function prototype:createHeroImg(data)
  local path = Logic:Get("Hero"):GetHeroBgImage(data.baseId)
  self:createBg(path)
  path = Logic:Get("Hero"):GetHeroImage(data.baseId)
  self:createImg(path)
  self.sprAdd:setVisible(false)
end
function prototype:createFabaoImg(data)
  local rec = KFDBGetRecord("TalismanSetting", data.baseId)
  local path = Logic:Get("Hero"):GetHeroBgImage(rec.baseId)
  self:createBg(path)
  path = Logic:Get("Hero"):GetHeroImage(rec.baseId)
  self:createImg(path)
  self.sprAdd:setVisible(false)
end
function prototype:createEquipImg(data)
  local path = Logic:Get("Armor"):getArmorImgBg(data.baseId)
  self:createBg(path)
  path = Logic:Get("Armor"):getArmorImg(data.baseId)
  self:createImg(path)
  local rec = Logic:Get("Armor"):getArmorInfoByBaseId(data.baseId) or {}
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
function prototype:createBg(path)
  local sprBg = CCSprite:create(path)
  if sprBg then
    self.bg:setDisplayFrame(sprBg:displayFrame())
  end
end
function prototype:createImg(path)
  local sprIcon = CCSprite:create(path)
  if sprIcon then
    self.icon:setDisplayFrame(sprIcon:displayFrame())
  end
end
function prototype:clear()
  self:createImg(path_clarity)
  self:createBg(path_bg)
  self.sprPlus:setVisible(false)
  self.sprAdd:setVisible(true)
end
function prototype:onBtnChoose(sender, event)
  SceneHelper:pushScene("SmeltResourceList", self.rootNode)
end
