require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.ttfTime:setStyle(kCCLabelTTFStyleOutline)
  self.ttfRate:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTaskDesr:setStyle(kCCLabelTTFStyleOutline)
  self.ttfFightScore:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:Refresh(data)
  self.data = data
  self:refreshPlace()
  self:refreshSelectCards()
  self:showConditions()
  self:showRewards()
  self:caluPosition()
  self.ttfTime:setString(TwGetStr(100046, data.exceTimes))
  local rate = Logic:Get("Explore"):caluRate()
  if rate > 100 then
    rate = 100 or rate
  end
  self.ttfRate:setString(rate .. "%")
  local fight = Logic:Get("Explore"):getTotalFight()
  self.ttfFightScore:setString(fight)
  self.nodAni:removeAllChildrenWithCleanup(true)
  self.nodAni:stopAllActions()
  self:showGuideAni(self.nodAni)
end
function prototype:caluPosition()
  local height = 65
  local hasCdTask = Logic:Get("Explore"):HasReduceColdDown()
  local itemCnt = hasCdTask and #self.data.successItems + 1 or #self.data.successItems
  local moveY = (5 - itemCnt) * height
  self.nodSelectCard:setPositionY(174 + moveY)
end
function prototype:showGuideAni(node)
  local bFirstTaskClick = Logic:Get("System"):GetSysVariableMisc("FirstTaskClick")
  if bFirstTaskClick then
    return
  end
  local function runAni()
    if self.ani then
      self.ani:RemoveAnimation()
      self.ani = nil
    end
    local x = 0
    local y = 0
    self.ani = Logic:Get("AniMgr"):NewCCB("UI/uixsyd02", node, ccp(x, y))
    if self.ani then
      self.ani:RunAni()
    end
  end
  local arr = CCArray:create()
  arr:addObject(CCCallFuncN:create(runAni))
  arr:addObject(CCDelayTime:create(1.5))
  node:runAction(CCRepeatForever:create(CCSequence:create(arr)))
end
function prototype:refreshPlace()
  local rec = KFDBGetRecord("TaskPlace", self.data.point)
  local spr = CCSprite:create(rec.placeIcon)
  if spr then
    self.sprPlace:setDisplayFrame(spr:displayFrame())
  end
  self.ttfTaskDesr:setString(rec.taskDesr or "")
end
function prototype:showConditions()
  local idx = Logic:Get("Explore"):HasReduceColdDown() and 1 or 0
  if idx == 1 then
    local id = self.data.star .. "_" .. self.data.point
    local record = KFDBGetRecord("TaskPointCDConfig", id)
    if record then
      self.ccbCond1:refreshReduseCd(record)
    end
  end
  for i = 1 + idx, 5 do
    local ccb = "ccbCond" .. i
    local condition = self.data.successItems[i - idx]
    if condition then
      self[ccb]:Refresh(condition, i)
    else
      self[ccb]:setVisible(false)
    end
  end
end
function prototype:showRewards()
  local rec = KFDBGetRecord("TaskRewardConfig", self.data.reward)
  if table.empty(rec or {}) then
    return
  end
  local ccbs = list.map(function(index)
    return self["ccbBaseReward" .. index]
  end, table.indices(list.rep({0}, 2)))
  local baseShowTypes = json.decode(rec.baseShowTypes or "[]")
  local baseShowIds = json.decode(rec.baseShowIds or "[]")
  local baseAmounts = json.decode(rec.baseAmounts or "[]")
  local successShowTypes = json.decode(rec.successShowTypes or "[]")
  local successShowIds = json.decode(rec.successShowIds or "[]")
  local successAmounts = json.decode(rec.successAmounts or "[]")
  for i, ccb in ipairs(ccbs) do
    if baseShowTypes[i] then
      local data = {}
      data.showType = baseShowTypes[i]
      data.showId = baseShowIds[i]
      data.amount = baseAmounts[i]
      ccb:setVisible(true)
      ccb:ReFreshByGift(data)
    else
      ccb:setVisible(false)
    end
  end
  local positions = {
    {320},
    {260, 380},
    {
      320,
      220,
      420
    }
  }
  ccbs = list.map(function(index)
    return self["ccbSuccess" .. index]
  end, table.indices(list.rep({0}, 3)))
  for i, ccb in ipairs(ccbs) do
    if successShowTypes[i] then
      local data = {}
      data.showType = successShowTypes[i]
      data.showId = successShowIds[i]
      data.amount = successAmounts[i]
      ccb:setVisible(true)
      ccb:ReFreshByGift(data)
      ccb:setPositionX(positions[#successShowTypes][i])
    else
      ccb:setVisible(false)
    end
  end
end
function prototype:refreshSelectCards()
  local ccbs = list.map(function(index)
    return self["ccbHero" .. index]
  end, table.indices(list.rep({0}, 5)))
  local listCards = self:createCardsData()
  for i, ccb in ipairs(ccbs) do
    if i <= self.data.cardCount then
      ccb:setVisible(true)
      if listCards[i] and listCards[i].baseId then
        ccb:Refresh(listCards[i])
      elseif listCards[i] and not listCards[i].baseId then
        ccb:refreshIcon(listCards[i])
      else
        ccb:clear()
      end
      ccb:setCallBack(function()
        Logic:Get("System"):SetSysVariableMisc("FirstTaskClick", 1)
        SceneHelper:pushScene("ExploreSelect", self.rootNode)
      end)
    else
      ccb:setVisible(false)
    end
  end
end
function prototype:createCardsData()
  local result = {}
  local selectedCards = Logic:Get("Explore"):getSelectCards()
  for _, data in pairs(selectedCards) do
    table.insert(result, data)
  end
  local selectedFriends = Logic:Get("Explore"):getSelectFriends()
  for _, data in pairs(selectedFriends) do
    table.insert(result, data)
  end
  local selectedSystem = Logic:Get("Explore"):getSystemCards()
  for _, data in pairs(selectedSystem) do
    table.insert(result, data)
  end
  return result
end
