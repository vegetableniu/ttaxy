module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  local data = Logic:Get("PlayerInfo"):GetDailyRewardData()
  for i, v in ipairs(data) do
    local str = string.format("ccbReward%d", i)
    if self[str] then
      self[str]:RefreshReward(v)
    end
  end
  Logic:Get("PlayerInfo"):On(Logic.PlayerInfo.EVT.DRAW_DAILY_REWARDS, self:Event("onDrawDailyRewards"))
  local data = Logic:Get("PlayerInfo"):GetDailyCheckInfo()
  local pathTitle = ""
  local pathSeven = ""
  if data.first then
    pathTitle = "images/Daily/firstFocus.png"
    pathSeven = "images/newfont/dailyReward.png"
  else
    pathTitle = "images/Daily/dailyFocus.png"
    pathSeven = "images/newfont/dailyDraw.png"
  end
  local spr = CCSprite:create(pathTitle)
  if spr then
    self.sprTitle:setDisplayFrame(spr:displayFrame())
    self.sprTitle:setScale(1.25)
  end
  spr = CCSprite:create(pathSeven)
  if spr then
    self.sprSeven:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:onExit()
end
function prototype:onBtnBg(sender, event)
end
function prototype:onBtnDraw(sender, event)
  SceneHelper:popScene()
  Logic:Get("PlayerInfo"):PostDailyCheckIn()
end
function prototype:onDrawDailyRewards()
  self:onBtnDraw()
end
