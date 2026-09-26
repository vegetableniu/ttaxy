module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({
  "GET_REWARD_LIST_SUCCESSED",
  "GET_REWARD_LIST_FAILED",
  "GET_INVITE_CODE_SUCCESSED",
  "GET_INVITE_CODE_FAILED",
  "ADD_INVITE_CODE_SUCCESSED",
  "ADD_INVITE_CODE_FAILED"
})
function class:initialize()
  super.initialize(self)
  self.send = false
  self.rewardList = {}
  MsgInvite:On("REWARD_LIST", self:Event("OnGetRewardList"), false)
  MsgInvite:On("CHAECK_INVITE_CODE", self:Event("OnCHAECK_INVITE_CODE"), false)
  MsgInvite:On("ADD_INVITE_CODE", self:Event("OnADD_INVITE_CODE"), false)
end
function class:OnReset()
end
function class:isSend()
  return self.send
end
function class:setSend(flag)
  if flag then
    self.send = flag
  end
end
function class:InviteSuccess()
  Prompt:Fail(TwGetStr(105110))
end
function class:InviteFail()
  Prompt:Fail(TwGetStr(101050))
end
function class:PostGetRewardList()
  MsgInvite:Post("REWARD_LIST")
end
function class:PostCheckInviteCode(code)
  if code then
    MsgInvite:Post("CHAECK_INVITE_CODE", {invite = code})
  end
end
function class:PostaddInviteCode(code)
  if code then
    MsgInvite:Post("ADD_INVITE_CODE", {invite = code})
  end
end
function class:OnGetRewardList(code, content)
  if 0 == code and content then
    self:SetRewardList(content)
    self:FireEvent(EVT.GET_REWARD_LIST_SUCCESSED)
  else
    self:FireEvent(EVT.GET_REWARD_LIST_FAILED, code)
  end
end
function class:OnCHAECK_INVITE_CODE(code, content)
  if 0 == code and nil ~= content then
    self:FireEvent(EVT.GET_INVITE_CODE_SUCCESSED, content)
  else
    self:FireEvent(EVT.GET_INVITE_CODE_FAILED, code)
  end
end
function class:OnADD_INVITE_CODE(code, content)
  if 0 == code and content then
    self:FireEvent(EVT.ADD_INVITE_CODE_SUCCESSED, content)
  else
    self:FireEvent(EVT.ADD_INVITE_CODE_FAILED, code)
  end
end
function class:GetRewardList()
  return self.rewardList
end
function class:SetRewardList(data)
  self.rewardList = data
end
