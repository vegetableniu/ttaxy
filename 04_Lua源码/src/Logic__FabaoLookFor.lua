module((...), package.seeall)
require("Logic")
require("MsgTalisman")
require("SceneHelper")
class = Logic.class:subclass()
GOLD_LOOK_FOOR_TYPE = "VCOIN"
COIN_LOOK_FOOR_TYPE = "SILVER"
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.treasure.facade.TreasureResult"))
local MSG_RESULT_STR = {
  TREASURE_PACK_EMPTY = 103043,
  TREASURE_PACK_FULL = 103042,
  HERO_PACK_FULL = 103048,
  MUST_VIP = 103047,
  TALISMAN_PACK_FULL = 105972,
  TALISMAN_PACK_CAPACITY_IS_NOT_ENOUGH = 105973,
  TALISMAN_PACK_FULL = 111011
}
EVT = Enum({
  "REFRESH_INFO",
  "REFRESH_LOOKFOR",
  "REFRESH_CONFIG",
  "REFRESH_TREA",
  "REFRESH_SELE_HERO",
  "REFRESH_AUTO_LOOKFOR",
  "REFRESH_OPEN_DRAGON_KING"
})
local NORMAL_RANK_NUM = 4
function class:initialize()
  super.initialize(self)
  self.fabaoTmpPackInfo = {}
  self.rewardResult = {}
  self.seleHeroIds = {}
  self.heroSeleCur = {}
  self.rewardResultArr = {}
  self.skillHero = {}
  self.bRankUp = false
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgTalisman", MSG_RESULT, MSG_RESULT_STR)
  MsgTalisman:On("GET_TALISMAN_TMP_PACK_INFO", self:Event("OnTempPackInfo"))
  MsgTalisman:On("LOOKFOR", self:Event("OnLookFor"))
  MsgTalisman:On("AUTO_LOOKFOR", self:Event("OnAutoLookFor"))
  MsgTalisman:On("RECEIVE", self:Event("OnReceive"))
end
function class:PostInfo()
  MsgTalisman:Post("GET_TALISMAN_TMP_PACK_INFO", {})
end
function class:OnTempPackInfo(code, content)
  if code ~= 0 then
    return
  end
  self.fabaoTmpPackInfo = content
  self:FireEvent(EVT.REFRESH_INFO)
end
function class:ClearTempPack()
  self.fabaoTmpPackInfo = self.fabaoTmpPackInfo or {}
  self.fabaoTmpPackInfo.treasures = {}
end
function class:PostLookFor()
  MsgTalisman:Post("LOOKFOR")
end
function class:OnLookFor(code, content)
  if nil == content then
    return
  end
  local rank = self:GetFabaoRank()
  if rank then
    self.bRankUp = rank < content.rank
  else
    self.bRankUp = false
  end
  Logic:Get("Cost"):AddCosts(content.costs)
  self.fabaoTmpPackInfo = self.fabaoTmpPackInfo or {}
  self.fabaoTmpPackInfo.rank = content.rank
  self:AddFabaoTreasures(content.treasures)
  self:FireEvent(EVT.REFRESH_LOOKFOR)
end
function class:GetFabaoRank()
  return self.fabaoTmpPackInfo and self.fabaoTmpPackInfo.rank or nil
end
function class:IsYaoChiRank()
  local rank = self:GetFabaoRank()
  if not rank then
    return false
  end
  return rank > NORMAL_RANK_NUM
end
function class:SetFabaoRank(rank)
  self.fabaoTmpPackInfo = self.fabaoTmpPackInfo or {}
  self.fabaoTmpPackInfo.rank = rank
end
function class:AddFabaoTreasures(treasures)
  self.fabaoTmpPackInfo = self.fabaoTmpPackInfo or {}
  self.fabaoTmpPackInfo.treasures = self.fabaoTmpPackInfo.treasures or {}
  for _, id in ipairs(treasures or {}) do
    table.insert(self.fabaoTmpPackInfo.treasures, id)
  end
end
function class:PostAutoLookFor()
  MsgTalisman:Post("AUTO_LOOKFOR")
end
function class:OnAutoLookFor(code, content)
  if nil == content then
    return
  end
  self.autoLookFor = content
  for _, info in ipairs(content) do
    Logic:Get("Cost"):AddCosts(info.costs)
  end
  self:FireEvent(EVT.REFRESH_AUTO_LOOKFOR)
end
function class:PostReceive()
  MsgTalisman:Post("RECEIVE", {})
end
function class:OnReceive(code, content)
  self.rewardResult = content
  if self.rewardResult.rewards then
    Logic:Get("Reward"):AddRewards(self.rewardResult.rewards)
    Logic:Get("WeChat"):Tailisman(self.rewardResult.rewards)
  end
  SceneHelper:pushPrompt("FabaoLookForTip", nil)
  self:ClearTempPack()
  self:FireEvent(EVT.REFRESH_INFO)
end
function class:GetTreasurePackVo()
  return self.fabaoTmpPackInfo
end
function class:GetAutoLookFor()
  return self.autoLookFor
end
function class:GetRewardResult()
  return self.rewardResult
end
function class:CheckRankCost(rank)
  rank = rank or self:GetFabaoRank()
  if nil == rank then
    return false
  end
  local rankInfo = KFDBGetRecord("TaSearchRankConfig", rank)
  if nil == rankInfo then
    return false
  end
  local money = Logic:Get("PlayerInfo"):GetPlayerMoneyByType(json.decode(rankInfo.costTypes))
  return money >= tonumber(rankInfo.costs)
end
function class:GetTempPackMaxNum()
  local TEMP_PACK_SIZE = "TALISMAN:TMP_PACK_SIZE"
  local info = KFDBGetRecord("ConfigValue", TEMP_PACK_SIZE)
  if nil == info then
    return 0
  end
  return tonumber(info.content)
end
function class:GetTemCurSize()
  local treasures = self.fabaoTmpPackInfo and self.fabaoTmpPackInfo.treasures or {}
  local curSize = treasures and #treasures or 0
  return curSize
end
function class:CheckPackFull()
  local maxNum = self:GetTempPackMaxNum()
  local treasures = self.fabaoTmpPackInfo and self.fabaoTmpPackInfo.treasures or {}
  local curSize = treasures and #treasures or 0
  return maxNum > curSize
end
function class:GetOpenXunXianCost()
  local COST_STR = "TALISMAN:ACCESS_DRAGON_KING_COST"
  local costInfo = KFDBGetRecord("ConfigValue", COST_STR)
  local COST_TYPE = "TALISMAN:ACCESS_DRAGON_KING_COST_TYPE"
  local costTypeInfo = KFDBGetRecord("ConfigValue", COST_TYPE)
  return costInfo and tonumber(costInfo.content) or nil, costTypeInfo and costTypeInfo.content or nil
end
function class:IsGetTrea()
  return self:CheckRankCost(1)
end
function class:GetTreaRewStrTip(rewards, solds)
  local str = {}
  str[1] = {}
  str[1].strR = TwGetStr(103077)
  str[1].strK = 7
  local num = 2
  local rewardsCode = Logic:Get("Reward"):FabaocomRewards(rewards)
  rewardsCode[0] = {}
  local curr = rewardsCode[0][0]
  local reward = rewardsCode[rewards[1].type][rewards[1].code]
  while reward do
    str[num] = {}
    str[num].strR = Logic:Get("Reward"):RewardTreaTip(reward)
    local rec = KFDBGetRecord("TalismanSetting", reward.code)
    if rec ~= nil then
      local Fabao = Logic:Get("Hero"):GetHeroInfoByBaseId(rec.baseId)
      if Fabao and Fabao.rank then
        str[num].strK = Fabao.rank
      end
    else
      str[num].strK = 1
    end
    num = num + 1
    if rewards[num - 1] then
      reward = rewardsCode[rewards[num - 1].type][rewards[num - 1].code]
    else
      reward = nil
    end
  end
  if solds > 0 then
    str[num] = {}
    str[num].strR = ""
    str[num].strK = 7
    str[num + 1] = {}
    str[num + 1].strR = TwGetStr(103078)
    str[num + 1].strK = 7
    str[num + 2] = {}
    str[num + 2].strR = TwGetStr(103079) .. "*" .. solds
    str[num + 2].strK = 7
    str[num + 3] = {}
    str[num + 3].strR = Logic:Get("Reward"):RewardTreaTip(curr)
    str[num + 3].strK = 7
  end
  local strNew = {}
  local strEmpty = {strR = "", strK = 7}
  if #str < 10 then
    for i = 1, #str do
      table.insert(strNew, str[i])
    end
    return strNew
  else
    return str
  end
end
function class:setHunting(hunting)
  self.hunting = hunting or nil
end
function class:isHunting()
  return self.hunting
end
function class:setDrawing(drawing)
  self.drawing = drawing or nil
end
function class:isDrawing()
  return self.drawing
end
function class:isRankUp()
  return self.bRankUp
end
