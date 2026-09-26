module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
BTN_PATH = {
  NORMAL = "images/public/btnHeroFrameNormal.png",
  SELECT = "images/public/btnHeroFrameSelect.png",
  PLAYER = "images/public/btnPlayerNormal.png"
}
CLARITY_PATH = "images/public/clarity05.png"
function prototype:initialize(...)
  super.initialize(self, ...)
  self.data = {}
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLevel:setStyle(kCCLabelTTFStyleOutline)
  self.ttfRank:setStyle(kCCLabelTTFStyleOutline)
  self.ttfColdTime:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:ReFrashFighterInfo(pNodeData)
  if pNodeData == nil or table.empty(pNodeData) then
    return
  end
  self.data = pNodeData
  self:initFightInfo()
end
function prototype:onBtnRecord(sender, event)
  SceneHelper:runWithScene("PvpRecord", self.rootNode)
end
function prototype:onBtnItemClicked(sender, event)
  local playerName = Logic:Get("PlayerInfo"):GetPlayerName()
  if self.data.name == playerName then
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
  local coldTime = Logic:Get("Pvp"):GetColdTime()
  local diffTime = Logic:Get("System"):DiffTime(coldTime)
  if diffTime > 0 then
    local cost = Logic:Get("Pvp"):GetResetCost()
    local text = TwGetStr(105870) .. "\n" .. TwGetStr(105805, cost or 0)
    Prompt:Confirm(self, "", text, self.onConfirmBuy, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  local energy = Logic:Get("Devil"):GetEnergy()
  local rec = KFDBGetRecord("ConfigValue", "PVP:DEFY_MATCH_ENERGY")
  local cost = rec and tonumber(rec.content) or 0
  if energy and cost and cost > energy.point then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(105219)
    local str = TwGetStr(105557)
    Prompt:Confirm(self, "", str, self.onBuyEnergy, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  if not self.data.virtual and Logic:Get("Pvp"):IsNeedChallegeFade(self.data.rank) then
    Prompt:Confirm(self, "", TwGetStr(105804, self.data.rank, self.data.name), self.challenge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  self:challenge()
end
function prototype:initFightInfo()
  self:Clear()
  local iconPath = Logic:Get("Hero"):GetHeroImage(self.data.leaderBaseId)
  local spriteIcon = CCSprite:create(iconPath)
  if spriteIcon then
    self.sprIcon:setDisplayFrame(spriteIcon:displayFrame())
  end
  local bgPath = Logic:Get("Hero"):GetHeroBgImage(self.data.leaderBaseId)
  local sprBg = CCSprite:create(bgPath)
  if sprBg then
    self.sprBg:setDisplayFrame(sprBg:displayFrame())
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.sprIcon, self.data.leaderBaseId)
  self.ttfName:setString(self.data.name)
  self.ttfLevel:setString(TwGetStr(105311, self.data.level))
  if self.data.battleScore and self.data.battleScore >= 0 then
    self.nodBattle:create(0, "YELLOW_E_NUM")
    self.nodBattle:setAlign("LEFT", "CENTER")
    self.nodBattle:setValue(self.data.battleScore)
  end
  if 0 < self.data.rank then
    self.ttfRank:setString(self.data.rank)
  else
    self.ttfRank:setString("-")
  end
  local playerName = Logic:Get("PlayerInfo"):GetPlayerName()
  if self.data.name == playerName then
    self.sprBattle:setVisible(false)
    self.nodBattleEffect:setVisible(false)
    self.nodRecord:setVisible(true)
    self.ttfName:setColor(ccc3(255, 0, 0))
    local sprNormal, sprSelect
    sprNormal = CCScale9Sprite:create(BTN_PATH.PLAYER)
    sprSelect = CCScale9Sprite:create(BTN_PATH.PLAYER)
    if sprNormal and sprSelect then
      self.btnItem:setBackgroundSpriteForState(sprNormal, CCControlStateNormal)
      self.btnItem:setBackgroundSpriteForState(sprSelect, CCControlStateHighlighted)
    end
    local rec = Logic:Get("Pvp"):GetRecordByDesId(self.data.desId)
    if rec and rec.icoPath ~= "" then
      local spr = CCSprite:create(rec.logoPath)
      if spr then
        self.sprTitle1:setDisplayFrame(spr:displayFrame())
      end
      spr = CCSprite:create(rec.icoPath)
      if spr then
        self.sprTitle2:setDisplayFrame(spr:displayFrame())
      end
    end
  end
end
function prototype:Clear()
  self.sprBattle:setVisible(true)
  self.nodBattleEffect:setVisible(true)
  self.ttfColdTime:setString("")
  self.ttfName:setColor(ccc3(255, 255, 255))
  local sprNormal, sprSelect
  sprNormal = CCScale9Sprite:create(BTN_PATH.NORMAL)
  sprSelect = CCScale9Sprite:create(BTN_PATH.SELECT)
  if sprNormal and sprSelect then
    self.btnItem:setBackgroundSpriteForState(sprNormal, CCControlStateNormal)
    self.btnItem:setBackgroundSpriteForState(sprSelect, CCControlStateHighlighted)
  end
  local spr = CCSprite:create(CLARITY_PATH)
  if spr then
    self.sprTitle1:setDisplayFrame(spr:displayFrame())
    self.sprTitle2:setDisplayFrame(spr:displayFrame())
  end
  self.nodRecord:setVisible(false)
end
function prototype:onBuyEnergy()
  SceneHelper:pushPrompt("DevilBuyTip", self.rootNode)
end
function prototype:challenge()
  Logic:Get("Pvp"):SetTarget(self.data)
  Logic:Get("Pvp"):SetIsPvp(true)
  Logic:Get("Battle"):SetEmBattleType(Logic.Battle.BATTLE_TYPE.ARENA)
  SceneHelper:pushScene("EmbattleGroup", self.rootNode)
end
function prototype:onConfirmBuy()
  local cost = Logic:Get("Pvp"):GetResetCost()
  local playerMoney = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if playerMoney and cost <= playerMoney then
    MsgPvp:Post("CLEAR_COOL_DOWN")
    return
  end
  Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
  Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
end
