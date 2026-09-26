module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  self.nodId:setFontSize(35)
  self.nodId:setClear(true)
  self.nodTimes:setFontSize(35)
  self.nodTimes:setClear(true)
  MsgReward:On("TEST_REWARD_REPEAT", self:Event("OnTestRewardRepeat"))
end
function prototype:onExit()
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnBackCliecked(sender, event)
end
function prototype:onDrawClicked(sender, event)
  local reward = self.nodId:getString()
  if reward == nil or "" == reward then
    return
  end
  local num = self.nodTimes:getString()
  num = tonumber(num)
  if num == nil or num <= 0 then
    return
  end
  MsgReward:Post("TEST_REWARD_REPEAT", {reward = reward, num = num})
end
function prototype:SaveReport(reports)
  local path = CVariableSystem:GetSingleton():GetSysVariable(GV_DOCPATH)
  local file = io.open(path .. "LotteryJson.txt", "a+")
  file:write(reports)
  file:close()
end
function prototype:OnTestRewardRepeat(code, data)
  if data.status ~= 0 then
    Prompt:Fail(103060)
    return
  end
  local str = ""
  local outputStr = ""
  local num = 0
  local total = {}
  for k, v in pairs(data) do
    if k ~= "status" then
      num = 0
      str = str .. k .. ":"
      outputStr = outputStr .. k .. ":"
      total[k] = 0
      for k2, v2 in pairs(v) do
        str = str .. k2 .. ":" .. v2 .. ","
        outputStr = outputStr .. k2 .. ":" .. v2 .. ","
        num = num + 1
        total[k] = total[k] + v2
        if num / 3 == 1 then
          str = str .. "\n"
          num = 0
        end
      end
      str = str .. "\n"
      outputStr = outputStr .. "\n"
    end
  end
  local timeTab = Logic:Get("System"):GetTimeDate(os.time())
  local timeStr = string.format("%04d-%02d-%02d %02d:%02d:%02d", timeTab.year, timeTab.month, timeTab.day, timeTab.hour, timeTab.min, timeTab.sec)
  outputStr = outputStr .. timeStr .. "\n"
  outputStr = outputStr .. "============================" .. "\n"
  self:SaveReport(outputStr)
  self.ttfResultText:setString(str)
end
