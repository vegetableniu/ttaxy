module((...), package.seeall)
require("Logic.Battle")
local Battle = Logic.Battle
local LAYER_TYPE = Battle.UI_LAYER_TYPE
local COLOR_RED = ccColor3B(255, 0, 0)
local COLOR_WHITE = ccColor3B(255, 255, 255)
local COLOR_BLUE2 = ccColor3B(0, 221, 255)
local COLOR_GREEN2 = ccColor3B(0, 255, 108)
local NEW_OPEN_COLOR = COLOR_GREEN2
local FINISH_COLOR = COLOR_BLUE2
local ACTION_POINT_COLOR = COLOR_GREEN2
local REMAIN_TIMES_COLOR = COLOR_GREEN2
local ITEM_BG_IMG = {}
ITEM_BG_IMG.NORMAL = {
  normal = "images/public/btnHeroFrameNormal.png",
  select = "images/public/btnHeroFrameSelect.png",
  disable = "images/public/btnHeroFrameDisable.png"
}
ITEM_BG_IMG.HARD = {
  normal = "images/public/btnItem2Normal.png",
  select = "images/public/btnItem2Select.png",
  disable = "images/public/btnItem2Disable.png"
}
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
  self.id = nil
  self.layerType = nil
  self.campType = nil
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self.staState:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  self.staName:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  self.staActionPoint:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  self.staNotice:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  self.staRemain:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  self.staRemain:setString(TwGetStr(100059))
  self.staActionPoint:setColor(ACTION_POINT_COLOR)
  self.staNotice:setColor(REMAIN_TIMES_COLOR)
  if self.ani ~= nil then
    self.ani:RemoveAnimation()
  end
end
function prototype:onExit()
end
function prototype:refresh(data)
  self:clear()
  if nil == data or table.empty(data) or data.id == nil then
    return
  end
  self.id = data.id
  self.layerType = data.layerType
  self.campType = data.campType
  self:refreshImgBg()
  if self.layerType == LAYER_TYPE.CAMPAIGN then
    self:refreshCampain(self.id)
  elseif self.layerType == LAYER_TYPE.BATTLE then
    self:refreshBattle(self.id)
  end
end
function prototype:clear()
  self.staState:setString("")
  self.staName:setString("")
  self.staActionPoint:setString("")
  self.staNotice:setString("")
  self.staRemain:setVisible(false)
  self.btnItem:setEnabled(false)
  self.btnItem:setVisible(false)
  self.imgFight:setVisible(false)
  self.staLevelOpen:setString("")
end
function prototype:refreshImgBg()
  local imgs = ITEM_BG_IMG.NORMAL
  if self.campType == Battle.CAMPAIGN_TYPE.HARD then
    imgs = ITEM_BG_IMG.HARD
  end
  self.btnItem:setBackgroundSpriteForState(CCScale9Sprite:create(imgs.normal), CCControlStateNormal)
  self.btnItem:setBackgroundSpriteForState(CCScale9Sprite:create(imgs.select), CCControlStateHighlighted)
  self.btnItem:setBackgroundSpriteForState(CCScale9Sprite:create(imgs.disable), CCControlStateDisabled)
end
function prototype:refreshCampain(id)
  local info = Logic:Get("Battle"):GetCampaignInfoById(id)
  if nil == info then
    return
  end
  self.btnItem:setVisible(true)
  self.btnItem:setEnabled(true)
  self.staLevelOpen:setString("")
  self.staLevelOpen:setVisible(true)
  self.staLevelOpen:setString(TwGetStr(105311, info.level))
  self.staLevelOpen:setColor(ccc3(0, 255, 108))
  local heroLvl = Logic:Get("PlayerInfo"):GetPlayerLevel()
  if heroLvl < info.level then
    self.staLevelOpen:setString(TwGetStr(100054, info.level))
    self.staLevelOpen:setColor(ccc3(255, 0, 0))
  elseif Logic:Get("Battle"):IsCampInPreShow(id) then
    self.btnItem:setEnabled(false)
    self.staLevelOpen:setString(TwGetStr(100055))
    self.staLevelOpen:setColor(ccc3(255, 0, 0))
  end
  local bFinish = Logic:Get("Battle"):IsCampainFinish(id)
  if not bFinish or not TwGetStr(100002) then
  end
  self.staState:setString((TwGetStr(100001)))
  self.staState:setColor(bFinish and FINISH_COLOR or NEW_OPEN_COLOR)
  self.staName:setString(info.name)
end
function prototype:refreshBattle(id)
  local info = Logic:Get("Battle"):GetBattleInfoById(id)
  if nil == info then
    return
  end
  self.imgFight:setVisible(true)
  local bFinish = Logic:Get("Battle"):IsBattleFinish(id)
  if not bFinish or not TwGetStr(100002) then
  end
  self.staState:setString((TwGetStr(100001)))
  self.staState:setColor(bFinish and FINISH_COLOR or NEW_OPEN_COLOR)
  self.staName:setString(info.name)
  self.staActionPoint:setString(TwGetStr(100003, info.cost))
  self.btnItem:setVisible(true)
  self.btnItem:setEnabled(true)
  self.staLevelOpen:setString("")
  local heroLvl = Logic:Get("PlayerInfo"):GetPlayerLevel()
  if heroLvl < info.level then
    self.staLevelOpen:setString(TwGetStr(100054, info.level))
  else
    local battleType = Logic:Get("Battle"):GetBattleType(id)
    if battleType == Battle.CAMPAIGN_TYPE.HARD then
      local leftTimes = Logic:Get("Battle"):GetLeftTimes(id)
      if -1 == leftTimes then
        self.staNotice:setString("")
      else
        self.staNotice:setString(TwGetStr(100004, leftTimes))
        self.btnItem:setEnabled(leftTimes > 0)
        self.staRemain:setVisible(true)
      end
    end
  end
end
function prototype:onItemClicked(sender, event)
  if self.layerType == LAYER_TYPE.CAMPAIGN then
    Logic:Get("Main"):CuMengMainGuide("FirstBattle", "SelectCampaign")
    Logic:Get("Main"):CuMengMainGuide("EvolutionBattle", "SelectCampaign")
    Logic:Get("Guide"):done("FirstBattle", "SelectCampaign")
    Logic:Get("Guide"):done("LevelUpBattle", "SelectCampaign")
    Logic:Get("Guide"):done("EvolutionBattle", "SelectCampaign")
    Logic:Get("Guide"):done("AchievementBattle", "SelectCampaign")
    Logic:Get("Guide"):done("FightBattle", "SelectCampaign")
    Logic:Get("Guide"):done("LotteryBattle", "SelectCampaign")
    local info = Logic:Get("Battle"):GetCampaignInfoById(self.id)
    if nil == info then
      return
    end
    local curLvl = Logic:Get("PlayerInfo"):GetPlayerLevel()
    if curLvl < info.level then
      Prompt:ConfirmBtnText(100061)
      Prompt:Select(self, nil, TwGetStr(100060, info.level), self.onConfirmUpLevel)
      return
    end
  elseif self.layerType == LAYER_TYPE.BATTLE then
    Logic:Get("Main"):CuMengMainGuide("FirstBattle", "SelectBattle")
    Logic:Get("Main"):CuMengMainGuide("EvolutionBattle", "SelectBattle")
    Logic:Get("Guide"):done("FirstBattle", "SelectBattle")
    Logic:Get("Guide"):done("LevelUpBattle", "SelectBattle")
    Logic:Get("Guide"):done("EvolutionBattle", "SelectBattle")
    Logic:Get("Guide"):done("AchievementBattle", "SelectBattle")
    Logic:Get("Guide"):done("FightBattle", "SelectBattle")
    Logic:Get("Guide"):done("LotteryBattle", "SelectBattle")
    local playersLeadership = Logic:Get("Hero"):GetLeadership()
    local battlingLeadership = Logic:Get("Hero"):GetBattlingLeadership()
    if playersLeadership < battlingLeadership then
      Prompt:Confirm(self, 103071, 103070)
      return
    end
    local info = Logic:Get("Battle"):GetBattleInfoById(self.id)
    if nil == info then
      return
    end
    local curLvl = Logic:Get("PlayerInfo"):GetPlayerLevel()
    if curLvl < info.level then
      Prompt:Tip(TwGetStr(100060, info.level))
      return
    end
    local currPhysical = Logic:Get("PlayerInfo"):GetPlayerPhysical()
    if currPhysical.point < info.cost then
      Logic:Get("Mall"):BuyPoints()
      return
    end
    local bagBool = Logic:Get("Hero"):IsBagEnough()
    if bagBool then
      SceneHelper:pushPrompt("BattleTip")
      return
    end
    if self.id == "CN08BN04" then
      local _, _, num = Logic:Get("Hero"):CheckAppointLevelCardExist(0, 3)
      if num < 2 then
        Logic:Get("SureConfirm"):SetBtnText({
          ok = TwGetStr(103086)
        })
        Logic:Get("SureConfirm"):SetAni(true)
        Prompt:Confirm(self, 104323, 104324, function()
          Logic:Get("ExplainEquip"):setEvolutionType(Logic.ExplainEquip.EVO_TYPE.MATERIAL_EVO)
          SceneHelper:pushScene("HeroEvolution", self.rootNode)
        end, Prompt.PROMPT_TYPE.SELECT)
        return
      end
    end
    local bFinish = Logic:Get("Battle"):IsBattleFinish(self.id)
    if not bFinish then
      local lockInfo = KFDBGetRecord("ConfigValue", "BATTLE:LOCK_ID_LEVEL")
      if lockInfo then
        local info = json.decode(lockInfo.content)
        for k, v in pairs(info) do
          if self.id == k then
            local battleHero = Logic:Get("Hero"):GetBattlingHero()
            local btnText = {}
            btnText.ok = TwGetStr(104322)
            local bool, num = Logic:Get("Hero"):CheckAppointLevelCardExist(30)
            if v == 30 and not bool then
              Logic:Get("SureConfirm"):SetBtnText(btnText)
              Logic:Get("SureConfirm"):SetAni(true)
              Prompt:Confirm(self, 104323, 104320, self.callBackFunc, Prompt.PROMPT_TYPE.SELECT)
              return
            end
          end
        end
      end
    end
  end
  Logic:Get("Battle"):FireEvent(Battle.EVT.CLICK_BATTLE_COPY_ITEM, self.id, self.layerType)
end
function prototype:callBackFunc()
  SceneHelper:pushScene("HeroUpgrade", self.rootNode)
end
function prototype:onConfirmUpLevel(confType)
  if confType == SureConfirm.RET.CANCEL then
    return
  end
  if self.layerType ~= LAYER_TYPE.CAMPAIGN then
    return
  end
  local campInfo = Logic:Get("Battle"):GetCampaignInfoById(self.id)
  if nil == campInfo then
    return
  end
  if "" == campInfo.prevId then
    return
  end
  local prevIdLst = json.decode(campInfo.prevId)
  if #prevIdLst == 0 then
    return
  end
  local prevId = prevIdLst[1]
  Logic:Get("Battle"):FireEvent(Battle.EVT.CLICK_BATTLE_COPY_ITEM, prevId, self.layerType)
end
function prototype:updateGuide()
  local logicGuide = Logic:Get("Guide")
  if not logicGuide:isGuiding() then
    return false
  end
  local data = {
    {
      guide = "FirstBattle",
      step = "SelectCampaign"
    },
    {
      guide = "FirstBattle",
      step = "SelectBattle"
    },
    {
      guide = "LevelUpBattle",
      step = "SelectCampaign"
    },
    {
      guide = "LevelUpBattle",
      step = "SelectBattle"
    },
    {
      guide = "EvolutionBattle",
      step = "SelectCampaign"
    },
    {
      guide = "EvolutionBattle",
      step = "SelectBattle"
    },
    {
      guide = "AchievementBattle",
      step = "SelectCampaign"
    },
    {
      guide = "AchievementBattle",
      step = "SelectBattle"
    },
    {
      guide = "FightBattle",
      step = "SelectCampaign"
    },
    {
      guide = "FightBattle",
      step = "SelectBattle"
    },
    {
      guide = "LotteryBattle",
      step = "SelectCampaign"
    },
    {
      guide = "LotteryBattle",
      step = "SelectBattle"
    }
  }
  for _, v in ipairs(data) do
    if logicGuide:isActive(v.guide, v.step) then
      Logic:Get("Guide"):lockTouch(self.btnItem)
      break
    end
  end
end
function prototype:addGuideTip()
  if self.id == "CN01BN03" or self.id == "CN01BN04" or self.id == "CN01BN05" then
    self:onLockTouch(self.btnItem)
  end
end
function prototype:onLockTouch(node)
  if self.spr == nil then
    local strPath = "images/public/clarity80.png"
    self.spr = CCSprite:create(strPath)
    self.rootNode:addChild(self.spr, 0, 98)
    self.spr:setAnchorPoint(CCPoint(0.5, 0.5))
  end
  local node = node or self.rootNode
  local size = node:getContentSize()
  local rect = CCRect(0, 0, size.width, size.height)
  local transformTarget = node:nodeToWorldTransform()
  rect = CCRectApplyAffineTransform(rect, transformTarget)
  local transformLocal = self.rootNode:worldToNodeTransform()
  rect = CCRectApplyAffineTransform(rect, transformLocal)
  self.spr:setPositionX(rect.origin.x + rect.size.width / 2)
  self.spr:setPositionY(rect.origin.y + rect.size.height / 2)
  if self.ani ~= nil then
    self.ani:RemoveAnimation()
  end
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIts", self.spr)
  if self.ani then
    self.ani:RunAni()
  end
end
