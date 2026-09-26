module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local BTN_RESET = {
  NORMAL = "images/public/btn_small_normal.png",
  DISABLE = "images/public/btn_small_disable.png"
}
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  self.ttfEnergy:setStyle(kCCLabelTTFStyleOutline)
  self.ttfColdTime:setStyle(kCCLabelTTFStyleOutline)
  local power = Logic:Get("Hero"):GetFightingPoints()
  if power[2] and power[2] >= 0 then
    self.nodPower:create(0, "YELLOW_E_NUM")
    self.nodPower:setAlign("CENTER", "CENTER")
    self.nodPower:setValue(power[2])
  end
  Logic:Get("Pvp"):On(Logic.Pvp.EVT.GET_PVP_INFO, self:Event("onGetPvpInfo"))
  Logic:Get("Pvp"):On(Logic.Pvp.EVT.SKIP_PVP, self:Event("onSkipPvp"))
  Logic:Get("Pvp"):On(Logic.Pvp.EVT.CLEAR_COOL_DOWN, self:Event("onClearCoolDown"))
  Logic:Get("Devil"):On(Logic.Devil.EVT.BUY_SUCCESSED, self:Event("onBuySuccessed"))
  Logic:Get("Devil"):On(Logic.Devil.EVT.UPDATE_ENERGY, self:Event("updateColdTime"))
  self.data = {}
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pFList, 1)
  self.tableViewControl:RequireUpdate()
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.m_pFList:addChild(self.tableViewControl.tableView)
  Logic:Get("Pvp"):PostGetPvpInfo()
end
function prototype:onExit()
  Logic:Get("Pvp"):SetIsPvp(false)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnBackClicked(sender, event)
  SceneHelper:runWithScene("Home", self.rootNode)
end
function prototype:onBtnRewardsClicked(sender, event)
  Logic:Get("Pvp"):SetRankType(Logic.Pvp.RANK_TYPE.RANK_REWARD)
  SceneHelper:runWithScene("PvpRank", self.rootNode)
end
function prototype:onBtnReset(sender, event)
  local coldTime = Logic:Get("Pvp"):GetColdTime()
  local diffTime = Logic:Get("System"):DiffTime(coldTime)
  if diffTime > 0 then
    local cost = Logic:Get("Pvp"):GetResetCost()
    local text = TwGetStr(105870) .. "\n" .. TwGetStr(105805, cost or 0)
    Prompt:Confirm(self, "", text, self.onConfirmBuy, Prompt.PROMPT_TYPE.SELECT)
    return
  end
end
function prototype:onBuyClicked(sender, event)
  local leaveBuyTime = Logic:Get("Devil"):GetLeaveBuyTimes()
  if leaveBuyTime <= 0 then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    local str = TwGetStr(10078) .. "\n" .. TwGetStr(105321)
    Prompt:Confirm(Logic:Get("Main"), "", str, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  SceneHelper:pushPrompt("DevilBuyTip", self.rootNode)
end
function prototype:onGetPvpInfo()
  local bAttacked = Logic:Get("Pvp"):IsAttacked()
  if bAttacked then
    Logic:Get("Pvp"):SetAttacked(false)
    SceneHelper:runWithScene("PvpRecord", self.rootNode)
    return
  end
  local matchList = Logic:Get("Pvp"):GetMatchList()
  self.data = matchList
  self.tableViewControl:RequireUpdate()
  self:updateColdTime()
end
function prototype:onClearCoolDown()
  self:updateColdTime()
end
function prototype:onSkipPvp()
  SceneHelper:removeScene("FightResult")
  SceneHelper:pushScene("FightResult", nil, self.mainScene)
end
function prototype:onBuySuccessed()
  self:updateColdTime()
end
function prototype:onConfirmBuy()
  local cost = Logic:Get("Pvp"):GetResetCost()
  local playerMoney = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if playerMoney and cost <= playerMoney then
    MsgPvp:Post("CLEAR_COOL_DOWN")
    return
  end
  Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
  Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 120)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("PvpMainItem", self.rootNode)
    subScene:ReFrashFighterInfo(self.data[index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):ReFrashFighterInfo(self.data[index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.data and not table.empty(self.data) then
    return #self.data
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
function prototype:updateColdTime()
  local energy = Logic:Get("Devil"):GetEnergy() or {}
  local maxEnergy = Logic:Get("Devil"):GetMaxEnergy()
  self.ttfEnergy:setString(string.format("%d/%d", energy.point or 0, maxEnergy))
  local spr
  local coldTime = Logic:Get("Pvp"):GetColdTime()
  local diffTime = Logic:Get("System"):DiffTime(coldTime)
  if diffTime > 0 then
    local waitTime = Logic:Get("System"):GetTimeDate(diffTime) or {}
    self.ttfColdTime:setString(string.format("%02d:%02d", waitTime.min or 0, waitTime.sec or 0))
    spr = CCSprite:create(BTN_RESET.NORMAL)
    if spr then
      self.sprResetBg:setDisplayFrame(spr:displayFrame())
    end
    return
  end
  spr = CCSprite:create(BTN_RESET.DISABLE)
  if spr then
    self.sprResetBg:setDisplayFrame(spr:displayFrame())
  end
  self.ttfColdTime:setString("")
end
