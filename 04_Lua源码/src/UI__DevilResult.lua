module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
RET = Enum({"OK", "CANCEL"})
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  SceneHelper:removeScene("EmbattleGroup")
  Logic:Get("BattleShow"):CleanUp()
  local killed = Logic:Get("Devil"):isKilled()
  if killed then
    Logic:Get("Devil"):OnNewDemog()
  end
  self:SetBackGround()
  self.ttfPoints:setStyle(kCCLabelTTFStyleOutline)
  self.ttfDamage:setStyle(kCCLabelTTFStyleOutline)
  self.ttfRank:setStyle(kCCLabelTTFStyleOutline)
  self.ttfGroup:setStyle(kCCLabelTTFStyleOutline)
  self.ttfClick:setString(TwGetStr(105249))
  self.animationMgr:runAnimations("Default Timeline")
  self.ttfPoints:setString(TwGetStr(105510))
  self.ttfDamage:setString(TwGetStr(105511))
  local rank = Logic:Get("Devil"):getRank()
  if rank and rank > 0 then
    self.ttfRank:setString(TwGetStr(105530))
    self.nodeRank:create(0, "GREEN_NUM")
    self.nodeRank:setAlign("LEFT", "CENTER")
    self.nodeRank:setValue(rank)
  end
  local feat = Logic:Get("Devil"):getActFeat()
  if feat and feat >= 0 then
    self.nodeCoin:create(0, "YELLOW_E_NUM")
    self.nodeCoin:setAlign("RIGHT", "CENTER")
    self.nodeCoin:setValue(feat)
  end
  local damage = Logic:Get("Devil"):getActDamage()
  if damage and damage >= 0 then
    self.nodeExp:create(0, "YELLOW_E_NUM")
    self.nodeExp:setAlign("RIGHT", "CENTER")
    self.nodeExp:setValue(damage)
  end
  Logic:Get("Devil"):On(Logic.Devil.EVT.SHOW_DAMAGE_RANK, self:Event("onShowDamageRank"))
end
function prototype:onExit()
  Logic:Get("Devil"):FireEvent(Logic.Devil.EVT.PUSH_NEW_REWARD)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:SetBackGround()
  local bgSp = CCSprite:create("images/BattleShow/fightResult_bg.png")
  local bgTexture, bgTextureRect = Logic:Get("HeroCardInfo"):GetCardTexture(bgSp, nil, false, CCSize(640, 833))
  self.mSpBg:setTexture(bgTexture)
  self.mSpBg:setTextureRect(bgTextureRect)
end
function prototype:onBtnRankClicked()
  local rankData = Logic:Get("Devil"):getTotalDamageRank()
  if rankData == nil or table.empty(rankData) then
    Logic:Get("Devil"):PostTotalDamageRank()
  else
    SceneHelper:pushPrompt("DevilDamageTip", nil)
  end
end
function prototype:onBtnReturnClicked()
  local share = Logic:Get("Devil"):isFriendInvited()
  local kill = Logic:Get("Devil"):isKilled()
  Logic:Get("Devil"):clearTotalDamageData()
  if not share and not kill then
    Prompt:Select(self, "", TwGetStr(105528), self.onInviteFriend)
  else
    SceneHelper:popScene()
    if kill then
      local enterType = Logic:Get("Devil"):getEnterType()
      if enterType == Logic.Devil.ENTER_TYPE.BATTLE then
        SceneHelper:removeScene("DevilInfo")
      elseif enterType == Logic.Devil.ENTER_TYPE.DEVIL_LIST then
        SceneHelper:runWithScene("DevilMain", self.rootNode)
      end
    end
  end
end
function prototype:onShowDamageRank()
  SceneHelper:pushPrompt("DevilDamageTip", nil)
end
function prototype:onInviteFriend(clickType)
  if clickType == RET.OK then
    Logic:Get("Devil"):PostInviteFriendAttack()
  end
  SceneHelper:popScene()
end
function prototype:bindAnimationMgr()
  return true
end
