require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  local currTask = Logic:Get("Explore"):getCurrExecuteTask()
  self.data = currTask
  local rec = KFDBGetRecord("TaskPlace", currTask.point)
  self:setCard(rec.bossBaseId, self.sprBoss)
  local baseId = currTask.selfCards[1].baseId
  self:setCard(baseId, self.sprPlayer)
  local bSuccessed = Logic:Get("Explore"):IsTaskSuccessed()
  local winPath = "images/Explore/fntMissionSuccess.png"
  local failPath = "images/Explore/fntMissionFail.png"
  local path = bSuccessed and winPath or failPath
  local spr = CCSprite:create(path)
  if spr then
    self.sprResult:setDisplayFrame(spr:displayFrame())
  end
  local timeline = bSuccessed and "win" or "lose"
  self.animationMgr:runAnimations(timeline)
end
function prototype:bindAnimationMgr()
  return true
end
function prototype:completedAnimationSequenceNamed(name)
  local bSuccessed = Logic:Get("Explore"):IsTaskSuccessed()
  local aniName = bSuccessed and "UI/uikxz" or "UI/uikxz02"
  local ani = Logic:Get("AniMgr"):NewCCB(aniName, self.rootNode, ccp(320, 480), 0, nil, 1)
  ani:RunAni(nil, nil, function()
    SceneHelper:removePrompt(self.rootNode)
    Logic:Get("Explore"):promptReward()
  end)
end
function prototype:setCard(baseId, node)
  local cardNode = Logic:Get("HeroCardInfo"):GetSprCard(baseId)
  local texture, rect = Logic:Get("HeroCardInfo"):GetCardTexture(cardNode)
  node:setTexture(texture)
  node:setTextureRect(rect)
end
function prototype:onBtnCancel(sender, event)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnBg(sender, event)
end
function prototype:onBtnCover(sender, event)
end
function prototype:onBtnBox(sender, event)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnConfirm(sender, event)
end
function prototype:onImmediateFinish()
  SceneHelper:removePrompt(self.rootNode)
end
