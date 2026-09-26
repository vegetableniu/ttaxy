module((...), package.seeall)
local CONNECT_SHOW_NOTICE = 1500
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
  log4msg:info("Block begin")
end
function prototype:dispose(...)
  log4msg:info("Block end")
  super.dispose(self)
end
function prototype:onEnter(node, loader)
  self.layInfo:setVisible(false)
  self.staNetConnect:setString(TwGetStr(10109))
  self.staNetConectText:setDimensions(CCSize(350, 0))
  self.staNetConectText:setHorizontalAlignment(kCCTextAlignmentLeft)
  self.staNetConectText:setString(TwGetStr(10108))
  if not self:EventTracer():Exist("onShowNotice") then
    Singleton(Timer):After(CONNECT_SHOW_NOTICE, self:Event("onShowNotice"))
  end
end
function prototype:onShowNotice()
  self:showInstant()
end
function prototype:showInstant()
  log4msg:info("Block visible.")
  self.layInfo:setVisible(true)
end
