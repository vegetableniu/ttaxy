module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local POSITION = {
  {y = 135},
  {y = 204},
  {y = 268}
}
function prototype:onEnter()
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.SELECT_HERO, self:Event("onSelectHero"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.SWALLOW_ELIXIR, self:Event("onSwallowElixir"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.ON_HERO_CROSSING, self:Event("onBattleEnd"))
  self.isOpen = false
  self:onSelectHero()
end
function prototype:onSelectHero()
  self:clear()
  self.selectHero = Logic:Get("Cultivate"):getSelectHero()
  if table.empty(self.selectHero or {}) then
    return
  end
  local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(self.selectHero.baseId)
  self.bundary = Logic:Get("Cultivate"):getCutivateStateById(self.selectHero.id)
  self.attribute = Logic:Get("Cultivate"):getAllAttribute(self.selectHero.id)
  self.index = #self.attribute or 0
  local index = 3
  if self.index <= 3 then
    index = 3
    self.sprAttrAdd:setPositionY(135)
    self:setBg("images/Cultivate/attr_3.png")
  elseif self.index == 4 or self.index == 5 then
    index = 5
    self.sprAttrAdd:setPositionY(204)
    self:setBg("images/Cultivate/attr_5.png")
  elseif self.index > 5 then
    index = 7
    self.sprAttrAdd:setPositionY(268)
    self:setBg("images/Cultivate/attr_7.png")
  end
  for k, v in pairs(self.attribute) do
    local ccb = string.format("ccb%d", index - k + 1)
    if self[ccb] then
      self[ccb]:refreshAttribute(v)
    end
  end
end
function prototype:onBattleEnd()
  self:onSelectHero()
end
function prototype:onSwallowElixir()
  self:onSelectHero()
end
function prototype:setBg(path)
  if path == nil then
    return
  end
  local sprite = CCSprite:create(path)
  if sprite then
    self.sprBg:setDisplayFrame(sprite:displayFrame())
  end
end
function prototype:clear()
  for i = 1, 7 do
    local ccb = string.format("ccb%d", i)
    if self[ccb] then
      self[ccb]:refreshAttribute(nil)
    end
  end
end
function prototype:onBtnClose()
  Logic:Get("Cultivate"):FireEvent(Logic.Cultivate.EVT.REMOVE_ITEM)
end
