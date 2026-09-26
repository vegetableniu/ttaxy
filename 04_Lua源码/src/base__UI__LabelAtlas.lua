module((...), package.seeall)
local MOVIE_INTERVAL_TIME = 30
local DEFAULT_FONT = "particles/fonts/labelatlas.png"
local DEFAULT_FONT_WIDTH = 16
local DEFAULT_FONT_HEIGTH = 24
local DEFAULT_FONT_MAP = "."
local NUMS = {
  GREEN_NUM = "particles/fonts/greenNum.fnt",
  BLUE_NUM = "particles/fonts/blueNum.fnt",
  YELLOW_NUM = "particles/fonts/yellowNum.fnt",
  TIME_NUM = "particles/fonts/timeNum.fnt",
  YELLOW_E_NUM = "particles/fonts/yellowNumEadge.fnt",
  LARGE_NUM = "particles/fonts/LargeNum.fnt",
  BIG_BLUE_NUM = "particles/fonts/bigBlueNum.fnt",
  DISCOUNT_NUM = "particles/fonts/discountNumber.fnt",
  ARMOR_ANI_NUM = "particles/fonts/yellowNumAni.fnt",
  PINK_NUM = "particles/fonts/pinkNum.fnt",
  ATTR_NUM = "particles/fonts/attrNum.fnt"
}
local DEFAULT_PLIST = NUMS.YELLOW_NUM
local LABEL_TAG = 128
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
  self.precision = 1
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:setColor(r, g, b)
  self.label:setColor(ccColor3B(r, g, b))
end
function prototype:setAlign(hAlign, vAlign)
  if self.label == nil then
    return
  end
  local anchorPoitX = 0
  local anchorPoitY = 0
  local node = self.node
  local label = self.label
  local x, y = label:getPosition()
  local nodeSize = node:getContentSize()
  y = nodeSize.height
  if hAlign == "RIGHT" then
    anchorPoitX = 1
    x = nodeSize.width
  elseif hAlign == "CENTER" then
    anchorPoitX = 0.5
    x = nodeSize.width / 2
  elseif hAlign == "LEFT" then
    anchorPoitX = 0
    x = 0
  end
  if vAlign == "TOP" then
    anchorPoitY = 1
    y = nodeSize.height
  elseif vAlign == "BOTTOM" then
    anchorPoitY = 0
    y = 0
  elseif vAlign == "CENTER" then
    anchorPoitY = 0.5
    y = nodeSize.height / 2
  end
  label:setAnchorPoint(CCPoint(anchorPoitX, anchorPoitY))
  label:setPosition(ccp(x, y))
end
function prototype:IsExist(node)
  node = node or self.rootNode
  local label = node:getChildByTag(LABEL_TAG)
  self.label = label
  return label ~= nil
end
function prototype:createLabel(strNum, charMapFile, itemWidth, itemHeight, startCharMap, node)
  if not strNum then
  else
    strNum = "0" or tostring(strNum)
  end
  if self:IsExist(node) then
    self:setValueWithPrecision(strNum)
    return
  end
  charMapFile = charMapFile or DEFAULT_FONT
  local label = CCLabelAtlas:create(strNum, charMapFile, itemWidth or DEFAULT_FONT_WIDTH, itemHeight or DEFAULT_FONT_HEIGTH, string.byte(startCharMap or DEFAULT_FONT_MAP))
  self:createInner(label, node)
end
function prototype:create(strNum, plistFileName, node)
  self:createPlist(strNum, NUMS[plistFileName], node)
end
function prototype:createPlist(strNum, plistFile, node)
  strNum = (strNum or 0) / self.precision
  if not strNum then
  else
    strNum = "0" or tostring(strNum)
  end
  if self:IsExist(node) then
    self:setValueWithPrecision(strNum)
    return
  end
  plistFile = plistFile or DEFAULT_PLIST
  local label = CCLabelBMFont:create()
  label:setFntFile(plistFile)
  self.label = label
  self:setValueWithPrecision(strNum)
  self:createInner(label, node)
end
function prototype:createInner(label, node)
  node = node or self.rootNode
  local nodeSize = node:getContentSize()
  local labelSize = label:getContentSize()
  local scaleH = nodeSize.height / labelSize.height
  label:setScale(scaleH)
  node:addChild(label, 0, LABEL_TAG)
  self.node = node
  self:setAlign("LEFT", "TOP")
  return label
end
function prototype:setPrecision(precision, validNum)
  assert(precision ~= 0, "Divisor cannot be zero!")
  self.precision = precision
  self.validNum = validNum
end
function prototype:setCallback(cbk)
  self.callback = cbk
end
function prototype:setValueAniByStep(value, stepValue, precisionFix)
  if self.label == nil then
    return
  end
  local curValue = tonumber(tostring(self.label:getString()))
  if curValue == nil then
    return
  end
  if not precisionFix then
    value = value / self.precision
  end
  self.nextValue = curValue and curValue / self.precision or 0
  self.toValue = value
  self.stepValue = stepValue
  if stepValue == 0 then
    self:setValueWithPrecision(value)
    self:CallBack()
    return 0
  end
  local arrAction = CCArray:create()
  arrAction:addObject(CCDelayTime:create(MOVIE_INTERVAL_TIME / 1000))
  arrAction:addObject(CCCallFuncN:create(function()
    self:processMovie()
  end))
  local seq = CCSequence:create(arrAction)
  local moveAction = CCRepeatForever:create(seq)
  self.label:runAction(moveAction)
  return math.ceil((value - curValue) / stepValue * MOVIE_INTERVAL_TIME)
end
function prototype:setValueAni(value, allTime)
  assert(type(value) == "number")
  value = value / self.precision
  local curValue = tonumber(tostring(self.label:getString()))
  curValue = curValue and curValue / self.precision or 0
  local stepValue = (value - curValue) / allTime * MOVIE_INTERVAL_TIME
  self:setValueAniByStep(value, stepValue, true)
  return stepValue
end
function prototype:setValueWithPrecision(value)
  value = value * self.precision
  value = self:toValidString(value)
  self.label:setString(tostring(value))
end
function prototype:toValidString(value)
  local validNum = self.validNum
  if validNum then
    local fmt = "%." .. validNum .. "f"
    value = string.format(fmt, value)
  end
  return value
end
function prototype:setValue(value)
  value = self:toValidString(value)
  self.label:setString(tostring(value))
end
function prototype:getValue()
  return tostring(self.label:getString())
end
function prototype:processMovie()
  self.nextValue = self.nextValue + self.stepValue
  local function IsRollEnd()
    if self.stepValue > 0 then
      return self.nextValue >= self.toValue
    end
    return self.nextValue <= self.toValue
  end
  if not IsRollEnd() then
    self:setValueWithPrecision((math.ceil(self.nextValue)))
    return
  end
  self:setValueWithPrecision(self.toValue)
  self.label:stopAllActions()
  self:CallBack()
end
function prototype:CallBack()
  if self.callback then
    self.callback()
  end
end
function prototype:reorderChild(lv)
  self.node:reorderChild(self.label, lv)
end
function prototype:removeChild(bClean)
  self.node:removeChild(self.label, bClean)
end
function prototype:Owner()
  return self.label
end
function prototype:setFntFile(plistFileName)
  if not self.label then
    return
  end
  self.label:setFntFile(NUMS[plistFileName])
end
