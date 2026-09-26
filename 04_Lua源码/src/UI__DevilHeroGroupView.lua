module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local IMG_NOR_PATH = {
  "images/Embattle/fontBattleGroup.png",
  "images/Embattle/fontFirstGroup.png",
  "images/Embattle/fontSecondGroup.png"
}
local IMG_SEL_PATH = {
  "images/Embattle/fontBattleGroupSel.png",
  "images/Embattle/fontFirstGroupSel.png",
  "images/Embattle/fontSecondGroupSel.png"
}
function prototype:onEnter()
  super.onEnter(self)
  self.currGroupX = self.nodeCurrGroup:getPositionX()
  self.firstGroupX = self.nodeFirstGroup:getPositionX()
  self.groups = {}
  self.groupId = 1
  self:setGroupEmbattle(self.groupId)
end
function prototype:onBtnClose()
  SceneHelper:removeScene("DevilHeroGroupView")
end
function prototype:onBtnHeroImage(sender, event)
  for i = 1, 6 do
    local str = string.format("btnHeroImage%d", i)
    if sender == self[str] then
      self:createHero(i)
      break
    end
  end
end
function prototype:onBtnCurrGroup(sender, event)
  if self.groupId == 1 then
    return
  end
  self.groupId = 1
  self:setGroupEmbattle(self.groupId)
end
function prototype:onBtnFirstGroup(sender, event)
  if self.groupId == 2 then
    return
  end
  self.groupId = 2
  self:setGroupEmbattle(self.groupId)
end
function prototype:onBtnSecGroup(sender, event)
  if self.groupId == 3 then
    return
  end
  self.groupId = 3
  self:setGroupEmbattle(self.groupId)
end
function prototype:onBtnGroup(sender, event)
  SceneHelper:pushScene("DevilGroup", self.rootNode)
end
function prototype:setGroupEmbattle(groupId)
  local groupsInfo = Logic:Get("Hero"):GetRankGroupInfo()
  if groupsInfo == nil or next(groupsInfo) == nil then
    return
  end
  for k, v in pairs(groupsInfo.groups) do
    if v.groupId == groupId then
      self.groups = v
      break
    end
  end
  if #groupsInfo.groups == 1 then
    self.nodeCurrGroup:setVisible(false)
    self.nodeFirstGroup:setVisible(false)
    self.nodeSecGroup:setVisible(false)
  elseif #groupsInfo.groups == 2 then
    self.nodeCurrGroup:setPositionX(self.currGroupX + 100)
    self.nodeFirstGroup:setPositionX(self.firstGroupX + 100)
    self.nodeSecGroup:setVisible(false)
  end
  for i = 1, #IMG_NOR_PATH do
    local str = string.format("imgGroup%d", i)
    if groupId == i then
      local spr = CCSprite:create(IMG_SEL_PATH[i])
      if spr == nil then
        break
      end
      if self[str] then
        self[str]:setDisplayFrame(spr:displayFrame())
      end
    else
      local spr = CCSprite:create(IMG_NOR_PATH[i])
      if spr == nil then
        break
      end
      if self[str] then
        self[str]:setDisplayFrame(spr:displayFrame())
      end
    end
  end
  for i = 1, #self.groups.embattles do
    for j = 1, 2 do
      local index = (i - 1) * 2 + j
      local strView = string.format("ccbHero%d", index)
      if not strView then
        return
      end
      if self.groups.embattles[i][j] ~= nil then
        self[strView]:SetImage(self.groups.embattles[i][j], self.groups.leaderBaseId)
        self[strView]:setScale(0.9)
      else
        self[strView]:SetImage(nil)
      end
    end
  end
end
function prototype:createHero(index)
  local heroInfo = index <= 3 and (self.groups.embattles[index][1] or {}) or self.groups.embattles[index - 3][2] or {}
  if table.empty(heroInfo) then
    return
  end
  heroInfo.userBuffs = self.groups.userBuff
  heroInfo.artifactLevel = self.groups.artifactLevel
  heroInfo.otherPlayer = true
  Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(heroInfo)
end
