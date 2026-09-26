module((...), package.seeall)
require("UIDefine")
local DEFAULT_EDIT_FONT_SIZE = 50
prototype = Tw.Controller.prototype:extend()
EditManager = {}
EditManager.editMgrList = {}
function EditManager:push(obj)
  table.insert(EditManager.editMgrList, obj)
end
function EditManager:remove(obj)
  for i, v in ipairs(EditManager.editMgrList) do
    if v == obj then
      table.remove(EditManager.editMgrList, i)
      break
    end
  end
end
function EditManager:reset(obj)
  for i, v in ipairs(EditManager.editMgrList) do
    if v ~= obj then
      v.bInEdit = false
    end
  end
end
function prototype:initialize(...)
  super.initialize(self, ...)
  self.textField = nil
  self.bInEdit = false
  self.bclear = false
  self.strMarker = ""
  self.textLayer = nil
  self.callback = nil
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:setVisible(visible)
  if nil == self.textField then
    return
  end
  self.textField:setVisible(visible)
end
function prototype:setPasswordMode(bPassmode)
  if nil == self.textField then
    return
  end
  self.textField:setPasswordMode(bPassmode)
end
function prototype:getString()
  local str = self.textField and self.textField:getString() or ""
  return str
end
function prototype:setString(str)
  if nil == self.textField then
    return
  end
  self.textField:setString(str or "")
end
function prototype:setClear(bclear)
  if bclear then
    self.bclear = bclear
  end
end
function prototype:setFontSize(fontSize)
  self.textField:setFontSize(fontSize)
end
function prototype:setPlaceHolder(text)
  if nil == self.textField then
    return
  end
  self.textField:setPlaceHolder(text or "")
end
function prototype:setMaxLens(maxLen, bDBCSCharAs2)
  if nil == self.textField then
    return
  end
  if nil == bDBCSCharAs2 then
    bDBCSCharAs2 = true
  end
  self.textField:setMaxLens(maxLen or -1, bDBCSCharAs2)
end
function prototype:setPosition(pos)
  if nil == self.textField then
    return
  end
  self.textField:setPosition(pos)
end
function prototype:setAnchorPoint(anchorPoint)
  if nil == self.textField then
    return
  end
  self.textField:setAnchorPoint(anchorPoint)
end
function prototype:setStyle(style)
  if nil == self.textField then
    return
  end
  self.textField:setStyle(style)
end
function prototype:setCallback(callback)
  self.callback = callback
end
function prototype:CallBack(event)
  if self.callback then
    self.callback(event)
  end
end
function prototype:setTouchPriority(priority)
  priority = priority or 0
  local bSwallowsTouches = CTwUtil:GetPlatform() ~= CTwUtil.E_TP_WIN32
  self.textLayer:registerScriptTouchHandler(bind(self.onTouch, self), false, priority, bSwallowsTouches)
  self.textLayer:setTouchEnabled(false)
  self.textLayer:setTouchEnabled(true)
end
function prototype:setMulLine(bMul)
  if nil == self.textField then
    return
  end
  if bMul then
    local sizeNode = self.rootNode:getContentSize()
    self.textField:setDimensions(CCSize(sizeNode.width, sizeNode.height))
  else
    self.textField:setDimensions(CCSize(0, 0))
  end
end
function prototype:onEnter()
  if nil ~= self.textField then
    return
  end
  local sizeNode = self.rootNode:getContentSize()
  self.textLayer = CCLayer:create()
  local textField = CCTextFieldTTF:textFieldWithPlaceHolder(TwGetStr(10055), UIDefine.DEFAULT_FONT_NAME, UIDefine.DEFAULT_FONT_SIZE)
  self.textField = textField
  textField:setFontSize(DEFAULT_EDIT_FONT_SIZE)
  local textSize = textField:getContentSize()
  textField:setAnchorPoint(CCPoint(0, 1))
  textField:setPosition(CCPoint(0, sizeNode.height))
  self.textLayer:setTouchEnabled(true)
  local bSwallowsTouches = CTwUtil:GetPlatform() ~= CTwUtil.E_TP_WIN32
  self.textLayer:registerScriptTouchHandler(bind(self.onTouch, self), false, 0, bSwallowsTouches)
  self.rootNode:addChild(textField)
  self.rootNode:addChild(self.textLayer)
  EditManager:push(self)
end
function prototype:onExit()
  EditManager:remove(self)
end
function prototype:onTouch(eventType, x, y)
  if nil == self.textField then
    return
  end
  if not self.textField:isVisible() then
    return
  end
  if eventType == CCTOUCHBEGAN then
    return self:onTouchBegan(x, y)
  elseif eventType == CCTOUCHMOVED then
    return self:onTouchMoved(x, y)
  elseif eventType == CCTOUCHENDED then
    return self:onTouchEnd(x, y)
  end
end
function prototype:isPosInTextField(x, y)
  local touchPos = CCPoint(x, y)
  touchPos = self.rootNode:getParent():convertToNodeSpace(touchPos)
  x = touchPos.x
  y = touchPos.y
  local pos = self.rootNode:getPositionLua()
  local size = self.rootNode:getContentSize()
  local anchorPoint = self.rootNode:getAnchorPoint()
  if self.rootNode:isIgnoreAnchorPointForPosition() then
    anchorPoint.x = 0
    anchorPoint.y = 0
  end
  local posBeginX = pos.x - size.width * anchorPoint.x
  local posBeginY = pos.y - size.height * anchorPoint.y
  local bInRect = x > posBeginX and x < posBeginX + size.width and y > posBeginY and y < posBeginY + size.height
  return bInRect
end
function prototype:onTouchBegan(x, y)
  local bInRect = self:isPosInTextField(x, y)
  if bInRect then
    self.textField:stopAllActions()
    local array = CCArray:create()
    array:addObject(CCFadeOut:create(0.25))
    array:addObject(CCFadeIn:create(0.25))
    local seq = CCSequence:create(array)
    local action = CCRepeat:create(seq, 3)
    self.textField:runAction(action)
    self:attachWithIME()
    if self.bclear == true then
      self.strMarker = self:getString()
      self.textField:setString("")
    end
  elseif self.bInEdit then
    self.textField:stopAllActions()
    self.textField:setOpacity(255)
    self:detachWithIME()
    if self.bclear and "" == self:getString() then
      self:setString(self.strMarker)
    end
    EditManager:reset(self)
    return true
  end
  return bInRect
end
function prototype:onTouchMoved(x, y)
end
function prototype:onTouchEnd(x, y)
  if not self:isPosInTextField(x, y) then
    self:CallBack("onTouchEnd")
  end
end
function prototype:onClickTextField(x, y)
  local bClick = self:isPosInTextField(x, y)
  if bClick then
    self:attachWithIME()
    if self.bclear == true then
      self.strMarker = self:getString()
      self.textField:setString("")
    end
  else
    self:detachWithIME()
  end
end
function prototype:attachWithIME()
  self.textField:attachWithIME()
  self.bInEdit = true
  Logic:Get("ControlsInfo"):SaveControlInfo(self.rootNode)
end
function prototype:detachWithIME()
  self.textField:detachWithIME()
  self.bInEdit = false
  Logic:Get("ControlsInfo"):Clear()
end
