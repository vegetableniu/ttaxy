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
  if pill == 0 and not medicineInfo.canCompose then
    self.imgAdd:setVisible(false)
  else
    self.imgAdd:setVisible(true)
  end
  self.sprLock:setVisible(false)
  local strImage, strBg
  if Logic:Get("Cultivate"):getHeroSwallowElixir(medicineInfo.position, medicineInfo.heroId) then
    self.imgAdd:setVisible(false)
    strImage = Logic:Get("Cultivate"):getElixirImg(medicineInfo.baseId)
    strBg = Logic:Get("Cultivate"):getElixirImgBg(medicineInfo.baseId)
  else
    strImage = Logic:Get("Cultivate"):getElixirImg(medicineInfo.baseId, nil, true)
    strBg = Logic:Get("Cultivate"):getElixirImgBg(medicineInfo.baseId, nil, true)
  end
  local sprMedicine = CCSprite:create(strImage)
  if sprMedicine then
    self.sprMedicine:setDisplayFrame(sprMedicine:displayFrame())
  end
  local sprBg = CCSprite:create(strBg)
  if sprBg then
    self.sprBg:setDisplayFrame(sprBg:displayFrame())
  end
end
function prototype:clear()
  local imgPath = "images/public/clarity05.png"
  local sprMedicine = CCSprite:create(imgPath)
  if sprMedicine then
    self.sprMedicine:setDisplayFrame(sprMedicine:displayFrame())
  end
  local sprBg = CCSprite:create(imgPath)
  if sprBg then
    self.sprBg:setDisplayFrame(sprBg:displayFrame())
  end
  self.imgAdd:setVisible(false)
end
