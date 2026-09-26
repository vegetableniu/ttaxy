module((...), package.seeall)
local Define = require("BattleShow.BattleDefine")
prototype = Tw.Controller.prototype:extend()
function prototype:onNodeLoaded(node, loader)
  self.doneFun = {}
end
function prototype:bindAnimationMgr()
  return true
end
function prototype:completedAnimationSequenceNamed(name)
  if self.doneFun[name] then
    local doneFun = self.doneFun[name]
    self.doneFun[name] = nil
    doneFun()
  end
end
function prototype:SetWaitSign(doneFun, aniName)
  if doneFun and aniName then
    self.doneFun[aniName] = doneFun
  end
end
function prototype:SetWaitSignByDefaultAniName(doneFun)
  local aniName = "Shine"
  self:SetWaitSign(doneFun, aniName)
end
function prototype:RunAmination(ani)
  local aniName = ani or "Shine"
  self.animationMgr:runAnimations(aniName)
end
