module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter(node, loader)
  self.staTitle:setString("")
  self.staInfo:setString("")
  self.staTitle:setColor(ccc3(211, 192, 162))
  self.staTitle:setStyle(kCCLabelTTFStyleOutline, ccc3(50, 40, 31))
  self.staInfo:setColor(ccc3(211, 192, 162))
  self.staInfo:setStyle(kCCLabelTTFStyleOutline, ccc3(50, 40, 31))
end
function prototype:refresh(idCamp)
  local info = Logic:Get("Battle"):GetCampaignInfoById(idCamp)
  if nil == info then
    return
  end
  self.staTitle:setString(info.intro_title or "")
  local text = info.introduction
  text = ReplaceStringTab(text)
  self.staInfo:setString(text or "")
end
