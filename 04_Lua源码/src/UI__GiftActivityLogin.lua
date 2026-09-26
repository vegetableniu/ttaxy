module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("Logic.Compose")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onBtnReturn()
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onEnter()
  super.onEnter(self)
  Logic:Get("PlayerInfo"):On(Logic.PlayerInfo.EVT.REFRESH_GET_REWARD, self:Event("Refresh"))
  Logic:Get("Gift"):SetGiftInfoType("Activity")
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.title_ttf:setColor(ccc3(255, 183, 18))
  self.title_ttf:setString(giftInfo.name)
  self.title_ttf:setStyle(kCCLabelTTFStyleOutline)
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz", self.sprRight, ccp(35, 19), 0, nil, nil)
  if self.ani then
    self.ani:RunAni()
  end
  self:Refresh()
end
function prototype:onBtnRecharge(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
function prototype:onBtnGetReward(sender, event)
  Logic:Get("PlayerInfo"):PostDailyCheckIn()
end
function prototype:Refresh()
  local data = Logic:Get("PlayerInfo"):GetDailyRewardData()
  for i, v in ipairs(data) do
    local str = string.format("reward%d", i)
    if self[str] then
      self[str]:RefreshReward(v)
    end
  end
  local data = Logic:Get("PlayerInfo"):GetDailyCheckInfo()
  local pathTitle = ""
  local pathSeven = ""
  if data.first then
    pathTitle = "images/newfont/firstLoginDesr.png"
    pathSeven = "images/newfont/dailyReward.png"
  else
    pathTitle = "images/newfont/dailyLoginDesr.png"
    pathSeven = "images/newfont/dailyDraw.png"
  end
  local spr = CCSprite:create(pathTitle)
  if spr then
    self.tip_spr:setDisplayFrame(spr:displayFrame())
  end
  spr = CCSprite:create(pathSeven)
  if spr then
    self.seven_tip:setDisplayFrame(spr:displayFrame())
  end
end
