module((...), package.seeall)
local Define = require("Map.Define")
local DFT_MAX_CLICK_DIS_TO_TARGET = Map.Define.DFT_MAX_CLICK_DIS_TO_TARGET
local internal = {}
class = objectlua.Mixin:new()
function class:initialize()
  self.id = internal:AwardObjId()
  self.mapObjType = Define.MAP_OBJ_TYPE.UNKNOWN
  self.roleType = Define.ROLE_TYPE.UNKNOW
  self.data = {}
  self.bVisible = true
  self.name = nil
  self.click = {
    canClkCalbk = nil,
    clkCallback = nil,
    maxClkDis = DFT_MAX_CLICK_DIS_TO_TARGET
  }
end
function class:dispose()
end
function class:GetId()
  return self.id
end
function class:GetObjType()
  return self.mapObjType
end
function class:SetRoleType(type)
  self.roleType = type
end
function class:GetRoleType()
  return self.roleType
end
function class:CheckRoleType(type)
  return bit.band(type, self.roleType) == self.roleType
end
function class:GetSceneNode()
  return nil
end
function class:SetName(name)
  self.name = name
end
function class:GetName()
  return self.name
end
function class:GetData(name)
  return self.data[name]
end
function class:SetData(name, data)
  self.data[name] = data
end
function class:SetVisible(bVisible)
  self.bVisible = bVisible
end
function class:IsVisible()
  return self.bVisible
end
function class:HasAI()
  return false
end
function class:SetClickCallBack(canClkCalbk, clkCallback, maxClkDis)
  self.click.canClkCalbk = canClkCalbk
  self.click.clkCallback = clkCallback
  self.click.maxClkDis = maxClkDis or DFT_MAX_CLICK_DIS_TO_TARGET
end
function class:GetMaxClickDis()
  return self.click.maxClkDis
end
function class:CanClick(...)
  if nil ~= self.click.canClkCalbk then
    return self.click.canClkCalbk(self:GetId(), ...)
  end
  return false
end
function class:Clicked(...)
  if nil ~= self.click.clkCallback then
    self.click.clkCallback(self:GetId(), ...)
  end
end
internal.id = 0
function internal:AwardObjId()
  internal.id = internal.id + 1
  return internal.id
end
