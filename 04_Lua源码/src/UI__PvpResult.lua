module((...), package.seeall)
require("SceneHelper")
local IMG_WIN_PATH = "images/font/fightWin.png"
local IMG_FAIL_PATH = "images/font/fightFail.png"
local CLARITY_PATH = "images/public/clarity05.png"
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  Logic:Get("Fight"):On(Logic.Fight.EVT.SHOW_COMPARE, self:Event("showCompare"))
  Logic:Get("BattleShow"):CleanUp()
  SceneHelper:removeScene("EmbattleGroup")
  SceneHelper:removeScene("FightResult")
  self.nodUp:setVisible(false)
  self.nodDown:setVisible(false)
  self:runAni()
  local str = TwGetStr(107014) .. Logic:Get("Pvp"):GetRewardGold()
  self.ttfGold:setStyle(kCCLabelTTFStyleOutline)
  self.ttfGold:setString(str)
end
function prototype:onExit()
  Logic:Get("Fight"):clearCompareData()
  Logic:Get("Pvp"):SetIsPvp(false)
  Logic:Get("Pvp"):FireEvent(Logic.Pvp.EVT.GET_PVP_INFO)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:showCompare()
  SceneHelper:pushScene("FightCompare", self.rootNode)
end
function prototype:onBtnCompareClicked(sender, event)
  local player = Logic:Get("Fight"):GetOwn()
  local enemy = Logic:Get("Fight"):GetEnemy()
  if player == nil or enemy == nil then
    if Logic:Get("Pvp"):IsPvp() then
      Logic:Get("Pvp"):PostLineupCompare()
      return
    end
    local fighter = Logic:Get("Fight"):GetFighter()
    MsgArena:Post("LINEUP_COMPARE", {
      id = fighter.id
    })
    return
  end
  self:showCompare()
end
function prototype:onBtnCloseClicked(sender, event)
  SceneHelper:popScene()
end
function prototype:onBtnLotteryClicked(sender, event)
end
function prototype:runAni()
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/uichange", self.nodAni, ccp(0, 0), 0, nil, 1)
  self:setAniImg()
  if Logic:Get("Pvp"):IsRankUp() and self.ani then
    self.nodUp:setVisible(true)
    self.nodDown:setVisible(true)
    self.ani:RunAni(nil, nil, bind(self.aniEnd, self))
    return
  end
  self.ttfRank:setStyle(kCCLabelTTFStyleOutline)
  self.ttfRank:setString(TwGetStr(105803))
end
function prototype:setAniImg()
  local leader = Logic:Get("Hero"):GetLeaderId()
  local leaderBaseId = Logic:Get("Hero"):GetHeroInfoById(leader).baseId
  self:SetIcon(self.ani:GetChild("sprPlayerBg"), self.ani:GetChild("sprPlayerIcon"), leaderBaseId)
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.ani:GetChild("sprPlayerBg"), leaderBaseId)
  local player = Logic:Get("Pvp"):GetPlayer()
  self:SetTitle(self.ani:GetChild("sprPlayerTitle1"), self.ani:GetChild("sprPlayerTitle2"), player.desId)
  self.ani:GetChild("ttfPlayerName"):setString(player.name)
  local target = Logic:Get("Pvp"):GetTarget()
  self:SetIcon(self.ani:GetChild("sprTargetBg"), self.ani:GetChild("sprTargetIcon"), target.leaderBaseId)
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.ani:GetChild("sprTargetBg"), target.leaderBaseId)
  self:SetTitle(self.ani:GetChild("sprTargetTitle1"), self.ani:GetChild("sprTargetTitle2"), target.desId)
  self.ani:GetChild("ttfTargetName"):setString(target.name)
  local success = Logic:Get("Pvp"):GetSuccess()
  local spr
  if success then
    spr = CCSprite:create(IMG_WIN_PATH)
  else
    spr = CCSprite:create(IMG_FAIL_PATH)
  end
  self.ani:GetChild("sprWin"):setDisplayFrame(spr:displayFrame())
  self.ani:GetChild("sprWin2"):setDisplayFrame(spr:displayFrame())
  local beforeRank = Logic:Get("Pvp"):GetBeforeRank()
  self:SetRank(player.rank, beforeRank)
end
function prototype:SetIcon(bgNode, IconNode, baseId)
  local iconPath = Logic:Get("Hero"):GetHeroImage(baseId)
  local spriteIcon = CCSprite:create(iconPath)
  if spriteIcon then
    IconNode:setDisplayFrame(spriteIcon:displayFrame())
  end
  local strBg = Logic:Get("Hero"):GetHeroBgImage(baseId)
  local spriteBg = CCSprite:create(strBg)
  if spriteBg then
    bgNode:setDisplayFrame(spriteBg:displayFrame())
  end
end
function prototype:SetTitle(node1, node2, desId)
  local rec = Logic:Get("Pvp"):GetRecordByDesId(desId)
  if rec and rec.icoPath ~= "" then
    local spr = CCSprite:create(rec.logoPath)
    if spr then
      node1:setDisplayFrame(spr:displayFrame())
    end
    spr = CCSprite:create(rec.icoPath)
    if spr then
      node2:setDisplayFrame(spr:displayFrame())
    end
    return
  end
  local spr = CCSprite:create(CLARITY_PATH)
  if spr then
    node1:setDisplayFrame(spr:displayFrame())
    node2:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:SetRank(upRank, downRank)
  self.nodRankUp:create(0, "YELLOW_E_NUM")
  self.nodRankUp:setAlign("CENTER", "CENTER")
  if upRank and upRank >= 0 then
    self.nodRankUp:setValue(upRank)
  end
  self.nodRankDown:create(0, "YELLOW_E_NUM")
  self.nodRankDown:setAlign("CENTER", "CENTER")
  if downRank and downRank > 0 then
    self.nodRankDown:setValue(downRank)
    return
  end
  local rec = KFDBGetRecord("ConfigValue", "PVP:RANK_SIZE")
  local lastRank = rec and tonumber(rec.content) + 1 or 0
  self.nodRankDown:setValue(lastRank)
end
function prototype:aniEnd()
  local player = Logic:Get("Pvp"):GetPlayer()
  self:SetRank(player.rank, player.rank + 1)
end
