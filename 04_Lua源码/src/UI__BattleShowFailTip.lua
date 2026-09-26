module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.type = Logic:Get("Battle"):GetEmBattleType()
  if self.type == Logic.Battle.BATTLE_TYPE.ACTIVE then
    self:SetBtnText(104210)
  elseif self.type == Logic.Battle.BATTLE_TYPE.ARENA then
  elseif self.type == Logic.Battle.BATTLE_TYPE.CAMPAIGN then
    local battleId = Logic:Get("Battle"):GetBattleId()
    local battleType = Logic:Get("Battle"):GetBattleType(battleId)
    if battleType == Logic.Battle.CAMPAIGN_TYPE.NORMAL then
      self:SetBtnText(104210)
    elseif battleType == Logic.Battle.CAMPAIGN_TYPE.HARD then
      self:SetBtnText(104211)
    else
      self:SetBtnText(104210)
    end
  else
    self:SetBtnText(104210)
  end
end
function prototype:SetBtnText(textId)
  self.btnTip:setTitleForState(TwGetStr(textId), CCControlStateNormal)
  self.btnTip:setTitleForState(TwGetStr(textId), CCControlStateHighlighted)
  self.btnTip:setTitleForState(TwGetStr(textId), CCControlStateDisabled)
end
function prototype:onBtnTip(...)
  if self.type == Logic.Battle.BATTLE_TYPE.ACTIVE then
    SceneHelper:runWithScene("HeroUpgrade", self.rootNode)
  elseif self.type == Logic.Battle.BATTLE_TYPE.ARENA then
  elseif self.type == Logic.Battle.BATTLE_TYPE.CAMPAIGN then
    local battleId = Logic:Get("Battle"):GetBattleId()
    local battleType = Logic:Get("Battle"):GetBattleType(battleId)
    if battleType == Logic.Battle.CAMPAIGN_TYPE.NORMAL then
      SceneHelper:runWithScene("HeroUpgrade", self.rootNode)
    elseif battleType == Logic.Battle.CAMPAIGN_TYPE.HARD then
      SceneHelper:runWithScene("HeroUpSkill", self.rootNode)
    else
      SceneHelper:runWithScene("HeroUpgrade", self.rootNode)
    end
  else
    SceneHelper:runWithScene("HeroUpgrade", self.rootNode)
  end
end
