module((...), package.seeall)
require("Logic")
require("Logic.Reward")
require("SceneHelper")
class = Logic.class:subclass()
EVT = Enum({
  "SHARE",
  "ROULETTE_LEFT",
  "ROULETTE"
})
local TYPE = {
  PURPLE_CARD = 1020,
  SHINING_CARD = 1021,
  TALISMAN = 1024,
  LEVEL_UP = 1025,
  RANK_UP = 1026,
  DEFAULT = 1027,
  F_CODE = 1029,
  PHONE_FEE = 1030,
  XIAOMI_DEFAULT = 1032
}
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.platform.facade.PlatformResult"))
local MSG_RESULT_STR = {
  ROULETTE_TIME_LIMIT = 110712,
  ROULETTE_TIMES_LIMIT = 110711,
  SHARE_TIME_LIMIT = 110708,
  OPRATOR_LIMIT = 110709,
  PASSIVE_SHARE_LIMIT = 110705,
  INITIATIVE_SHARE_LIMIT = 110704,
  TODAY_HAS_DRAW = 110703
}
function class:initialize()
  super.initialize(self)
  self.contentStr = nil
  self.bShowPrompt = false
  self.promptType = "DEFAULT"
  self.bFirstShare = false
  self.bInitiativeShare = false
  self.initiativeCnt = 0
  self.passiveCnt = 0
  self.leftDrawTime = 0
  self.drawId = 0
  self.records = {}
  self.bDrawFCode = false
  self.shareDay = Logic:Get("System"):GetTimeDate()
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgPlatform", MSG_RESULT, MSG_RESULT_STR)
  MsgPlatform:On("INITIATIVE_SHARE", self:Event("OnInitiativeShare"))
  MsgPlatform:On("PASSIVE_SHARE", self:Event("OnPassiveShare"))
  MsgPlatform:On("GET_COMMON_INFO", self:Event("OnRouletteLeft"))
  MsgPlatform:On("ROULETTE", self:Event("OnRoulette"))
end
function class:OnReset()
end
function class:InitPlatformInfo(data)
  if table.empty(data or {}) then
    return
  end
  self.bFirstShare = data.firstShare
  self.initiativeCnt = data.initiativeCount
  self.passiveCnt = data.passiveCount
  self.shareDay = Logic:Get("System"):GetTimeDate()
end
function class:SetShowPrompt(bShowPrompt)
  self.bShowPrompt = bShowPrompt
end
function class:GetContentStr()
  return self.contentStr or ""
end
function class:GetLeftDrawTime()
  return self.leftDrawTime or 0
end
function class:GetRecord()
  return self.records
end
function class:GetDrawPos()
  local rec = KFDBGetRecord("WechatRoulette", self.drawId)
  return rec and rec.position or 0
end
function class:GetDrawData()
  local rec = KFDBGetRecord("WechatRoulette", self.drawId)
  return rec
end
function class:PromptRewards()
  if self.rewardsStr and "" ~= self.rewardsStr then
    Prompt:Fail(self.rewardsStr)
  end
end
function class:IsActivityPlatform()
  local rec = KFDBGetRecord("ConfigValue", "PLATFORM:WEBCHAT_SHARE_OPRATOR_ID") or {}
  local data = json.decode(rec.content or "[]")
  local operatorId = tonumber(Logic:Get("System"):GetOperatorId())
  for k, v in pairs(data or {}) do
    if operatorId == v then
      return true
    end
  end
  return false
end
function class:IsOpenWeChatShare()
  if not self:IsActivityPlatform() then
    return false
  end
  if self:IsActiveOver() then
    return false
  end
  return true
end
function class:IsInitiativeShare()
  return self.bInitiativeShare
end
function class:ResetTimes()
  local currTime = Logic:Get("System"):GetTimeDate()
  if currTime.day == self.shareDay.day then
    return
  end
  self.initiativeCnt = 0
  self.passiveCnt = 0
  self.shareDay = Logic:Get("System"):GetTimeDate()
end
function class:IsOverLimit()
  local initMax = Logic:Get("Egg"):GetCongifValueByKey("PLATFORM:INITIATIVE_SHARE_COUNT")
  return initMax <= self.initiativeCnt
end
function class:IsActiveOver()
  local rec = KFDBGetRecord("ConfigValue", "PLATFORM:WEBCHAT_SHARE_START_TIME") or {}
  local time = Logic:Get("Mall"):GetItemTime(rec.content)
  if table.empty(time) then
    return true
  end
  time = os.time(time)
  if not time or Logic:Get("System"):DiffTime(time) > 0 then
    return true
  end
  rec = KFDBGetRecord("ConfigValue", "PLATFORM:WEBCHAT_SHARE_END_TIME") or {}
  time = Logic:Get("Mall"):GetItemTime(rec.content)
  if table.empty(time) then
    return false
  end
  time = os.time(time)
  if not time or Logic:Get("System"):DiffTime(time) < 0 then
    return true
  end
  return false
end
function class:IsFcodeActivityOver()
  local rec = KFDBGetRecord("ConfigValue", "PLATFORM:WECHAT_FCODE_START_TIME") or {}
  local time = Logic:Get("Mall"):GetItemTime(rec.content)
  if table.empty(time) then
    return false
  end
  time = os.time(time)
  if not time or Logic:Get("System"):DiffTime(time) > 0 then
    return true
  end
  rec = KFDBGetRecord("ConfigValue", "PLATFORM:WECHAT_FCODE_END_TIME") or {}
  time = Logic:Get("Mall"):GetItemTime(rec.content)
  if table.empty(time) then
    return false
  end
  time = os.time(time)
  if not time or Logic:Get("System"):DiffTime(time) < 0 then
    return true
  end
  return false
end
function class:GetWeChatUrl()
  return Logic:Get("System"):GetOperatorItemFromFile("weChatUrl", "config.dat")
end
function class:Compose(rewards)
  self:checkRewards(rewards, "WECHAT:ORANGE_CARD", "SHINING_CARD")
end
function class:FragmentExchange(rewards)
  self:checkRewards(rewards, "WECHAT:SHINING_CARD", "SHINING_CARD")
end
function class:Lottery(rewards)
  self:checkRewards(rewards, "WECHAT:SHINING_CARD", "SHINING_CARD")
end
function class:RankUp(hero)
  local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
  local rec = KFDBGetRecord("ConfigValue", "WECHAT:RANK_UP") or {}
  local tab = json.decode(rec.content or "[]") or {}
  for k, v in pairs(tab) do
    if "HERO" == heroInfo.card and heroInfo.star == v.star and heroInfo.rank >= v.rank then
      self.promptType = "RANK_UP"
      self.bShowPrompt = true
      return
    end
  end
end
function class:LevelUp()
  local level = Logic:Get("PlayerInfo"):GetPlayerLevel()
  local rec = KFDBGetRecord("ConfigValue", "WECHAT:LEVEL_UP") or {}
  local tab = json.decode(rec.content or "[]") or {}
  for k, v in pairs(tab) do
    if level == v then
      self.promptType = "LEVEL_UP"
      self.bShowPrompt = true
      return
    end
  end
end
function class:Tailisman(rewards)
  for _, reward in pairs(rewards or {}) do
    if reward.type == "TALISMAN" or reward.type == Logic.Reward.REWARDS_TYPE.TALISMAN then
      local talismanInfo = KFDBGetRecord("TalismanSetting", reward.code)
      local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(talismanInfo.baseId)
      if self:checkCardRank(heroInfo, "WECHAT:TALISMAN") then
        self.promptType = "TALISMAN"
        self.bShowPrompt = true
        return
      end
    end
  end
end
function class:FCode()
  if self.bDrawFCode then
    self.promptType = "F_CODE"
    self.bShowPrompt = true
  end
end
function class:PhoneFee()
  self.promptType = "PHONE_FEE"
  self.bShowPrompt = true
end
function class:checkRewards(rewards, keyId, promptType)
  for _, reward in pairs(rewards or {}) do
    if reward.type == "HERO" or reward.type == Logic.Reward.REWARDS_TYPE.HERO then
      local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(reward.code)
      if self:checkCardRank(heroInfo, keyId) then
        self.promptType = promptType
        self.bShowPrompt = true
        return
      end
    end
  end
end
function class:checkCardRank(heroInfo, keyId)
  local rec = KFDBGetRecord("ConfigValue", keyId) or {}
  local tab = json.decode(rec.content or "[]") or {}
  return heroInfo.star >= tab.star and heroInfo.rank >= tab.rank
end
function class:OpenWeChat(promptType)
  local strType = promptType and promptType or self.promptType
  if not self.bShowPrompt then
    return
  end
  self.bShowPrompt = false
  self.promptType = "DEFAULT"
  self.bDrawFCode = false
  if not self:IsOpenWeChatShare() then
    return
  end
  if not strType or strType == "DEFAULT" then
    self.bInitiativeShare = true
    local bXiaoMi = Logic:Get("System"):IsOperator("xiaomiapk")
    if not bXiaoMi or not self:GetStrByType("XIAOMI_DEFAULT") then
    end
    self.contentStr = self:GetStrByType()
    self:PushShareUI()
    return
  end
  self.bInitiativeShare = false
  if self:IsOverLimit() then
    return
  end
  if strType == "LEVEL_UP" then
    local str = self:GetStrByType(strType)
    local level = Logic:Get("PlayerInfo"):GetPlayerLevel()
    self.contentStr = string.format(str, level)
    self:PushShareUI()
    return
  end
  if TYPE[strType] then
    self.contentStr = self:GetStrByType(strType)
    self:PushShareUI()
  end
end
function class:PushShareUI()
  if not SceneHelper:isExistPrompt("WeChat") then
    SceneHelper:pushPrompt("WeChat")
  end
end
function class:GetStrByType(type)
  local id = TYPE[type] and TYPE[type] or TYPE.DEFAULT
  local rec = KFDBGetRecord("LanguageSetting", id) or {}
  local str = ReplaceStringTab(rec.content) or ""
  local str = rec.content or ""
  return str
end
function class:OpenLottery()
  SceneHelper:pushScene("WeChatLottery")
end
function class:PostShare()
  MsgPlatform:Post("INITIATIVE_SHARE")
end
function class:PostRouletteLeft()
  MsgPlatform:Post("GET_COMMON_INFO")
end
function class:PostRoulette()
  MsgPlatform:Post("ROULETTE")
end
function class:OnInitiativeShare(code, data)
  if code ~= 0 then
    return
  end
  self.bFirstShare = false
  self.initiativeCnt = self.initiativeCnt + 1
  self.leftDrawTime = data.lotteryTimes
  if 0 < self.leftDrawTime then
    self:OpenLottery()
    return
  end
  if table.empty(data.rewardResults or {}) then
    Prompt:Msg(110702)
    return
  end
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  local str = Logic:Get("Reward"):AddRewardsTip(data.rewardResults)
  Prompt:Msg(str)
end
function class:OnPassiveShare(code, data)
  if code ~= 0 then
    return
  end
  self.bFirstShare = false
  self.passiveCnt = self.passiveCnt + 1
  if 0 < self.leftDrawTime then
    self:OpenLottery()
    return
  end
  Prompt:Msg(110702)
end
function class:OnRouletteLeft(code, data)
  if code ~= 0 then
    return
  end
  self.leftDrawTime = data.lotteryTimes and data.lotteryTimes or self.leftDrawTime
  self.records = {}
  for k, v in pairs(data.fcode or {}) do
    table.insert(self.records, v)
  end
  for k, v in pairs(data.common or {}) do
    table.insert(self.records, v)
  end
  self:FireEvent(EVT.ROULETTE_LEFT)
end
function class:OnRoulette(code, data)
  if code ~= 0 then
    return
  end
  self.drawId = data.id
  self.leftDrawTime = self.leftDrawTime - 1
  self:FireEvent(EVT.ROULETTE)
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  local recData = self:GetDrawData()
  self.rewardsStr = TwGetStr(103080) .. " " .. recData.name
  if recData and recData.showType == "REAL_GOODS" then
    self.bDrawFCode = true
    self.rewardsStr = self.rewardsStr .. "\n" .. TwGetStr(110715)
  end
end
