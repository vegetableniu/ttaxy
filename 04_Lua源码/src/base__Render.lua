module((...), package.seeall)
local class = objectlua.Object:subclass()
function class:initialize(...)
  super.initialize(self)
end
function class:dispose()
  super.dispose(self)
end
function class:Init()
  local infoStats = CStatsInfo:new()
  infoStats:Init()
  local Render = CRenderSystem:GetSingleton()
  Render:InsertRenderObj(infoStats, nil, CRenderSystem.LAYER_TOPMOST, true)
  Render:InsertRenderObj(CTwUIRoot:GetSingleton(), nil, CRenderSystem.LAYER_UI, false)
end
function class:ClearStageLayer()
  CRenderSystem:GetSingleton():ClearRenderQueue(CRenderSystem.LAYER_STAGE)
end
function class:Clear(layer)
  CRenderSystem:GetSingleton():ClearRenderQueue(layer)
end
function class:Insert(renderObj, layer, autoDel)
  CRenderSystem:GetSingleton():InsertRenderObj(renderObj, nil, layer, autoDel)
end
function class:Remove(renderObj)
  CRenderSystem:GetSingleton():RemoveRenderObj(renderObj)
end
function class:SetRenderInterval(group, interval)
  CRenderSystem:GetSingleton():SetRenderInterval(group, interval)
end
instance = class:new()
