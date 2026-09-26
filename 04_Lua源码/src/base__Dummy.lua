require("Scene")
module((...), package.seeall)
class = objectlua.Object:subclass()
function class:initialize(view)
  super.initialize(self)
  self.name = "role"
  self.scene = Scene.Scene.class:new(Scene.Define.MODE.HORIZONTAL)
  self.role = self.scene:Create(self.name)
  local deviceName = CVariableSystem:GetSingleton():GetSysVariable(GV_DEVICE_NAME)
  local a = string.find(deviceName, "iPad")
  self.defaultScale = nil ~= a and 1 or 1.25
  self.defaultScale = self.defaultScale * CTwUIRender:GetSingleton():GetZoomScale()
  self.role:GetView():SetScale(self.defaultScale)
  self.wrapper = StubViewTargetScene(self.scene:Mgr())
  view:SetTarget(self.wrapper)
  self:SetDir(Scene.RoleView.DIR.D)
end
function class:dispose()
  super.dispose(self)
end
function class:SetName(name)
  self.role:SetName(name)
end
function class:SetDir(dir)
  self.role:GetView():SetDir(dir)
end
function class:GetDir(dir)
  return self.role:GetView():GetDir()
end
function class:Stand()
  self:SetAction(Scene.RoleView.ACTION.STAND)
end
function class:SetAction(action)
  local mgr = self.scene:ActionMgr()
  local proxy = self.scene:Proxy(self.name)
  mgr:Clear(proxy)
  mgr:Exec(proxy, mgr:Repeat(proxy:Action(action)))
end
function class:GetAction()
  return self.role:GetView():GetAction()
end
function class:SetProModelId(proModelId)
  self.role:GetView():SetRoleType(proModelId)
end
function class:GetModelProType()
  self.role:GetView():GetRoleType()
end
function class:SetModel(id)
  self.role:SetModel(id)
  self:Stand()
end
function class:GetModel()
  return self.role:GetModel(true)
end
function class:SetWeapon(id)
  self.role:SetWeapon(id)
end
function class:GetWeapon()
  return self.role:GetWeapon(true)
end
function class:SetMount(id)
  self.role:SetMount(id)
  self:Stand()
end
function class:GetMount()
  return self.role:GetMount(true)
end
function class:SetScale(rate)
  self.role:GetView():SetScale(self.defaultScale * rate)
end
