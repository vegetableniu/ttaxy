module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:RefreshInfo(bNext, level)
  if bNext == true then
    local swallow = Logic:Get("Talisman"):GetSwallFabaos()
    if not swallow then
      return
    end
    local swallowFabao = {}
    for k, v in pairs(swallow) do
      local hero = Logic:Get("Hero"):GetHeroInfoById(k)
      if hero then
        table.insert(swallowFabao, hero)
      end
    end
    self.staNextLife:setVisible(true)
    self.staNextAttack:setVisible(true)
    self.staNextLevel:setVisible(true)
    self.imgTip1:setVisible(true)
    self.imgTip2:setVisible(true)
    self.imgTip3:setVisible(true)
    local updateFabao = Logic:Get("Talisman"):GetUpgradeFabao()
    if updateFabao then
      local baseid = updateFabao.baseId .. "_" .. updateFabao.level
      local nowattack = Logic:Get("Talisman"):GetTaIlsmanAttack(baseid)
      local nowlife = Logic:Get("Talisman"):GetTaIlsmanLife(baseid)
      self.staCurAttack:setString(nowattack)
      self.staCurLife:setString(nowlife)
      self.staLevel:setString(updateFabao.level or 0)
      baseid = updateFabao.baseId .. "_" .. level
      local nextattack = Logic:Get("Talisman"):GetTaIlsmanAttack(baseid)
      local nextlife = Logic:Get("Talisman"):GetTaIlsmanLife(baseid)
      self.staNextAttack:setString(nextattack)
      self.staNextLife:setString(nextlife)
      self.staNextLevel:setString(level)
    end
  else
    local updateFabao = Logic:Get("Talisman"):GetUpgradeFabao()
    if not updateFabao then
      return
    end
    self.staNextLife:setVisible(false)
    self.staNextAttack:setVisible(false)
    self.staNextLevel:setVisible(false)
    self.imgTip1:setVisible(false)
    self.imgTip2:setVisible(false)
    self.imgTip3:setVisible(false)
    local baseid = updateFabao.baseId .. "_" .. updateFabao.level
    local nowattack = Logic:Get("Talisman"):GetTaIlsmanAttack(baseid)
    local nowlife = Logic:Get("Talisman"):GetTaIlsmanLife(baseid)
    self.staCurAttack:setString(nowattack)
    self.staCurLife:setString(nowlife)
    self.staLevel:setString(updateFabao.level or 0)
  end
end
function prototype:SetNextLevel(level)
  self.staNextLevel:setString(level)
end
