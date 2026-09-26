module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:updateGuide()
  if Logic:Get("Guide"):isActive("LevelUp", "SelectMaterialConfirm") then
    Logic:Get("Guide"):lockTouch(self.btnConfirm)
  end
  if Logic:Get("Guide"):isActive("FightLevelUp", "SelectMaterialConfirm") then
    Logic:Get("Guide"):lockTouch(self.btnConfirm)
  end
end
function prototype:onConfirm()
  local swallowFabao = Logic:Get("Talisman"):GetTemFabaos()
  local bConfirm = false
  if not swallowFabao then
    SceneHelper:popScene()
  end
  Logic:Get("Talisman"):SetSwallFabaos()
  Logic:Get("Talisman"):FireEvent(Logic.Talisman.EVT.OPT_SWALLOWFABAO_SET)
  SceneHelper:popScene()
end
function prototype:onConfirmSelect()
  Logic:Get("Talisman"):SetSwallFabaos()
  Logic:Get("Talisman"):FireEvent(Logic.Talisman.EVT.OPT_SWALLOWFABAO_SET)
  SceneHelper:popScene()
end
