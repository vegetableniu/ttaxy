require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.bRollUp = true
  self.ttfLineupName:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:bindAnimationMgr()
  return true
end
function prototype:runTimeline()
  local timeLine = self.bRollUp and "rollUp" or "pullDown"
  self.animationMgr:runAnimations(timeLine)
  self:runShiningAni(not self.bRollUp)
end
function prototype:onBtnLineup(sender, event)
  self.bRollUp = not self.bRollUp
  self:runTimeline()
  self.owner:onClickedGroup(self.idx)
end
function prototype:onBtnChangeName(sender, event)
  Logic:Get("Lineup"):setOldName(self.data.name)
  SceneHelper:pushPrompt("LineupRename", self.rootNode)
end
function prototype:onBtnSave(sender, event)
  if self:isEmptyEmbattle() then
    Prompt:Fail(115329)
    return
  end
  Logic:Get("Lineup"):postUseTeam(self.data.name, false)
end
function prototype:setOwner(owner, idx)
  self.owner = owner
  self.idx = idx
end
function prototype:isRollUp()
  return self.bRollUp
end
function prototype:reset()
  self.bRollUp = true
  self:runTimeline()
end
function prototype:refreshItem(data)
  if table.empty(data or {}) then
    return
  end
  self.data = data
  self.ttfLineupName:setString(data.name or "")
  self:refreshHeros()
end
function prototype:refreshHeros()
  for idx, group in ipairs(self.data.groups or {}) do
    local ccb = "ccbGroup" .. idx
    self[ccb]:refreshGroup(group, self.data.name, idx)
  end
end
function prototype:isEmptyEmbattle()
  local teamLeaders = Logic:Get("Lineup"):getTeamLeaderByName(self.data.name)
  for i, leaderId in ipairs(teamLeaders) do
    if leaderId == ID[-1] or leaderId == ID[0] then
      return true
    end
  end
  return false
end
function prototype:runShiningAni(bRun)
  if bRun then
    local array = CCArray:create()
    array:addObject(CCFadeTo:create(1, 150))
    array:addObject(CCFadeTo:create(1, 0))
    local actions = CCRepeatForever:create(CCSequence:create(array))
    self.sprBreath:runAction(actions)
    return
  end
  self.sprBreath:stopAllActions()
  self.sprBreath:setOpacity(0)
end
