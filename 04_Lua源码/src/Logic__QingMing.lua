module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({
  "GET_JIBAI_PAGE",
  "JIBAI",
  "PROMPT_END"
})
local ERROR_CODE = TypeDef("com.eyu.mt.module.qingming.facade.QingmingResult")
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.qingming.facade.QingmingResult"))
local MSG_RESULT_STR = {
  CURRENCY_NOT_ENOUGH = 10036,
  JIPING_NOT_ENOUGH = 110758,
  ACTIVITY_CLOSED = 111042
}
function class:initialize()
  super.initialize(self)
  self.jibaiCnt = 0
  self.jiping = 0
  self.pondId = 0
  self.score = 0
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgQingming", MSG_RESULT, MSG_RESULT_STR)
  MsgQingming:On("GET_INFO", self:Event("OnGetInfo"))
  MsgQingming:On("JIBAI", self:Event("OnJiBai"))
  MsgQingming:On("GET_JIBAI_PAGE", self:Event("OnGetJibaiPage"))
end
function class:dispose()
  super.dispose(self)
end
function class:GetJiPing()
  return self.jiping
end
function class:GetScore()
  return self.score
end
function class:AddJiping(amount)
  self.jiping = amount and amount or self.jiping
end
function class:GetRewardList()
  local list = {}
  local playerLv = Logic:Get("PlayerInfo"):GetPlayerLevel()
  local function IsMatched(rec)
    if rec.pondId ~= self.pondId then
      return false
    end
    if playerLv < rec.lowLevel then
      return false
    end
    if playerLv > rec.highLevel then
      return false
    end
    return true
  end
  for i = 1, KFDBGetRecordAmt("QingmingReward") do
    local rec = KFDBGetRecordByIdx("QingmingReward", i)
    if rec and IsMatched(rec) then
      table.insert(list, rec)
    end
  end
  table.sort(list, function(a, b)
    return a.sort > b.sort
  end)
  return list
end
function class:GetCurrRankRecord()
  return KFDBGetRecord("QingmingPond", self.pondId)
end
function class:GetNextIdx()
  local rec = self:GetCurrRankRecord()
  if not rec then
    return
  end
  local timesTab = json.decode(rec.jibaiCounts or "[]") or {}
  local idx
  for i, v in ipairs(timesTab) do
    if v >= self.jibaiCnt then
      idx = i
      return idx
    end
  end
  return idx
end
function class:GetNextCost()
  local rec = self:GetCurrRankRecord()
  if not rec then
    return 0
  end
  local costTab = json.decode(rec.jipingCosts or "[]") or {}
  local idx = self:GetNextIdx()
  if idx and costTab[idx] then
    return costTab[idx]
  end
  return 0
end
function class:GetNextScore()
  local rec = self:GetCurrRankRecord()
  if not rec then
    return 0
  end
  local scoreTab = json.decode(rec.scores or "[]") or {}
  local idx = self:GetNextIdx()
  if idx and scoreTab[idx] then
    return scoreTab[idx]
  end
  return 0
end
function class:ShowRewardTip()
  if self.rewardStr then
    Prompt:Confirm(self, "", self.rewardStr, self.changeUI, Prompt.PROMPT_TYPE.CONFIRM)
  end
end
function class:changeUI()
  if self.bShowUpdateAni then
    self:FireEvent(EVT.PROMPT_END)
    return
  end
  self:FireEvent(EVT.GET_JIBAI_PAGE)
end
function class:SetData(data)
  self.jibaiCnt = data.jibaiCount or self.jibaiCnt
  self.jiping = data.jiping or self.jiping
  self.pondId = data.pondId or self.pondId
  self.score = data.score or self.score
end
function class:PostGetInfo()
  MsgQingming:Post("GET_INFO")
end
function class:PostJiBai()
  MsgQingming:Post("JIBAI")
end
function class:PostGetJibaiPage()
  MsgQingming:Post("GET_JIBAI_PAGE")
end
function class:OnGetInfo(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("GiftRank"):SetRankData(data)
  Logic:Get("GiftRank"):FireEvent(Logic.GiftRank.EVT.GET_INFO)
end
function class:OnJiBai(code, data)
  if code ~= 0 then
    return
  end
  if table.empty(data or {}) then
    return
  end
  self.rewardStr = nil
  self.bShowUpdateAni = data.pageVo and data.pageVo.pondId > self.pondId
  if self.bShowUpdateAni then
    self.rewardStr = TwGetStr(110759)
  else
    self.rewardStr = TwGetStr(110762)
  end
  Logic:Get("Reward"):AddRewards(data.rewards)
  self.rewardStr = self.rewardStr .. Logic:Get("Reward"):AddDupiTreaTip(data.rewards)
  self:SetData(data.pageVo or {})
  self:FireEvent(EVT.JIBAI)
end
function class:OnGetJibaiPage(code, data)
  if code ~= 0 then
    return
  end
  self:SetData(data)
  self:FireEvent(EVT.GET_JIBAI_PAGE)
end
