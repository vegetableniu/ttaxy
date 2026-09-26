module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter(...)
end
function prototype:onBtnClose(...)
  SceneHelper:removeScene("CultivateCrossFail")
end
function prototype:onBtnCardTip(...)
  SceneHelper:runWithScene("HeroUpgrade")
end
