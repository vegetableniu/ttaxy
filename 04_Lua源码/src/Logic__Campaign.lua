module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
function class:initialize()
  super.initialize(self)
end
function class:dispose()
  super.dispose(self)
end
function class:GetCampainLst(type)
end
function class:GetCampaignInfoById(id)
  local info = KFDBGetRecord("CampaignConfig", id)
  if nil == info then
    log4battle:debug("get CampaignConfig failed:" .. id)
  end
  return info
end
function class:GetCampainName(id)
  local info = self:GetCampaignInfoById(id)
  if nil == info then
    return ""
  end
  return info.name
end
function class:GetCampainIntroduction(id)
  local info = self:GetCampaignInfoById(id)
  if nil == info then
    return ""
  end
  return info.introduction
end
