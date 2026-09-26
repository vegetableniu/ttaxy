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
  Logic:Get("Groupbuy"):On(Logic.Groupbuy.EVT.REFRESH_LOAD_REWARD_INFO, self:Event("Refrash"))
  self.m_pCList:setContentSize(CCSize(588, 380))
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.title_ttf:setColor(ccc3(255, 183, 18))
  self.title_ttf:setString(giftInfo.name)
  self.title_ttf:setStyle(kCCLabelTTFStyleOutline)
  self.tip_ttf:setFontSize(23)
  self.tip_ttf:setString(TwGetStr(103355))
  self.tip_ttf:setStyle(kCCLabelTTFStyleOutline)
  self.tip_ttf:setHorizontalAlignment(kCCTextAlignmentCenter)
  local loadReward = Logic:Get("Groupbuy"):GetLoadRewardInfoVo()
  local allGift = Logic:Get("Groupbuy"):GetItemData(loadReward.baseRewardIds)
  if table.empty(allGift) then
    self.ttfPage:setString(1 .. "/" .. 1)
    return
  end
  if allGift then
    self.allGift = allGift
    self.page = math.ceil(#self.allGift / Logic.Compose.MAX_LIST)
    self.data = self.allGift
    self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pCList, self.page)
    self.tableViewControl.tableView:runUIAnimat()
    if self.page == 1 then
      self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
    end
    self.m_pCList:addChild(self.tableViewControl.tableView)
  end
  self.ppl_amoumt_ttf:setStyle(kCCLabelTTFStyleOutline)
  self.ppl_amoumt_ttf:setString(loadReward.chargeCount)
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz", self.sprRight, ccp(35, 19), 0, nil, nil)
  if self.ani then
    self.ani:RunAni()
  end
end
function prototype:Refrash()
  local loadReward = Logic:Get("Groupbuy"):GetLoadRewardInfoVo()
  local allGift = Logic:Get("Groupbuy"):GetItemData(loadReward.baseRewardIds)
  self.allGift = allGift
  self.data = self.allGift
  self.page = math.ceil(#self.allGift / Logic.Compose.MAX_LIST)
  self.tableViewControl:RequireUpdate(self.page)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(588, 164)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local idx = index + 1
  local lstIdx = idx + (curPage - 1) * Logic.Compose.MAX_LIST
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("GiftActivityGroupItem", self.rootNode)
    subScene:ReFrashReward(self.allGift[lstIdx], index)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):ReFrashReward(self.allGift[lstIdx], index)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.page == 0 then
    self.page = 1
  end
  self.ttfPage:setString(curPage .. "/" .. self.page)
  if #self.allGift == 0 then
    return 0
  end
  if self.page == curPage then
    local num = #self.allGift - (self.page - 1) * Logic.Hero.MAX_HEROS_PER_PAGE
    return num
  else
    return Logic.Compose.MAX_LIST
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:actionFinish(tableView)
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
function prototype:getTableViewOffset()
  return nil
end
function prototype:onBtnRecharge(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
