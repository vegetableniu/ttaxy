module((...), package.seeall)
local LAYER = {ANIMATION = 1, NAME = 100}
ANIM_EVENT = {
  FINISH = "finish",
  DELETE = "delete",
  START_COLLECT = "start_collect",
  END_COLLECT = "end_collect"
}
local DEFAULT_ANIM_HEIGHT = -140
class = objectlua.Object:subclass()
function class:initialize(scene, actionMgr, owner)
  super.initialize(self)
  self.scene = scene
  self.actionMgr = actionMgr
  self.owner = owner
  self.sceneNode = Tw.Scene.NodeSet:new(self.scene)
  self.scene:Attach(self.sceneNode)
  self.nameNode = nil
  self.animNodeSet = {}
  self.stageNum = 0
  self.stageBeginTime = 0
  self.stageTime = 0
  self.curStage = 1
  self.data = nil
end
function class:dispose()
  self.actionMgr:Mgr():Del(self.sceneNode)
  self.sceneNode = nil
  self.animNodeSet = {}
  super.dispose(self)
end
function class:Run(file, stage)
  local data = CTwFilePack.Open("conf/animation/" .. file .. ".conf")
  if nil == data or "" == data then
    data = CTwFilePack.Open("conf/animation/default.conf")
  end
  local dataAnim = json.decode(data)
  if nil == dataAnim then
    return
  end
  self.data = dataAnim
  self.stageNum = table.getn(dataAnim.stage)
  if nil == stage then
    self.curStage = 1
  elseif stage <= 0 or stage > self.stageNum then
    self.curStage = self.stageNum
  else
    self.curStage = stage
  end
  self:RunStage()
end
function class:GetSceneNode()
  return self.sceneNode
end
function class:SetName(name)
  if nil == self.nameNode then
    self.nameNode = Tw.Scene.Text:new(self.scene)
    self.sceneNode:Attach(LAYER.NAME, self.nameNode, LAYER.NAME)
    self.nameNode:SetPos(TwPoint(0, DEFAULT_ANIM_HEIGHT))
  end
  self.nameNode:SetText(name)
end
function class:SetPos(pos)
  self.sceneNode:SetPos(pos)
end
function class:GetPos()
  return self.sceneNode:GetPos()
end
function class:RunStage()
  self:ClearAnimNodes()
  local infoStage = self:GetCurStage()
  if nil == infoStage then
    return false
  end
  self:FireEvent(infoStage.startevent)
  local num = 0
  local maxTime = 0
  for _, item in ipairs(infoStage.item or {}) do
    do
      local aniFile = item.ani == nil and ANI.INTERACTIVE or item.ani
      local id = ANI_ID(aniFile, item.title)
      local ani = Tw.Scene.Animation:new(self.scene)
      local _, _, x, y = string.find(item.pos, "(.-),(.*)")
      if item.flip == nil then
      end
      local flip = item.flip == "true"
      ani:SetPos(TwPoint(tonumber(x), tonumber(y)))
      ani:SetAni(id, true)
      ani:SetFlip(flip)
      local time = Tw.Scene.AnimationTime(id)
      maxTime = math.max(maxTime, time)
      if item.loop == "true" and time > 0 then
        local delay = self.actionMgr:Wait(time)
        local setFrame = self.actionMgr:Call(function()
          ani:SetFrame(0)
        end)
        local actionEffect = self.actionMgr:Seq(delay, setFrame)
        local action = self.actionMgr:Repeat(actionEffect)
        self.actionMgr:Mgr():Add(self.sceneNode, action)
      end
      local nodeId = num + 1
      table.insert(self.animNodeSet, {id = nodeId, node = ani})
      self.sceneNode:Attach(nodeId, ani, num + LAYER.ANIMATION)
      num = num + 1
    end
  end
  if nil == infoStage.time or -1 == tonumber(infoStage.time) then
    self.stageTime = -1
  elseif 0 == tonumber(infoStage.time) then
    self.stageTime = maxTime
  else
    self.stageTime = tonumber(infoStage.time)
  end
  self.stageBeginTime = TimeGetTime()
  if infoStage.autonext == "true" and 0 <= self.stageTime then
    local callback = self.actionMgr:Do(function()
      self:StageEnd()
    end)
    local delay = self.actionMgr:Wait(self.stageTime)
    self.actionMgr:Mgr():Add(self.sceneNode, self.actionMgr:Seq(delay, callback))
  end
  if 0 < self.stageTime and infoStage.showprogress == "true" then
    DlgTmpl:Open("Progress", {
      self.stageTime,
      UIDefine.DLG_PROGRESS_OPEN_MODE.CAIJI,
      infoStage.progresstext
    })
    self:FireEvent(ANIM_EVENT.START_COLLECT)
    local callback = self.actionMgr:Do(function()
      self:FireEvent(ANIM_EVENT.END_COLLECT)
    end)
    local delay = self.actionMgr:Wait(self.stageTime)
    self.actionMgr:Mgr():Add(self.sceneNode, self.actionMgr:Seq(delay, callback))
  end
end
function class:NextStage()
  local infoStage = self:GetCurStage()
  if infoStage.showprogress == "true" then
    local curTime = TimeGetTime()
    if curTime < self.stageBeginTime + self.stageTime then
      local callback = self.actionMgr:Do(function()
        self:NextStage()
      end)
      local delay = self.actionMgr:Wait(self.stageBeginTime + self.stageTime - curTime)
      local action = self.actionMgr:Seq(delay, callback)
      self.actionMgr:Mgr():Add(self.sceneNode, action)
      return
    end
  end
  self:FireEvent(infoStage.endevent)
  if self:IsLastStage() then
    return
  end
  self.curStage = self.curStage + 1
  self:RunStage()
end
function class:SetStage(stage)
  if stage < 1 or stage > self.stageNum then
    return
  end
  self.curStage = stage
  self:RunStage()
end
function class:GetCurStage()
  if self.curStage > self.stageNum then
    return nil
  end
  return self.data.stage[self.curStage]
end
function class:IsLastStage()
  return self.curStage == self.stageNum
end
function class:StageEnd()
  self:NextStage()
end
function class:ClearAnimNodes()
  self.actionMgr:Mgr():Del(self.sceneNode)
  for _, item in ipairs(self.animNodeSet) do
    self.sceneNode:Detach(item.id)
    item.node:delete()
  end
  self.animNodeSet = {}
end
function class:FireEvent(flag)
  if nil == flag or "" == flag or type(flag) == "table" then
    return
  end
  self.owner:OnEvent(flag)
end
function class:HitTest(ptSrn)
  if nil == self.sceneNode then
    return false
  end
  for _, item in ipairs(self.animNodeSet) do
    if nil ~= item.node and item.node:HitTest(ptSrn) then
      return true
    end
  end
  return false
end
function class:OnClick()
  if self:IsLastStage() then
    self:StageEnd()
    return
  end
  local infoStage = self:GetCurStage()
  if nil == infoStage then
    return
  end
  if infoStage.showprogress ~= "true" then
    self:NextStage()
    return
  end
  local curTime = TimeGetTime()
  if curTime < self.stageBeginTime + self.stageTime then
    return
  end
  self:NextStage()
end
