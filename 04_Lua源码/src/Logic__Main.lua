module((...), package.seeall)
require("Logic")
require("SceneHelper")
EVT = Enum({
  "REFRESH_FUCNTION",
  "GOTO_HOME_PAGE",
  "GOTO_RECHARGE",
  "SHOW_NEW_TIP",
  "GOTO_BIND_ACCOUNT"
})
class = Logic.class:subclass()
function class:initialize()
  super.initialize(self)
  self.showFunc = true
end
function class:SetFuncVisible(bool)
  self.showFunc = bool
  self:FireEvent(EVT.REFRESH_FUCNTION, bool)
end
function class:GotoHomePage()
  self:FireEvent(EVT.GOTO_HOME_PAGE)
end
function class:GotoRecharge()
  self:FireEvent(EVT.GOTO_RECHARGE)
end
function class:GotoBindAccount()
  self:FireEvent(EVT.GOTO_BIND_ACCOUNT)
end
function class:CuMengMain(stringEvtId)
  local playerInfo = Logic:Get("PlayerInfo"):GetPlayerAllInfo()
  if playerInfo.level > 10 then
    return
  end
  local Level = "Player_Level:" .. playerInfo.level
  local UniqueId = Logic:Get("System"):GetUniqueId()
  local jsonStr = {Level = Level, UniqueId = UniqueId}
  local strEvtLable = json.encode(jsonStr)
  CUMengAgent:OnEvent(stringEvtId, strEvtLable)
end
function class:CuMengMainGuide(guide, step)
  if Logic:Get("Guide"):isActive(guide, step) then
    local str = guide .. step
    self:CuMengMain(str)
  end
end
function class:PromptCharge()
  Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
  Prompt:Confirm(self, "", 105316, self.GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
end
