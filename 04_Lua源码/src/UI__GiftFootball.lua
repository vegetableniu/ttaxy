module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.ttfBall:setStyle(kCCLabelTTFStyleOutline)
  self.ttfRateLeft:setStyle(kCCLabelTTFStyleOutline)
  self.ttfRateRight:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTip:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTip:setString(TwGetStr(111654))
  self.aniLeftShoot = Logic:Get("AniMgr"):NewCCB("UI/goal", self.aniNode, ccp(-5, 230))
  self.aniLeftMiss1 = Logic:Get("AniMgr"):NewCCB("UI/N_goal", self.aniNode, ccp(-25, 230))
  self.aniLeftMiss2 = Logic:Get("AniMgr"):NewCCB("UI/N_goal02", self.aniNode, ccp(-10, 230))
  self.aniNodeRight:setScaleX(-1)
  self.aniRightShoot = Logic:Get("AniMgr"):NewCCB("UI/goal", self.aniNodeRight, ccp(-40, 230))
  self.aniRightMiss1 = Logic:Get("AniMgr"):NewCCB("UI/N_goal", self.aniNodeRight, ccp(-25, 230))
  self.aniRightMiss2 = Logic:Get("AniMgr"):NewCCB("UI/N_goal02", self.aniNodeRight, ccp(-25, 230))
  self.aniLeftShoot:setVisible(false)
  self.aniLeftMiss1:setVisible(false)
  self.aniLeftMiss2:setVisible(false)
  self.aniRightShoot:setVisible(false)
  self.aniRightMiss1:setVisible(false)
  self.aniRightMiss2:setVisible(false)
  Logic:Get("Football"):PostLoadPitch()
  Logic:Get("Football"):On(Logic.Football.EVT.REFRESH_INFO, self:Event("setUIBaseInfo"))
  Logic:Get("Football"):On(Logic.Football.EVT.SHOOT_OVER, self:Event("runAnimation"))
end
function prototype:setUIBaseInfo()
  local progInfo = Logic:Get("Football"):getProgressInfo()
  local hits = Logic:Get("Football"):getHits()
  local ambition = (progInfo.hits or 0) - hits
  local counts = Logic:Get("Football"):getProgCounts()
  local curProgress = Logic:Get("Football"):getProgress()
  local usedFreeCounts = Logic:Get("Football"):getUsedFreeBalls()
  local buyBalls = Logic:Get("Football"):getBuyBalls()
  local freeCounts = (progInfo.freeBalls or 0) - usedFreeCounts + buyBalls
  if not (freeCounts >= 0) or not freeCounts then
    freeCounts = 0
  end
  self.ttfBall:setString(TwGetStr(111653, freeCounts))
  local mustHitTimesLeft = Logic:Get("Football"):getAbsHitCounts(1)
  local mustHitTimesRight = Logic:Get("Football"):getAbsHitCounts(2)
  if mustHitTimesLeft <= 0 then
    self.ttfRateLeft:setString(TwGetStr(111655))
  else
    self.ttfRateLeft:setString(TwGetStr(111656, mustHitTimesLeft + 1))
  end
  if mustHitTimesRight <= 0 then
    self.ttfRateRight:setString(TwGetStr(111659))
  else
    self.ttfRateRight:setString(TwGetStr(111656, mustHitTimesRight + 1))
  end
  self.finishFlag = false
  if ambition <= 0 and curProgress == counts then
    self.finishFlag = true
  end
  self:setRewardsInfo()
end
function prototype:runAnimation(scoreFlag, rewards)
  self.btnBg:setEnabled(true)
  self.sprBall:setVisible(false)
  self.nodeBtnLeft:setVisible(false)
  self.nodeBtnRight:setVisible(false)
  if scoreFlag then
    self.rewards = rewards
    if self.pos == 1 then
      self.aniRecord = self.aniLeftShoot
      self.aniLeftShoot:setVisible(true)
      self.aniLeftShoot:RunAni(nil, nil, bind(self.aniEnd, self))
    elseif self.pos == 2 then
      self.aniRecord = self.aniRightShoot
      self.aniRightShoot:setVisible(true)
      self.aniRightShoot:RunAni(nil, nil, bind(self.aniEnd, self))
    else
      return
    end
  else
    local index = math.random(1, 2)
    local aniStr = self.pos == 1 and "aniLeftMiss" or "aniRightMiss"
    aniStr = string.format(aniStr .. "%d", index)
    if self[aniStr] then
      self.aniRecord = self[aniStr]
      self.aniRecord:setVisible(true)
      self[aniStr]:RunAni(nil, nil, bind(self.aniEndMiss, self))
    end
  end
end
function prototype:aniEnd()
  local param = {}
  param.titlePath = "images/Football/gainReward.png"
  param.rewards = self.rewards
  param.minisizeFlag = true
  param.func = self.aniEndMiss
  Prompt:IconConfirm(self, param)
end
function prototype:aniEndMiss()
  self.btnBg:setEnabled(false)
  self.sprBall:setVisible(true)
  self.nodeBtnLeft:setVisible(true)
  self.nodeBtnRight:setVisible(true)
  if self.aniRecord then
    self.aniRecord:setVisible(false)
    self.aniRecord = nil
  end
  self:setUIBaseInfo()
end
function prototype:setRewardsInfo()
  self:clear()
  local rewardsInfo = Logic:Get("Football"):getRewardsInfo()
  self:setSingleRewards("ccbLeft", rewardsInfo[1])
  self:setSingleRewards("ccbRight", rewardsInfo[2])
end
function prototype:clear()
  for i = 1, 3 do
    local leftGood = string.format("ccbLeft%d", i)
    if self[leftGood] then
      self[leftGood]:setVisible(false)
    end
  end
  for i = 1, 3 do
    local rightGood = string.format("ccbRight%d", i)
    if self[rightGood] then
      self[rightGood]:setVisible(false)
    end
  end
end
function prototype:setSingleRewards(str, goodsInfo)
  if not goodsInfo or not goodsInfo.showType or table.empty(goodsInfo.showType) then
    return
  end
  for i, v in ipairs(goodsInfo.showType) do
    local strItem = string.format(str .. "%d", i)
    if self[strItem] then
      local giftInfo = {}
      giftInfo.showType = goodsInfo.showType[i] or ""
      giftInfo.showId = tonumber(goodsInfo.showIds[i]) or 1
      giftInfo.amount = goodsInfo.counts[i]
      self[strItem]:ReFreshByGift(giftInfo)
      self[strItem]:setVisible(true)
    end
  end
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:popScene()
end
function prototype:onBtnRule(sender, event)
  SceneHelper:pushScene("GiftFootballRule", self.rootNode)
end
function prototype:onBtnLeft(sender, event)
  self:onShoot(1)
end
function prototype:onBtnRight(sender, event)
  self:onShoot(2)
end
function prototype:onShoot(pos)
  if self.finishFlag then
    Prompt:Tip(111658)
    return
  end
  self.pos = pos
  if Logic:Get("Football"):isFree() then
    Logic:Get("Football"):PostFreeShoot(self.pos)
    return
  end
  local cost = KFDBGetRecord("ConfigValue", "FOOTBALL:SHOOT_COST")
  cost = cost and tonumber(cost.content) or 0
  local jade = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if cost > jade then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Prompt:ConfirmRecord(self, "", TwGetStr(111657, cost), self.onConfirm, Prompt.PROMPT_TYPE.SELECT, nil, Logic.SureConfirm.RECORD_TYPE.SHOOT)
end
function prototype:onConfirm()
  Logic:Get("Football"):PostShoot(self.pos)
end
