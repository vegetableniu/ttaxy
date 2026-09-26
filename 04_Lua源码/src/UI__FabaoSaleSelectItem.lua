module((...), package.seeall)
require("SceneHelper")
local FABAO_ICON_PATH = "images/public/clarity05.png"
prototype = Tw.Controller.prototype:extend()
function prototype:initialize()
  super.initialize(self)
end
function prototype:onEnter()
  super.onEnter(self)
end
function prototype:onBtnImage()
  if self.fabao then
    local rec = KFDBGetRecord("TalismanSetting", self.fabao.baseId)
    if rec ~= nil and rec.baseId ~= nil then
      Logic:Get("HeroCardInfo"):OpenTailsman(self.fabao)
    end
  end
end
function prototype:onBtnSelect()
  local frame = CCSprite:create("images/public/selcet1.png")
  if not self.fabao then
    return
  end
  if self.bSelect then
    frame = CCSprite:create("images/public/selcet1.png")
    Logic:Get("Talisman"):RemoveSaleFabao(self.fabao.id)
    Logic:Get("Talisman"):DeleteSaleFabaoid(self.fabao.id)
    self.bSelect = false
  else
    frame = CCSprite:create("images/public/selcet2.png")
    Logic:Get("Talisman"):AddSaleFabao(self.fabao.id)
    Logic:Get("Talisman"):SetSaleFabaoids(self.fabao.id)
    self.bSelect = true
  end
  if frame then
    self.imgSelect:setDisplayFrame(frame:displayFrame())
  end
end
function prototype:onFabaoImage()
  Logic:Get("HeroCardInfo"):OpenTailsman(self.hero)
end
function prototype:clear()
  self.btnSelect:setEnabled(true)
  self.staName:setString("")
  self.staLife:setString("")
  self.staAttack:setString("")
  self.staPrice:setString("")
  local frame = CCSprite:create("images/public/selcet1.png")
  self.imgSelect:setDisplayFrame(frame:displayFrame())
end
function prototype:ReFrashInfo(data)
  self:clear()
  self:onWriteBand()
  if data == nil or table.empty(data) then
    return
  end
  local rec = KFDBGetRecord("TalismanSetting", data.baseId)
  if rec == nil or rec.baseId == nil then
    return
  end
  if data.level == nil or data.baseId == nil then
    return
  end
  self.fabao = data
  self:onReFrashIcon()
  local sprClarity = CCSprite:create(FABAO_ICON_PATH)
  if sprClarity then
    self.imgFabao:setDisplayFrame(sprClarity:displayFrame())
    self.imgkuang:setDisplayFrame(sprClarity:displayFrame())
  end
  local heroCard = Logic:Get("Hero"):GetHeroInfoByBaseId(rec.baseId)
  local pathIcon = Logic:Get("Hero"):GetHeroImage(rec.baseId)
  local spriteIcon = CCSprite:create(pathIcon)
  if spriteIcon then
    self.imgFabao:setDisplayFrame(spriteIcon:displayFrame())
  end
  local strBg = Logic:Get("Hero"):GetHeroBgImage(rec.baseId)
  local spriteBg = CCSprite:create(strBg)
  if spriteBg then
    self.imgkuang:setDisplayFrame(spriteBg:displayFrame())
  end
  self.staLevel:create(0, "YELLOW_E_NUM")
  self.staLevel:setAlign("LEFT", "CENTER")
  self.staLevel:setValue(data.level or 1)
  self.staName:setString(heroCard.name)
  local baseid = self.fabao.baseId .. "_" .. self.fabao.level
  local price = Logic:Get("Talisman"):GetTalismanPrice(baseid)
  self.staPrice:setString(price)
  if rec.race == "EXP_1" then
    self.imgSword:setVisible(false)
    self.imgHeart:setVisible(false)
    self.staAttack:setString("")
    self.staLife:setString("")
    return
  end
  local nowattack = Logic:Get("Talisman"):GetTaIlsmanAttack(baseid)
  local nowlife = Logic:Get("Talisman"):GetTaIlsmanLife(baseid)
  self.imgSword:setVisible(true)
  self.imgHeart:setVisible(true)
  self.staAttack:setString(nowattack)
  self.staLife:setString(nowlife)
end
function prototype:onWriteBand()
  local str = {
    "staAttack",
    "staLife",
    "staPrice"
  }
  for i = 1, #str do
    if self[str[i]] then
      self[str[i]]:setStyle(kCCLabelTTFStyleOutline)
    end
  end
end
function prototype:onReFrashIcon()
  local frame = CCSprite:create("images/public/selcet1.png")
  local isin = Logic:Get("Talisman"):IsInSaleFabaoids(self.fabao.id)
  if isin == true then
    frame = CCSprite:create("images/public/selcet2.png")
    self.bSelect = true
  else
    frame = CCSprite:create("images/public/selcet1.png")
    self.bSelect = false
  end
  if frame then
    self.imgSelect:setDisplayFrame(frame:displayFrame())
  end
end
