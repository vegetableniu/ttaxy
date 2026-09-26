module((...), package.seeall)
local CCBAni = require("BattleShow.CCBAnimation")
local Define = require("BattleShow.BattleDefine")
local LAYER_LEVEL = Define.LAYER_LEVEL
local BUFF_LAYER = {}
class = objectlua.Object:subclass()
local PicMap = {
  ATTACK = "images/Cultivate/ATTACK",
  LIFE = "images/Cultivate/LIFE",
  RATE_DODGY = "images/Cultivate/RATE_DODGY",
  RATE_HIT = "images/Cultivate/RATE_HIT",
  RATE_CRIT = "images/Cultivate/RATE_CRIT",
  RATE_HURT_CRIT = "images/Cultivate/RATE_HURT_CRIT",
  RATE_HARM_P = "images/Cultivate/RATE_HARM_P",
  RATE_HARM_M = "images/Cultivate/RATE_HARM_M",
  RATE_UNHARM_P = "images/Cultivate/RATE_UNHARM_P",
  RATE_UNHARM_M = "images/Cultivate/RATE_UNHARM_M",
  RATE_UNCRIT = "images/Cultivate/RATE_UNCRIT",
  RATE_UNHURT_CRIT = "images/Cultivate/RATE_UNHURT_CRIT"
}
function class:initialize(target, layer, effects)
  super.initialize(self)
  self.layer = layer
  self.effects = effects
  self.isEnemy = target:IsEnemy()
end
function class:dispose()
  super.dispose(self)
end
function class:Set(effects)
  self.effects = effects
end
function class:Add()
  local effect = self.effects.effect
  local action = self.effects.action
  local state = self.effects.state
  local level = tonumber(self.effects.level or 0) or 0
  local flip = effect and effect.flip and self.isEnemy
  local scale = self.layer:getScale()
  self.ani = CCBAni.class:new(effect and effect.name, self.layer, nil, level, flip, scale)
  if self.ani then
    self:AddAttrTo(state)
    self.ani:RunAnimation()
  end
end
function class:Remove()
  if self.ani then
    self.ani:RemoveAnimation()
    self.ani = nil
  end
  local effect = self.effects.effect
  local action = self.effects.action
  local level = tonumber(self.effects.level or 0) or 0
  local flip = effect and effect.flip and self.isEnemy
  local scale = self.layer:getScale()
  local ani = CCBAni.class:new(effect and effect.name, self.layer, nil, level, flip, scale)
  ani:RunAnimationAutoRemove()
end
function class:Active()
end
function class:Cancel()
end
function class:Change()
end
function class:GetType()
  return "Effect"
end
function class:AddAttrTo(state)
  if type(state) ~= "table" then
    return
  end
  local put = {}
  for attr, value in pairs(state) do
    if PicMap[attr] then
      table.insert(put, {attr = attr, value = value})
    end
  end
  if table.empty(put) then
    return
  end
  local count = 0
  for _, content in ipairs(put) do
    count = count + 1
    if count > 2 then
      return
    end
    local direct = 0 < tonumber(content.value) and "_UP.png" or "_DOWN.png"
    local path = PicMap[content.attr] .. direct
    local sprite = CCSprite:create(path)
    if sprite and self.ani:GetChild("attr" .. count) then
      self.ani:GetChild("attr" .. count):setDisplayFrame(sprite:displayFrame())
    end
    local sprite = CCSprite:create(path)
    if sprite and self.ani:GetChild("attrLight" .. count) then
      self.ani:GetChild("attrLight" .. count):setDisplayFrame(sprite:displayFrame())
    end
  end
end
