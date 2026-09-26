module((...), package.seeall)
local internal = {}
class = objectlua.Object:subclass()
function class:initialize(data, view, action)
  super.initialize(self)
  self.modelId = 0
  self.weaponId = 0
  self.mountId = 0
  self.data = data
  self.view = view
  self.action = action
  self.strName = ""
  view:SetModelChgCallback(bind(self.OnModelChanged, self))
end
function class:dispose()
  super.dispose(self)
end
function class:GetData(name)
  return self.data[name]
end
function class:SetData(name, data)
  self.data[name] = data
end
function class:GetView()
  return self.view
end
function class:GetAction()
  return self.action
end
function class:GetScene()
  return self.view:Scene()
end
function class:SetSyncModel(bSync)
  self.view:SetSyncModel(bSync)
end
function class:SetName(name)
  if self:GetName() == name then
    return
  end
  self.strName = name
  self.view:SetName(name)
end
function class:GetName()
  return self.strName
end
function class:SetNameFontSize(size)
  self.view:SetNameFontSize(size)
end
function class:GetSceneNode()
  return self.view:GetSceneNode()
end
function class:SetScale(scale)
  self.view:SetScale(scale)
end
function class:GetScale()
  return self.view:GetScale()
end
function class:SetAlpha(alpha)
  self.view:SetAlpha(alpha)
end
function class:FadeOut(time)
  local action = self.action:FadeOut(time)
  self.action.mgr:Exec(self.action, action)
end
function class:FadeIn(time)
  local action = self.action:FadeIn(time)
  self.action.mgr:Exec(self.action, action)
end
function class:GetAlpha()
  return self.view:GetAlpha()
end
function class:SetDir(dir)
  if self:GetDir() == dir then
    return
  end
  self.view:SetDir(dir)
end
function class:GetDir()
  return self.view:GetDir()
end
function class:SetModel(id)
  if self:GetModel(true) == id then
    return
  end
  self.modelId = id
  local realId = internal:GetRoleSkinModelId(id)
  self.view:SetModel(realId)
end
function class:GetModel(bOrigion)
  if nil == bOrigion or not bOrigion then
    return self.view:GetModel()
  end
  return self.modelId
end
function class:SetWeapon(id)
  if self:GetWeapon(true) == id then
    return
  end
  self.weaponId = id
  local realId = internal:GetRoleSkinModelId(id)
  self.view:SetWeapon(realId)
end
function class:GetWeapon(bOrigion)
  if nil == bOrigion or not bOrigion then
    return self.view:GetWeapon()
  end
  return self.weaponId
end
function class:SetMount(id)
  id = tonumber(id or 0)
  if id ~= 0 and id < 300001 then
    id = Logic:Get("Player"):GetMountModel(id)
  end
  if self:GetMount(true) == id then
    return
  end
  self.mountId = id
  local realId = internal:GetRoleSkinModelId(id)
  self.view:SetMount(realId)
end
function class:GetMount(bOrigion)
  if nil == bOrigion or not bOrigion then
    return self.view:GetMount()
  end
  return self.mountId
end
function class:SetProModelId(proModelId)
  self.view:SetRoleType(proModelId)
end
function class:GetModelProType()
  self.view:GetRoleType()
end
function class:SetAction(action)
  self.view:SetAction(action)
end
function class:HitTest(ptSrn)
  return self.view:HitTest(ptSrn)
end
function class:SetHitTestType(type)
  self.view:SetHitTestType(type)
end
function class:SetMoveSpeed(speed)
  self.action:SetMoveSpeed(speed)
end
function class:GetMoveSpeed()
  self.action:GetMoveSpeed()
end
function class:AddEffect(title, fg, loop, headOffset)
  self.view:AddEffect(title, fg, loop, headOffset)
end
function class:HasEffect(title)
  return self.view:HasEffect(title)
end
function class:DelEffect(title)
  self.view:DelEffect(title)
end
function class:ClearEffect()
  self.view:ClearEffect()
end
function class:OnModelChanged()
end
function internal:GetRoleSkinModelId(modelId)
  local roleSkin = KFDBGetRecord("RoleSkin", tonumber(modelId))
  if nil ~= roleSkin then
    local reduModel = tonumber(roleSkin.MBmodel)
    if nil ~= reduModel and 0 ~= reduModel then
      return reduModel
    end
  end
  return modelId
end
