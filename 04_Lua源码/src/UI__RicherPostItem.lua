module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:initRewards(post)
  if table.empty(post) then
    return
  end
  self.posts = {}
  for _, v in pairs(post) do
    local str = self:createSingleStr(v)
    table.insert(self.posts, str)
  end
  self.currIdx = 1
  self:runAni()
end
function prototype:createSingleStr(post)
  local strTab = {}
  for _, reward in pairs(post.rewardResults or {}) do
    local str = Logic:Get("Reward"):RewardTreaTip(reward)
    local map = Logic:Get("Reward"):createMap(reward)
    local data = {}
    if map[reward.type] then
      data.showType = map[reward.type].showType[reward.code + 1] or ""
      data.showId = map[reward.type].showId[reward.code + 1] or 4
    end
    local _, color = Logic:Get("Gift"):GetColorByGift(data)
    local rewardStr = TwGetStr(110914, color, str or "")
    table.insert(strTab, rewardStr)
  end
  local rewardStr = table.concat(strTab, ",")
  local nameStr = TwGetStr(110914, "00fff6", post.name)
  local tempStr = ""
  if post.content then
    local rings = TwGetStr(110914, "00fff6", post.content)
    tempStr = TwGetStr(115080, nameStr, rings, rewardStr)
  else
    tempStr = TwGetStr(115081, nameStr, rewardStr)
  end
  local str = TwGetStr(110914, "fcff00", tempStr)
  return str
end
function prototype:runAni()
  local sizeW = 430
  local sizeH = 15
  self.nodText:setString(self.posts[self.currIdx])
  self.nodText:setPositionX(sizeW)
  local sz = self.nodText:getContentSize()
  local pt = ccp(sizeW - sz.width, sizeH)
  local time = sz.width / 40
  local action = {}
  local actionMoveTo = CCMoveTo:create(time, pt)
  table.insert(action, CCMoveTo:create(0, ccp(sizeW, sizeH)))
  table.insert(action, actionMoveTo)
  table.insert(action, CCDelayTime:create(3))
  table.insert(action, CCMoveTo:create(0, ccp(sizeW + 1, sizeH)))
  table.insert(action, CCCallFuncN:create(function()
    self.currIdx = self.currIdx + 1
    self.currIdx = self.currIdx > #self.posts and 1 or self.currIdx
    self:runAni()
  end))
  self.nodText:runAction(Logic:Get("AniMgr"):CreateSequence(action))
end
