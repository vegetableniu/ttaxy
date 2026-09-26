local INIT_TO = 640
SceneHelper = {}
SceneHelper.promptStack = {}
SceneHelper.layerStack = {}
function SceneHelper:pushPrompt(ccbName, rootNode)
  local runningScene = self:getRootLayer()
  if runningScene == nil then
    return
  end
  local prompt = Tw.Controller:load(ccbName, rootNode)
  if prompt == nil then
    return
  end
  runningScene:addChild(prompt, Logic:Get("GameSetting"):GetLayerPriority("prompt"))
  table.insert(self.promptStack, {name = ccbName, scene = prompt})
end
function SceneHelper:removePrompt(prompt, ccbName)
  local scene, idx = self:getPrompt(prompt, ccbName)
  if scene == nil then
    return
  end
  local succ, msg = pcall(function()
    scene:removeFromParentAndCleanup(true)
  end)
  table.remove(self.promptStack, idx)
end
function SceneHelper:getPrompt(prompt, ccbName)
  if #self.promptStack <= 0 then
    return nil, 0
  end
  for i = #self.promptStack, 1, -1 do
    local info = self.promptStack[i]
    if info and (prompt and prompt == info.scene or ccbName and info.name == ccbName) then
      return info.scene, i
    end
  end
  return nil, 0
end
function SceneHelper:isExistScene(ccbName)
  for _, scene in pairs(self.layerStack) do
    if scene.name == ccbName then
      return true
    end
  end
  return false
end
function SceneHelper:isExistPrompt(ccbName)
  for _, scene in pairs(self.promptStack) do
    if scene.name == ccbName then
      return true
    end
  end
  return false
end
function SceneHelper:insertScene(ccbName, rootNode, parent, priority)
  local runningScene = self:getRootLayer(parent)
  if runningScene == nil then
    return
  end
  local subScene = Tw.Controller:load(ccbName, rootNode)
  if subScene ~= nil then
    runningScene:addChild(subScene, priority)
  end
end
function SceneHelper:runWithScene(ccbName, rootNode, parent, reOpen)
  if #self.layerStack > 0 and not reOpen and self.layerStack[#self.layerStack].name == ccbName then
    return
  end
  local runningScene = self:getRootLayer(parent)
  if runningScene == nil then
    return
  end
  local delayTime = 0
  for _, scene in pairs(self.layerStack) do
    if scene.scene.onChange ~= nil then
      if scene.state ~= "exit" then
        scene.state = "exit"
        delayTime = scene.scene:onChange()
      end
      break
    end
  end
  local function _runWithScene()
    local subScene = Tw.Controller:load(ccbName, rootNode)
    if subScene ~= nil then
      self:ClearScene()
      runningScene:addChild(subScene, Logic:Get("GameSetting"):GetLayerPriority())
      table.insert(self.layerStack, {name = ccbName, scene = subScene})
    end
  end
  if delayTime and "number" == type(delayTime) and delayTime > 0 then
    local actionSets = CCArray:create()
    actionSets:addObject(CCDelayTime:create(delayTime))
    actionSets:addObject(CCCallFuncN:create(_runWithScene))
    runningScene:runAction(CCSequence:create(actionSets))
  else
    _runWithScene()
  end
end
function SceneHelper:ClearScene()
  for _, prompt in pairs(self.promptStack) do
    prompt.scene:removeFromParentAndCleanup(true)
  end
  self.promptStack = {}
  for _, scene in pairs(self.layerStack) do
    scene.scene:removeFromParentAndCleanup(true)
  end
  self.layerStack = {}
end
function SceneHelper:pushScene(ccbName, rootNode, parent, priority, notNeedHide)
  local runningScene = self:getRootLayer(parent)
  if runningScene == nil then
    return
  end
  local subScene = Tw.Controller:load(ccbName, rootNode)
  if subScene == nil then
    return
  end
  if #self.layerStack > 0 and not notNeedHide then
    self.layerStack[#self.layerStack].scene:setVisible(false)
  end
  table.insert(self.layerStack, {name = ccbName, scene = subScene})
  priority = priority or Logic:Get("GameSetting"):GetLayerPriority("scene")
  runningScene:addChild(subScene, priority)
end
function SceneHelper:removeScene(ccbName, removeSingle)
  local runningScene = self:getRootLayer()
  if runningScene == nil then
    return
  end
  local waitForDelete = {}
  local sceneId
  for idx, scene in ipairs(self.layerStack) do
    if scene.name == ccbName then
      scene.scene:removeFromParentAndCleanup(true)
      sceneId = idx
      table.insert(waitForDelete, idx)
      if removeSingle then
        break
      end
    end
  end
  if sceneId ~= nil then
    local needShowScene = false
    local fixId = 0
    if self.layerStack[sceneId + 1] == nil then
      needShowScene = true
    end
    for idx, sceneIdx in ipairs(waitForDelete) do
      table.remove(self.layerStack, sceneIdx - fixId)
      fixId = fixId + 1
    end
    if needShowScene and self.layerStack[#self.layerStack] ~= nil then
      self.layerStack[#self.layerStack].scene:setVisible(true)
    end
  end
end
function SceneHelper:pushMoveScene(ccbName, rootNode, parent, priority)
  local runningScene = self:getRootLayer(parent)
  if runningScene == nil then
    return
  end
  local subScene = Tw.Controller:load(ccbName, rootNode)
  if subScene == nil then
    return
  end
  if #self.layerStack > 0 then
    self.layerStack[#self.layerStack].scene:setVisible(false)
  end
  table.insert(self.layerStack, {name = ccbName, scene = subScene})
  local systemSize = Logic:Get("System"):GetDriveSize()
  subScene:setPosition(systemSize and systemSize.width or INIT_TO, 0)
  local actionMoveTo = CCMoveTo:create(0.3, ccp(0, 0))
  subScene:runAction(actionMoveTo)
  priority = priority or Logic:Get("GameSetting"):GetLayerPriority("scene")
  runningScene:addChild(subScene, priority)
end
function SceneHelper:popScene()
  local runningScene = self:getRootLayer()
  if runningScene == nil then
    return
  end
  if #self.layerStack > 1 then
    local preScene = self.layerStack[#self.layerStack - 1]
    local curScene = self.layerStack[#self.layerStack]
    if preScene == nil or curScene == nil then
      return
    end
    preScene.scene:setVisible(true)
    curScene.scene:removeFromParentAndCleanup(true)
    table.remove(self.layerStack, #self.layerStack)
  end
end
function SceneHelper:getTopLayer()
  return self.layerStack[#self.layerStack].scene
end
function SceneHelper:getRootLayer(parent)
  parent = parent or CCDirector:sharedDirector():getRunningScene()
  if nil == parent then
    return nil
  end
  local layer = parent:getChildByTag(999)
  if nil == layer then
    layer = self.transitionScene and self.transitionScene:getChildByTag(999) or nil
    if nil == layer then
      return
    end
  end
  return layer:getChildByTag(999)
end
function SceneHelper:createScene(ccbName)
  self:ClearScene()
  local scene = Tw.Controller:loadAsScene(ccbName)
  if nil == scene then
    return
  end
  CCDirector:sharedDirector():pushScene(scene)
end
function SceneHelper:replaceScene(ccbName)
  self:ClearScene()
  local scene = Tw.Controller:loadAsScene(ccbName)
  if nil == scene then
    return
  end
  CCDirector:sharedDirector():replaceScene(scene)
  return scene
end
function SceneHelper:guideActive()
  local rootLayer = self:getRootLayer()
  if rootLayer == nil then
    return
  end
  local cover = Tw.Controller:load("Guide", rootLayer)
  if cover == nil then
    return
  end
  rootLayer:addChild(cover, 999, 888)
end
function SceneHelper:guideDismiss()
  local rootLayer = self:getRootLayer()
  if rootLayer == nil then
    return
  end
  rootLayer:removeChildByTag(888, true)
end
function SceneHelper:transition(ccbName, time, transitionType, orientation)
  self:ClearScene()
  transitionType = transitionType or CCTransitionFade
  if nil == transitionType.create then
    return
  end
  local scene = Tw.Controller:loadAsScene(ccbName)
  if nil == scene then
    return
  end
  time = time or 1
  local transitionScene
  if nil ~= orientation then
    transitionScene = transitionType.create(transitionType, time, scene, orientation)
  else
    transitionScene = transitionType.create(transitionType, time, scene)
  end
  if nil == transitionScene then
    return
  end
  CCDirector:sharedDirector():replaceScene(transitionScene)
  self.transitionScene = scene
  return scene
end
