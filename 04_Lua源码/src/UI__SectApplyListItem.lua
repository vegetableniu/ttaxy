module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
  self.data = {}
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:reFrashInfo(Data)
  if Data and next(Data) then
    self.data = Data
    self:initInfo()
  end
end
function prototype:onBtnApply(sender, event)
  local job = Logic:Get("Sect"):getSectInfo().job
  if Logic:Get("Sect"):checkAuth(job, "CHECK_APPLY") then
    Logic:Get("Sect"):PostCheckUser(true, self.data.playerId)
  else
    Prompt:Tip(TwGetStr(110151))
  end
end
function prototype:onBtnReject(sender, event)
  local job = Logic:Get("Sect"):getSectInfo().job
  if Logic:Get("Sect"):checkAuth(job, "CHECK_APPLY") then
    Logic:Get("Sect"):PostCheckUser(false, self.data.playerId)
  else
    Prompt:Tip(TwGetStr(110151))
  end
end
function prototype:initInfo()
  local iconPath = Logic:Get("Hero"):GetHeroImage(self.data.baseId)
  local spriteIcon = CCSprite:create(iconPath)
  if spriteIcon then
    self.fighterIcon:setDisplayFrame(spriteIcon:displayFrame())
  end
  local imgBg = Logic:Get("Hero"):GetHeroBgImage(self.data.baseId)
  local sprBg = CCSprite:create(imgBg)
  if sprBg then
    self.spriteRank:setDisplayFrame(sprBg:displayFrame())
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.fighterIcon, self.data.baseId)
  self.ttfName:setString(self.data.name)
  self.nodeLevel:create(0, "YELLOW_E_NUM")
  self.nodeLevel:setAlign("LEFT", "CENTER")
  self.nodeLevel:setValue(self.data.level)
  self.nodeBattle:create(0, "YELLOW_E_NUM")
  self.nodeBattle:setAlign("LEFT", "CENTER")
  self.nodeBattle:setValue(self.data.fightScore)
end
function prototype:onBtnHero(sender, event)
  if self.data == nil then
    return
  end
  local heroInfo = {
    level = self.data.level or 1,
    baseId = self.data.baseId or 1,
    powerSkill = tonumber(self.data.skill) or 1
  }
  Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(heroInfo)
end
