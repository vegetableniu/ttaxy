require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.SELECT_ROUTE, self:Event("onSelectRoute"))
end
function prototype:onSelectRoute()
  SceneHelper:removeScene("RicherValeRouteTip")
end
function prototype:onBtnBg()
end
function prototype:onBtnChooseA()
  Logic:Get("NewMonopoly"):PostSelectRoute(true)
end
function prototype:onBtnChooseB()
  Logic:Get("NewMonopoly"):PostSelectRoute(false)
end
