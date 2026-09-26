module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local STAR_PATH = "images/Fight/star.png"
local BG_PATH = {
  WHITE = "images/Fight/whiteRank.png",
  GREEN = "images/Fight/greenRank.png",
  BLUE = "images/Fight/blueRank.png",
  PURPLE = "images/Fight/purpleRank.png"
}
function prototype:initialize(...)
  super.initialize(self, ...)
  self.data = {}
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfBattleEffect:setStyle(kCCLabelTTFStyleOutline)
  self.ttfBattleNum:setStyle(kCCLabelTTFStyleOutline)
  self.ttfSocialStatus:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLevel:setStyle(kCCLabelTTFStyleOutline)
  self.ttfRewardNum:setStyle(kCCLabelTTFStyleOutline)
  self.ttfReward:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCost:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:ReFrashFighterInfo(pNodeData)
  if pNodeData and next(pNodeData) then
    self.data = pNodeData
    if self.data.id == ID[-1] then
      self.data.name = Logic:Get("Fight"):GetRobotName()
    end
    self:initFightInfo()
  end
end
function prototype:onBtnItemClicked(sender, event)
  if self.data.state then
    return
  end
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
  local fightTimes = Logic:Get("Fight"):GetFightTimes()
  if fightTimes <= 0 then
    SceneHelper:pushPrompt("FightPvpTip", self.rootNode)
    return
  end
  Logic:Get("Guide"):done("FightPVP", "Select")
  Logic:Get("Fight"):SetFighter(self.data)
  Logic:Get("Fight"):isClickStore(false)
  Logic:Get("Battle"):SetEmBattleType(Logic.Battle.BATTLE_TYPE.ARENA)
  SceneHelper:pushScene("EmbattleGroup", self.rootNode)
end
function prototype:initFightInfo()
  local leaderStars = self.data.star or 1
  local iconPath = Logic:Get("Hero"):GetHeroImage(self.data.leaderBaseId)
  local spriteIcon = CCSprite:create(iconPath)
  if spriteIcon then
    self.fighterIcon:setDisplayFrame(spriteIcon:displayFrame())
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.fighterIcon, self.data.leaderBaseId)
  local bgPath
  if leaderStars == 1 then
    bgPath = BG_PATH.WHITE
  elseif leaderStars == 2 then
    bgPath = BG_PATH.GREEN
  elseif leaderStars > 2 and leaderStars < 5 then
    bgPath = BG_PATH.BLUE
  elseif leaderStars >= 5 then
    bgPath = BG_PATH.PURPLE
  end
  local sprBg = CCSprite:create(bgPath)
  if sprBg then
    self.sprBg:setDisplayFrame(sprBg:displayFrame())
  end
  self:createStar(leaderStars)
  self.sprFra:setVisible(self.data.carry or false)
  self.ttfName:setString(self.data.name)
  self.ttfLevel:setString(TwGetStr(105311, self.data.level))
  self.ttfBattleEffect:setString(TwGetStr(105312))
  self.ttfBattleNum:setString(self.data.battleEffect)
  self.ttfSocialStatus:setString(TwGetStr(105334))
  self.ttfRewardNum:setString(TwGetStr(105335, self.data.socialStatus))
  local x = self.ttfRewardNum:getPositionX() + self.ttfRewardNum:getContentSize().width
  local y = self.ttfRewardNum:getPositionY()
  self.ttfReward:setPosition(ccp(x, y))
  self.ttfReward:setString(TwGetStr(105336))
  if self.data.state then
    self.ttfCost:setVisible(false)
    self.spriteKo:setVisible(true)
    self.spriteBattle:setVisible(false)
  else
    self.ttfCost:setVisible(true)
    self.spriteKo:setVisible(false)
    self.spriteBattle:setVisible(true)
  end
end
function prototype:createStar(num)
  local tag = 100
  local starNum = num >= 5 and 5 or num
  for i = 2, 5 do
    local starChild = self.layer:getChildByTag(tag - i)
    if starChild ~= nil then
      self.layer:removeChildByTag(tag - i, true)
    end
  end
  for i = 2, starNum do
    local sprStar = CCSprite:create(STAR_PATH)
    if sprStar then
      sprStar:setAnchorPoint(CCPoint(0.5, 0.5))
      local x = self.sprStar:getPositionX() + (self.sprStar:getContentSize().width + 10) * (i - 1)
      local y = self.sprStar:getPositionY()
      sprStar:setPosition(CCPoint(x, y))
      self.layer:addChild(sprStar, 5, tag - i)
    end
  end
end
function prototype:updateGuide()
  if Logic:Get("Guide"):isActive("FightPVP", "Select") then
    local fightInfo = Logic:Get("Fight"):GetMatchList()
    if fightInfo[1].id == self.data.id then
      Logic:Get("Fight"):setGuideFightDraw(true)
      Logic:Get("Guide"):lockTouch(self.btnItem)
    end
  end
end
function prototype:confirmBuy()
  local buyTimes = Logic:Get("Fight"):GetLeaveBuyTimes()
  if buyTimes > 0 then
    SceneHelper:pushPrompt("FightPvpTip", self.rootNode)
  else
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    local str = TwGetStr(10078) .. "\n" .. TwGetStr(105321)
    Prompt:Confirm(Logic:Get("Main"), "", str, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
  end
end
