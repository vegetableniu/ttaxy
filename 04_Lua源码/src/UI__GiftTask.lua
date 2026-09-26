module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  self.ttfMyFeats:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTimes:setStyle(kCCLabelTTFStyleOutline)
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.ttfTitle:setString(giftInfo.name)
  self.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  local FEAT_BG_PATH = "images/Devil/progress_energyBg.png"
  local FEAT_PATH = "images/Devil/progress_energy.png"
  self.nodProgress:createProgress(FEAT_BG_PATH, FEAT_PATH)
  self.nodProgress:setValue(0)
  self.data = {}
  self.tableViewControl = TableViewEx.prototype:createList(self, self.nodList, 1)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.nodList:addChild(self.tableViewControl.tableView)
  Logic:Get("GodReward"):On(Logic.GodReward.EVT.GET_INFO, self:Event("onGetInfo"))
  Logic:Get("GodReward"):PostGetInfo()
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnReward(sender, event)
  SceneHelper:runWithScene("GiftTaskShow", self.rootNode)
end
function prototype:onBtnReFrash(sender, event)
  local progress = Logic:Get("GodReward"):GetProgress()
  for id, v in pairs(progress) do
    local rec = KFDBGetRecord("GodTaskSetting", id)
    if progress[id] and progress[id] >= rec.target then
      Prompt:Fail(TwGetStr(110903))
      return
    end
  end
  if not table.empty(progress) then
    Prompt:Confirm(self, "", 110912, self.onConfirmRefresh, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  self:onConfirmRefresh()
end
function prototype:onConfirmRefresh()
  local maxTimes = Logic:Get("Egg"):GetCongifValueByKey("GODREWARD:FREE_REFRESH_LIMIT")
  local currTimes = Logic:Get("GodReward"):GetFreeTimes()
  if maxTimes <= currTimes then
    Prompt:Fail(TwGetStr(110901))
    return
  end
  Logic:Get("GodReward"):PostRefreshTask()
end
function prototype:onGetInfo()
  local maxTimes = Logic:Get("Egg"):GetCongifValueByKey("GODREWARD:FREE_REFRESH_LIMIT")
  local currTimes = Logic:Get("GodReward"):GetFreeTimes()
  local leftTimes = maxTimes <= currTimes and 0 or maxTimes - currTimes
  self.ttfTimes:setString(leftTimes)
  self:featProgress()
  self:createListData()
end
function prototype:featProgress()
  local feats = Logic:Get("GodReward"):GetFeats()
  self.ttfMyFeats:setString(feats)
  local rewardList = Logic:Get("GodReward"):GetRewardFeats()
  local MAX_REC_CNT = KFDBGetRecordAmt("GodFeatSetting")
  local idx = self:GetFeatRewardIdx()
  if idx == math.floor(MAX_REC_CNT / 4) then
    idx = idx - 1 or idx
  end
  local dataTab = {}
  local MAX_CCB = 5
  for i = 1, MAX_CCB do
    local id = i ~= MAX_CCB and idx * 4 + i or MAX_REC_CNT
    local rec = KFDBGetRecordByIdx("GodFeatSetting", id)
    if rec then
      table.insert(dataTab, rec)
    end
  end
  table.sort(dataTab, function(a, b)
    return a.feats < b.feats
  end)
  local rec = KFDBGetRecordByIdx("GodFeatSetting", idx * 4)
  local minFeats = rec and rec.feats or 0
  local maxFeats = (dataTab[#dataTab - 1].feats - minFeats) / 0.8
  local proValue = self:caluProgValue(minFeats, maxFeats, feats)
  self.nodProgress:setValue(proValue)
  for i = 1, MAX_CCB do
    local ccb = "ccbFeat" .. i
    if self[ccb] then
      if MAX_CCB > i then
        self[ccb]:refreshInfo(dataTab[i] or {})
        local pro = self:caluProgValue(minFeats, maxFeats, dataTab[i].feats) / 100
        local x = self.nodProgress:getPositionX() + self.nodProgress:getContentSize().width * pro
        self[ccb]:setPositionX(x)
      else
        self[ccb]:refreshLastGift(dataTab[i] or {})
      end
    end
  end
end
function prototype:caluProgValue(minFeats, maxFeats, currFeats)
  local currProg = minFeats < currFeats and currFeats - minFeats or 0
  local proValue = currProg * 100 / maxFeats
  return proValue
end
function prototype:createListData()
  self.data = {}
  local tasks = Logic:Get("GodReward"):GetTasks()
  for _, id in pairs(tasks) do
    local rec = KFDBGetRecord("GodTaskSetting", id)
    if rec then
      table.insert(self.data, rec)
    end
  end
  table.sort(self.data, function(a, b)
    return a.sort > b.sort
  end)
  self.sprManualRefresh:setVisible(table.empty(self.data))
  self.tableViewControl:RequireUpdate()
end
function prototype:GetFeatRewardIdx()
  local rewardList = {}
  for i = 1, KFDBGetRecordAmt("GodFeatSetting") do
    local rec = KFDBGetRecordByIdx("GodFeatSetting", i)
    if rec then
      rec.isChanged = Logic:Get("GodReward"):IsDrawFeatReward(rec.id)
      table.insert(rewardList, rec)
    end
  end
  table.sort(rewardList, function(lReward, rReward)
    return lReward.feats < rReward.feats
  end)
  for _, v in pairs(rewardList) do
    if not v.isChanged then
      return math.floor((v.id - 1) / 4)
    end
  end
  return math.floor(#rewardList / 4)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(588, 164)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("GiftTaskListItem", self.rootNode)
    subScene:refrashTask(self.data[index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):refrashTask(self.data[index + 1])
  end
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
