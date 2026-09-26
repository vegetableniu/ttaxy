require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:updateGuide()
end
function prototype:onConfirm()
  Logic:Get("Guide"):done("TalismanEquip", "SelectFabaoDone")
  local selechero = Logic:Get("Talisman"):GetSelectHero()
  local tailIds = Logic:Get("Talisman"):GetEquipTail_IDS()
  local ids = {}
  for k, v in pairs(tailIds) do
    table.insert(ids, v)
  end
  Logic:Get("Talisman"):Post_REPLACE_HERO_TALISMANS(selechero.id, ids)
  Logic:Get("Talisman"):FireEvent(Logic.Talisman.EVT.CONFIG_SELE_TREASURE_BTN)
  SceneHelper:popScene()
end
function prototype:onConfirmSelect()
end
function prototype:updateGuide()
  if Logic:Get("Guide"):isActive("TalismanEquip", "SelectFabaoDone") then
    Logic:Get("Guide"):lockTouch(self.btnConfirm)
  end
end
