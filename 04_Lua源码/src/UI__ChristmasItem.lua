module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
TASK_TANK_MAX = 5
REVEICE_PATH = "images/Christmas/reveice_task.png"
ACHIEVE_PATH = "images/Christmas/achieve.png"
function prototype:onEnter()
  super.onEnter(self)
  self:setOutline()
  self.canDraw = false
end
function prototype:setOutline()
  local ttfList = {
    "ttfGiftInfo",
    "ttfGain",
    "ttfProgress",
    "taskRankTitle"
  }
  for i = 1, #ttfList do
    self[ttfList[i]]:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  end
end
function prototype:reFrashInfo(titleInfo)
  self.id = titleInfo
  self.info = KFDBGetRecord("TaskSetting", titleInfo)
  if self.info == nil then
    return
  end
  local proNum = Logic:Get("ChristmasActivity"):getTargetValuesById(self.info.targetType, self.id)
  self:setBtnPromptlyAchieve(true)
  local flagReveiced = Logic:Get("ChristmasActivity"):IsReceivedTask(self.id)
  if flagReveiced then
    self:setSprByPath(ACHIEVE_PATH)
    self:setBtnGiveUpVisible(true)
  else
    self:setSprByPath(REVEICE_PATH)
    self:setBtnGiveUpVisible(false)
  end
  self.btnGain:setEnabled(false)
  if flagReveiced and (proNum >= self.info.target or self:IsInCanDirectGetReward(titleInfo)) then
    self.canDraw = true
    self:setBtnPromptlyAchieve(false)
    self:setBtnGiveUpVisible(false)
    self.btnGain:setEnabled(true)
    if not (proNum >= self.info.target) or not proNum then
      proNum = self.info.target
    end
  end
  self:setTitleInfo(self.info.name, self.info.desc, TwGetStr(106220, proNum, self.info.target))
  self:setStar(self.info.star, TwGetStr(106221))
  self:createImg(self.info)
  self:createProgress(self.info)
end
function prototype:setBtnGiveUpVisible(flag)
  self.btnGiveUp:setEnabled(flag)
  self.giveUpImg:setVisible(flag)
  self.giveUpBgImg:setVisible(flag)
end
function prototype:setSprByPath(path)
  local spr = CCSprite:create(path)
  if spr == nil then
    return
  end
  self.promptlyImg:setDisplayFrame(spr:displayFrame())
end
function prototype:IsInCanDirectGetReward(id)
  local canDirectGetRewardList = Logic:Get("ChristmasActivity"):getCanDirectGetRewardTasks()
  for i = 1, #canDirectGetRewardList do
    if id == canDirectGetRewardList[i] then
      return true
    end
  end
  return false
end
function prototype:setTitleInfo(giftInfoStr, gainStr, progressStr)
  self.ttfGiftInfo:setString(giftInfoStr)
  self.ttfGain:setString(gainStr)
  self.ttfProgress:setString(progressStr)
end
function prototype:setBtnPromptlyAchieve(flag)
  self.promptlyImg:setVisible(flag)
  self.achieveBgImg:setVisible(flag)
  self.btnPromptlyAchieve:setVisible(flag)
end
function prototype:setStar(taskRankNum, taskRankStr)
  local starList = {
    "starOne",
    "starTwo",
    "starThree",
    "starFour",
    "starFive"
  }
  local ttfColor = {
    ccc3(42, 255, 90),
    ccc3(42, 255, 90),
    ccc3(42, 255, 90),
    ccc3(42, 255, 90),
    ccc3(42, 255, 90)
  }
  self.taskRankTitle:setString(taskRankStr)
  self.taskRankTitle:setColor(ttfColor[taskRankNum])
  for i = 1, #starList do
    if taskRankNum < i then
      self[starList[i]]:setVisible(false)
    end
  end
end
function prototype:createImg(giftInfo)
  giftInfo.description = {
    showType = giftInfo.showtype,
    showId = giftInfo.showid
  }
  local spr = Logic:Get("Gift"):createImg(giftInfo.description)
  if spr ~= nil then
    self.sprHeroHead:setDisplayFrame(spr:displayFrame())
    local strGoods, retBaseId, bIsFragment = Logic:Get("Gift"):createGoodsImg(giftInfo.description)
    if strGoods ~= nil then
      self.goodsImg:setDisplayFrame(strGoods:displayFrame())
      Logic:Get("HeroCardInfo"):AddShanCardSmall(self.goodsImg, retBaseId, nil, bIsFragment)
    end
    local sprFra = CCSprite:create("images/public/clarity80.png")
    self.sprCompose:setDisplayFrame(sprFra:displayFrame())
    if bIsFragment then
      local sprFra = Logic:Get("Compose"):GetJigsawImg()
      self.sprCompose:setDisplayFrame(sprFra:displayFrame())
    end
  end
end
function prototype:createProgress(giftInfo)
  local str = ""
  if self.canDraw then
    str = "images/HeroCardInfo/gift_fin.png"
  else
    str = "images/public/clarity05.png"
  end
  local spr = CCSprite:create(str)
  spr:setAnchorPoint(CCPoint(0, 0))
  self.sprFinish:setDisplayFrame(spr:displayFrame())
  self.sprFinish:setAnchorPoint(CCPoint(0.5, 0.5))
end
function prototype:onBtnGain(sender, event)
  Logic:Get("ChristmasActivity"):PostGetRewardMsg(self.id)
end
function prototype:getCostGoldByBuyTask()
  local buyTime = Logic:Get("ChristmasActivity"):getBuyTaskTimes()
  local info = KFDBGetRecord("ComTimesCost", buyTime)
  if info == nil then
    return 0
  end
  return info.cost
end
function prototype:buyTask()
  local buyTimes = Logic:Get("ChristmasActivity"):getBuyTaskTimes()
  local maxBuyTimes = Logic:Get("Box"):GetMaxOpenTime("TASK_MAX_COMPLETE_TIMES")
  local costNum = Logic:Get("ChristmasActivity"):GetTaskCost()
  local times = maxBuyTimes - buyTimes
  Prompt:Confirm(self, nil, TwGetStr(106205, costNum, times), self.onConfirmBuyTask, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onConfirmBuyTask()
  local costNum = Logic:Get("ChristmasActivity"):GetTaskCost()
  local totalCharge = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if costNum > totalCharge then
    Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  Logic:Get("ChristmasActivity"):PostBuyTaskMsg(costNum)
end
function prototype:onBtnInfo(sender, event)
  if self.info.showtype == "HERO" then
    local fdb_baseHero = Logic:Get("HeroCardInfo"):kdbBaseHero(self.info.showid)
    if fdb_baseHero ~= nil then
      if fdb_baseHero.card == "HERO" then
        local heroInfo = {
          exp = 0,
          id = 68719480211,
          level = 1,
          baseId = self.info.showid or 1,
          powerSkill = 0
        }
        Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(heroInfo)
      else
        Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.info.showid)
      end
    end
  elseif self.info.showtype == "FRAGMENT" then
    local fraConfig = Logic:Get("Compose"):kdbItemConfig(self.info.showid)
    if fraConfig ~= nil then
      Logic:Get("HeroCardInfo"):OpenHeroInfoById(fraConfig.baseId, true, fraConfig.name)
    end
  end
end
function prototype:onBtnPromptlyAchieve(sender, event)
  local reveiceFlag = Logic:Get("ChristmasActivity"):IsReceivedTask(self.id)
  if reveiceFlag then
    if self.canDraw then
      Logic:Get("ChristmasActivity"):PostGetRewardMsg(self.id)
    else
      local costNum = self.info.completeCost
      Prompt:Confirm(self, nil, TwGetStr(106208, costNum), self.onConfirmTask, Prompt.PROMPT_TYPE.SELECT)
    end
  else
    local totalTaskNum = Logic:Get("ChristmasActivity"):getTotalTaskNum()
    if Logic:Get("ChristmasActivity"):IsHaveReceivedTask() then
      Prompt:Fail(TwGetStr(106241))
      return
    elseif totalTaskNum == 0 then
      local buyTimes = Logic:Get("ChristmasActivity"):getBuyTaskTimes()
      local maxBuyTimes = Logic:Get("Box"):GetMaxOpenTime("TASK_MAX_COMPLETE_TIMES")
      if buyTimes >= maxBuyTimes then
        Prompt:Tip(TwGetStr(106247))
        return
      else
        Prompt:Confirm(self, nil, TwGetStr(106238), self.buyTask, Prompt.PROMPT_TYPE.SELECT)
        return
      end
    else
      Logic:Get("ChristmasActivity"):PostPickUpTaskMsg(self.id)
    end
  end
end
function prototype:onConfirmTask()
  local costNum = self.info.completeCost
  local totalCharge = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if costNum > totalCharge then
    Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  Logic:Get("ChristmasActivity"):PostImmediatelyCompleteTaskMsg(self.id)
end
function prototype:onBtnGiveUp(sender, event)
  Prompt:Confirm(self, nil, TwGetStr(106243), self.onGiveUpTask, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onGiveUpTask()
  Logic:Get("ChristmasActivity"):PostGiveUpMsg(self.id)
end
