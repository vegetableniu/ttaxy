module((...), package.seeall)
require("Logic")
require("SceneHelper")
class = Logic.class:subclass()
EVT = Enum({
  "GET_OTHER_DRAW_RESULT",
  "DRAW_RESULT",
  "DRAW_FAILED"
})
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.player.facade.PlayerResult"))
local MSG_RESULT_STR = {ROULETTE_LOTTERY_LEVEL_LIMIT = 108013}
function class:initialize()
  super.initialize(self)
  self.lastDrawLevel = 0
  self.nextDrawLevel = 0
  self.hasDraw = false
  self.otherPlayerDrawResult = {}
  self.drawResultId = 0
  MsgPlayer:On("ROULETTE_LOTTERY", self:Event("OnGetDrawResult"), false)
  MsgPlayer:On("ROULETTE_LOTTERY_RESULTS", self:Event("OnGetOtherPlayerDrawResult"))
end
function class:initDrawLevel()
  local drawInfo = KFDBGetRecord("ConfigValue", "PLAYER:ROULETTE_LOTTERY_LEVEL")
  if drawInfo and drawInfo.content ~= "" then
    local drawLevel = json.decode(drawInfo.content)
    for k, v in pairs(drawLevel) do
      if self.lastDrawLevel < 0 then
        self.nextDrawLevel = v
        self.hasDraw = true
        break
      elseif v > self.lastDrawLevel then
        self.nextDrawLevel = v
        self.hasDraw = true
        break
      end
      self.hasDraw = false
    end
  end
end
function class:setLastDrawLevel(level)
  if level ~= nil then
    self.lastDrawLevel = level
  else
    self.lastDrawLevel = -1
  end
  self:initDrawLevel()
end
function class:getLastDrawLevel()
  return self.lastDrawLevel
end
function class:getNextDrawLevel()
  return self.nextDrawLevel
end
function class:getHasDraw()
  return self.hasDraw
end
function class:getDrawResultId()
  return self.drawResultId
end
function class:getOtherPlayerDrawResult()
  return self.otherPlayerDrawResult
end
function class:OnGetOtherPlayerDrawResult(code, data)
  if code == 0 and data ~= nil then
    self.otherPlayerDrawResult = data
    self:FireEvent(EVT.GET_OTHER_DRAW_RESULT)
  end
end
function class:OnGetDrawResult(code, data)
  if code == 0 and data ~= nil then
    self.drawResultId = data.id
    if 0 < data.nextLevel then
      self.lastDrawLevel = self.nextDrawLevel
      self.nextDrawLevel = data.nextLevel
      self.hasDraw = true
    else
      self.nextDrawLevel = -1
      self.hasDraw = false
    end
    if data.rewardResults ~= nil then
      Logic:Get("Reward"):AddRewards(data.rewardResults)
      Logic:Get("Facebook"):ShareFriend("Draw", data.rewardResults)
    end
    self:FireEvent(EVT.DRAW_RESULT)
  else
    self:FireEvent(EVT.DRAW_FAILED, code)
  end
end
