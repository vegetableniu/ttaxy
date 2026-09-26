module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local EVO_TYPE = Enum({
  "MATERIAL_EVO",
  "PAY_MONEY_EVO"
})
function prototype:onEnter()
  Logic:Get("ExplainEquip"):On(Logic.ExplainEquip.EVO_TYPE.CLOSE_PROMPT, self:Event("onRemoveSelf"))
end
function prototype:onBtnMaterialEvolution(sender, event)
  Logic:Get("ExplainEquip"):setEvolutionType(EVO_TYPE.MATERIAL_EVO)
  SceneHelper:runWithScene("HeroEvolution", self.rootNode)
end
function prototype:onBtnPayMoneyEvolution(sender, event)
  Logic:Get("ExplainEquip"):setEvolutionType(EVO_TYPE.PAY_MONEY_EVO)
  SceneHelper:runWithScene("HeroEvolution", self.rootNode)
end
function prototype:onBtnCancel(sender, event)
  self:onRemoveSelf()
end
function prototype:onRemoveSelf()
  SceneHelper:removePrompt(self.rootNode)
end
