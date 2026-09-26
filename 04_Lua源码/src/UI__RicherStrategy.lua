require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:onBtnBg()
  self:onBtnReturn()
end
function prototype:onBtnReturn()
  SceneHelper:popScene()
end
