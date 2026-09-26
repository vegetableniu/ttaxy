module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("Logic.Compose")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onBtnReturn()
  SceneHelper:runWithScene("GiftActivityInfoCostRank", self.rootNode)
end
function prototype:onBtnRecharge(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
function prototype:onEnter()
  super.onEnter(self)
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz", self.sprRight, ccp(35, 19), 0, nil, nil)
  if self.ani then
    self.ani:RunAni()
  end
  self:RefreInfo()
end
function prototype:RefreInfo()
  self.content:setString(TwGetStr(103335))
  self.content:setHorizontalAlignment(kCCVerticalTextAlignmentCenter)
  local id = "COST_RANK_REWARD_3"
  local rankStr = ""
  local configValue = KFDBGetRecord("ConfigValue", id)
  local rewardIds = json.decode(configValue.content)
  local kValue = {
    "R1R1",
    "R2R5",
    "R6R10",
    "R11R20"
  }
  local num = 103327
  local numRes = 103345
  for i = 1, 4 do
    local str = string.format("rank%d", i)
    self[str]:setString(TwGetStr(num))
    num = num + 1
    local strRe = string.format("rankRe%d", i)
    self[strRe]:setString(TwGetStr(numRes))
    numRes = numRes + 1
    self[strRe]:setDimensions(CCSize(320, 0))
  end
end
function prototype:onBtnCheckRank(sender, event)
  SceneHelper:runWithScene("CostRank", self.rootNode)
end
