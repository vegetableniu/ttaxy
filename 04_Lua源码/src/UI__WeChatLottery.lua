module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  self.ttfReward:setStyle(kCCLabelTTFStyleOutline)
  self.ttfList:setStyle(kCCLabelTTFStyleOutline)
  self.ttfList:setString(TwGetStr(110713))
  self.ttfGet:setString(TwGetStr(110710))
  Logic:Get("WeChat"):ResetTimes()
  Logic:Get("WeChat"):PostRouletteLeft()
  self:setCards()
  Logic:Get("WeChat"):On(Logic.WeChat.EVT.ROULETTE_LEFT, self:Event("OnRouletteLeft"))
  Logic:Get("WeChat"):On(Logic.WeChat.EVT.ROULETTE, self:Event("OnRoulette"))
end
function prototype:onExit()
  Logic:Get("WeChat"):FCode()
  Logic:Get("WeChat"):OpenWeChat()
end
function prototype:onBtnBg()
end
function prototype:onBtnClose()
  SceneHelper:popScene()
end
function prototype:onBtnStart()
  local leftTimes = Logic:Get("WeChat"):GetLeftDrawTime()
  if leftTimes <= 0 then
    Prompt:Fail(110711)
    return
  end
  Logic:Get("WeChat"):PostRoulette()
end
function prototype:setCards()
  local operatorId = tonumber(Logic:Get("System"):GetOperatorId())
  local pos = {}
  local function canShow(rec)
    if table.empty(rec or {}) then
      return false
    end
    if operatorId ~= rec.operator then
      return false
    end
    if rec.showType ~= "REAL_GOODS" then
      return true
    end
    if Logic:Get("WeChat"):IsFcodeActivityOver() then
      return false
    end
    return true
  end
  for i = 1, KFDBGetRecordAmt("WechatRoulette") do
    local rec = KFDBGetRecordByIdx("WechatRoulette", i)
    if canShow(rec) then
      local str = string.format("ccbCard%d", rec.position)
      if self[str] and not pos[rec.position] then
        self[str]:ReFreshByGift(rec)
        pos[rec.position] = rec.id
      end
    end
  end
end
function prototype:OnRoulette()
  local pos = Logic:Get("WeChat"):GetDrawPos()
  if pos > 0 then
    self:OnRouletteLeft()
    self:turnToTarget(pos)
  end
end
function prototype:turnToTarget(target)
  self.range = 0.06
  self.time = 1
  self.maxTime = 42 - target
  self.nodAni:setRotation(-22.5)
  local item = 8
  for i = 1, item do
    local str = string.format("ccbCard%d", i)
    if self[str] then
      self[str]:setRotation((2 * i - 1) * 22.5)
    end
  end
  self.btnClose:setEnabled(false)
  self:rotate()
  self.btnStart:setEnabled(false)
end
function prototype:rotate()
  self.range = self.range + math.floor(self.time / 8) * 0.008
  local array = CCArray:create()
  array:addObject(CCRotateBy:create(self.range / math.pow(1, self.time), 45))
  array:addObject(CCCallFuncN:create(function()
    self.time = self.time + 1
    if self.time < self.maxTime then
      self:rotate()
    else
      self:rotateEnd()
    end
  end))
  self.nodAni:runAction(CCSequence:create(array))
end
function prototype:rotateEnd()
  self.btnClose:setEnabled(true)
  self.btnStart:setEnabled(true)
  Logic:Get("WeChat"):PromptRewards()
end
function prototype:OnRouletteLeft()
  local leftTimes = Logic:Get("WeChat"):GetLeftDrawTime()
  self:showWeChatTip(leftTimes > 0)
  self.ttfReward:setString(TwGetStr(100004, leftTimes))
  self:ShowRecord()
end
function prototype:ShowRecord()
  local record = Logic:Get("WeChat"):GetRecord()
  for i, v in ipairs(record or {}) do
    local rec = KFDBGetRecord("WechatRoulette", v.configId)
    if rec then
      local param = string.format("nodReward%d", i)
      if self[param] then
        self[param]:setString(TwGetStr(110714, v.userName or "", rec.name))
      end
    end
  end
end
function prototype:showWeChatTip(bool)
  if self.ani then
    self.ani:RemoveAnimation()
    self.ani = nil
  end
  local spr = self.rootNode:getChildByTag(10)
  if spr then
    self.rootNode:removeChildByTag(10, true)
  end
  if not bool then
    return
  end
  local x = self.nodTable:getPositionX() + 50
  local y = self.nodTable:getPositionY() + 50
  self.ani = Logic:Get("AniMgr"):RunCCBAni("UI/uinew", self.rootNode, ccp(x, y), 1)
  local spr = CCSprite:create("images/public/tip.png")
  self.rootNode:addChild(spr, 0, 10)
  spr:setAnchorPoint(CCPoint(0.5, 0.5))
  spr:setPosition(ccp(x, y))
end
