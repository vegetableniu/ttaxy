module((...), package.seeall)
class = objectlua.Object:subclass()
function class:initialize(ccb, owner, tag, pos, level)
  super.initialize(self)
  local rootNode = owner.rootNode
  local layer = Tw.Controller:load(ccb, rootNode)
  assert(layer ~= nil)
  if tag and level then
    rootNode:addChild(layer, level, tag)
  elseif level then
    rootNode:addChild(layer, level)
  else
    rootNode:addChild(layer)
  end
  if pos == nil then
    local winSz = rootNode:getContentSize()
    pos = ccp(winSz.width / 2, winSz.height / 2)
  end
  layer:setPosition(pos)
  self.aniLayer = layer
  self.rootNode = rootNode
end
function class:SetParams(...)
  self.aniLayer:SetParams(...)
end
function class:RunAnimation(ani)
  self.aniLayer:RunAnimation(ani)
end
function class:RunAnimationWithoutWait()
  assert(self.aniLayer ~= nil)
  self.aniLayer:RunAnimation()
end
function class:RunAnimationSync(bAutoRemove)
  assert(self.aniLayer ~= nil)
  local synchroniser = Utils.Synchroniser:new()
  local waitSign = synchroniser:Join()
  self.aniLayer:SetWaitSignByDefaultAniName(waitSign)
  self.aniLayer:RunAnimation()
  if bAutoRemove then
    synchroniser:Sync()
    self:RemoveAnimation()
    return
  end
  return synchroniser
end
function class:RemoveAnimation()
  self.rootNode:removeChild(self.aniLayer, true)
end
function class:SetWaitSignByDefaultAniName(waitSign)
  self.aniLayer:SetWaitSignByDefaultAniName(waitSign)
end
function class:setVisible(bv)
  self.aniLayer:setVisible(bv)
end
