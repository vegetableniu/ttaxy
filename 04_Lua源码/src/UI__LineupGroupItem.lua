require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:onBtnHeroClicked(sender, event)
end
function prototype:onBtnLeaderClicked(sender, event)
end
function prototype:refreshGroup(data, groupName, idx)
  self.idx = idx
  self.data = data
  self.groupName = groupName
  self:refreshTitle()
  self:clear()
  self:refreshHeros()
end
function prototype:clear()
  local MAX_HERO = 5
  local HERO_BG_PATH = "images/public/herobg.png"
  local HERO_ICON_PATH = "images/public/clarity05.png"
  local sprBg = CCSprite:create(HERO_BG_PATH)
  local sprIcon = CCSprite:create(HERO_ICON_PATH)
  for i = 1, MAX_HERO do
    local strHeroBg = string.format("sprHeroBg%d", i)
    local strIcon = string.format("sprHeroIcon%d", i)
    local strSprLv = string.format("sprLv%d", i)
    local strNodLv = string.format("nodLv%d", i)
    if self[strHeroBg] then
      self[strHeroBg]:setDisplayFrame(sprBg:displayFrame())
    end
    if self[strIcon] then
      self[strIcon]:setDisplayFrame(sprIcon:displayFrame())
      Logic:Get("HeroCardInfo"):ClearShanCardSmall(self[strIcon])
    end
    self[strSprLv]:setVisible(false)
    self[strNodLv]:setVisible(false)
  end
end
function prototype:refreshHeros()
  local leaders = Logic:Get("Lineup"):getTeamLeaderByName(self.groupName)
  local leaderId = leaders[self.idx]
  if leaderId == nil then
    return
  end
  local arrayIds = {}
  for _, ids in ipairs(self.data) do
    for i, id in ipairs(ids) do
      if id ~= ID[0] and id ~= ID[-1] then
        if id == leaderId then
          table.insert(arrayIds, 1, id)
        else
          table.insert(arrayIds, id)
        end
      end
    end
  end
  local idx = leaderId == ID[-1] and 1 or 0
  for i, id in ipairs(arrayIds) do
    local heroInfo = Logic:Get("Hero"):GetHeroInfoById(id)
    self:refreshHeroIcon(i + idx, heroInfo)
  end
end
function prototype:refreshHeroIcon(idx, hero)
  if idx == nil or hero == nil then
    return
  end
  if idx < 0 or idx > 5 then
    return
  end
  local strHeroBg = string.format("sprHeroBg%d", idx)
  local strIcon = string.format("sprHeroIcon%d", idx)
  local strSprLv = string.format("sprLv%d", idx)
  local strNodLv = string.format("nodLv%d", idx)
  local strAdd = string.format("imgAdd%d", idx)
  local iconPath = Logic:Get("Hero"):GetHeroImage(hero.baseId)
  local spriteIcon = CCSprite:create(iconPath)
  if spriteIcon then
    self[strIcon]:setDisplayFrame(spriteIcon:displayFrame())
  end
  local strBg = Logic:Get("Hero"):GetHeroBgImage(hero.baseId)
  local spriteBg = CCSprite:create(strBg)
  if spriteBg then
    self[strHeroBg]:setDisplayFrame(spriteBg:displayFrame())
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self[strIcon], hero.baseId)
  if hero.level and 0 < hero.level then
    self[strSprLv]:setVisible(true)
    self[strNodLv]:setVisible(true)
    self[strNodLv]:create(0, "YELLOW_E_NUM")
    self[strNodLv]:setAlign("LEFT", "CENTER")
    self[strNodLv]:setValue(hero.level)
  else
    self[strSprLv]:setVisible(false)
    self[strNodLv]:setVisible(false)
  end
end
function prototype:refreshTitle()
  local path = string.format("images/TeamSwitch/fntGroup%d.png", self.idx)
  local spr = CCSprite:create(path)
  if spr then
    self.sprGroup:setDisplayFrame(spr:displayFrame())
  end
end
