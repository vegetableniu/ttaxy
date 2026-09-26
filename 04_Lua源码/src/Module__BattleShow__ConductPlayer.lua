module((...), package.seeall)
require("Logic")
class = objectlua.Object:subclass()
function class:initialize(mgr, params)
  super.initialize(self)
  self.mgr = mgr
  self.parentLayer = mgr.mMainLayer
  self.beforeAction = params.beforeAct
  self.action = params.act
  self.nextAction = params.nextAct
  self.endsConduct = params.endAct
  self.owner = Logic:Get("RoleView"):Find(self.action.owner)
  self.isMultiHit = self:IsMultiTarget()
  self:Play()
end
function class:Play()
  local info = KFDBGetRecord("SkillConfig", self.action.skill) or {}
  local skillInfo
  if info and info.conduct then
    skillInfo = self:GetSkillStageInfo(info.conduct)
  end
  skillInfo = skillInfo or self:GetSkillStageInfo(0)
  local combs = tonumber(info and info.combs or 0)
  skillInfo.combs = combs
  self.info = skillInfo
  local ActionPlayer = require("BattleShow.Action." .. skillInfo.actStyle)
  if not ActionPlayer then
    log4battle:warn("action type not exist! : " .. skillInfo.actStyle)
    return
  end
  ActionPlayer.class:new(self)
end
function class:IsMultiTarget()
  local count = 0
  for _, target in ipairs(self.action.targets) do
    local targetUnit = Logic:Get("RoleView"):Find(target.target)
    if self.owner:IsEnemy() ~= targetUnit:IsEnemy() then
      count = count + 1
    end
  end
  if count < 2 then
    return false
  end
  return true
end
function class:GetSkillStageInfo(id)
  local ConductMap = require("BattleShow.SkillMap").Conduct
  local conduct = ConductMap[id]
  if not conduct then
    log4battle:warn("conductId not exist! :" .. id)
    return nil
  end
  local EffectMap = require("BattleShow.SkillMap").EffectConfig
  local function GetEffectMap(effect)
    if type(effect) == "string" then
      return EffectMap[effect]
    end
    if type(effect) == "table" then
      local map = {}
      for _, cell in ipairs(effect) do
        table.insert(map, {
          effect = EffectMap[cell]
        })
      end
      return map
    end
  end
  local ani = {
    actStyle = conduct.style,
    stage1 = {
      effect = GetEffectMap(conduct.atkact),
      sound = conduct.atkSound
    },
    stage2 = {
      effect = GetEffectMap(conduct.atkeffect)
    },
    stage3 = {
      effect = GetEffectMap(conduct.defact),
      sound = conduct.defSound
    },
    stage4 = {
      effect = GetEffectMap(conduct.defeffect)
    },
    stage5 = {
      effect = GetEffectMap(conduct.mageffect)
    },
    feedback = {
      effect = GetEffectMap(conduct.fbeffect)
    },
    delay = conduct.delay,
    param = conduct.param,
    adjust = conduct.adjust
  }
  return ani
end
