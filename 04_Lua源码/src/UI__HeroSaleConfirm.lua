module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onConfirm()
  SceneHelper:pushPrompt("HeroSaleTip", self.rootNode)
end
function prototype:onConfirmSale()
  if #self.heros ~= 0 then
    Logic:Get("Hero"):PostSellHero(self.heros)
    Logic:Get("BGSound"):PlayEffect("audio/sale.mp3")
  end
end
