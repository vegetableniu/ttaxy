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
  Logic:Get("Main"):CuMengMainGuide("LevelUp", "SelectMaterialConfirm")
  Logic:Get("Guide"):done("LevelUp", "SelectMaterialConfirm")
  Logic:Get("Guide"):done("FightLevelUp", "SelectMaterialConfirm")
  Logic:Get("Hero"):SwapHero(false)
  local swallowHero = Logic:Get("Hero"):GetSwallowHero()
  local bConfirm = false
  if not swallowHero then
    SceneHelper:popScene()
  end
  local info = KFDBGetRecord("ConfigValue", "HERO:HERO_UPGRADE")
  local num = 4
  if info then
    num = tonumber(info.content)
  end
  for k, v in pairs(swallowHero) do
    local hero = Logic:Get("Hero"):GetHeroInfoById(k)
    if hero then
      local info = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
      if info and num <= info.star then
        bConfirm = true
        break
      end
    end
  end
  if bConfirm then
    Prompt:Confirm(self, 104151, TwGetStr(104152, num), self.onConfirmSelect, Prompt.PROMPT_TYPE.SELECT)
  else
    Logic:Get("Hero"):FireEvent(Logic.Hero.EVT.OPT_SWALLOWHERO_SET)
    SceneHelper:popScene()
  end
end
function prototype:onConfirmSelect()
  Logic:Get("Hero"):FireEvent(Logic.Hero.EVT.OPT_SWALLOWHERO_SET)
  SceneHelper:popScene()
end
