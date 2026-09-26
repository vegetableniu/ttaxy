require("Logic.Guide")
module((...), package.seeall)
local CONST = {
  TOUCH_PRIORITY_COVER = -999,
  TOUCH_PRIORITY_LOCK = -998,
  TOUCH_PRIORITY_REVISE = -997
}
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
  Logic:Get("Guide"):On(Logic.Guide.EVT.LOCK, self:Event("lock"))
  Logic:Get("Guide"):On(Logic.Guide.EVT.LOCK_TOUCH, self:Event("lockTouch"))
  Logic:Get("Guide"):On(Logic.Guide.EVT.LOCK_DRAG, self:Event("lockDrag"))
end
function prototype:onEnter()
  local function setupCover(cover)
    cover:registerScriptTouchHandler(function(event, x, y, touch)
      if event == CCTOUCHBEGAN then
        local rect = cover:boundingBox()
        local pt = self.rootNode:convertToNodeSpace(touch:getLocation())
        return cover:boundingBox():containsPoint(pt)
      end
      return false
    end, false, CONST.TOUCH_PRIORITY_COVER, true)
    cover:setTouchEnabled(true)
    cover:ignoreAnchorPointForPosition(false)
  end
  setupCover(self.coverTop)
  setupCover(self.coverBottom)
  setupCover(self.coverLeft)
  setupCover(self.coverRight)
  self.touchLocker:registerScriptTouchHandler(function(event, x, y, touch)
    return self.touchReviseHandler == nil
  end, false, CONST.TOUCH_PRIORITY_LOCK, true)
  self.touchLocker:setTouchEnabled(true)
  self.touchReviser:registerScriptTouchHandler(function(event, x, y, touch)
    if self.touchReviseHandler ~= nil then
      return self:touchReviseHandler(event, touch)
    end
    return false
  end, false, CONST.TOUCH_PRIORITY_REVISE, false)
  self.touchReviser:setTouchEnabled(true)
end
function prototype:lock()
  self:cover()
  self.touchReviseHandler = nil
end
function prototype:lockTouch(node)
  assert(node ~= nil)
  self:cover(node)
  function self:touchReviseHandler(event, touch)
    if event ~= CCTOUCHBEGAN then
      local prev = touch:getPreviousLocationInView()
      touch:setTouchInfo(touch:getID(), prev.x, prev.y)
    end
    return true
  end
end
function prototype:lockDrag(nodeSrc, nodeDest)
  assert(nodeSrc ~= nil)
  assert(nodeDest ~= nil)
  self:cover(nodeSrc)
  local began
  function self:touchReviseHandler(event, touch)
    if event == CCTOUCHBEGAN then
      self:cover(nodeDest)
      began = touch:getLocationInView()
      return true
    end
    if event == CCTOUCHMOVED then
      return true
    end
    if event == CCTOUCHCANCELLED then
      self:cover(nodeSrc)
      return true
    end
    if event == CCTOUCHENDED then
      local size = nodeDest:getContentSize()
      local rect = CCRect(0, 0, size.width, size.height)
      rect = nodeDest:nodeToWorldTransform(rect)
      if not rect:containsPoint(touch:getLocation()) then
        local prev = touch:getPreviousLocationInView()
        touch:setTouchInfo(touch:getID(), prev.x, prev.y)
        touch:setTouchInfo(touch:getID(), began.x, began.y)
        self:cover(nodeSrc)
      end
      return true
    end
    return true
  end
end
function prototype:unlock()
  self.touchReviseHandler = nil
end
function prototype:cover(node)
  self.iniMark:stopAllActions()
  self.iniMark:removeAllChildrenWithCleanup(true)
  self.iniMark:setPosition(ccp(320, 480))
  local node = node or self.rootNode
  local size = node:getContentSize()
  local rect = CCRect(0, 0, size.width, size.height)
  local transformTarget = node:nodeToWorldTransform()
  rect = CCRectApplyAffineTransform(rect, transformTarget)
  local transformLocal = self.rootNode:worldToNodeTransform()
  rect = CCRectApplyAffineTransform(rect, transformLocal)
  self.coverTop:setPositionY(rect.origin.y + rect.size.height)
  self.coverBottom:setPositionY(rect.origin.y)
  self.coverLeft:setPositionX(rect.origin.x)
  self.coverRight:setPositionX(rect.origin.x + rect.size.width)
  self.coverLeft:setPositionY(rect.origin.y)
  self.coverLeft:changeHeight(rect.size.height)
  self.coverRight:setPositionY(rect.origin.y)
  self.coverRight:changeHeight(rect.size.height)
  self.mark:setVisible(node ~= self.rootNode)
  self.mark:setPositionX(rect.origin.x + rect.size.width / 2)
  self.mark:setPositionY(rect.origin.y + rect.size.height / 2)
  local bool = false
  if 320 < rect.origin.x and 480 < rect.origin.y or not (rect.origin.x > 500) or rect.origin.y < 200 then
  end
  local sprHand = CCSprite:create("images/Effect/uixsyd02/001.png")
  self.iniMark:addChild(sprHand, 0, 2)
  sprHand:setAnchorPoint(CCPoint(0.166, 0.769))
  if bool then
    local layerAni = self.ani:GetLayer()
    layerAni:setScaleX(-1)
  end
  local moveToAction = CCMoveTo:create(0.8, ccp(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2))
  local arr = CCArray:create()
  arr:addObject(moveToAction)
  local function runAnia()
    local hand = self.iniMark:getChildByTag(2)
    if hand ~= nil then
      self.iniMark:removeChildByTag(2, true)
    end
    local ani = Logic:Get("AniMgr"):NewCCB("UI/uixsyd02", self.iniMark, nil, nil, nil, nil, true)
    if ani then
      ani:RunAni()
    end
  end
  local removeAni = function()
    if ani ~= nil then
      ani:RemoveAnimation()
    end
  end
  arr:addObject(CCCallFuncN:create(runAnia))
  arr:addObject(CCDelayTime:create(1))
  arr:addObject(CCCallFuncN:create(function()
    self.iniMark:setPosition(ccp(320, 480))
  end))
  arr:addObject(CCDelayTime:create(1))
  self.iniMark:runAction(CCRepeatForever:create(CCSequence:create(arr)))
end
