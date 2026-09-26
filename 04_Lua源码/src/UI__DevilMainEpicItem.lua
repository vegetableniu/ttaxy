module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local BTN_GROUP = {
  NORMAL = "images/Devil/btnReinNormal.png",
  SELECT = "images/Devil/btnReinSelect.png",
  LOCK = "images/Devil/btnReinLock.png"
}
local lock = "images/Main/skillLock.png"
function prototype:initialize(...)
  super.initialize(self, ...)
  self.idTab = {}
  self.leftTime = nil
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self:setStyle()
  self:formatLabel()
  local rank = Logic:Get("Devil"):getRank()
  if rank and rank > 0 then
    self.nodeRank:create(0, "YELLOW_E_NUM")
    self.nodeRank:setAlign("LEFT", "CENTER")
    self.nodeRank:setValue(rank)
  else
    self.ttfRank:setString("-")
  end
  local integral = Logic:Get("Devil"):getFeat()
  if integral and integral >= 0 then
    self.nodeIntegral:create(0, "YELLOW_E_NUM")
    self.nodeIntegral:setAlign("LEFT", "CENTER")
    self.nodeIntegral:setValue(integral)
  end
  Logic:Get("Devil"):On(Logic.Devil.EVT.UPDATE_ACT_TIME, self:Event("onUpdateTime"))
  Logic:Get("Devil"):On(Logic.Devil.EVT.PUSH_DAMOG_LIST, self:Event("onPushDamogList"))
  Logic:Get("Devil"):initTimer()
  self.groupStatus = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.FIRST_HERO_GROUP)
  self:onLockHeroGroup(self.groupStatus)
  if Logic:Get("System"):IsOperator("ilovewebgame") then
    self.nodStrategy:setVisible(false)
  end
  local bPushDemog = Logic:Get("Devil"):GetPushDemog()
  if bPushDemog then
    local x = self.btnDevil:getPositionX() + 50
    local y = self.btnDevil:getPositionY() + 50
    if self.ani == nil then
      self.ani = Logic:Get("AniMgr"):RunCCBAni("UI/uinew", self, ccp(x, y))
    end
    local spr = self.rootNode:getChildByTag(10)
    if spr == nil then
      local ccSprite = CCSprite:create("images/public/tip.png")
      self.rootNode:addChild(ccSprite, 0, 10)
      ccSprite:setAnchorPoint(CCPoint(0.5, 0.5))
      ccSprite:setPosition(ccp(x, y))
    end
  else
    if self.ani ~= nil then
      self.ani:RemoveAnimation()
      self.ani = nil
    end
    local spr = self.rootNode:getChildByTag(10)
    if spr ~= nil then
      self.rootNode:removeChildByTag(10, true)
    end
  end
end
function prototype:onExit()
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:setStyle()
  self.ttfDamage:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLeftTime:setStyle(kCCLabelTTFStyleOutline)
  self.ttfBack:setStyle(kCCLabelTTFStyleOutline)
  self.ttfActName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfRank:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:formatLabel()
  self.ttfDamage:setString(TwGetStr(105504))
  local activeId = Logic:Get("Devil"):getActiveId() or ""
  local rec = KFDBGetRecord("DemogActiveConfig", activeId)
  if rec then
    self.ttfBack:setString(rec.desc or "")
  end
end
function prototype:createImg(giftInfo)
  if giftInfo == nil then
    return
  end
  local spr = Logic:Get("Gift"):createImg(giftInfo)
  if spr ~= nil then
    self.sprRewardBg:setDisplayFrame(spr:displayFrame())
    local strGoods = Logic:Get("Gift"):createGoodsImg(giftInfo)
    if strGoods ~= nil then
      local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(strGoods)
      self.sprRewardIcon:setTexture(texture)
      self.sprRewardIcon:setTextureRect(textureRect)
    end
  end
end
function prototype:onBtnRewardClicked(sender, event)
  SceneHelper:runWithScene("DevilGift", self.rootNode)
end
function prototype:onBtnReinClicked(sender, event)
  if self.groupStatus then
    if event == CCControlEventTouchDown then
      local level, copyName = Logic:Get("Lock"):GetOpenLevelAndBattle(Logic.Lock.LOCK_ID.FIRST_HERO_GROUP)
      self:showLockTip(level, copyName)
    end
    self:closeLockTip(event)
    return
  end
  if event == CCControlEventTouchUpInside then
    SceneHelper:pushScene("DevilGroup", self.rootNode)
  end
end
function prototype:onBtnLotteryClicked(sender, event)
  local activeId = Logic:Get("Devil"):getActiveId() or ""
  local rec = KFDBGetRecord("DemogActiveConfig", activeId)
  if rec == nil then
    Prompt:Fail(TwGetStr(105325))
    return
  end
  Logic:Get("Mall"):initItemData()
  local data = Logic:Get("Mall"):GetTabData()
  local drawData
  for _, v in pairs(data) do
    if v.type == rec.lottery then
      drawData = v
      break
    end
  end
  if drawData then
    Logic:Get("Lottery"):SetDrawData(drawData)
    Logic:Get("Lottery"):SetFrom(Logic.Lottery.FROM_DEVIL)
    SceneHelper:runWithScene("LotteryGold", self.rootNode)
  else
    Prompt:Fail(TwGetStr(105325))
  end
end
function prototype:onBtnDevilClicked(sender, event)
  Logic:Get("Devil"):clearPushDemog()
  MsgDemog:Post("DEMOG_LIST")
end
function prototype:onBtnRankClicked(sender, event)
  Logic:Get("Devil"):setRankType(Logic.Devil.RANK_TYPE.DEVILMAIN)
  SceneHelper:runWithScene("DevilPrimordialExchange", self.rootNode)
end
function prototype:onBtnFeatClicked(sender, event)
  Logic:Get("Devil"):FireEvent(Logic.Devil.EVT.PAGE_CHANGE, 2)
end
function prototype:onBtnStragety(sender, event)
  SceneHelper:pushScene("Strategy", self.rootNode)
end
function prototype:onUpdateTime(leftTime)
  if leftTime == nil then
    return
  end
  local str = ""
  if leftTime.day and leftTime.min > 0 then
    str = TwGetStr(100046, leftTime.min) .. str
  end
  if leftTime.hour and 0 < leftTime.hour then
    str = TwGetStr(100045, leftTime.hour) .. str
  else
    str = str .. TwGetStr(105506, leftTime.sec or 0)
  end
  if leftTime.day and leftTime.day > 0 then
    str = TwGetStr(105502, leftTime.day) .. str
  end
  str = TwGetStr(105505) .. str
  self.ttfLeftTime:setString(str)
end
function prototype:onPushDamogList()
  SceneHelper:runWithScene("DevilList", self.rootNode)
end
function prototype:onLockHeroGroup(isLock)
  local sprNormal, sprSelect
  if isLock then
    sprNormal = CCScale9Sprite:create(BTN_GROUP.LOCK)
    sprSelect = CCScale9Sprite:create(BTN_GROUP.LOCK)
    self:addLock(self.btnRein, 98, lock)
  else
    sprNormal = CCScale9Sprite:create(BTN_GROUP.NORMAL)
    sprSelect = CCScale9Sprite:create(BTN_GROUP.SELECT)
    self:removeLock(self.btnRein, 98, lock)
  end
  if sprNormal and sprSelect then
    self.btnRein:setBackgroundSpriteForState(sprNormal, CCControlStateNormal)
    self.btnRein:setBackgroundSpriteForState(sprSelect, CCControlStateHighlighted)
  end
end
function prototype:showLockTip(level, copyName)
  if nil ~= copyName and "" ~= copyName then
    local str = TwGetStr(105403, level) .. "\n" .. TwGetStr(105401, copyName)
    Prompt:PopTip(str)
  else
    Prompt:PopTip(TwGetStr(105402, level))
  end
end
function prototype:closeLockTip(event)
  if event == CCControlEventTouchUpOutside or event == CCControlEventTouchUpInside or event == CCControlEventTouchCancel then
    Logic:Get("SureConfirm"):FireEvent(Logic.SureConfirm.EVT.CLOSE_POPTIP)
  end
end
function prototype:addLock(btnNode, tag, sprPath)
  if btnNode and tag then
    local lockChild = btnNode:getChildByTag(tag)
    if lockChild ~= nil then
      return
    end
    local sprLock = sprPath and CCSprite:create(sprPath) or CCSprite:create(LOCK_PATH)
    if nil == sprLock then
      return
    end
    sprLock:setAnchorPoint(CCPoint(0.5, 0.5))
    local x = btnNode:getContentSize().width / 2
    local y = btnNode:getContentSize().height / 2
    sprLock:setPosition(ccp(x, y))
    btnNode:addChild(sprLock, 10, tag)
  end
end
function prototype:removeLock(btnNode, tag)
  if btnNode and tag then
    local lockChild = btnNode:getChildByTag(tag)
    if lockChild ~= nil then
      btnNode:removeChildByTag(tag, true)
    end
  end
end
