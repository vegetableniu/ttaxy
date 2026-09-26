module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("Logic.DramaControl")
local DramaControl = Logic.DramaControl
local CONST = {
  TOUCH_PRIORITY_COVER = -999,
  TOUCH_PRIORITY_LOCK = -998,
  TOUCH_PRIORITY_REVISE = -997
}
function prototype:onEnter()
  Logic:Get("DramaControl"):On(DramaControl.EVT.TALK, self:Event("talk"))
  Logic:Get("DramaControl"):On(DramaControl.EVT.END, self:Event("dramaEnd"))
  Logic:Get("DramaControl"):On(Logic.DramaControl.EVT.COVER_UI, self:Event("cover"))
  self.staLeft:setDimensions(CCSize(429, 0))
  self.staRight:setDimensions(CCSize(429, 0))
  self:setVisibleBg()
  local function setupCover(cover)
    cover:registerScriptTouchHandler(function(event, x, y, touch)
      if event == CCTOUCHBEGAN then
        local rect = cover:boundingBox()
        local pt = self.rootNode:convertToNodeSpace(touch:getLocation())
        return cover:boundingBox():containsPoint(pt)
      end
      return false
    end, false, CONST.TOUCH_PRIORITY_COVER, true)
    cover:ignoreAnchorPointForPosition(false)
  end
  setupCover(self.coverTop)
  setupCover(self.coverBottom)
  setupCover(self.coverLeft)
  setupCover(self.coverRight)
end
function prototype:bindAnimationMgr()
  return true
end
function prototype:completedAnimationSequenceNamed(name)
end
function prototype:runAmination(ani)
  local aniName = ani or "Default Timeline"
  self.animationMgr:runAnimations(aniName)
end
function prototype:onBgClicked()
  local bSuc = Logic:Get("DramaControl"):ClickNext()
  if not bSuc then
    SceneHelper:removePrompt(self.rootNode)
  end
end
function prototype:talk(idHead, idTalk, bLeft)
  if nil == idHead or idTalk == nil then
    return
  end
  self.staNameLeft:setString("")
  self.staNameRight:setString("")
  local name = Logic:Get("Hero"):GetHeroName(idHead)
  local staName = bLeft and self.staNameLeft or self.staNameRight
  staName:setString(name .. ":")
  self.staLeft:setString("")
  self.staRight:setString("")
  local strTalk = Logic:Get("DramaTalk"):GetDramaTalk(idTalk)
  local staText = bLeft and self.staLeft or self.staRight
  staText:setString(strTalk)
  self:setHead(idHead, bLeft)
  self:runAmination(bLeft and "Left Timeline" or "Right Timeline")
end
function prototype:dramaEnd()
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:setHead(idHead, bLeft)
  if nil == idHead then
    return
  end
  self.imgHeadL:setVisible(bLeft)
  self.imgHeadR:setVisible(not bLeft)
  local img = bLeft and self.imgHeadL or self.imgHeadR
  local imgPath = Logic:Get("Hero"):GetHeroImage(idHead, Logic.Hero.HEROIMG_SIZE.BIG)
  if nil == imgPath or "" == imgPath then
    log4drama:debug("dramatalk setHead faild " .. idHead)
    return
  end
  local sprite = CCSprite:create(imgPath)
  if sprite then
    img:setDisplayFrame(sprite:displayFrame())
  end
end
function prototype:setVisibleBg()
  if Logic:Get("DramaControl"):GetVisibleBG() then
    self.layerBg:setVisible(false)
  end
end
function prototype:onExit()
  Logic:Get("DramaControl"):setVisibleBG(false)
end
function prototype:cover(node)
  self.layerBg:setVisible(false)
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
end
