module((...), package.seeall)
local Define = require("BattleShow.BattleDefine")
local CCBAni = require("BattleShow.CCBAnimation")
local LAYER_LEVEL = Define.LAYER_LEVEL
local BUFF_OP = Define.REPROT_BUFF
class = objectlua.Object:subclass()
function class:initialize(owner)
  super.initialize(self)
  self.owner = owner
  self.layer = CCLayer:create()
  owner.rootNode:addChild(self.layer, LAYER_LEVEL.BUFF)
  local heroImg = self.owner:GetBindChild()
  local heroSize = heroImg:getContentSize()
  self.layer:setContentSize(heroSize)
  self.layer:setPosition(ccp(15, 25.5))
  self.layer:setScale(heroImg:getScale())
  self.buff = {}
end
function class:Oprator(id, op, hp, shield)
  local Dispatch = {
    [BUFF_OP.ADD] = "AddBuff",
    [BUFF_OP.REMOVE] = "RemoveBuff",
    [BUFF_OP.ACTIVE] = "ActiveBuff",
    [BUFF_OP.IMMUNE] = "CancelBuff"
  }
  self.hp = hp
  self.shield = shield
  local func = bind(self[Dispatch[op]], self)
  if func then
    func(id)
  end
end
function class:AddBuff(id)
  if self.buff[id] then
    self:RemoveBuff(id)
  end
  log4battle:debug("[AddBuff] " .. "id:" .. id .. " target:" .. self.owner:GetPosId())
  local effects = self:GetConduct(id, "Add")
  local Buff = require("BattleShow.Buff." .. effects.style)
  self.buff[id] = Buff.class:new(self.owner, self.layer, effects)
  self.buff[id]:Add(self.hp, self.shield)
end
function class:RemoveBuff(id)
  log4battle:debug("[RemoveBuff] " .. "id:" .. id .. " target:" .. self.owner:GetPosId())
  local buff = self:GetBuff(id)
  if buff == nil then
    return
  end
  local effects = self:GetConduct(id, "Remove")
  buff:Set(effects)
  buff:Remove()
  self.buff[id] = nil
end
function class:ActiveBuff(id)
  log4battle:debug("[ActiveBuff] " .. "id:" .. id .. " target:" .. self.owner:GetPosId())
  local buff = self:GetBuff(id)
  local effects = self:GetConduct(id, "Active")
  buff:Set(effects)
  buff:Active()
end
function class:CancelBuff(id)
  log4battle:debug("[CancelBuff] " .. "id:" .. id .. " target:" .. self.owner:GetPosId())
  local buff = self:GetBuff(id)
  local effects = self:GetConduct(id, "Cancel")
  buff:Set(effects)
  buff:Cancel()
end
function class:ChangeBuff(id)
  log4battle:debug("[CancelBuff] " .. "id:" .. id .. " target:" .. self.owner:GetPosId())
  local buff = self:GetBuff(id)
  local effects = self:GetConduct(id, "Change")
  buff:Set(effects)
  buff:Change()
end
function class:AddBuffsTo(node, level)
  for id, buff in pairs(self.buff) do
    if buff:GetType() == "Effect" then
      local effects = self:GetConduct(id, "Add")
      level = tonumber(effects.level or 0) or 0
      local effect = effects.effect
      local flip = effect and effect.flip and self.owner:IsEnemy()
      local scale = node:getScale()
      local ani = CCBAni.class:new(effect and effect.name, node, nil, level, flip, scale)
      ani:RunAnimation()
    end
  end
end
function class:GetBuff(id)
  return self.buff[id]
end
function class:GetLayer()
  return self.layer
end
function class:CleanUp()
  if self.layer then
    self.layer:removeAllChildrenWithCleanup(true)
  end
  self.buff = {}
end
function class:DeadClean()
  local buffs = {}
  for id, buff in pairs(self.buff) do
    local info = KFDBGetRecord("BuffConfig", id)
    local name = info and info.link
    if name ~= "REVIVE" then
      buff:Set({})
      buff:Remove()
    else
      buffs[id] = buff
      log4battle:debug("dead, relive id = %d", id)
    end
  end
  self.buff = buffs
end
function class:GetConduct(id, op)
  local effects = {style = "OutPut", level = 0}
  local info = KFDBGetRecord("BuffConfig", id)
  local name = info and info.link
  if not name or name == "" then
    log4battle:warn("BuffConfig have not link, id:%s !!", id)
    return effects
  end
  local state = json.decode(info.state)
  local info = KFDBGetRecord("BuffConduct", name)
  if nil == info then
    log4battle:warn("!! not exist name : " .. name)
    return effects
  end
  effects = {
    style = info.style,
    level = info.level,
    state = state.ctx.alters
  }
  local conduct
  if info[op] ~= nil and info[op] ~= "" then
    conduct = json.decode(info[op])
  end
  if conduct ~= nil then
    local effect = self:GetEffect(conduct[1])
    local action = self:GetEffect(conduct[2])
    effects.effect = effect
    effects.action = action
  end
  return effects
end
function class:GetEffect(id)
  local effect = id
  if id == nil or id == json.null then
    return effect
  end
  local Effect = require("BattleShow.SkillMap").EffectConfig
  local info = Effect[id]
  if nil ~= info then
    effect = info
  end
  return effect
end
