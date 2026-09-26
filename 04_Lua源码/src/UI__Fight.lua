module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local SEC_SCALE = 1000
function prototype:initialize(...)
  super.initialize(self, ...)
  local fdbRecord = KFDBGetRecord("ConfigValue", "ARENA:REFRESH_ADD_TIME")
  self.addTime = fdbRecord and tonumber(fdbRecord.content) * 60 or 0
  fdbRecord = KFDBGetRecord("ConfigValue", "ARENA:REFRESH_COOL_TIME")
  self.maxFreshTime = fdbRecord and tonumber(fdbRecord.content) * 60 or 0
  fdbRecord = KFDBGetRecord("ConfigValue", "ARENA:COOL_TIME_COST")
  self.coolTimeCost = fdbRecord and fdbRecord.content or 0
  self.currTime = 0
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  self:showRefreshTime(false)
  self.ttfRank:setStyle(kCCLabelTTFStyleOutline)
  self.ttfIntegral:setStyle(kCCLabelTTFStyleOutline)
  Logic:Get("Fight"):On(Logic.Fight.EVT.UPDATE_FIGHT_INFO, self:Event("updateFightInfo"))
  Logic:Get("Fight"):On(Logic.Fight.EVT.UPDATE_FIGHT_TIMES, self:Event("updateFightTimes"))
  Logic:Get("Fight"):On(Logic.Fight.EVT.UPDATE_REFRESH_TIME, self:Event("showPhyWaitTime"))
  Logic:Get("Fight"):On(Logic.Fight.EVT.ENTER_REWARD_STORE, self:Event("enterRewardStore"))
  Logic:Get("Fight"):On(Logic.Fight.EVT.SKIP_FIGHT, self:Event("onSkipFight"))
  Logic:Get("Gift"):On(Logic.Gift.EVT.REFRESH_TIP, self:Event("RewardTip"))
  Logic:Get("Fight"):On(Logic.Fight.EVT.GET_REWARDS, self:Event("HasReward"))
  Logic:Get("Guide"):On(Logic.Guide.EVT.STEP, self:Event("updateGuide"))
  self.data = {}
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pFList, 1)
  self.tableViewControl:RequireUpdate()
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.m_pFList:addChild(self.tableViewControl.tableView)
  self:updateGuide()
  local matchList = Logic:Get("Fight"):GetMatchList()
  if matchList == nil or table.empty(matchList) or Logic:Get("Fight"):isOpenDiffDay() or not Logic:Get("Guide"):isGuiding() and Logic:Get("Fight"):isLevelChanged() then
    MsgArena:Post("MATCH_LIST")
  else
    self:updateFightInfo()
    self:showPhyWaitTime()
  end
end
function prototype:onExit()
  Logic:Get("Fight"):isClickStore(false)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnRewardsClicked(node, loader)
  Logic:Get("Guide"):done("FightDrawGift", "ClickReward")
  SceneHelper:runWithScene("FightExchange", self.rootNode)
end
function prototype:onBtnRefreshClicked(node, loader)
  local lostTime = Logic:Get("Fight"):GetLostTime()
  local min = math.ceil(lostTime / 60)
  if lostTime >= self.maxFreshTime then
    local actCost = self.coolTimeCost * min
    local text = TwGetStr(105307, actCost)
    Prompt:Confirm(self, "", text, self.onConfirmBuy, Prompt.PROMPT_TYPE.SELECT)
  else
    local flagColdDown = Logic:Get("Fight"):isColdDown()
    if flagColdDown and lostTime > 0 then
      local actCost = self.coolTimeCost * min
      local text = TwGetStr(105307, actCost)
      Prompt:Confirm(self, "", text, self.onConfirmBuy, Prompt.PROMPT_TYPE.SELECT)
    else
      MsgArena:Post("MANUAL_REFRESH_LIST")
    end
  end
end
function prototype:onBuyClicked(node, loader)
  local buyTimes = Logic:Get("Fight"):GetLeaveBuyTimes()
  if buyTimes > 0 then
    SceneHelper:pushPrompt("FightPvpTip", self.rootNode)
  else
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    local str = TwGetStr(10078) .. "\n" .. TwGetStr(105321)
    Prompt:Confirm(Logic:Get("Main"), "", str, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
  end
end
function prototype:onBtnBackClicked(node, loader)
  SceneHelper:runWithScene("Home", self.rootNode)
end
function prototype:onSkipFight()
  SceneHelper:removeScene("FightResult")
  SceneHelper:pushScene("FightResult", nil, self.mainScene)
end
function prototype:onConfirmBuy()
  local lostTime = Logic:Get("Fight"):GetLostTime()
  local min = math.ceil(lostTime / 60)
  local actCost = self.coolTimeCost * min
  local playerMoney = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if playerMoney then
    if actCost <= playerMoney then
      MsgArena:Post("CLEAR_COOL_TIME")
    else
      Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
      Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    end
  end
end
function prototype:updateFightInfo()
  self:updateFightTimes()
  local fightPoints = Logic:Get("Fight"):GetTotalIntegral()
  self.ttfIntegral:setString(fightPoints)
  local power = Logic:Get("Hero"):GetFightingPoints()
  if power[2] and power[2] >= 0 then
    self.nodPower:create(0, "YELLOW_E_NUM")
    self.nodPower:setAlign("CENTER", "CENTER")
    self.nodPower:setValue(power[2])
  end
  self.fightInfo = Logic:Get("Fight"):GetMatchList()
  self.data = {
    self.fightInfo
  }
  self.tableViewControl:RequireUpdate()
end
function prototype:updateFightTimes()
  local fightTimes = Logic:Get("Fight"):GetFightTimes()
  self.ttfRank:setString(fightTimes)
end
function prototype:enterRewardStore()
  SceneHelper:runWithScene("FightPvpGift", self.rootNode)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 160)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("FightPvpNode", self.rootNode)
    subScene:ReFrashFighterInfo(self.fightInfo[index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):ReFrashFighterInfo(self.fightInfo[index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.data and self.data[curPage] and next(self.data[curPage]) ~= nil then
    return #self.data[curPage]
  else
    return 0
  end
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:showPhyWaitTime()
  local lostTime = Logic:Get("Fight"):GetLostTime()
  local waitTime = Logic:Get("System"):SecToDay(lostTime) or {}
  local isColdDown = Logic:Get("Fight"):isColdDown()
  if isColdDown then
    self.ttfTime:setColor(ccColor3B(255, 0, 0))
  else
    self.ttfTime:setColor(ccColor3B(255, 255, 255))
  end
  if lostTime > 0 then
    self:showRefreshTime(true)
  else
    self:showRefreshTime(false)
  end
  self.ttfTime:setString(string.format("%02d:%02d:%02d", waitTime.hour or 0, waitTime.min or 0, waitTime.sec or 0))
end
function prototype:showRefreshTime(isShow)
  if isShow == nil then
    return
  end
  self.sprRefreshTime:setVisible(isShow)
  self.ttfTime:setVisible(isShow)
end
function prototype:showRewardTip()
  local ccSprite = CCSprite:create("images/public/tip.png")
  self.layer:addChild(ccSprite, 0, 10)
  ccSprite:setAnchorPoint(CCPoint(0.5, 0.5))
  local x = self.btnRewards:getPositionX() + self.btnRewards:getContentSize().width * 0.4
  local y = self.btnRewards:getPositionY() + self.btnRewards:getContentSize().height * 0.5
  ccSprite:setPosition(x, y)
  ccSprite:setScale(1)
  self.ani = Logic:Get("AniMgr"):RunCCBAni("UI/uinew", self, ccp(x, y), 1)
end
function prototype:RewardTip()
  local boolean = Logic:Get("Fight"):IsInitDraw()
  if boolean then
    local tip = self.layer:getChildByTag(10)
    if tip == nil then
      self:showRewardTip()
    end
  else
    if self.ani ~= nil then
      self.ani:RemoveAnimation()
    end
    self.layer:removeChildByTag(10, true)
  end
end
function prototype:HasReward()
  self:RewardTip()
end
function prototype:actionFinish(tableView)
  if not Logic:Get("Guide"):isGuiding() then
    return
  end
  local idx = self:getTableViewOffset()
  if idx == nil then
    return
  end
  local cell = tableView:cellAtIndex(idx - 1)
  if cell == nil then
    return
  end
  local item = cell:getChildByTag(2)
  if item == nil then
    return
  end
  item:updateGuide()
end
function prototype:getTableViewOffset()
  return 1
end
function prototype:updateGuide()
  local logicGuide = Logic:Get("Guide")
  if logicGuide:isActive("FightDrawGift", "Start") then
    logicGuide:done("FightDrawGift", "Start")
  end
  if logicGuide:isActive("FightDrawGift", "ClickReward") then
    logicGuide:lockTouch(self.btnRewards)
  end
end
