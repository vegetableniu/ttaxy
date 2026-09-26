module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
ITEM_PATH = {
  NORMAL = "images/public/btnItem2Normal.png",
  SELECT = "images/public/btnItem2Select.png",
  DISABLE = "images/public/btnItem2Disable.png"
}
function prototype:initialize()
  super.initialize(self)
end
function prototype:onEnter()
  self.ttfDesc:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTimes:setStyle(kCCLabelTTFStyleOutline)
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLevel:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:ReFrashInfo(data)
  if data == nil then
    return
  end
  self.ttfLevel:setString("")
  self.btnSelectActivity:setEnabled(true)
  self.data = data
  self.ttfDesc:setString(data.buffDesc)
  self.info = KFDBGetRecord("CampaignConfig", data.campaignId)
  if self.info.type == "LIMITED" and self.data.dailyCount <= 0 then
    self.ttfTimes:setString(TwGetStr(106043))
    self.imgFight:setVisible(false)
  elseif self.info.type == "FULLED" then
    self.ttfTimes:setString(TwGetStr(106018, data.cost))
    local sprNormal, sprSelect, sprDisable
    sprNormal = CCScale9Sprite:create(ITEM_PATH.NORMAL)
    sprSelect = CCScale9Sprite:create(ITEM_PATH.SELECT)
    sprDisable = CCScale9Sprite:create(ITEM_PATH.DISABLE)
    if sprNormal and sprSelect and sprDisable then
      self.btnSelectActivity:setBackgroundSpriteForState(sprNormal, CCControlStateNormal)
      self.btnSelectActivity:setBackgroundSpriteForState(sprSelect, CCControlStateHighlighted)
      self.btnSelectActivity:setBackgroundSpriteForState(sprDisable, CCControlStateDisabled)
    end
  else
    self.ttfTimes:setString(TwGetStr(105601, data.dailyCount))
  end
  self.ttfName:setString(data.name)
  local level = Logic:Get("PlayerInfo"):GetPlayerLevel()
  if level < self.data.level then
    self.ttfLevel:setString(TwGetStr(106020, self.data.level))
    self.btnSelectActivity:setEnabled(false)
    return
  end
  if self.info.type ~= "FULLED" and self.data.dailyCount <= 0 then
    self.btnSelectActivity:setEnabled(false)
  end
end
function prototype:onBtnSelectActivity(sender, event)
  if Logic:Get("Rebirth"):IsClickNewDay() then
    SceneHelper:runWithScene("Home", self.rootNode)
    return
  end
  local isBagFull = Logic:Get("Hero"):IsBagEnough()
  if isBagFull then
    SceneHelper:pushPrompt("BattleTip")
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
  Logic:Get("Rebirth"):SetBattleId(self.data.id)
  if self.info.type ~= "FULLED" and 0 >= self.data.dailyCount then
    local freeBuyTimes = Logic:Get("Rebirth"):GetMaxFreeTimes()
    local buyTimes = Logic:Get("Rebirth"):GetBuyCnt()
    if freeBuyTimes - buyTimes > 0 then
      Logic:Get("SureConfirm").btnText.ok = TwGetStr(105219)
      local cost = Logic:Get("Rebirth"):GetBuyTimeCost()
      local descStr = TwGetStr(105602, cost)
      Prompt:Confirm(self, "", descStr, self.onConfirmBuy, Prompt.PROMPT_TYPE.SELECT)
    else
      Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
      local str = TwGetStr(10078) .. "\n" .. TwGetStr(105321)
      Prompt:Confirm(Logic:Get("Main"), "", str, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    end
    return
  end
  if self.info.type == "FULLED" then
    local phyInfo = Logic:Get("PlayerInfo"):GetPlayerPhysical()
    local phyPoint = not phyInfo and 0 or phyInfo.point
    if phyPoint < self.data.cost then
      Logic:Get("Mall"):BuyPoints()
      return
    end
    Logic:Get("Battle"):SetEmBattleType(Logic.Battle.BATTLE_TYPE.FULLED)
  else
    Logic:Get("Battle"):SetEmBattleType(Logic.Battle.BATTLE_TYPE.REBIRTH)
  end
  SceneHelper:pushScene("EmbattleGroup", self.rootNode)
end
function prototype:onConfirmBuy()
  Logic:Get("Rebirth"):PostBuyTimes()
end
