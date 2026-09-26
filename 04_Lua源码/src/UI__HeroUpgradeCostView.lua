module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:RefreshCost()
  local swallow = Logic:Get("Hero"):GetSwallowHero()
  if not swallow then
    return
  end
  local cost, exp = 0, 0
  exp = Logic:Get("Hero"):AllSwallowHeroExp()
  local upgradeId = Logic:Get("Hero"):GetUpgradeHero()
  local upgradeHero = Logic:Get("Hero"):GetHeroInfoById(upgradeId)
  if upgradeHero and upgradeHero.baseId then
    local info = Logic:Get("Hero"):GetHeroInfoByBaseId(upgradeHero.baseId)
    if info and info.coinRate then
      cost = exp * info.coinRate
      Logic:Get("Hero"):SetUpgradeCost(cost)
    end
  end
  self.staCost:setString(TwGetStr(104275, cost))
  self.staExp:setString(TwGetStr(104276, exp))
  local upgradeHeroId = Logic:Get("Hero"):GetUpgradeHero()
  local upgradeHero = Logic:Get("Hero"):GetHeroInfoById(upgradeHeroId)
  local exp = Logic:Get("Hero"):GetHeroNextExp(upgradeHero.baseId, upgradeHero.level)
  exp = exp - upgradeHero.exp
  self.staNextExp:setString(TwGetStr(104277, exp or 0))
  local full = 0
  if not upgradeHero then
    self.staFullExp:setString(TwGetStr(104278, full))
    return
  end
  full = Logic:Get("Hero"):upgradeHeroFullExp(upgradeHero)
  self.staFullExp:setString(TwGetStr(104278, full))
end
function prototype:CostPreView(...)
  self.staCost:setString(TwGetStr(104275, 0))
  self.staExp:setString(TwGetStr(104276, 0))
  local upgradeId = Logic:Get("Hero"):GetUpgradeHero()
  local upgradeHero = Logic:Get("Hero"):GetHeroInfoById(upgradeId)
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(upgradeHero.baseId)
  if info and info.level == upgradeHero.level then
    self.staNextExp:setString(TwGetStr(104277, 0))
  else
    local exp = Logic:Get("Hero"):GetHeroNextExp(upgradeHero.baseId, upgradeHero.level)
    exp = exp - upgradeHero.exp
    self.staNextExp:setString(TwGetStr(104277, exp or 0))
  end
  local full = 0
  if not upgradeHero then
    self.staFullExp:setString(TwGetStr(104278, full))
    return
  end
  full = Logic:Get("Hero"):upgradeHeroFullExp(upgradeHero)
  self.staFullExp:setString(TwGetStr(104278, full))
end
