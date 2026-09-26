module((...), package.seeall)
require("Logic")
require("MsgPlatform")
class = Logic.class:subclass()
function class:initialize()
  super.initialize(self)
  self.drawPr = 0
  self.lastPraiseTime = 0
  MsgPlatform:On("DRAW_PRAISE_REWARD", self:Event("OnDrawPraiseReward"))
end
function class:setLastPraiseTime(time)
  self.lastPraiseTime = time
end
function class:PostDrawPraiseReward()
  MsgPlatform:Post("DRAW_PRAISE_REWARD", {})
end
function class:OnDrawPraiseReward(code, content)
  if code == 0 then
  end
end
function class:IsQH()
  local opID = Logic:Get("System"):GetOperatorId()
  local opName = Logic:Get("System"):GetOperatorName()
  if opID == nil or opID ~= "14" then
    return false
  end
  if opName == nil or opName ~= "360" then
    return false
  end
  return true
end
function class:IsOpenAd()
  if not self.IsQH() then
    return false
  end
  local level = Logic:Get("PlayerInfo"):GetPlayerLevel()
  if level < 20 then
    return false
  end
  local systime = Logic:Get("System"):GetTime()
  local year = tonumber(Logic:Get("System"):GetTimeStr("%y", systime))
  local month = tonumber(Logic:Get("System"):GetTimeStr("%m", systime))
  local day = tonumber(Logic:Get("System"):GetTimeStr("%d", systime))
  if year == 13 then
    if month == 11 and day < 29 then
      return false
    elseif month == 12 and day > 6 then
      return false
    end
  else
    return false
  end
  self.lastPraiseTime = self.lastPraiseTime or 0
  local darwTimeStr = Logic:Get("System"):GetTimeStr("%x", self.lastPraiseTime / 1000)
  local systimeStr = Logic:Get("System"):GetTimeStr("%x", systime)
  if darwTimeStr == systimeStr then
    return false
  end
  return true
end
