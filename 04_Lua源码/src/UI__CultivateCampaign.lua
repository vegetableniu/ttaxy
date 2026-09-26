module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter(...)
  super.onEnter(self)
  Logic:Get("Cultivate"):SetCheckedBattleId(nil)
  Logic:Get("BattleShow"):On(Logic.BattleShow.EVT.INEND, self:Event("OnBattleInEnd"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.SET_BTLSCROLL, self:Event("OnSetScroll"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.ON_LOAD_INFO, self:Event("OnLoadInfo"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.SWALLOW_ELIXIR, self:Event("OnSwallowElixir"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.COM_ELIXIR, self:Event("OnComElixir"))
  Logic:Get("BattleShow"):On(Logic.BattleShow.EVT.END, self:Event("OnEndBattle"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.RE_CULTIVATE_SUCCESS, self:Event("OnRecultivate"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.ON_HERO_CROSSING, self:Event("OnHeroCrossing"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.STUFF_CHANGE, self:Event("OnStuffChange"))
  self:createScrollView()
  self:refreshView()
  self:AdaptByCurCampaign()
  self:changeShopBtnBg()
  Logic:Get("Cultivate"):PostLoadInfo()
end
function prototype:createScrollView(...)
  local scroll = CCScrollViewEx:create(CCSizeMake(580, 734))
  scroll:setPosition(ccp(0, 0))
  scroll:setClippingToBounds(true)
  scroll:setTouchEnabled(false)
  local container = Tw.Controller:load("CultivateCampaignView", self.rootNode)
  scroll:setContainer(container)
  scroll:setDirection(kCCScrollViewDirectionVertical)
  scroll:updateInset()
  self.lstView:addChild(scroll)
  self.scroll = scroll
end
function prototype:refreshView()
  if not self.scroll then
    return
  end
  Logic:Get("Elite"):initCampaignList("PILL")
  local data = Logic:Get("Elite"):GetAllCampaign("PILL")
  self.data = data
  local container = self.scroll:getContainer()
  container:refresh(data)
end
function prototype:refreshNewTip(...)
  local bNew = Logic:Get("Cultivate"):showTip()
  self.sprNew:setVisible(bNew)
  if self.aniNew then
    self.aniNew:RemoveAnimation()
    self.aniNew = nil
  end
  if bNew then
    self.aniNew = Logic:Get("AniMgr"):NewCCB("UI/uinew", self.sprNew, ccp(27, 27), 0, nil, nil)
    if self.aniNew then
      self.aniNew:RunAni()
    end
  end
end
function prototype:AdaptByCurCampaign(...)
  if not self.index then
    return
  end
  local container = self.scroll:getContainer()
  local pos = container:getNodePos(self.index)
  if not pos then
    return
  end
  local midY = 367
  local oldOffset = self.scroll:getContentOffset()
  local deltaY = 367 - (pos.y + oldOffset.y)
  local offsetY = oldOffset.y + deltaY
  local minOffset = self.scroll:minContainerOffset()
  local maxOffset = self.scroll:maxContainerOffset()
  local offsetY = math.min(maxOffset.y, math.max(offsetY, minOffset.y))
  self.scroll:setContentOffset(ccp(oldOffset.x, offsetY))
end
function prototype:onExit(...)
end
function prototype:changeShopBtnBg()
  local bLockShop = Logic:Get("CultivateShop"):IsLockShop()
  local normalPath = "images/public/btnCommonNormal.png"
  local disabledPath = "images/public/btnCommonDisable.png"
  local actPath = bLockShop and disabledPath or normalPath
  local spr = CCSprite:create(actPath)
  if spr then
    self.sprShopBtn:setDisplayFrame(spr:displayFrame())
  end
  self:showGuideAni(self.sprFnt)
end
function prototype:showGuideAni(node)
  local bFirstOpen = Logic:Get("System"):GetSysVariableMisc("FirstOpenShop")
  local bLockShop = Logic:Get("CultivateShop"):IsLockShop()
  if bFirstOpen or bLockShop then
    return
  end
  Logic:Get("System"):SetSysVariableMisc("FirstOpenShop", 1)
  local function runAni()
    if self.ani then
      self.ani:RemoveAnimation()
      self.ani = nil
    end
    local x = node:getPositionX() + node:getContentSize().width / 2
    local y = node:getPositionY() + node:getContentSize().height / 2
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
function prototype:onBtnShop(sender, event)
  local bLockShop = Logic:Get("CultivateShop"):IsLockShop()
  if bLockShop then
    local rec = KFDBGetRecordByIdx("ShopSetting", 1) or {}
    local _, battle = Logic:Get("Lock"):GetOpenLevelAndEliteBattle(rec.lock)
    local tips = TwGetStr(114115, battle) .. TwGetStr(114116)
    Prompt:Msg(tips)
    return
  end
  SceneHelper:pushScene("CultivateShop", self.rootNode)
end
function prototype:onBtnTrain(...)
  Logic:Get("Cultivate"):setFromBattle(true)
  SceneHelper:pushScene("CultivateSelectHero")
end
function prototype:onBtnPack(...)
  SceneHelper:pushScene("CultivatePillPack")
end
function prototype:onBtnReturn(...)
  Logic:Get("Main"):GotoHomePage()
end
function prototype:OnBattleInEnd(...)
  self.rootNode:setVisible(false)
end
function prototype:OnSetScroll(enable)
  if self.scroll then
    self.scroll:setTouchEnabled(enable)
  end
end
function prototype:OnLoadInfo(...)
  self:refreshNewTip()
end
function prototype:OnSwallowElixir(...)
  self:refreshNewTip()
end
function prototype:OnComElixir(...)
  self:refreshNewTip()
end
function prototype:OnEndBattle(...)
  self:refreshNewTip()
  self:refreshView()
  self:changeShopBtnBg()
end
function prototype:OnRecultivate()
  self:refreshNewTip()
end
function prototype:OnHeroCrossing()
  self:refreshNewTip()
  self:refreshView()
end
function prototype:OnStuffChange()
  self:refreshNewTip()
end
