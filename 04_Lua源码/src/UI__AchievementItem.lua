module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local ID_SET = 100
local INIT_CHAPTER = 0
function prototype:onBtnCanDo(sender, event)
  if Logic:Get("Guide"):isActive("Achievement", "Draw") then
    Logic:Get("Guide"):done("Achievement", "Draw")
    Logic:Get("DramaTalk"):OnGuideTrigger(75)
  end
  if self.chapter and self.index then
    if self.index == 0 then
      Logic:Get("Achievement"):SendMsgDrawChapter(self.chapter)
    else
      Logic:Get("Achievement"):SendMsgDrawRewards(self.chapter, self.index)
    end
  end
end
function prototype:onEnter()
end
function prototype:ReFrashAchievementInfo(achievementInfo)
  local curPro = 0
  local curMax = 1
  local taskType = Logic:Get("Achievement"):GetMyAchieveInfo()
  self.staTaskTitle:setStyle(kCCLabelTTFStyleOutline)
  self.staTaskContent:setStyle(kCCLabelTTFStyleOutline)
  self.staTaskRewards:setStyle(kCCLabelTTFStyleOutline)
  self.staTaskPro:setStyle(kCCLabelTTFStyleOutline)
  if achievementInfo.recommend == 1 then
    self.btnCanDo:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/btnRecommendNormal.png"), CCControlStateNormal)
    self.btnCanDo:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/btnRecommendSelect.png"), CCControlStateHighlighted)
    self.btnCanDo:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/btnRecommendNormal.png"), CCControlStateDisabled)
  else
    self.btnCanDo:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/btnHeroFrameNormal.png"), CCControlStateNormal)
    self.btnCanDo:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/btnHeroFrameSelect.png"), CCControlStateHighlighted)
    self.btnCanDo:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/btnHeroFrameNormal.png"), CCControlStateDisabled)
  end
  self.imgbFinish:setVisible(false)
  self.staTaskPro:setVisible(false)
  self.btnCanDo:setEnabled(false)
  self.staTaskTitle:setString(achievementInfo.title or "")
  self.staTaskContent:setString(achievementInfo.content or "")
  local reward = Logic:Get("Reward"):kdbRewardConfig(achievementInfo.rewards)
  local rewardStr = ""
  if reward and not table.empty(reward) and reward.fixed then
    if reward.fixed[1] then
      if reward.fixed[1] and reward.fixed[1].type == "BUFF" then
        rewardStr = Logic:Get("Reward"):GetRewardsStr(reward.fixed[1])
      else
        for k, v in pairs(reward.fixed) do
          if rewardStr and rewardStr ~= "" then
            rewardStr = rewardStr .. ","
          end
          rewardStr = rewardStr .. Logic:Get("Reward"):GetRewardsStr(v)
        end
      end
    else
      rewardStr = Logic:Get("Reward"):GetRewardsStr(reward.fixed)
    end
  end
  self.staTaskRewards:setString(rewardStr)
  if achievementInfo and achievementInfo.statu then
    if achievementInfo.heroIconId == 0 then
      self.staTaskPro:setVisible(true)
      self.staTaskPro:setString(TwGetStr(102122, achievementInfo.prograss))
    end
    if achievementInfo.statu == Logic.Achievement.DRAW_TYPE.CAN_DRAW then
      self.btnCanDo:setEnabled(true)
    end
  end
  local typeImg = {
    "images/HeroCardInfo/notfount.png",
    "images/HeroCardInfo/gift_ing.png",
    "images/HeroCardInfo/gift_fin.png",
    "images/HeroCardInfo/complete.png"
  }
  if achievementInfo and achievementInfo.statu then
    local imgPath = typeImg[achievementInfo.statu + 1]
    local img = CCSprite:create(imgPath)
    if img then
      self.imgbFinish:setVisible(true)
      self.imgbFinish:setDisplayFrame(img:displayFrame())
    end
  end
  if achievementInfo and achievementInfo.heroIconId then
    if achievementInfo.heroIconId == 0 then
      self.m_pCHeroIcon:setVisible(false)
      self.imgChapter:setVisible(true)
      self.staTaskTitle:setColor(ccColor3B(175, 25, 175))
    else
      self.m_pCHeroIcon:setVisible(true)
      self.imgChapter:setVisible(false)
      self.m_pCHeroIcon:ReFrashHeroInfo(achievementInfo.heroIconId, true, "HERO")
      self.staTaskTitle:setColor(ccColor3B(255, 255, 255))
    end
  end
  self.chapter = achievementInfo.chapter
  self.index = achievementInfo.index
  self.m_pCHeroIcon.btnHeroIcon:setEnabled(true)
end
function prototype:updateGuide()
  if Logic:Get("Guide"):isActive("Achievement", "Draw") then
    self.m_pCHeroIcon.btnHeroIcon:setEnabled(false)
    Logic:Get("Guide"):lockTouch(self.btnCanDo)
  end
end
function prototype:coverZixia()
  Logic:Get("DramaControl"):setCoverUI(self.btnCanDo)
end
