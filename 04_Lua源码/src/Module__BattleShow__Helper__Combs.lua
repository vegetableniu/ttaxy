module((...), package.seeall)
class = objectlua.Mixin:new()
function class:initialize()
end
function class:ForeachShieldAndHp(hp, target, shield, combs, status, callback)
  local bCrit = status:IsStatus("CRIT")
  local notCritStatus = status:RemoveStatus("CRIT")
  if hp < 0 and shield > 0 or hp > 0 and shield < 0 then
    shield = -shield or shield
  end
  self.remainHp = target:GetHp()
  local function CallBack(tgt, v, sv, sts, times, bLast)
    if nil ~= callback then
      callback(tgt, v, sv, sts, times, bLast)
    end
  end
  if combs < 2 or (hp == nil or hp == 0) and (shield or shield == 0) then
    CallBack(target, hp, shield, status, 0, true)
    return
  end
  local cnt = 0
  local valueList, hpList = self:GetShieldListByCombs(shield, hp, combs)
  valueList, hpList = self:GetCritShieldAndHpList(valueList, hpList, bCrit)
  local totleTimes = #valueList + #hpList
  for _, sv in ipairs(valueList) do
    local bLastTime = cnt + 1 == totleTimes
    local sign = bCrit and bLastTime and status or notCritStatus
    CallBack(target, 0, sv, sign, cnt, bLastTime)
    cnt = cnt + 1
  end
  for _, v in ipairs(hpList) do
    local bLastTime = cnt + 1 == totleTimes
    local sign = bCrit and bLastTime and status or notCritStatus
    CallBack(target, v, 0, sign, cnt, bLastTime)
    cnt = cnt + 1
  end
end
function class:GetHpListByCombs(hp, remainHp, combs)
  local hpList = {}
  local hpSum = 0
  if combs > 1 and 0 ~= hp and nil ~= hp then
    local hpPart = math.floor(hp / combs)
    for i = 1, combs - 1 do
      table.insert(hpList, hpPart)
      hpSum = hpSum + hpPart
      if remainHp + hpSum <= 0 then
        return hpList
      end
    end
    if hp - hpSum ~= 0 then
      table.insert(hpList, hp - hpSum)
    end
  end
  return hpList
end
function class:GetValueList(value, combs)
  if value == 0 or combs == 0 then
    return {}
  end
  local valueList = {}
  local valuePart = math.floor(value / combs)
  for i = 1, combs - 1 do
    table.insert(valueList, valuePart)
  end
  local remian = value - (combs - 1) * valuePart
  if remian == 0 or not remian then
    remian = nil
  end
  table.insert(valueList, remian)
  return valueList
end
function class:GetCritShieldAndHpList(shieldList, hpList, bCrit)
  if #hpList >= 1 then
    return shieldList, self:GetCritValueList(hpList, bCrit)
  end
  return self:GetCritValueList(shieldList, bCrit), hpList
end
function class:GetCritValueList(valueList, bCrit)
  local len = #valueList
  if not bCrit or len <= 1 then
    return valueList
  end
  local retList = {}
  local critValue = valueList[len] + valueList[len - 1]
  local sumValue = 0
  for i = 1, len - 2 do
    sumValue = sumValue + valueList[i]
  end
  retList = self:GetValueList(sumValue, len - 1)
  table.insert(retList, critValue)
  return retList
end
function class:GetShieldListByCombs(shield, hp, combs)
  shield = shield or 0
  local shieldList = {}
  local HpList = {}
  if combs > 1 then
    local shieldWeight = shield / (shield + hp)
    local shieldCombs = math.ceil(combs * shieldWeight)
    local hpCombs = combs - shieldCombs
    shieldList = self:GetValueList(shield, shieldCombs)
    HpList = self:GetHpListByCombs(hp, self.remainHp, hpCombs)
  end
  return shieldList, HpList
end
