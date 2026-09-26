module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.rightBtnNode:setVisible(not Logic:Get("Armor"):isSmeltUIBtnNodeDisabled())
  Logic:Get("Armor"):checkArmorEquipState()
  Logic:Get("Armor"):ClearSmeltList()
  Logic:Get("Armor"):On(Logic.Armor.EVT.ON_MELT, self:Event("OnArmorMelt"))
  Logic:Get("Armor"):On(Logic.Armor.EVT.REFRESH_CELL, self:Event("OnRefreshCell"))
end
function prototype:onExit()
  Logic:Get("Armor"):ClearSmeltList()
end
function prototype:refreshCell(data)
  if not data then
    return
  end
  for i = 1, 5 do
    local strCell = string.format("cell%d", i)
    if self[strCell] then
      self[strCell]:refresh(data[i])
    end
  end
end
function prototype:refreshAniCell(data)
  if not data then
    return
  end
  for i = 1, 5 do
    local strCell = string.format("imgIn%d", i)
    local sprIn = self.ani:GetChild(strCell)
    local texture, textureRect = Logic:Get("Armor"):GetArmorTexture(data[i])
    if sprIn and texture then
      sprIn:setTexture(texture)
      sprIn:setTextureRect(textureRect)
    end
  end
end
function prototype:onBtnFastAdd(sender, event)
  local ids, baseIds = Logic:Get("Armor"):GetArmorsAuto()
  if self.baseIds and #self.baseIds == #baseIds then
    if #self.baseIds < 5 then
      Prompt:Confirm(self, "", 111150)
    else
      Prompt:Confirm(self, "", 111149)
    end
    return
  end
  self:refreshCell(baseIds)
  self.baseIds = baseIds
  if table.empty(ids) then
    Prompt:Confirm(self, "", 111145)
  end
end
function prototype:onBtnSmelt(sender, event)
  local smeltIds, smeltMat = Logic:Get("Armor"):GetCheckedSmelt()
  if table.empty(smeltIds) then
    Prompt:Confirm(self, "", 111141)
    return
  end
  Logic:Get("Armor"):PostMelt(smeltIds, smeltMat)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:popScene()
end
function prototype:onBtnMysticShop(sender, event)
  SceneHelper:runWithScene("MysticShop", self.rootNode)
end
function prototype:onBg()
end
function prototype:OnArmorMelt(reward)
  self.reward = Logic:Get("Reward"):mergeRewards(reward)
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/uipromotion02", self.sprAni, ccp(-4, 176), 0, nil, nil)
  if self.ani then
    self.btnCover:setVisible(true)
    self:refreshAniCell(self.baseIds)
    self.ani:RunAni(nil, true, bind(self.aniEnd, self))
  end
end
function prototype:OnRefreshCell()
  local smeltBaseIds = Logic:Get("Armor"):GetCheckedSmeltBaseId()
  self.baseIds = smeltBaseIds
  self:refreshCell(smeltBaseIds)
end
function prototype:aniEnd()
  self:refreshCell({})
  self.baseIds = nil
  Logic:Get("Armor"):ClearSmeltList()
  self.btnCover:setVisible(false)
  self.ani:RemoveAnimation()
  self:promptResult()
end
function prototype:promptResult()
  local param = {}
  param.titlePath = "images/newfont/smeltSuccess.png"
  param.richtexts = {}
  local strTab = {
    [Logic.Reward.REWARDS_TYPE.SECRETSHOP_CURRENCY] = TwGetStr(111146),
    [Logic.Reward.REWARDS_TYPE.EQUIPMENT_MATERIAL] = {
      [0] = 802,
      [1] = 803
    }
  }
  for k, v in pairs(self.reward or {}) do
    if strTab[v.type] then
      if type(strTab[v.type]) == "string" then
        table.insert(param.richtexts, TwGetStr(111153, strTab[v.type] or ""))
      elseif type(strTab[v.type]) == "table" then
        local info = Logic:Get("Hero"):GetHeroInfoByBaseId(strTab[v.type][v.code])
        if info then
          table.insert(param.richtexts, TwGetStr(111153, info.name or ""))
        end
      end
    end
  end
  param.rewards = self.reward
  param.content = {}
  param.content.str = "\n" .. TwGetStr(111152)
  param.content.color = ccc3(0, 255, 0)
  param.content.style = kCCLabelTTFStyleOutline
  Prompt:IconConfirm(self, param)
end
