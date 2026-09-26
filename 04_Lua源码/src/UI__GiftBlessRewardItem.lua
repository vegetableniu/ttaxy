module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  self.maxTimes = {}
end
function prototype:setMaxTimes(node, times)
  self.maxTimes[node] = times
end
function prototype:runAni(node, times, target)
  if not self[node] then
    return
  end
  local range = times == 0 and 0.1 or times * 0.1
  if times >= self.maxTimes[node] then
    range = 2.4 or range
  end
  local x = self[node]:getPositionX()
  local y = self[node]:getPositionY()
  y = times < self.maxTimes[node] and -307 or 53 - target * 90
  local arr = CCArray:create()
  local moveTo = CCMoveTo:create(range, ccp(x, y))
  local func = CCCallFuncN:create(function()
    if times < self.maxTimes[node] then
      self[node]:setPositionY(53)
      self:runAni(node, times + 1, target)
      return
    end
    Logic:Get("Bless"):PromptReward(node)
  end)
  arr:addObject(moveTo)
  arr:addObject(func)
  self[node]:runAction(CCSequence:create(arr))
end
function prototype:setFakeReward()
  local rec = KFDBGetRecord("ConfigValue", "BLESSING:FAKE_LEVEL")
  local level = Logic:Get("PlayerInfo"):GetPlayerLevel()
  local idx = 0
  local prevLv = 0
  local tabLevels = json.decode(rec.content) or {}
  for i, v in ipairs(tabLevels) do
    if level > prevLv and v >= level then
      idx = i
      break
    end
    prevLv = v
  end
  local GetTable = function(id)
    local rec = KFDBGetRecord("ConfigValue", id) or {}
    local data = json.decode(rec.content or "[]") or {}
    return data
  end
  for i = 2, 4 do
    local showTypeStr = "BLESSING:FAKE_REWARDS_SHOWTYPES_" .. i
    local showIdsStr = "BLESSING:FAKE_REWARDS_SHOWIDS_" .. i
    local amountsStr = "BLESSING:FAKE_REWARDS_AMOUNTS_" .. i
    local showTypes = GetTable(showTypeStr)
    local showIds = GetTable(showIdsStr)
    local amounts = GetTable(amountsStr)
    for j = 1, 5 do
      local ccb = "ccbReward" .. i .. j
      local info = {}
      info.showType = showTypes[idx][j] or "COPPER"
      info.showId = showIds[idx][j] or 4
      info.amount = amounts[idx][j] or 1
      if self[ccb] then
        self[ccb]:ReFreshByGift(info)
      end
    end
  end
end
function prototype:resetPos()
  for i = 1, 5 do
    local node = "nodReward" .. i
    if self[node] then
      self[node]:setPositionY(53)
    end
  end
end
