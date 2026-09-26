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
  super.onEnter(self)
  Logic:Get("Guide"):On(Logic.Guide.EVT.STEP, self:Event("updateGuide"))
  Logic:Get("Hero"):ClearFiendInfo()
  self.enterType = Logic:Get("Devil"):getEnterType()
  if self.enterType == Logic.Devil.ENTER_TYPE.DEVIL_LIST then
    self.btnCover:setEnabled(false)
  elseif self.enterType == Logic.Devil.ENTER_TYPE.BATTLE then
    self.btnCover:setEnabled(true)
    self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIMS", self.layer)
  end
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCostNormal:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCostFull:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLife:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTime:setStyle(kCCLabelTTFStyleOutline)
  self.ttfVigor:setStyle(kCCLabelTTFStyleOutline)
  self.ttfReset:setStyle(kCCLabelTTFStyleOutline)
  self.ttfActName:setStyle(kCCLabelTTFStyleOutline)
  self.data = Logic:Get("Devil"):getDavilData()
  self:setActive()
  local cardNode = Logic:Get("HeroCardInfo"):GetSprCard(self.data.baseId)
  if cardNode then
    local texture = Logic:Get("HeroCardInfo"):GetCardTexture(cardNode)
    if texture then
      self.sprHeroBg:setTexture(texture)
      self.sprHeroBg:setTextureRect(cardNode:getTextureRect())
    end
    Logic:Get("HeroCardInfo"):AddShanCard(self.sprHeroBg, self.data.baseId)
  end
  if self.data.level and self.data.level >= 0 then
    self.nodeLv:create(0, "YELLOW_E_NUM")
    self.nodeLv:setAlign("LEFT", "CENTER")
    self.nodeLv:setValue(self.data.level)
  end
  local color = Logic:Get("Hero"):getColorByBaseId(self.data.baseId)
  if color then
    self.ttfName:setColor(color)
  end
  self.ttfName:setString(self.data.name)
  local normal = Logic:Get("Devil"):getNormalAct()
  local all = Logic:Get("Devil"):getAllOutAct()
  self.ttfCostNormal:setString(TwGetStr(105509, normal or 0))
  self.ttfCostFull:setString(TwGetStr(105509, all or 0))
  self.nodeLifeBg:createProgress(LIFE_BG_PATH, CURR_LIFE_PATH)
  self.nodeLifeBg:setVisible(true)
  self.nodeEnergy:createProgress(ENERGY_BG_PATH, CURR_ENERGY_PATH)
  self.nodeEnergy:setVisible(true)
  self:refreshData()
  Logic:Get("Devil"):On(Logic.Devil.EVT.UPDATE_DAMOG_LIST, self:Event("OnUpdateRunTime"))
  Logic:Get("Devil"):On(Logic.Devil.EVT.PUSH_REPORT, self:Event("onPushReport"))
  Logic:Get("Devil"):On(Logic.Devil.EVT.BUY_SUCCESSED, self:Event("onBuySuccessed"))
  if self.ani then
    self.ani:RunAni(nil, nil, bind(self.aniEnd, self))
  end
end
function prototype:onExit()
  Logic:Get("Battle"):SetEmBattleType(Logic.Battle.BATTLE_TYPE.CAMPAIGN)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:refreshData()
  local str = string.format("%.0f/%.0f", self.data.currentHp or 0, self.data.totalHp or 1)
  self.ttfLife:setString(str)
  local energy = Logic:Get("Devil"):GetEnergy() or {}
  local maxEnergy = Logic:Get("Devil"):GetMaxEnergy()
  if energy.waitTime and maxEnergy > energy.point then
    self.sprReset:setVisible(true)
    self.ttfReset:setVisible(true)
    self.ttfReset:setString(TwGetStr(102003, energy.waitTime.min or 0, energy.waitTime.sec or 0))
  else
    self.sprReset:setVisible(false)
    self.ttfReset:setVisible(false)
  end
  self.ttfVigor:setString(TwGetStr(105538, energy.point or 0, maxEnergy))
  local energyPct = math.ceil(100 * energy.point / maxEnergy)
  if energyPct < 0 then
    energyPct = 0 or energyPct
  end
  if energyPct > 100 then
    energyPct = 100 or energyPct
  end
  self.nodeEnergy:setValue(energyPct)
  local value = math.ceil(100 * self.data.currentHp / self.data.totalHp)
  if value and value >= 0 then
    self.nodeLifeBg:setValue(value)
  end
  if self.data.waitTime and not Logic:Get("Devil"):checkTimeOut(self.data.waitTime) then
    local str = string.format("%02d:%02d:%02d", self.data.waitTime.hour or 0, self.data.waitTime.min or 0, self.data.waitTime.sec or 0)
    self.ttfTime:setString(str)
  else
    self.ttfTime:setString(TwGetStr(105523))
  end
end
function prototype:setActive()
  local activeId = Logic:Get("Devil"):getActiveId() or ""
  local rec = KFDBGetRecord("DemogActiveConfig", activeId)
  if not rec then
    return
  end
  local name = json.decode(rec.name or "[]") or {}
  if rec.showLevel == "" then
    self.ttfActName:setString(name[1] or "")
    return
  end
  local recLevel = json.decode(rec.showLevel or "[]") or {}
  local idx = 0
  for i, ranges in ipairs(recLevel) do
    if self.data.level >= ranges[1] and self.data.level <= ranges[2] then
      idx = i
      break
    end
  end
  self.ttfActName:setString(name[idx] or "")
end
function prototype:onBtnReturnClicked(sender, event)
  SceneHelper:popScene()
end
function prototype:onBtnNormalClicked(sender, event)
  local result = Logic:Get("Hero"):checkAllGroupLeaderShip()
  if result > 0 then
    local str = ""
    if result == 1 then
      str = TwGetStr(105532) .. TwGetStr(105533) .. TwGetStr(103070)
    else
      str = TwGetStr(105534, TwGetStr(102131 + result - 2)) .. TwGetStr(103070)
    end
    Prompt:Confirm(self, 103071, str)
    return
  end
  if Logic:Get("Devil"):checkTimeOut(self.data.waitTime) then
    Prompt:Fail(TwGetStr(105523))
    return
  end
  local energy = Logic:Get("Devil"):GetEnergy()
  local normal = Logic:Get("Devil"):getNormalAct()
  if energy and normal and normal > energy.point then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(105219)
    local str = TwGetStr(105557)
    Prompt:Confirm(self, "", str, self.onBuyEnergy, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  Logic:Get("Devil"):setIsAllAct(false)
  Logic:Get("Battle"):SetEmBattleType(Logic.Battle.BATTLE_TYPE.DEMOG)
  SceneHelper:pushScene("EmbattleGroup", self.rootNode)
end
function prototype:onBtnFullClicked(sender, event)
  local result = self:checkLeaderShip()
  if result > 0 then
    local str = ""
    if result == 1 then
      str = TwGetStr(105532) .. TwGetStr(105533) .. TwGetStr(103070)
    else
      str = TwGetStr(105534, TwGetStr(102131 + result - 2)) .. TwGetStr(103070)
    end
    Prompt:Confirm(self, 103071, str)
    return
  end
  Logic:Get("Guide"):done("Devil", "SelectItem")
  if Logic:Get("Devil"):checkTimeOut(self.data.waitTime) then
    Prompt:Fail(TwGetStr(105523))
    return
  end
  local energy = Logic:Get("Devil"):GetEnergy()
  local all = Logic:Get("Devil"):getAllOutAct()
  if energy and all and all > energy.point then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(105219)
    local str = TwGetStr(105557)
    Prompt:Confirm(self, "", str, self.onBuyEnergy, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  Logic:Get("Devil"):setIsAllAct(true)
  Logic:Get("Battle"):SetEmBattleType(Logic.Battle.BATTLE_TYPE.DEMOG)
  SceneHelper:pushScene("EmbattleGroup", self.rootNode)
end
function prototype:onBtnHeroClicked(sender, event)
  Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.data.baseId)
end
function prototype:onBtnBuyClicked(sender, event)
  local leaveBuyTime = Logic:Get("Devil"):GetLeaveBuyTimes()
  if leaveBuyTime <= 0 then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    local str = TwGetStr(10078) .. "\n" .. TwGetStr(105321)
    Prompt:Confirm(Logic:Get("Main"), "", str, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  SceneHelper:pushPrompt("DevilBuyTip", self.rootNode)
end
function prototype:aniEnd()
  if self.ani then
    self.ani:RemoveAnimation()
  end
  self.btnCover:setEnabled(false)
  if not Logic:Get("Devil"):isGuideDevil() then
    Logic:Get("Devil"):setGuideDevil(true)
    Logic:Get("Guide"):check()
  end
end
function prototype:OnUpdateRunTime()
  self.data = Logic:Get("Devil"):getDavilData()
  self:refreshData()
end
function prototype:onPushReport()
  SceneHelper:pushScene("DevilResult", self.rootNode)
end
function prototype:onConfirmBuy()
  MsgDemog:Post("BUY_ENERGY")
end
function prototype:onBuySuccessed()
  self:refreshData()
end
function prototype:onBuyEnergy()
  SceneHelper:pushPrompt("DevilBuyTip", self.rootNode)
end
function prototype:checkLeaderShip()
  local playersLeadership = Logic:Get("Hero"):GetLeadership()
  local group = Logic:Get("Hero"):GetGroups()
  local result = -1
  for i, v in ipairs(group) do
    Logic:Get("Devil"):SetChangeGroup({heros = v})
    Logic:Get("Devil"):InitGroupTeamerHero(v.groupId)
    local leadership = Logic:Get("Devil"):GetGroupLeadership()
    if playersLeadership < leadership then
      result = v.groupId
      break
    end
  end
  return result
end
function prototype:updateGuide()
  if Logic:Get("Guide"):isActive("Devil", "SelectItem") then
    Logic:Get("Guide"):lockTouch(self.btnFull)
  end
end
