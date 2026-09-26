module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  self.btnHero:setZoomOnTouchDown(false)
  self.btnBg:setZoomOnTouchDown(false)
end
function prototype:onBtnHero()
  Logic:Get("Main"):CuMengMainGuide("LevelUp", "SelectMaterialWait")
  Logic:Get("Guide"):done("LevelUp", "SelectMaterialWait")
  Logic:Get("Guide"):done("FightLevelUp", "SelectMaterialWait")
  SceneHelper:pushScene("HeroSwallowSelect", self.rootNode)
end
function prototype:Init(flag)
  if flag then
    self.btnHero:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/clarity05.png"), CCControlStateNormal)
    self.btnHero:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/clarity05.png"), CCControlStateHighlighted)
    self.btnHero:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/clarity05.png"), CCControlStateDisabled)
    self.btnBg:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/clarity05.png"), CCControlStateNormal)
    self.btnBg:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/clarity05.png"), CCControlStateHighlighted)
    self.btnBg:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/clarity05.png"), CCControlStateDisabled)
  else
    self.btnHero:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/selcet3.png"), CCControlStateNormal)
    self.btnHero:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/selcet3.png"), CCControlStateHighlighted)
    self.btnHero:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/selcet3.png"), CCControlStateDisabled)
  end
end
