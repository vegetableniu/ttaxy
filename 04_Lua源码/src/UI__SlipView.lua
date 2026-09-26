module((...), package.seeall)
prototype = {}
local SLIP_SENSE = 10
local SLIP_TIME = 0.5
SLIP_DIRECTION = {HORIZONTAL = 1, VERTICAL = 2}
function prototype:create(bindObj, bindNode, createInfo)
  if not bindObj or not bindNode then
    return
  end
  if not createInfo or not next(createInfo) then
    return
  end
  if not createInfo.ccbName or type(createInfo.ccbName) ~= "string" then
    return
  end
  local slipControl = {}
  slipControl.ccbName = createInfo.ccbName
  slipControl.allPage = createInfo.allPage or 1
  slipControl.curPage = 1
  slipControl.data = createInfo.data
  slipControl.bHide = createInfo.bHide
  local direction = createInfo.direction
  if direction ~= SLIP_DIRECTION.VERTICAL then
    direction = SLIP_DIRECTION.HORIZONTAL
  end
  slipControl.direction = direction
  slipControl.bScroll = createInfo.bScroll or false
  local oldSize = bindNode:getContentSize()
  local scaleX = bindNode:getScaleX()
  local scaleY = bindNode:getScaleY()
  local newSize = CCSizeMake(oldSize.width * scaleX, oldSize.height * scaleY)
  bindNode:setContentSize(newSize)
  bindNode:setScale(1)
  local function loadToContainer(ccbName, page, bHide)
    if not ccbName or not page then
      return
    end
    local allPage = slipControl.allPage
    if page <= 0 or page > allPage then
      return
    end
    if not slipControl.scroll then
      local scroll = CCScrollViewEx:create(newSize)
      slipControl.scroll = scroll
      scroll:setClippingToBounds(true)
      scroll:setTouchEnabled(slipControl.bScroll)
      local container = CCNode:create()
      local containerSize
      local containerDir = kCCScrollViewDirectionHorizontal
      if slipControl.direction == SLIP_DIRECTION.HORIZONTAL then
        containerSize = CCSizeMake(newSize.width * allPage, newSize.height)
        containerDir = kCCScrollViewDirectionVertical
      else
        containerSize = CCSizeMake(newSize.width, newSize.height * allPage)
        container:setPositionY(-(allPage - page) * newSize.height)
      end
      scroll:setBounceable(false)
      container:setContentSize(containerSize)
      scroll:setContainer(container)
      scroll:setDirection(containerDir)
      scroll:updateInset()
      bindNode:addChild(scroll, 1, 2)
    end
    local pageNode = Tw.Controller:load(ccbName, bindObj.rootNode)
    if not pageNode then
      return
    end
    if slipControl.direction == SLIP_DIRECTION.HORIZONTAL then
      pageNode:setPosition(ccp((page - 1) * newSize.width, 0))
    else
      pageNode:setPosition(ccp(0, (allPage - page) * newSize.height))
    end
    pageNode.rootNode:setAnchorPoint(ccp(0, 0))
    slipControl.scroll:getContainer():addChild(pageNode, 0, page)
    slipControl.scroll:updateInset()
    if pageNode.loadAtIndex and not bHide then
      pageNode:loadAtIndex(page, slipControl.data)
    end
  end
  local function removeFromContainer(page)
    if page > 0 and page <= slipControl.allPage then
      local container = slipControl.scroll:getContainer()
      local pageNode = container:getChildByTag(page)
      if pageNode then
        pageNode:removeFromParentAndCleanup(true)
      end
    end
  end
  local function preLoadAndCleanup(self, dir)
    if not dir then
      return
    end
    local preLoadPage = self.curPage + dir
    loadToContainer(self.ccbName, preLoadPage)
    local removePage = self.curPage - dir * 3
    removeFromContainer(removePage)
  end
  local function updateCurPage(self, dir, offset)
    if not dir then
      return
    end
    offset = offset or 1
    self.oldPage = self.curPage
    local newPage = self.curPage + dir * offset
    if (newPage < 1 or newPage > self.allPage) and offset == 1 then
      if bindObj.outOfPage then
        bindObj:outOfPage(dir)
      end
      self.containerMoving = false
      return false
    else
    end
    self.curPage = newPage
    return true
  end
  local adaptContentSize = function(self)
    local container = self.scroll:getContainer()
    local pageNode = container:getChildByTag(self.curPage)
    if pageNode then
      local nodeSize = pageNode.rootNode:getContentSize()
      local containerSize = container:getContentSize()
      if self.direction == SLIP_DIRECTION.HORIZONTAL then
        container:setContentSize(CCSizeMake(containerSize.width, nodeSize.height))
      else
        container:setContentSize(CCSizeMake(nodeSize.width, containerSize.height))
      end
    end
  end
  local function sliderAction(self, dir, bAnimat)
    if not dir then
      return
    end
    local duringTime = bAnimat == false and 0 or SLIP_TIME
    local moveByCCP = slipControl.direction == SLIP_DIRECTION.HORIZONTAL and ccp(-dir * newSize.width, 0) or ccp(0, dir * newSize.height)
    local container = slipControl.scroll:getContainer()
    local array = CCArray:create()
    array:addObject(CCDelayTime:create(0))
    array:addObject(CCCallFunc:create(function()
      if slipControl.direction == SLIP_DIRECTION.HORIZONTAL then
        local beginPosX = -newSize.width * (self.oldPage - 1)
        container:setPositionX(beginPosX)
      else
        local beginPosY = -(self.allPage - self.oldPage) * newSize.height
        container:setPositionY(beginPosY)
      end
    end))
    array:addObject(CCMoveBy:create(duringTime, moveByCCP))
    array:addObject(CCCallFunc:create(function()
      if bindObj.slipPageTurn then
        bindObj:slipPageTurn(self.curPage)
      end
      local removePage = self.curPage - dir * 2
      removeFromContainer(removePage)
      self.containerMoving = false
      local preLoadPage = self.curPage - dir
      local hasLoad = self:isLoaded(preLoadPage)
      if not hasLoad then
        loadToContainer(self.ccbName, preLoadPage)
      end
    end))
    container:stopAllActions()
    container:runAction(CCSequence:create(array))
  end
  local function registerTouchEvent(self, layer)
    local function onTouchBegan(x, y)
      local nodePos = bindObj.rootNode:convertToNodeSpace(ccp(bindNode:getPosition()))
      local nodeSize = newSize
      local nodeAnchor = bindNode:getAnchorPoint()
      if bindNode:isIgnoreAnchorPointForPosition() then
        nodeAnchor.x = 0
        nodeAnchor.y = 0
      end
      local posBeginX = nodePos.x - nodeSize.width * nodeAnchor.x
      local posBeginY = nodePos.y - nodeSize.height * nodeAnchor.y
      self.bInRect = x > posBeginX and x < posBeginX + nodeSize.width and y > posBeginY and y < posBeginY + nodeSize.height
      if not self.bInRect then
        return true
      end
      self.oldX = x
      self.oldY = y
      return true
    end
    local function onTouchMoved(x, y)
      if not self.bInRect then
        return
      end
      local deltaX = x - self.oldX
      local deltaY = y - self.oldY
      self.oldX = x
      self.oldY = y
      local bHorEnabled = math.abs(deltaX) >= math.abs(deltaY)
      if self.bScroll then
        local bMayShaking = self.direction == SLIP_DIRECTION.HORIZONTAL and bHorEnabled and math.abs(deltaX) >= 10 or self.direction == SLIP_DIRECTION.VERTICAL and not bHorEnabled and math.abs(deltaY) >= 10
        if bMayShaking then
          self.scroll:setTouchEnabled(false)
        end
      end
      local dir
      if self.direction == SLIP_DIRECTION.HORIZONTAL and bHorEnabled then
        if deltaX < -SLIP_SENSE then
          dir = 1
        elseif deltaX > SLIP_SENSE then
          dir = -1
        end
      elseif self.direction == SLIP_DIRECTION.VERTICAL and not bHorEnabled then
        if deltaY < -SLIP_SENSE then
          dir = -1
        elseif deltaY > SLIP_SENSE then
          dir = 1
        end
      end
      if not dir or self.touchMoving or self.containerMoving then
        return
      end
      if not self.touchMoving then
        self.touchMoving = true
        self.containerMoving = true
        self:TurnPage(dir)
      end
    end
    local function onTouchEnded(x, y)
      self.oldX = x
      self.oldY = y
      self.touchMoving = false
      if self.bScroll then
        self.scroll:setTouchEnabled(true)
      end
    end
    local function onTouch(eventType, x, y)
      if eventType == CCTOUCHBEGAN then
        return onTouchBegan(x, y)
      elseif eventType == CCTOUCHMOVED then
        return onTouchMoved(x, y)
      else
        return onTouchEnded(x, y)
      end
    end
    layer:registerScriptTouchHandler(onTouch, false, -2)
    layer:setTouchEnabled(true)
  end
  local layer = CCLayer:create()
  layer:setContentSize(newSize)
  registerTouchEvent(slipControl, layer)
  bindNode:addChild(layer, 200, 1)
  slipControl.touchLayer = layer
  loadToContainer(slipControl.ccbName, 1, slipControl.bHide)
  loadToContainer(slipControl.ccbName, 2)
  adaptContentSize(slipControl)
  function slipControl:RequireUpdate(allPage)
    self.allPage = allPage or self.allPage
    if self.curPage > self.allPage then
      self.curPage = self.allPage
    end
    local container = slipControl.scroll:getContainer()
    local pageNode = container:getChildByTag(self.curPage)
    if pageNode and pageNode.loadAtIndex then
      pageNode:loadAtIndex(self.curPage, self.data)
    end
  end
  function slipControl:TurnPage(dir, bAnimat)
    if not dir or type(dir) ~= "number" then
      return
    end
    if math.abs(dir) ~= 1 then
      return
    end
    local needToSlide = updateCurPage(self, dir)
    if needToSlide then
      preLoadAndCleanup(self, dir)
      adaptContentSize(self)
      self:RequireUpdate()
      sliderAction(self, dir, bAnimat)
    end
  end
  function slipControl:TurnPageTo(destPage, bAnimat)
    if destPage == self.curPage then
      local container = self.scroll:getContainer()
      local pageNode = container:getChildByTag(self.curPage)
      if pageNode and pageNode.loadAtIndex then
        pageNode:loadAtIndex(self.curPage, self.data)
      end
      return
    end
    local duringPage = destPage - self.curPage
    if math.abs(duringPage) == 1 then
      self:TurnPage(duringPage, bAnimat)
      return
    end
    self.curPage = destPage
    for i = 1, self.allPage do
      removeFromContainer(i)
    end
    loadToContainer(self.ccbName, self.curPage)
    loadToContainer(self.ccbName, self.curPage - 1)
    loadToContainer(self.ccbName, self.curPage + 1)
    local destOffset = slipControl.direction == SLIP_DIRECTION.HORIZONTAL and ccp((1 - self.curPage) * newSize.width, 0) or ccp(0, (1 - self.curPage) * newSize.height)
    self.scroll:setContentOffset(destOffset)
  end
  function slipControl:isLoaded(page)
    if not page then
      return false
    end
    local container = self.scroll:getContainer()
    return container:getChildByTag(page) ~= nil
  end
  function slipControl:setTouchEnabled(enable)
    if self.touchLayer then
      self.touchLayer:setTouchEnabled(enable or false)
    end
  end
  function slipControl:GetPage()
    return self.allPage
  end
  function slipControl:SetData(data)
    self.data = data
  end
  function slipControl:SetDirection(direction)
  end
  return slipControl
end
