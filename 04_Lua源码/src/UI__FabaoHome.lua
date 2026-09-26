module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
local IMG_SEL_PATH = {
  "images/Embattle/fontBattleGroupSel.png",
  "images/Embattle/fontFirstGroupSel.png",
  "images/Embattle/fontSecondGroupSel.png"
}
local IMG_NOR_PATH = {
  "images/Embattle/fontBattleGroup.png",
  "images/Embattle/fontFirstGroup.png",
  "images/Embattle/fontSecondGroup.png"
}
local SPR_ADD = {
  "imgAddLeft",
  "imgAddRight"
}
local HERO_LOCK_PATH = "images/Main/heroLock.png"
local NO_FABAO_ICON_PAHT = "images/public/materialEvo.png"
local FABAO_ICON_PATH = "images/public/clarity05.png"
local MAX_HERO_PER_PAGE = 5
prototype = BtnPosition.prototype:extend()
function prototype:initialize()
  super.initialize(self)
end
function prototype:onEnter()
  super.onEnter(self)
  Logic:Get("Talisman"):GetTailsmans_KeyIds()
  self.data = Logic:Get("Hero"):GetFightHero()
  local page = 0
  if #self.data then
    for i = 1, #self.data do
      if #self.data[i] ~= 0 then
        page = page + 1
      end
    end
  end
  self:setGroupBtnState(page)
  self:showgroupsta(1)
  Logic:Get("Talisman"):SetSelectHero(self.data[1][1])
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstHero, page)
  self.lstHero:addChild(self.tableViewControl.tableView)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionHorizontal)
  self.tableViewControl:RequireUpdateWithoutAnimat(page)
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.CHANGE_IMG_FABAO, self:Event("onChangeImgFabao"))
  Logic:Get("Guide"):On(Logic.Guide.EVT.STEP, self:Event("updateGuide"))
  local selecthero = Logic:Get("Talisman"):GetSelectHero()
  Logic:Get("Talisman"):ChangeImgFabao(1)
  self.aniButton = Logic:Get("AniMgr"):NewCCB("UI/UIcz02", self.sprRight, ccp(66, 17), 0, nil, nil)
  self:StaLock()
  self:updateGuide()
end
function prototype:onBtnReturn()
  Logic:Get("Talisman"):ClearSelectHero()
  SceneHelper:runWithScene("Home", self.rootNode)
end
function prototype:onBtnActivity()
  Logic:Get("Guide"):done("Talisman", "FabaoLookFor")
  SceneHelper:runWithScene("FabaoLookFor", self.rootNode)
end
function prototype:onBtnPutonFabao()
  local curSelectHero = Logic:Get("Talisman"):GetSelectHero()
  Logic:Get("HeroCardInfo"):OpenHeroInfo(curSelectHero)
end
function prototype:onTurnToTreasure()
  SceneHelper:runWithScene("FabaoLookFor", self.rootNode)
end
function prototype:onBtnLeft()
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onBtnRight()
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(1)
  end
end
function prototype:onBtnUpgradeFabao()
  Logic:Get("Talisman"):setOpenStyle(true)
  Logic:Get("Talisman"):setCheckState(1)
  SceneHelper:pushScene("FabaoUpgradeSelect", self.rootNode)
end
function prototype:onBtnFabaoL()
  Logic:Get("Guide"):done("TalismanEquip", "Start")
  Logic:Get("Talisman"):setTalismanPosition(1)
  self:selectFabao(1)
end
function prototype:onBtnFabaoR(sender, event)
  if self.fabaoStatus then
    self:showTip(self.fabaoStatus, event)
    return
  end
  if event == CCControlEventTouchUpInside then
    Logic:Get("Talisman"):setTalismanPosition(2)
    self:selectFabao(2)
  end
end
function prototype:selectFabao(position)
  local allfabaos = Logic:Get("Talisman"):GetAllfabaos()
  local canEquipFabaos = Logic:Get("Talisman"):GetTailsmanVoByHero(position)
  if #allfabaos == 0 or canEquipFabaos == nil or table.empty(canEquipFabaos) then
    Prompt:Fail(TwGetStr(112046))
    return
  end
  Logic:Get("Talisman"):ClearSelectFabao()
  Logic:Get("Talisman"):setOpenStyle(false)
  SceneHelper:pushScene("FabaoSelect", self.rootNode)
end
function prototype:onBtnCheckFabao()
  Logic:Get("Talisman"):setOpenStyle(false)
  Logic:Get("Talisman"):setCheckState(0)
  SceneHelper:pushScene("FabaoUpgradeSelect", self.rootNode)
end
function prototype:onChangeImgFabao()
  local spriteIcon = CCSprite:create(FABAO_ICON_PATH)
  self.imgFabaoL:setDisplayFrame(spriteIcon:displayFrame())
  self.imgFabaoR:setDisplayFrame(spriteIcon:displayFrame())
  self.imgBgRight:setDisplayFrame(spriteIcon:displayFrame())
  self.imgBgLeft:setDisplayFrame(spriteIcon:displayFrame())
  self.imgLevel1:setVisible(false)
  self.imgLevel2:setVisible(false)
  self.staLevel1:setVisible(false)
  self.staLevel2:setVisible(false)
  local thehero = Logic:Get("Talisman"):GetSelectHero()
  if thehero == nil then
    self.btnFabao:setEnabled(false)
    return
  end
  self.btnFabao:setEnabled(true)
  local objNode = self.btnFabao:getChildByTag(0)
  if objNode then
    self.btnFabao:removeChild(objNode, true)
  end
  local node = Logic:Get("HeroCardInfo"):createHeroCard(thehero.baseId, 190)
  node:setAnchorPoint(CCPoint(0, 1))
  self.btnFabao:addChild(node, 0, 0)
  local btnCz = self.btnFabao:getContentSize()
  node:setPosition(ccp(btnCz.width / 1.95, btnCz.height / 2))
  local Talismans = Logic:Get("Talisman"):GetHeroEquipTailsmanByHeroId(thehero.id)
  if Talismans == nil or Talismans[1] == nil then
    self:setSprAddVisible()
    return
  end
  self:setSprAddVisible()
  local updateFabao = Talismans[1]
  self.updateFabao = updateFabao
  if Talismans then
    self:onsetimgfabao(Talismans)
  end
end
function prototype:setSprAddVisible()
  self[SPR_ADD[1]]:setVisible(true)
  if self.fabaoStatus then
    self[SPR_ADD[2]]:setVisible(false)
  else
    self[SPR_ADD[2]]:setVisible(true)
  end
end
function prototype:onsetimgfabao(fabao)
  local strbg = {"imgFabaoL", "imgFabaoR"}
  local btn = {"imgBgLeft", "imgBgRight"}
  local imglevel = {"imgLevel1", "imgLevel2"}
  local stalevel = {"staLevel1", "staLevel2"}
  for i = 1, #btn do
    if fabao[i] and fabao[i].baseId then
      local rec = KFDBGetRecord("TalismanSetting", fabao[i].baseId)
      if rec ~= nil and rec.baseId ~= nil and self.imgFabaoL then
        local pathIcon = Logic:Get("Hero"):GetHeroImage(rec.baseId)
        local fdb_baseHero = Logic:Get("HeroCardInfo"):kdbBaseHero(rec.baseId)
        if pathIcon then
          local spriteIcon = CCSprite:create(pathIcon)
          if spriteIcon then
            self[btn[rec.position]]:setDisplayFrame(spriteIcon:displayFrame())
            self[btn[rec.position]]:setVisible(true)
            self[imglevel[rec.position]]:setVisible(true)
            self[stalevel[rec.position]]:setVisible(true)
            if self[stalevel[rec.position]] then
              self[stalevel[rec.position]]:create(0, "YELLOW_E_NUM")
              self[stalevel[rec.position]]:setAlign("LEFT", "CENTER")
              self[stalevel[rec.position]]:setValue(fabao[i].level or 1)
            end
            self.btnUpgradeFabao:setEnabled(true)
            self.btnCheckFabao:setEnabled(true)
            self[SPR_ADD[rec.position]]:setVisible(false)
            if tonumber(fdb_baseHero.rank) == 0 then
              fdb_baseHero.rank = 1
            end
            local spr = Logic:Get("Compose"):GetItemsFrame(tonumber(fdb_baseHero.rank))
            self[strbg[rec.position]]:setDisplayFrame(spr:displayFrame())
          end
        end
      end
    end
  end
end
function prototype:onBtnczpz()
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPageTo(1, true, false)
    self:showgroupsta(1)
  end
end
function prototype:onBtnYjFirst()
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPageTo(2, true, false)
    self:showgroupsta(2)
  end
end
function prototype:onBtnYjSecond()
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPageTo(3, true, false)
    self:showgroupsta(3)
  end
end
function prototype:showgroupsta(curPage)
  for i = 1, #IMG_NOR_PATH do
    local str = string.format("imgGroup%d", i)
    if i == curPage then
      local sprIcon = CCSprite:create(IMG_SEL_PATH[i])
      if sprIcon == nil then
        break
      end
      if self[str] then
        self[str]:setDisplayFrame(sprIcon:displayFrame())
      end
    else
      local sprIcon = CCSprite:create(IMG_NOR_PATH[i])
      if sprIcon == nil then
        break
      end
      if self[str] then
        self[str]:setDisplayFrame(sprIcon:displayFrame())
      end
    end
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(530, 130)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("FabaoSelectHero", self.rootNode)
    subScene:ReFrashInfo(self.data[curPage])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):ReFrashInfo(self.data[curPage])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.data == nil or table.empty(self.data) then
    return 0
  end
  return 1
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdateWithoutAnimat()
  self:showgroupsta(curPage)
end
function prototype:StaLock()
  self.fabaoStatus = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.TALISMAN_EQUIP_2_LOCK)
  self:onFabaoLock(self.fabaoStatus)
end
function prototype:onFabaoLock(isLock)
  if isLock then
    self[SPR_ADD[2]]:setVisible(false)
    self:addLock(self.btnFabaoR, 90, HERO_LOCK_PATH)
  else
    self:removeLock(self.btnFabaoR, 90)
  end
end
function prototype:addLock(btnNode, tag, sprPath)
  if btnNode and tag then
    local lockChild = btnNode:getChildByTag(tag)
    if lockChild ~= nil then
      return
    end
    local sprLock = sprPath and CCSprite:create(sprPath) or CCSprite:create(HERO_LOCK_PATH)
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
function prototype:showTip(isLock, event)
  if isLock then
    if event == CCControlEventTouchDown then
      local level, copyName = Logic:Get("Lock"):GetOpenLevelAndBattle(Logic.Lock.LOCK_ID.TALISMAN_EQUIP_2_LOCK)
      self:showLockTip(level, copyName)
    end
    self:closeLockTip(event)
    return
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
function prototype:onRETURN_BACK()
  self:onChangeImgFabao()
end
function prototype:setGroupBtnState(page)
  if page == 1 then
    self.imgGroup2:setVisible(false)
    self.imgGroup3:setVisible(false)
    self.btnYjFirst:setEnabled(false)
    self.btnYjSecond:setEnabled(false)
  elseif page == 2 then
    self.imgGroup3:setVisible(false)
    self.btnYjSecond:setEnabled(false)
  end
end
function prototype:updateGuide()
  local logicGuide = Logic:Get("Guide")
  if not logicGuide:isGuiding() then
    return
  end
  logicGuide:lockTouch("Talisman", "FabaoLookFor", self.btnActivity)
  logicGuide:lockTouch("TalismanEquip", "Start", self.btnFabaoL)
end
