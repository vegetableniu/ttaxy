local Define = require("Scene.Define")
require("UIDefine")
module((...), package.seeall)
PART = Enum({
  "MOUNT",
  "MODEL",
  "WEAPON"
})
ACTION = Enum({
  "STAND",
  "RUN",
  "ATTACK",
  "MAGIC",
  "HIT1",
  "FSTAND",
  "MSTAND",
  "MRUN",
  "EXTEND1",
  "EXTEND2",
  "EXTEND3"
})
DIR = Enum({
  "R",
  "RU",
  "U",
  "LU",
  "L",
  "LD",
  "D",
  "RD"
})
HIT_TEST_TYPE = Enum({"NODESET", "BODY"})
local DEFAULT_MODEL = "role_default"
local SHADOW_H = "shadow_one"
local SHADOW_O = "shadow_two"
local DEFAULT_MODEL_NAME_H = -140
DEFUALT_NAME_OFF_HEAD_H = -30
local internal = {}
class = objectlua.Object:subclass()
function class:initialize(scene, actionMgr, mode)
  super.initialize(self)
  self.scene = scene
  self.actionMgr = actionMgr
  self.mode = mode
  self.dir = DIR.R
  self.action = ACTION.STAND
  self.roleType = 0
  self.parts = {}
  self.partsId = {}
  self.effects = {}
  self.notExistPart = {}
  self.partReady = {}
  self.hitTestType = HIT_TEST_TYPE.BODY
  self.modelChgCallback = nil
  self.syncModel = false
  self.sceneNode = Tw.Scene.NodeSet:new(self.scene)
  self.scene:Attach(self.sceneNode)
  self:SetupShadow()
  self.effectBg = Tw.Scene.AnimationSet:new(self.scene)
  self.sceneNode:Attach(internal.LAYER.EFFECT_BG, self.effectBg, internal.LAYER.EFFECT_BG)
  self.model = Tw.Scene.AnimationSet:new(self.scene)
  self.sceneNode:Attach(internal.LAYER.MODEL, self.model, internal.LAYER.MODEL)
  self.name = Tw.Scene.Text:new(self.scene)
  self.sceneNode:Attach(internal.LAYER.HUD, self.name, internal.LAYER.HUD)
  self.name:SetPos(TwPoint(0, 0))
  self.name:SetStyle(UIDefine.RENDER_TEXT_STYLE.SHADOW)
  self.name:SetAlign(Tw.Scene.TEXT_ALIGN_CENTER)
  self.effectFg = Tw.Scene.AnimationSet:new(self.scene)
  self.sceneNode:Attach(internal.LAYER.EFFECT_FG, self.effectFg, internal.LAYER.EFFECT_FG)
  for k, v in pairs(PART) do
    self.partsId[v] = 0
    self.parts[v] = Tw.Scene.Animation:new(self.scene)
    self.parts[v]:SetVisible(false)
    self.model:Attach(v, self.parts[v], v)
  end
end
function class:dispose()
  super.dispose(self)
end
function class:Scene()
  return self.scene
end
function class:GetSceneNode()
  return self.sceneNode
end
function class:SetSyncModel(bSync)
  self.syncModel = bSync
end
function class:SetPos(pos)
  self.sceneNode:SetPos(TwPoint(pos.x, pos.y))
end
function class:GetPos()
  local pos = self.sceneNode:GetPos()
  return {
    x = pos.x,
    y = pos.y
  }
end
function class:SetScale(scale)
  self.sceneNode:SetScale(scale)
end
function class:GetScale()
  return self.sceneNode:GetScale()
end
function class:SetDir(dir)
  if self.dir == dir then
    return
  end
  local action = self:MapAction(self.action)
  local dirOld, flipOld = internal:MapDir(self.mode, action, self.dir)
  local dirNew, flipNew = internal:MapDir(self.mode, action, dir)
  self.dir = dir
  if dirOld == dirNew and flipOld == flipNew then
    return
  end
  self:Update()
end
function class:GetDir()
  return self.dir
end
function class:SetAction(action)
  if self.action == action then
    if self:IsReady() then
      self:QuickUpdateModel()
      return
    end
  else
    self.notExistPart = {}
    self.partReady = {}
  end
  self.action = action
  self:Update()
end
function class:GetAction()
  return self.action
end
function class:SetAlpha(alpha)
  self.sceneNode:SetAlpha(alpha)
end
function class:GetAlpha()
  return self.sceneNode:GetAlpha()
end
function class:SetRoleType(roleType)
  self.roleType = roleType
  self:Update()
end
function class:GetRoleType()
  return self.roleType
end
function class:SetModel(id)
  id = id or 0
  if self:GetModel() == id then
    return
  end
  self:SetPart(PART.MODEL, id)
  self:Update()
end
function class:GetModel()
  return self.partsId[PART.MODEL]
end
function class:SetWeapon(id)
  id = id or 0
  if self:GetWeapon() == id then
    return
  end
  self:SetPart(PART.WEAPON, id)
  self:Update()
end
function class:GetWeapon()
  return self.partsId[PART.WEAPON]
end
function class:SetMount(id)
  id = id or 0
  if self:GetMount() == id then
    return
  end
  self:SetPart(PART.MOUNT, id)
  self:Update()
end
function class:GetMount()
  return self.partsId[PART.MOUNT]
end
function class:SetName(name)
  self.name:SetText(name)
end
function class:SetNameFontSize(size)
  self.name:SetFontSize(size or 20)
end
function class:SetHpValue(hp)
  hp = hp < 0 and 0 or 1 or hp
  self.hpPrg:SetValue(hp)
end
function class:AddHpPrg()
  self.hpPrg = Tw.Scene.Progress:new(self.scene, ANI_ID("ui", "battle_bldbkg"), ANI_ID("ui", "battlle_bld"))
  self.sceneNode:Attach(internal.LAYER.HUD, self.hpPrg, internal.LAYER.HUD)
end
function class:HitTest(ptSrn)
  if self.hitTestType == HIT_TEST_TYPE.BODY then
    return self.parts[PART.MODEL]:HitTest(ptSrn)
  elseif self.hitTestType == HIT_TEST_TYPE.NODESET then
    return self.sceneNode:HitTest(ptSrn)
  end
  return false
end
function class:SetHitTestType(type)
  self.hitTestType = type
end
function class:AddEffect(title, fg, loop, headOffset)
  self:DelEffect(title)
  local set = fg and self.effectFg or self.effectBg
  local ani = Tw.Scene.Animation:new(self.scene)
  set:Attach(Tw.Scene.NodePtrAsId(ani), ani)
  local id = internal:EffectAniId(title)
  ani:SetAni(id, true)
  if headOffset then
    local posHead = self:GetCurHeadOffset()
    posHead.x = posHead.x + headOffset.x
    posHead.y = posHead.y + headOffset.y
    ani:SetPos(posHead)
  end
  local action = self.actionMgr:Wait(Tw.Scene.AnimationTime(id))
  if not loop then
    action = self.actionMgr:Seq(action, self.actionMgr:Do(function()
      self:DelEffect(title)
    end))
  else
    action = self.actionMgr:Seq(self.actionMgr:Call(function()
      ani:SetFrame(0)
    end), action)
    action = self.actionMgr:Repeat(action)
  end
  self.scene:GetActionMgr():Add(self.sceneNode, action)
  self.effects[title] = {
    set = set,
    ani = ani,
    action = action,
    headOffset = headOffset
  }
end
function class:RefreshEffectPos()
  for _, info in pairs(self.effects) do
    if info.headOffset then
      local posHead = self:GetCurHeadOffset()
      posHead.x = posHead.x + info.headOffset.x
      posHead.y = posHead.y + info.headOffset.y
      info.ani:SetPos(posHead)
    end
  end
end
function class:HasEffect(title)
  return nil ~= self.effects[title]
end
function class:DelEffect(title)
  local effect = self.effects[title]
  if effect == nil then
    return
  end
  self.effects[title] = nil
  self.scene:GetActionMgr():Del(self.sceneNode, effect.action)
  effect.set:Detach(Tw.Scene.NodePtrAsId(effect.ani))
  effect.ani:delete()
end
function class:ClearEffect()
  for title, data in pairs(self.effects) do
    self:DelEffect(title)
  end
  self.effects = {}
end
function class:CalcActionTime(action, frame)
  local modelId = self.partsId[PART.MODEL]
  local part = PART[modelId ~= 0 and "MODEL" or "MOUNT"]
  if self.partsId[part] == 0 then
    return 0
  end
  local dir = internal:MapDir(self.mode, action, self.dir)
  local ani = self:GetPartAniId(part, action, dir)
  local time = Tw.Scene.AnimationTime(ani, frame or 0)
  if 0 == time then
  end
  return time
end
function class:SetupShadow()
  assert(self.shadow == nil)
  self.shadow = Tw.Scene.Image:new(self.scene)
  self.sceneNode:Attach(internal.LAYER.SHADOW, self.shadow, internal.LAYER.SHADOW)
  local horizontal = self.mode == Define.MODE.HORIZONTAL
  local title = horizontal and SHADOW_H or SHADOW_O
  local aniId = ANI_ID(ANI.UI, title)
  self.shadow:SetAni(aniId)
end
function class:SetPart(part, id)
  if nil == id then
    id = 0
  end
  if type(id) == "string" then
    id = tonumber(id)
  end
  self.partsId[part] = id
  self:ModelChanged()
end
function class:Update()
  local action = self:MapAction(self.action)
  local dir, flip = internal:MapDir(self.mode, action, self.dir)
  if not self:IsAllPartExist(dir, action) then
    self:ShowDefaultModel()
    self:UpdateNamePos(dir, action)
    return
  end
  self.model:SetFlip(flip)
  local mountId = self.partsId[PART.MOUNT]
  local offset = internal:GetMountOffset(mountId, self.roleType, self.mode, action, flip)
  for k, v in pairs(PART) do
    self:UpdatePart(dir, v, offset)
  end
  if not self:IsAllPartReady() then
    self:ShowDefaultModel()
  end
  self:UpdateNamePos(dir, action)
end
function class:ShowDefaultModel()
  for _, part in pairs(PART) do
    local ani = self.model:Get(part)
    ani:SetVisible(false)
  end
  local aniId = ANI_ID(ANI.UI, DEFAULT_MODEL)
  local model = self.model:Get(PART.MODEL)
  model:SetAni(aniId)
  model:SetPos(TwPoint(0, 0))
  model:SetVisible(true)
end
function class:IsAllPartExist(dir, action)
  for name, part in pairs(PART) do
    local partId = self.partsId[part]
    if self.notExistPart[partId] then
      return false
    end
    if partId > 0 then
      local ani = self:GetPartAniId(part, action, dir)
      if not Tw.Scene.IsAniExist(ani) then
        self.notExistPart[partId] = true
        return false
      else
        self.notExistPart[partId] = false
      end
    end
  end
  return true
end
function class:IsReady()
  if table.empty(self.partReady) then
    return false
  end
  for id, state in pairs(self.partReady) do
    if not state then
      return false
    end
  end
  return true
end
function class:ModelChanged()
  if self.modelChgCallback then
    self.modelChgCallback()
  end
  self:RefreshEffectPos()
end
function class:SetModelChgCallback(callback)
  self.modelChgCallback = callback
end
function class:IsAllPartReady()
  local bChg = false
  for name, part in pairs(PART) do
    local partId = self.partsId[part]
    if partId > 0 and not self.partReady[partId] then
      if not self.parts[part]:IsReady() then
        self.partReady[partId] = false
        return false
      else
        self.partReady[partId] = true
        bChg = true
      end
    end
  end
  if bChg then
    self:ModelChanged()
  end
  return true
end
function class:UpdatePart(dir, part, offset)
  local ani = self.model:Get(part)
  local id = self.partsId[part]
  if id <= 0 then
    ani:SetVisible(false)
    return
  end
  ani:SetVisible(true)
  local aniId = self:GetPartAniId(part, self.action, dir)
  ani:SetAni(aniId, self.syncModel)
  if part ~= PART.MOUNT then
    ani:SetPos(TwPoint(offset.x, offset.y))
  end
end
function class:UpdateNamePos(dir, action)
  local modelId = self.partsId[PART.MODEL]
  if modelId <= 0 then
    return
  end
  if self.notExistPart[modelId] or not self.partReady[modelId] then
    self.name:SetPos(TwPoint(0, DEFAULT_MODEL_NAME_H))
    return
  end
  local pos = self:GetNameOffset(dir, action)
  self.name:SetPos(pos)
end
function class:GetNameOffset(dir, action)
  local pos = self:GetHeadOffset(dir, action)
  pos.y = pos.y + DEFUALT_NAME_OFF_HEAD_H
  return pos
end
function class:GetCurHeadOffset()
  local modelId = self.partsId[PART.MODEL]
  if self.notExistPart[modelId] or not self.partReady[modelId] then
    return TwPoint(0, DEFAULT_MODEL_NAME_H)
  end
  local action = self:MapAction(self.action)
  local dir, flip = internal:MapDir(self.mode, action, self.dir)
  return self:GetHeadOffset(dir, action)
end
function class:GetHeadOffset(dir, action)
  local pos = TwPoint(0, 0)
  local offsetModelId
  local mountId = self:GetMount()
  if nil ~= mountId and 0 < tonumber(mountId) and self.model:Get(PART.MOUNT):GetVisible() then
    offsetModelId = mountId
    local aniModel = self:GetPartAniId(PART.MOUNT, action, dir)
    local sizeModel = Tw.Scene.GetAniRectSize(aniModel)
    local offsetModel = Tw.Scene.GetAniOffset(aniModel)
    pos.y = pos.y - (sizeModel.h / 2 + offsetModel.y)
  else
    local modelId = self:GetModel()
    offsetModelId = modelId
    local aniModel = self:GetPartAniId(PART.MODEL, self.action, dir)
    local sizeModel = Tw.Scene.GetAniRectSize(aniModel)
    pos.y = pos.y - sizeModel.h
  end
  local offset = internal:GetHeadOffset(offsetModelId, action)
  local percent = self.mode == Define.MODE.HORIZONTAL and 1 or 0.7
  pos.x = pos.x + offset.x * percent
  pos.y = pos.y + offset.y * percent
  return pos
end
function class:QuickUpdateModel()
  for name, id in pairs(PART) do
    local ani = self.model:Get(id)
    if ani:GetVisible() then
      ani:SetFrame(0)
    end
  end
end
function class:GetPartAniId(part, action, dir)
  action = self:MapAction(action)
  local items = {}
  table.insert(items, string.format("%d", self.partsId[part]))
  table.insert(items, self.mode == Define.MODE.HORIZONTAL and "H" or "O")
  table.insert(items, dir)
  table.insert(items, internal.actionTitle[action])
  return internal:PartAniId(table.concat(items, ""), self.mode)
end
function class:MapAction(action)
  if self.partsId[PART.MOUNT] == 0 then
    return action
  end
  return internal.MOUNT_ACTION_MAP[action] or action
end
internal.LAYER = Enum({
  "SHADOW",
  "EFFECT_BG",
  "MODEL",
  "HUD",
  "EFFECT_FG"
})
function internal:PartAniId(title, mode)
  return ANI_ID("role", title)
end
function internal:EffectAniId(title, mode)
  return ANI_ID("effect", title)
end
internal.DIR_MAP_OVERLOOK = {
  stand = {
    [DIR.R] = DIR.RD,
    [DIR.RU] = DIR.RD,
    [DIR.U] = DIR.RD,
    [DIR.LU] = DIR.RD,
    [DIR.L] = DIR.RD,
    [DIR.LD] = DIR.RD,
    [DIR.D] = DIR.RD
  },
  mstand = {
    [DIR.R] = DIR.RD,
    [DIR.RU] = DIR.RD,
    [DIR.U] = DIR.RD,
    [DIR.LU] = DIR.RD,
    [DIR.L] = DIR.RD,
    [DIR.LD] = DIR.RD,
    [DIR.D] = DIR.RD
  },
  comm = {
    [DIR.U] = DIR.RU,
    [DIR.LU] = DIR.RU,
    [DIR.L] = DIR.R,
    [DIR.LD] = DIR.RD,
    [DIR.D] = DIR.RD
  }
}
function internal:MapDir(mode, action, dir)
  local quarter = table.size(DIR) / 4
  local flip = dir > quarter * 1 and dir <= quarter * 3
  if mode == Define.MODE.HORIZONTAL then
    return DIR.R, flip
  end
  if mode == Define.MODE.OVERLOOK then
    local category = "comm"
    if action == ACTION.STAND then
      category = "stand"
    end
    if action == ACTION.MSTAND then
      category = "mstand"
    end
    assert(category ~= nil)
    return internal.DIR_MAP_OVERLOOK[category][dir] or dir, flip
  end
  assert(false)
end
function internal:GetHeadOffset(modelId, action)
  local key = modelId .. "a" .. action
  local info = KFDBGetRecord("HeadOffSet", key)
  if nil ~= info then
    return {
      x = info.offsetx,
      y = info.offsety
    }
  end
  local info = KFDBGetRecord("HeadOffSet", modelId)
  if nil ~= info then
    return {
      x = info.offsetx,
      y = info.offsety
    }
  end
  return {x = 0, y = 0}
end
function internal:GetMountOffset(mount, roleType, mode, action, flip)
  local offset = {x = 0, y = 0}
  if mount == 0 or roleType == 0 then
    return offset
  end
  local m = mode == Define.MODE.HORIZONTAL and 0 or 1
  local id = mount * 1000 + roleType * 100 + m * 10 + action
  local cfg = KFDBGetRecord("Mount", id)
  if not cfg then
    return offset
  end
  offset.x = cfg.x
  offset.y = cfg.y
  if flip then
    offset.x = -offset.x
  end
  return offset
end
function class:SetVoice(baseId)
  if baseId > 6 or baseId < 1 then
    return
  end
  local cfg = KFDBGetRecord("BaseHero", baseId)
  local voice
  if cfg then
    local vtb = cfg.sex == 0 and "male" or "female"
    voice = internal.actionVoice[vtb]
  end
  self.voiceInfo = voice
end
function class:playVoice(actionId)
  if self.voiceInfo == nil then
    return
  end
  local voice = self.voiceInfo[actionId]
  if voice == nil then
    return
  end
  Logic:Get("Sound"):Play(voice)
end
internal.DIR_STR = table.invert(DIR)
internal.MOUNT_ACTION_MAP = {
  [ACTION.STAND] = ACTION.MSTAND,
  [ACTION.RUN] = ACTION.MRUN
}
internal.actionTitle = {
  [ACTION.STAND] = "sta",
  [ACTION.RUN] = "run",
  [ACTION.ATTACK] = "att",
  [ACTION.MAGIC] = "mag",
  [ACTION.HIT1] = "hit1",
  [ACTION.FSTAND] = "fsta",
  [ACTION.MRUN] = "mrun",
  [ACTION.MSTAND] = "msta",
  [ACTION.EXTEND1] = "ext1",
  [ACTION.EXTEND2] = "ext2",
  [ACTION.EXTEND3] = "ext3"
}
internal.actionVoice = {
  male = {
    [ACTION.ATTACK] = "audio/voice/male/attack.ogg",
    [ACTION.MAGIC] = "audio/voice/male/magic.ogg",
    [ACTION.HIT1] = "audio/voice/male/hit.ogg"
  },
  female = {
    [ACTION.ATTACK] = "audio/voice/female/attack.ogg",
    [ACTION.MAGIC] = "audio/voice/female/magic.ogg",
    [ACTION.HIT1] = "audio/voice/female/hit.ogg"
  }
}
