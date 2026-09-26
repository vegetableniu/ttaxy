module((...), package.seeall)
require("SceneHelper")
local HERO_ICON_PATH = "images/public/clarity05.png"
local GREEN_ICON_PAHT = "images/Talisman/UIjnsjtx1.png"
prototype = Tw.Controller.prototype:extend()
function prototype:initialize()
  super.initialize(self)
end
function prototype:onEnter()
  super.onEnter(self)
end
function prototype:clear()
  local sprIcon = CCSprite:create(HERO_ICON_PATH)
  for i = 1, 5 do
    local str = string.format("imgHero%d", i)
    if self[str] then
      self[str]:setDisplayFrame(sprIcon:displayFrame())
      Logic:Get("HeroCardInfo"):ClearShanCardSmall(self[str])
    end
    str = string.format("imgkuang%d", i)
    if self[str] then
      self[str]:setDisplayFrame(sprIcon:displayFrame())
    end
    str = string.format("imgbg%d", i)
    if self[str] then
      self[str]:setVisible(true)
    end
    str = string.format("btnHero%d", i)
    if self[str] then
      self[str]:setEnabled(false)
    end
    if self.ani then
      self.ani:RemoveAnimation()
    end
    str = string.format("imgLv%d", i)
    if self[str] then
      self[str]:setVisible(false)
    end
    str = string.format("staLevel%d", i)
    if self[str] then
      self[str]:setVisible(false)
    end
  end
end
function prototype:ReFrashInfo(data)
  self:clear()
  if data == nil or table.empty(data) then
    return
  end
  self.heros = data
  for i, v in ipairs(data) do
    local str = string.format("imgHero%d", i)
    if self[str] then
      local iconPath = Logic:Get("Hero"):GetHeroImage(v.baseId)
      local spriteIcon = CCSprite:create(iconPath)
      if spriteIcon then
        self[str]:setDisplayFrame(spriteIcon:displayFrame())
      end
      Logic:Get("HeroCardInfo"):AddShanCardSmall(self[str], v.baseId)
    end
    str = string.format("imgkuang%d", i)
    if self[str] then
      local strBg = Logic:Get("Hero"):GetHeroBgImage(v.baseId)
      local spriteBg = CCSprite:create(strBg)
      if spriteBg then
        self[str]:setDisplayFrame(spriteBg:displayFrame())
      end
    end
    str = string.format("imgbg%d", i)
    if self[str] then
      self[str]:setVisible(false)
    end
    str = string.format("btnHero%d", i)
    if self[str] then
      self[str]:setEnabled(true)
    end
    local selecthero = Logic:Get("Talisman"):GetSelectHero()
    str = string.format("imggreen%d", i)
    if selecthero and v == selecthero then
      self.ani = Logic:Get("AniMgr"):NewCCB("UI/uijnsjtxfb", self[str], ccp(0, 8), 0, nil, 0.7)
      if self.ani then
        self.ani:RunAni()
      end
      self[str]:setVisible(true)
      Logic:Get("Talisman"):ChangeImgFabao(i)
    end
    str = string.format("imgLv%d", i)
    if self[str] then
      self[str]:setVisible(true)
    end
    local hero = v
    if hero.level then
      str = string.format("staLevel%d", i)
      if self[str] then
        self[str]:create(0, "YELLOW_E_NUM")
        self[str]:setAlign("LEFT", "CENTER")
        self[str]:setValue(hero.level or 1)
        self[str]:setVisible(true)
      end
    end
  end
end
function prototype:onChangeImgFabao(code)
  if code == nil then
    return
  end
  local strgreen = string.format("imggreen%d", code)
  if self[strgreen] then
    self[strgreen]:setVisible(true)
  end
end
function prototype:onBtnSelect(sender, event)
  local choose = 0
  for i = 1, 5 do
    local str = string.format("btnHero%d", i)
    local strgreen = string.format("imggreen%d", i)
    if sender == self[str] then
      if self.heros[i] then
        Logic:Get("Talisman"):SetSelectHero(self.heros[i])
        choose = 1
        Logic:Get("Talisman"):ChangeImgFabao(i)
        if self.ani then
          self.ani:RemoveAnimation()
        end
        self.ani = Logic:Get("AniMgr"):NewCCB("UI/uijnsjtxfb", self[strgreen], ccp(0, 8), 0, nil, 0.7)
        if self.ani then
          self.ani:RunAni()
        end
        self[strgreen]:setVisible(true)
      else
        self[strgreen]:setVisible(false)
      end
    end
  end
  if choose == 0 then
    Logic:Get("Talisman"):ClearSelectHero()
  end
end
