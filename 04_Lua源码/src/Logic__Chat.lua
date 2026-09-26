module((...), package.seeall)
class = Logic.class:subclass()
EVT = Enum({"POSTS"})
CHAT_INTERVAL = 30
function class:initialize()
  super.initialize(self)
  self.index = 1
  self.chatSrv = {}
  self.chatLocal = {}
  self.chatCycle = {}
  MsgChat:On("GET_POSTS", self:Event("OnGetPosts"), false)
  Singleton(NetMgr):On(NetMgr.EVT.ANNOUCEMENT, self:Event("OnNewAnnoucement"))
end
function class:OnEnterWorld()
  if not self:EventTracer():Exist("CHAT_LOCAL") then
    for i = 1, KFDBGetRecordAmt("ChatConfig") do
      local info = self:GetClientChat(i)
      if info and info.content then
        table.insert(self.chatLocal, TwGetStr(104251, info.content))
      end
    end
    Singleton(Timer):Repeat(10000, self:Event("CHAT_LOCAL", "OnChatLocal"))
  end
end
function class:OnChatLocal()
  local bInBattle = Logic:Get("BattleShow"):IsEnterBattle()
  if bInBattle then
    return
  end
  local currentTime = TimeGetTime()
  if not self.firstTime then
    self.firstTime = TimeGetTime()
  end
  local systime = Logic:Get("System"):GetTime()
  if not table.empty(self.chatCycle) then
    for k, v in pairs(self.chatCycle) do
      if systime >= tonumber(v.content.endTime) / 1000 then
        if self:EventTracer():Exist(k) then
          self:EventTracer():Cancel(k)
        end
        self.chatCycle[k] = nil
      end
    end
  end
  if math.modf((currentTime - self.firstTime) / 1000) >= CHAT_INTERVAL then
    if #self.chatSrv == 0 then
      if self.index > KFDBGetRecordAmt("ChatConfig") then
        self.index = 1
      end
      if self.chatLocal[self.index] then
        self:FireEvent(EVT.POSTS, false, self.chatLocal[self.index])
      end
      self.index = self.index + 1
    else
      self:FireEvent(EVT.POSTS, true, self.chatSrv[1])
      table.remove(self.chatSrv, 1)
    end
    self.firstTime = nil
  end
end
function class:PostGetPosts()
  if not self.bFirst then
    self.time = (Logic:Get("System"):GetTime() - 86400) * 1000
    self.bFirst = true
  end
  MsgChat:Post("GET_POSTS", {
    time = self.time
  })
end
function class:OnGetPosts(code, data)
  if code ~= 0 or not data then
    return
  end
  self.time = (Logic:Get("System"):GetTime() + 1) * 1000
  for i = 1, #data do
    if 0 > data[i].id then
      self:CycleChat(data[i])
    else
      local chatInfo = self:GetSrvChatById(data[i].id)
      local chat = chatInfo.template or ""
      if chatInfo and chatInfo.template then
        Logic:Get("Analysis"):SetNeedSwapStr(chatInfo.template)
        Logic:Get("Analysis"):FindDollar(chatInfo.template, "$")
        local t = Logic:Get("Analysis"):GetIsSwapString()
        if data[i].content.rewards then
          data[i].content.rewards = self:MergeRewards(data[i].content.rewards)
        end
        local swapT = {}
        if t then
          for j = 1, #t do
            if t[j] == "hero_1" then
              if data[i].content.heros and data[i].content.heros[1] then
                swapT[t[j]] = data[i].content.heros[1]
              end
            elseif t[j] == "hero_2" then
              if data[i].content.heros and data[i].content.heros[2] then
                swapT[t[j]] = data[i].content.heros[2]
              end
            else
              swapT[t[j]] = data[i].content[t[j]]
            end
          end
        end
        chat = TwGetStr(104257, self:ReplaceString(chatInfo.template, swapT))
      end
      table.insert(self.chatSrv, chat)
    end
  end
end
function class:CycleChat(data)
  if data.content.delay ~= nil then
    if data.content.key ~= nil then
      self.chatCycle[data.content.key] = data
      if not self:EventTracer():Exist(data.content.key) then
        Singleton(Timer):Repeat(tonumber(data.content.delay) * 60000, self:Event(data.content.key, function()
          table.insert(self.chatSrv, 1, data.content.content[1])
        end))
      end
    else
      table.insert(self.chatSrv, 1, data.content.content[1])
    end
  else
    table.insert(self.chatSrv, 2, data.content.content[1])
  end
end
function class:MergeRewards(rewards)
  if type(rewards) ~= "table" then
    return {}
  end
  local rewardSort = function(param1, param2)
    if not param1 or not param2 then
      return false
    end
    return param1.code > param2.code
  end
  table.sort(rewards, rewardSort)
  table.insert(rewards, {})
  local newReward = {}
  local baseId = rewards[1].code
  local num = 0
  for i = 1, #rewards do
    if baseId == rewards[i].code then
      num = num + 1
    else
      table.insert(newReward, {
        amount = rewards[i - 1].amount,
        code = rewards[i - 1].code,
        type = rewards[i - 1].type
      })
      num = 1
      baseId = rewards[i].code
    end
  end
  return newReward
end
function class:GetColorByStar(rank)
  rank = tonumber(rank)
  if rank == 1 then
    return TwGetStr(104252)
  elseif rank == 2 then
    return TwGetStr(104253)
  elseif rank == 3 then
    return TwGetStr(104254)
  elseif rank == 4 then
    return TwGetStr(104255)
  elseif rank == 5 then
    return TwGetStr(104259)
  elseif rank >= 6 then
    return TwGetStr(104249)
  else
    return TwGetStr(104256)
  end
end
function class:ReplaceString(template, swapTable)
  if template == nil or swapTable == nil then
    return
  end
  if type(swapTable) == "string" then
    swapTable = json.decode(swapTable)
  end
  for k, v in pairs(swapTable) do
    if k == "player" then
      template = string.gsub(template, "%$player%$", v.name)
    elseif k == "rewards" then
      local strRewards = ""
      for i = 1, #v do
        local strStar = ""
        local color = ""
        local info = Logic:Get("Hero"):GetHeroInfoByBaseId(v[i].code)
        if info and info.star then
          strStar = string.format(TwGetStr(104250, info.star))
          color = self:GetColorByStar(info.rank)
        end
        if strRewards == "" then
          strRewards = color .. strStar .. Logic:Get("Reward"):GetRewardsStr(v[i]) .. "</font>"
        else
          strRewards = color .. strRewards .. ", " .. strStar .. Logic:Get("Reward"):GetRewardsStr(v[i]) .. "</font>"
        end
      end
      template = string.gsub(template, "%$rewards%$", strRewards)
    elseif k == "hero_1" then
      local info = Logic:Get("Hero"):GetHeroInfoByBaseId(v)
      local color = self:GetColorByStar(info.rank)
      if not info then
        template = string.gsub(template, "%$hero_1%$", " ")
      else
        local strStar = string.format(TwGetStr(104250, info.star or 1))
        template = string.gsub(template, "%$hero_1%$", color .. strStar .. info.name .. "</font>")
      end
    elseif k == "hero_2" then
      local info = Logic:Get("Hero"):GetHeroInfoByBaseId(v)
      local color = self:GetColorByStar(info.rank)
      if not info then
        template = string.gsub(template, "%$hero_2%$", " ")
      else
        local strStar = string.format(TwGetStr(104250, info.star or 1))
        template = string.gsub(template, "%$hero_2%$", color .. strStar .. info.name .. "</font>")
      end
    elseif k == "battle" then
      local battleName = Logic:Get("Battle"):GetBattleName(v)
      local campaignId = Logic:Get("Battle"):GetBattleCampaignId(v)
      local campaognName = Logic:Get("Battle"):GetCampainName(campaignId)
      if campaognName then
        battleName = campaognName .. "-" .. battleName
      end
      if not battleName then
        template = string.gsub(template, "%$battle%$", " ")
      else
        template = string.gsub(template, "%$battle%$", battleName)
      end
    elseif k == "lockName" then
      template = string.gsub(template, "%$lockName%$", v or "")
    elseif k == "goodsId" then
      local RouletteLotteryConfig = KFDBGetRecord("RouletteLotteryConfig", v)
      if RouletteLotteryConfig and RouletteLotteryConfig.rewardName then
        template = string.gsub(template, "%$goodsId%$", TwGetStr(104248) .. RouletteLotteryConfig.rewardName .. "</font>")
      else
        template = string.gsub(template, "%$goodsId%$", " ")
      end
    elseif k == "talismans" then
      local rec = KFDBGetRecord("TalismanSetting", v.code)
      local fdb_baseHero = Logic:Get("HeroCardInfo"):kdbBaseHero(rec.baseId)
      local color = self:GetColorByStar(fdb_baseHero.rank)
      template = string.gsub(template, "%$talismans%$", color .. fdb_baseHero.name .. "</font>")
    end
  end
  return template
end
function class:OnNewAnnoucement()
  self:PostGetPosts()
end
function class:GetClientChat(index)
  return KFDBGetRecord("ChatConfig", index)
end
function class:GetSrvChatById(id)
  return KFDBGetRecord("Post", id)
end
