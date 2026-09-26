module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local CARD_SIZE_WIDTH = 166
local IMG_NOR_PATH = {
  "images/Embattle/fontBattleGroup.png",
  "images/Embattle/fontFirstGroup.png",
  "images/Embattle/fontSecondGroup.png"
}
local IMG_SEL_PATH = {
  "images/Embattle/fontBattleGroupSel.png",
  "images/Embattle/fontFirstGroupSel.png",
  "images/Embattle/fontSecondGroupSel.png"
}
local IMG_BTN_PATH = {
  NORMAL = "images/newfont/BeginFight.png",
  NONE = "images/TeamSwitch/b.png"
}
function prototype:onEnter()
  super.onEnter(self)
  Logic:Get("Devil"):On(Logic.Devil.EVT.REFRESH_GROUP_DATA, self:Event("onRefreshGroupData"))
  Logic:Get("Hero"):On(Logic.Hero.EVT.SWITCH_HERO_GROUP, self:Event("onSwitchGroup"))
  self.pos = {}
  for i = 1, 6 do
    local strView = string.format("ccbHero%d", i)
    if self[strView] then
      self[strView]:Clear()
      local x, y = self[strView]:getPosition()
      self.pos[i] = {}
      self.pos[i].x = x
      self.pos[i].y = y
    end
  end
  local nameStr = ""
  self.firstGroup = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.FIRST_HERO_GROUP)
  if self.firstGroup then
    self.nodeCurrGroup:setVisible(false)
    self.nodeFirstGroup:setVisible(false)
    self.nodeSecGroup:setVisible(false)
    self.imgBtnRightBg:setVisible(false)
    self.sprRight:setVisible(false)
    self.btnGroup:setEnabled(false)
  end
  self.secondGroup = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.SECOND_HERO_GROUP)
  if self.secondGroup then
    self.nodeCurrGroup:setPositionX(self.nodeCurrGroup:getPositionX() + 100)
    self.nodeFirstGroup:setPositionX(self.nodeFirstGroup:getPositionX() + 100)
    self.nodeSecGroup:setVisible(false)
  end
  self.groupId = 1
  self.hasMember = true
  self:setGroupEmbattle(self.groupId)
  self:Touch()
  self:updateGuide()
end
function prototype:onExit(...)
  Logic:Get("Cultivate"):SetBtlBtnVisible(true)
  Logic:Get("Cultivate"):SetEmbattleFromCultivate(false)
end
function prototype:Touch()
  local moveUnit, touchBeginPos
  local HitTest = function(unit, pos)
    local x, y = unit:getPosition()
    local size = unit:getContentSize()
    x = x - size.width / 2
    y = y - size.height / 2
    return x < pos.x and y < pos.y and pos.x < x + size.width and pos.y < y + size.height
  end
  local function GetHitUnit(pos)
    local units = {
      "ccbHero1",
      "ccbHero2",
      "ccbHero3",
      "ccbHero4",
      "ccbHero5",
      "ccbHero6"
    }
    for i = 1, #units do
      if HitTest(self[units[i]], pos) then
        return self[units[i]]
      end
    end
  end
  local function onTouchBegan(x, y)
    moveUnit = GetHitUnit({x = x, y = y})
    if moveUnit == nil then
      touchBeginPos = nil
      moveUnit = nil
      return false
    end
    if moveUnit then
      local mx, my = moveUnit:getPosition()
      touchBeginPos = {x = mx, y = my}
      self.rootNode:reorderChild(moveUnit, 0)
    end
    return true
  end
  local function onTouchMoved(x, y)
    if moveUnit and touchBeginPos then
      moveUnit:setPosition(x, y)
    end
  end
  local function MoveOver(moveUnit, dragUnit)
    if not moveUnit or not dragUnit then
      return
    end
    local moveInfo = moveUnit:GetHeroInfo()
    local dragInfo = dragUnit:GetHeroInfo()
    if not moveInfo then
      return
    end
    local srcPoint = moveUnit:GetTagEmbattle()
    local tarPoint = dragUnit:GetTagEmbattle()
    if srcPoint and tarPoint then
      Logic:Get("Hero"):PostGroupEmbattle(self.groupId, srcPoint, tarPoint)
    end
    if not dragInfo then
      dragUnit:SetHeroInfo(moveInfo)
      dragUnit:SetImage(moveInfo, self.groupId)
      dragUnit:setScale(0.9)
      moveUnit:SetHeroInfo(nil)
      moveUnit:SetImage(nil)
      moveUnit:setScale(0.9)
      return
    end
    dragUnit:SetHeroInfo(moveInfo)
    moveUnit:SetHeroInfo(dragInfo)
    moveUnit:SetImage(dragInfo, self.groupId)
    dragUnit:SetImage(moveInfo, self.groupId)
    moveUnit:setScale(0.9)
    dragUnit:setScale(0.9)
  end
  local function onTouchEnded(x, y)
    for i = 1, 6 do
      local strView = string.format("ccbHero%d", i)
      if self[strView] then
        self[strView]:setPosition(self.pos[i].x, self.pos[i].y)
      end
    end
    if moveUnit and touchBeginPos then
      moveUnit:setPosition(touchBeginPos.x, touchBeginPos.y)
      local dragUnit = GetHitUnit({x = x, y = y})
      if dragUnit then
        MoveOver(moveUnit, dragUnit)
      end
    end
    moveUnit = nil
    touchBeginPos = nil
  end
  local function onTouch(eventType, x, y)
    if eventType == CCTOUCHBEGAN then
      return onTouchBegan(x, y)
    elseif eventType == CCTOUCHMOVED then
      return onTouchMoved(x, y)
    else
      return onTouchEnded(x, y)
    end
  end
  self.rootNode:registerScriptTouchHandler(onTouch)
  self.rootNode:setTouchEnabled(true)
end
function prototype:onBtnReturn()
  SceneHelper:popScene()
  local battleType = Logic:Get("Battle"):GetEmBattleType()
  if battleType == Logic.Battle.BATTLE_TYPE.ELITE then
    Logic:Get("Cultivate"):SetBtlBtnVisible(true)
  end
end
function prototype:onRefreshGroupData()
  self.groupId = 1
  self:setGroupEmbattle(self.groupId)
end
function prototype:onSwitchGroup()
  self:onBtnCurrGroup()
  self.groupId = 1
  self:setGroupEmbattle(self.groupId)
end
function prototype:onAreBegin()
  local battleType = Logic:Get("Battle"):GetEmBattleType()
  if not self.hasMember then
    SceneHelper:pushScene("DevilGroup", self.rootNode)
    return
  end
  Logic:Get("Guide"):done("FightPVP", "Fight")
  Logic:Get("Guide"):done("EquipElite", "Fight")
  if battleType == Logic.Battle.BATTLE_TYPE.CAMPAIGN then
    Logic:Get("System"):SaveUsrVariable()
    Logic:Get("Guide"):done("Partner", "Fight")
    Logic:Get("Guide"):done("FirstBattle", "Fight")
    Logic:Get("Guide"):done("LevelUpBattle", "Fight")
    local hero = Logic:Get("Hero"):GetFriendInfo()
    Logic:Get("Battle"):SetCurSelFriendId(hero)
    Logic:Get("Battle"):PostEnterMsg()
  elseif battleType == Logic.Battle.BATTLE_TYPE.ACTIVE then
    local hero = Logic:Get("Hero"):GetFriendInfo()
    Logic:Get("Battle"):SetCurSelFriendId(hero)
    Logic:Get("Battle"):PostEnterMsg()
  elseif battleType == Logic.Battle.BATTLE_TYPE.ARENA then
    if Logic:Get("Pvp"):IsPvp() then
      Logic:Get("Pvp"):PostDefyMatch()
      return
    end
    if Logic:Get("Sect"):IsFromDemog() then
      local info = Logic:Get("Sect"):GetCheckedDemogInfo()
      if info then
        local embattle = Logic:Get("Hero"):GetSendGroupHeros()
        Logic:Get("Sect"):PostAttackDemog(info.demogId, embattle)
      end
      return
    end
    Logic:Get("Fight"):PostDefyMatch()
  elseif battleType == Logic.Battle.BATTLE_TYPE.DEMOG then
    Logic:Get("Devil"):PostAttackDemog()
  elseif battleType == Logic.Battle.BATTLE_TYPE.REBIRTH then
    Logic:Get("Rebirth"):PostMultiaction()
  elseif battleType == Logic.Battle.BATTLE_TYPE.FULLED then
    Logic:Get("Rebirth"):PostMultiaction()
  elseif battleType == Logic.Battle.BATTLE_TYPE.ELITE then
    Logic:Get("Elite"):PostMultiaction(false)
  elseif battleType == Logic.Battle.BATTLE_TYPE.PILL then
    Logic:Get("Elite"):PostMultiaction(false)
  end
  self.rootNode:unregisterScriptTouchHandler()
end
function prototype:onBtnCurrGroup(sender, event)
  if self.groupId == 1 then
    return
  end
  self.groupId = 1
  self:setGroupEmbattle(self.groupId)
end
function prototype:onBtnFirstGroup(sender, event)
  if self.groupId == 2 then
    return
  end
  self.groupId = 2
  self:setGroupEmbattle(self.groupId)
end
function prototype:onBtnSecGroup(sender, event)
  if self.groupId == 3 then
    return
  end
  self.groupId = 3
  self:setGroupEmbattle(self.groupId)
end
function prototype:onBtnGroup(sender, event)
  SceneHelper:pushScene("DevilGroup", self.rootNode)
end
function prototype:onBtnSkip(sender, event)
  local battleType = Logic:Get("Battle"):GetEmBattleType()
  local battleId = Logic:Get("Rebirth"):GetBattleId()
  if self:IsSatisfySkip8(battleId) then
    Logic:Get("Rebirth"):PostQuickAdvance()
    return
  end
  Logic:Get("Mall"):BuyPoints()
end
function prototype:onBtnQuick(sender, event)
  local battleType = Logic:Get("Battle"):GetEmBattleType()
  if battleType == Logic.Battle.BATTLE_TYPE.ARENA then
    if event == CCControlEventTouchUpInside then
      if Logic:Get("Pvp"):IsPvp() then
        Logic:Get("Pvp"):SetSkipPvp(true)
        Logic:Get("Pvp"):PostDefyMatch()
        return
      end
      Logic:Get("Fight"):SetSkipFight(true)
      Logic:Get("Fight"):PostDefyMatch()
    end
    return
  end
  if battleType == Logic.Battle.BATTLE_TYPE.ELITE then
    if event == CCControlEventTouchUpInside then
      Logic:Get("Elite"):PostMultiaction(true)
    end
    return
  end
  local bVip = Logic:Get("PlayerInfo"):IsOpenFunc()
  if bVip then
    if event == CCControlEventTouchUpInside and battleType == Logic.Battle.BATTLE_TYPE.FULLED then
      Logic:Get("Rebirth"):PostQuickBattle()
      return
    end
    return
  end
  if event == CCControlEventTouchDown then
    Prompt:PopTip(TwGetStr(103047))
    return
  end
  if event == CCControlEventTouchUpOutside or event == CCControlEventTouchUpInside or event == CCControlEventTouchCancel then
    Logic:Get("SureConfirm"):FireEvent(Logic.SureConfirm.EVT.CLOSE_POPTIP)
  end
end
function prototype:setGroupEmbattle(groupId)
  local groups = Logic:Get("Hero"):GetGroups()
  local idx = 1
  for i = 1, #IMG_NOR_PATH do
    local str = string.format("imgGroup%d", i)
    if groupId == i then
      local spr = CCSprite:create(IMG_SEL_PATH[i])
      if spr == nil then
        break
      end
      if self[str] then
        self[str]:setDisplayFrame(spr:displayFrame())
      end
    else
      local spr = CCSprite:create(IMG_NOR_PATH[i])
      if spr == nil then
        break
      end
      if self[str] then
        self[str]:setDisplayFrame(spr:displayFrame())
      end
    end
  end
  self.imgBg:setVisible(true)
  self.imgDesc:setVisible(false)
  self.hasMember = true
  local spr = CCSprite:create(IMG_BTN_PATH.NORMAL)
  if spr then
    self.imgAreBegin:setDisplayFrame(spr:displayFrame())
  end
  for _, v in pairs(groups or {}) do
    if v.groupId == groupId then
      for i = 1, #v.embattles do
        for j = 1, #v.embattles[i] do
          local index = (i - 1) * 2 + j
          local strView = string.format("ccbHero%d", index)
          if not strView then
            return
          end
          local embattle = {
            i - 1,
            j - 1
          }
          self[strView]:SetTagEmbattle(embattle)
          if v.embattles[i][j] ~= ID[0] and v.embattles[i][j] ~= ID[-1] then
            local heroInfo = Logic:Get("Hero"):GetHeroInfoById(v.embattles[i][j])
            if not heroInfo then
              return
            end
            self[strView]:SetImage(heroInfo, groupId)
            self[strView]:SetHeroInfo(heroInfo)
            self[strView]:setScale(0.9)
          else
            self[strView]:SetImage(nil)
            self[strView]:SetHeroInfo(nil)
          end
        end
      end
    end
  end
  if groups[groupId] and groups[groupId].leaderId == ID[-1] then
    self.hasMember = false
    self.imgBg:setVisible(false)
    self.imgDesc:setVisible(true)
    spr = CCSprite:create(IMG_BTN_PATH.NONE)
    if spr then
      self.imgAreBegin:setDisplayFrame(spr:displayFrame())
    end
  end
  self:showSkipBtn()
end
function prototype:showSkipBtn()
  local battleType = Logic:Get("Battle"):GetEmBattleType()
  if battleType == Logic.Battle.BATTLE_TYPE.ARENA then
    if Logic:Get("Sect"):IsFromDemog() then
      return
    end
    local chargeTypeId = 402
    if Logic:Get("Pvp"):IsPvp() then
      if self:IsChargeEnoughByType(chargeTypeId) then
        self.nodQuick:setVisible(true)
        self:SetBtnQuickPos()
      end
      return
    end
    if not Logic:Get("Lock"):checkStatusById("SKIP_ARENA") or self:IsChargeEnoughByType(chargeTypeId) then
      self.nodQuick:setVisible(true)
      self:SetBtnQuickPos()
    end
    return
  end
  local canShowType = {
    [Logic.Battle.BATTLE_TYPE.FULLED] = true,
    [Logic.Battle.BATTLE_TYPE.ELITE] = true,
    [Logic.Battle.BATTLE_TYPE.PILL] = true
  }
  if not canShowType[battleType] then
    return
  end
  local bFinish
  if battleType == Logic.Battle.BATTLE_TYPE.FULLED then
    local id = Logic:Get("Rebirth"):GetBattleId()
    bFinish = Logic:Get("Rebirth"):isClearPrevBattle(id)
  elseif battleType == Logic.Battle.BATTLE_TYPE.ELITE then
    local id = Logic:Get("Elite"):GetBattleId()
    local bClearBattle = Logic:Get("Elite"):IsClearBattle(id)
    local block = Logic:Get("Lock"):checkStatusById("SKIP_ELITE")
    bFinish = bClearBattle and not block
  elseif battleType == Logic.Battle.BATTLE_TYPE.PILL then
    local id = Logic:Get("Elite"):GetBattleId()
    local bClearBattle = Logic:Get("Elite"):IsClearBattle(id)
    bFinish = bClearBattle
  end
  if not bFinish then
    self.nodQuick:setVisible(false)
    self.nodSkip:setVisible(false)
    return
  end
  self.nodQuick:setVisible(true)
  local bVip = Logic:Get("PlayerInfo"):IsOpenFunc()
  local strNoraml = "images/public/btnCommonNormal.png"
  local strLight = "images/public/btnCommonSelect.png"
  local strDisable = "images/public/btnCommonDisable.png"
  if battleType == Logic.Battle.BATTLE_TYPE.ELITE then
    self.btnQuick:setBackgroundSpriteForState(CCScale9Sprite:create(strNoraml), CCControlStateNormal)
    self.btnQuick:setBackgroundSpriteForState(CCScale9Sprite:create(strLight), CCControlStateHighlighted)
    self.btnQuick:setBackgroundSpriteForState(CCScale9Sprite:create(strDisable), CCControlStateDisabled)
    self:SetBtnQuickPos()
    return
  end
  if battleType == Logic.Battle.BATTLE_TYPE.PILL then
    self.btnQuick:setBackgroundSpriteForState(CCScale9Sprite:create(strNoraml), CCControlStateNormal)
    self.btnQuick:setBackgroundSpriteForState(CCScale9Sprite:create(strLight), CCControlStateHighlighted)
    self.btnQuick:setBackgroundSpriteForState(CCScale9Sprite:create(strDisable), CCControlStateDisabled)
    self:SetBtnQuickPos()
    if not bVip then
      return
    end
  end
  if bVip then
    self.btnQuick:setBackgroundSpriteForState(CCScale9Sprite:create(strNoraml), CCControlStateNormal)
    self.btnQuick:setBackgroundSpriteForState(CCScale9Sprite:create(strLight), CCControlStateHighlighted)
    self.btnQuick:setBackgroundSpriteForState(CCScale9Sprite:create(strDisable), CCControlStateDisabled)
    self:SetButtonsStatusForAdvance()
    return
  end
  self.btnQuick:setBackgroundSpriteForState(CCScale9Sprite:create(strDisable), CCControlStateNormal)
  self.btnQuick:setBackgroundSpriteForState(CCScale9Sprite:create(strDisable), CCControlStateHighlighted)
  self.btnQuick:setBackgroundSpriteForState(CCScale9Sprite:create(strDisable), CCControlStateDisabled)
  self:SetBtnQuickPos()
end
function prototype:SetButtonsStatusForAdvance()
  local condition = false
  local battleType = Logic:Get("Battle"):GetEmBattleType()
  if battleType == Logic.Battle.BATTLE_TYPE.PILL then
    local chargeType = 404
    local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
    local totalCharge = wallet.totalCharge
    local configInfo = KFDBGetRecord("Charge2Times", chargeType)
    local needCharge = not configInfo and 0 or tonumber(configInfo.chargeAmount)
    condition = totalCharge >= needCharge
  end
  if condition then
    self.nodSkip:setVisible(true)
    local posQuick = self.nodQuick:getPositionLua()
    self.nodeBtnAreBegin:setPosition(ccp(129, posQuick.y))
    self.nodQuick:setPosition(ccp(321, posQuick.y))
    self.nodSkip:setPosition(ccp(513, posQuick.y))
    if battleType == Logic.Battle.BATTLE_TYPE.PILL then
      local phyInfo = Logic:Get("PlayerInfo"):GetPlayerPhysical()
      local phyPoint = not phyInfo and 0 or phyInfo.point
      local battleId = Logic:Get("Elite"):GetBattleId()
      local rec = Logic:Get("Battle"):GetBattleInfoById(battleId) or {}
      local cost = tonumber(rec.cost)
      local times = math.floor(phyPoint / cost)
      if times > 8 then
        times = 8
      end
      local dailyCount = Logic:Get("Elite"):GetCountByBattleId(battleId)
      if times > dailyCount then
        times = dailyCount
      end
      self.times = times
      self.sprSkip:setVisible(false)
      self.nodSkip:setVisible(false)
      self.nodQuick:setVisible(false)
      self.nodeBtnAreBegin:setPositionX(320)
    end
    return
  end
  self:SetBtnQuickPos()
end
function prototype:IsChargeEnoughByType(chargeType)
  if chargeType == nil then
    return false
  end
  local configInfo = KFDBGetRecord("Charge2Times", chargeType)
  if configInfo == nil then
    return false
  end
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  local totalCharge = wallet.totalCharge
  local needCharge = tonumber(configInfo.chargeAmount)
  return totalCharge >= needCharge
end
function prototype:SetBtnQuickPos()
  local posQuick = self.nodQuick:getPositionLua()
  local battleType = Logic:Get("Battle"):GetEmBattleType()
  if battleType == Logic.Battle.BATTLE_TYPE.PILL then
    self.nodeBtnAreBegin:setPosition(ccp(320, posQuick.y))
    self.nodQuick:setVisible(false)
    return
  end
  self.nodeBtnAreBegin:setPosition(ccp(197, posQuick.y))
  self.nodQuick:setPosition(ccp(452, posQuick.y))
end
function prototype:IsSatisfySkip8(battleId)
  if battleId == nil then
    return false
  end
  local configInfo = KFDBGetRecord("ConfigValue", "BATTLE:QUICK_ADVANCE_COUNT")
  local skipTimes = not configInfo and 0 or tonumber(configInfo.content)
  local info = Logic:Get("Battle"):GetBattleInfoById(battleId)
  local curBattleNeedPoint = not info and 0 or info.cost
  local phyInfo = Logic:Get("PlayerInfo"):GetPlayerPhysical()
  local phyPoint = not phyInfo and 0 or phyInfo.point
  local needPhyPoint = skipTimes * curBattleNeedPoint
  return info and configInfo and phyPoint >= needPhyPoint
end
function prototype:updateGuide()
  local logicGuide = Logic:Get("Guide")
  logicGuide:lockTouch("FirstBattle", "Fight", self.btnAreBegin)
  logicGuide:lockTouch("LevelUpBattle", "Fight", self.btnAreBegin)
  logicGuide:lockTouch("Partner", "Fight", self.btnAreBegin)
  logicGuide:lockTouch("FightPVP", "Fight", self.btnAreBegin)
  logicGuide:lockTouch("EquipElite", "Fight", self.btnAreBegin)
end
