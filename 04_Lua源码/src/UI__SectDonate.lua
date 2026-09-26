module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local MAX_NUM_LEN = 7
local RET = {YES = 1, NO = 2}
function prototype:onEnter()
  self.labDonate:setString(TwGetStr(110167))
  self.staExp:setStyle(kCCLabelTTFStyleOutline)
  local expTips = KFDBGetRecord("LanguageSetting", 1000)
  self.staExp:setString(expTips and expTips.content or "")
  self.gift = 0
  self.edtNum:setMaxLens(MAX_NUM_LEN)
  self.edtNum:setFontSize(28)
  self.edtNum:setTouchPriority(-255)
  Logic:Get("Sect"):On(Logic.Sect.EVT.CONTRIBUTE_FINISHED, self:Event("OnContributed"))
end
function prototype:onOKBtn(sender, event)
  local xyNum = self.edtNum:getString()
  if xyNum == "" then
    Prompt:Confirm(self, "", 110111, nil, Prompt.PROMPT_TYPE.CONFIRM)
    return
  end
  local ret = Logic:Get("Sect"):checkNumber(xyNum)
  if ret > 0 then
    self.gift = ret
    if Logic:Get("Sect"):GetNeedExp() == 0 then
      Prompt:Confirm(self, "", TwGetStr(110115), self.postDonate, Prompt.PROMPT_TYPE.SELECT)
      return
    end
    Logic:Get("Sect"):PostContributeMenpai(ret)
  else
    local str = TwGetStr(105316)
    if ret == -1 then
      str = TwGetStr(110067)
    elseif ret == 0 then
      str = TwGetStr(110110)
    elseif ret == -3 then
      local maxDonateVal = KFDBGetRecord("MenpaiLevelConfig", KFDBGetRecordAmt("MenpaiLevelConfig"))
      maxDonateVal = maxDonateVal and maxDonateVal.needExp or 0
      local donateExpRate = KFDBGetRecord("ConfigValue", "MENPAI:MENPAI_EXP_COUNT")
      donateExpRate = donateExpRate and tonumber(donateExpRate.content) or 1
      str = TwGetStr(110046, math.floor(maxDonateVal / donateExpRate))
    else
      Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
      Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
      SceneHelper:removePrompt(self.rootNode)
      return
    end
    Prompt:Confirm(self, "", str, nil, Prompt.PROMPT_TYPE.CONFIRM)
  end
end
function prototype:onCancelBtn(sender, event)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:OnContributed()
  local donateExpAdd = KFDBGetRecord("ConfigValue", "MENPAI:MENPAI_EXP_COUNT")
  donateExpAdd = donateExpAdd and tonumber(donateExpAdd.content) or 1
  self.contrb = Logic:Get("Sect"):GetContributeContent()
  self:sortReward()
  local exp = math.floor(self.gift * donateExpAdd)
  local gicon = self.contrb.costReward.rewards[2].amount or 0
  local sect = Logic:Get("Sect"):getSectInfo()
  local needExp = Logic:Get("Sect"):GetNeedExp()
  local feat = self.contrb.costReward.rewards[1].amount or 0
  local text = TwGetStr(110069, self.gift, exp, gicon, feat)
  Prompt:Confirm(self, "", text, nil, Prompt.PROMPT_TYPE.CONFIRM)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:postDonate()
  Logic:Get("Sect"):PostContributeMenpai(self.gift)
end
function prototype:sortReward()
  if not table.empty(self.contrb) then
    local rewardSort = function(param1, param2)
      if not param1 or not param2 then
        return false
      end
      return param1.type == 25
    end
    table.sort(self.contrb.costReward.rewards, rewardSort)
  end
end
