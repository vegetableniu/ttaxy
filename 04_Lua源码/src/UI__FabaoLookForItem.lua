module((...), package.seeall)
require("SceneHelper")
local HERO_ICON_PATH = "images/public/clarity05.png"
local FABAO_ICON_BG = "images/public/herobg.png"
MAX_FABAO_TREA_PER_PAGE = 4
prototype = Tw.Controller.prototype:extend()
function prototype:initialize()
  super.initialize(self)
  self.idxBegin = 1
end
function prototype:onEnter()
  super.onEnter(self)
end
function prototype:clear()
  local sprIcon = CCSprite:create(HERO_ICON_PATH)
  for i = 1, MAX_FABAO_TREA_PER_PAGE do
    local str = string.format("imgItem%d", i)
    if self[str] then
      self[str]:setDisplayFrame(sprIcon:displayFrame())
      Logic:Get("HeroCardInfo"):ClearShanCardSmall(self[str])
    end
    sprIcon = CCSprite:create(FABAO_ICON_BG)
    str = string.format("imgkuang%d", i)
    if self[str] then
      self[str]:setDisplayFrame(sprIcon:displayFrame())
    end
    str = string.format("btnItem%d", i)
    if self[str] then
      self[str]:setEnabled(false)
    end
  end
end
function prototype:ReFrashInfo(page)
  self:clear()
  local treaPacVo = Logic:Get("FabaoLookFor"):GetTreasurePackVo()
  local treaLst = treaPacVo and treaPacVo.treasures or nil
  if treaLst == nil or table.empty(treaLst) then
    return
  end
  self.idxBegin = (page - 1) * MAX_FABAO_TREA_PER_PAGE + 1
  for i = 1, MAX_FABAO_TREA_PER_PAGE do
    local idx = (page - 1) * MAX_FABAO_TREA_PER_PAGE + i
    local id = treaLst[idx]
    if id then
      local str = string.format("imgItem%d", i)
      local rec = KFDBGetRecord("TalismanSetting", id)
      if self[str] and rec and rec.baseId then
        local iconPath = Logic:Get("Hero"):GetHeroImage(rec.baseId)
        if iconPath and "" ~= iconPath then
          local spriteIcon = CCSprite:create(iconPath)
          if spriteIcon then
            self[str]:setDisplayFrame(spriteIcon:displayFrame())
          end
          Logic:Get("HeroCardInfo"):AddShanCardSmall(self[str], rec.baseId)
        else
          log4misc:warn("GetHeroImage failed " .. rec.baseId)
        end
      end
      str = string.format("imgkuang%d", i)
      if self[str] and rec then
        local strBg = Logic:Get("Hero"):GetHeroBgImage(rec.baseId)
        if strBg and "" ~= strBg then
          local spriteBg = CCSprite:create(strBg)
          if spriteBg then
            self[str]:setDisplayFrame(spriteBg:displayFrame())
          end
        end
      end
      str = string.format("btnItem%d", i)
      if self[str] then
        self[str]:setEnabled(true)
      end
    end
  end
end
function prototype:onBtnSelect(sender, event)
  local treaPacVo = Logic:Get("FabaoLookFor"):GetTreasurePackVo()
  local treaLst = treaPacVo and treaPacVo.treasures or nil
  if treaLst == nil or table.empty(treaLst) then
    return
  end
  local btnIdx = 1
  for i = 1, MAX_FABAO_TREA_PER_PAGE do
    local str = string.format("btnItem%d", i)
    if sender == self[str] then
      btnIdx = i
      break
    end
  end
  local idxTreasure = self.idxBegin + btnIdx - 1
  if treaLst[idxTreasure] == nil then
    return
  end
  Logic:Get("HeroCardInfo"):OpenTailsmanByID(treaLst[idxTreasure])
end
