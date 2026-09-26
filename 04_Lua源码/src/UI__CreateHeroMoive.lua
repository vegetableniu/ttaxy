module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  local UniqueId = Logic:Get("System"):GetUniqueId()
  CUMengAgent:OnEvent("CreateHeroMove", UniqueId)
  self.btnEnter:setEnabled(true)
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/SYD", self.layer, ccp(320, 480), 0, nil, 1)
  local text3 = self.ani:GetChild("staText3")
  local text4 = self.ani:GetChild("staText4")
  local text5 = self.ani:GetChild("staText5")
  text3:setDimensions(CCSize(608, 0))
  text4:setDimensions(CCSize(608, 0))
  text5:setDimensions(CCSize(608, 0))
  text3:setString(TwGetStr(104302))
  text4:setString(TwGetStr(104303))
  text5:setString(TwGetStr(104304))
  if self.ani then
    self.ani:RunAni(nil, true, bind(self.changeToCreateHero, self))
  end
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:changeToCreateHero()
  Logic:Get("CreateHero"):CreateHeroMovieEnd()
end
function prototype:onBtnEnterClicked(sender, event)
  self:changeToCreateHero()
end
