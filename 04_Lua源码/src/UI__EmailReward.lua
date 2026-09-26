module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local CONTEN_MAX = 10
require("SceneHelper")
function prototype:ReFrashEmailRewards(mailInfo)
  if mailInfo == nil or next(mailInfo) == nil then
    return
  end
  self.m_pCHeroIcon:ReFrashEmailInfo(mailInfo.code, false, mailInfo.type)
  self.staRewards:setString(Logic:Get("Reward"):RewardTreaTip(mailInfo))
end
