module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:RefreshInfo(bNext, level)
  if bNext then
    local swallow = Logic:Get("Hero"):GetSwallowHero()
    if not swallow then
      return
    end
    local swallowHero = {}
    for k, v in pairs(swallow) do
      if v then
        local hero = Logic:Get("Hero"):GetHeroInfoById(k)
        if hero then
          table.insert(swallowHero, hero)
        end
      end
    end
    self.staNextLife:setVisible(true)
    self.staNextAttack:setVisible(true)
    self.staNextLevel:setVisible(true)
    self.imgTip1:setVisible(true)
    self.imgTip2:setVisible(true)
    self.imgTip3:setVisible(true)
    local upgradeHeroId = Logic:Get("Hero"):GetUpgradeHero()
    if not upgradeHeroId then
      return
    end
    local upgradeInfo = Logic:Get("Hero"):GetHeroInfoById(upgradeHeroId)
    if not upgradeInfo then
      return
    end
    local curLife, curAttack = Logic:Get("Hero"):GetHeroLifeAndAttack(upgradeInfo.baseId, upgradeInfo.level)
    if curLife and curAttack then
      self.staCurLife:setString(curLife)
      self.staCurAttack:setString(curAttack)
    end
    self.staLevel:setString(upgradeInfo.level or 0)
    local nextLife, nextAttack = Logic:Get("Hero"):GetHeroLifeAndAttack(upgradeInfo.baseId, level)
    self.staNextLife:setString(string.format("%d", nextLife))
    self.staNextAttack:setString(string.format("%d", nextAttack))
  else
    local upgradeHeroId = Logic:Get("Hero"):GetUpgradeHero()
    if not upgradeHeroId then
      return
    end
    local upgradeInfo = Logic:Get("Hero"):GetHeroInfoById(upgradeHeroId)
    if not upgradeInfo then
      return
    end
    self.staNextLife:setVisible(false)
    self.staNextAttack:setVisible(false)
    self.staNextLevel:setVisible(false)
    self.imgTip1:setVisible(false)
    self.imgTip2:setVisible(false)
    self.imgTip3:setVisible(false)
    local life, attack = Logic:Get("Hero"):GetHeroLifeAndAttack(upgradeInfo.baseId, upgradeInfo.level)
    if life and attack then
      self.staCurLife:setString(life)
      self.staCurAttack:setString(attack)
    end
    self.staLevel:setString(upgradeInfo.level or 0)
  end
end
function prototype:SetNextLevel(level)
  self.staNextLevel:setString(level)
end
