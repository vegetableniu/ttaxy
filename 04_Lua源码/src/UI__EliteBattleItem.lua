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
  self.ttfTimes:setStyle(kCCLabelTTFStyleOutline)
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLevel:setStyle(kCCLabelTTFStyleOutline)
  self.ttfPoint:setStyle(kCCLabelTTFStyleOutline)
  self.ttfOpen:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:ReFrashInfo(data)
  if data == nil then
    return
  end
  self:Clear()
  self.data = data
  self.info = KFDBGetRecord("CampaignConfig", data.campaignId)
  local rec = Logic:Get("Battle"):GetBattleInfoById(self.data.id) or {}
  self.ttfTimes:setString(string.format("(%d/%d)", data.dailyCount or 0, rec.dailyCount or 0))
  self.ttfName:setString(data.name)
  self.ttfPoint:setString(TwGetStr(100003, data.cost))
  local drop = json.decode(data.itemDrop or "[]") or {}
  if table.empty(drop) then
    self.nodDrop:setVisible(false)
  else
    for i = 1, 3 do
      local str = "nodArmor" .. i
      local ccb = "ccbArmor" .. i
      if self[str] and drop[i] then
        local info = {}
        local reward = {}
        local logic = Logic:Get("Reward")
        reward.code = drop[i].code
        reward.type = Logic.Reward.REWARDS_TYPE[drop[i].type]
        local map = logic:createMap(reward)
        if map[reward.type] then
          info.showType = map[reward.type].showType[reward.code + 1] or ""
          info.showId = map[reward.type].showId[reward.code + 1] or 1
        end
        self[ccb]:ReFreshByGift(info)
        self[str]:setVisible(true)
      end
    end
  end
  local bFinish = Logic:Get("Elite"):IsClearBattle(self.data.id)
  if not bFinish or not TwGetStr(100002) then
  end
  self.ttfOpen:setString((TwGetStr(100001)))
  local level = Logic:Get("PlayerInfo"):GetPlayerLevel()
  if level < self.data.level then
    self.ttfLevel:setString(TwGetStr(106020, self.data.level))
    self.nodDrop:setVisible(false)
    self.nodFight:setVisible(false)
    self.btnSelectActivity:setEnabled(false)
    return
  end
  if self.data.dailyCount <= 0 then
    self.imgFight:setVisible(false)
  end
end
function prototype:Clear()
  self.ttfName:setString("")
  self.ttfTimes:setString("")
  self.ttfLevel:setString("")
  self.ttfPoint:setString("")
  self.nodDrop:setVisible(true)
  self.nodFight:setVisible(true)
  for i = 1, 3 do
    local str = "nodArmor" .. i
    if self[str] then
      self[str]:setVisible(false)
    end
  end
  self.nodDrop:setVisible(true)
end
function prototype:onBtnSelectActivity(sender, event)
  Logic:Get("Elite"):SetBattleId(self.data.id)
  if Logic:Get("Guide"):isActive("EquipElite", "SelectBattle") then
    Logic:Get("Guide"):done("EquipElite", "SelectBattle")
    Logic:Get("Battle"):SetEmBattleType(Logic.Battle.BATTLE_TYPE.ELITE)
    SceneHelper:pushScene("EmbattleGroup", self.rootNode)
    return
  end
  local isBagFull = Logic:Get("Hero"):IsBagEnough()
  if isBagFull then
    SceneHelper:pushPrompt("BattleTip")
    return
  end
  local bArmorFull = Logic:Get("Armor"):isEquipPackEnough()
  if bArmorFull then
    Prompt:Confirm(self, "", TwGetStr(111438), self.onSmelt, Prompt.PROMPT_TYPE.SELECT)
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
  if 0 >= self.data.dailyCount then
    local extraTimes = Logic:Get("Box"):GetMaxOpenTime("ELITE")
    local maxBuyTimes = self.data.buyLimit + extraTimes
    local battleBuyTimes = Logic:Get("Elite"):GetBuyTimesById(self.data.id)
    if maxBuyTimes > battleBuyTimes then
      Logic:Get("SureConfirm").btnText.ok = TwGetStr(105219)
      local idx = battleBuyTimes + 1
      local costTab = json.decode(self.data.buyTimesCost or "[]") or {}
      if idx > #costTab then
        idx = #costTab or idx
      end
      self.buyTimeCost = costTab[idx] or 0
      local descStr = TwGetStr(105602, self.buyTimeCost)
      Prompt:Confirm(self, "", descStr, self.onConfirmBuy, Prompt.PROMPT_TYPE.SELECT)
      return
    end
    local str = TwGetStr(105344)
    Prompt:Fail(str)
    return
  end
  local phyInfo = Logic:Get("PlayerInfo"):GetPlayerPhysical()
  local phyPoint = not phyInfo and 0 or phyInfo.point
  if phyPoint < self.data.cost then
    Logic:Get("Mall"):BuyPoints()
    return
  end
  Logic:Get("Battle"):SetEmBattleType(Logic.Battle.BATTLE_TYPE.ELITE)
  SceneHelper:pushScene("EmbattleGroup", self.rootNode)
end
function prototype:onConfirmBuy()
  local jade = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if jade < self.buyTimeCost then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Logic:Get("Elite"):PostBuyTimes()
end
function prototype:onSmelt()
  Logic:Get("Armor"):setSmeltUIBtnNodeDisabled(false)
  SceneHelper:pushScene("ArmorSmelt", self.rootNode)
end
function prototype:updateGuide()
  if Logic:Get("Guide"):isActive("EquipElite", "SelectBattle") then
    Logic:Get("Guide"):lockTouch(self.btnSelectActivity)
  end
end
