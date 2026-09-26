module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local CLARITY_PATH = "images/public/clarity05.png"
local DEFAULT_BG_PATH = "images/public/herobg.png"
function prototype:onEnter()
end
function prototype:refresh(heros)
  if not heros or table.empty(heros) then
    return
  end
  self.heros = heros
  self:clear()
  for i, v in ipairs(heros) do
    if v and v.baseId then
      local strBg = string.format("imgBg%d", i)
      local strIcon = string.format("imgIcon%d", i)
      local strNodeLv = string.format("nodeLv%d", i)
      local strSprLv = string.format("sprLv%d", i)
      local img = Logic:Get("Hero"):GetHeroImage(v.baseId)
      local spr = CCSprite:create(img)
      if self[strIcon] and spr then
        self[strIcon]:setDisplayFrame(spr:displayFrame())
        Logic:Get("HeroCardInfo"):AddShanCardSmall(self[strIcon], v.baseId)
      end
      local imgBg = i ~= 1 and Logic:Get("Hero"):GetHeroBgImage(v.baseId) or Logic:Get("Hero"):GetHeroBgImage(v.baseId, Logic.Hero.HEROIMG_SIZE.MIDDLE, true)
      local sprBg = CCSprite:create(imgBg)
      if self[strBg] and sprBg then
        self[strBg]:setDisplayFrame(sprBg:displayFrame())
      end
      if self[strSprLv] then
        self[strSprLv]:setVisible(true)
      end
      local chooseHeroId = Logic:Get("Armor"):getChooseHeroId()
      if chooseHeroId and chooseHeroId == v.id then
        if self.ani then
          self.ani:RemoveAnimation()
        end
        self.ani = Logic:Get("AniMgr"):NewCCB("UI/uijnsjtxfb", self[strBg], ccp(50, 53), 0, nil, 0.7)
        if self.ani then
          self.ani:RunAni()
        end
      end
      if self[strNodeLv] then
        self[strNodeLv]:setVisible(true)
        self[strNodeLv]:create(0, "YELLOW_E_NUM")
        self[strNodeLv]:setAlign("LEFT", "CENTER")
        self[strNodeLv]:setValue(v.level)
      end
    end
  end
end
function prototype:clear()
  local spr = CCSprite:create(CLARITY_PATH)
  if not spr then
    return
  end
  local bgSpr = CCSprite:create(DEFAULT_BG_PATH)
  if not bgSpr then
    return
  end
  for i = 1, 5 do
    local strIcon = string.format("imgIcon%d", i)
    local strBg = string.format("imgBg%d", i)
    local strNodeLv = string.format("nodeLv%d", i)
    local strSprLv = string.format("sprLv%d", i)
    if self[strIcon] then
      self[strIcon]:setDisplayFrame(spr:displayFrame())
      Logic:Get("HeroCardInfo"):ClearShanCardSmall(self[strIcon])
    end
    if self[strBg] then
      self[strBg]:setDisplayFrame(bgSpr:displayFrame())
    end
    if self[strSprLv] then
      self[strSprLv]:setVisible(false)
    end
    if self[strNodeLv] then
      self[strNodeLv]:setVisible(false)
    end
  end
end
function prototype:chooseItem(index)
  if not self.heros or not self.heros[index] then
    return
  end
  Logic:Get("Armor"):changeHeroInfo(self.heros[index])
end
function prototype:onBtn1Clicked(sender, event)
  self:chooseItem(1)
end
function prototype:onBtn2Clicked(sender, event)
  self:chooseItem(2)
end
function prototype:onBtn3Clicked(sender, event)
  self:chooseItem(3)
end
function prototype:onBtn4Clicked(sender, event)
  self:chooseItem(4)
end
function prototype:onBtn5Clicked(sender, event)
  self:chooseItem(5)
end
