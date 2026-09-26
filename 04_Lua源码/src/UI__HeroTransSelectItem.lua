module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
BTN_SELECT = {
  NORMAL = "images/public/btnLeaderFrameSelect.png",
  SELECT = "images/public/btnLeaderFrameSelect.png",
  DISABLE = "images/public/btnHeroFrameDisable.png"
}
BTN_NORMAL = {
  NORMAL = "images/public/btnHeroFrameNormal.png",
  SELECT = "images/public/btnHeroFrameSelect.png",
  DISABLE = "images/public/btnHeroFrameDisable.png"
}
function prototype:initialize()
  super.initialize(self)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfHp:setStyle(kCCLabelTTFStyleOutline)
  self.ttfAttack:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLimit:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:RefreshInfo(data)
  if table.empty(data or {}) then
    return
  end
  self:Clear()
  self.data = data
  local rec = Logic:Get("Hero"):GetHeroInfoByBaseId(data.baseId)
  if rec then
    self.ttfName:setString(rec.name)
  end
  local _, path = Logic:Get("Hero"):GetHeroBgImage(data.baseId)
  local frame = CCSprite:create(path)
  if frame then
    self.sprClick:setDisplayFrame(frame:displayFrame())
  end
  local hp, attack = Logic:Get("Hero"):GetHeroLifeAndAttack(data.baseId, data.level)
  self.ttfHp:setString(hp)
  self.ttfAttack:setString(attack)
  if data.level and data.level > 0 then
    self.nodLevel:create(0, "YELLOW_E_NUM")
    self.nodLevel:setAlign("CENTER", "CENTER")
    self.nodLevel:setValue(data.level)
  end
  self:createImg()
  local map = {
    [1] = {
      str = TwGetStr(105760),
      color = ccc3(unpack({
        0,
        255,
        0
      }))
    },
    [2] = {
      str = TwGetStr(105760),
      color = ccc3(unpack({
        0,
        255,
        0
      }))
    },
    [3] = {
      str = TwGetStr(105751),
      color = ccc3(unpack({
        255,
        0,
        0
      }))
    },
    [4] = {
      str = TwGetStr(105752),
      color = ccc3(unpack({
        255,
        0,
        0
      }))
    }
  }
  self.ttfLimit:setColor(map[data.sort].color)
  self.ttfLimit:setString(map[data.sort].str)
  if 2 < data.sort then
    self.btnBg:setEnabled(false)
  end
  local selectCard = Logic:Get("Compose"):GetSelectCard()
  if not table.empty(selectCard or {}) and data.id == selectCard.id then
    self.btnBg:setEnabled(true)
    local sprNormal, sprSelect, sprDisable
    sprNormal = CCScale9Sprite:create(BTN_SELECT.NORMAL)
    sprSelect = CCScale9Sprite:create(BTN_SELECT.SELECT)
    sprDisable = CCScale9Sprite:create(BTN_SELECT.DISABLE)
    if sprNormal and sprSelect and sprDisable then
      self.btnBg:setBackgroundSpriteForState(sprNormal, CCControlStateNormal)
      self.btnBg:setBackgroundSpriteForState(sprSelect, CCControlStateHighlighted)
      self.btnBg:setBackgroundSpriteForState(sprDisable, CCControlStateDisabled)
    end
  end
end
function prototype:Clear()
  self.ttfLimit:setString("")
  self.btnBg:setEnabled(true)
  local sprNormal, sprSelect, sprDisable
  sprNormal = CCScale9Sprite:create(BTN_NORMAL.NORMAL)
  sprSelect = CCScale9Sprite:create(BTN_NORMAL.SELECT)
  sprDisable = CCScale9Sprite:create(BTN_NORMAL.DISABLE)
  if sprNormal and sprSelect and sprDisable then
    self.btnBg:setBackgroundSpriteForState(sprNormal, CCControlStateNormal)
    self.btnBg:setBackgroundSpriteForState(sprSelect, CCControlStateHighlighted)
    self.btnBg:setBackgroundSpriteForState(sprDisable, CCControlStateDisabled)
  end
end
function prototype:createImg()
  local iconPath = Logic:Get("Hero"):GetHeroImage(self.data.baseId)
  local spriteIcon = CCSprite:create(iconPath)
  if spriteIcon then
    self.sprHero:setDisplayFrame(spriteIcon:displayFrame())
  end
  local strBg, strStar = Logic:Get("Hero"):GetHeroBgImage(self.data.baseId)
  local spriteBg = CCSprite:create(strBg)
  if spriteBg then
    self.sprBg:setDisplayFrame(spriteBg:displayFrame())
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.sprBg, self.data.baseId)
end
function prototype:onBtnBg(sender, event)
  Logic:Get("Compose"):SetSelectCard(self.data)
  Logic:Get("Compose"):FireEvent(Logic.Compose.EVT.SELECT_CARD)
end
function prototype:onBtnHero(sender, event)
  Logic:Get("HeroCardInfo"):OpenHeroInfo(self.data)
end
