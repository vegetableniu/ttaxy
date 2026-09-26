module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  Logic:Get("Fight"):setGuideFightDraw(true)
  self.btnSure:setEnabled(false)
  Singleton(Timer):After(3000, self:Event("setGoOn"))
end
function prototype:onBtnSure(node, loader)
  Logic:Get("Fight"):setGuideFightDraw(false)
  Logic:Get("Guide"):check()
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onMenuClose(node, loader)
end
function prototype:onExit()
  Logic:Get("Fight"):setGuideFightDraw(false)
end
function prototype:setGoOn()
  self.btnSure:setEnabled(true)
  local ccSprite = CCSprite:create("images/font/click_go_on.png")
  if ccSprite ~= nil then
    self.rootNode:addChild(ccSprite, 0, 10)
    local seq1 = Logic:Get("Gift"):fadetoSpr()
    ccSprite:runAction(CCRepeatForever:create(seq1))
    ccSprite:setPosition(self.goOn:getPosition())
  end
end
