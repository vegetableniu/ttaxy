module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
REWARDS_TYPE = TypeDef("com.eyu.mt.module.reward.model.RewardType")
function class:initialize()
  super.initialize(self)
  self.shareContent = ""
  self.shareCbbBool = false
  self.lotteryNum = 1
  self.ShareBOOL_TWO = false
end
function class:SetShareFriendContent(shareContent)
  self.shareContent = shareContent
end
function class:GetShareFriendContent()
  return self.shareContent
end
function class:SetShareCbbBool(shareCbbBool)
  self.shareCbbBool = shareCbbBool
end
function class:GetShareCbbBool()
  return self.shareCbbBool
end
function class:ShareFriend(strCBB, rewards)
  do return end
  local sysBool = Logic:Get("System"):IsOpenFaceBook()
  if not sysBool then
    return
  end
  self.ShareBOOL_TWO = false
  self:IsOpenShareCBB(strCBB, rewards)
end
function class:IsOpenShareCBB(strCBB, rewards)
  if strCBB == nil or strCBB == "" or rewards == nil then
    return
  end
  if strCBB == "Lottery" then
    self:Lottery(rewards)
  elseif strCBB == "Compose" then
    self:Compose(rewards)
  elseif strCBB == "Battle" then
    self:Battle(rewards)
  elseif strCBB == "Draw" then
    self:Draw(rewards)
  end
end
function class:Lottery(rewards)
  local shareBOOL = false
  local strContents = ""
  for _, reward in ipairs(rewards) do
    if reward.type == "HERO" or reward.type == REWARDS_TYPE.HERO then
      local heroInfo = KFDBGetRecord("BaseHero", reward.code)
      shareBOOL = self:ISrewardCanShare(heroInfo)
      if shareBOOL and self.lotteryNum > 0 then
        local strReward = Logic:Get("Reward"):RewardTreaTip(reward)
        strContents = strContents .. strReward .. ","
        self:SetShareCbbBool(shareBOOL)
        self.ShareBOOL_TWO = true
      end
    end
  end
  if strContents ~= "" then
    self.shareContent = strContents
  end
  if self.ShareBOOL_TWO then
    local strContent = TwGetStr(103314)
    self.shareContent = string.gsub(strContent, "GIFT", self.shareContent)
  end
end
function class:Compose(rewards)
  self.shareContent = ""
  local shareBOOL = false
  for _, reward in ipairs(rewards) do
    if reward.type == "HERO" or reward.type == REWARDS_TYPE.HERO then
      local heroInfo = KFDBGetRecord("BaseHero", reward.code)
      shareBOOL = self:ISrewardCanShare(heroInfo)
      if shareBOOL then
        local strReward = Logic:Get("Reward"):RewardTreaTip(reward)
        self.shareContent = self.shareContent .. strReward .. ","
        self:SetShareCbbBool(shareBOOL)
      end
    end
  end
  local strContent = TwGetStr(103314)
  self.shareContent = string.gsub(strContent, "GIFT", self.shareContent)
end
function class:Battle(rewards)
  self.shareContent = ""
  local shareBOOL = false
  for _, reward in ipairs(rewards) do
    if reward.type == "HERO" or reward.type == REWARDS_TYPE.HERO then
      local heroInfo = KFDBGetRecord("BaseHero", reward.code)
      shareBOOL = self:ISrewardCanShare(heroInfo)
      if shareBOOL then
        local strReward = Logic:Get("Reward"):RewardTreaTip(reward)
        self.shareContent = self.shareContent .. strReward .. ","
        self:SetShareCbbBool(shareBOOL)
      end
    end
  end
  local strContent = TwGetStr(103314)
  self.shareContent = string.gsub(strContent, "GIFT", self.shareContent)
end
function class:Draw(rewards)
  self.shareContent = ""
  local shareBOOL = false
  for _, reward in ipairs(rewards) do
    if reward.type == REWARDS_TYPE.CURRENCY or reward.type == "CURRENCY" then
      local ItemType = TypeDef("com.eyu.mt.module.currency.model.CurrencyType")
      if reward.code == ItemType.GOLD or reward.code == ItemType.GIFT or reward.code == ItemType.INTER then
        self:SetShareCbbBool(true)
      end
    end
  end
  self.shareContent = TwGetStr(103316)
end
function class:ISrewardCanShare(heroInfo)
  if heroInfo ~= nil and heroInfo.card == "HERO" then
    local statKB = 7
    local rankKB = 4
    if statKB <= heroInfo.star or rankKB <= heroInfo.rank then
      return true
    end
  end
  return false
end
function class:OpenFaceBook()
  do return end
  local sysBool = Logic:Get("System"):IsOpenFaceBook()
  if not sysBool then
    return
  end
  if self.shareCbbBool then
    if self.ShareBOOL_TWO and self.lotteryNum > 0 then
      self.lotteryNum = self.lotteryNum - 1
    end
    self.shareCbbBool = false
    SceneHelper:pushPrompt("FacebookTip", nil)
  end
end
