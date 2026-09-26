module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
  self.data = {}
  self.leftTimePos = {}
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self.sprBox:setVisible(false)
  self.labTip:setVisible(false)
  self.sprWinLab:setVisible(false)
  self.labTip:setStyle(kCCLabelTTFStyleOutline)
  self.ttfDemogName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLeftTime:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:onNodeLoaded(node, loader)
  self.leftTimePos.x = self.ttfLeftTime:getPositionX()
  self.leftTimePos.y = self.ttfLeftTime:getPositionY()
end
function prototype:refresh(data)
  self:clear()
  if not data or table.empty(data) then
    return
  end
  self.data = data
  self.escape = false
  local baseId = Logic:Get("Sect"):GetBaseIdByConfig(data.configId)
  if baseId then
    local iconPath = Logic:Get("Hero"):GetHeroImage(baseId)
    if iconPath then
      local spriteIcon = CCSprite:create(iconPath)
      if spriteIcon then
        self.sprHeroIcon:setDisplayFrame(spriteIcon:displayFrame())
      end
    end
    local strBg, strStar = Logic:Get("Hero"):GetHeroBgImage(baseId)
    if strBg then
      local spriteBg = CCSprite:create(strBg)
      if spriteBg then
        self.sprHeroBg:setDisplayFrame(spriteBg:displayFrame())
      end
    end
    Logic:Get("HeroCardInfo"):AddShanCardSmall(self.sprHeroIcon, baseId)
  end
  local id = Logic:Get("Sect"):GetBaseIdByConfig(data.configId)
  local name = Logic:Get("Hero"):GetHeroInfoByBaseId(id)
  name = name and name.name or "no demog name"
  local color = Logic:Get("Hero"):getColorByBaseId(baseId)
  if color then
    self.ttfDemogName:setColor(color)
  end
  self.ttfDemogName:setString(name)
  self.ttfName:setString(data.nameCall or "no call name")
  self.ttfLeftTime:setPosition(ccp(self.leftTimePos.x, self.leftTimePos.y))
  local currTime = Logic:Get("System"):GetTime()
  self.diffTime = Logic:Get("System"):DiffTime(data.escapeTime / 1000)
  if self.diffTime > 0 and data.hp ~= 0 then
    self.sprFight:setVisible(true)
    self.sprBox:setVisible(false)
    self.sprWinLab:setVisible(false)
    local restTime = Logic:Get("System"):SecToDay(self.diffTime)
    if restTime then
      local str = ""
      if restTime.hour and 0 < restTime.hour then
        str = str .. TwGetStr(100045, restTime.hour)
      end
      if restTime.min and 0 < restTime.min then
        str = str .. TwGetStr(100046, restTime.min)
      end
      str = str .. TwGetStr(105507, restTime.sec or 0)
      self.ttfLeftTime:setString(str)
    end
  else
    self.sprFight:setVisible(false)
    if data.canReward then
      self.sprBox:setVisible(true)
      self.labTip:setVisible(true)
      self.sprWinLab:setVisible(true)
      self.labTip:setString(TwGetStr(105559))
    else
      self.sprBox:setVisible(false)
      self.sprWinLab:setVisible(false)
      if data.hp ~= 0 then
        self.escape = true
        self.ttfLeftTime:setString(TwGetStr(110121))
      else
        self.ttfLeftTime:setString(TwGetStr(103014))
      end
    end
  end
  local sectInfo = Logic:Get("Sect"):getSectInfo()
  local demogLevel = 0
  for i = 1, KFDBGetRecordAmt("DemogConfig") do
    local rec = KFDBGetRecordByIdx("DemogConfig", i)
    if rec and rec.baseId == baseId and sectInfo and sectInfo.level == rec.menpaiLevel then
      demogLevel = rec.demogLevel
      break
    end
  end
  self.nodeLv:create(0, "YELLOW_E_NUM")
  self.nodeLv:setAlign("LEFT", "CENTER")
  self.nodeLv:setValue(demogLevel)
  self.nodeLife:create(0, "YELLOW_E_NUM")
  self.nodeLife:setAlign("LEFT", "CENTER")
  if data.hp and 0 <= data.hp then
    self.nodeLife:setValue(data.hp)
  end
end
function prototype:onBtnBgClicked(sender, event)
  if not self.data.canReward and self.data.hp == 0 or self.escape then
    return
  end
  Logic:Get("Sect"):SetCheckedDemogInfo(self.data)
  if self.data.canReward then
    Logic:Get("Sect"):PostDrawReward(self.data.demogId)
  else
    SceneHelper:runWithScene("SectDemogInfo", self.rootNode)
  end
end
function prototype:onBtnIconClicked(sender, event)
  Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.data.baseId)
end
function prototype:clear()
  self.ttfDemogName:setString("")
  self.ttfName:setString("")
  self.ttfLeftTime:setString("")
  self.sprBox:setVisible(false)
  self.sprWinLab:setVisible(false)
  self.sprFight:setVisible(false)
  self.ttfDemogName:setColor(ccColor3B(255, 255, 255))
end
