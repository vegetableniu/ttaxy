local ActionMgr = require("Scene.ActionMgr")
local RoleBuilder = require("Scene.RoleBuilder")
local Role = require("Scene.Role")
module((...), package.seeall)
class = objectlua.Object:subclass()
function class:initialize(mode)
  super.initialize(self)
  self.mgr = Tw.Scene.Mgr()
  self.actioinMgr = ActionMgr.class:new(self.mgr:GetActionMgr())
  self.roleBuilder = RoleBuilder.class:new(self.mgr, self.actioinMgr, mode, Role)
  self.roles = {}
end
function class:dispose()
  super.dispose(self)
end
function class:Mgr()
  return self.mgr
end
function class:ActionMgr()
  return self.actioinMgr
end
function class:Create(name, data)
  self:Destroy(name)
  data = data or {}
  local role = self.roleBuilder:Build(data)
  self.roles[name] = role
  return role
end
function class:Destroy(name)
  if nil == self.roles[name] then
    return
  end
  self.mgr:Detach(self.roles[name]:GetView():GetSceneNode())
  self.roles[name] = nil
end
function class:Find(name)
  return self.roles[name]
end
function class:Proxy(name)
  if nil == self.roles[name] then
    self:Create(name)
  end
  return self.roles[name]:GetAction()
end
function class:DestroyAll()
  for name, _ in pairs(self.roles) do
    self:Destroy(name)
  end
end
