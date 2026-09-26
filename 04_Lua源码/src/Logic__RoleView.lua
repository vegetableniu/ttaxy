module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
function class:initialize()
  super.initialize(self)
  self.roles = {}
end
function class:Add(name, role)
  assert(role ~= nil)
  self.roles[name] = role
end
function class:Find(name)
  return self.roles[name]
end
function class:Destory(name)
  self.roles[name] = nil
end
function class:ClearAll()
  self.roles = {}
end
function class:GetAllRoles()
  return self.roles
end
function class:FindByModelId(modelId)
  for _, role in pairs(self.roles) do
    if role.model == modelId then
      return role
    end
  end
  return nil
end
