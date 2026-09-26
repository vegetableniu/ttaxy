module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  self.btnSure:setEnabled(false)
  Singleton(Timer):After(3000, self:Event("setGoOn"))
end
function prototype:onBtnSure(node, loader)
  local divilData = Logic:Get("Devil"):GetHasDemog()
  if divilData then
    MsgDemog:Post("REFRESH_DEMOG")
    Logic:Get("Devil"):SetHasDemog(false)
  end
  Logic:Get("Devil"):SetComBattleId("")
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onMenuClose(node, loader)
end
function prototype:onExit()
end
function prototype:setGoOn()
  if self.eventTracer:Exist("setGoOn") then
    self:EventTracer():Cancel("setGoOn")
  end
  self.btnSure:setEnabled(true)
  local ccSprite = CCSprite:create("images/font/click_go_on.png")
  if ccSprite ~= nil then
    self.rootNode:addChild(ccSprite, 0, 10)
    local seq1 = Logic:Get("Gift"):fadetoSpr()
    ccSprite:runAction(CCRepeatForever:create(seq1))
    ccSprite:setPosition(self.goOn:getPosition())
  end
end
