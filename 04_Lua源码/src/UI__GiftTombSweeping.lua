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
  self.ttfCost:setString(TwGetStr(110754))
  self.ttfCostCnt:setStyle(kCCLabelTTFStyleOutline)
  self.ttfDesr:setStyle(kCCLabelTTFStyleOutline)
  self.ttfDesr:setString(TwGetStr(110752))
  self.ttfReward:setStyle(kCCLabelTTFStyleOutline)
  self.ttfReward:setString(TwGetStr(110751))
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTitle:setColor(ccc3(255, 183, 18))
  self.ttfTitle:setString(giftInfo.name)
  Logic:Get("QingMing"):PostGetJibaiPage()
  Logic:Get("QingMing"):On(Logic.QingMing.EVT.GET_JIBAI_PAGE, self:Event("onGetJibaiPage"))
  Logic:Get("QingMing"):On(Logic.QingMing.EVT.JIBAI, self:Event("onBaiJi"))
  Logic:Get("QingMing"):On(Logic.QingMing.EVT.PROMPT_END, self:Event("onPromptEnd"))
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnReward(sender, event)
  local data = Logic:Get("Gift"):GetActivityByType("QINGMING_RANK")
  Logic:Get("Gift"):SetActivityGift(data[1])
  SceneHelper:runWithScene("GiftCommonConsume", self.rootNode)
end
function prototype:onBtnWorship(sender, event)
  local sacrCnt = Logic:Get("QingMing"):GetJiPing()
  local cost = Logic:Get("QingMing"):GetNextCost()
  if sacrCnt < cost then
    Prompt:Fail(110758)
    return
  end
  Logic:Get("QingMing"):PostJiBai()
end
function prototype:onGetJibaiPage()
  local sacrCnt = Logic:Get("QingMing"):GetJiPing()
  self.ttfCostCnt:setString(sacrCnt)
  local cost = Logic:Get("QingMing"):GetNextCost()
  self.nodSacrCnt:setString(TwGetStr(110756, cost))
  local list = Logic:Get("QingMing"):GetRewardList()
  for i, v in ipairs(list) do
    local param = string.format("ccbCard%d", i)
    if self[param] then
      self[param]:ReFreshByGift(v)
    end
  end
end
function prototype:onBaiJi()
  self:baijiMoive()
end
function prototype:baijiMoive()
  local censerPath = "images/TombSweeping/censer.png"
  local function censerDisplayFrame(path)
    local sprCenser = CCSprite:create(path)
    if sprCenser then
      self.sprCenser:setDisplayFrame(sprCenser:displayFrame())
    end
  end
  self.btnWorship:setEnabled(false)
  censerDisplayFrame(censerPath)
  local path = "images/TombSweeping/hand.png"
  local spr = CCSprite:create(path)
  if spr then
    spr:setPosition(ccp(320, 440))
    self.rootNode:addChild(spr, 0, 2)
    local time = 0.3
    local array = CCArray:create()
    array:addObject(CCMoveTo:create(time, ccp(320, 460)))
    array:addObject(CCMoveTo:create(time, ccp(320, 420)))
    array:addObject(CCMoveTo:create(time, ccp(320, 500)))
    array:addObject(CCCallFuncN:create(function()
      self.rootNode:removeChildByTag(2, true)
      local censerPath = "images/TombSweeping/Incense.png"
      censerDisplayFrame(censerPath)
      Singleton(Timer):After(300, self:Event("ShowRewardTip"))
    end))
    spr:runAction(CCSequence:create(array))
  end
end
function prototype:ShowRewardTip()
  Logic:Get("QingMing"):ShowRewardTip()
  self.btnWorship:setEnabled(true)
end
function prototype:onPromptEnd()
  self:onGetJibaiPage()
  local list = Logic:Get("QingMing"):GetRewardList()
  for i, v in ipairs(list) do
    local param = string.format("ccbCard%d", i)
    local ani = string.format("ani%d", i)
    if self[param] then
      self[ani] = Logic:Get("AniMgr"):NewCCB("UI/supercardS", self, ccp(320 + self[param]:getPosition(), 360), 0)
      local sprBg = Logic:Get("Gift"):createImg(v)
      local sprIcon = Logic:Get("Gift"):createGoodsImg(v)
      if sprBg then
        self[ani]:GetChild("imgBg"):setDisplayFrame(sprBg:displayFrame())
      end
      if sprIcon then
        self[ani]:GetChild("imgHero"):setDisplayFrame(sprIcon:displayFrame())
      end
    end
  end
  Singleton(Timer):After(1000, self:Event("removeAni"))
end
function prototype:removeAni()
  local item = 4
  for i = 1, item do
    local ani = string.format("ani%d", i)
    if self[ani] then
      self[ani]:RemoveAnimation()
      self[ani] = nil
    end
  end
end
