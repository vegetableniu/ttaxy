module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local MAX_HERO = 5
local HERO_LOCK_PATH = "images/Main/heroLock.png"
local HERO_BG_PATH = "images/public/herobg.png"
local HERO_ICON_PATH = "images/public/clarity05.png"
function prototype:initialize(...)
  super.initialize(self, ...)
  self.data = nil
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  local path = "images/TeamSwitch/bg_s.png"
  local spr = CCSprite:create(path)
  if spr then
    self.sprBg:setSpriteFrame(spr:displayFrame())
  end
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:RefreshHeroInfo(data, owner)
  if data == nil then
    return
  end
  self.data = data
  self.owner = owner
  self:refreshTitle()
  self:refreshSwitchBtn()
  self:removeBtnLock()
  local sprBg = CCSprite:create(HERO_BG_PATH)
  local sprIcon = CCSprite:create(HERO_ICON_PATH)
  for i = 1, MAX_HERO do
    local strHeroBg = string.format("sprHeroBg%d", i)
    local strIcon = string.format("sprHeroIcon%d", i)
    local strSprLv = string.format("sprLv%d", i)
    local strNodLv = string.format("nodLv%d", i)
    local strAdd = string.format("imgAdd%d", i)
    if self[strHeroBg] then
      self[strHeroBg]:setDisplayFrame(sprBg:displayFrame())
    end
    if self[strIcon] then
      self[strIcon]:setDisplayFrame(sprIcon:displayFrame())
      Logic:Get("HeroCardInfo"):ClearShanCardSmall(self[strIcon])
    end
    if self[strAdd] then
      self[strAdd]:setVisible(true)
    end
    self[strSprLv]:setVisible(false)
    self[strNodLv]:setVisible(false)
  end
  self.leader = nil
  self.heros = {}
  for i = 1, #data.heros.embattles do
    for j = 1, #data.heros.embattles[i] do
      if data.heros.embattles[i][j] == data.heros.leaderId then
        local hero = Logic:Get("Hero"):GetHeroInfoById(data.heros.embattles[i][j])
        if hero ~= nil then
          self.leader = hero
        end
      elseif data.heros.embattles[i][j] ~= data.heros.leaderId then
        local hero = Logic:Get("Hero"):GetHeroInfoById(data.heros.embattles[i][j])
        if hero ~= nil then
          table.insert(self.heros, hero)
        end
      end
    end
  end
  self:initHeroData(1, self.leader)
  for i, v in pairs(self.heros) do
    self:initHeroData(i + 1, v)
  end
  self.firstGroup = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.FIRST_HERO_GROUP)
  if self.data.heros.groupId == 2 and self.firstGroup then
    self:allBtnAddLock(85)
    return
  end
  self.secondGroup = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.SECOND_HERO_GROUP)
  if self.data.heros.groupId == 3 and self.secondGroup then
    self:allBtnAddLock(90)
    return
  end
  self.fourthStatus = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.FOURTH_HERO)
  if self.fourthStatus then
    self:addLock(self.sprHeroBg4, 97, HERO_LOCK_PATH)
    self.imgAdd4:setVisible(false)
  end
  self.fifthStatus = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.FIFTH_HERO)
  if self.fifthStatus then
    self:addLock(self.sprHeroBg5, 98, HERO_LOCK_PATH)
    self.imgAdd5:setVisible(false)
  end
end
function prototype:refreshTitle()
  local path = string.format("images/TeamSwitch/fntGroup%d.png", self.data.sort)
  local spr = CCSprite:create(path)
  if spr then
    self.sprGroup:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:refreshSwitchBtn()
  local btnStatues = self.owner:getbtnStatues(self.data.sort)
  self.btnSwitch:setEnabled(btnStatues ~= "SELECTED")
  if self.ani then
    self.ani:RemoveAnimation()
  end
  if btnStatues == "SHINING" then
    self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz02", self.btnSwitch, ccp(85, 32.5))
    self.ani:GetChild("ccPar1"):setPositionType(kCCPositionTypeRelative)
    self.ani:GetChild("ccPar2"):setPositionType(kCCPositionTypeRelative)
    self.ani:RunAni()
  end
end
function prototype:onBtnSwitch(sender, event)
  if self.data.heros.groupId == 3 and self.secondGroup then
    if event == CCControlEventTouchDown then
      local level, copyName = Logic:Get("Lock"):GetOpenLevelAndBattle(Logic.Lock.LOCK_ID.SECOND_HERO_GROUP)
      self:showLockTip(level, copyName)
      return
    end
    self:closeLockTip(event)
    return
  end
  if event ~= CCControlEventTouchUpInside then
    return
  end
  if self.data.heros.leaderId == ID[-1] then
    Logic:Get("Devil"):SetChangeType(Logic.Hero.EVT.LEADER_CHANGE)
    Logic:Get("Devil"):SetChangeGroup(self.data)
    Logic:Get("Hero"):SetCurrentLeaderTag(false)
    SceneHelper:pushScene("DevilTeamerSelect", self.rootNode)
    return
  end
  self.owner:selectedGroup(self.data.sort)
end
function prototype:onBtnLeaderClicked(sender, event)
  if self.data.heros.groupId == 2 and self.firstGroup then
    if event == CCControlEventTouchDown then
      local level, copyName = Logic:Get("Lock"):GetOpenLevelAndBattle(Logic.Lock.LOCK_ID.FIRST_HERO_GROUP)
      self:showLockTip(level, copyName)
    end
    self:closeLockTip(event)
    return
  end
  if self.data.heros.groupId == 3 and self.secondGroup then
    if event == CCControlEventTouchDown then
      local level, copyName = Logic:Get("Lock"):GetOpenLevelAndBattle(Logic.Lock.LOCK_ID.SECOND_HERO_GROUP)
      self:showLockTip(level, copyName)
    end
    self:closeLockTip(event)
    return
  end
  if event == CCControlEventTouchUpInside then
    Logic:Get("Devil"):SetChangeType(Logic.Hero.EVT.LEADER_CHANGE)
    Logic:Get("Devil"):SetChangeGroup(self.data)
    SceneHelper:pushScene("DevilTeamerSelect", self.rootNode)
  end
end
function prototype:onBtnHeroClicked(sender, event)
  if self.data.heros.groupId == 2 and self.firstGroup then
    if event == CCControlEventTouchDown then
      local level, copyName = Logic:Get("Lock"):GetOpenLevelAndBattle(Logic.Lock.LOCK_ID.FIRST_HERO_GROUP)
      self:showLockTip(level, copyName)
    end
    self:closeLockTip(event)
    return
  end
  if self.data.heros.groupId == 3 and self.secondGroup then
    if event == CCControlEventTouchDown then
      local level, copyName = Logic:Get("Lock"):GetOpenLevelAndBattle(Logic.Lock.LOCK_ID.SECOND_HERO_GROUP)
      self:showLockTip(level, copyName)
    end
    self:closeLockTip(event)
    return
  end
  if sender == self.btnHero3 and self.fourthStatus then
    if event == CCControlEventTouchDown then
      local level, copyName = Logic:Get("Lock"):GetOpenLevelAndBattle(Logic.Lock.LOCK_ID.FOURTH_HERO)
      self:showLockTip(level, copyName)
    end
    self:closeLockTip(event)
    return
  end
  if sender == self.btnHero4 and self.fifthStatus then
    if event == CCControlEventTouchDown then
      local level, copyName = Logic:Get("Lock"):GetOpenLevelAndBattle(Logic.Lock.LOCK_ID.FIFTH_HERO)
      local str = TwGetStr(105403, level) .. "\n" .. TwGetStr(105404)
      Prompt:PopTip(str)
    end
    self:closeLockTip(event)
    return
  end
  if event == CCControlEventTouchUpInside then
    if self.data.heros.leaderId == ID[-1] then
      Logic:Get("Devil"):SetChangeType(Logic.Hero.EVT.LEADER_CHANGE)
    else
      Logic:Get("Devil"):SetChangeType(Logic.Hero.EVT.HERO_CURRENT)
    end
    Logic:Get("Devil"):SetChangeGroup(self.data)
    SceneHelper:pushScene("DevilTeamerSelect", self.rootNode)
  end
end
function prototype:initHeroData(idx, hero)
  if idx == nil or hero == nil then
    return
  end
  if idx < 0 or idx > MAX_HERO then
    return
  end
  local strHeroBg = string.format("sprHeroBg%d", idx)
  local strIcon = string.format("sprHeroIcon%d", idx)
  local strSprLv = string.format("sprLv%d", idx)
  local strNodLv = string.format("nodLv%d", idx)
  local strAdd = string.format("imgAdd%d", idx)
  local iconPath = Logic:Get("Hero"):GetHeroImage(hero.baseId)
  local spriteIcon = CCSprite:create(iconPath)
  if spriteIcon then
    self[strIcon]:setDisplayFrame(spriteIcon:displayFrame())
  end
  local strBg = Logic:Get("Hero"):GetHeroBgImage(hero.baseId)
  local spriteBg = CCSprite:create(strBg)
  if spriteBg then
    self[strHeroBg]:setDisplayFrame(spriteBg:displayFrame())
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self[strIcon], hero.baseId)
  if hero.level and 0 < hero.level then
    self[strSprLv]:setVisible(true)
    self[strNodLv]:setVisible(true)
    self[strNodLv]:create(0, "YELLOW_E_NUM")
    self[strNodLv]:setAlign("LEFT", "CENTER")
    self[strNodLv]:setValue(hero.level)
  else
    self[strSprLv]:setVisible(false)
    self[strNodLv]:setVisible(false)
  end
  if self[strAdd] then
    self[strAdd]:setVisible(false)
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
function prototype:showLockTip(level, copyName)
  if nil ~= copyName and "" ~= copyName and level ~= nil then
    local str = TwGetStr(105403, level) .. "\n" .. TwGetStr(105401, copyName)
    Prompt:PopTip(str)
  elseif level ~= nil then
    Prompt:PopTip(TwGetStr(105402, level))
  end
end
function prototype:closeLockTip(event)
  if event == CCControlEventTouchUpOutside or event == CCControlEventTouchUpInside or event == CCControlEventTouchCancel or event == CCControlEventTouchDragExit then
    Logic:Get("SureConfirm"):FireEvent(Logic.SureConfirm.EVT.CLOSE_POPTIP)
  end
end
function prototype:allBtnAddLock(tag)
  for i = 1, MAX_HERO do
    local str = string.format("sprHeroBg%d", i)
    local strAdd = string.format("imgAdd%d", i)
    self:addLock(self[str], tag, HERO_LOCK_PATH)
    tag = tag + 1
    if self[strAdd] then
      self[strAdd]:setVisible(false)
    end
  end
end
function prototype:removeBtnLock()
  for i = 1, MAX_HERO do
    local spr = string.format("sprHeroBg%d", i)
    if self[spr] then
      self[spr]:removeAllChildrenWithCleanup(true)
    end
  end
end
