module((...), package.seeall)
local Define = require("BattleShow.BattleDefine")
prototype = Tw.Controller.prototype:extend()
local ANI_NAME = "Default Timeline"
function prototype:onNodeLoaded(node, loader)
  self.doneFun = {}
end
function prototype:bindAnimationMgr()
  return true
end
function prototype:completedAnimationSequenceNamed(name)
  if self.doneFun[name] then
    if self.doneFun[name].timeout ~= nil then
      self:EventTracer():Cancel(name)
    end
    local doneFun = self.doneFun[name].cbk
    if not self.doneFun[name].retain then
      self.doneFun[name] = nil
    end
    doneFun()
  end
end
function prototype:CleanUp(bFinfish)
  if bFinfish then
    for name, _ in pairs(self.doneFun) do
      self:completedAnimationSequenceNamed(name)
    end
  end
  self.doneFun = {}
end
function prototype:FinishAni()
  self:completedAnimationSequenceNamed(ANI_NAME)
end
function prototype:SetWaitSign(doneFun, aniName, timeout, retain)
  retain = nil
  local aniName = aniName or ANI_NAME
  if doneFun and aniName then
    assert(self.doneFun[aniName] == nil or self.doneFun[aniName].retain == true)
    self.doneFun[aniName] = {
      cbk = doneFun,
      timeout = timeout,
      retain = retain
    }
  end
end
function prototype:SetWaitSignByDefaultAniName(doneFun, timeout)
  local aniName = ANI_NAME
  self:SetWaitSign(doneFun, aniName, timeout)
end
function prototype:RunAnimation(ani)
  local aniName = ani or ANI_NAME
  if self.animationMgr == nil then
    self:completedAnimationSequenceNamed(aniName)
    return
  end
  if self.doneFun[aniName] ~= nil and self.doneFun[aniName].timeout ~= nil then
    Singleton(Timer):After(self.doneFun[aniName].timeout, self:Event(aniName, function()
      self:completedAnimationSequenceNamed(aniName)
    end))
  end
  self.animationMgr:runAnimations(aniName)
end
function prototype:SetVisible()
end
function prototype:SetCloseCallback(owner, callback)
  self.callback = bind(callback, owner)
end
function prototype:onBtnClose(event)
  if self.callback ~= nil then
    self.callback(event)
  end
end
function prototype:SetCCBName(name)
  self.ccbName = name
end
