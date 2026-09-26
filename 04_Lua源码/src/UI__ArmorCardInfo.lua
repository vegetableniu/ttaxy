module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.name:setStyle(kCCLabelTTFStyleOutline)
  self.ttfDesc:setStyle(kCCLabelTTFStyleOutline)
  self.ttfProp1:setStyle(kCCLabelTTFStyleOutline)
  self.ttfProp2:setStyle(kCCLabelTTFStyleOutline)
  self.ttfProp3:setStyle(kCCLabelTTFStyleOutline)
  self.ttfProp4:setStyle(kCCLabelTTFStyleOutline)
  self.ttfBattle1:setStyle(kCCLabelTTFStyleOutline)
  self.ttfBattle2:setStyle(kCCLabelTTFStyleOutline)
  self.ttfBattle3:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:refreshArmorInfo(baseId, fra, btnDisabled)
  self.btnCopy1:setEnabled(false)
  self.btnCopy2:setEnabled(false)
  self.btnCopy3:setEnabled(false)
  self.eliteSpr1:setVisible(false)
  self.eliteSpr2:setVisible(false)
  self.eliteSpr3:setVisible(false)
  self:setBaseInfo(baseId, btnDisabled)
  self:createHeroCard(baseId, fra)
  self:createPfs(baseId)
  self:setPropInfo(baseId)
end
function prototype:setBaseInfo(baseId, btnDisabled)
  local info = Logic:Get("Armor"):getArmorInfoByBaseId(baseId)
  if info == nil or table.empty(info) then
    return
  end
  local color = Logic:Get("Armor"):getColorByBaseId(baseId)
  self.name:setColor(color)
  self.name:setString(info.name)
  self.ttfDesc:setString(ReplaceStringTab(info.desc or ""))
  info.battle = json.decode(info.battle or "[]") or {}
  info.copy = json.decode(info.copy or "[]") or {}
  info.gain = json.decode(info.gain or "[]") or {}
  self.copys = info.copy
  for i, v in ipairs(info.battle) do
    local battleStr = string.format("ttfBattle%d", i)
    if self[battleStr] then
      self[battleStr]:setString(v)
    end
  end
  for i, v in ipairs(info.gain) do
    local textCopyStr = string.format("textCopy%d", i)
    if self[textCopyStr] then
      local str = TwGetStr(111424, v)
      if info.copy[i] then
        local eliteStr = string.format("eliteSpr%d", i)
        if self[eliteStr] then
          self[eliteStr]:setVisible(true)
        end
        local btnStr = string.format("btnCopy%d", i)
        if self[btnStr] then
          self[btnStr]:setEnabled(true)
        end
        if Logic:Get("Elite"):isClearPrevBattle(info.copy[i]) then
          str = str .. TwGetStr(111437, TwGetStr(111436))
        else
          str = str .. TwGetStr(111423, TwGetStr(111422))
        end
      end
      self[textCopyStr]:setString(str)
    end
  end
end
function prototype:createHeroCard(baseId, fra)
  if baseId == nil then
    return
  end
  local node = Logic:Get("Armor"):createArmorCard(baseId, fra)
  if node == nil then
    return
  end
  local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(node, node:getContentSize())
  self.head:setTexture(texture)
  self.head:setTextureRect(textureRect)
  Logic:Get("Armor"):addStarLv(self.head, baseId)
end
function prototype:createPfs(baseId)
  local info = Logic:Get("Armor"):getArmorInfoByBaseId(baseId)
  if info == nil or table.empty(info) then
    return
  end
  local equipTypes = json.decode(info.equipTypes or "[]") or {}
  if #equipTypes >= 14 then
    local str = string.format("data/profession/QUANGZHIYE.png")
    self.spr_pfs_1:setVisible(true)
    local spr = CCSprite:create(str)
    self.spr_pfs_1:setDisplayFrame(spr:displayFrame())
    return
  end
  for i, v in ipairs(equipTypes) do
    local str = string.format("data/profession/%s.png", v)
    local strTip = string.format("spr_pfs_%d", i)
    if self[strTip] then
      local spr = CCSprite:create(str)
      self[strTip]:setDisplayFrame(spr:displayFrame())
    end
  end
end
function prototype:setPropInfo(baseId)
  local alters = Logic:Get("Armor"):getAltersByBaseId(baseId)
  local altersArr = Logic:Get("Armor"):sortPropInfo(alters)
  for i, v in ipairs(altersArr) do
    local spr = Logic:Get("Armor"):getPropertySpr(v.propName)
    local strSpr = string.format("spr%d", i)
    local strProp = string.format("ttfProp%d", i)
    if spr and self[strSpr] and self[strProp] then
      self[strSpr]:setVisible(true)
      self[strSpr]:setDisplayFrame(spr:displayFrame())
      local str = math.ceil(v.value) == v.value and TwGetStr(111412, v.value) or TwGetStr(111411, tostring(100 * v.value))
      self[strProp]:setString(str)
    end
  end
end
function prototype:gotoCopy(index)
  if not self.copys or table.empty(self.copys) or not self.copys[index] then
    return
  end
  if not Logic:Get("Elite"):isClearPrevBattle(self.copys[index]) then
    Prompt:Tip(TwGetStr(111443))
    return
  end
  local rec = Logic:Get("Battle"):GetBattleInfoById(self.copys[index])
  if rec == nil or rec.campaignId == nil then
    return
  end
  Logic:Get("Elite"):SetCampaignId(rec.campaignId)
  SceneHelper:runWithScene("EliteBattle", self.rootNode)
end
function prototype:onCopyBtn1(sender, event)
  self:gotoCopy(1)
end
function prototype:onCopyBtn2(sender, event)
  self:gotoCopy(2)
end
function prototype:onCopyBtn3(sender, event)
  self:gotoCopy(3)
end
