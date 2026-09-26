require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfFriendName:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:onBtnBg(sender, event)
  Logic:Get("System"):SetSysVariableMisc("FirstSelect", 1)
  self.owner:selectedCard(self.data.id, self.data)
end
function prototype:Refresh(data, owner, ownerType, idx)
  if table.empty(data or {}) then
    return
  end
  if ownerType == "SELF" then
    local logic = Logic:Get("HeroCardInfo")
    self.ccbHero:setCallBack(bind(logic.OpenHeroInfo, logic, data))
  else
    self.ccbHero:setCallBack(function()
      data.otherPlayer = true
      Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(data)
    end)
  end
  self.ccbHero:Refresh(data)
  self.data = data
  self.owner = owner
  local _, strStar = Logic:Get("Hero"):GetHeroBgImage(data.baseId)
  if strStar then
    local spr = CCSprite:create(strStar)
    if spr then
      self.sprStar:setDisplayFrame(spr:displayFrame())
    end
  end
  local strType = Logic:Get("HeroCardInfo"):GetHeroPhyleStr(data.baseId, Logic.HeroCardInfo.HERO_RACE.BIG)
  if strType then
    local spr = CCSprite:create(strType)
    if spr then
      self.sprRace:setDisplayFrame(spr:displayFrame())
    end
  end
  local path = Logic:Get("Hero"):GetHeroProfessionImage(data.baseId)
  local spr = CCSprite:create(path)
  if spr then
    self.sprProfession:setDisplayFrame(spr:displayFrame())
  end
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(data.baseId)
  self.ttfName:setString(info.name)
  self.ttfFriendName:setString(data.name or "")
  self:showSelected(ownerType)
  self:showFitStars()
  self.nodAni:removeAllChildrenWithCleanup(true)
  self.nodAni:stopAllActions()
  if idx == 1 then
    self:showGuideAni(self.nodAni)
  end
end
function prototype:showGuideAni(node)
  local bFirstSelect = Logic:Get("System"):GetSysVariableMisc("FirstSelect")
  if bFirstSelect then
    return
  end
  local function runAni()
    if self.ani then
      self.ani:RemoveAnimation()
      self.ani = nil
    end
    local x = 0
    local y = 0
    self.ani = Logic:Get("AniMgr"):NewCCB("UI/uixsyd02", node, ccp(x, y))
    if self.ani then
      self.ani:RunAni()
    end
  end
  local arr = CCArray:create()
  arr:addObject(CCCallFuncN:create(runAni))
  arr:addObject(CCDelayTime:create(1.5))
  node:runAction(CCRepeatForever:create(CCSequence:create(arr)))
end
function prototype:showSelected(ownerType)
  self.btnBg:setEnabled(true)
  self.sprSameCard:setVisible(false)
  local normalPath = "images/public/selcet1.png"
  local selectedPath = "images/public/selcet2.png"
  local lockPath = "images/public/selcet3.png"
  local spr = CCSprite:create(normalPath)
  if spr then
    self.sprSelect:setDisplayFrame(spr:displayFrame())
  end
  if Logic:Get("Explore"):IsSelected(self.data.id) then
    local spr = CCSprite:create(selectedPath)
    if spr then
      self.sprSelect:setDisplayFrame(spr:displayFrame())
    end
    return
  end
  local bCardFull = Logic:Get("Explore"):IsCardFull()
  local bFriendFull = ownerType == "FRIEND" and Logic:Get("Explore"):IsFriendCardFull()
  local bSameCard = Logic:Get("Explore"):HasSameCard(self.data.baseId)
  if bCardFull or bFriendFull or bSameCard then
    self.sprSameCard:setVisible(bSameCard)
    self.ttfFriendName:setString(bSameCard and "" or self.data.name)
    local spr = CCSprite:create(lockPath)
    if spr then
      self.sprSelect:setDisplayFrame(spr:displayFrame())
    end
    self.btnBg:setEnabled(false)
    return
  end
end
function prototype:showFitStars()
  local path = "images/Explore/star%d.png"
  local clarity = "images/public/clarity05.png"
  local sprs = list.map(function(index)
    return self["sprCondition" .. index]
  end, table.indices(list.rep({0}, 4)))
  self.sprCommand:setVisible(not table.empty(self.data.fit))
  for i, spr in ipairs(sprs) do
    local actPath = clarity
    if self.data.fit[i] then
      actPath = string.format(path, self.data.fit[i])
    end
    local ccSpr = CCSprite:create(actPath)
    if ccSpr then
      spr:setDisplayFrame(ccSpr:displayFrame())
    end
  end
end
