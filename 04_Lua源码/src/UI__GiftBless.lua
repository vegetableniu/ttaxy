module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  self.ttfCost:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLeftTimes:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCd:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCharge:setStyle(kCCLabelTTFStyleOutline)
  self:setLabelStyle()
  self:setMaxJade()
  self:numAniCreate()
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.ttfTitle:setString(giftInfo.name)
  self.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  Logic:Get("Bless"):PostInfo()
  Logic:Get("Bless"):On(Logic.Bless.EVT.INFO, self:Event("onInfo"))
  Logic:Get("Bless"):On(Logic.Bless.EVT.LOTTERY, self:Event("onLottery"))
  Logic:Get("Bless"):On(Logic.Bless.EVT.RESET, self:Event("onResetNode"))
  Singleton(Timer):Repeat(1000, self:Event("countDown"))
  self:countDown()
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz", self.sprRight, ccp(35, 19), 0, nil, nil)
  if self.ani then
    self.ani:RunAni()
  end
end
function prototype:setLabelStyle()
  for i = 1, 5 do
    local ttfJade = "ttfLock" .. i
    local ttfPos = "ttfLockPos" .. i
    local ttfTimes = "ttfLockTimes" .. i
    if self[ttfJade] then
      self[ttfJade]:setStyle(kCCLabelTTFStyleOutline)
    end
    if self[ttfPos] then
      self[ttfPos]:setStyle(kCCLabelTTFStyleOutline)
    end
    if self[ttfTimes] then
      self[ttfTimes]:setStyle(kCCLabelTTFStyleOutline)
    end
  end
end
function prototype:setMaxJade()
  local jade = Logic:Get("Egg"):GetCongifValueByKey("BLESSING:MAX_JADE")
  self.nodBestJade:create(0, "PINK_NUM")
  self.nodBestJade:setAlign("CENTER", "CENTER")
  self.nodBestJade:setValue(jade)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnCharge(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
function prototype:onBtnWorship(sender, event)
  local leftTimes = Logic:Get("Bless"):GetLeftTimes()
  if leftTimes <= 0 then
    Prompt:Fail(110851)
    return
  end
  local cost = Logic:Get("Bless"):GetCost()
  Prompt:Confirm(self, "", TwGetStr(110855, cost), self.post, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:post()
  local jade = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  local cost = Logic:Get("Bless"):GetCost()
  if jade < cost then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Logic:Get("Bless"):PostLottery()
end
function prototype:onInfo()
  local cost = Logic:Get("Bless"):GetCost()
  self.ttfCost:setString(cost)
  local leftTimes = Logic:Get("Bless"):GetLeftTimes()
  self.ttfLeftTimes:setString(TwGetStr(100004, leftTimes))
  self:LockJade()
  self:LockReward()
  local charge = Logic:Get("Bless"):GetNeedCharge()
  if charge > 0 then
    self.sprCharge:setVisible(true)
    self.ttfCharge:setString(charge)
    self.btnWorship:setEnabled(false)
    return
  end
  self.sprCharge:setVisible(false)
  self.ttfCharge:setString("")
  self.btnWorship:setEnabled(true)
end
function prototype:LockJade()
  local scroll = tolua.cast(self.nodNumAni:getChildByTag(self.scrollTag), "CCScrollViewEx")
  if not scroll then
    return
  end
  local container = scroll:getContainer()
  for i = 1, 2 do
    local node = "nodLock" .. i
    local contNode = "nodNum" .. i + 2
    if self[node] then
      local bLock, times = Logic:Get("Bless"):IsLockJade(i)
      self[node]:setVisible(bLock)
      local ttf = "ttfLock" .. i
      self[ttf]:setString(times)
      container:setNodeVisible(contNode, not bLock)
    end
  end
end
function prototype:LockReward()
  local scroll = tolua.cast(self.nodRewardAni:getChildByTag(self.rewardTag), "CCScrollViewEx")
  if not scroll then
    return
  end
  local container = scroll:getContainer()
  local list = Logic:Get("Bless"):GetRewardList()
  for i = 1, 5 do
    local node = "nodLockReward" .. i
    local contNode = "nodReward" .. i
    local ccb = "ccbReward1" .. i
    local bLock, times = Logic:Get("Bless"):IsLockReward(i)
    if self[node] then
      self[node]:setVisible(bLock)
      local ttfPos = "ttfLockPos" .. i
      local ttfTimes = "ttfLockTimes" .. i
      self[ttfTimes]:setString(times)
      self[ttfPos]:setString(i)
      container[contNode]:setVisible(not bLock)
    end
    if list[i] and container[ccb] then
      container[ccb]:ReFreshByGift(list[i])
    end
  end
end
function prototype:onLottery()
  self:runAni()
  self:runRewardAni()
end
function prototype:countDown()
  local info = Logic:Get("Gift"):GetActivityGift()
  local diffTime = Logic:Get("System"):DiffTime(info.endTime / 1000)
  if diffTime > 0 then
    local time = Logic:Get("System"):SecToDay(diffTime) or {}
    self.ttfCd:setString(TwGetStr(110856, time.day or 0, time.hour or 0, time.min or 0, time.sec or 0))
  end
end
function prototype:numAniCreate()
  local container = Tw.Controller:load("GiftBlessItem", self.rootNode)
  local size = CCSizeMake(571, 104)
  self.scrollTag = self:scrollViewCreate(container, size, self.nodNumAni)
  container = Tw.Controller:load("GiftBlessRewardItem", self.rootNode)
  size = CCSizeMake(571, 105)
  self.rewardTag = self:scrollViewCreate(container, size, self.nodRewardAni)
end
function prototype:scrollViewCreate(container, CCSize, addNode)
  local scroll = CCScrollViewEx:create(CCSize)
  scroll:setDirection(kCCScrollViewDirectionHorizontal)
  scroll:setClippingToBounds(true)
  scroll:setTouchEnabled(false)
  scroll:setContainer(container)
  scroll:updateInset()
  local tag = scroll:getTag()
  addNode:addChild(scroll)
  return tag
end
function prototype:runAni()
  local scroll = tolua.cast(self.nodNumAni:getChildByTag(self.scrollTag), "CCScrollViewEx")
  if not scroll then
    return
  end
  local container = scroll:getContainer()
  local jade = Logic:Get("Bless"):GetJade()
  for i = 1, 4 do
    local node = "nodNum" .. i
    local target = jade % 10
    if 1 > i - 2 or not Logic:Get("Bless"):IsLockJade(i - 2) then
      container:setMaxTimes(node, i + 3)
      container:runAni(node, 0, target)
    end
    jade = math.floor(jade / 10)
  end
end
function prototype:runRewardAni()
  local scroll = tolua.cast(self.nodRewardAni:getChildByTag(self.rewardTag), "CCScrollViewEx")
  if not scroll then
    return
  end
  local container = scroll:getContainer()
  container:setFakeReward()
  local rewards = Logic:Get("Bless"):GetRewards()
  for i = 1, 5 do
    local node = "nodReward" .. i
    if not Logic:Get("Bless"):IsLockReward(i) then
      local ccb = "ccbReward5" .. i
      if rewards[i] then
        container[ccb]:ReFreshByReward(rewards[i])
      end
      container:setMaxTimes(node, i + 3)
      container:runAni(node, 0, 4)
    end
  end
end
function prototype:onResetNode()
  self:onInfo()
  self:resetContainer(self.nodNumAni, self.scrollTag)
  self:resetContainer(self.nodRewardAni, self.rewardTag)
end
function prototype:resetContainer(node, tag)
  local scroll = tolua.cast(node:getChildByTag(tag), "CCScrollViewEx")
  if not scroll then
    return
  end
  local container = scroll:getContainer()
  if container then
    container:resetPos()
  end
end
