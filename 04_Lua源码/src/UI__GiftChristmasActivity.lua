module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("Logic.Compose")
require("BtnPosition")
require("Logic.SureConfirm")
prototype = BtnPosition.prototype:extend()
GOLD_REFRASH_PATH = "images/Christmas/glod_refrash.png"
REFRASH_TIME_PATH = "images/Christmas/refrash_time.png"
function prototype:onEnter()
  super.onEnter(self)
  Logic:Get("ChristmasActivity"):On(Logic.ChristmasActivity.EVT.REFRASH_UI, self:Event("refrashTaskTTF"))
  Logic:Get("ChristmasActivity"):On(Logic.ChristmasActivity.EVT.REFRASH_LIST, self:Event("refrashList"))
  Logic:Get("ChristmasActivity"):On(Logic.ChristmasActivity.EVT.CLEAR_COOL_TIME, self:Event("onClearCoolTime"))
  Logic:Get("ChristmasActivity"):On(Logic.ChristmasActivity.EVT.REFRASH_PROGRESS, self:Event("refreshProgress"))
  Logic:Get("Mall"):On(Logic.Mall.EVT.GET_LOTTERY_LIST, self:Event("onGetMallList"))
  self:setOutline()
  self:setTitle()
  self:setRewardVisible(true)
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.title_ttf:setColor(ccc3(255, 183, 18))
  self.title_ttf:setString(giftInfo.name)
  self.title_ttf:setStyle(kCCLabelTTFStyleOutline)
  self.reFrashTime:setString("")
  self:createList()
  self:refreshColdDown()
  if not self.eventTracer:Exist("refreshColdDown") then
    local repeatTime = 1000
    Singleton(Timer):Repeat(repeatTime, self:Event("refreshColdDown"))
  end
  if Logic:Get("Lock"):checkStatusById("TASK_COST_REFRESH") then
    self.nodAdvFresh:setVisible(false)
  end
end
function prototype:setRewardVisible(flag)
  self.sprRight:setVisible(flag)
  self.imgBtnRightBg:setVisible(flag)
  self.btnCheckReward:setEnabled(flag)
end
function prototype:setOutline()
  local ttfList = {
    "taskTime",
    "reFrashTime"
  }
  for i = 1, #ttfList do
    self[ttfList[i]]:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  end
end
function prototype:setTitle()
  local taskTimes = Logic:Get("ChristmasActivity"):getTotalTaskNum()
  self.taskTime:setString(TwGetStr(106202, taskTimes))
end
function sortFunc(curId, nextId)
  local curInfo = KFDBGetRecord("TaskSetting", curId)
  local nextInfo = KFDBGetRecord("TaskSetting", nextId)
  if curInfo.sort == nil or nextInfo.sort == nil then
    return false
  end
  return curInfo.sort > nextInfo.sort
end
function prototype:sortList(totalHerosId)
  table.sort(totalHerosId, sortFunc)
  return totalHerosId
end
function prototype:getListData()
  local result = {}
  result = Logic:Get("ChristmasActivity"):getTaskList()
  result = self:sortList(result)
  return result
end
function prototype:createList()
  self.titleinfo = self:getListData()
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pCList, 1)
  self.tableViewControl:RequireUpdate()
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.m_pCList:addChild(self.tableViewControl.tableView)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ChristmasItem", self.rootNode)
    subScene:reFrashInfo(self.titleinfo[index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):reFrashInfo(self.titleinfo[index + 1])
  end
  return cell
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(588, 164)
end
function prototype:numberOfCellsInTableView(curPage)
  return #self.titleinfo
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:refrashList()
  self:refrashTaskTTF()
  self.tableViewControl:RequireUpdate()
end
function prototype:refrashUI()
  self.titleinfo = self:getListData()
  self.tableViewControl:RequireUpdate()
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("GiftActivityList", nil)
end
function prototype:onBtnCheckReward(sender, event)
  MsgPlayer:Post("GET_LOTTERY_LIST")
end
function prototype:getCostGoldByBuyTask()
  local buyTime = Logic:Get("ChristmasActivity"):getBuyTaskTimes()
  local info = KFDBGetRecord("ComTimesCost", buyTime)
  if info == nil then
    return 0
  end
  return info.cost
end
function prototype:getCostGoldByRefrash()
  local refrashTime = Logic:Get("ChristmasActivity"):getRefrashTime()
  local info = KFDBGetRecord("BuyReTimesCost", refrashTime)
  if info == nil then
    local info = KFDBGetRecord("ConfigValue", "CHRISTMAS:MAX_REFRESH_TIMES_COST")
    local costNum = info == nil and 100 or tonumber(info.content)
    return costNum
  end
  return info.cost
end
function prototype:refrashTaskTTF()
  local taskTimes = Logic:Get("ChristmasActivity"):getTotalTaskNum()
  self.taskTime:setString(TwGetStr(106202, taskTimes))
end
function prototype:onBtnBuy(sender, event)
  local buyTimes = Logic:Get("ChristmasActivity"):getBuyTaskTimes()
  local maxBuyTimes = Logic:Get("Box"):GetMaxOpenTime("TASK_MAX_COMPLETE_TIMES")
  local costNum = Logic:Get("ChristmasActivity"):GetTaskCost()
  if buyTimes >= maxBuyTimes then
    Prompt:Tip(TwGetStr(106247))
    return
  end
  local times = maxBuyTimes - buyTimes
  Prompt:Confirm(self, nil, TwGetStr(106205, costNum, times), self.onConfirmTask, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onBtnReFrash(sender, event)
  local totalTaskNum = Logic:Get("ChristmasActivity"):getTotalTaskNum()
  local buyTimes = Logic:Get("ChristmasActivity"):getBuyTaskTimes()
  local maxBuyTimes = Logic:Get("Box"):GetMaxOpenTime("TASK_MAX_COMPLETE_TIMES")
  if totalTaskNum == 0 and buyTimes >= maxBuyTimes then
    Prompt:Confirm(self, nil, TwGetStr(106249), self.callBackBtnReFrash, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  self:callBackBtnReFrash()
end
function prototype:callBackBtnReFrash()
  local flagReveice = Logic:Get("ChristmasActivity"):IsHaveReceivedTask()
  if flagReveice or self:IsHaveDirectGetRewardTask() then
    Prompt:Confirm(self, nil, TwGetStr(106244), self.fun1, Prompt.PROMPT_TYPE.SELECT)
    return
  elseif self:IsHaveFiveRankTask() then
    Prompt:Confirm(self, nil, TwGetStr(106245), self.fun1, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  self:fun1()
end
function prototype:fun1()
  if Logic:Get("ChristmasActivity"):CanFreeFresh() then
    Logic:Get("ChristmasActivity"):PostFreeRefrashActivityMsg()
    return
  end
  local cost = Logic:Get("Egg"):GetCongifValueByKey("CHRISTMAS:CLEAR_COOLTIME_COST")
  local logic = Logic:Get("ChristmasActivity")
  local coldDown = Logic:Get("ChristmasActivity"):GetCoolTime()
  local diffTime = Logic:Get("System"):DiffTime(coldDown / 1000)
  local min = math.ceil(diffTime / 60)
  self.cost = math.ceil(cost * min)
  Prompt:Confirm(self, nil, TwGetStr(105307, self.cost), self.onConfirmReset, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onConfirmReset()
  local costNum = self.cost
  local totalCharge = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if costNum > totalCharge then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Logic:Get("ChristmasActivity"):PostClearCoolTime(costNum)
end
function prototype:onBtnAdvanRefrash(sender, event)
  local totalTaskNum = Logic:Get("ChristmasActivity"):getTotalTaskNum()
  local buyTimes = Logic:Get("ChristmasActivity"):getBuyTaskTimes()
  local maxBuyTimes = Logic:Get("Box"):GetMaxOpenTime("TASK_MAX_COMPLETE_TIMES")
  if totalTaskNum == 0 and buyTimes >= maxBuyTimes then
    Prompt:Confirm(self, nil, TwGetStr(106249), self.callBackBtnAdvanRefrash, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  self:callBackBtnAdvanRefrash()
end
function prototype:callBackBtnAdvanRefrash()
  local flagReveice = Logic:Get("ChristmasActivity"):IsHaveReceivedTask()
  if flagReveice or self:IsHaveDirectGetRewardTask() then
    Prompt:Confirm(self, nil, TwGetStr(106244), self.fun2, Prompt.PROMPT_TYPE.SELECT)
    return
  elseif self:IsHaveFiveRankTask() then
    Prompt:Confirm(self, nil, TwGetStr(106245), self.fun2, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  self:fun2()
end
function prototype:fun2()
  local info = KFDBGetRecord("ConfigValue", "CHRISTMAS:ADVANCED_REFRESH_COST")
  local costNum = info == nil and 1000 or tonumber(info.content)
  Prompt:ConfirmRecord(self, nil, TwGetStr(106240, costNum), self.onConfirmAdvanRefrash, Prompt.PROMPT_TYPE.SELECT, nil, Logic.SureConfirm.RECORD_TYPE.CHRIST_ADV_REFRESH)
end
function prototype:onConfirmTask()
  local costNum = Logic:Get("ChristmasActivity"):GetTaskCost()
  local totalCharge = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if costNum > totalCharge then
    Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  Logic:Get("ChristmasActivity"):PostBuyTaskMsg(costNum)
end
function prototype:onConfirmAdvanRefrash()
  local info = KFDBGetRecord("ConfigValue", "CHRISTMAS:ADVANCED_REFRESH_COST")
  local costNum = info == nil and 0 or tonumber(info.content)
  local totalCharge = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if costNum > totalCharge then
    Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  Logic:Get("ChristmasActivity"):PostAdvancedRefrashActivityMsg()
end
function prototype:IsHaveFiveRankTask()
  local result = false
  for i = 1, #self.titleinfo do
    local info = KFDBGetRecord("TaskSetting", self.titleinfo[i])
    if nil ~= info and info.star == 5 then
      return true
    end
  end
  return result
end
function prototype:IsCanDirectGetReward(id)
  self.info = KFDBGetRecord("TaskSetting", id)
  if self.info == nil then
    return false
  end
  local proNum = Logic:Get("ChristmasActivity"):getTargetValuesById(self.info.targetType)
  if proNum >= self.info.target or self:IsInCanDirectGetReward(id) then
    return true
  end
  return false
end
function prototype:IsInCanDirectGetReward(id)
  local canDirectGetRewardList = Logic:Get("ChristmasActivity"):getCanDirectGetRewardTasks()
  for i = 1, #canDirectGetRewardList do
    if id == canDirectGetRewardList[i] then
      return true
    end
  end
  return false
end
function prototype:IsHaveDirectGetRewardTask()
  local result = false
  for i = 1, #self.titleinfo do
    if self:IsCanDirectGetReward(self.titleinfo[i]) then
      return true
    end
  end
  return result
end
function prototype:refreshColdDown()
  local coldDown = Logic:Get("ChristmasActivity"):GetCoolTime()
  local diffTime = Logic:Get("System"):DiffTime(coldDown / 1000)
  local coldState = Logic:Get("ChristmasActivity"):GetCoolState()
  local color = coldState and ccc3(255, 0, 0) or ccc3(255, 255, 255)
  self.reFrashTime:setColor(color)
  if diffTime > 0 then
    local waitTime = Logic:Get("System"):SecToDay(diffTime) or {}
    self.reFrashTime:setString(string.format("%02d:%02d:%02d", waitTime.hour or 0, waitTime.min or 0, waitTime.sec or 0))
    return
  end
  self.reFrashTime:setString("-")
end
function prototype:onClearCoolTime()
  self:refreshColdDown()
end
function prototype:refreshProgress()
  self:refrashTaskTTF()
  self.titleinfo = self:getListData()
  self.tableViewControl:RequireUpdateWithoutAnimat()
end
function prototype:onGetMallList()
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  Logic:Get("Mall"):initItemData()
  local data = Logic:Get("Mall"):GetTabData()
  local tokenCoinData
  for _, v in pairs(data) do
    if v.id == giftInfo.mallId then
      tokenCoinData = v
      break
    end
  end
  if tokenCoinData then
    Logic:Get("Mall"):SetTokenCoinData(tokenCoinData)
    SceneHelper:pushScene("MallExchange", self.rootNode)
    return
  end
  Prompt:Fail(TwGetStr(105285))
end
