module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.content:setStyle(kCCLabelTTFStyleOutline)
  self.allGiftIdTable = Logic:Get("Devil"):initRewardData()
  Logic:Get("Devil"):removeDrawFeatReward(self.allGiftIdTable)
  self.drawData = nil
  self.maxFeat = 0
  local feat = Logic:Get("Devil"):getFeat()
  for i, v in ipairs(self.allGiftIdTable) do
    if feat >= v.feat and v.feat > self.maxFeat then
      self.maxFeat = v.feat
    end
  end
  self.content:setString(TwGetStr(105558, self.maxFeat))
end
function prototype:onMenuClose(sender, event)
  self:onBtnSure(sender, event)
end
function prototype:onBtnSure(sender, event)
  SceneHelper:removePrompt(self.rootNode)
  SceneHelper:runWithScene("DevilGift", self.rootNode)
end
