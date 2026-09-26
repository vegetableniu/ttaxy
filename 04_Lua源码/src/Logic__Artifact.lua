module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({
  "ENTER",
  "INJECT_SOULSTONE",
  "GETRANK",
  "SOUL_STONE_EXCHANGE"
})
SOUL_STONE_TYPE = TypeDef("com.eyu.mt.module.artifact.model.SoulStoneType")
STOP_TYPE = TypeDef("com.eyu.mt.module.artifact.model.MultiInjectStopType")
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.artifact.facade.BeeEffGeeResult"))
local MSG_RESULT_STR = {
  CURRENCY_NOT_ENOUGH = 10036,
  NO_SOULSTONE_PACKAGE = 105970,
  NULL_VALUE = 101307,
  LESS_THAN_ZERO = 105905,
  GREATER_THAN_MAX_LEVEL = 105970,
  ALREADY_MAX_LEVEL = 105971,
  NOT_ENOUGH_SOUL_STONE_REDUCE = 105972,
  EXCHANGE_TIMES_MUST_GREATER_THAN_ZERO = 105973,
  SOUL_STONE_EXCHANGE_LIMIT = 105974
}
function class:initialize()
  super.initialize(self)
  self.artlevel = 0
  self.progress = 0
  self.soulStoneNum = 0
  self.bAutoBuy = false
  self.autoCostSoul = 0
  self.buyId = 0
  self.rankList = {}
  self.critNum = 0
  self.injectNum = 0
  self.soulStoneSp = {
    [1] = 0,
    [2] = 0,
    [3] = 0
  }
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgArtifact", MSG_RESULT, MSG_RESULT_STR)
  MsgArtifact:On("ENTER", self:Event("OnEnterArtifact"))
  MsgArtifact:On("INJECT_SOULSTONE", self:Event("OnInjectSoulStone"))
  MsgArtifact:On("BUY_INJECT_SOULSTONE", self:Event("OnBuyInjectSoulStone"))
  MsgArtifact:On("BUY_SOULSTONE", self:Event("OnBuySoulStone"))
  MsgArtifact:On("GET_RANK_LIST", self:Event("OnGetRankList"))
  MsgArtifact:On("INJECT_SOUL_ONCE", self:Event("OnInjectSoulOnce"))
  MsgArtifact:On("INJECT_SOUL_REPEATEDLY", self:Event("OnInjectSoulRepeatedly"))
  MsgArtifact:On("SOUL_STONE_EXCHANGE", self:Event("OnSoulStoneExchange"))
  MsgArtifact:On("SOUL_STONE_EXCHANGE_BY_TYPE", self:Event("OnSoulStoneExchangeByType"))
end
function class:GetSoulStoneSp()
  return self.soulStoneSp
end
function class:SetArtLevel(artlevel)
  self.artlevel = artlevel or self.artlevel
end
function class:GetArtLevel()
  return self.artlevel
end
function class:GetProgress()
  return self.progress
end
function class:AddSoulNum(num)
  if num == nil then
    return
  end
  self.soulStoneNum = self.soulStoneNum + num
end
function class:GetSoulNum()
  return self.soulStoneNum
end
function class:SetAutoBuy(bAutoBuy)
  self.bAutoBuy = bAutoBuy
end
function class:IsAutoBuy()
  return self.bAutoBuy
end
function class:GetRankList()
  return self.rankList
end
function class:GetCritNum()
  return self.critNum
end
function class:GetInjectNum()
  return self.injectNum
end
function class:GetCurrLvSoulStone()
  local rec = KFDBGetRecord("BeeEffGeeLevelSetting", self.artlevel)
  if rec == nil or "NORMAL" == rec.stoneType then
    return 0
  end
  for k, v in pairs(SOUL_STONE_TYPE) do
    if k == rec.stoneType then
      return self.soulStoneSp[v]
    end
  end
  return 0
end
function class:GetCurrLvStoneTypeStr()
  local rec = KFDBGetRecord("BeeEffGeeLevelSetting", self.artlevel)
  if rec == nil or "NORMAL" == rec.stoneType then
    return ""
  end
  for k, v in pairs(SOUL_STONE_TYPE) do
    if k == rec.stoneType then
      local result = 105912
      return TwGetStr(result + v)
    end
  end
  return ""
end
function class:GetStrByType(type)
  if type == nil then
    return ""
  end
  if type == "NORMAL" then
    return TwGetStr(105907)
  end
  for k, v in pairs(SOUL_STONE_TYPE) do
    if k == type then
      local result = 105912
      return TwGetStr(result + v)
    end
  end
  return ""
end
function class:GetStoneByType(type)
  if type == nil then
    return 0
  end
  if type == "NORMAL" then
    return self.soulStoneNum
  end
  for k, v in pairs(SOUL_STONE_TYPE) do
    if k == type then
      return self.soulStoneSp[v]
    end
  end
  return 0
end
function class:GetIconByType(type)
  if type == nil then
    return "images/pulbic/clarity05.png"
  end
  if type == "NORMAL" then
    return "images/BattleShow/soul_item.png"
  end
  for k, v in pairs(SOUL_STONE_TYPE) do
    if k == type then
      return string.format("images/Artifact/soulStoneS%d.png", v)
    end
  end
  return "images/pulbic/clarity05.png"
end
function class:SoulStoneReduce(type, num)
  self.soulStoneSp[type] = self.soulStoneSp[type] - num
  self.soulStoneSp[type] = self.soulStoneSp[type] < 0 and 0 or self.soulStoneSp[type]
end
function class:AddSoulStoneSp(reward)
  if self.soulStoneSp[reward.code] then
    self.soulStoneSp[reward.code] = self.soulStoneSp[reward.code] + reward.amount
  end
end
function class:GetCurrLvMaxProgress()
  local rec = KFDBGetRecord("BeeEffGeeLevelSetting", self.artlevel)
  local maxExp = rec and rec.progress or 0
  return maxExp
end
function class:UpgradeProgress()
  local progress = 0
  local maxExp = self:GetCurrLvMaxProgress()
  local rec = KFDBGetRecord("BeeEffGeeLevelSetting", self.artlevel)
  local factor = rec and rec.normalProgressFactor or 1
  rec = KFDBGetRecord("ConfigValue", "BEEEFFGEE:SOUL_STONE_INJECT_PROGRESS")
  local soulPerExp = rec and tonumber(rec.content) or 1
  progress = (self.autoCostSoul + self.soulStoneNum) * soulPerExp * factor + self.progress - maxExp
  return progress
end
function class:GetArtiBuffByStar(star)
  if star == nil then
    return nil
  end
  return self:GetBuffByLevelAndStar(self.artlevel, star)
end
function class:GetBuffByLevelAndStar(level, star)
  if level == nil or star == nil then
    return nil
  end
  local format = string.format("%d_%d", level, star)
  local rec = KFDBGetRecord("ArtifactLevelSetting", format)
  if rec then
    if rec.alters == nil or "" == rec.alters then
      return nil
    end
    return rec
  end
  return nil
end
function class:PostEnterArtifact()
  MsgArtifact:Post("ENTER")
end
function class:PostInjectSoulStone()
  MsgArtifact:Post("INJECT_SOULSTONE")
end
function class:PostBuyInjectSoulStone(number)
  if number == nil then
    return
  end
  self.autoCostSoul = number
  MsgArtifact:Post("BUY_INJECT_SOULSTONE")
end
function class:PostBuySoulStone(id)
  if id == nil then
    return
  end
  self.buyId = id
  MsgArtifact:Post("BUY_SOULSTONE", {id = id})
end
function class:PostGetRankList()
  MsgArtifact:Post("GET_RANK_LIST")
end
function class:PostInjectSoulOnce()
  self.injectNum = 1
  MsgArtifact:Post("INJECT_SOUL_ONCE", {
    autoBuy = self.bAutoBuy
  })
end
function class:PostInjectSoulRepeatedly()
  self.injectNum = 50
  MsgArtifact:Post("INJECT_SOUL_REPEATEDLY", {
    autoBuy = self.bAutoBuy
  })
end
function class:PostSoulStoneExchange(id)
  if id == nil then
    return
  end
  MsgArtifact:Post("SOUL_STONE_EXCHANGE", {id = id})
end
function class:PostSoulStoneExchangeByType(id, count)
  if id == nil or count == nil then
    return
  end
  MsgArtifact:Post("SOUL_STONE_EXCHANGE_BY_TYPE", {id = id, count = count})
end
function class:OnEnterArtifact(code, data)
  if code ~= 0 then
    return
  end
  self.artlevel = data.level
  self.progress = data.progress
  self.soulStoneNum = data.normalSoulStone
  self.soulStoneSp[1] = data.primarySoulStone
  self.soulStoneSp[2] = data.middleSoulStone
  self.soulStoneSp[3] = data.seniorSoulStone
  self:FireEvent(EVT.ENTER)
end
function class:OnInjectSoulStone(code, data)
  if code ~= 0 then
    return
  end
  local bLvUp = data.level > self.artlevel
  self.artlevel = data.level
  self.progress = data.progress
  if bLvUp then
    self.soulStoneNum = self.soulStoneNum - data.number
  else
    self.soulStoneNum = data.number
  end
  self:FireEvent(EVT.INJECT_SOULSTONE, bLvUp)
end
function class:OnBuyInjectSoulStone(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(data)
  self.progress = self:UpgradeProgress()
  self.artlevel = self.artlevel + 1
  self.soulStoneNum = 0
  self:FireEvent(EVT.INJECT_SOULSTONE, true)
end
function class:OnBuySoulStone(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(data.costResults)
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  local strReward = Logic:Get("Reward"):AddDupiCardTip(data.rewardResults)
  Prompt:Msg(TwGetStr(105207) .. "\n" .. strReward)
end
function class:OnGetRankList(code, data)
  if code ~= 0 then
    return
  end
  self.rankList = data
  self:FireEvent(EVT.GETRANK)
end
function class:OnInjectSoulOnce(code, data)
  if code ~= 0 then
    return
  end
  local bLvUp = data.level - self.artlevel
  self.artlevel = data.level
  self.progress = data.progress
  self.critNum = data.critNum
  Logic:Get("Cost"):AddCosts(data.costResult)
  if data.stoneType == SOUL_STONE_TYPE.NORMAL then
    self.soulStoneNum = self.soulStoneNum - data.number
    self.soulStoneNum = 0 > self.soulStoneNum and 0 or self.soulStoneNum
  else
    self:SoulStoneReduce(data.stoneType, data.number)
  end
  self:FireEvent(EVT.INJECT_SOULSTONE, bLvUp)
end
function class:OnInjectSoulRepeatedly(code, data)
  if code ~= 0 then
    return
  end
  local bLvUp = data.level - self.artlevel
  self.artlevel = data.level
  self.progress = data.progress
  self.critNum = data.critNum
  Logic:Get("Cost"):AddCosts(data.costResult)
  self.soulStoneNum = self.soulStoneNum - data.soulStoneNumber
  self.soulStoneNum = 0 > self.soulStoneNum and 0 or self.soulStoneNum
  self:SoulStoneReduce(SOUL_STONE_TYPE.PRIMARY, data.primarySoulStone)
  self:SoulStoneReduce(SOUL_STONE_TYPE.MIDDLE, data.middleSoulStone)
  self:SoulStoneReduce(SOUL_STONE_TYPE.SENIOR, data.seniorSoulStone)
  self:FireEvent(EVT.INJECT_SOULSTONE, bLvUp)
  if data.haveInjected and data.haveInjected < 50 then
    if STOP_TYPE.MAX_LEVEL == data.stopType then
      Prompt:Fail(TwGetStr(105921, data.haveInjected))
      return
    end
    if STOP_TYPE.NO_ENOUGH_CURRENCY == data.stopType then
      Prompt:Fail(TwGetStr(105920, data.haveInjected))
      return
    end
  end
end
function class:OnSoulStoneExchange(code, data)
  if code ~= 0 then
    return
  end
  if data.costType == SOUL_STONE_TYPE.NORMAL then
    self.soulStoneNum = self.soulStoneNum - data.cost
    self.soulStoneNum = 0 > self.soulStoneNum and 0 or self.soulStoneNum
  else
    self:SoulStoneReduce(data.costType, data.cost)
  end
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  local str = Logic:Get("Reward"):AddRewardsTip(data.rewardResults)
  Prompt:Fail(str)
  self:FireEvent(EVT.SOUL_STONE_EXCHANGE)
end
function class:OnSoulStoneExchangeByType(code, data)
  self:OnSoulStoneExchange(code, data)
end
function class:GetIconByShowType(showtype)
  if showtype == nil then
    return "images/pulbic/clarity05.png"
  end
  if showtype == "SOUL_STONE" then
    return "images/BattleShow/soul_item.png"
  end
  local soulStoneImg = {
    "SOUL_STONE_1",
    "SOUL_STONE_2",
    "SOUL_STONE_3"
  }
  for k, v in pairs(soulStoneImg) do
    if v == showtype then
      return string.format("images/Artifact/soulStoneS%d.png", k)
    end
  end
  return "images/pulbic/clarity05.png"
end
