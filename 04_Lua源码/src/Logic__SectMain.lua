require("Timer")
module((...), package.seeall)
class = Logic.class:subclass()
EVT = Enum({"TIMER"})
local BTN_DEFAULT = {
  "btnMember",
  "btnDonate",
  "btnManage",
  "btnFight",
  "btnMall"
}
local BTN_VISI = {}
local BTN_INFO = {
  btnGOD = {
    fun = "onBtnMammon",
    normal = "images/Corps/ico_bcs.png",
    select = "images/Corps/ico_bcson.png",
    disable = "images/Corps/ico_bcs.png",
    ani = "UI/uinew"
  },
  btnSPRING = {
    fun = "onBtnSpring",
    normal = "images/Corps/ico_xq.png",
    select = "images/Corps/ico_xq.png",
    disable = "images/Corps/ico_xq.png",
    ani = "UI/uinew"
  },
  btnDEMOG = {
    fun = "onBtnGhost",
    normal = "images/Corps/ico_gmg.png",
    select = "images/Corps/ico_gmgon.png",
    disable = "images/Corps/ico_gmg.png",
    ani = "UI/uinew"
  },
  btnMESSAGE = {
    fun = "onBtnWord",
    normal = "images/Corps/ico_lyb.png",
    select = "images/Corps/ico_lybon.png",
    disable = "images/Corps/ico_lyb.png"
  },
  btnManage = {
    fun = "onBtnManage",
    normal = "images/Corps/ico_sz.png",
    select = "images/Corps/ico_szon.png",
    disable = "images/Corps/ico_sz.png",
    ani = "UI/uinew"
  },
  btnMember = {
    fun = "onBtnMember",
    normal = "images/Corps/ico_mz.png",
    select = "images/Corps/ico_mzon.png",
    disable = "images/Corps/ico_mz.png"
  },
  btnDonate = {
    fun = "onBtnDonate",
    normal = "images/Corps/ico_jx.png",
    select = "images/Corps/ico_jxon.png",
    disable = "images/Corps/ico_jx.png"
  },
  btnFight = {
    fun = "onBtnFight",
    normal = "images/Corps/icon_bpz.png",
    select = "images/Corps/icon_bpzon.png",
    disable = "images/Corps/icon_bpz.png",
    ani = "UI/uinew"
  },
  btnMall = {
    fun = "onBtnMall",
    normal = "images/Corps/icon_sc.png",
    select = "images/Corps/icon_scon.png",
    disable = "images/Corps/icon_sc.png"
  }
}
local REWARD_TYPE = TypeDef("com.eyu.mt.module.reward.model.RewardType")
function class:initialize()
  super.initialize(self)
  self.isTimerRun = false
  Logic:Get("Sect"):On(Logic.Sect.EVT.SPRING_DRINK_FINISHED, self:Event("OnPhysicalUp"))
end
function class:dispose()
  super.dispose(self)
end
function class:OnReset()
end
function class:getBtnItem()
  self:getCurLvFunction()
  return BTN_VISI
end
function class:getBtnInfo(btn)
  return BTN_INFO[btn]
end
function class:checkBtn(name, btn)
  if not btn or not name then
    return
  end
  if name == "btnSpring" then
    btn:setBeginTimer(true)
    return
  end
  if name == "btnDEMOG" then
    local bNewGhost = Logic:Get("Sect"):isNewDemog()
    if bNewGhost then
      btn:playAni()
    else
      btn:closeAni()
    end
    return
  end
  if name == "btnManage" then
    local sectInfo = Logic:Get("Sect"):getSectInfo()
    if not sectInfo or not sectInfo.aplypNum then
      return
    end
    local job = Logic:Get("Sect"):getSectInfo().job
    if Logic:Get("Sect"):IsNewApplyState() and Logic:Get("Sect"):checkAuth(job, "LIST_APPLY") then
      btn:playAni()
    else
      btn:closeAni()
    end
  end
  if name == "btnGOD" then
    if Logic:Get("Sect"):IsPrayNew() then
      btn:playAni()
    else
      btn:closeAni()
    end
  end
  if name == "btnFight" then
    if Logic:Get("Sect"):isJoinCountryFightTime() then
      btn:playAni()
    else
      btn:closeAni()
    end
  end
end
function class:onBtnMammon(sender, event)
  SceneHelper:runWithScene("SectMammon", self.rootNode)
end
function class:onBtnSpring(sender, event)
  if Logic:Get("Sect"):GetRefreshTime() == 0 then
    Logic:Get("Sect"):PostSpringDrink()
  else
    Prompt:Confirm(self, 110034, 110036, nil, Prompt.PROMPT_TYPE.CONFIRM)
  end
end
function class:onBtnGhost(sender, event)
  SceneHelper:runWithScene("SectDemogMain", self.rootNode)
end
function class:onBtnWord(sender, event)
  SceneHelper:runWithScene("SectWord", self.rootNode)
end
function class:onBtnManage(sender, event)
  SceneHelper:runWithScene("SectManage", self.rootNode)
end
function class:onBtnMember(sender, event)
  Logic:Get("Sect"):setIsFromMain(true)
  SceneHelper:runWithScene("SectMember", self.rootNode)
end
function class:onBtnDonate(sender, event)
  SceneHelper:pushPrompt("SectDonate", self.rootNode)
end
function class:onBtnFight(sender, event)
  SceneHelper:pushScene("SectFightMain", self.rootNode)
end
function class:onBtnMall(sender, event)
  SceneHelper:runWithScene("SectMall", self.rootNode)
end
function class:timer()
  self:FireEvent(EVT.TIMER)
  if not self.eventTracer:Exist("timer") then
    Singleton(Timer):Repeat(1000, self:Event("timer"))
  end
end
function class:OnPhysicalUp(rewards)
  if rewards.rewardResults[1].type == REWARD_TYPE.ACTION_POINT then
    local phyPoint = rewards.rewardResults[1].amount
    local str = TwGetStr(110035, phyPoint, "11:59:59")
    Prompt:Confirm(self, 110034, str, nil, Prompt.PROMPT_TYPE.CONFIRM)
  end
end
function class:getCurLvFunction()
  local sectInfo = Logic:Get("Sect"):getSectInfo()
  if sectInfo == nil then
    return
  end
  local rec = KFDBGetRecord("MenpaiLevelConfig", sectInfo.level)
  local funTable = json.decode(rec.openFunctions == "" and "[]" or rec.openFunctions)
  BTN_VISI[1] = {}
  for i = 1, #funTable do
    if funTable[i] ~= "POST" then
      BTN_VISI[1][#BTN_VISI[1] + 1] = "btn" .. funTable[i]
    end
  end
  for i = 1, 5 do
    BTN_VISI[1][#BTN_VISI[1] + 1] = BTN_DEFAULT[i]
  end
end
