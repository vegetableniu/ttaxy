require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:onMenuClose()
  self:onBtnCancel()
end
function prototype:onBtnCancel()
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnDive(sender, event)
  self.step = 0
  local maxItem = 6
  for i = 1, maxItem do
    local btn = "btnDive" .. i
    if self[btn] == sender then
      self.step = i
      break
    end
  end
  local info = Logic:Get("Monopoly"):GetMonoInfo()
  if 0 < info.specialDice then
    Logic:Get("Monopoly"):PostAdvanceDice(self.step)
    self:onBtnCancel()
    return
  end
  local costRec = KFDBGetRecord("ConfigValue", "MONOPOLY:ADVANCE_STEP_COST_CURRENCY") or {}
  local costs = json.decode(costRec.content or "[]") or {}
  local idx = info.currSpecialDiceTimes + 1
  if idx > #costs then
    idx = #costs or idx
  end
  self.currCost = costs[idx] or 0
  Prompt:Confirm(self, "", TwGetStr(115072, self.currCost), self.promptDice, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:promptDice()
  if not Logic:Get("PlayerInfo"):IsMoneyEnough(self.currCost) then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Logic:Get("Monopoly"):PostCostAdvanceDice(self.step)
  self:onBtnCancel()
end
