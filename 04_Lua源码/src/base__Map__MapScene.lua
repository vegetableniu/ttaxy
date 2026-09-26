module((...), package.seeall)
local ActionMgr = require("Scene.ActionMgr")
local RoleBuilder = require("Scene.RoleBuilder")
local Role = require("Map.MapRole")
class = objectlua.Object:subclass()
function class:initialize(mode)
  super.initialize(self)
  self.scene = CTwMapScene()
  self.actioinMgr = ActionMgr.class:new(self.scene:GetActionMgr())
  self.roleBuilder = RoleBuilder.class:new(self.scene, self.actioinMgr, mode, Role)
end
function class:dispose()
  super.dispose(self)
end
function class:Scene()
  return self.scene
end
function class:ActionMgr()
  return self.actioinMgr
end
function class:Create(data)
  return self.roleBuilder:Build(data)
end
