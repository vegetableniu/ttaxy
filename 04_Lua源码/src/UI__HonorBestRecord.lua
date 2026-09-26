module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local MAX_PLAYER = 3
local CLARITY_PATH = "images/public/clarity05.png"
function prototype:initialize()
  super.initialize(self)
end
function prototype:onEnter()
  super.onEnter(self)
  for i = 1, MAX_PLAYER do
    local nameStr = string.format("ttfName%d", i)
    if self[nameStr] then
      self[nameStr]:setStyle(kCCLabelTTFStyleOutline)
    end
  end
  self.ttfBattle:setStyle(kCCLabelTTFStyleOutline)
  self:Clear()
  self.honor = Logic:Get("Rebirth"):GetHonorType()
  if self.honor == Logic.Rebirth.HONOR_TYPE.REBIRTH then
    self:InitRebirthRecordView()
  elseif self.honor == Logic.Rebirth.HONOR_TYPE.ELITE then
    self:InitEliteRecordView()
  else
    self:InitBattleRecordView()
  end
  self:DisabledBtn()
end
function prototype:onExit()
  Logic:Get("Rebirth"):SetHonorType(Logic.Rebirth.HONOR_TYPE.BATTLE)
end
function prototype:Clear()
  for i = 1, MAX_PLAYER do
    local str = string.format("nodHero%d", i)
    local bgStr = string.format("sprHeroBg%d", i)
    local iconStr = string.format("sprHeroIcon%d", i)
    local nameStr = string.format("ttfName%d", i)
    if self[str] then
      self[str]:setVisible(false)
    end
    local spr = CCSprite:create(CLARITY_PATH)
    if spr then
      self[iconStr]:setDisplayFrame(spr:displayFrame())
      self[bgStr]:setDisplayFrame(spr:displayFrame())
      Logic:Get("HeroCardInfo"):ClearShanCardSmall(self[iconStr])
    end
    if self[nameStr] then
      self[nameStr]:setString("")
    end
  end
  self.btnNext:setEnabled(true)
  self.btnPrev:setEnabled(true)
end
function prototype:DisabledBtn()
  if self.listIdx == #self.listData then
    self.btnNext:setEnabled(false)
  end
  if self.listIdx == 1 then
    self.btnPrev:setEnabled(false)
  end
end
function prototype:InitBattleRecordView()
  Logic:Get("Battle"):On(Logic.Battle.EVT.BEST_RECORD, self:Event("OnBestRecord"))
  local camId = Logic:Get("Battle"):GetCurSelCampaign()
  if camId == nil then
    return
  end
  self.listData = Logic:Get("Battle"):GetBattleLst(camId)
  if self.listData == nil or table.empty(self.listData) then
    return
  end
  if #self.listData <= 1 then
    self.nodPrev:setVisible(false)
    self.nodNext:setVisible(false)
  end
  self.listIdx = #self.listData
  self:setBattleNameStr()
  MsgBattle:Post("BEST_RECORD", {
    battleId = self.listData[self.listIdx]
  })
end
function prototype:InitRebirthRecordView()
  Logic:Get("Rebirth"):On(Logic.Rebirth.EVT.RECORD, self:Event("OnRecord"))
  self.imgBtnRightBg:setVisible(false)
  self.sprRight:setVisible(false)
  self.btnFirstRecord:setEnabled(false)
  self.listData = Logic:Get("Rebirth"):GetListData()
  if self.listData == nil or table.empty(self.listData) then
    return
  end
  if #self.listData <= 1 then
    self.nodPrev:setVisible(false)
    self.nodNext:setVisible(false)
  end
  self.listIdx = 1
  Logic:Get("Rebirth"):SetBattleId(self.listData[self.listIdx].id)
  local info = KFDBGetRecord("CampaignConfig", Logic:Get("Rebirth"):GetCampaignId())
  self:setRebirthNameStr()
  Logic:Get("Rebirth"):PostRecord()
end
function prototype:InitEliteRecordView()
  Logic:Get("Elite"):On(Logic.Elite.EVT.RECORD, self:Event("OnEliteRecord"))
  self.imgBtnRightBg:setVisible(false)
  self.sprRight:setVisible(false)
  self.btnFirstRecord:setEnabled(false)
  self.listData = Logic:Get("Elite"):GetBattleList()
  if self.listData == nil or table.empty(self.listData) then
    return
  end
  if #self.listData <= 1 then
    self.nodPrev:setVisible(false)
    self.nodNext:setVisible(false)
  end
  self.listIdx = 1
  Logic:Get("Elite"):SetBattleId(self.listData[self.listIdx].id)
  local info = KFDBGetRecord("CampaignConfig", Logic:Get("Elite"):GetCampaignId())
  self:setRebirthNameStr()
  Logic:Get("Elite"):PostRecord()
end
function prototype:InitPlayers(info, idx)
  if info == nil or table.empty(info) then
    return
  end
  if idx < 1 or idx > MAX_PLAYER then
    return
  end
  local strName = string.format("ttfName%d", idx)
  local strBg = string.format("sprHeroBg%d", idx)
  local strIcon = string.format("sprHeroIcon%d", idx)
  local strBtn = string.format("nodHero%d", idx)
  local strPower = string.format("nodPower%d", idx)
  local leaderBaseId = 0
  for _, v in pairs(info.groups or {}) do
    if v.groupId == 1 then
      leaderBaseId = v.leaderBaseId
      break
    end
  end
  local iconPath = Logic:Get("Hero"):GetHeroImage(leaderBaseId)
  local spriteIcon = CCSprite:create(iconPath or CLARITY_PATH)
  if spriteIcon then
    self[strIcon]:setDisplayFrame(spriteIcon:displayFrame())
  end
  local strPathBg = Logic:Get("Hero"):GetHeroBgImage(leaderBaseId)
  local spriteBg = CCSprite:create(strPathBg or CLARITY_PATH)
  if spriteBg then
    self[strBg]:setDisplayFrame(spriteBg:displayFrame())
  end
  if self[strName] then
    self[strName]:setString(info.name or "")
  end
  if info.fightScore and self[strBtn] then
    self[strBtn]:setVisible(true)
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self[strIcon], leaderBaseId)
  if info.fightScore and 0 <= info.fightScore then
    self[strPower]:create(0, "YELLOW_E_NUM")
    self[strPower]:setAlign("LEFT", "CENTER")
    self[strPower]:setValue(info.fightScore)
  end
end
function prototype:setBattleNameImg()
  local rec = KFDBGetRecord("RebirthActivePath", self.listData[self.listIdx].id)
  if rec then
    local spr = CCSprite:create(rec.namePath)
    if spr then
      self.sprBattle:setDisplayFrame(spr:displayFrame())
    end
  end
end
function prototype:setRebirthNameStr()
  local rec = Logic:Get("Battle"):GetBattleInfoById(self.listData[self.listIdx].id)
  if rec then
    self.ttfBattle:setString(rec.name or "")
  end
end
function prototype:setBattleNameStr()
  local rec = Logic:Get("Battle"):GetBattleInfoById(self.listData[self.listIdx])
  if rec then
    self.ttfBattle:setString(rec.name or "")
  end
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:popScene()
end
function prototype:onBtnPrev(sender, event)
  if self.listIdx == nil then
    return
  end
  self.listIdx = self.listIdx - 1
  if self.listIdx < 1 then
    self.listIdx = #self.listData
  end
  if self.honor == Logic.Rebirth.HONOR_TYPE.REBIRTH then
    Logic:Get("Rebirth"):SetBattleId(self.listData[self.listIdx].id)
    local info = KFDBGetRecord("CampaignConfig", Logic:Get("Rebirth"):GetCampaignId())
    self:setRebirthNameStr()
    Logic:Get("Rebirth"):PostRecord()
  elseif self.honor == Logic.Rebirth.HONOR_TYPE.ELITE then
    Logic:Get("Elite"):SetBattleId(self.listData[self.listIdx].id)
    self:setRebirthNameStr()
    Logic:Get("Elite"):PostRecord()
  else
    self:setBattleNameStr()
    MsgBattle:Post("BEST_RECORD", {
      battleId = self.listData[self.listIdx]
    })
  end
end
function prototype:onBtnNext(sender, event)
  if self.listIdx == nil then
    return
  end
  self.listIdx = self.listIdx + 1
  if self.listIdx > #self.listData then
    self.listIdx = 1
  end
  if self.honor == Logic.Rebirth.HONOR_TYPE.REBIRTH then
    Logic:Get("Rebirth"):SetBattleId(self.listData[self.listIdx].id)
    local info = KFDBGetRecord("CampaignConfig", Logic:Get("Rebirth"):GetCampaignId())
    self:setRebirthNameStr()
    Logic:Get("Rebirth"):PostRecord()
  elseif self.honor == Logic.Rebirth.HONOR_TYPE.ELITE then
    Logic:Get("Elite"):SetBattleId(self.listData[self.listIdx].id)
    self:setRebirthNameStr()
    Logic:Get("Elite"):PostRecord()
  else
    self:setBattleNameStr()
    MsgBattle:Post("BEST_RECORD", {
      battleId = self.listData[self.listIdx]
    })
  end
end
function prototype:onBtnHero(sender, event)
  if self.record == nil or table.empty(self.record) then
    return
  end
  for i = 1, MAX_PLAYER do
    local str = string.format("btnHero%d", i)
    if self[str] and sender == self[str] then
      if self.record[i] == nil or table.empty(self.record[i]) then
        return
      end
      Logic:Get("Hero"):SetRankGroupInfo(self.record[i])
      SceneHelper:pushScene("DevilHeroGroupView", self.rootNode)
    end
  end
end
function prototype:onBtnFirstRecord(sender, event)
  SceneHelper:popScene()
end
function prototype:OnRecord()
  self:Clear()
  self:DisabledBtn()
  self.record = Logic:Get("Rebirth"):GetBestRecord()
  if self.record == nil or table.empty(self.record) then
    return
  end
  for i, v in ipairs(self.record) do
    self:InitPlayers(v, i)
  end
end
function prototype:OnBestRecord()
  self:Clear()
  self:DisabledBtn()
  self.record = Logic:Get("Battle"):GetBestRecord()
  if self.record == nil or table.empty(self.record) then
    return
  end
  for i, v in ipairs(self.record) do
    self:InitPlayers(v, i)
  end
end
function prototype:OnEliteRecord()
  self:OnRecord()
end
