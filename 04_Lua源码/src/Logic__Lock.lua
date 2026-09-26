module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({
  "ENTER_WORLD"
})
LOCK_ID = Enum({
  "UPGRADE",
  "EVOLUTION",
  "SPEED_UP",
  "MALL",
  "ACHIEVEMENT",
  "ACTIVITY",
  "SKILL",
  "FOURTH_HERO",
  "FIFTH_HERO",
  "PVP",
  "LOTTERY_L0",
  "LOTTERY_L1",
  "LOTTERY_L2",
  "LOTTERY_TEN",
  "FIRST_HERO_GROUP",
  "SECOND_HERO_GROUP",
  "DEMOG",
  "CARD_PROTECT",
  "RED_CARD_COMPOSE",
  "GOLD_EVOLUTION",
  "TALISMAN_EQUIP_2_LOCK",
  "TALISMAN",
  "RecyclePool1",
  "RecyclePool2"
})
function class:initialize()
  super.initialize(self)
  self.lockList = {}
  for key, _ in pairs(LOCK_ID) do
    local rec = KFDBGetRecord("Lock", key)
    if rec then
      local data = {}
      data.level = tonumber(rec.level)
      data.campaign = rec.campaign
      data.battle = rec.battle
      data.charge = rec.charge
      data.activeBattle = rec.activeBattle
      data.lockId = LOCK_ID[rec.id]
      data.lock = true
      table.insert(self.lockList, data)
    end
  end
end
function class:OnReset()
end
function class:OnEnterWorld()
  self:CheckAllLocks()
  self:FireEvent(EVT.ENTER_WORLD)
end
function class:CheckAllLocks()
  for _, v in pairs(self.lockList) do
    v.lock = self:checkLock(v.level, v.campaign, v.battle, v.charge, v.activeBattle, v.eliteCampaign, v.eliteBattle)
  end
end
function class:checkLock(comparelevel, campaign, battle, charge, activeBattle, eliteCampaign, eliteBattle)
  local level = Logic:Get("PlayerInfo"):GetPlayerLevel()
  if comparelevel and comparelevel > level then
    return true
  end
  if battle ~= nil and "" ~= battle then
    local bBattle = Logic:Get("Battle"):IsBattleFinish(battle)
    if not bBattle then
      return true
    end
  end
  if charge ~= nil and charge > 0 then
    local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
    local totalCharge = wallet.totalCharge
    if charge > totalCharge then
      return true
    end
  end
  if activeBattle ~= nil and "" ~= activeBattle then
    local rec = Logic:Get("Battle"):GetBattleInfoById(activeBattle)
    if rec == nil then
      return false
    end
    local camRec = Logic:Get("Battle"):GetCampaignInfoById(rec.campaignId)
    if camRec and camRec.type == "NORMAL" then
      return false
    end
    if not Logic:Get("Rebirth"):IsClearActiveBattle(activeBattle) then
      return true
    end
  end
  if eliteBattle ~= nil and "" ~= eliteBattle and not Logic:Get("Elite"):IsClearBattle(eliteBattle) then
    return true
  end
  return false
end
function class:checkLockByLockId(lockId)
  for _, v in pairs(self.lockList) do
    if v.lockId == lockId then
      v.lock = self:checkLock(v.level, v.campaign, v.battle, v.charge, v.activeBattle, v.eliteCampaign, v.eliteBattle)
      return v.lock
    end
  end
  return nil
end
function class:GetStatusByLockId(lockId)
  for _, v in pairs(self.lockList) do
    if v.lockId == lockId then
      return v.lock
    end
  end
  return nil
end
function class:checkStatusById(id)
  local rec = KFDBGetRecord("Lock", id)
  if rec == nil or table.empty(rec) then
    return false
  end
  return self:checkLock(rec.level, rec.campaign, rec.battle, rec.charge, rec.activeBattle, rec.eliteCampaign, rec.eliteBattle)
end
function class:GetOpenLevelAndBattle(lockId)
  for _, v in pairs(self.lockList) do
    if v.lockId == lockId then
      local name = ""
      if v.battle and "" ~= v.battle then
        name = Logic:Get("Battle"):GetBattleName(v.battle)
      end
      return v.level, name
    end
  end
  return 0, ""
end
function class:GetOpenLevelAndEliteBattle(lockId)
  if lockId == nil or "" == lockId then
    return 0, "", ""
  end
  local rec = KFDBGetRecord("Lock", lockId)
  if rec == nil or table.empty(rec) then
    return 0, "", ""
  end
  local battleName = ""
  if rec.eliteBattle and rec.eliteBattle ~= "" then
    battleName = Logic:Get("Battle"):GetBattleName(rec.eliteBattle)
  end
  return rec.level, battleName
end
function class:GetLevelAndBattleNames(lockId)
  if lockId == nil or "" == lockId then
    return 0, "", ""
  end
  local rec = KFDBGetRecord("Lock", lockId)
  if rec == nil or table.empty(rec) then
    return 0, "", ""
  end
  local battleName = ""
  if rec.battle and rec.battle ~= "" then
    battleName = Logic:Get("Battle"):GetBattleName(rec.battle)
  end
  local activeName = ""
  if rec.activeBattle and rec.activeBattle ~= "" then
    activeName = Logic:Get("Battle"):GetBattleName(rec.activeBattle)
  end
  return rec.level, battleName, activeName
end
function class:showLockTip(lockId)
  if lockId == nil then
    return
  end
  local level, copyName = self:GetOpenLevelAndBattle(lockId)
  if nil ~= copyName and "" ~= copyName then
    local str = TwGetStr(105403, level) .. "\n" .. TwGetStr(105401, copyName)
    Prompt:PopTip(str)
  else
    Prompt:PopTip(TwGetStr(105402, level))
  end
end
function class:showLockTipById(id)
  if id == nil then
    return
  end
  local rec = KFDBGetRecord("Lock", id)
  if table.empty(rec or {}) then
    return
  end
  local level = rec.level
  local name = ""
  if rec.battle and "" ~= rec.battle then
    name = Logic:Get("Battle"):GetBattleName(rec.battle)
  end
  if nil ~= name and "" ~= name then
    local str = TwGetStr(105403, level) .. "\n" .. TwGetStr(105401, name)
    Prompt:PopTip(str)
  else
    Prompt:PopTip(TwGetStr(105402, level))
  end
end
function class:closeLockTip(event)
  if event == nil then
    return
  end
  if event == CCControlEventTouchUpOutside or event == CCControlEventTouchUpInside or event == CCControlEventTouchCancel or event == CCControlEventTouchDragExit then
    Logic:Get("SureConfirm"):FireEvent(Logic.SureConfirm.EVT.CLOSE_POPTIP)
  end
end
function class:IsNeedWeekVip(key)
  local rec = KFDBGetRecord("Lock", key)
  if rec == nil or table.empty(rec) then
    return false
  end
  return rec.week == "true" or rec.week == "TRUE"
end
function class:IsNeedMonthVip(key)
  local rec = KFDBGetRecord("Lock", key)
  if rec == nil or table.empty(rec) then
    return false
  end
  return rec.vip == "true" or rec.vip == "TRUE"
end
