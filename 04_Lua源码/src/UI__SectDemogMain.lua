module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  local rec = KFDBGetRecord("LanguageSetting", 1012)
  if rec and rec.content then
    self.ttfDoubleGain:setStyle(kCCLabelTTFStyleOutline)
    self.ttfDoubleGain:setString(rec.content)
  end
  self.sprExplain:setVisible(false)
  self.btnExplain:setVisible(false)
  self:aniShow()
end
function prototype:onBtnReturnClicked(sender, event)
  SceneHelper:runWithScene("SectMain", self.rootNode)
end
function prototype:onBtnExplainClicked(sender, event)
  SceneHelper:pushScene("Strategy", self.rootNode)
end
function prototype:onBtnDemog(sender, event)
  SceneHelper:runWithScene("SectDemogList", self.rootNode)
end
function prototype:onBtnRein(sender, event)
  if event == CCControlEventTouchUpInside then
    SceneHelper:pushScene("DevilGroup", self.rootNode)
  end
end
function prototype:onBtnCompose(sender, event)
  SceneHelper:runWithScene("SectDemogCardMix", self.rootNode)
end
function prototype:onBtnCallDemog(sender, event)
  Logic:Get("Sect"):setFromDemogList(false)
  SceneHelper:runWithScene("SectCallDevil", self.rootNode)
end
function prototype:aniShow()
  self:showRewardTip()
  if Logic:Get("Sect"):isNewDemog() or Logic:Get("Sect"):isCallDemog() then
    Logic:Get("Sect"):setNewDemogFlag(false)
    Logic:Get("Sect"):setCallDemog(false)
  else
  end
end
function prototype:showRewardTip()
  if Logic:Get("Sect"):isCallDemog() then
    local getIndexByCode = function(tab, code)
      if not tab or table.empty(tab) then
        return nil
      end
      for i = 1, #tab do
        if tab[i].code == code then
          return i
        end
      end
      return nil
    end
    local demogInfo = Logic:Get("Sect"):GetSummonInfo()
    local newRewards = {}
    for i, v in ipairs(demogInfo.costAndReward.rewards) do
      local index = getIndexByCode(newRewards, demogInfo.costAndReward.rewards[i].code)
      if index then
        newRewards[index].amount = newRewards[index].amount + 1
      else
        newRewards[#newRewards + 1] = demogInfo.costAndReward.rewards[i]
      end
    end
    local str = ""
    for i, v in ipairs(newRewards) do
      str = str .. Logic:Get("Reward"):RewardTreaTip(v) .. "\n"
    end
    Prompt:Confirm(self, TwGetStr(110049), str, nil, Prompt.PROMPT_TYPE.CONFIRM)
  end
end
