module((...), package.seeall)
local AI = require("Map.AI")
local Role = require("Scene.Role")
local MapObj = require("Map.MapObj")
local Define = require("Map.Define")
local MapMgr = require("Map.MapMgr")
local ImageNum = require("Map.ImageNum")
local internal = {}
class = Role.class:subclass()
class:include(MapObj.class)
function class:initialize(data, view, action)
  super.initialize(self, data, view, action)
  MapObj.class.initialize(self)
  self.bVisible = true
  self.mapObjType = Define.MAP_OBJ_TYPE.ROLE
  self.AI = nil
  self.canRunAICalbk = nil
  self.aiInfo = {isPatrol = false, isTrack = false}
  self.standType = Define.STAND_TYPE.STAND
  self.actionLst = {}
  self.actionFlag = {}
  self.moveType = Define.MOVE_STYLE_TYPE.AROUND_E
  self.movingInfo = {
    moving = false,
    nextPos = nil,
    movePath = nil,
    moveIdx = 1
  }
  self.moveCallBack = nil
  self.lockMove = {bLock = false, timeEnd = 0}
  self:SetDir(Scene.RoleView.DIR.D)
  self:SetProModelId(0)
end
function class:dispose()
  MapObj.class.dispose(self)
  super.dispose(self)
end
function class:GetSceneNode()
  return super.GetSceneNode(self)
end
function class:GetData(name)
  return MapObj.class.GetData(self, name)
end
function class:SetData(name, data)
  MapObj.class.SetData(self, name, data)
end
function class:SetVisible(bVisible)
  MapObj.class.SetVisible(self, bVisible)
  local sceneNode = self:GetSceneNode()
  sceneNode:SetVisible(bVisible)
end
function class:SetName(name)
  super.SetName(self, name)
end
function class:GetName()
  return super.GetName(self)
end
function class:SetModel(id)
  if super.GetModel(self, true) == id then
    return
  end
  super.SetModel(self, id)
  self:Stand(true)
end
function class:SetMount(id)
  super.SetMount(self, id)
  self:Stand(true)
end
function class:OnModelChanged()
  super.OnModelChanged(self)
end
function class:AddActionInLst(action, flag)
  for idx, info in ipairs(self.actionLst) do
    if info.action == action then
      return
    elseif info.flag == flag then
      local actionRole = self.action
      local actionMgr = actionRole.mgr
      actionMgr:Clear(actionRole, info.action)
      table.remove(self.actionLst, idx)
      break
    end
  end
  table.insert(self.actionLst, {action = action, flag = flag})
end
function class:SetAction(actionType, loop)
  assert(actionType)
  local actionRole = self.action
  local actionMgr = actionRole.mgr
  self:ClearActions()
  if loop then
    if actionType == Scene.RoleView.ACTION.STAND or actionType == Scene.RoleView.ACTION.FSTAND then
      self.standType = actionType == Scene.RoleView.ACTION.STAND and Define.STAND_TYPE.STAND or Define.STAND_TYPE.FSTAND
    end
    local action = actionMgr:Repeat(actionRole:Action(actionType))
    actionRole:Exec(action)
    local flag = internal:GetActionFlagId()
    self:AddActionInLst(action, flag)
    return flag
  else
    super.SetAction(self, actionType)
  end
  return 0
end
function class:SetActionByAction(action)
  self:ClearActions()
  local actionRole = self.action
  actionRole:Exec(action)
end
function class:AddAction(actionType, loop)
  if not loop then
    super.SetAction(self, action)
    return 0
  end
  local actionRole = self.action
  local actionMgr = actionRole.mgr
  local action = actionMgr:Repeat(actionRole:Action(actionType))
  actionRole:Exec(action)
  local flag = internal:GetActionFlagId()
  self:AddActionInLst(action, flag)
  return flag
end
function class:AddActionByAction(action)
  local actionRole = self.action
  actionRole:Exec(action)
  local flag = internal:GetActionFlagId()
  self:AddActionInLst(action, flag)
  return flag
end
function class:GetActionByFlag(flag)
  if not flag then
    return
  end
  for idx, info in ipairs(self.actionLst) do
    if info.flag == flag then
      return info.action, idx
    end
  end
end
function class:DeleteAction(action, idx)
  local actionRole = self.action
  local actionMgr = actionRole.mgr
  actionMgr:Clear(actionRole, action)
  if idx then
    table.remove(self.actionLst, idx)
  else
    for idx, info in ipairs(self.actionLst) do
      if info.action == action then
        table.remove(self.actionLst, idx)
        break
      end
    end
  end
end
function class:DeleteActionByFlag(flag)
  if not flag then
    return
  end
  local action, idx = self:GetActionByFlag(flag)
  if not action then
    return
  end
  self:DeleteAction(action, idx)
end
function class:ClearActions()
  local actionRole = self.action
  local actionMgr = actionRole.mgr
  for _, info in ipairs(self.actionLst) do
    actionMgr:Clear(actionRole, info.action)
  end
  self.actionLst = {}
end
function class:Stand(bForce)
  if not bForce and self:GetActionByFlag(self.actionFlag.stand) then
    return
  end
  local action = self.standType == Define.STAND_TYPE.STAND and Scene.RoleView.ACTION.STAND or Scene.RoleView.ACTION.FSTAND
  self.actionFlag.stand = self:SetAction(action, true)
end
function class:SetStandType(type)
  self.standType = type
  if self:GetActionByFlag(self.actionFlag.stand) then
    self:Stand(true)
  end
end
function class:GetStandAction()
  return self.standType == Define.STAND_TYPE.STAND and Scene.RoleView.ACTION.STAND or Scene.RoleView.ACTION.FSTAND
end
function class:FStand(bForce)
  if not bForce and self:GetActionByFlag(self.actionFlag.fstand) then
    return
  end
  self.actionFlag.fstand = self:SetAction(Scene.RoleView.ACTION.FSTAND, true)
end
function class:SetNameFontSize(size)
  super.SetNameFontSize(self, size)
end
function class:HitTest(ptSrn)
  if not self:IsInScreen() then
    return false
  end
  return self.view:HitTest(ptSrn)
end
function class:SetWorldPos(pos)
  self.view:SetPos(pos)
end
function class:GetWorldPos()
  local posScene = self.view:GetPos()
  return TwPoint(posScene.x, posScene.y)
end
function class:IsInScreen()
  local map = Singleton(MapMgr):GetMap()
  return map:IsPosInView(self:GetWorldPos())
end
function class:ComputeAStarPath(posWorld)
  local map = Singleton(MapMgr):GetMap()
  local posE = TwPoint(posWorld.x, posWorld.y)
  local curPos = self:GetWorldPos()
  local posB = TwPoint(curPos.x, curPos.y)
  local realPosE = posE
  local bEndChange = false
  if map:IsWorldPosInMask(posE) then
    realPosE = map:GetValidPosNearEnd(posB, posE, self.moveType)
    bEndChange = true
  end
  local realPosB = posB
  local bBeginChange = false
  if map:IsWorldPosInMask(posB) then
    realPosB = map:GetValidPosNearEnd(realPosE, posB, self.moveType)
    bBeginChange = true
  end
  local astarPath = Singleton(MapMgr):GetAStarPath(realPosB, realPosE)
  if not bBeginChange then
    self.movingInfo.moveIdx = 2
  else
    self.movingInfo.moveIdx = 1
  end
  self.movingInfo.movePath = astarPath
end
function class:GetAStarPath()
  return self.movingInfo.movePath
end
function class:GotoNextPos()
  local posNext = self:GetNextMovePos()
  if nil == posNext then
    return false
  end
  if not self:MoveTo(posNext) then
    return self:GotoNextPos()
  end
  return true
end
function class:LockMove(time)
  self.lockMove.bLock = true
  if nil == time or 0 == time then
    time = 0
  else
    time = time + TimeGetTime()
  end
  self.lockMove.timeEnd = time
end
function class:UnlockMove()
  self.lockMove.bLock = false
  self.lockMove.timeEnd = 0
end
function class:IsLock()
  if not self.lockMove.bLock then
    return false
  end
  if 0 == self.lockMove.timeEnd then
    return true
  end
  local curTime = TimeGetTime()
  if curTime > self.lockMove.timeEnd then
    self:UnlockMove()
    return false
  end
  return true
end
function class:MoveToWorld(posWorld, moveType)
  if self:IsLock() then
    return false
  end
  self.moveType = moveType or Define.MOVE_STYLE_TYPE.AROUND_E
  self:ComputeAStarPath(posWorld)
  return self:GotoNextPos()
end
function class:MoveTo(posWorld, bIgnorMask)
  local map = Singleton(MapMgr):GetMap()
  if not bIgnorMask and map:IsWorldPosInMask(posWorld) then
    self:StopMove()
    return false
  end
  local actionRole = self.action
  local actionMgr = actionRole.mgr
  self:DeleteActionByFlag(self.actionFlag.stand)
  self:DeleteActionByFlag(self.actionFlag.move)
  if not self:GetActionByFlag(self.actionFlag.run) then
    self.actionFlag.run = self:AddAction(Scene.RoleView.ACTION.RUN, true)
  end
  local callback = actionMgr:Do(function()
    self:OnMoveFinish()
  end)
  local turn, move = actionRole:Goto(posWorld.x, posWorld.y)
  local moveAction = actionMgr:Seq(turn, move, callback)
  self.actionFlag.move = self:AddActionByAction(moveAction)
  self.movingInfo.moving = true
  return true
end
function class:SetMoveCallBack(callback)
  self.moveCallBack = callback
end
function class:StopMove()
  self.movingInfo = {}
  self:Stand()
end
function class:IsMoving()
  return self.movingInfo.moving
end
function class:OnMoveFinish()
  if self:CanContinueMove() then
    self:GotoNextPos()
    return
  end
  local curPos = self.view:GetPos()
  local curMovePath = self:GetLastMovingPos()
  local bSuc = nil ~= curMovePath and curMovePath.x == curPos.x and curMovePath.y == curPos.y
  if nil ~= self.moveCallBack then
    self.moveCallBack(self, bSuc)
  end
  if nil ~= self.AI then
    self.AI:OnMoveFinish(bSuc)
  end
end
function class:CanContinueMove()
  if nil == self.movingInfo.movePath then
    return false
  end
  if self.movingInfo.moveIdx > #self.movingInfo.movePath then
    return false
  end
  return true
end
function class:GetLastMovingPos()
  if nil == self.movingInfo.movePath then
    return nil
  end
  return self.movingInfo.movePath[#self.movingInfo.movePath]
end
function class:GetNextMovePos()
  if not self:CanContinueMove() then
    return nil
  end
  local pos = self.movingInfo.movePath[self.movingInfo.moveIdx]
  self.movingInfo.moveIdx = self.movingInfo.moveIdx + 1
  return pos
end
function class:FloatingNumWord(value)
  local actionRole = self.action
  local actionMgr = actionRole.mgr
  local action = actionMgr:Do(function()
    local pos = self:GetWorldPos()
    local imageNum = ImageNum.class:new(self.view:Scene(), actionMgr, value)
    imageNum:GetSceneNode():SetPos(TwPoint(pos.x, pos.y - 175))
  end)
  actionMgr:Exec(actionRole, action)
end
function class:FloatingWord(text, color)
  local actionRole = self.action
  local actionMgr = actionRole.mgr
  local scene = self:GetScene()
  local sceneNode = self:GetSceneNode()
  color = color or 4278255360
  local nodeId = internal:GetNewNodeId()
  local textNode = Tw.Scene.Text:new(scene)
  sceneNode:Attach(nodeId, textNode, nodeId)
  textNode:SetPos(TwPoint(0, -100))
  textNode:SetStyle(UIDefine.RENDER_TEXT_STYLE.SHADOW)
  textNode:SetAlign(Tw.Scene.TEXT_ALIGN_CENTER)
  textNode:SetFontSize(20)
  textNode:SetText(text)
  textNode:SetColor(color)
  local scaleUp = actionMgr:Create(Tw.Scene.ScaleTo, 200, 1.5)
  local scaleDn = actionMgr:Create(Tw.Scene.ScaleTo, 200, 1)
  local delay = actionMgr:Wait(1000)
  local fadeOut = actionMgr:Create(Tw.Scene.FadeOut, 200)
  local destroy = actionMgr:Do(function()
    local node = sceneNode:Detach(nodeId)
    actionMgr:Clear(node)
    node:delete()
  end)
  local seq = actionMgr:Seq(scaleUp, scaleDn, delay, fadeOut, destroy)
  local move = actionMgr:Create(Tw.Scene.MoveBy, 3000, TwPoint(0, -240))
  local final = actionMgr:Spawn(seq, move)
  actionMgr:Mgr():Add(textNode, final)
end
function class:CreateAI(mgr, aiType, aiStatus)
  self.AI = AI.CreateAI(self, mgr, aiType, aiStatus)
  return self.AI
end
function class:SetAttackTarget(idTarget)
  if nil == idTarget or nil == self.AI then
    return
  end
  self.AI:SetAttackTarget(idTarget)
end
function class:SetAIStatus(status)
  if nil == self.AI then
    return
  end
  self.AI:SetStatus(status)
end
function class:HasAI()
  return nil ~= self.AI
end
function class:SetCanRunAICallBk(canRunAICalbk)
  self.canRunAICalbk = canRunAICalbk
end
function class:CanRunAI()
  if self.canRunAICalbk then
    return self.canRunAICalbk(self:GetId())
  end
  return self:HasAI() and self:IsVisible() and self:IsInScreen()
end
function class:ProcessAI()
  if nil == self.AI then
    return
  end
  if not self:CanRunAI() then
    return
  end
  self.AI:Process()
end
function class:SetPatrol(bCan)
  self.aiInfo.isPatrol = bCan
end
function class:CanPatrol()
  return self.aiInfo.isPatrol
end
function class:SetTrack(bCan)
  self.aiInfo.isTrack = bCan
end
function class:CanTrack()
  return self.aiInfo.isTrack
end
internal.flagId = 0
internal.nodeId = 1000
function internal:GetActionFlagId()
  internal.flagId = internal.flagId + 1
  return internal.flagId
end
function internal:GetNewNodeId()
  internal.nodeId = internal.nodeId + 1
  return internal.nodeId
end
