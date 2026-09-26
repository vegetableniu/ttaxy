local RoleView = require("Scene.RoleView")
local ActionRole = require("Scene.ActionRole")
module((...), package.seeall)
class = objectlua.Object:subclass()
function class:initialize(scene, mgr, mode, Role)
  super.initialize(self)
  self.scene = scene
  self.mgr = mgr
  self.mode = mode
  self.Role = Role
end
function class:dispose()
  super.dispose(self)
end
function class:Build(data)
  local view = RoleView.class:new(self.scene, self.mgr, self.mode)
  local action = ActionRole.class:new(self.mgr, data, view)
  return self.Role.class:new(data, view, action)
end
