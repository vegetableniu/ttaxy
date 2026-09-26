module((...), package.seeall)
require("Logic.Battle")
require("TableViewEx")
require("BtnPosition")
local Battle = Logic.Battle
local Login = Logic.Login
local LST_W = 560
local LST_H = 496
local LST_ITEM_W = 563
local LST_ITEM_H = 117
local CELL_TAG = 1
local LAYER_TYPE = Battle.UI_LAYER_TYPE
local MAIN_BTN_TYPE = Enum({
  "CAMPAIGN_NORMAL",
  "CAMPAIGN_HARD",
  "RETURN_CAMPAIGN",
  "COPY_DROP"
})
local IMG_NORMAL_STR = "images/font/normalCopySmall.png"
local IMG_HARD_STR = "images/font/elite.png"
local IMG_RETURN_STR = "images/font/return.png"
local IMG_TITLE_NORMAL_STR = "images/font/Battle.png"
local IMG_TITLE_HARD_STR = "images/font/hardBattleCopy.png"
local IMG_ACTIVITY_STR = "images/Activity/ActivityTitle.png"
local IMG_REBIRTH_STR = "images/Rebirth/fontHonor.png"
prototype = BtnPosition.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
  Logic:Get("Battle"):On(Battle.EVT.CLICK_BATTLE_COPY_ITEM, self:Event("onClickItem"))
  Logic:Get("Battle"):On(Battle.EVT.REFRESH_BATTLE_COPY, self:Event("refresh"))
  Logic:Get("Battle"):On(Battle.EVT.REOPEN_BATTLE_COPY, self:Event("reOpen"))
  Logic:Get("Battle"):On(Battle.EVT.SET_UI_NEXT_LAYER, self:Event("setNextLayer"))
  Logic:Get("Battle"):On(Battle.EVT.SET_UI_CAMPAIGN_TYPE, self:Event("setNextCampType"))
  Logic:Get("Battle"):On(Battle.EVT.OPEN_BATTLE_FRIEND, self:Event("onOpenBattleFriend"))
  Logic:Get("Battle"):On(Battle.EVT.BATTLE_FRIEND_SCENE_RETURN, self:Event("onBattleFriendSceneReturn"))
  Logic:Get("BattleShow"):On(Logic.BattleShow.EVT.INEND, self:Event("onInBattleEnd"))
  Logic:Get("BattleShow"):On(Logic.BattleShow.EVT.END, self:Event("onBattleResultEnd"))
  Logic:Get("Battle"):On(Logic.Battle.EVT.CAMPAIGN_COMPLETED, self:Event("onCampaignComplete"))
  Logic:Get("Guide"):On(Logic.Guide.EVT.STEP, self:Event("updateGuide"))
  self.curStageInfo = {}
  self.curStageInfo.campId = nil
  self.curStageInfo.battleId = nil
  self.curStageInfo.campType = Battle.CAMPAIGN_TYPE.NORMAL
  self.curStageInfo.layerType = LAYER_TYPE.CAMPAIGN
  self.curStageInfo.typeBtnLeft = MAIN_BTN_TYPE.CAMPAIGN_HARD
  self.curStageInfo.typeBtnRight = MAIN_BTN_TYPE.COPY_DROP
  Logic:Get("Battle"):SetCurSelLayerType(LAYER_TYPE.CAMPAIGN)
  self.campLabelInfo = {}
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  Logic:Get("Battle"):RefreshLeftTimes()
  Logic:Get("Battle"):SetEmBattleType(Logic.Battle.BATTLE_TYPE.CAMPAIGN)
  self:createList()
  self:refreshMainUI()
end
function prototype:onExit()
end
function prototype:createList()
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstItems, 1)
  self.tableViewControl.tableView:setVerticalFillOrder(kCCTableViewFillBottomUp)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.lstItems:addChild(self.tableViewControl.tableView)
end
function prototype:refreshListLable()
  if self.curStageInfo.layerType == LAYER_TYPE.BATTLE then
    self:createListLable(self.curStageInfo.campId)
  else
    self:deleteListLable()
  end
end
function prototype:createListLable(idCamp)
  if nil == idCamp then
    return
  end
  if self.campLabelInfo and self.campLabelInfo.node then
    self.campLabelInfo.node:refresh(idCamp)
    return
  end
  self.campLabelInfo = self.campLabelInfo or {}
  self.campLabelInfo.idCamp = idCamp
  local node = Tw.Controller:load("BattleCopyNotice", self.rootNode)
  self.tableViewControl.tableView:addSpecialCell(node)
  self.campLabelInfo.node = node
  node:refresh(idCamp)
end
function prototype:deleteListLable()
  if self.campLabelInfo and self.campLabelInfo.node then
    self.campLabelInfo = {}
    self.tableViewControl.tableView:clearSpecialCell()
  end
end
function prototype:openNewSceneDelay(funOpen)
  if self.tableViewControl and self.tableViewControl.tableView then
    self.tableViewControl.tableView:runUIAnimat(false)
  end
  local arrAction = CCArray:create()
  arrAction:addObject(CCDelayTime:create(0.2))
  arrAction:addObject(CCCallFuncN:create(function()
    if funOpen then
      funOpen()
    end
  end))
  self.rootNode:runAction(CCSequence:create(arrAction))
end
function prototype:onOpenBattleFriend()
  if self.curStageInfo.layerType ~= LAYER_TYPE.BATTLE or Logic:Get("Battle"):GetCurSelBattleId() == nil then
    return
  end
  self:openNewSceneDelay(function()
    SceneHelper:pushScene("BattleCopyFriend")
  end)
end
function prototype:onBattleFriendSceneReturn()
  self:reOpen()
end
function prototype:reOpen()
  local hasDevil = Logic:Get("Devil"):GetHasDemog()
  if hasDevil then
    self.tableViewControl:RequireUpdateWithoutAnimat()
  else
    self.tableViewControl.tableView:runUIAnimat(true)
  end
end
function prototype:refresh(bLstNotHasMovie, isNotSceneChange)
  local function RefreshList()
    self:refreshListLable()
    if not bLstNotHasMovie then
      self.tableViewControl:RequireUpdate()
    else
      self.tableViewControl:RequireUpdateWithoutAnimat()
    end
  end
  if nil == self.tableViewControl or nil == self.tableViewControl.tableView then
    return
  end
  if not bLstNotHasMovie and not isNotSceneChange then
    self.tableViewControl.tableView:runUIAnimat(false)
  end
  self:refreshMainUI()
  local arrAction = CCArray:create()
  arrAction:addObject(CCDelayTime:create(0.2))
  arrAction:addObject(CCCallFuncN:create(function()
    RefreshList()
  end))
  if isNotSceneChange then
    RefreshList()
  else
    self.rootNode:runAction(CCSequence:create(arrAction))
  end
end
function prototype:refreshLstItems(item, idx)
  if nil == item then
    return
  end
  local data = self:getData()
  local info = {}
  info.id = data and data[idx] or nil
  info.layerType = self.curStageInfo.layerType
  info.campType = self.curStageInfo.campType
  if info.id == nil then
    item:setVisible(false)
  else
    item:setVisible(true)
    item:refresh(info)
  end
end
function prototype:clearMainUI()
  self.btnLeft:setEnabled(false)
  self.sprLeft:setVisible(false)
  self.imgBtnLeftBg:setVisible(false)
  if Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.ACTIVITY) then
    self.btnRight:setEnabled(false)
    self.sprRight:setVisible(false)
    self.imgBtnRightBg:setVisible(false)
  else
    self.sprRight:setVisible(true)
    local spr = CCSprite:create(IMG_ACTIVITY_STR)
    self.sprRight:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:setLeftBtn(bVisible, imgStr)
  self.btnLeft:setEnabled(bVisible)
  self.sprLeft:setVisible(bVisible)
  self.imgBtnLeftBg:setVisible(bVisible)
  if bVisible and imgStr then
    local sprite = CCSprite:create(imgStr)
    if sprite then
      self.sprLeft:setDisplayFrame(sprite:displayFrame())
    end
  end
end
function prototype:setRightBtn(bVisible, imgStr)
  self.btnRight:setEnabled(bVisible)
  self.sprRight:setVisible(bVisible)
  self.imgBtnRightBg:setVisible(bVisible)
  if bVisible and imgStr then
    local sprite = CCSprite:create(imgStr)
    if sprite then
      self.sprRight:setDisplayFrame(sprite:displayFrame())
    end
  end
end
function prototype:setTitle(bVisible, imgStr)
  self.sprTitle:setVisible(bVisible)
  if bVisible and imgStr then
    local sprite = CCSprite:create(imgStr)
    if sprite then
      self.sprTitle:setDisplayFrame(sprite:displayFrame())
    end
  end
end
function prototype:refreshMainUI()
  self:clearMainUI()
  if self.curStageInfo.layerType == LAYER_TYPE.CAMPAIGN then
    self:refreshCampaignUI()
  elseif self.curStageInfo.layerType == LAYER_TYPE.BATTLE then
    self:refreshBattleUI()
  end
end
function prototype:refreshCampaignUI()
  local IsVisibleHard = function()
    return not Logic:Get("Lock"):checkStatusById("EQUIP")
  end
  local curCampType = self.curStageInfo.campType
  self.curStageInfo.typeBtnLeft = curCampType == Battle.CAMPAIGN_TYPE.NORMAL and MAIN_BTN_TYPE.CAMPAIGN_HARD or MAIN_BTN_TYPE.CAMPAIGN_NORMAL
  local imgStrLeft = curCampType == Battle.CAMPAIGN_TYPE.NORMAL and IMG_HARD_STR or IMG_NORMAL_STR
  self:setLeftBtn(IsVisibleHard(), imgStrLeft)
  local imgStrTitle = curCampType == Battle.CAMPAIGN_TYPE.NORMAL and IMG_TITLE_NORMAL_STR or IMG_TITLE_HARD_STR
  self:setTitle(true, imgStrTitle)
end
function prototype:refreshBattleUI()
  local curCampType = self.curStageInfo.campType
  self:setLeftBtn(true, IMG_RETURN_STR)
  self:setRightBtn(true, IMG_REBIRTH_STR)
  self.curStageInfo.typeBtnLeft = MAIN_BTN_TYPE.RETURN_CAMPAIGN
  self.curStageInfo.typeBtnRight = MAIN_BTN_TYPE.COPY_DROP
  local imgStrTitle = curCampType == Battle.CAMPAIGN_TYPE.NORMAL and IMG_TITLE_NORMAL_STR or IMG_TITLE_HARD_STR
  self:setTitle(true, imgStrTitle)
end
function prototype:onLeftClicked(sender, event)
  if self.curStageInfo.typeBtnLeft == MAIN_BTN_TYPE.RETURN_CAMPAIGN then
    self:onChangeLayerType(LAYER_TYPE.CAMPAIGN)
  elseif self.curStageInfo.typeBtnLeft == MAIN_BTN_TYPE.CAMPAIGN_HARD then
    Logic:Get("Guide"):done("EquipElite", "SelectElite")
    Logic:Get("Guide"):done("EquipFetterTwo", "SelectElite")
    SceneHelper:runWithScene("EliteCampaign", self.rootNode)
  elseif self.curStageInfo.typeBtnLeft == MAIN_BTN_TYPE.CAMPAIGN_NORMAL then
    self:onChangeCampType(Battle.CAMPAIGN_TYPE.NORMAL)
  else
    return
  end
  self:refresh()
end
function prototype:onRightClicked(sender, event)
  if self.curStageInfo.typeBtnRight == MAIN_BTN_TYPE.COPY_DROP and self.curStageInfo.layerType == LAYER_TYPE.BATTLE then
    self:openNewSceneDelay(function()
      SceneHelper:pushScene("HonorFirstRecord")
    end)
    return
  end
  if self.curStageInfo.layerType == LAYER_TYPE.CAMPAIGN then
    Logic:Get("Battle"):setOpenActivityInBattleCopy(true)
    Logic:Get("Activity"):PostActivesMsg()
    return
  end
end
function prototype:onChangeCampType(type)
  self.curStageInfo.campType = type
end
function prototype:onChangeLayerType(type)
  self.curStageInfo.layerType = type
  Logic:Get("Battle"):SetCurSelLayerType(type)
end
function prototype:onClickItem(id, layerType)
  if layerType == LAYER_TYPE.CAMPAIGN then
    self.curStageInfo.campId = id
    Logic:Get("Battle"):SetCurSelCampaign(id)
    local bKorean = Logic:Get("System"):IsOperator("ilovewebgame")
    local bVisitor = Logic:Get("Account"):GetIsVisitorType()
    if bKorean and bVisitor and id == "CN04" then
      Prompt:Confirm(Logic:Get("Main"), "", 102217, Logic:Get("Main").GotoBindAccount, Prompt.PROMPT_TYPE.SELECT)
      return
    end
    self:onChangeLayerType(LAYER_TYPE.BATTLE)
  elseif layerType == LAYER_TYPE.BATTLE then
    self.curStageInfo.battleId = id
    Logic:Get("Battle"):SetCurSelBattleId(id)
    local continueFunc = function(self)
      if Logic:Get("Friend"):IsNeedGetNewCommendFriend() then
        return
      end
      self:openNewSceneDelay(function()
        SceneHelper:pushScene("BattleCopyFriend")
      end)
    end
    local callBack = bind(continueFunc, self)
    Logic:Get("Battle"):FireEvent(Battle.EVT.SELECT_ONE_BATTLE, id, callBack)
    return
  else
    return
  end
  self:refresh()
end
function prototype:setNextLayer(layerType)
  self:onChangeLayerType(layerType)
  self:refresh()
end
function prototype:setNextCampType(campType)
  self:onChangeCampType(campType)
  self:refresh()
end
function prototype:onInBattleEnd()
  SceneHelper:removeScene("Embattle")
  SceneHelper:removeScene("BattleCopyFriend")
end
function prototype:onBattleResultEnd()
  local IsDataChg = function()
    local lastBattleInfo = Logic:Get("Battle"):GetLastBattleCampInfo()
    if nil == lastBattleInfo or nil == lastBattleInfo.battleId or not lastBattleInfo.success then
      return false
    end
    if lastBattleInfo.bBattleFinish then
      return true
    end
    local leftTimes = Logic:Get("Battle"):GetLeftTimes(lastBattleInfo.battleId)
    if leftTimes >= 0 then
      return true
    end
    return false
  end
  if IsDataChg() then
    local hasDevil = Logic:Get("Devil"):GetHasDemog()
    if hasDevil then
      self.tableViewControl:RequireUpdateWithoutAnimat(nil, true)
    else
      self.tableViewControl:RequireUpdate()
    end
  else
    self:reOpen()
  end
end
function prototype:onCampaignComplete(idCampaign)
  self:setNextLayer(LAYER_TYPE.CAMPAIGN)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(LST_ITEM_W, LST_ITEM_H)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    self:createBattleCellItem(index + 1, cell)
  else
    local cellItem = cell:getChildByTag(CELL_TAG)
    if cellItem then
      self:refreshLstItems(cellItem, index + 1)
    end
  end
  return cell
end
function prototype:createBattleCellItem(index, cell)
  local subScene = Tw.Controller:load("BattleCopyItem", self.rootNode)
  subScene:setPosition(CCPoint((LST_W - LST_ITEM_W) / 2, 0))
  subScene:setAnchorPoint(CCPointMake(0.5, 0.5))
  cell:addChild(subScene, 0, CELL_TAG)
  self:refreshLstItems(subScene, index)
end
function prototype:numberOfCellsInTableView(curPage)
  local allNum = 0
  if LAYER_TYPE.CAMPAIGN == self.curStageInfo.layerType then
    local lstCamp = Logic:Get("Battle"):GetCampainLst(self.curStageInfo.campType)
    allNum = lstCamp and #lstCamp or 0
  elseif LAYER_TYPE.BATTLE == self.curStageInfo.layerType then
    local lstCamp = Logic:Get("Battle"):GetBattleLst(self.curStageInfo.campId)
    allNum = lstCamp and #lstCamp or 0
  end
  return allNum
end
function prototype:actionFinish(table, cell)
end
function prototype:tableCellTouched(table, cell)
end
function prototype:actionFinish(tableView)
  if not Logic:Get("Guide"):isGuiding() then
    local data = self:getData()
    if table.empty(data) then
      return
    end
    local cell = tableView:cellAtIndex(#data - 1)
    if cell == nil then
      return
    end
    local item = cell:getChildByTag(CELL_TAG)
    if item ~= nil then
      item:addGuideTip()
    end
    return
  end
  if Logic:Get("Guide"):isActive("EquipElite", "SelectElite") then
    Logic:Get("Guide"):lockTouch(self.btnLeft)
    return
  end
  if Logic:Get("Guide"):isActive("EquipFetterTwo", "SelectElite") then
    Logic:Get("Guide"):lockTouch(self.btnLeft)
    return
  end
  local data = self:getData()
  if table.empty(data) then
    return
  end
  local cell = tableView:cellAtIndex(#data - 1)
  if cell == nil then
    return
  end
  local item = cell:getChildByTag(CELL_TAG)
  if item == nil then
    return
  end
  item:updateGuide()
end
function prototype:getData()
  if self.curStageInfo.layerType == LAYER_TYPE.CAMPAIGN then
    return Logic:Get("Battle"):GetCampainLst(self.curStageInfo.campType)
  end
  if self.curStageInfo.layerType == LAYER_TYPE.BATTLE then
    return Logic:Get("Battle"):GetBattleLst(self.curStageInfo.campId)
  end
  return {}
end
function prototype:tablePageTurn(curPage)
end
function prototype:onChange()
  return 0
end
function prototype:updateGuide()
  if Logic:Get("Guide"):isActive("EquipElite", "SelectElite") then
    Logic:Get("Guide"):lockTouch(self.btnLeft)
    return
  end
  if Logic:Get("Guide"):isActive("EquipFetterTwo", "SelectElite") then
    Logic:Get("Guide"):lockTouch(self.btnLeft)
    return
  end
end
