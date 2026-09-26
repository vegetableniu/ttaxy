module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("Logic.Compose")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onBtnReturn()
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onEnter()
  super.onEnter(self)
  self.m_pCList:setContentSize(CCSize(500, 275))
  Logic:Get("Gift"):SetGiftInfoType("Activity")
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.title_ttf:setColor(ccc3(255, 183, 18))
  self.title_ttf:setString(giftInfo.name)
  self.title_ttf:setStyle(kCCLabelTTFStyleOutline)
  self.tip_ttf:setFontSize(23)
  self.tip_ttf:setStyle(kCCLabelTTFStyleOutline)
  self.tip_ttf:setString(TwGetStr(103361))
  self.tip_ttf:setColor(ccColor3B(0, 255, 0))
  self.ttf_tip:setString(TwGetStr(103363))
  local strformat = TwGetStr(103088)
  local activityInfo = Logic:Get("Gift"):GetActivityGift()
  local startTimeStr = Logic:Get("System"):GetTimeStr(strformat, activityInfo.startTime / 1000)
  local endTimeStr = Logic:Get("System"):GetTimeStr(strformat, activityInfo.endTime / 1000)
  local strTime = ""
  if startTimeStr == nil or endTimeStr == nil then
    strTime = TwGetStr(103095)
  else
    strTime = startTimeStr .. "-" .. endTimeStr
  end
  self.time_ttf:setString(TwGetStr(103362, strTime))
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz", self.sprRight, ccp(35, 19), 0, nil, nil)
  if self.ani then
    self.ani:RunAni()
  end
  self.strArr = {
    [1] = {
      targetLevel = TwGetStr(103390),
      content = TwGetStr(103391),
      showid = "7"
    }
  }
  for i = 1, KFDBGetRecordAmt("ArtifactUpgradeActivity") do
    local rec = KFDBGetRecordByIdx("ArtifactUpgradeActivity", i)
    if rec and rec.activityId == activityInfo.id then
      table.insert(self.strArr, rec)
    end
  end
  self.page = 1
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pCList, self.page)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.m_pCList:addChild(self.tableViewControl.tableView)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(500, 55)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("GiftActivityUpArtItem", self.rootNode)
    subScene:ReFrashReward(self.strArr[index + 1], index + 1)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):ReFrashReward(self.strArr[index + 1], index + 1)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if #self.strArr == 0 then
    return 1
  end
  return #self.strArr
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:onBtnRecharge(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
function prototype:onBtnUpArt(sender, event)
  SceneHelper:runWithScene("Artifact", self.rootNode)
end
