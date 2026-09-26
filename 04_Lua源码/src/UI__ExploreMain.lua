require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  super.onEnter(self)
  self.ttfCost:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTime:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTip:setStyle(kCCLabelTTFStyleOutline)
  self.ttfProgress:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLeftComTime:setStyle(kCCLabelTTFStyleOutline)
  self.ttfGuideName:setStyle(kCCLabelTTFStyleOutline)
  self.data = {}
  self.info = {}
  self.tableViewControl = TableViewEx.prototype:createList(self, self.nodList, 1)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.nodList:addChild(self.tableViewControl.tableView)
  self.nodBuyExp:setVisible(false)
  self.nodUpgrade:setVisible(false)
  self.bshowTips = false
  self.labJade:create(0, "GREEN_NUM")
  self.labJade:setAlign("LEFT", "CENTER")
  self:refreshJade()
  Logic:Get("Explore"):postLoadExploreInfo()
  Logic:Get("Explore"):On(Logic.Explore.EVT.LOAD_EXPLORE_INFO, self:Event("onLoadExploreInfo"))
  Logic:Get("Explore"):On(Logic.Explore.EVT.EXECUTE_TASK, self:Event("onExecuteTask"))
  Logic:Get("Explore"):On(Logic.Explore.EVT.IMMEDIATE_FINISH, self:Event("onImmediateFinish"))
  Logic:Get("Explore"):On(Logic.Explore.EVT.COST_REFRESH_RELEASE, self:Event("onCostRefreshRelease"))
  Logic:Get("Explore"):On(Logic.Explore.EVT.UP_NPC_LEVEL, self:Event("onUpNpcLevel"))
  Logic:Get("Explore"):On(Logic.Explore.EVT.BUY_NPC_EXP, self:Event("onBuyNpcExp"))
end
function prototype:onBtnCover(sender, event)
end
function prototype:onBtnBg(sender, event)
end
function prototype:onBtnCover(sender, event)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnPresent(sender, event)
  SceneHelper:pushScene("ExploreShow", self.rootNode)
end
function prototype:onBtnUpgrade(sender, event)
  local rec = KFDBGetRecord("NPCLevelConfig", self.info.level)
  if table.empty(rec or {}) then
    return
  end
  if self.info.exp < rec.exp then
    Prompt:Fail(115225)
    return
  end
  local maxNpcLv = KFDBGetRecordAmt("NPCLevelConfig")
  if maxNpcLv <= self.info.level then
    Prompt:Fail(115224)
    return
  end
  local logic = Logic:Get("Explore")
  Prompt:Confirm(logic, "", TwGetStr(115232), logic.postUpNpcLevel, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onBtnBuyExp(sender, event)
  local maxNpcLv = KFDBGetRecordAmt("NPCLevelConfig")
  local cost = Logic:Get("Egg"):GetCongifValueByKey("EXPLORE:BUY_EXP_COST_BASE")
  local rec = KFDBGetRecord("NPCLevelConfig", self.info.level) or {}
  if self.info.exp >= rec.exp then
    if maxNpcLv <= self.info.level then
      Prompt:Fail(115219)
      return
    end
    Prompt:Fail(115220)
    return
  end
  SceneHelper:pushPrompt("ExploreBuyExp", self.rootNode)
end
function prototype:onBtnRefresh(sender, event)
  local cost = self:getRefreshCost()
  if not Logic:Get("PlayerInfo"):IsMoneyEnough(cost) then
    Logic:Get("Main"):PromptCharge()
    return
  end
  local logic = Logic:Get("Explore")
  Prompt:Confirm(logic, "", TwGetStr(115227, cost), logic.postCostRefreshRelease, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onBtnTaskList(sender, event)
  if table.empty(self.info or {}) then
    return
  end
  self.type = "RELEASES"
  self.data = self.info.releases or {}
  self:changeBtnBg()
  self:showRefreshTime()
  self.tableViewControl:RequireUpdate()
end
function prototype:getRefreshCost()
  if table.empty(self.info or {}) then
    return 0
  end
  local rec = KFDBGetRecord("ConfigValue", "EXPLORE:REFRESH_COSTS") or {}
  local costs = json.decode(rec.content or "[]")
  local idx = self.info.costRefreshTimes + 1
  if idx > #costs then
    idx = #costs or idx
  end
  return costs[idx] or 0
end
function prototype:onBtnAcceptList(sender, event)
  if table.empty(self.info or {}) then
    return
  end
  self.type = "EXECUTES"
  self.data = self.info.executes or {}
  table.sort(self.data, function(a, b)
    return a.endAt < b.endAt
  end)
  self:changeBtnBg()
  self:showRefreshTime()
  self.tableViewControl:RequireUpdate()
end
function prototype:onLoadExploreInfo()
  self.info = Logic:Get("Explore"):GetExploreVo()
  self.data = self.info.releases or {}
  self.type = "RELEASES"
  self.tableViewControl:RequireUpdate()
  local cost = self:getRefreshCost()
  self.ttfCost:setString(cost)
  self:refreshNpcInfo()
  self:showRefreshTime()
  self:refreshCompleteTimes()
  self:RefreshTime()
  if not self.eventTracer:Exist("RefreshTime") then
    Singleton(Timer):Repeat(1000, self:Event("RefreshTime"))
  end
end
function prototype:refreshCompleteTimes()
  local key = "EXPLORE:COST_FINISH_TIMES_LIMIT"
  local maxComplete = Logic:Get("Egg"):GetCongifValueByKey(key)
  local leftComTime = maxComplete - self.info.costFinishTimes
  self.ttfLeftComTime:setString(leftComTime)
end
function prototype:changeBtnBg()
  local leftNormal = "images/Explore/btnLeftNormal.png"
  local leftSelect = "images/Explore/btnLeftSelected.png"
  local rightNormal = "images/Explore/btnRightNormal.png"
  local rightSelect = "images/Explore/btnRightSelected.png"
  local leftPath = self.type == "RELEASES" and leftSelect or leftNormal
  local rightPath = self.type == "EXECUTES" and rightSelect or rightNormal
  local spr = CCSprite:create(leftPath)
  if spr then
    self.sprBtnLeft:setDisplayFrame(spr:displayFrame())
  end
  spr = CCSprite:create(rightPath)
  if spr then
    self.sprBtnRight:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:showRefreshTime()
  self.nodRefresh:setVisible(self.type ~= "EXECUTES")
  self.nodExecute:setVisible(self.type == "EXECUTES")
end
function prototype:refreshNpcInfo()
  local rec = KFDBGetRecord("NPCLevelConfig", self.info.level)
  if table.empty(rec or {}) then
    return
  end
  self.ttfTip:setString(rec.nextCondition)
  local bg = "images/Explore/proBg.png"
  local progress = "images/Explore/proUpside.png"
  self.nodExp:createProgress(bg, progress)
  local prc = math.floor(self.info.exp * 100 / rec.exp)
  self.nodExp:setValue(prc)
  self.ttfProgress:setString(self.info.exp .. "/" .. rec.exp)
  self.labNpcLv:create(self.info.level, "YELLOW_E_NUM")
  self.labNpcLv:setAlign("LEFT", "CENTER")
  self.ttfGuideName:setString(rec.guideName or "")
  local maxNpcLv = KFDBGetRecordAmt("NPCLevelConfig")
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  local chargeRecord = KFDBGetRecord("Charge2Times", 405) or {}
  local chargeEnough = wallet.totalCharge >= (chargeRecord.chargeAmount or 0)
  local bMaxValue = maxNpcLv <= self.info.level
  self.nodBuyExp:setVisible(chargeEnough and not bMaxValue)
  self.nodUpgrade:setVisible(not bMaxValue)
end
function prototype:onCostRefreshRelease()
  self:onLoadExploreInfo()
  self:refreshJade()
end
function prototype:onExecuteTask()
  self:onBtnAcceptList()
end
function prototype:onImmediateFinish()
  self:onBtnAcceptList()
  self:refreshCompleteTimes()
  self:refreshNpcInfo()
  self:refreshJade()
  SceneHelper:pushPrompt("ExplorePrompt", self.rootNode)
end
function prototype:onUpNpcLevel()
  self:onLoadExploreInfo()
  self:refreshJade()
end
function prototype:onBuyNpcExp()
  self.info = Logic:Get("Explore"):GetExploreVo()
  self:refreshNpcInfo()
  self:refreshJade()
end
function prototype:refreshJade()
  local jade = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  self.labJade:setValue(jade)
end
function prototype:RefreshTime()
  if self.type == "EXECUTES" then
    self.tableViewControl:RequireUpdateWithoutAnimat()
  end
  self.ttfTime:setString("")
  local refreshTime = self.info.nextRefresh
  if refreshTime then
    local diffTime = Logic:Get("System"):DiffTime(refreshTime / 1000)
    local countDown = Logic:Get("System"):SecToDay(diffTime)
    if diffTime > 0 then
      countDown.hour = countDown.hour + countDown.day * 24
      local str = TwGetStr(102008, countDown.hour or 0, countDown.min or 0, countDown.sec or 0)
      self.ttfTime:setString(str)
      return
    end
    self.ttfTime:setString("-")
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 121)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local tag = 2
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ExploreMainItem", self.rootNode)
    cell:addChild(subScene, 0, tag)
  end
  cell:getChildByTag(tag):Refresh(self.data[index + 1], self.type, index + 1)
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if table.empty(self.data or {}) then
    return 0
  end
  return #self.data
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
