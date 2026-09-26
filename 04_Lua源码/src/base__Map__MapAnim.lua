module((...), package.seeall)
require("Animation")
local Define = require("Map.Define")
local MapObj = require("Map.MapObj")
local ANIM_EVENT = Animation.ANIM_EVENT
ANIM_STATUS = Enum({"OPEN", "FINISH"})
class = objectlua.Object:subclass()
class:include(MapObj.class)
function class:initialize(scene, actionMgr)
  super.initialize(self)
  MapObj.class.initialize(self)
  self.mapObjType = Define.MAP_OBJ_TYPE.ANIMATION
  self.anim = Animation.class:new(scene, actionMgr, self)
  self.status = ANIM_STATUS.OPEN
  self.eventCallback = nil
end
function class:dispose()
  self.anim:dispose()
  MapObj.class.dispose(self)
  super.dispose(self)
end
function class:Run(file, stage)
  self.anim:Run(file, stage)
end
function class:GetSceneNode()
  return self.anim:GetSceneNode()
end
function class:SetName(name)
  MapObj.class.SetName(self, name)
  self.anim:SetName(name)
end
function class:GetName()
  return MapObj.class.GetName(self)
end
function class:SetWorldPos(pos)
  self.anim:SetPos(pos)
end
function class:GetWorldPos()
  return self.anim:GetPos()
end
function class:SetVisible(bVisible)
  MapObj.class.SetVisible(self, bVisible)
  local sceneNode = self.anim:GetSceneNode()
  sceneNode:SetVisible(bVisible)
end
function class:SetScale(scale)
  local sceneNode = self.anim:GetSceneNode()
  sceneNode:SetScale(scale)
end
function class:GetScale()
  local sceneNode = self.anim:GetSceneNode()
  return sceneNode:GetScale()
end
function class:HitTest(ptSrn)
  return self.anim:HitTest(ptSrn)
end
function class:CanClick()
  if self.status == ANIM_STATUS.FINISH then
    return false
  end
  return MapObj.class.CanClick(self)
end
function class:NextStage()
  self.anim:NextStage()
end
function class:IsLastStage()
  return self.anim:IsLastStage()
end
function class:OnEvent(flag)
  if ANIM_EVENT.FINISH == flag then
    self.status = ANIM_STATUS.FINISH
  end
  if nil ~= self.eventCallback then
    self.eventCallback(self:GetId(), flag)
  end
end
function class:SetEventCallback(funCallBack)
  self.eventCallback = funCallBack
end
