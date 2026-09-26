require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.selectGroup = 0
end
function prototype:Refresh()
  self:createChildCcbs()
end
function prototype:createChildCcbs()
  local teams = Logic:Get("Lineup"):getTeams()
  local teamData = {}
  for name, v in pairs(teams) do
    local data = {}
    data.groups = tree.clone(v)
    data.name = name
    table.insert(teamData, data)
  end
  self.rootNode:removeAllChildrenWithCleanup(true)
  local allItemsHeight = Logic:Get("Lineup"):getAllItemsHeight()
  self.layer:setContentSize(CCSizeMake(640, allItemsHeight))
  local itemHeight = 820
  local itemInterval = 115
  local firstItemY = allItemsHeight - itemHeight / 2
  local itemCnt = table.size(teams)
  for i = 1, #teamData do
    local y = firstItemY - itemInterval * (i - 1)
    local ccb = "ccbGroup" .. i
    self[ccb] = Tw.Controller:load("LineupGroup", self.rootNode)
    self[ccb]:setPosition(ccp(320, y))
    self[ccb]:setOwner(self, i)
    self[ccb]:refreshItem(teamData[i])
    local tag = 1
    self.rootNode:addChild(self[ccb], 0, tag + i)
  end
end
function prototype:onClickedGroup(selectIdx)
  local ccb = "ccbGroup" .. selectIdx
  local moveY = self[ccb]:isRollUp() and 0 or 690
  self:resetCcbs(selectIdx)
  self:moveCcbs(selectIdx, moveY)
end
function prototype:moveCcbs(idx, moveY)
  local itemCnt = self:getItemCnt()
  local itemHeight = 820
  local itemInterval = 115
  local allItemsHeight = Logic:Get("Lineup"):getAllItemsHeight()
  local firstItemY = allItemsHeight - itemHeight / 2
  local posYs = {}
  for i = 1, itemCnt do
    local y = firstItemY - itemInterval * (i - 1)
    table.insert(posYs, y)
  end
  for i = idx + 1, #posYs do
    local ccb = "ccbGroup" .. i
    local x = self[ccb]:getPositionX()
    local action = CCMoveTo:create(0.167, ccp(x, posYs[i] - moveY))
    self[ccb]:runAction(action)
  end
end
function prototype:resetCcbs(idx)
  local markIdx = 0
  local itemCnt = self:getItemCnt()
  for i = 1, itemCnt do
    local ccb = "ccbGroup" .. i
    if idx ~= i and not self[ccb]:isRollUp() then
      self[ccb]:reset()
      markIdx = i
    end
  end
  self:moveCcbs(markIdx, 0)
end
function prototype:getItemCnt()
  local teams = Logic:Get("Lineup"):getTeams()
  local itemCnt = table.size(teams)
  return itemCnt
end
