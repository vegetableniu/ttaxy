module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local WIN_WIDTH, WIN_HEIGHT = 590, 100
function prototype:onEnter()
  Logic:Get("Guide"):On(Logic.Guide.EVT.STEP, self:Event("updateGuide"))
  self:updateGuide()
  self.ttfProp1:setStyle(kCCLabelTTFStyleOutline)
  self.ttfProp2:setStyle(kCCLabelTTFStyleOutline)
  self.ttfProp3:setStyle(kCCLabelTTFStyleOutline)
  self.ttfProp4:setStyle(kCCLabelTTFStyleOutline)
  Logic:Get("Armor"):checkArmorEquipState()
  self.weaponIcon:setEquipType(1)
  self.EquipIcon:setEquipType(2)
  self.groups = Logic:Get("Hero"):GetFightHero()
  self.maxPage = 0
  for i, v in pairs(self.groups) do
    if v and not table.empty(v) then
      self.maxPage = i
    end
  end
  self.tableViewControl = TableViewEx.prototype:createList(self, self.nodeHeroList, self.maxPage, true)
  self.nodeHeroList:addChild(self.tableViewControl.tableView)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionHorizontal)
  Logic:Get("Armor"):PostEquipPackInfo()
  Logic:Get("Armor"):On(Logic.Armor.EVT.CHANGE_HERO_INFO, self:Event("changeHeroInfo"))
  local chooseHeroId = Logic:Get("Armor"):getChooseHeroId()
  if not chooseHeroId then
    self:changeHeroInfo(self.groups[1][1])
    return
  end
  for i = 1, self.maxPage do
    for index, v in ipairs(self.groups[i]) do
      if v.id == chooseHeroId then
        self.tableViewControl:TurnPageTo(i, true, false)
        self:changeHeroInfo(v)
        return
      end
    end
  end
  self:changeHeroInfo(self.groups[1][1])
end
function prototype:changeHeroInfo(info)
  self.chooseInfo = info
  if info and info.baseId then
    Logic:Get("Armor"):setChooseHeroId(info.id)
    Logic:Get("HeroCardInfo"):ClearShanCard(self.sprHero, info.baseId)
    local card = Logic:Get("HeroCardInfo"):createHeroCardForByFight(info.baseId)
    local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(card, card:getContentSize())
    Logic:Get("HeroCardInfo"):AddShanCard(self.sprHero, info.baseId, card:getContentSize().width)
    self.sprHero:setTexture(texture)
    self.sprHero:setTextureRect(textureRect)
    self.detailsItem:initInfo(info.baseId)
  end
  self.tableViewControl:RequireUpdate(self.maxPage, false, false)
  self:setArmorInfo()
end
function prototype:setArmorInfo()
  local chooseHeroId = Logic:Get("Armor"):getChooseHeroId()
  local equipArmors = Logic:Get("Armor"):getHeroEquipArmors(chooseHeroId)
  self.weaponIcon:clear()
  self.EquipIcon:clear()
  local bLock = Logic:Get("Lock"):checkStatusById("EQUIP_LVUP")
  self.btnLvUp:setEnabled(#equipArmors > 0 and not bLock)
  for _, v in ipairs(equipArmors) do
    if v.position == 1 then
      self.weaponIcon:setMetaGodImage(v)
    elseif v.position == 2 then
      self.EquipIcon:setMetaGodImage(v)
    end
  end
  self:setArmorsCombosTotalAlters()
end
function prototype:setArmorsCombosTotalAlters()
  self:clear()
  local chooseHeroId = Logic:Get("Armor"):getChooseHeroId()
  local heroInfo = Logic:Get("Hero"):GetHeroInfoById(chooseHeroId)
  if not heroInfo or not heroInfo.baseId then
    return false
  end
  local heroEquipArmors = Logic:Get("Armor"):getHeroEquipArmors(chooseHeroId)
  local counts = Logic:Get("Armor"):getActivateCounts(heroInfo.baseId, heroEquipArmors)
  if counts == 0 then
    self.sprTotalProp:setVisible(false)
    return
  end
  self.sprTotalProp:setVisible(true)
  local armorSet = Logic:Get("Hero"):GetHeroInfoByBaseId(heroInfo.baseId)
  if armorSet and armorSet.weaponSet then
    armorSet = json.decode(armorSet.weaponSet or "[]") or {}
  end
  local buffId = tostring(heroInfo.baseId) .. "_" .. tostring(armorSet[counts] or 0)
  local alters = Logic:Get("Armor"):getTotalComboAlters(buffId)
  local altersArr = Logic:Get("Armor"):sortPropInfo(alters)
  for i, v in ipairs(altersArr) do
    local spr = Logic:Get("Armor"):getPropertySpr(v.propName)
    local strSpr = string.format("spr%d", i)
    local strProp = string.format("ttfProp%d", i)
    if spr and self[strSpr] and self[strProp] then
      self[strSpr]:setVisible(true)
      self[strSpr]:setDisplayFrame(spr:displayFrame())
      local str = TwGetStr(111411, tostring(100 * v.value))
      self[strProp]:setString(str)
      if i == 1 then
        local xSprPos = self[strSpr]:getPositionX()
        local width = self[strSpr]:getContentSize().width
        self[strProp]:setPositionX(xSprPos + width / 2 - 2)
      else
        local prePorpStr = string.format("ttfProp%d", i - 1)
        local xPrePropPos = self[prePorpStr]:getPositionX()
        local prePropWidth = self[prePorpStr]:getContentSize().width
        local sprWidth = self[strSpr]:getContentSize().width
        local xSprPos = xPrePropPos + prePropWidth + 2 + sprWidth / 2
        self[strSpr]:setPositionX(xSprPos)
        self[strProp]:setPositionX(xSprPos + sprWidth / 2 - 2)
      end
    end
  end
end
function prototype:cellSizeForTable()
  return CCSizeMake(WIN_WIDTH, WIN_HEIGHT)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ArmorHeroList", self.rootNode)
    subScene:refresh(self.groups[curPage])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):refresh(self.groups[curPage])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  return self.maxPage == 0 and 0 or 1
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  if self.groups[curPage] then
    self:changeHeroInfo(self.groups[curPage][1])
  end
  self.tableViewControl:RequireUpdate()
end
function prototype:clear()
  self.spr1:setVisible(false)
  self.spr2:setVisible(false)
  self.spr3:setVisible(false)
  self.spr4:setVisible(false)
  self.ttfProp1:setString("")
  self.ttfProp2:setString("")
  self.ttfProp3:setString("")
  self.ttfProp4:setString("")
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("Home", self.rootNode)
end
function prototype:onBtnBagClicked(sender, event)
  SceneHelper:runWithScene("ArmorPack", self.rootNode)
end
function prototype:onBtnHero(sender, event)
  if self.chooseInfo and self.chooseInfo.baseId then
    local heroInfo = {
      id = self.chooseInfo.id,
      level = self.chooseInfo.level or 1,
      baseId = self.chooseInfo.baseId or 1,
      powerSkill = tonumber(self.chooseInfo.powerSkill) or 1
    }
    Logic:Get("HeroCardInfo"):OpenHeroInfo(heroInfo)
  end
end
function prototype:onBtnLvUp(sender, event)
  local bLock = Logic:Get("Lock"):checkStatusById("EQUIP_LVUP")
  if bLock then
    local level, copyName = Logic:Get("Lock"):GetLevelAndBattleNames("EQUIP_LVUP")
    if nil ~= copyName and "" ~= copyName then
      local str = TwGetStr(105403, level) .. "\n" .. TwGetStr(105401, copyName)
      Prompt:Tip(str)
    else
      Prompt:Tip(TwGetStr(105402, level))
    end
    return
  end
  if not self.btnLvUp:isEnabled() then
    Prompt:Tip(TwGetStr(111442))
    return
  end
  SceneHelper:runWithScene("ArmorRankSele", self.rootNode)
end
function prototype:updateGuide()
  local logicGuide = Logic:Get("Guide")
  if not logicGuide:isGuiding() then
    return
  end
  if Logic:Get("Armor"):isDoneEquip() then
    Logic:Get("Guide"):done("EquipEquip", "SelectEquip")
    Logic:Get("Guide"):done("EquipEquip", "SelectEquipDone")
  end
  if logicGuide:isActive("EquipEquip", "SelectEquip") then
    logicGuide:lockTouch(self.weaponIcon)
  end
  if logicGuide:isActive("EquipFetterOne", "Start") then
    logicGuide:lockTouch(self.EquipIcon)
  end
end
