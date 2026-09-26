require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.fntCurrRate:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:bindAnimationMgr()
  return true
end
function prototype:onBtnRollBack(sender, event)
  self.animationMgr:runAnimations("hide")
  self.rootNode:getParent().bshowTips = false
end
function prototype:show()
  self.animationMgr:runAnimations("show")
end
function prototype:refreshUI()
  self.data = Logic:Get("Explore"):getCurrTask()
  self:showConditions()
  local rate = Logic:Get("Explore"):caluRate()
  if rate > 100 then
    rate = 100 or rate
  end
  self.fntCurrRate:setString(rate .. "%")
end
function prototype:showConditions()
  local idx = Logic:Get("Explore"):HasReduceColdDown() and 1 or 0
  if idx == 1 then
    local id = self.data.star .. "_" .. self.data.point
    local record = KFDBGetRecord("TaskPointCDConfig", id)
    if record then
      self.ccbCondition1:showLine(true)
      self.ccbCondition1:refreshReduseCd(record)
    end
  end
  for i = 1 + idx, 5 do
    local ccb = "ccbCondition" .. i
    local condition = self.data.successItems[i - idx]
    if condition then
      self[ccb]:showLine(true)
      self[ccb]:Refresh(condition, i)
    else
      self[ccb]:setVisible(false)
    end
  end
end
