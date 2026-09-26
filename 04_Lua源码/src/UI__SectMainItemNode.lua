module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:initialize()
  super.initialize(self)
  Logic:Get("SectMain"):On(Logic.SectMain.EVT.TIMER, self:Event("timer"))
  self.beginTime = false
  self.isPlayAni = false
end
function prototype:onEnter()
  self.staFlg:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:refreshInfo(info)
  if not info then
    return
  end
  self.beginTime = false
  self.isPlayAni = false
  self.imgFlag:removeAllChildrenWithCleanup(true)
  self.fun = info.fun
  self.ani = info.ani
  if info.normal then
    self.btnDown:setBackgroundSpriteForState(CCScale9Sprite:create(info.normal), CCControlStateNormal)
  end
  if info.select then
    self.btnDown:setBackgroundSpriteForState(CCScale9Sprite:create(info.select), CCControlStateHighlighted)
  end
  if info.disable then
    self.btnDown:setBackgroundSpriteForState(CCScale9Sprite:create(info.disable), CCControlStateDisabled)
  end
end
function prototype:onBtnDown(sender, event)
  if self.fun then
    local logic = Logic:Get("SectMain")
    logic[self.fun](sender, event)
  end
end
function prototype:setButtonEnable(enable)
  self.btnDown:setEnabled(enable)
end
function prototype:setBeginTimer(begin)
  self.beginTime = begin
  if self.beginTime then
    self:timer()
  end
end
function prototype:getBeginTimer()
  return self.beginTime
end
function prototype:timer()
  if not self.beginTime then
    return
  end
  self:ShowSpringColl()
end
function prototype:playAni()
  if not self.ani or self.isPlayAni then
    return
  end
  self.imgFlag:removeAllChildrenWithCleanup(true)
  self.isPlayAni = true
  Logic:Get("AniMgr"):RunCCBAni(self.ani, self.imgFlag, nil, 1, nil, nil, nil, -1)
  self.imgFlag:setVisible(self.isPlayAni)
end
function prototype:closeAni()
  if self.isPlayAni then
    self.imgFlag:removeAllChildrenWithCleanup(true)
    self.isPlayAni = false
    self.imgFlag:setVisible(self.isPlayAni)
  end
end
function prototype:ShowSpringColl()
  local springCoolTime = Logic:Get("Sect"):GetRefreshTime()
  if 0 == springCoolTime then
    self:playAni()
    self.staFlg:setVisible(false)
    self.btnDown:setEnabled(true)
  else
    self:closeAni()
    self.staFlg:setVisible(true)
    self.btnDown:setEnabled(false)
    self.staFlg:setString(springCoolTime)
  end
end
