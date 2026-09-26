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
  if not self.fabao then
    return
  end
  local rec = KFDBGetRecord("TalismanSetting", self.fabao.baseId)
  if rec ~= nil and rec.baseId ~= nil then
    Logic:Get("HeroCardInfo"):OpenTailsman(self.fabao)
  end
end
function prototype:onBtnSelect()
  if self.fabao == nil or not Logic:Get("Talisman"):getOpenStyle() then
    return
  end
  if Logic:Get("Talisman"):IsInMaxLevel(self.fabao) then
    Prompt:Fail(112039)
    return
  end
  Logic:Get("Talisman"):ClearSwallFabaos()
  Logic:Get("Talisman"):SetUpgradeFabao(self.fabao)
  Logic:Get("Talisman"):jumpToUpgrade()
  SceneHelper:popScene()
end
function prototype:createImg(giftInfo)
  local spr = Logic:Get("Gift"):createImg(giftInfo)
  if spr ~= nil then
    self.iconBg:setDisplayFrame(spr:displayFrame())
    local strGoods = Logic:Get("Gift"):createGoodsImg(giftInfo)
    if strGoods ~= nil then
      local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(strGoods)
      self.iconImage:setTexture(texture)
      self.iconImage:setTextureRect(textureRect)
    end
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.iconBg, self.data.showId)
end
function prototype:clear()
  self.btnSelect:setEnabled(true)
  local frame = CCSprite:create("images/public/selcet1.png")
  self.imgCanSelect:setDisplayFrame(frame:displayFrame())
end
function prototype:ReFrashInfo(data)
  self:clear()
  if data == nil or table.empty(data) then
    return
  end
  local rec = KFDBGetRecord("TalismanSetting", data.baseId)
  if rec == nil then
    return
  end
  self.fabao = data
  local sprClarity = CCSprite:create(FABAO_ICON_PATH)
  if sprClarity then
    self.imgFabao:setDisplayFrame(sprClarity:displayFrame())
    self.imgkuang1:setDisplayFrame(sprClarity:displayFrame())
  end
  local heroCard = Logic:Get("Hero"):GetHeroInfoByBaseId(rec.baseId)
  local pathIcon = Logic:Get("Hero"):GetHeroImage(rec.baseId)
  if pathIcon then
    local spriteIcon = CCSprite:create(pathIcon)
    if spriteIcon then
      self.imgFabao:setDisplayFrame(spriteIcon:displayFrame())
    end
  end
  if data.equipHero and Logic:Get("Talisman"):getOpenStyle() then
    self.staTip:setVisible(true)
    self.staTip:setStyle(kCCLabelTTFStyleOutline)
    local heroInfo = Logic:Get("Hero"):GetHeroInfoById(data.equipHero)
    local hInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(heroInfo.baseId)
    local color = Logic:Get("Hero"):getColorByBaseId(heroInfo.baseId)
    if color then
      self.staTip:setColor(color)
    end
    self.staTip:setString(hInfo.name)
  else
    self.staTip:setVisible(false)
  end
  local strBg = Logic:Get("Hero"):GetHeroBgImage(rec.baseId)
  if strBg then
    local spriteBg = CCSprite:create(strBg)
    if spriteBg then
      self.imgkuang1:setDisplayFrame(spriteBg:displayFrame())
    end
  end
  local id = tostring(data.baseId .. "_" .. data.level)
  local life = Logic:Get("Talisman"):GetTaIlsmanLife(id)
  if life and rec.race ~= "EXP_1" then
    self.imgLife:setVisible(true)
    self.staHeart:setVisible(true)
    self.staHeart:setString(life)
    self.staHeart:setStyle(kCCLabelTTFStyleOutline)
  else
    self.imgLife:setVisible(false)
    self.staHeart:setVisible(false)
  end
  local attack = Logic:Get("Talisman"):GetTaIlsmanAttack(id)
  if attack and rec.race ~= "EXP_1" then
    self.imgAttack:setVisible(true)
    self.staAttack:setVisible(true)
    self.staAttack:setString(attack)
    self.staAttack:setStyle(kCCLabelTTFStyleOutline)
  else
    self.imgAttack:setVisible(false)
    self.staAttack:setVisible(false)
  end
  self.staName:setString(heroCard.name)
  self.staLevel:create(0, "YELLOW_E_NUM")
  self.staLevel:setAlign("LEFT", "CENTER")
  self.staLevel:setValue(data.level or 1)
  self.state = Logic:Get("Talisman"):getOpenStyle()
  if not self.state then
    self.imgCanSelect:setVisible(false)
  else
    self.imgCanSelect:setVisible(true)
    local frame = CCSprite:create("images/public/selcet1.png")
    if frame then
      self.imgCanSelect:setDisplayFrame(frame:displayFrame())
    end
    local upgradefabao = Logic:Get("Talisman"):GetUpgradeFabao()
    if upgradefabao and self.fabao and upgradefabao.id == self.fabao.id then
      frame = CCSprite:create("images/public/selcet2.png")
      if frame then
        self.imgCanSelect:setDisplayFrame(frame:displayFrame())
      end
    end
  end
end
