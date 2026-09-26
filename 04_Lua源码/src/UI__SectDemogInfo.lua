module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local LIFE_BG_PATH = "images/Devil/progress_life.png"
local CURR_LIFE_PATH = "images/Devil/progress_bg.png"
local ENERGY_BG_PATH = "images/Devil/progress_energyBg.png"
local CURR_ENERGY_PATH = "images/Devil/progress_energy.png"
function prototype:initialize(...)
  super.initialize(self, ...)
  self.enterType = nil
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self.btnCover:setEnabled(false)
  self:changeBtnShow(false)
  self.ttfLife:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTime:setStyle(kCCLabelTTFStyleOutline)
  local info = Logic:Get("Sect"):GetCheckedDemogInfo()
  self.data = info
  if info and not table.empty(info) then
    local baseId = 0
    if info.baseId then
      baseId = info.baseId
    else
      baseId = Logic:Get("Sect"):GetBaseIdByConfig(info.configId)
    end
    self.baseId = baseId
    local cardNode = Logic:Get("HeroCardInfo"):GetSprCard(baseId)
    if cardNode then
      local texture = Logic:Get("HeroCardInfo"):GetCardTexture(cardNode)
      if texture then
        self.imgDemogBg:setTexture(texture)
        self.imgDemogBg:setTextureRect(cardNode:getTextureRect())
      end
      Logic:Get("HeroCardInfo"):AddShanCard(self.imgDemogBg, baseId)
    end
    local color = Logic:Get("Hero"):getColorByBaseId(baseId)
    if color then
      self.ttfName:setColor(color)
    end
    local demog = Logic:Get("Sect"):GetCheckedDemogInfo()
    local name = "not found"
    if demog and demog.baseId then
      name = Logic:Get("Hero"):GetHeroInfoByBaseId(demog.baseId).name
    else
      local id = Logic:Get("Sect"):GetBaseIdByConfig(demog.configId)
      name = Logic:Get("Hero"):GetHeroInfoByBaseId(id).name
    end
    self.ttfName:setString(name)
  end
  if info.level and 0 <= info.level then
    self.nodeLv:create(0, "YELLOW_E_NUM")
    self.nodeLv:setAlign("LEFT", "CENTER")
    self.nodeLv:setValue(info.level)
  end
  self.nodeLifeBg:createProgress(LIFE_BG_PATH, CURR_LIFE_PATH)
  self.nodeLifeBg:setVisible(true)
  self:refreshData()
  Logic:Get("Sect"):On(Logic.Sect.EVT.ON_ATTACK_DEMOG, self:Event("OnAttackDemog"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.ON_CLEAR_COOLTIME, self:Event("OnClearCoolTime"))
  self.inScene = true
  self.bEscape = false
  self:onTimer()
end
function prototype:onExit()
  self.inScene = false
  Logic:Get("Battle"):SetEmBattleType(Logic.Battle.BATTLE_TYPE.CAMPAIGN)
  Logic:Get("Sect"):SetFromDemog(false)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:refreshData()
  local curHp = self.data.hp or self.data.currencyHp or 0
  local totalHp = self.data.totalHp or 1
  local str = string.format("%.0f/%.0f", curHp, totalHp)
  self.ttfLife:setString(str)
  local value = math.ceil(100 * curHp / totalHp)
  if value and value >= 0 then
    self.nodeLifeBg:setValue(value)
  end
  self.data.escapeTime = self.data.escapeTime or Logic:Get("System"):GetTime()
  local diffTime = Logic:Get("System"):DiffTime(self.data.escapeTime / 1000)
  local escapeTime = Logic:Get("System"):SecToDay(diffTime)
  if escapeTime and diffTime > 0 then
    local str = string.format("%02d:%02d:%02d", escapeTime.hour or 0, escapeTime.min or 0, escapeTime.sec or 0)
    self.ttfTime:setString(str)
  else
    self.bEscape = true
    self.ttfTime:setString(TwGetStr(105523))
  end
  local coolTime = Logic:Get("Sect"):getAttackDemogCoolTime()
  if coolTime and coolTime ~= 0 then
    diffTime = Logic:Get("System"):DiffTime(coolTime / 1000)
    coolTime = Logic:Get("System"):SecToDay(diffTime)
    if coolTime and diffTime > 0 then
      str = string.format("%02d:%02d:%02d", coolTime.hour or 0, coolTime.min or 0, coolTime.sec or 0)
      self.ttfRefreshTime:setString(str)
      self:changeBtnShow(true)
    else
      self.ttfRefreshTime:setString("")
      self:changeBtnShow(false)
    end
  else
    self:changeBtnShow(false)
  end
end
function prototype:onTimer()
  if self.inScene and not self.bEscape then
    local escpTime = self.data.escapeTime or Logic:Get("System"):GetTime()
    local diffTime = Logic:Get("System"):DiffTime(escpTime / 1000)
    local escapeTime = Logic:Get("System"):SecToDay(diffTime)
    if escapeTime and diffTime > 0 then
      local str = string.format("%02d:%02d:%02d", escapeTime.hour or 0, escapeTime.min or 0, escapeTime.sec or 0)
      self.ttfTime:setString(str)
    else
      self.bEscape = true
      self.ttfTime:setString(TwGetStr(105523))
    end
    if self.bEscape then
      Singleton(Timer):After(1000, self:Event("onTimer"))
      return
    end
    local coolTime = Logic:Get("Sect"):getAttackDemogCoolTime()
    if coolTime and coolTime ~= 0 then
      diffTime = Logic:Get("System"):DiffTime(coolTime / 1000)
      coolTime = Logic:Get("System"):SecToDay(diffTime)
      if coolTime and diffTime > 0 then
        local str = string.format("%02d:%02d:%02d", coolTime.hour or 0, coolTime.min or 0, coolTime.sec or 0)
        self.ttfRefreshTime:setString(str)
        self:changeBtnShow(true)
      else
        self:changeBtnShow(false)
        self.ttfRefreshTime:setString("")
      end
    else
      self:changeBtnShow(false)
      self.ttfRefreshTime:setString("")
    end
    Singleton(Timer):After(1000, self:Event("onTimer"))
  end
end
function prototype:clearCoolTime()
  Logic:Get("Sect"):PostClearCoolTime()
end
function prototype:onBtnReturnClicked(sender, event)
  SceneHelper:runWithScene("SectDemogList", self.rootNode)
end
function prototype:onBtnNormalClicked(sender, event)
  if self.data and not table.empty(self.data) then
    Logic:Get("Sect"):SetFromDemog(true)
    Logic:Get("Devil"):setIsAllAct(false)
    Logic:Get("Battle"):SetEmBattleType(Logic.Battle.BATTLE_TYPE.ARENA)
    SceneHelper:pushScene("EmbattleGroup", self.rootNode)
  end
end
function prototype:onBtnDemogClicked(sender, event)
  Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.baseId)
end
function prototype:onBtnRefresh(sender, event)
  local clearCoolTimeCost = KFDBGetRecord("ConfigValue", "MENPAI:CLEAR_COOLTIME_COUNT")
  clearCoolTimeCost = clearCoolTimeCost and tonumber(clearCoolTimeCost.content)
  Prompt:Confirm(self, "", TwGetStr(110172, clearCoolTimeCost), self.clearCoolTime, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:OnAttackDemog()
end
function prototype:OnUpdateRunTime()
  self.data = Logic:Get("Sect"):GetCheckedDemogInfo()
  self:refreshData()
end
function prototype:onPushReport()
  SceneHelper:pushScene("DevilResult", self.rootNode)
end
function prototype:OnClearCoolTime()
  self:refreshData()
end
function prototype:changeBtnShow(inCoolTime)
  self.sprAttack:setVisible(not inCoolTime)
  self.sprSword:setVisible(not inCoolTime)
  self.btnNormal:setVisible(not inCoolTime)
  self.sprCoolTime:setVisible(inCoolTime)
  self.btnRefresh:setVisible(inCoolTime)
  self.ttfRefresh:setVisible(inCoolTime)
  self.ttfRefreshTime:setVisible(inCoolTime)
end
