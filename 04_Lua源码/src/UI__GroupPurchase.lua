module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
prototype = Tw.Controller.prototype:extend()
local WIN_WIDTH, WIN_HEIGHT = 588, 220
function prototype:initialize()
  super.initialize(self)
end
function prototype:onEnter()
  super.onEnter(self)
  self.labTime:setStyle(kCCLabelTTFStyleOutline)
  self.labTip:setStyle(kCCLabelTTFStyleOutline)
  self.labTip:setString(TwGetStr(111048))
  self.labTip:setPosition(ccp(320, 455))
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.title_ttf:setColor(ccc3(255, 183, 18))
  self.title_ttf:setString(giftInfo.name)
  self.title_ttf:setStyle(kCCLabelTTFStyleOutline)
  Logic:Get("GroupPurchase"):On(Logic.GroupPurchase.EVT.GET_BUY_INFO_OK, self:Event("refreshData"))
  Logic:Get("GroupPurchase"):PostPlayerBuyInfo()
  self.groupInfos = Logic:Get("GroupPurchase"):getOpenGroupPurchasesInfo()
  self.curPageNo = 1
  self.maxPageNo = math.ceil(#self.groupInfos / 2)
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz", self.sprCharge, ccp(35, 19), 0, nil, nil)
  if self.ani then
    self.ani:RunAni()
  end
  for i = 1, #self.groupInfos do
    local str = string.format("subScene%d", i)
    self[str] = Tw.Controller:load("GroupPurchaseItem", self.rootNode)
    self[str]:setAnchorPoint(CCPointMake(0, 0))
  end
  local scroll = CCScrollViewEx:create(CCSizeMake(588, 535))
  scroll:setDirection(kCCScrollViewDirectionVertical)
  scroll:setTouchEnabled(false)
  scroll:setClippingToBounds(true)
  scroll:setPositionY(0)
  scroll:setPositionX(0)
  local container = CCSprite:create()
  local xPos, yPos = 0, 0
  local tag = 100
  for i = 1, #self.groupInfos do
    local n = i % 2
    yPos = n * 265
    xPos = math.floor((i - 1) / 2) * 588
    local subScene = string.format("subScene%d", i)
    self[subScene]:setPosition(CCPointMake(xPos, yPos))
    self[subScene]:refreshInfo(self.groupInfos[i])
    container:addChild(self[subScene], 0, tag)
    tag = tag - 1
    if i == 2 then
      break
    end
  end
  local conHeight = 530
  local conWidth = 588 * math.ceil(#self.groupInfos / 2)
  container:setContentSize(CCSizeMake(conWidth, conHeight))
  scroll:setContainer(container)
  scroll:updateInset()
  scroll:setContentOffset(CCPointMake(0, 530 - conHeight), false)
  self.scrollTag = scroll:getTag()
  self.scoNode:addChild(scroll)
end
function prototype:refreshData(id)
  self.groupInfos = Logic:Get("GroupPurchase"):getOpenGroupPurchasesInfo()
  self.curPageNo = self.curPageNo or 1
  self.maxPageNo = math.ceil(#self.groupInfos / 2)
  for i = 1, #self.groupInfos do
    local subScene = string.format("subScene%d", i)
    if id and self.groupInfos[i].id == id or id == nil then
      self[subScene]:refreshInfo(self.groupInfos[i])
    end
    if i == 2 then
      break
    end
  end
  if not self.eventTracer:Exist("refreshSurplusTime") then
    Singleton(Timer):Repeat(1000, self:Event("refreshSurplusTime"))
  end
end
function prototype:refreshSurplusTime()
  if not self.groupInfos or table.empty(self.groupInfos) then
    self.labTime:setString(TwGetStr(111042))
    return
  end
  local endTime = self.groupInfos[1].endTime
  local diffTime = Logic:Get("System"):DiffTime(endTime)
  local surplusTime = Logic:Get("System"):SecToDay(diffTime)
  if surplusTime and diffTime > 0 then
    local str = ""
    if surplusTime.day and 0 < surplusTime.day then
      str = TwGetStr(111043, surplusTime.day or 0) .. TwGetStr(111044, surplusTime.hour or 0)
    elseif surplusTime.hour and 0 < surplusTime.hour then
      str = TwGetStr(111044, surplusTime.hour or 0) .. TwGetStr(111045, surplusTime.min or 0)
    elseif surplusTime.min and 0 < surplusTime.min then
      str = TwGetStr(111045, surplusTime.min or 0) .. TwGetStr(111046, surplusTime.sec or 0)
    else
      str = TwGetStr(111046, surplusTime.sec or 0)
    end
    str = str .. TwGetStr(111047)
    self.labTime:setString(str)
  else
    self.labTime:setString(TwGetStr(111042))
  end
end
function prototype:onReturnBtnClicked(sender, event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onChargeBtnClicked(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
