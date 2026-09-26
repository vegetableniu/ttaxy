module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
BTN_PROTECT = {
  NORMAL = "images/public/btn_long_normal.png",
  SELECT = "images/public/btn_long_light.png",
  DISABLE = "images/public/btn_long_disable.png"
}
function prototype:onEnter()
  Logic:Get("Hero"):On(Logic.Hero.EVT.HERO_LOCK, self:Event("RefreshCard"))
  self.HeroInfo = Logic:Get("HeroCardInfo"):GetHeroInfo()
  self.btnCloseTwo:setVisible(self.HeroInfo.eType == Logic.HeroCardInfo.eType.CLOSE)
  self.btnClose:setVisible(self.HeroInfo.eType == Logic.HeroCardInfo.eType.PROTECT)
  self.btnProTect:setVisible(self.HeroInfo.eType == Logic.HeroCardInfo.eType.PROTECT)
  self.sprFrontPro:setVisible(self.HeroInfo.eType == Logic.HeroCardInfo.eType.PROTECT)
  self.sprClose:setVisible(self.HeroInfo.eType == Logic.HeroCardInfo.eType.PROTECT)
  self.sprClose1:setVisible(self.HeroInfo.eType == Logic.HeroCardInfo.eType.CLOSE)
  self:setBtnProTitle()
  self.bShowFunc = Logic:Get("Main").showFunc
  if Logic:Get("Main").showFunc then
    Logic:Get("Main"):SetFuncVisible(false)
  end
  if self.HeroInfo.eType == Logic.HeroCardInfo.eType.PROTECT then
    self.protStatus = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.CARD_PROTECT)
    self:onLockProtect(self.protStatus)
  end
  self.ccbInfo:setVisible(false)
  self.heroTail:setVisible(false)
  self:initTitle()
  self:initScroll()
end
function prototype:initTitle()
  local fdb_baseHero = Logic:Get("HeroCardInfo"):kdbBaseHero(self.HeroInfo.baseId)
  if fdb_baseHero then
    self.ttfName:setStyle(kCCLabelTTFStyleOutline)
    self.ttfName:setString(fdb_baseHero.name or "")
    local color = Logic:Get("Hero"):getColorByBaseId(self.HeroInfo.baseId)
    self.ttfName:setColor(color)
  end
end
function prototype:initScroll()
  local scroll = CCScrollViewEx:create(CCSizeMake(640, 750))
  scroll:setDirection(kCCScrollViewDirectionVertical)
  scroll:setClippingToBounds(true)
  scroll:setPosition(ccp(0, 105))
  self.container = Tw.Controller:load("HeroCardInfoTail", self.rootNode)
  self.container:ReFrashHeroInfo(self.HeroInfo)
  local height = self.container.layer:getContentSize().height
  scroll:setContainer(self.container)
  scroll:setContentOffset(ccp(0, 750 - height))
  scroll:updateInset()
  self.rootNode:addChild(scroll)
end
function prototype:onExit()
  Logic:Get("HeroCardInfo"):SetPromptHeroInfo(false)
  if self.bShowFunc then
    Logic:Get("Main"):SetFuncVisible(true)
  end
end
function prototype:onBtnClose()
  local bool = Logic:Get("HeroCardInfo"):GetPromptHeroInfo()
  if bool then
    SceneHelper:removePrompt(self.rootNode)
  else
    SceneHelper:popScene()
  end
end
function prototype:onBtnCloseTwo()
  local bool = Logic:Get("HeroCardInfo"):GetPromptHeroInfo()
  if bool then
    SceneHelper:removePrompt(self.rootNode)
  else
    SceneHelper:popScene()
  end
end
function prototype:onBtnNext(sender, event)
end
function prototype:onBtnProTect(sender, event)
  if self.protStatus then
    if event == CCControlEventTouchDown then
      local level, copyName = Logic:Get("Lock"):GetOpenLevelAndBattle(Logic.Lock.LOCK_ID.CARD_PROTECT)
      self:showLockTip(level, copyName)
    end
    self:closeLockTip(event)
    return
  end
  if event == CCControlEventTouchUpInside then
    if self.HeroInfo.locked then
      Logic:Get("Hero"):PostLock(false, self.HeroInfo.id)
    else
      Logic:Get("Hero"):PostLock(true, self.HeroInfo.id)
    end
  end
end
function prototype:RefreshCard()
  self:setBtnProTitle()
end
function prototype:setBtnProTitle()
  local str = ""
  if self.HeroInfo.locked then
    str = "images/font/quxiao.png"
  else
    str = "images/font/baohu.png"
  end
  local ccspr = CCSprite:create(str)
  self.sprFrontPro:setDisplayFrame(ccspr:displayFrame())
end
function prototype:onLockProtect(isLock)
  local sprNormal, sprSelect
  if isLock then
    sprNormal = CCScale9Sprite:create(BTN_PROTECT.DISABLE)
    sprSelect = CCScale9Sprite:create(BTN_PROTECT.DISABLE)
  else
    sprNormal = CCScale9Sprite:create(BTN_PROTECT.NORMAL)
    sprSelect = CCScale9Sprite:create(BTN_PROTECT.SELECT)
  end
  if sprNormal and sprSelect then
    self.btnProTect:setBackgroundSpriteForState(sprNormal, CCControlStateNormal)
    self.btnProTect:setBackgroundSpriteForState(sprSelect, CCControlStateHighlighted)
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
