module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  local GameId = Logic:Get("System"):GetMisc("Account").gameId
  if 1 == GameId then
    local BtnLeft = ccp(82, 764)
    local BtnRight = ccp(558, 764)
    self.imgBtnLeftBg:setPosition(BtnLeft)
    self.imgBtnRightBg:setPosition(BtnRight)
    self.sprLeft:setPosition(BtnLeft)
    self.sprRight:setPosition(BtnRight)
  elseif 3 == GameId then
    local BtnLeft = ccp(108, 761)
    local BtnRight = ccp(534, 761)
    local SprLeft = ccp(122, 761)
    local SprRight = ccp(520, 761)
    self.imgBtnLeftBg:setPosition(BtnLeft)
    self.imgBtnRightBg:setRotation(180)
    self.imgBtnRightBg:setPosition(BtnRight)
    self.sprLeft:setPosition(SprLeft)
    self.sprRight:setPosition(SprRight)
  end
end
