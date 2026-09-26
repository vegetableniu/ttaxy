module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  local cardInfo = Logic:Get("Armor"):getArmorCardInfo()
  if cardInfo == nil then
    return
  end
  self.layer:refreshArmorInfo(cardInfo.baseId, cardInfo.fra)
end
function prototype:onBtnClose(sender, event)
  local bPrompt = Logic:Get("HeroCardInfo"):GetPromptHeroInfo()
  if bPrompt then
    SceneHelper:removePrompt(self.rootNode)
    return
  end
  SceneHelper:popScene()
end
