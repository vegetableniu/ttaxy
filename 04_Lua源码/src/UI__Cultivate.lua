module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local POSITION = {
  ["3"] = {
    {x = 270, y = 758},
    {x = 395, y = 545},
    {x = 148, y = 545}
  },
  ["4"] = {
    {x = 275, y = 758},
    {x = 410, y = 595},
    {x = 275, y = 485},
    {x = 130, y = 595}
  },
  ["5"] = {
    {x = 270, y = 758},
    {x = 409, y = 642},
    {x = 352, y = 498},
    {x = 191, y = 500},
    {x = 133, y = 647}
  }
}
local path_nor = "images/public/btn_long_normal.png"
local path_sel = "images/public/btn_long_light.png"
local path_dis = "images/public/btn_long_disable.png"
function prototype:onEnter(node, loader)
  super.onEnter(self)
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.SELECT_HERO, self:Event("onSelectHero"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.SWALLOW_ELIXIR, self:Event("onSwallowElixir"))
  Logic:Get("BattleShow"):On(Logic.BattleShow.EVT.BATTLE_END, self:Event("onBattleEnd"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.COM_ELIXIR, self:Event("onComElixir"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.REMOVE_ITEM, self:Event("onRemoveItem"))
  Logic:Get("BattleShow"):On(Logic.BattleShow.EVT.END, self:Event("OnEndBattle"))
  Logic:Get("BattleShow"):On(Logic.BattleShow.EVT.INEND, self:Event("OnCultivateBattleInEnd"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.STUFF_CHANGE, self:Event("OnStuffChange"))
  self.selectHero = {}
  self.attribute = {}
  self.ccbAttribute:setAnchorPoint(ccp(0, 0))
  self:createTableView()
  self:onSelectHero()
  self:showBtnStatus()
  self:changeShopBtnBg()
  self.ttfCost:setStyle(kCCLabelTTFStyleOutline)
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
function prototype:showBtnStatus(...)
  local bCrossEnabled, bMax
  local bSelect = self.selectHero ~= nil
  if self.selectHero then
    bCrossEnabled = Logic:Get("Cultivate"):isSwallowAllElixir(self.selectHero.id)
    bMax = Logic:Get("Cultivate"):isMaxState(self.selectHero.baseId, self.selectHero.id)
  end
  if self.aniButton then
    self.aniButton:RemoveAnimation()
    self.aniButton = nil
  end
  local rec = KFDBGetRecord("CultivateState", self.bundary) or {}
  local bLock = Logic:Get("Lock"):checkStatusById(rec.lock)
  local path = ""
  if not bSelect or not bCrossEnabled or bMax or bLock then
    path = "images/Cultivate/fb_fight_dis.png"
    self.btnDutorob:setBackgroundSpriteForState(CCScale9Sprite:create(path_dis), CCControlStateNormal)
    self.btnDutorob:setBackgroundSpriteForState(CCScale9Sprite:create(path_dis), CCControlStateHighlighted)
  else
    path = "images/Cultivate/fb_fight_sel.png"
    self.btnDutorob:setBackgroundSpriteForState(CCScale9Sprite:create(path_nor), CCControlStateNormal)
    self.btnDutorob:setBackgroundSpriteForState(CCScale9Sprite:create(path_sel), CCControlStateHighlighted)
    self.aniButton = Logic:Get("AniMgr"):NewCCB("UI/UIcz02", self.btnDutorob, ccp(95, 30), 0, nil, nil)
  end
  local spr = CCSprite:create(path)
  if spr then
    self.sprBatIcon:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:onExit()
  Logic:Get("Cultivate"):setSelectHero(nil)
end
function prototype:createTableView()
  self.page = 1
  self.tableViewControl = TableViewEx.prototype:createList(self, self.nodeList, self.page)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.nodeList:addChild(self.tableViewControl.tableView)
end
function prototype:onSelectHero()
  self.selectHero = Logic:Get("Cultivate"):getSelectHero()
  local objNode = self.btnHeroSelect:getChildByTag(0)
  if objNode then
    self.btnHeroSelect:removeChild(objNode, true)
  end
  if table.empty(self.selectHero or {}) then
    for i = 1, 5 do
      local ccbMedicine = string.format("ccbMedicine%d", i)
      self[ccbMedicine].imgAdd:setVisible(false)
      self[ccbMedicine]:refreshMedicineInfo(nil)
    end
    self:showBtnStatus()
    self.imgAdd:setVisible(true)
    self.sprRealm:setVisible(false)
    self.nodeCost:setVisible(false)
    self.sprMaxState:setVisible(false)
    self.attribute = {}
    self.tableViewControl:RequireUpdateWithoutAnimat(nil, 0)
    return
  end
  local node = Logic:Get("HeroCardInfo"):createHeroCard(self.selectHero.baseId, 200)
  node:setAnchorPoint(CCPoint(0.5, 0.5))
  self.btnHeroSelect:addChild(node, 0, 0)
  local btnCz = self.btnHeroSelect:getContentSize()
  local nodeCz = self.btnHeroSelect:getContentSize()
  node:setPosition(ccp(btnCz.width / 2, btnCz.height / 2))
  self.imgAdd:setVisible(false)
  self.ccbAttribute:setPositionX(640)
  self.ccbAttribute.btnClose:setVisible(false)
  self.btnOpen1:setVisible(true)
  self.btnOpen2:setVisible(true)
  self.sprMaxState:setVisible(false)
  self.nodeCross:setVisible(true)
  self.nodeCost:setVisible(true)
  self:initHeroMedicine()
  self:initAttributeInfo()
  self:setCcbAttributePosition()
  self:setMedicineImg()
  self:crossCost()
  self:showBtnStatus()
  self.tableViewControl:RequireUpdateWithoutAnimat(nil, 0)
  if self:isMaxState() then
    self.nodeCross:setVisible(false)
    self.sprTip:setVisible(false)
    self.sprMaxState:setVisible(true)
    self.nodeCost:setVisible(false)
  end
end
function prototype:initHeroMedicine()
  local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(self.selectHero.baseId)
  self.bundary = Logic:Get("Cultivate"):getCutivateStateById(self.selectHero.id)
  local heroMedicine = KFDBGetRecord("UnitTypeElixir", heroInfo.type .. "_" .. self.bundary)
  self.selectHero.medicine = heroMedicine
  local cultivateInfo = KFDBGetRecord("CultivateState", self.bundary)
  local path = string.format("images/Cultivate/state_%d.png", self.bundary)
  local spr = CCSprite:create(path)
  if spr then
    self.sprRealm:setVisible(true)
    self.sprRealm:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:setCcbAttributePosition()
  local attribute = Logic:Get("Cultivate"):getAllAttribute(self.selectHero.id)
  local index = #attribute or 0
  if index <= 3 then
    self.ccbAttribute:setPositionY(500)
    self.ccbAttribute.btnClose:setPositionY(80)
    return
  end
  if index == 4 or index == 5 then
    self.ccbAttribute:setPositionY(470)
    self.ccbAttribute.btnClose:setPositionY(118)
    return
  end
  self.ccbAttribute.btnClose:setPositionY(130)
  self.ccbAttribute:setPositionY(433)
end
function prototype:initAttributeInfo()
  if self:isMaxState() then
    self.attribute = {}
    return
  end
  local spr
  self.attribute = Logic:Get("Cultivate"):getCrossAddAttribute(self.bundary, self.selectHero.id)
  spr = CCSprite:create("images/Cultivate/font_cross_attr.png")
  if spr then
    self.sprTip:setVisible(true)
    self.sprTip:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:crossCost()
  local cultivate = KFDBGetRecord("CultivateState", self.bundary)
  self.ttfCost:setString(cultivate.costStr or 0)
end
function prototype:setMedicineImg()
  for i = 1, 5 do
    local ccbMedicine = string.format("ccbMedicine%d", i)
    self[ccbMedicine]:refreshMedicineInfo(nil)
    self[ccbMedicine]:setVisible(false)
  end
  local medicine = json.decode(self.selectHero.medicine.elixirs or "") or {}
  local index = 0
  for k, v in pairs(medicine) do
    index = index + 1
  end
  if index == 0 then
    index = 5
  end
  if index < 3 then
    index = 3
  end
  local path = string.format("images/Cultivate/xx_main_%d.png", index)
  local spr = CCSprite:create(path)
  if spr then
    self.sprMainBg:setDisplayFrame(spr:displayFrame())
  end
  local position = POSITION[tostring(index)]
  for i = 1, index do
    local ccbMedicine = string.format("ccbMedicine%d", i)
    self[ccbMedicine]:setVisible(true)
    self[ccbMedicine]:setPosition(ccp(position[i].x, position[i].y))
    if self:isMaxState() then
      self[ccbMedicine]:refreshMedicineInfo(nil)
    end
  end
  if self:isMaxState() then
    return
  end
  for k, v in pairs(medicine or {}) do
    local ccbMedicine = string.format("ccbMedicine%d", k)
    local medicineInfo = {}
    medicineInfo.position = k
    medicineInfo.heroId = self.selectHero.id
    medicineInfo.baseId = v
    self[ccbMedicine]:refreshMedicineInfo(medicineInfo)
  end
end
function prototype:onSwallowElixir(elixirId)
  self:initHeroMedicine()
  self:initAttributeInfo()
  self:setMedicineImg()
  self:showBtnStatus()
  Singleton(Timer):After(400, self:Event("TIMER_RUN", function()
    self:runRankUpAni(elixirId)
  end))
  self.tableViewControl:RequireUpdateWithoutAnimat(nil, 0)
end
function prototype:isMaxState()
  return Logic:Get("Cultivate"):isMaxState(self.selectHero.baseId, self.selectHero.id)
end
function prototype:runRankUpAni(elixirId)
  local elixir = Logic:Get("Cultivate"):GetPillInfoByBaseId(elixirId)
  local info = not json.decode(elixir.alters or "") and {}
  local isPct = false
  local strTab = {}
  for k, v in pairs(info) do
    local tmp = {}
    if v < 10 then
      tmp.value = "+" .. v * 100 .. "%"
      tmp.isPct = true
    else
      tmp.value = "+" .. v
      tmp.isPct = false
    end
    tmp.attrType = k
    table.insert(strTab, tmp)
  end
  self:runAniOne(strTab)
end
function prototype:runAniOne(info)
  local x = 280
  if info[1].isPct then
    x = 300
  end
  local ani = Logic:Get("AniMgr"):NewCCB("UI/uizi", self.rootNode, ccp(x, 520), 0, nil, 1)
  if ani then
    self:setAniValueAndImg(info[1], ani)
    ani:SetWaitSignByDefaultAniName(function()
      if info[2] then
        local ani2 = Logic:Get("AniMgr"):NewCCB("UI/uizi", self.rootNode, ccp(x, 520), 0, nil, 1)
        self:setAniValueAndImg(info[2], ani2)
      end
    end, 5000)
    ani:RunAnimationWithoutWait()
  end
end
function prototype:setAniValueAndImg(info, ani)
  local labAttr = ani:GetChild("labAttr")
  labAttr:setString(info.value)
  local sprAttr = ani:GetChild("sprAttr")
  local sprite = Logic:Get("Cultivate"):getAttrSpr(info.attrType)
  if sprite then
    sprAttr:setDisplayFrame(sprite:displayFrame())
  end
end
function prototype:onBtnReturn(...)
  SceneHelper:removeScene("Cultivate")
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
function prototype:onBtnHeroSelectBig(...)
  SceneHelper:pushScene("CultivateSelectHero", self.rootNode)
end
function prototype:onBtnDutorob(...)
  if not self.selectHero then
    Prompt:Tip(114107)
    return
  end
  local function checkLock(...)
    local rec = KFDBGetRecord("CultivateState", self.bundary) or {}
    local bLock = Logic:Get("Lock"):checkStatusById(rec.lock)
    if bLock then
      local str = ""
      local level, battle = Logic:Get("Lock"):GetOpenLevelAndEliteBattle(rec.lock)
      local playerLevel = Logic:Get("PlayerInfo"):GetPlayerLevel()
      if level > playerLevel then
        str = str .. TwGetStr(114114, level)
      end
      if battle ~= "" then
        str = str .. TwGetStr(114115, battle)
      end
      return true, str
    end
    return false
  end
  local bLock, str = checkLock()
  local bCrossEnabled = Logic:Get("Cultivate"):isSwallowAllElixir(self.selectHero.id)
  if not bCrossEnabled then
    local strTip = TwGetStr(114104)
    if str then
      strTip = strTip .. TwGetStr(114118) .. str
    end
    strTip = strTip .. TwGetStr(114113)
    Prompt:Tip(strTip)
    return
  end
  local bMax = Logic:Get("Cultivate"):isMaxState(self.selectHero.baseId, self.selectHero.id)
  if bMax then
    Prompt:Tip(114105)
    return
  end
  if bLock then
    Prompt:Tip(str .. TwGetStr(114113))
    return
  end
  local rec = KFDBGetRecord("CultivateState", self.bundary) or {}
  local cost = tonumber(rec.cost) or 0
  local function OnCultivate(self, ret)
    if ret ~= Prompt.RET.OK then
      return
    end
    local copper = Logic:Get("PlayerInfo"):GetPlayerMoney().copper or 0
    if copper < cost then
      Prompt:Fail(103031)
      return
    end
    local isById, cross = Logic:Get("Cultivate"):CrossRecById(self.selectHero.id, self.bundary)
    if not isById then
      isById, cross = Logic:Get("Cultivate"):CrossRecByJob(self.selectHero.id, self.bundary)
    end
    if cross.dramaId ~= 0 then
      Logic:Get("DramaTalk"):OnGuideTrigger(cross.dramaId, bind(self.startBattle, self))
      return
    end
    self:startBattle()
  end
  local str = TwGetStr(114117, cost)
  Prompt:Select(self, "", str, OnCultivate)
end
function prototype:startBattle()
  Logic:Get("Cultivate"):SetCrossHero(self.selectHero)
  Logic:Get("Battle"):SetEmBattleType(Logic.Battle.BATTLE_TYPE.PILL)
  SceneHelper:pushScene("EmbattleCultivate")
end
function prototype:onBtnRebuild(...)
  if SceneHelper:isExistScene("CultivateRebuild") then
    return
  end
  SceneHelper:pushScene("CultivateRebuild", self.rootNode)
end
function prototype:onBtnOpen()
  self.btnOpen1:setVisible(false)
  self.btnOpen2:setVisible(false)
  local position = self.ccbAttribute:getPositionY()
  local arrAction = CCArray:create()
  local actionMoveTo = CCMoveTo:create(0.5, ccp(470, position))
  arrAction:addObject(CCCallFuncN:create(function()
    self.ccbAttribute.btnClose:setVisible(true)
    self.ccbAttribute.btnClose:setEnabled(false)
  end))
  arrAction:addObject(actionMoveTo)
  arrAction:addObject(CCCallFuncN:create(function()
    self.ccbAttribute.btnClose:setEnabled(true)
  end))
  self.ccbAttribute:runAction(CCSequence:create(arrAction))
end
function prototype:onRemoveItem()
  local arrAction = CCArray:create()
  local position = self.ccbAttribute:getPositionY()
  local actionMoveTo = CCMoveTo:create(0.5, ccp(640, position))
  arrAction:addObject(CCCallFuncN:create(function()
    self.ccbAttribute.btnClose:setEnabled(false)
  end))
  arrAction:addObject(actionMoveTo)
  arrAction:addObject(CCCallFuncN:create(function()
    self.ccbAttribute.btnClose:setVisible(false)
    self.ccbAttribute.btnClose:setEnabled(true)
  end))
  arrAction:addObject(CCCallFuncN:create(function()
    self.btnOpen1:setVisible(true)
    self.btnOpen2:setVisible(true)
  end))
  self.ccbAttribute:runAction(CCSequence:create(arrAction))
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(500, 41)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("CultivateAttributeItem", self.rootNode)
    subScene.attributeList:refreshAttribute(self.attribute[index + 1], self.selectHero.id)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2)
    cell:getChildByTag(2).attributeList:refreshAttribute(self.attribute[index + 1], self.selectHero.id)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.attribute == nil then
    return 0
  end
  return #self.attribute
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdateWithoutAnimat(nil, 0)
end
function prototype:onBattleEnd()
  SceneHelper:removeScene("EmbattleCultivate")
  self:onSelectHero()
end
function prototype:onComElixir()
  self:onSelectHero()
end
function prototype:OnEndBattle(...)
  self.rootNode:setVisible(true)
  self:onSelectHero()
  self:changeShopBtnBg()
end
function prototype:OnCultivateBattleInEnd(...)
  self.rootNode:setVisible(false)
end
function prototype:OnStuffChange()
  self:onSelectHero()
end
