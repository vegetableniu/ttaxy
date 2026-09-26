module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.ttfGiftInfo:setStyle(kCCLabelTTFStyleOutline)
  self.ttfGain:setStyle(kCCLabelTTFStyleOutline)
  self.ttfFeat:setStyle(kCCLabelTTFStyleOutline)
  self.ttfProgress:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:refrashTask(data)
  if table.empty(data or {}) then
    return
  end
  self.data = data
  self.ttfGiftInfo:setString(data.name or "")
  self.ttfGain:setString(data.desc or "")
  self.ttfFeat:setString(data.feats or "")
  self.ccbIcon:ReFreshByGift(data)
  self:createProgress()
end
function prototype:createProgress()
  self.ttfProgress:setString("")
  self.nodCatchTask:setVisible(true)
  self.sprFinish:setVisible(false)
  self:changeAcceptBtnImg(nil)
  local path = "images/Christmas/reveice_task.png"
  self:changeBtnImg(path)
  local progress = Logic:Get("GodReward"):GetProgress()
  if table.empty(progress) then
    return
  end
  local path
  if progress[self.data.id] then
    self.ttfProgress:setString(TwGetStr(106220, progress[self.data.id], self.data.target))
    path = "images/GodReward/fntGiveTask.png"
    self:changeBtnImg(path)
    self.sprFinish:setVisible(progress[self.data.id] >= self.data.target)
    self.nodCatchTask:setVisible(progress[self.data.id] < self.data.target)
    if progress[self.data.id] < self.data.target then
      local paths = {}
      paths.normalPath = "images/Christmas/lred_button_nor.png"
      paths.selectPath = "images/Christmas/lred_button_hig.png"
      self:changeAcceptBtnImg(paths)
    end
    return
  end
  self.nodCatchTask:setVisible(false)
end
function prototype:changeAcceptBtnImg(paths)
  local imgPaths = paths or {}
  local normalPath = imgPaths.normalPath or "images/Christmas/lgre_button_nor.png"
  local selectPath = imgPaths.selectPath or "images/Christmas/lgre_button_hig.png"
  local sprNormal = CCScale9Sprite:create(normalPath)
  local sprSelect = CCScale9Sprite:create(selectPath)
  self.btnTask:setBackgroundSpriteForState(sprNormal, CCControlStateNormal)
  self.btnTask:setBackgroundSpriteForState(sprSelect, CCControlStateHighlighted)
end
function prototype:changeBtnImg(path)
  local spr = CCSprite:create(path)
  if spr then
    self.sprTask:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:onBtnGain(sender, event)
  local progress = Logic:Get("GodReward"):GetProgress()
  if table.empty(progress) or not progress[self.data.id] then
    return
  end
  if progress[self.data.id] < self.data.target then
    return
  end
  Logic:Get("GodReward"):PostGetTaskReward(self.data.id)
end
function prototype:onBtnTask(sender, event)
  local progress = Logic:Get("GodReward"):GetProgress()
  if table.empty(progress) then
    Logic:Get("GodReward"):PostAcceptTask(self.data.id)
    return
  end
  local path
  if progress[self.data.id] then
    Prompt:Confirm(self, "", 110913, self.onConfirmGiveUpTask, Prompt.PROMPT_TYPE.SELECT)
    return
  end
end
function prototype:onConfirmGiveUpTask()
  Logic:Get("GodReward"):PostGiveUpTask(self.data.id)
end
