module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  local level = Logic:Get("Draw"):getNextDrawLevel()
  local x = self.staLevel:getPositionX()
  local position = TwGetStr(108017)
  x = x + tonumber(position)
  self.staLevel:setPositionX(x)
  if level then
    self.staLevel:setString(level)
  end
  self:SetBackGround()
end
function prototype:onBtnDrawEntry()
  if not self.eventTracer:Exist("onEnterDraw") then
    Logic:Get("Draw"):On(Logic.Draw.EVT.GET_OTHER_DRAW_RESULT, self:Event("onEnterDraw"))
  end
  MsgPlayer:Post("ROULETTE_LOTTERY_RESULTS")
end
function prototype:onEnterDraw()
  SceneHelper:removeScene("DrawEntry")
  SceneHelper:pushScene("DrawMain", nil, self.mainScene)
end
function prototype:SetBackGround()
  local bgSp = CCSprite:create("images/BattleShow/fightResult_bg.png")
  local bgTexture, bgTextureRect = Logic:Get("HeroCardInfo"):GetCardTexture(bgSp, nil, false, CCSize(640, 833))
  self.mspBg:setTexture(bgTexture)
  self.mspBg:setTextureRect(bgTextureRect)
end
function prototype:onBtnEntry()
  self:onBtnDrawEntry()
end
