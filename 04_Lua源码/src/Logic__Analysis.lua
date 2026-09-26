require("Logic")
module((...), package.seeall)
class = Logic.class:subclass()
function class:initialize()
  super.initialize(self)
  self.getNeedSwapStr = {}
  self.newSting = ""
end
function class:SetNeedSwapStr(str)
  self.newSting = str
end
function class:FindDollar(getObj, ctr)
  self.getNeedSwapStr = {}
  local pos = string.find(getObj, ctr, 1, string.len(getObj))
  if pos == nil then
    self.getNeedSwapStr = {}
    return nil
  end
  local nub = 1
  local posTab = {}
  while pos do
    table.insert(posTab, pos)
    if nub == 2 then
      table.insert(self.getNeedSwapStr, string.sub(getObj, posTab[1] + 1, posTab[2] - 1))
      posTab = {}
      nub = 0
    end
    pos = string.find(getObj, ctr, pos + 1, string.len(getObj))
    nub = nub + 1
  end
end
function class:GetIsSwapString()
  if next(self.getNeedSwapStr) == nil then
    return nil
  end
  return self.getNeedSwapStr
end
function class:SetSwapString(fdbGetStr, serverStr)
  if fdbGetStr == nil or serverStr == nil or next(self.getNeedSwapStr) == nil then
    return
  end
  if type(serverStr) == "string" then
    serverStr = json.decode(serverStr)
  end
  for i = 1, #self.getNeedSwapStr do
    local oldStr
    oldStr = string.format("%%$%s%%$", self.getNeedSwapStr[i])
    if self.getNeedSwapStr[i] == "player" and serverStr[self.getNeedSwapStr[i]] then
      self.newSting = string.gsub(self.newSting, oldStr, serverStr[self.getNeedSwapStr[i]].name)
    end
    if self.getNeedSwapStr[i] == "number" and serverStr[self.getNeedSwapStr[i]] then
      self.newSting = string.gsub(self.newSting, oldStr, serverStr[self.getNeedSwapStr[i]])
    end
    if self.getNeedSwapStr[i] == "job" and serverStr[self.getNeedSwapStr[i]] then
      local name = Logic:Get("Sect"):GetNameByPos(serverStr[self.getNeedSwapStr[i]])
      self.newSting = string.gsub(self.newSting, oldStr, name)
    end
    if self.getNeedSwapStr[i] == "content" and serverStr[self.getNeedSwapStr[i]] then
      self.newSting = string.gsub(self.newSting, oldStr, serverStr[self.getNeedSwapStr[i]])
    end
    if self.getNeedSwapStr[i] == "realGoods" then
      local goodName = KFDBGetRecord("RouletteLotteryConfig", serverStr.goodsId)
      if goodName then
        self.newSting = string.gsub(self.newSting, oldStr, goodName.rewardName)
      end
    end
    if self.getNeedSwapStr[i] == "single" then
      local battleName = KFDBGetRecord("CampaignConfig", serverStr[self.getNeedSwapStr[i]])
      if battleName == nil then
        battleName = KFDBGetRecord("BattleInfoConfig", serverStr[self.getNeedSwapStr[i]])
      end
      if battleName then
        self.newSting = string.gsub(self.newSting, oldStr, battleName.name)
      end
    end
    if self.getNeedSwapStr[i] == "exploreTaskId" then
      local rec = KFDBGetRecord("TaskPlace", serverStr[self.getNeedSwapStr[i]])
      if rec then
        self.newSting = string.gsub(self.newSting, oldStr, rec.taskName)
      end
    end
    if string.find(self.getNeedSwapStr[i], "players", 1, string.len(self.getNeedSwapStr[i])) and serverStr.players then
      local splStr = string.split(self.getNeedSwapStr[i], "_")
      local newStr = serverStr.players[tonumber(splStr[2]) + 1]
      self.newSting = string.gsub(self.newSting, oldStr, newStr.name)
    end
    if string.find(self.getNeedSwapStr[i], "numbers", 1, string.len(self.getNeedSwapStr[i])) and serverStr.numbers then
      local splStr = string.split(self.getNeedSwapStr[i], "_")
      local reavNumber = tonumber(splStr[2])
      local newStr = serverStr.numbers[reavNumber + 1]
      self.newSting = string.gsub(self.newSting, oldStr, newStr)
    end
    if string.find(self.getNeedSwapStr[i], "names", 1, string.len(self.getNeedSwapStr[i])) and serverStr.names then
      local splStr = string.split(self.getNeedSwapStr[i], "_")
      local reavNumber = tonumber(splStr[2])
      local newStr = serverStr.names[reavNumber + 1]
      self.newSting = string.gsub(self.newSting, oldStr, newStr)
    end
    if string.find(self.getNeedSwapStr[i], "code", 1, string.len(self.getNeedSwapStr[i])) and serverStr.code then
      self.newSting = string.gsub(self.newSting, oldStr, serverStr.code)
    end
    if self.getNeedSwapStr[i] == "reward" or self.getNeedSwapStr[i] == "rewards" then
      local serverRewards
      if serverStr.reward then
        serverRewards = serverStr.reward
      elseif serverStr.rewards[1].type then
        serverRewards = serverStr.rewards[1]
      else
        serverRewards = serverStr.rewards[1]
      end
      local newStr = Logic:Get("Reward"):GetRewardsStr(serverRewards)
      self.newSting = string.gsub(self.newSting, oldStr, newStr)
    end
    if string.find(self.getNeedSwapStr[i], "hero", 1, string.len(self.getNeedSwapStr[i])) and serverStr.hero then
      local heroInfo = KFDBGetRecord("BaseHero", serverStr.hero)
      if heroInfo then
        self.newSting = string.gsub(self.newSting, oldStr, heroInfo.name)
      end
    end
    if string.find(self.getNeedSwapStr[i], "heros", 1, string.len(self.getNeedSwapStr[i])) and serverStr.heros then
      local splStr = string.split(self.getNeedSwapStr[i], "_")
      local reavNumber = tonumber(splStr[2])
      local heroInfo = KFDBGetRecord("BaseHero", serverStr.heros[reavNumber])
      if heroInfo then
        self.newSting = string.gsub(self.newSting, oldStr, heroInfo.name)
      end
    end
  end
end
function class:GetSwapFinishString()
  return self.newSting
end
