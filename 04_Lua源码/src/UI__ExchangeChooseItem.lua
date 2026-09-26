module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local path_select = "images/public/selcet2.png"
local path_unselect = "images/public/selcet1.png"
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLife:setStyle(kCCLabelTTFStyleOutline)
  self.ttfAttack:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:refresh(data, bFull)
  if not data or not next(data) then
    return
  end
  self.data = data
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(data.baseId)
  if info then
    self.ttfName:setString(info.name or "")
  end
  local color = Logic:Get("Hero"):getColorByBaseId(data.baseId)
  self.ttfName:setColor(color)
  local strBg = Logic:Get("Hero"):GetHeroBgImage(data.baseId)
  local sprBg = CCSprite:create(strBg)
  if sprBg then
    self.sprBg:setDisplayFrame(sprBg:displayFrame())
  end
  local strIcon = Logic:Get("Hero"):GetHeroImage(data.baseId)
  local sprIcon = CCSprite:create(strIcon)
  if sprIcon then
    self.sprIcon:setDisplayFrame(sprIcon:displayFrame())
  end
  self.alsLevel:create(0, "YELLOW_E_NUM")
  self.alsLevel:setAlign("LEFT", "CENTER")
  self.alsLevel:setValue(data.level or 0)
  local nLife, nAttack = Logic:Get("Hero"):GetHeroLifeAndAttack(data.baseId, data.level)
  self.ttfLife:setString(nLife or "0")
  self.ttfAttack:setString(nAttack or "0")
  local bSelect = Logic:Get("Exchange"):IsSelected(data.id)
  local path = bSelect and path_select or path_unselect
  local sprSelect = CCSprite:create(path)
  if sprSelect then
    self.sprSelect:setDisplayFrame(sprSelect:displayFrame())
  end
  local bSame = Logic:Get("Exchange"):IsSameName(data.id)
  self.btnItem:setEnabled(not bFull or bSelect)
  if not bSelect then
    local bSameFull = Logic:Get("Exchange"):CheckSameNameAndFull(data.id)
    self.btnItem:setEnabled(not bSameFull)
  end
end
function prototype:onBtnItem(...)
  local bSelect = Logic:Get("Exchange"):IsSelected(self.data.id)
  if bSelect then
    Logic:Get("Exchange"):RemoveCard(self.data.id)
  else
    Logic:Get("Exchange"):AddCard(self.data.id)
  end
  Logic:Get("Exchange"):PostUpdateList()
end
function prototype:onBtnIcon(...)
  if not self.data then
    return
  end
  Logic:Get("HeroCardInfo"):OpenHeroInfo(self.data)
end
