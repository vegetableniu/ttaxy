module((...), package.seeall)
require("Logic")
local CCBAni = require("BattleShow.CCBAnimation")
EVT = Enum({})
local DEFAULT_NAME = "DEFAULT"
class = Logic.class:subclass()
function class:initialize()
  super.initialize(self)
  self.group = {}
end
function class:dispose()
  super.dispose(self)
end
function class:Spawn(grpName, bAutoRm, callback)
  local group = self.group[grpName]
  if group == nil then
    return
  end
  local PlayOne = function(ani, sync)
    local waitSign = sync:Join()
    ani:SetWaitSignByDefaultAniName(waitSign)
    ani:setVisible(true)
    ani:RunAnimation()
  end
  local function PlayAll()
    local synchroniser = Utils.Synchroniser:new()
    for _, ani in ipairs(group) do
      PlayOne(ani, synchroniser)
    end
    synchroniser:Sync()
    if bAutoRm then
      self:RemoveGroup(grpName)
    end
    if callback ~= nil then
      callback()
    end
  end
  RunInCoroutine(PlayAll)
end
function class:Sequence(grpName, bAutoRm, callback)
  local group = self.group[grpName]
  if group == nil then
    return
  end
  local PlayOne = function(ani)
    if ani.callfun then
      return ani.callfun()
    end
    local synchroniser = Utils.Synchroniser:new()
    local waitSign = synchroniser:Join()
    ani:SetWaitSignByDefaultAniName(waitSign)
    ani:setVisible(true)
    ani:RunAnimation()
    synchroniser:Sync()
  end
  local function PlayAll()
    for _, ani in ipairs(group) do
      PlayOne(ani)
    end
    if bAutoRm then
      self:RemoveGroup(grpName)
    end
    if callback ~= nil then
      callback()
    end
  end
  RunInCoroutine(PlayAll)
end
function class:Cbk(fun)
  return {callfun = fun}
end
function class:FindGroup(grpName)
  for name, _ in pairs(self.group) do
    if name == grpName then
      return name
    end
  end
end
function class:CreateSequence(actions)
  local actArray = CCArray:create()
  for _, act in ipairs(actions) do
    local obj = act
    if type(act) == "function" then
      obj = CCCallFuncN:create(act)
    end
    actArray:addObject(obj)
  end
  return CCSequence:create(actArray)
end
function class:CreateSpawn(actions)
  local actArray = CCArray:create()
  for _, act in ipairs(actions) do
    local obj = act
    if type(act) == "function" then
      obj = CCCallFuncN:create(act)
    end
    actArray:addObject(obj)
  end
  return CCSpawn:create(actArray)
end
function class:DelayTimeSync(owner, time, bSync, callback)
  if owner == nil then
    return
  end
  local aniLogic = Logic:Get("AniMgr")
  local actions = {}
  local waitSign, sync
  if bSync then
    sync = Utils.Synchroniser:new()
    waitSign = sync:Join()
  end
  local delay = CCDelayTime:create(time)
  table.insert(actions, delay)
  table.insert(actions, function()
    if callback then
      callback()
    end
    if bSync then
      waitSign()
    end
  end)
  owner:runAction(aniLogic:CreateSequence(actions))
  if bSync then
    sync:Sync()
  end
end
function class:MoveToAndRotateSync(owner, time, pos, angle)
  if nil == owner then
    return
  end
  local actions = {}
  local sync = Utils.Synchroniser:new()
  local waitSign = sync:Join()
  local HeroMoveTo = CCMoveTo:create(time, pos)
  table.insert(actions, HeroMoveTo)
  table.insert(actions, waitSign)
  owner:runAction(self:CreateSpawn({
    CCRotateTo:create(time, angle),
    self:CreateSequence(actions)
  }))
  sync:Sync()
end
function class:MoveToSync(owner, time, pos, bTop)
  if owner == nil then
    return
  end
  if bTop then
    owner:getParent():reorderChild(owner, 0)
  end
  local aniLogic = Logic:Get("AniMgr")
  local actions = {}
  local sync = Utils.Synchroniser:new()
  local waitSign = sync:Join()
  local HeroMoveTo = CCMoveTo:create(time, pos)
  table.insert(actions, HeroMoveTo)
  table.insert(actions, function()
    waitSign()
  end)
  owner:runAction(aniLogic:CreateSequence(actions))
  sync:Sync()
end
function class:AccMoveToSync(owner, time, pos, bTop)
  if owner == nil then
    return
  end
  if bTop then
    owner:getParent():reorderChild(owner, 0)
  end
  local aniLogic = Logic:Get("AniMgr")
  local actions = {}
  local sync = Utils.Synchroniser:new()
  local waitSign = sync:Join()
  local HeroMoveTo = CCMoveTo:create(time, pos)
  table.insert(actions, CCDelayTime:create(0.2))
  table.insert(actions, CCEaseExponentialIn:create(HeroMoveTo))
  table.insert(actions, function()
    waitSign()
  end)
  owner:runAction(aniLogic:CreateSequence(actions))
  sync:Sync()
end
function class:RotateToSync(owner, time, angle)
  if owner == nil then
    return
  end
  local aniLogic = Logic:Get("AniMgr")
  local actions = {}
  local sync = Utils.Synchroniser:new()
  local waitSign = sync:Join()
  local HeroRotateTo = CCRotateTo:create(time, angle)
  table.insert(actions, HeroRotateTo)
  table.insert(actions, function()
    waitSign()
  end)
  owner:runAction(aniLogic:CreateSequence(actions))
  sync:Sync()
end
function class:CreateGroup(grpName)
  local group = self.group[grpName]
  if group == nil then
    self.group[grpName] = {}
  end
end
function class:Add(ani, grpName)
  grpName = grpName or DEFAULT_NAME
  self:CreateGroup(grpName)
  table.insert(self.group[grpName], ani)
end
function class:RunCCBAniSync(ccb, owner, bAutoRm, pos)
  local ani = CCBAni.class:new(ccb, owner, pos)
  return ani:RunAnimationSync(bAutoRm)
end
function class:RunCCBAni(ccb, owner, pos, scale, bAutoRm, waitSign, aniName, level, bFilp, timeout, retain)
  local ani = CCBAni.class:new(ccb, owner, pos, level, bFilp, scale)
  local cbk
  if bAutoRm then
    function cbk()
      ani:RemoveAnimation()
      if waitSign then
        waitSign()
      end
    end
  end
  ani:RunAnimationByWaitSign(aniName, cbk, timeout, retain)
  return ani
end
function class:NewCCB(ccb, owner, pos, level, bFilp, scale, hasTag)
  local ani = CCBAni.class:new(ccb, owner, pos, level, bFilp, scale)
  ani:AddToParent(hasTag)
  return ani
end
function class:RunSequence(owner, actions, sync)
  local synchroniser = sync or Utils.Synchroniser:new()
  local actArray = CCArray:create()
  for _, act in ipairs(actions) do
    actArray:addObject(act)
  end
  local wait = synchroniser:Join()
  actArray:addObject(CCCallFuncN:create(function()
    wait()
  end))
  owner:runAction(CCSequence:create(actArray))
  if not sync then
    synchroniser:Sync()
  end
end
function class:AddCCB(ccb, owner, pos, level, grpName)
  grpName = grpName or DEFAULT_NAME
  self:CreateGroup(grpName)
  local ani = CCBAni.class:new(ccb, owner, pos, level)
  table.insert(self.group[grpName], ani)
end
function class:RemoveGroup(grpName)
  if self.group[grpName] == nil then
    return
  end
  grpName = grpName or DEFAULT_NAME
  for _, ani in ipairs(self.group[grpName]) do
    if ani.RemoveAnimation ~= nil then
      ani:RemoveAnimation()
    elseif ani.callfun == nil and ani.setVisible ~= nil then
      ani:setVisible(false)
    end
  end
  self.group[grpName] = {}
end
function class:RemoveAll()
  self.group = {}
end
