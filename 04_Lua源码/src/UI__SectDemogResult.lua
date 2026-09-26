module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local REWARDS_TYPE = TypeDef("com.eyu.mt.module.reward.model.RewardType")
function prototype:onEnter()
  self.ttfDamage:setString(TwGetStr(110059))
  self.ttfMoney:setString(TwGetStr(110060))
  self.ttfClick:setString(TwGetStr(105249))
  self.labTips:setStyle(kCCLabelTTFStyleOutline)
  self.labTips:setString("")
  self:SetBackGround()
  local damage = 0
  local money = 0
  local attackInfo = Logic:Get("Sect"):GetAttackInfo()
  if attackInfo then
    damage = attackInfo.demage
    local rewardsArr = attackInfo.rewardResult
    if rewardsArr then
      for i = 1, #rewardsArr do
        if rewardsArr[i].type == REWARDS_TYPE.CURRENCY then
          money = rewardsArr[i].amount
          break
        end
      end
    end
  end
  self.labDamage:create(0, "YELLOW_E_NUM")
  self.labDamage:setAlign("RIGHT", "CENTER")
  self.labDamage:setValue(damage)
  self.labMoney:create(0, "YELLOW_E_NUM")
  self.labMoney:setAlign("RIGHT", "CENTER")
  self.labMoney:setValue(money)
  if money == 0 then
    self.labTips:setString(TwGetStr(110080))
  end
end
function prototype:onBtnClose(sender, event)
end
function prototype:onBtnReturnClicked(sender, event)
  SceneHelper:runWithScene("SectDemogList", self.rootNode)
end
function prototype:SetBackGround()
  local bgSp = CCSprite:create("images/BattleShow/fightResult_bg.png")
  local bgTexture, bgTextureRect = Logic:Get("HeroCardInfo"):GetCardTexture(bgSp, nil, false, CCSize(640, 833))
  self.mSpBg:setTexture(bgTexture)
  self.mSpBg:setTextureRect(bgTextureRect)
end
