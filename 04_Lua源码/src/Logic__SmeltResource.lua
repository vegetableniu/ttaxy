module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({
  "REFRESH_LIST",
  "REFRESH_UNIT",
  "EXCHANGE"
})
local ERROR_CODE = TypeDef("com.eyu.mt.module.recycle.facade.RecycleResult")
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.recycle.facade.RecycleResult"))
local MSG_RESULT_STR = {
  HERO_IS_IN_USE = 108843,
  ACTIVITY_IS_NOT_OPEN = 108200,
  PLEASE_SELECT_THINGS_TO_RECYCLE = 108820,
  CURRENCY_IS_NNOT_ENOUGH = 108755,
  EQUIP_IS_EQUIPED = 108821,
  EQUIP_NOT_FOUND = 108822,
  TALISMAN_IS_EQUIPED = 108823,
  TALISMAN_NOT_FOUND = 108824,
  CAN_NOT_RECYCLE = 108825,
  HERO_IN_GROUP = 108826,
  HERO_NOT_FOUND = 108827,
  REPEAT_ID = 108828,
  HERO_LOCKED = 108829
}
function class:initialize()
  super.initialize(self)
  self.tempSmeltIds = {}
  self.smeltIds = {}
  self.smeltList = {}
  self.pool = 1
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgRecycle", MSG_RESULT, MSG_RESULT_STR)
  MsgRecycle:On("RECYCLE", self:Event("OnRecycle"))
end
function class:dispose()
  super.dispose(self)
end
function class:PostRecycle(isCost, recycleThings, count)
  self.count = count
  MsgRecycle:Post("RECYCLE", {cost = isCost, recycleThings = recycleThings})
end
function class:OnRecycle(code, data)
  if code == 0 then
    Logic:Get("Cost"):CostAndReward(data)
    self:promptTip(data.rewards)
    self:ClearSmeltList()
    self:FireEvent(EVT.EXCHANGE)
  end
end
function class:promptTip(rewards)
  local reward = {}
  for k, v in pairs(rewards or {}) do
    if self.pool == 2 then
      if v.amount > self.count then
        local otherCount = v.amount - self.count
        local temp1 = table.clone(v)
        local temp2 = table.clone(v)
        temp1.amount = self.count
        temp2.amount = otherCount
        table.insert(reward, temp1)
        table.insert(reward, temp2)
      else
        table.insert(reward, v)
      end
    else
      table.insert(reward, v)
    end
  end
  local str = ""
  for k, v in pairs(reward or {}) do
    if v.amount == self.count then
      str = str .. TwGetStr(103080) .. " " .. Logic:Get("Reward"):RewardTreaTip(v) .. "\n"
    else
      str = str .. TwGetStr(108850) .. " " .. Logic:Get("Reward"):RewardTreaTip(v) .. "\n"
    end
  end
  Prompt:Fail(str)
end
function class:getHeroList()
  self.smeltList = {}
  local heroId = Logic:Get("Hero"):GetUnbattlingHero(false)
  local allHeros = Logic:Get("Hero"):GetHeroInfosByIds(heroId)
  if not allHeros then
    return
  end
  for k, v in pairs(allHeros) do
    local info = Logic:Get("Hero"):GetHeroInfoByBaseId(v.baseId)
    local id = "HERO_ID:" .. v.baseId
    local recRecycle = self:getRecycleInfo(id)
    if recRecycle == nil then
      id = "CARD_TYPE:" .. info.card .. ":" .. info.rank .. ":" .. info.star
      recRecycle = self:getRecycleInfo(id)
    end
    if recRecycle and recRecycle.pool == self.pool then
      info.cardId = v.id
      info.type = "HERO"
      info.sort = 1
      info.cardInfo = v
      table.insert(self.smeltList, info)
    end
  end
  return self.smeltList
end
function class:getFabaoList()
  local data = Logic:Get("Talisman"):GetAllfabaos()
  for k, v in pairs(data or {}) do
    local id = "TALISMAN_ID:" .. v.baseId
    local recRecycle = self:getRecycleInfo(id)
    if v.equipHero == nil and recRecycle and recRecycle.pool == self.pool then
      local rec = KFDBGetRecord("TalismanSetting", v.baseId)
      local info = Logic:Get("Hero"):GetHeroInfoByBaseId(rec.baseId)
      info.cardId = v.id
      info.id = rec.id
      info.sort = 2
      info.type = info.card
      info.cardInfo = v
      table.insert(self.smeltList, info)
    end
  end
end
function class:getArmorList()
  local data = Logic:Get("Armor"):getUnEquipArmors()
  for k, v in pairs(data or {}) do
    local id = "EQUIP_ID:" .. v.baseId
    local recRecycle = self:getRecycleInfo(id)
    if v.equipHero == nil and recRecycle and recRecycle.pool == self.pool then
      local info = Logic:Get("Armor"):getArmorInfoByBaseId(v.baseId)
      info.cardId = v.id
      info.type = "EQUIPMENT"
      info.sort = 3
      info.cardInfo = v
      table.insert(self.smeltList, info)
    end
  end
end
function class:getSmeltList()
  self:getHeroList()
  self:getFabaoList()
  self:getArmorList()
  return self.smeltList or {}
end
function class:autoCheck()
  local data = self:getHeroList()
  local count = 5 - #self.tempSmeltIds
  local checkList = {}
  table.sort(data, function(param1, param2)
    local card1 = param1.card == "EXP_CARD" and 1 or 0
    local card2 = param2.card == "EXP_CARD" and 1 or 0
    if card1 ~= card2 then
      return card1 > card2
    end
    if param1.star ~= param2.star then
      return param1.star < param2.star
    end
    if param1.id == param2.id then
      return param1.cardId < param2.cardId
    end
    return param1.id < param2.id
  end)
  for k, v in pairs(data or {}) do
    if count == 0 then
      break
    end
    if v.star == 7 and not self:IsCheckSmelt(v.cardId) then
      table.insert(self.tempSmeltIds, v.cardId)
      table.insert(checkList, v.cardId)
      count = count - 1
    end
  end
  return self.tempSmeltIds, checkList
end
function class:AddToSmeltList(id)
  if not id then
    return
  end
  table.insert(self.tempSmeltIds, id)
end
function class:DelFromSmeltList(id)
  if not id then
    return
  end
  for k, v in ipairs(self.tempSmeltIds) do
    if v == id then
      table.remove(self.tempSmeltIds, k)
    end
  end
end
function class:GetCheckedSmeltList()
  return self.tempSmeltIds
end
function class:initTempSmeltList()
  self.tempSmeltIds = table.values(self.smeltIds) or {}
end
function class:finalySmeltList()
  self.smeltIds = table.values(self.tempSmeltIds) or {}
end
function class:ClearSmeltList()
  self.tempSmeltIds = {}
  self.smeltIds = {}
end
function class:IsSmeltFull()
  return #self.tempSmeltIds >= 5
end
function class:IsCheckSmelt(id)
  if not id then
    return false
  end
  for _, v in ipairs(self.tempSmeltIds) do
    if id == v then
      return true
    end
  end
  return false
end
function class:PostRefreshSmeltList()
  self:FireEvent(EVT.REFRESH_LIST)
end
function class:PostRefreshCell()
  self:FireEvent(EVT.REFRESH_UNIT)
end
function class:setPool(pool)
  self.pool = pool
end
function class:getSmeltInfoById(id)
  local info = Logic:Get("Hero"):GetHeroInfoById(id)
  if info then
    local rec = Logic:Get("Hero"):GetHeroInfoByBaseId(info.baseId)
    local id = "HERO_ID:" .. rec.id
    local recRecycle = self:getRecycleInfo(id)
    if recRecycle then
      return recRecycle
    end
    id = "CARD_TYPE:" .. rec.card .. ":" .. rec.rank .. ":" .. rec.star
    recRecycle = self:getRecycleInfo(id)
    if recRecycle then
      return recRecycle
    end
    return nil
  end
  info = Logic:Get("Talisman"):GetTailsmansByIds(id)
  if info then
    local rec = KFDBGetRecord("TalismanSetting", info.baseId)
    local id = "TALISMAN_ID:" .. rec.id
    local recRecycle = self:getRecycleInfo(id)
    if recRecycle then
      return recRecycle
    end
    return nil
  end
  info = Logic:Get("Armor"):getArmorInfoById(id)
  if info then
    local id = "EQUIP_ID:" .. info.baseId
    local recRecycle = self:getRecycleInfo(id)
    if recRecycle then
      return recRecycle
    end
    return nil
  end
end
function class:getRecycleInfo(id)
  local recRecycle = KFDBGetRecord("RecycleSetting", id)
  local playerLevel = Logic:Get("PlayerInfo"):GetPlayerLevel()
  if recRecycle then
    local levelTab = json.decode(recRecycle.levels or "[]") or {}
    local rateTab = json.decode(recRecycle.rates or "[]") or {}
    local costTab = json.decode(recRecycle.costs or "[]") or {}
    local fixCounts = json.decode(recRecycle.fixCounts or "[]") or {}
    local randomCounts = json.decode(recRecycle.randomCounts or "[]") or {}
    local goldCounts = json.decode(recRecycle.goldCounts or "[]") or {}
    local idx = 1
    for k, v in pairs(levelTab) do
      if v >= playerLevel then
        break
      end
      idx = idx + 1
    end
    local info = {}
    info.rate = rateTab[idx]
    info.cost = costTab[idx]
    info.fixCount = fixCounts[idx]
    info.randomCount = randomCounts[idx]
    info.goldCount = goldCounts[idx]
    info.pool = recRecycle.pool
    return info
  end
  return nil
end
function class:GetCoinPath(coinType)
  local path = "images/public/clarity05.png"
  if coinType and "" == coinType then
    path = "images/smelt/icon1.png"
  end
  local tab = {
    PURPLE = "images/smelt/icon1.png",
    ORANGE = "images/smelt/icon2.png",
    GOLD = "images/public/jade.png",
    INTER = "images/public/jade.png",
    GIFT = "images/public/jade.png",
    COPPER = "images/public/gold.png"
  }
  local rec = coinType
  if tab[rec] then
    path = tab[rec]
  end
  return path
end
