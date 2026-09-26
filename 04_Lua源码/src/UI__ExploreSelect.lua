require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local MAX_ITEMS = 20
function prototype:onEnter()
  self.ccbTips:setVisible(false)
  self.ccbTips:refreshUI()
  self.bshowTips = false
  self.cards = {}
  self.sendType = ""
  self.ttfSelected:setStyle(kCCLabelTTFStyleOutline)
  local size = Logic:Get("Explore"):selectedSize()
  self.ttfSelected:setString(size)
  self.ttfSuccessRate:setStyle(kCCLabelTTFStyleOutline)
  self:showRate()
  self:showLeftHire()
  self.data = self:initHeroList()
  self.tableViewControl = TableViewEx.prototype:createList(self, self.nodList, self.page)
  self.nodList:addChild(self.tableViewControl.tableView)
  Logic:Get("Explore"):On(Logic.Explore.EVT.OWNER_FIGHT_SCORE, self:Event("onOwnerFightScore"))
  Logic:Get("Explore"):On(Logic.Explore.EVT.CARD_CHANGED, self:Event("onCardChanged"))
end
function prototype:onBtnReturn(sender, event)
  Logic:Get("Explore"):clearSelect("SELF")
  Logic:Get("Explore"):FireEvent(Logic.Explore.EVT.OWNER_FIGHT_SCORE)
  SceneHelper:removeScene("ExploreSelect", self.rootNode)
end
function prototype:onBtnCover(sender, event)
end
function prototype:onBtnBg(sender, event)
end
function prototype:onBtnConfirm(sender, event)
  self.sendType = "BUTTON"
  Logic:Get("Explore"):postOwnerFightScore()
end
function prototype:onBtnArrow(sender, event)
  if self.bshowTips then
    self.ccbTips:onBtnRollBack(sender, event)
    return
  end
  self.bshowTips = true
  self.ccbTips:setVisible(true)
  self.ccbTips:show()
end
function prototype:onBtnFriend(sender, event)
  local info = Logic:Get("Explore"):GetExploreVo()
  local key = "EXPLORE:HIRE_FRIEND_TIME_LIMIT"
  local leftHireFriend = self:leftTimes(key, info.hireFriendTimes)
  if leftHireFriend <= 0 then
    Prompt:Fail(115210)
    return
  end
  local systemCards = Logic:Get("Explore"):getSystemCards()
  if not table.empty(systemCards) then
    Prompt:Fail(115243)
    return
  end
  SceneHelper:pushScene("ExploreFriend", self.rootNode)
end
function prototype:onBtnSystem(sender, event)
  local info = Logic:Get("Explore"):GetExploreVo()
  local key = "EXPLORE:HIRE_VIRTUAL_TIME_LIMIT"
  local leftHireSystem = self:leftTimes(key, info.hireVirtualTimes)
  if leftHireSystem <= 0 then
    Prompt:Fail(115209)
    return
  end
  local friends = Logic:Get("Explore"):getSelectFriends()
  if not table.empty(friends) then
    Prompt:Fail(115242)
    return
  end
  SceneHelper:pushScene("ExploreSystem", self.rootNode)
end
function prototype:onBtnLeft(sender, event)
  if self.tableViewControl then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onBtnRight(sender, event)
  if self.tableViewControl then
    self.tableViewControl:TurnPage(1)
  end
end
function prototype:initHeroList()
  local cardIds = Logic:Get("Hero"):GetTotalHeroId()
  local cardList = Logic:Get("Hero"):GetHeroInfosByIds(cardIds)
  local result = {}
  local reqStar = Logic:Get("Egg"):GetCongifValueByKey("EXPLORE:HERO_STAR_REQUIRE")
  for i, card in ipairs(cardList) do
    local info = Logic:Get("Hero"):GetHeroInfoByBaseId(card.baseId)
    if reqStar <= info.star and not Logic:Get("Explore"):isOnExecute(card.id) then
      card.fit = Logic:Get("Explore"):getFitSuccessTable(card.baseId)
      table.insert(result, card)
    end
  end
  table.sort(result, function(lp, rp)
    if #lp.fit ~= #rp.fit then
      return #lp.fit > #rp.fit
    end
    local infoA = Logic:Get("Hero"):GetHeroInfoByBaseId(lp.baseId)
    local infoB = Logic:Get("Hero"):GetHeroInfoByBaseId(rp.baseId)
    if infoA.rank ~= infoB.rank then
      return infoA.rank > infoB.rank
    end
    return infoA.star > infoB.star
  end)
  self.page = math.ceil(#result / MAX_ITEMS)
  return result
end
function prototype:onOwnerFightScore()
  if self.sendType == "SELECTED" then
    self:showRate()
    self.ccbTips:refreshUI()
    return
  end
  SceneHelper:removeScene("ExploreSelect", self.rootNode)
end
function prototype:selectedCard(id, data)
  Logic:Get("Explore"):selectedCard(id, data, "SELF")
  self:refreshSelectUI()
  if Logic:Get("Explore"):IsCardFull() then
    self.sendType = "SELECTED"
    Logic:Get("Explore"):postOwnerFightScore()
  end
end
function prototype:refreshSelectUI()
  local size = Logic:Get("Explore"):selectedSize()
  self.ttfSelected:setString(size)
  self:showRate()
  self.ccbTips:refreshUI()
  self.tableViewControl:RequireUpdateWithoutAnimat()
end
function prototype:showRate()
  local rate = Logic:Get("Explore"):caluRate()
  if rate > 100 then
    rate = 100 or rate
  end
  self.ttfSuccessRate:setString(rate .. "%")
end
function prototype:showLeftHire()
  local info = Logic:Get("Explore"):GetExploreVo()
  local key = "EXPLORE:HIRE_FRIEND_TIME_LIMIT"
  local leftHireFriend = self:leftTimes(key, info.hireFriendTimes)
  self.ttfFriendTimes:setStyle(kCCLabelTTFStyleOutline)
  self.ttfFriendTimes:setString(leftHireFriend)
  key = "EXPLORE:HIRE_VIRTUAL_TIME_LIMIT"
  local leftHireSystem = self:leftTimes(key, info.hireVirtualTimes)
  self.ttfSystemTimes:setStyle(kCCLabelTTFStyleOutline)
  self.ttfSystemTimes:setString(leftHireSystem)
end
function prototype:leftTimes(key, currTimes)
  local maxTimes = Logic:Get("Egg"):GetCongifValueByKey(key)
  local left = maxTimes - (currTimes or 0)
  return left
end
function prototype:onCardChanged()
  self:refreshSelectUI()
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 121)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local tag = 2
  local idx = index + 1 + (curPage - 1) * MAX_ITEMS
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ExploreSelectItem", self.rootNode)
    cell:addChild(subScene, 0, tag)
  end
  cell:getChildByTag(tag):Refresh(self.data[idx], self, "SELF", index + 1)
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if table.empty(self.data or {}) then
    return 0
  end
  self.ttfPage:setString(curPage .. "/" .. self.page)
  if self.page == curPage then
    local num = #self.data - (self.page - 1) * MAX_ITEMS
    return num
  end
  return MAX_ITEMS
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
