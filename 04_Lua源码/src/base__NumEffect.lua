module((...), package.seeall)
require("UI.UIDefine")
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self)
  self.bg = 0
  self.ed = 100
  self.interval = 1000
  self.add = 1
  self.bIncrease = true
  self.fontSize = UIDefine.DEFAULT_FONT_SIZE
  self.ccColor = ccColor3B()
  self.ccColor.r = 0
  self.ccColor.g = 0
  self.ccColor.b = 0
end
function prototype:dispose()
  self.dispose(self)
end
function prototype:RunEffect(view, nBegin, nEnd, nInterval)
  if not view or nBegin == nEnd then
    return
  end
  self.view = view
  self.bg = nBegin
  self.ed = nEnd
  self.interval = nInterval
  if nBegin < nEnd then
    self.bIncrease = true
    self.add = math.modf((self.ed - self.bg) / 9)
  else
    self.bIncrease = false
    self.add = math.modf((self.bg - self.ed) / 9)
  end
  Singleton(Timer):Repeat(self.interval, self:Event("NUM_ADD_TIME_EVENT", "OnAddTimer"))
end
function prototype:OnAddTimer()
  self.view:setFontSize(self.fontSize)
  self.view:setColor(self.ccColor)
  if self.bIncrease then
    if self.bg > self.ed then
      self.bg = self.ed
    end
    self.view:setString(tostring(self.bg))
    self.bg = self.bg + self.add
    if self.bg > self.ed then
      self.view:setString(tostring(self.ed))
      self:EventTracer():Cancel("NUM_ADD_TIME_EVENT")
    end
  else
    if self.ed > self.bg then
      self.ed = self.bg
    end
    self.view:setString(tostring(self.bg))
    self.bg = self.bg - self.add
    if self.ed > self.bg then
      self.view:setString(tostring(self.ed))
      self:EventTracer():Cancel("NUM_ADD_TIME_EVENT")
    end
  end
end
function prototype:SetFontSize(size)
  self.fontSize = size or UIDefine.DEFAULT_FONT_SIZE
end
function prototype:SetColor(r, g, b)
  self.ccColor.r = r or 0
  self.ccColor.g = g or 0
  self.ccColor.b = b or 0
end
