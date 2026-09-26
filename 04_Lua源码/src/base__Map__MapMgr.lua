module((...), package.seeall)
local MapScene = require("Map.MapScene")
local MapAnim = require("Map.MapAnim")
local Define = require("Map.Define")
local internal = {}
local class = objectlua.Object:subclass()
function class:initialize(...)
  super.initialize(self)
  self.map = CTwMap()
  self.mapScene = nil
  self.mapTypeId = nil
  self.srnFlwRoleId = nil
  self.mapObjs = {}
  self.effects = {}
end
function class:dispose()
  super.dispose(self)
end
function class:Init(nViewWidth, nViewHeight)
  self.map:SetViewpos(TwRect(0, 0, nViewWidth, nViewHeight), false)
end
function class:OnOperateEvent(args)
  return false
end
function class:ChangeGameViewSize(w, h)
  self.map:ChangeGameViewSize(w, h)
end
function class:CreateMap(mapTypeId, mode)
  self:DeleteMap()
  self.mapTypeId = mapTypeId
  local realMapId = string.gsub(mapTypeId, "(.mp)$", "")
  self.map:Create(realMapId)
  self.mapScene = MapScene.class:new(mode)
  local scene = self.mapScene:Scene()
  scene:SetOrigin(TwPoint(0, 0))
  self.map:SetMapScene(scene)
  self.map:OnViewposChg()
  self:AddInRender(self.map)
  return self.map
end
function class:DeleteMap()
  self:ResetCamera()
  self:ClearMapObj()
  self:ClearEffect()
  self:DeleteFromRender(self.map)
  self.map:Destroy()
  self.mapScene = nil
end
function class:GetMap()
  return self.map
end
function class:GetScene()
  return self.mapScene:Scene()
end
function class:GetMapId()
  if nil == self.map then
    return nil
  end
  return self.map:GetId()
end
function class:GetMapTypeId()
  return self.mapTypeId
end
function class:GetMapSize()
  if nil == self.map then
    return nil
  end
  return self.map:GetWorldSize()
end
function class:CreateMapObj(objType, data)
  if self.map:GetId() < 1 then
    return nil
  end
  data = data or {}
  local obj
  if objType == Define.MAP_OBJ_TYPE.ROLE then
    if nil == self.mapScene then
      return nil
    end
    obj = self.mapScene:Create(data)
  elseif objType == Define.MAP_OBJ_TYPE.ANIMATION then
    obj = MapAnim.class:new(self.mapScene:Scene(), self.mapScene:ActionMgr())
  end
  if nil == obj then
    return nil
  end
  self.mapObjs[obj:GetId()] = obj
  return obj
end
function class:GetMapObj(id)
  return self.mapObjs[id]
end
function class:DestroyMapObj(id)
  if self.srnFlwRoleId == id then
    self:SetMapNodeScrnFllow(nil)
  end
  local role = self.mapObjs[id]
  assert(role)
  if role:GetObjType() == Define.MAP_OBJ_TYPE.ROLE or role:GetObjType() == Define.MAP_OBJ_TYPE.ANIMATION then
    self.mapScene:Scene():Detach(role:GetSceneNode())
    role:dispose()
  else
    log4map:debug("DestroyMapObj:objtype error " .. role:GetObjType())
  end
  self.mapObjs[id] = nil
end
function class:ClearMapObj()
  for _, id in ipairs(self.mapObjs) do
    self.DestroyMapObj(id)
  end
  self.mapObjs = {}
end
function class:AddEffect(posWorld, title, loop)
  if not posWorld or not title then
    return
  end
  loop = loop or false
  local scene = self.mapScene:Scene()
  local actionMgr = self.mapScene:ActionMgr()
  local ani = Tw.Scene.Animation:new(scene)
  scene:Attach(ani)
  local id = ANI_ID(ANI.EFFECT, title)
  ani:SetAni(id)
  ani:SetPos(posWorld)
  local action = actionMgr:Wait(Tw.Scene.AnimationTime(id))
  local effectId = internal:AwardEffectId()
  if not loop then
    action = actionMgr:Seq(action, actionMgr:Do(function()
      self:DelEffect(effectId)
    end))
  else
    action = actionMgr:Seq(actionMgr:Call(function()
      ani:SetFrame(0)
    end), action)
    action = actionMgr:Repeat(action)
  end
  scene:GetActionMgr():Add(ani, action)
  self.effects[effectId] = {ani = ani, action = action}
  return effectId
end
function class:DelEffect(id)
  local effect = self.effects[id]
  if effect == nil then
    return
  end
  self.effects[id] = nil
  local scene = self.mapScene:Scene()
  local actionMgr = self.mapScene:ActionMgr()
  scene:GetActionMgr():Del(effect.ani, effect.action)
  scene:Detach(effect.ani)
end
function class:ClearEffect()
  for title, data in pairs(self.effects) do
    self:DelEffect(title)
  end
  self.effects = {}
end
function class:ResetCamera()
  if nil == self.map then
    return nil
  end
  local camera = self.map:GetCamera()
  camera:Reset()
end
function class:SetMapNodeScrnFllow(role, bMoveToTarget)
  if nil == self.map then
    return nil
  end
  if nil == role then
    self.map:SetMapNodeScrnFllow(nil)
    self.srnFlwRoleId = nil
  else
    self.map:SetMapNodeScrnFllow(role:GetSceneNode(), false, bMoveToTarget)
    self.srnFlwRoleId = role:GetId()
  end
end
function class:GetAStarPath(posBegin, posEnd)
  if nil == self.map or self.map:GetId() <= 0 then
    return nil
  end
  local astarPath = self.map:GetAStarPath(posBegin, posEnd)
  local worldPath = {}
  for _, cellIdx in ipairs(astarPath) do
    local posWorld = self:CellIdx2World(cellIdx)
    table.insert(worldPath, posWorld)
  end
  return worldPath
end
function class:CellIdx2World(cellIdx)
  local cell = self.map:CellIndexToCellPos(cellIdx)
  local posWorld = self.map:Cell2World(cell)
  return posWorld
end
function class:AddInRender(map)
  Singleton(Render):Insert(map, CRenderSystem.LAYER_MAP, false)
end
function class:DeleteFromRender(map)
  Singleton(Render):Remove(map)
end
function class:DropMapRender()
  local renderInterval = 1000
  Singleton(Render):SetRenderInterval(CRenderSystem.LAYER_MAP, renderInterval)
end
function class:RecoverMapRender()
  Singleton(Render):SetRenderInterval(CRenderSystem.LAYER_MAP, 0)
end
internal.effectId = 0
function internal:AwardEffectId()
  internal.effectId = internal.effectId + 1
  return internal.effectId
end
instance = class:new()
