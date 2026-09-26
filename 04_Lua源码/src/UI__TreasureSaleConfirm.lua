require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.titleOne:setString(TwGetStr(103114))
  self.titleTwo:setString(TwGetStr(103115))
end
function prototype:updateGuide()
  if Logic:Get("Guide"):isActive("SkillUpgrade", "SelectTreasureDone") then
    Logic:Get("Guide"):lockTouch(self.btnConfirm)
  end
end
function prototype:onConfirm()
  Logic:Get("Guide"):done("SkillUpgrade", "SelectTreasureDone")
  local treas = Logic:Get("Treasure"):GetSeleTrea()
  Logic:Get("Treasure"):SetHeroSeleCur(treas)
  Logic:Get("Treasure"):FireEvent(Logic.Treasure.EVT.REFRESH_TREA)
  SceneHelper:popScene()
end
function prototype:onConfirmSelect()
end
