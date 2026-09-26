module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local MAX_COUNTRY_PER_PAGE = 5
function prototype:initialize(...)
  super.initialize(self, ...)
  self.countryInfo = {}
  self.isNotBidOrJoin = false
  self.isJoinTime = false
  self.isReportTime = false
end
function prototype:onEnter()
  self.ttfBidTime:setStyle(kCCLabelTTFStyleOutline)
  self.ttfJoinTime:setStyle(kCCLabelTTFStyleOutline)
  self.staPageNum:setStyle(kCCLabelTTFStyleOutline)
  Logic:Get("Sect"):On(Logic.Sect.EVT.COUNTRY_FIGHT_HAS_JOINED, self:Event("onEnterFight"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.SET_TABLEVIEW_TOUCH, self:Event("OnSetTableViewTouch"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.REFRESH_COUNTRY_INFO, self:Event("onRefreshCountryInfo"))
  self.page = 1
  self.data = {}
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pCList, self.page)
  self.tableViewControl.tableView:setTouchEnabled(false)
  self.m_pCList:addChild(self.tableViewControl.tableView)
  self:holdRewardTime()
  self.staPageNum:setVisible(false)
  Logic:Get("Sect"):setCanJoinState(false)
  local joinBidDate = Logic:Get("Sect"):GetJoinBidDate()
  local joinFightDate = Logic:Get("Sect"):GetJoinFightDate()
  local reportDate = Logic:Get("Sect"):GetReportDate()
  self:bidStartAndEnd(joinBidDate)
  self:joinStartAndEnd(joinFightDate)
  MsgMenpai:Post("COUNTRY_DATA")
end
function prototype:dispose(...)
  super.dispose(self)
  if SceneHelper:isExistPrompt("SectWord") then
    SceneHelper:removePrompt(nil, "SectWord")
  end
end
function prototype:onRefreshCountryInfo()
  local countryInfo = Logic:Get("Sect"):getCountryInfo()
  if table.empty(countryInfo or {}) then
    return
  end
  self.countryInfo = countryInfo.countryDatas
  self:sortDateById()
  self:initTableData()
  self.tableViewControl:RequireUpdateWithoutAnimat(self.page, true, true)
end
function prototype:setCountryType(id)
  local country = KFDBGetRecord("CountrySetting", id)
  if country == nil then
    return
  end
  return country.type
end
function prototype:sortDateById()
  if not table.empty(self.countryInfo) then
    local countrySort = function(param1, param2)
      if not param1 or not param2 then
        return false
      end
      local sortInfo1 = KFDBGetRecord("CountrySetting", param1.data.id)
      local sortInfo2 = KFDBGetRecord("CountrySetting", param2.data.id)
      if not sortInfo1 or not sortInfo2 then
        return false
      end
      local sortId1 = sortInfo1.position or 0
      local sortId2 = sortInfo2.position or 1
      return sortId1 < sortId2
    end
    table.sort(self.countryInfo, countrySort)
  end
end
function prototype:initTableData(info)
  if table.empty(self.countryInfo) then
    return
  end
  self.page = math.ceil(#self.countryInfo / MAX_COUNTRY_PER_PAGE)
  self.data = {}
  for i = 1, self.page do
    table.insert(self.data, {})
  end
  local idx = 1
  for i, v in ipairs(self.countryInfo) do
    table.insert(self.data[idx], v)
    if i % MAX_COUNTRY_PER_PAGE == 0 then
      idx = idx + 1
    end
  end
end
function prototype:bidStartAndEnd(bidTime)
  if table.empty(bidTime or {}) then
    return
  end
  local strFormat = TwGetStr(108126)
  local startTime = Logic:Get("System"):GetTimeStr(strFormat, bidTime[1] / 1000)
  local endTime = Logic:Get("System"):GetTimeStr(strFormat, bidTime[2] / 1000)
  self.ttfBidTime:setString(startTime .. "-" .. endTime)
end
function prototype:joinStartAndEnd(joinTime)
  if table.empty(joinTime or {}) then
    return
  end
  local strFormat = TwGetStr(108126)
  local startTime = Logic:Get("System"):GetTimeStr(strFormat, joinTime[1] / 1000)
  local endTime = Logic:Get("System"):GetTimeStr(strFormat, joinTime[2] / 1000)
  self.ttfJoinTime:setString(startTime .. "-" .. endTime)
end
function prototype:holdRewardTime(rewardTime)
  self.ttfDesc:setString(TwGetStr(108130))
end
function prototype:onEnterFight()
  SceneHelper:removeScene("SectFightMain")
  SceneHelper:pushScene("SectFight", self.rootNode)
end
function prototype:onLeftClicked(sender, event)
  SceneHelper:removeScene("SectFightMain")
  SceneHelper:removeScene("SectMain")
  SceneHelper:runWithScene("SectMain", self.rootNode)
end
function prototype:onPrevPageBtnClicked(sender, event)
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onNextPageBtnClicked(sender, event)
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(1)
  end
end
function prototype:onBtnWord(sender, event)
  Logic:Get("Sect"):setEnterWord(true)
  self:OnSetTableViewTouch(false)
  if not SceneHelper:isExistPrompt("SectWord") then
    SceneHelper:pushPrompt("SectWord", self.rootNode)
  end
end
function prototype:OnSetTableViewTouch(flage)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(640, 600)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("SectFightMainItem", self.rootNode)
    subScene:refresh(self.data[curPage - 1 + index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):refresh(self.data[curPage - 1 + index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  self.staPageNum:setString(curPage .. "/" .. self.page)
  if table.empty(self.data) == nil then
    return 0
  end
  if self.page == curPage then
    return 1
  else
    return 1
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdateWithoutAnimat()
end
