require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.ttfTime:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTaskName:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:onBtnCheck(sender, event)
  if Logic:Get("Explore"):IsTaskFull() then
    Prompt:Fail(115212)
    return
  end
  Logic:Get("System"):SetSysVariableMisc("FirstExcute", 1)
  self.nodAni:removeAllChildrenWithCleanup(true)
  self.nodAni:stopAllActions()
  Logic:Get("Explore"):setCurrTask(self.data)
  SceneHelper:pushScene("ExploreTask", self.rootNode)
end
function prototype:onBtnComplete(sender, event)
  Logic:Get("Explore"):setCurrExecuteTask(self.data)
  local rate = self.data.rate > 100 and 100 or self.data.rate
  local cost = self:getCost()
  if not Logic:Get("PlayerInfo"):IsMoneyEnough(cost) then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Prompt:Confirm(self, "", TwGetStr(115234, rate, cost), self.onComfirm, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onBtnDraw(sender, event)
  Logic:Get("Explore"):setCurrExecuteTask(self.data)
  local rate = self.data.rate > 100 and 100 or self.data.rate
  if self.data.endAt and Logic:Get("System"):DiffTime(self.data.endAt / 1000) < 0 then
    Prompt:Confirm(self, "", TwGetStr(115236, rate), self.onDrawReward, Prompt.PROMPT_TYPE.SELECT)
  end
end
function prototype:onDrawReward()
  Logic:Get("Explore"):postDrawTaskReward()
end
function prototype:getCost()
  local rec = KFDBGetRecord("TaskStarConfig", self.data.star) or {}
  local diffTime = Logic:Get("System"):DiffTime(self.data.endAt / 1000)
  if diffTime < 0 then
    return 0
  end
  return math.ceil((rec.baseFinishCost or 0) * diffTime / 60)
end
function prototype:onComfirm()
  Logic:Get("Explore"):postImmediateFinish()
end
function prototype:Refresh(data, type, idx)
  if table.empty(data or {}) then
    return
  end
  self.data = data
  self.type = type
  self.nodComplete:setVisible(self.type == "EXECUTES")
  self.nodDraw:setVisible(self.type == "EXECUTES")
  self.nodCheck:setVisible(self.type == "RELEASES")
  self.nodLeftTime:setVisible(self.type == "RELEASES")
  self.nodAni:setVisible(self.type == "RELEASES")
  local rec = KFDBGetRecord("TaskPlace", data.point)
  self.ttfTaskName:setString(rec.taskName or "")
  local star = string.rep("*", data.star or 1)
  self.labStar:setString(star)
  self:refreshRewards()
  self:refreshTime()
  self.nodAni:removeAllChildrenWithCleanup(true)
  self.nodAni:stopAllActions()
  if idx == 1 and self.type == "RELEASES" then
    self:showGuideAni(self.nodAni)
  end
end
function prototype:showGuideAni(node)
  local bFirstExcute = Logic:Get("System"):GetSysVariableMisc("FirstExcute")
  if bFirstExcute then
    return
  end
  local function runAni()
    if self.ani then
      self.ani:RemoveAnimation()
      self.ani = nil
    end
    local x = 0
    local y = 0
    self.ani = Logic:Get("AniMgr"):NewCCB("UI/uixsyd02", node, ccp(x, y))
    if self.ani then
      self.ani:RunAni()
    end
  end
  local arr = CCArray:create()
  arr:addObject(CCCallFuncN:create(runAni))
  arr:addObject(CCDelayTime:create(1.5))
  node:runAction(CCRepeatForever:create(CCSequence:create(arr)))
end
function prototype:refreshTime()
  local taskPath = "images/Explore/fntMissionTime.png"
  local leftPath = "images/Explore/fntLeftTime.png"
  self.sprMin:setVisible(true)
  local path = self.type == "RELEASES" and taskPath or leftPath
  local spr = CCSprite:create(path)
  if spr then
    self.sprTaskTime:setDisplayFrame(spr:displayFrame())
  end
  if self.type == "RELEASES" then
    self.ttfTime:setString(self.data.exceTimes)
    return
  end
  self.sprMin:setVisible(false)
  local diffTime = Logic:Get("System"):DiffTime(self.data.endAt / 1000)
  self.nodComplete:setVisible(diffTime > 0)
  self.nodDraw:setVisible(diffTime <= 0)
  if diffTime > 0 then
    self.nodLeftTime:setVisible(true)
    local countDown = Logic:Get("System"):SecToDay(diffTime)
    countDown.hour = countDown.hour + countDown.day * 24
    local str = TwGetStr(102008, countDown.hour or 0, countDown.min or 0, countDown.sec or 0)
    self.ttfTime:setString(str)
    return
  end
  self.nodLeftTime:setVisible(false)
  self.ttfTime:setString("-")
end
function prototype:refreshRewards()
  local rec = KFDBGetRecord("TaskRewardConfig", self.data.reward)
  if table.empty(rec or {}) then
    return
  end
  local successShowTypes = json.decode(rec.successShowTypes or "[]")
  local successShowIds = json.decode(rec.successShowIds or "[]")
  local successAmounts = json.decode(rec.successAmounts or "[]")
  local ccbs = list.map(function(index)
    return self["ccbReward" .. index]
  end, table.indices(list.rep({0}, 3)))
  for i, ccb in ipairs(ccbs) do
    if successShowTypes[i] then
      local data = {}
      data.showType = successShowTypes[i]
      data.showId = successShowIds[i]
      data.amount = successAmounts[i]
      ccb:setVisible(true)
      ccb:ReFreshByGift(data)
    else
      ccb:setVisible(false)
    end
  end
end
