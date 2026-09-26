module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
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
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.ON_HERO_CROSSING, self:Event("onHeroCrossing"))
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
    self.imgBtnRightBg:setVisible(false)
    self.sprRight:setVisible(false)
  end
  self.secondGroup = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.SECOND_HERO_GROUP)
  if self.secondGroup then
  end
  self.groupId = 1
  self:setGroupEmbattle(self.groupId)
  self:Touch()
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
      Logic:Get("Cultivate"):EmbattleChanged(srcPoint, tarPoint)
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
end
function prototype:onRefreshGroupData()
  self.groupId = 1
  self:setGroupEmbattle(self.groupId)
end
function prototype:onHeroCrossing()
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIdj01", self.layer, ccp(320, 480), 0, nil, 1)
  if self.ani then
    self.ani:RunAni(nil, nil, bind(self.aniEnd, self))
  end
end
function prototype:aniEnd()
  Logic:Get("Cultivate"):StartCrossBattle()
end
function prototype:onAreBegin()
  local battleType = Logic:Get("Battle"):GetEmBattleType()
  if battleType == Logic.Battle.BATTLE_TYPE.PILL then
    local curHero = Logic:Get("Cultivate"):GetCrossHero()
    Logic:Get("Cultivate"):PostHeroCrossing(curHero.id)
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
function prototype:onBtnQuick(sender, event)
  local battleType = Logic:Get("Battle"):GetEmBattleType()
  if battleType == Logic.Battle.BATTLE_TYPE.PILL then
    if event == CCControlEventTouchUpInside then
      local curHero = Logic:Get("Cultivate"):getSelectHero()
      Logic:Get("Cultivate"):PostHeroCrossing(curHero.id)
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
  local groups = Logic:Get("Cultivate"):GetDefaultGroups()
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
            local heroInfo = v.embattles[i][j]
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
    self.imgBg:setVisible(false)
    self.imgDesc:setVisible(true)
    spr = CCSprite:create(IMG_BTN_PATH.NONE)
    if spr then
      self.imgAreBegin:setDisplayFrame(spr:displayFrame())
    end
  end
end
function prototype:SetButtonsStatus()
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
  self.nodeBtnAreBegin:setPosition(ccp(197, posQuick.y))
  self.nodQuick:setPosition(ccp(452, posQuick.y))
end
