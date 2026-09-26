module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local CARD_SIZE_WIDTH = 122
function prototype:onNodeLoaded(node, loader)
  local friendInfo = Logic:Get("BattleShow"):GetFriendInfo()
  if friendInfo == nil or friendInfo.name == nil then
    self:onBtnCancel()
    return
  end
  self:InitialString()
  self:SetBackGround()
  local bHasMaxFriends = Logic:Get("Friend"):IsFriendFull()
  if friendInfo.friend or bHasMaxFriends then
    self.mBtnCancel:setVisible(false)
    self.mBtnAdd:setVisible(false)
    self.mStaFriendTip:setVisible(false)
    self.mBtnOK:setVisible(true)
    self.mTitle:setString(TwGetStr(107004))
    if bHasMaxFriends then
      self:ShowFriendMaxTip()
    end
  end
  Logic:Get("Friend"):DeleteCommendFriend(friendInfo.id)
  self:SetFriendName(friendInfo.name)
  self:SetFriendLv(friendInfo.heroLevel)
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  self:SetTolFriendPoint(wallet[string.lower("FRIENDSHIP")])
  local costAndReward = Logic:Get("BattleShow"):GetCostAndReward()
  local pointItems = Logic:Get("Reward"):GetItemsByType(costAndReward.rewards, Logic.Reward.REWARDS_TYPE.CURRENCY, Logic.Reward.CURRENCY_TYPE.FRIENDSHIP)
  local points = Logic:Get("Reward"):CalcTotleNum(pointItems)
  self:SetCurFriendPoint(points)
  self:createHeroCard(friendInfo.baseId)
end
function prototype:InitialString()
  self.mTitle:setString(TwGetStr(107020))
  self.staYouqing:setString(TwGetStr(107021))
  self.staCurYouqing:setString(TwGetStr(107022))
  self.maxFriendPointTip:setString(TwGetStr(107023))
  self.mStaFriendTip:setString(TwGetStr(107024))
  local SetButtonString = function(ctrl, str)
    ctrl:setTitleForState(TwGetStr(str), CCControlStateNormal)
    ctrl:setTitleForState(TwGetStr(str), CCControlStateHighlighted)
    ctrl:setTitleForState(TwGetStr(str), CCControlStateDisabled)
  end
  SetButtonString(self.mBtnCancel, 107025)
  SetButtonString(self.mBtnAdd, 107026)
  SetButtonString(self.mBtnOK, 107027)
end
function prototype:ShowFriendMaxTip()
  self.mStaFriendTip:setString(TwGetStr(107032))
  self.mStaFriendTip:setVisible(true)
end
function prototype:SetBackGround()
  local bgSp = CCSprite:create("images/BattleShow/fightResult_bg.png")
  local bgTexture, bgTextureRect = Logic:Get("HeroCardInfo"):GetCardTexture(bgSp, nil, false, CCSize(640, 833))
  self.mSpBg:setTexture(bgTexture)
  self.mSpBg:setTextureRect(bgTextureRect)
end
function prototype:SetFriendName(name)
  self.friendName = name
  self.mStaName:setString(name)
end
function prototype:GetFriendName(name)
  return self.friendName
end
function prototype:SetFriendLv(lv)
  self.mStaLv:setString(TwGetStr(107003, lv))
end
function prototype:SetCurFriendPoint(pt)
  self.mStaCurFirPoint:setString(tostring(pt))
end
function prototype:SetTolFriendPoint(pt)
  self.mStaTolFirPoint:setString(tostring(pt))
  local config = KFDBGetRecord("ConfigValue", "BATTLE:FRIENDSHIP_LIMIT")
  local maxPt = config and config.content or 0
  self.maxFriendPointTip:setVisible(pt >= tonumber(maxPt))
end
function prototype:SetFriendExist(bExist)
  self.mBtnCancel:setVisible(not bExist)
end
function prototype:onBtnOK()
  self:onBtnCancel()
end
function prototype:onBtnCancel()
  SceneHelper:removeScene("BattleFriendAdd")
  Logic:Get("BattleShow"):BattleShowEnd()
end
function prototype:onBtnClose()
end
function prototype:onBtnAdd()
  local name = self:GetFriendName()
  Logic:Get("Friend"):SendMsgAddFriend(name)
  self:onBtnCancel()
end
function prototype:createHeroCard(baseId)
  if baseId == nil then
    return
  end
  local node = Logic:Get("HeroCardInfo"):createHeroCard(baseId, CARD_SIZE_WIDTH)
  if node == nil then
    return
  end
  local cardSz = node:getContentSize()
  node:setScale(1 * (CARD_SIZE_WIDTH / cardSz.width))
  node:setAnchorPoint(CCPoint(0.5, 0.5))
  self.rootNode:addChild(node)
  node:setPosition(self.imgHeroIcon:getPosition())
end
