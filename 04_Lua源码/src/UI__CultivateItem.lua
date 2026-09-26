module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:refreshMedicineInfo(medicineInfo)
  self:clear()
  if medicineInfo == nil then
    return
  end
  self.medicineInfo = medicineInfo
  local pill = Logic:Get("Cultivate"):GetPillByBaseId(medicineInfo.baseId) or 0
  local canCompose = Logic:Get("Cultivate"):canComposeElixirByBaseId(medicineInfo.baseId)
  if pill == 0 and not canCompose then
    self.imgAdd:setVisible(false)
  else
    self.imgAdd:setVisible(true)
  end
  self.btnMedicine:setVisible(true)
  self.sprLock:setVisible(false)
  self.btnMedicine:setEnabled(true)
  local strImage = Logic:Get("Cultivate"):getElixirImg(medicineInfo.baseId)
  if Logic:Get("Cultivate"):getHeroSwallowElixir(medicineInfo.position, medicineInfo.heroId) then
    self.imgAdd:setVisible(false)
  else
    strImage = Logic:Get("Cultivate"):getElixirImg(medicineInfo.baseId, nil, true)
  end
  if strImage then
    self.btnMedicine:setBackgroundSpriteForState(CCScale9Sprite:create(strImage), CCControlStateNormal)
    self.btnMedicine:setBackgroundSpriteForState(CCScale9Sprite:create(strImage), CCControlStateHighlighted)
    self.btnMedicine:setBackgroundSpriteForState(CCScale9Sprite:create(strImage), CCControlStateDisabled)
  end
  local strBg = "images/Cultivate/xx_icon_zi.png"
  if strBg then
    self.btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(strBg), CCControlStateNormal)
    self.btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(strBg), CCControlStateHighlighted)
    self.btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(strBg), CCControlStateDisabled)
  end
end
function prototype:clear()
  local imgPath = "images/public/clarity05.png"
  self.btnMedicine:setBackgroundSpriteForState(CCScale9Sprite:create(imgPath), CCControlStateNormal)
  self.btnMedicine:setBackgroundSpriteForState(CCScale9Sprite:create(imgPath), CCControlStateHighlighted)
  self.btnMedicine:setBackgroundSpriteForState(CCScale9Sprite:create(imgPath), CCControlStateDisabled)
  local strBg = "images/Cultivate/xx_icon_hui.png"
  if strBg then
    self.btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(strBg), CCControlStateNormal)
    self.btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(strBg), CCControlStateHighlighted)
    self.btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(strBg), CCControlStateDisabled)
  end
  local sprite = CCSprite:create("images/Cultivate/xx_icon_lock.png")
  if sprite then
    self.sprLock:setVisible(true)
    self.sprLock:setDisplayFrame(sprite:displayFrame())
  end
  self.imgAdd:setVisible(false)
  self.btnMedicine:setVisible(true)
  self.btnMedicine:setEnabled(false)
  self.btnBg:setEnabled(false)
end
function prototype:onBtnMedicine(...)
  local swallowElixir = Logic:Get("Cultivate"):getHeroSwallowElixir(self.medicineInfo.position, self.medicineInfo.heroId)
  if swallowElixir ~= nil then
    Logic:Get("Cultivate"):OpenPillDetail(self.medicineInfo.baseId, true)
    return
  end
  Logic:Get("Cultivate"):setMedicine(self.medicineInfo)
  SceneHelper:pushScene("CultivateComposeMedicine", self.rootNode, nil, nil, true)
end
