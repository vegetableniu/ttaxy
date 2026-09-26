module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  Logic:Get("DramaTalk"):OnGuideTrigger(74)
  Logic:Get("Lottery"):setGuideLottery(true)
  local ccSprite = CCSprite:create("images/font/click_go_on.png")
  if ccSprite ~= nil then
    self.rootNode:addChild(ccSprite, 0, 10)
    local seq1 = Logic:Get("Gift"):fadetoSpr()
    ccSprite:runAction(CCRepeatForever:create(seq1))
    ccSprite:setPosition(self.goOn:getPosition())
  end
end
function prototype:onBtnSure(node, loader)
  Logic:Get("Guide"):done("LotteryEvo", "Start")
  Logic:Get("Lottery"):setGuideLottery(false)
  Logic:Get("Guide"):check()
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onMenuClose(node, loader)
  self:onBtnSure()
end
function prototype:onExit()
  Logic:Get("Lottery"):setGuideLottery(false)
end
