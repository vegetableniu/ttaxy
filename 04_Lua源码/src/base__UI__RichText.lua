module((...), package.seeall)
require("std")
prototype = Tw.Controller.prototype:extend()
local TEXT_LAYER_Z_ORDER = 254
local BG_LAYER_Z_ORDER = -253
function prototype:initialize(...)
  super.initialize(self, ...)
  self.dimensions = {width = 0, height = 0}
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
end
function prototype:create()
  if self.init then
    return false
  end
  local contentSize = self.rootNode:getContentSize()
  local containerSize = self.dimensions
  self.container = CCNode:create()
  self.container:setContentSize(CCSizeMake(0, 0))
  self.container:setAnchorPoint(ccp(0, 0))
  self.container:setPosition(ccp(0, 0))
  self.rootNode:addChild(self.container)
  self.touchLayer = CCLayer:create()
  self.touchLayer:setContentSize(self.container:getContentSize())
  self.touchLayer:setTouchEnabled(true)
  self.touchLayer:registerScriptTouchHandler(bind(self.onTouch, self), false, 0, true)
  self.rootNode:addChild(self.touchLayer, 0, -1)
  self.init = true
end
function prototype:reCalcContentSize()
  local curLine = 0
  local contentSize = {width = 0, height = 5}
  if self.dimensions.width ~= 0 and self.dimensions.height ~= 0 then
    contentSize.width = self.dimensions.width
    contentSize.height = self.dimensions.height
  else
    for i, v in ipairs(self.unitGroups) do
      contentSize.width = contentSize.width + v.width
      if v.line ~= curLine + 1 then
        break
      end
    end
    for i, v in ipairs(self.unitGroups) do
      if v.line ~= curLine then
        contentSize.height = contentSize.height + v.height
        curLine = v.line
      end
    end
  end
  self.container:setContentSize(CCSizeMake(contentSize.width, contentSize.height))
  self.touchLayer:setContentSize(CCSizeMake(contentSize.width, contentSize.height))
  self.rootNode:setContentSize(CCSizeMake(contentSize.width, contentSize.height))
end
function prototype:setVerticalAlignment(verticalAlignment)
  if verticalAlignment ~= slef.m_vAlignment then
    slef.m_vAlignment = verticalAlignment
    if self.szText ~= nil then
      slef:updateTexture()
    end
  end
end
function prototype:setHorizontalAlignment(horizontalAlignment)
  if horizontalAlignment ~= slef.m_vHorizontalAlignment then
    slef.m_vHorizontalAlignment = horizontalAlignment
    if self.szText ~= nil then
      slef:updateTexture()
    end
  end
end
function prototype:setDimensions(width, height)
  if width == 0 or height == 0 then
    width, height = 0, 0
  end
  self.dimensions.width = width
  self.dimensions.height = height
end
function prototype:clean()
  self.container:removeAllChildrenWithCleanup(true)
end
function prototype:setString(szText, fontType)
  if self.szText == szText then
    return false
  end
  local xmlText = TwGetStr(104258, self:replaceSpecialCharacter(szText))
  local xmlDoc = xml.eval(xmlText)
  local xmlTextGroups = self:separateXmlText(xmlDoc)
  local unitGroups, separateResult = self:separateContent(xmlTextGroups)
  self.szText = szText
  self.unitGroups = unitGroups
  self.fontType = fontType == nil and kCCLabelTTFStyleOutline or fontType
  if "Full" == separateResult then
  end
  self:create()
  self:updateTexture()
end
function prototype:replaceSpecialCharacter(str, isDecode)
  local _str = str
  local special_code = {
    ["\n"] = "&n;"
  }
  local unidirectionCode = {
    ["&nbsp;"] = " "
  }
  for k, v in pairs(special_code) do
    _str = isDecode and string.gsub(_str, v, k) or string.gsub(_str, k, v)
  end
  if isDecode then
    for k, v in pairs(unidirectionCode) do
      _str = string.gsub(_str, k, v)
    end
  end
  return _str
end
local emotionImagePath = "images/Emotion/"
function prototype:updateTexture(groups)
  if groups == nil then
    if self.unitGroups == nil then
      return false
    else
      groups = self.unitGroups
    end
  else
    self.unitGroups = groups
  end
  self:clean()
  local curLine = 1
  local contentSize = {width = 0, height = 5}
  for i, v in ipairs(groups) do
    if v.line ~= curLine then
      contentSize.height = contentSize.height + v.height
      curLine = v.line
    end
  end
  for i, v in ipairs(groups) do
    if v.emotion then
      local count = 1
      local animFrames = CCArray:create()
      while true do
        do
          local path = string.format("%s%s/%02d.png", emotionImagePath, v.content, count)
          local isExist = CTwFilePack.Open(path)
          if isExist ~= "" and isExist ~= nil then
            local displayFrame = CCSprite:create(path):displayFrame()
            if displayFrame ~= nil then
              animFrames:addObject(displayFrame)
            end
          else
            break
          end
          count = count + 1
        end
      end
      if count ~= 1 then
        local ani = CCAnimation:createWithSpriteFrames(animFrames, 0.3)
        local emo = CCRepeatForever:create(CCAnimate:create(ani))
        local spr = CCSprite:create()
        spr:runAction(emo)
        spr:setAnchorPoint(ccp(0, 0))
        spr:setPositionX(v.x - v.width)
        spr:setPositionY(v.y + contentSize.height)
        self.container:addChild(spr)
      end
    else
      local textFiled = CCLabelTTF:create()
      textFiled:setAnchorPoint(CCPointMake(0, 0))
      textFiled:setPositionX(v.x - v.width)
      textFiled:setPositionY(v.y + contentSize.height)
      textFiled:setStyle(self.fontType)
      textFiled:setString(v.content)
      textFiled:setFontSize(v.size or CTwUtil:GetSingleton():GetFontSize())
      if v.color then
        local r, g, b = string.match(v.color, "#(%w%w)(%w%w)(%w%w)")
        textFiled:setColor(ccc3(tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)))
      end
      if v.event or v.u then
        local underLineLabel = CCLabelTTF:create()
        local char, charCount = v.content:gsub("[\128-\255][\128-\255]", "  ")
        local vLength = string.len(v.content)
        local subLength = 0
        local flag = 1
        for i = 1, vLength do
          if i > flag then
            local charByte = string.byte(v.content, i)
            local chnLength = getCodePointByteAmount(charByte) - 1
            local isDBCS = chnLength > 0
            if isDBCS then
              subLength = subLength + chnLength - 1
            end
            flag = flag + chnLength
          end
        end
        underLineLabel:setString(string.rep("_", charCount ~= 0 and #char - subLength - 1 or #char))
        underLineLabel:setAnchorPoint(CCPointMake(0, 0))
        if v.color then
          local r, g, b = string.match(v.color, "#(%w%w)(%w%w)(%w%w)")
          underLineLabel:setColor(ccc3(tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)))
        end
        underLineLabel:setFontSize(v.size or CTwUtil:GetSingleton():GetFontSize())
        textFiled:addChild(underLineLabel)
      end
      self.container:addChild(textFiled)
    end
  end
  self:reCalcContentSize()
end
function prototype:getCharSize(char, size)
  if char == "\n" then
    return {width = 0, height = 0}
  end
  local label = CCLabelTTF:create()
  label:setFontSize(size or CTwUtil:GetSingleton():GetFontSize())
  label:setString(char)
  return label:getContentSize()
end
function prototype:getEmotionSize(id)
  local path = string.format("%s%s/%02d.png", emotionImagePath, id, 1)
  local spr = CCSprite:create(path)
  if spr then
    return spr:getContentSize()
  else
    return {width = 20, height = 20}
  end
end
function prototype:checkIsEmotion(text)
  if string.find(text, "#") == 1 then
    local emotionId = tonumber(string.sub(text, 2))
    if type(emotionId) == "number" then
      return true, emotionId
    end
  end
  return false
end
local emotionIdLength = 3
local chnLength = 1
function prototype:separateContent(xmlTextGroups)
  local _unitGroups = {}
  local curLine = 1
  local textWidth = 0
  local curPos = {x = 0, y = 0}
  local maxLineHeight = 0
  for _, xmlText in ipairs(xmlTextGroups) do
    xmlText.content = self:replaceSpecialCharacter(xmlText.content, true)
    local xmlTextLength = string.len(xmlText.content)
    local beginPos = 1
    local flag = beginPos
    for i = 1, xmlTextLength do
      if i < flag then
      else
        local viewSize = self.dimensions
        local charByte = string.byte(xmlText.content, i)
        local char = string.sub(xmlText.content, i, i)
        local isDBCS = false
        local isEmotion = false
        local isSpecial = false
        local emotionId
        local unitSize = {width = 0, height = 0}
        isEmotion, emotionId = self:checkIsEmotion(string.sub(xmlText.content, i, i + emotionIdLength))
        chnLength = getCodePointByteAmount(charByte) - 1
        isDBCS = chnLength > 0
        if isDBCS then
        end
        if isEmotion then
          flag = i + emotionIdLength
        elseif isDBCS then
          flag = i + chnLength
        else
          flag = i
        end
        if i ~= flag then
          char = string.sub(xmlText.content, i, flag)
        end
        flag = flag + 1
        unitSize = isEmotion and self:getEmotionSize(emotionId) or self:getCharSize(char, xmlText.size)
        if maxLineHeight < unitSize.height then
          maxLineHeight = unitSize.height
          for i, v in pairs(_unitGroups) do
            if v.line == curLine then
              v.height = maxLineHeight
            end
          end
        end
        curPos.x = curPos.x + unitSize.width
        textWidth = textWidth + unitSize.width
        if viewSize.width ~= 0 and curPos.x + unitSize.width > viewSize.width then
          if beginPos ~= flag then
            local unit = self:updateAttrValue(xmlText, xmlText)
            unit.content = string.sub(xmlText.content, beginPos, flag - 1)
            unit.line = curLine
            unit.width = textWidth
            unit.height = maxLineHeight
            unit.x = curPos.x
            unit.y = curPos.y
            table.insert(_unitGroups, unit)
            beginPos = flag
            textWidth = 0
          end
          curLine = curLine + 1
          curPos.x = 0
          curPos.y = curPos.y - maxLineHeight
          if viewSize.height ~= 0 and curLine * unitSize.height > viewSize.height then
            return _unitGroups, "Full"
          end
        elseif isEmotion then
          if beginPos ~= i then
            local unit = self:updateAttrValue(xmlText, xmlText)
            unit.content = string.sub(xmlText.content, beginPos, i - 1)
            unit.line = curLine
            unit.width = textWidth - unitSize.width
            unit.height = maxLineHeight
            unit.x = curPos.x - unitSize.width
            unit.y = curPos.y
            table.insert(_unitGroups, unit)
            beginPos = i
          end
          do
            local unit = self:updateAttrValue(xmlText, xmlText)
            unit.content = emotionId
            unit.line = curLine
            unit.width = unitSize.width
            unit.height = maxLineHeight
            unit.x = curPos.x
            unit.y = curPos.y
            unit.emotion = true
            table.insert(_unitGroups, unit)
            beginPos = flag
            textWidth = 0
          end
        elseif char == "\n" then
          if beginPos ~= flag then
            local unit = self:updateAttrValue(xmlText, xmlText)
            unit.content = string.sub(xmlText.content, beginPos, flag - 1)
            unit.line = curLine
            unit.width = textWidth
            unit.height = maxLineHeight
            unit.x = curPos.x
            unit.y = curPos.y
            table.insert(_unitGroups, unit)
          end
          curLine = curLine + 1
          curPos.x = 0
          curPos.y = curPos.y - maxLineHeight
          beginPos = flag
          textWidth = 0
          maxLineHeight = 0
          if viewSize.height ~= 0 and curLine * unitSize.height > viewSize.height then
            return _unitGroups, "Full"
          end
        elseif isDBCS and i + chnLength == xmlTextLength or isEmotion and i + emotionIdLength == xmlTextLength or i == xmlTextLength then
          local unit = self:updateAttrValue(xmlText, xmlText)
          unit.content = string.sub(xmlText.content, beginPos, flag - 1)
          unit.line = curLine
          unit.width = textWidth
          unit.height = maxLineHeight
          unit.x = curPos.x
          unit.y = curPos.y
          table.insert(_unitGroups, unit)
          textWidth = 0
        end
      end
    end
  end
  return _unitGroups, "Success"
end
function prototype:updateAttrValue(xmlNode, attr)
  local attr = attr == nil and {} or table.clone(attr)
  local attrType = xmlNode[0]
  if "font" == attrType then
    attr.color = xmlNode.color
    attr.size = xmlNode.size or xmlNode.SIZE
  elseif "a" == attrType then
    attr.event = string.match(xmlNode.href, "event:(.+)")
  elseif "u" == attrType then
    attr.haveUnderLine = true
  end
  return attr
end
function prototype:separateXmlText(xmlNode, nodeContainer, attr)
  attr = attr or {}
  nodeContainer = nodeContainer or {}
  for _, node in ipairs(xmlNode) do
    local nodeType = type(node)
    if "table" == nodeType then
      self:separateXmlText(node, nodeContainer, self:updateAttrValue(node, attr))
    end
    if "string" == nodeType then
      attr.content = node
      table.insert(nodeContainer, table.clone(attr))
    end
  end
  return nodeContainer
end
function prototype:onTouch(eventType, x, y)
  local node = self.container
  repeat
    if not node:isVisible() then
      return false
    end
    node = node:getParent()
  until node == nil
  if eventType == CCTOUCHBEGAN then
    return self:onTouchBegan(x, y)
  elseif eventType == CCTOUCHMOVED then
    return self:onTouchMoved(x, y)
  elseif eventType == CCTOUCHENDED then
    return self:onTouchEnd(x, y)
  end
end
function prototype:isPointInRect(x, y)
  local convertPoint = self.container:convertToNodeSpace(CCPoint(x, y))
  local size = self.container:getContentSize()
  local anchorPoint = self.container:getAnchorPoint()
  local ignoreAnchor = self.container:isIgnoreAnchorPointForPosition()
  local posBeginX = size.width * (ignoreAnchor and 0 or anchorPoint.x)
  local posBeginY = size.height * (ignoreAnchor and 0 or anchorPoint.y)
  local bInRect = posBeginX < convertPoint.x and convertPoint.x < posBeginX + size.width and posBeginY < convertPoint.y and convertPoint.y < posBeginY + size.height
  return bInRect
end
function prototype:setTouchedDelegate(func)
  self.touchedDelegate = func
end
function prototype:onTouchBegan(x, y)
  if not self.rootNode:isVisible() then
    return false
  end
  if not self:isPointInRect(x, y) then
    return false
  end
  return self:onTouchEnd(x, y, true)
end
function prototype:onTouchMoved(x, y)
end
function prototype:onTouchEnd(x, y, isCheck)
  local convertPoint = self.container:convertToNodeSpace(CCPoint(x, y))
  local curLine = 1
  local contentSize = {width = 0, height = 5}
  for i, v in ipairs(self.unitGroups) do
    if v.line ~= curLine then
      contentSize.height = contentSize.height + v.height
      curLine = v.line
    end
  end
  for _, v in ipairs(self.unitGroups) do
    if v.event and convertPoint.x > v.x - v.width and convertPoint.x < v.x and convertPoint.y > v.y + contentSize.height and convertPoint.y < v.y + v.height + contentSize.height then
      if not isCheck and self.touchedDelegate then
        self.touchedDelegate(v.event)
      end
      return true
    end
  end
  return false
end
