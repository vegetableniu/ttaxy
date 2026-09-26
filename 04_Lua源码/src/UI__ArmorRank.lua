module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local IMG_HERO_CARD = {
  "imgHero1",
  "imgHero2",
  "imgHero3",
  "imgHero4",
  "imgHero5",
  "imgHero6"
}
function prototype:onEnter()
  self.ttfLeftProp1:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLeftProp2:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLeftProp3:setStyle(kCCLabelTTFStyleOutline)
  self.ttfRightProp1:setStyle(kCCLabelTTFStyleOutline)
  self.ttfRightProp2:setStyle(kCCLabelTTFStyleOutline)
  self.ttfRightProp3:setStyle(kCCLabelTTFStyleOutline)
  self.costTip:setStyle(kCCLabelTTFStyleOutline)
  self.costNum:setStyle(kCCLabelTTFStyleOutline)
  self.costTip:setString(TwGetStr(111419))
  self.sprArrow:setVisible(false)
  Logic:Get("Armor"):setFromRank(false)
  self.befArmor = Logic:Get("Armor"):getCurRankArmor()
  self:initInfo()
  Logic:Get("Armor"):On(Logic.Armor.EVT.RANK_UP_OK, self:Event("OnRankupCard"))
end
function prototype:initInfo()
  self:clear()
  if not self.befArmor then
    return
  end
  self.sprArrow:setVisible(true)
  self:setImg(self.befArmor.baseId, self.sprBef)
  local info = Logic:Get("Armor"):getArmorInfoByBaseId(self.befArmor.baseId)
  if info and info.nextId and info.nextId > 0 then
    self:setImg(info.nextId, self.sprAft)
  end
  self:setArmorPropDetails()
  self:setCostInfo()
  self.btnRank:setEnabled(Logic:Get("Armor"):isMaterialEnough(self.befArmor.baseId))
end
function prototype:setImg(armorId, bigSpr)
  local card = Logic:Get("Armor"):createArmorCard(armorId)
  local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(card, card:getContentSize())
  bigSpr:setTexture(texture)
  bigSpr:setTextureRect(textureRect)
  Logic:Get("Armor"):addStarLv(bigSpr, armorId)
end
function prototype:setArmorPropDetails()
  self:clear()
  self:setPropInfo(self.befArmor.baseId, "leftSpr", "ttfLeftProp")
  local info = Logic:Get("Armor"):getArmorInfoByBaseId(self.befArmor.baseId)
  if info and info.nextId and info.nextId > 0 then
    self:setPropInfo(info.nextId, "rightSpr", "ttfRightProp")
  end
end
function prototype:setPropInfo(baseId, sprStr, ttfStr)
  local alters = Logic:Get("Armor"):getAltersByBaseId(baseId)
  local index = #table.values(alters)
  for i, v in pairs(alters) do
    local spr = Logic:Get("Armor"):getPropertySpr(i)
    local strSpr = string.format(sprStr .. "%d", index)
    local strProp = string.format(ttfStr .. "%d", index)
    if spr and self[strSpr] and self[strProp] then
      self[strSpr]:setVisible(true)
      self[strSpr]:setDisplayFrame(spr:displayFrame())
      local str = math.ceil(v) == v and TwGetStr(111412, v) or TwGetStr(111411, tostring(100 * v))
      self[strProp]:setString(str)
    end
    index = index - 1
  end
end
function prototype:clear()
  for i = 1, 3 do
    local leftSprStr = string.format("leftSpr%d", i)
    local leftPropStr = string.format("ttfLeftProp%d", i)
    if self[leftSprStr] then
      self[leftSprStr]:setVisible(false)
    end
    if self[leftPropStr] then
      self[leftPropStr]:setString("")
    end
    local rightSprStr = string.format("rightSpr%d", i)
    local rightPropStr = string.format("ttfRightProp%d", i)
    if self[rightSprStr] then
      self[rightSprStr]:setVisible(false)
    end
    if self[rightPropStr] then
      self[rightPropStr]:setString("")
    end
  end
end
function prototype:OnRankupCard()
  self:rankupAni()
  self:rankUpFinished()
end
function prototype:rankupAni()
  local rootLayer = SceneHelper:getRootLayer()
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/uiyxsj01", rootLayer, nil, 1)
  if not self.ani then
    return
  end
  self:enableInfoText(false)
  self.ani:GetChild("btnClose"):setEnabled(false)
  local baseId = self.befArmor.baseId
  if not baseId then
    return
  end
  local card = Logic:Get("Armor"):createArmorCard(baseId, nil, true)
  local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(card, card:getContentSize())
  self.ani:GetChild("imgIn"):setTexture(texture)
  self.ani:GetChild("imgIn"):setTextureRect(textureRect)
  self.ani:GetChild("imgOut1"):setTexture(texture)
  self.ani:GetChild("imgOut1"):setTextureRect(textureRect)
  local info = Logic:Get("Armor"):getArmorInfoByBaseId(self.befArmor.baseId)
  if not info or not info.materials then
    return
  end
  self.costNum:setString(tostring(info.cost or 0))
  info.materials = json.decode(info.materials) or {}
  local materialsTab = {}
  for k, v in pairs(info.materials) do
    local giftInfo = {}
    giftInfo.showType = k
    if k == "PURPLE" then
      giftInfo.showId = 4
    elseif k == "ORANGE" then
      giftInfo.showId = 6
    elseif k == "RED" then
      giftInfo.showId = 7
    end
    table.insert(materialsTab, giftInfo)
  end
  for i = 1, 6 do
    if materialsTab[i] then
      local spr = Logic:Get("Gift"):createImg(materialsTab[i])
      if spr ~= nil then
        local strGoods = Logic:Get("Gift"):createGoodsImg(materialsTab[i])
        if strGoods ~= nil then
          strGoods:setAnchorPoint(CCPoint(0, 0))
          spr:addChild(strGoods, 3, 2)
          local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(spr)
          self.ani:GetChild(IMG_HERO_CARD[i]):setTexture(texture)
          self.ani:GetChild(IMG_HERO_CARD[i]):setTextureRect(textureRect)
        end
      end
    else
      self.ani:GetChild(IMG_HERO_CARD[i]):setVisible(false)
    end
  end
  local cardInfo = Logic:Get("Armor"):getArmorInfoByBaseId(baseId)
  if not cardInfo then
    return
  end
  local nextCardInfo = Logic:Get("Armor"):getArmorInfoByBaseId(cardInfo.nextId)
  local cardAlterInfo = Logic:Get("Armor"):getAltersByBaseId(baseId)
  local nextCardAlterInfo = Logic:Get("Armor"):getAltersByBaseId(cardInfo.nextId)
  local cardAlterArr = Logic:Get("Armor"):sortPropInfo(cardAlterInfo)
  local nextCardAlterArr = Logic:Get("Armor"):sortPropInfo(nextCardAlterInfo)
  card = Logic:Get("Armor"):createArmorCard(cardInfo.nextId, nil, true)
  texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(card, card:getContentSize())
  self.ani:GetChild("imgOut2"):setTexture(texture)
  self.ani:GetChild("imgOut2"):setTextureRect(textureRect)
  self.ani:SetCloseCallback(self, self.onCloseAniBtn)
  Logic:Get("BGSound"):SwitchMusic("audio/up.mp3", false)
  self.ani:SetWaitSignByDefaultAniName(function()
    self.ani:GetChild("imgGai"):setVisible(false)
    self.ani:GetChild("imgBody"):setVisible(false)
    for i = 1, 4 do
      self:setArmorResultInfo(i, cardAlterArr[i], nextCardAlterArr[i])
    end
    Singleton(Timer):After(1500, self:Event("aniFrontEnd"))
  end, 5000)
  self.ani:RunAnimationWithoutWait()
end
function prototype:onCloseAniBtn()
  self.ani:RemoveAnimation()
  Logic:Get("BGSound"):stopAllEffect()
  Logic:Get("BGSound"):PlayBGMusic()
end
function prototype:aniFrontEnd()
  self.ani:GetChild("btnClose"):setEnabled(true)
  local ccSprite = CCSprite:create("images/font/click_go_on.png")
  if ccSprite ~= nil then
    self.ani:GetLayer():addChild(ccSprite, 0, 10)
    local seq1 = Logic:Get("Gift"):fadetoSpr()
    ccSprite:runAction(CCRepeatForever:create(seq1))
    ccSprite:setPosition(self.ani:GetChild("ttfGoOn"):getPosition())
  end
end
function prototype:rankUpFinished()
  self.sprBef:setVisible(false)
  self.sprArrow:setVisible(false)
  self.btnRank:setEnabled(false)
  self:clear()
  self:resetIcons()
  Logic:Get("Armor"):setCurRankArmor(nil)
end
function prototype:enableInfoText(enable)
  for i = 1, 4 do
    self.ani:GetChild("imgL" .. tostring(i)):setVisible(enable)
    self.ani:GetChild("imgLBg" .. tostring(i)):setVisible(enable)
    self.ani:GetChild("imgR" .. tostring(i)):setVisible(enable)
    self.ani:GetChild("imgRBg" .. tostring(i)):setVisible(enable)
    self.ani:GetChild("imgUp" .. tostring(i)):setVisible(enable)
  end
end
function prototype:resetIcons()
  self.icon1:setInitInfo()
  self.icon2:setInitInfo()
  self.icon3:setInitInfo()
  self.icon4:setInitInfo()
  self.icon5:setInitInfo()
end
function prototype:setCostInfo()
  self:resetIcons()
  local info = Logic:Get("Armor"):getArmorInfoByBaseId(self.befArmor.baseId)
  if not info or not info.materials then
    return
  end
  self.costNum:setString(tostring(info.cost or 0))
  info.materials = json.decode(info.materials) or {}
  local num = 1
  for k, v in pairs(info.materials) do
    local giftInfo = {}
    local counts = Logic:Get("Armor"):getMaterialsByType(k) or 0
    giftInfo.showType = k
    giftInfo.amount = TwGetStr(111413, counts, tonumber(v))
    if k == "PURPLE" then
      giftInfo.showId = 4
    elseif k == "ORANGE" then
      giftInfo.showId = 6
    elseif k == "RED" then
      giftInfo.showId = 7
    end
    local iconStr = string.format("icon%d", num)
    if self[iconStr] then
      self[iconStr]:ReFreshByGift(giftInfo)
      self[iconStr]:setTtfSize(20)
      if counts >= tonumber(v) then
        self[iconStr]:setTtfColor(ccColor3B(0, 255, 0))
      else
        self[iconStr]:setTtfColor(ccColor3B(255, 0, 0))
      end
    end
    num = num + 1
  end
end
function prototype:setArmorResultInfo(index, lInfo, rInfo)
  if lInfo and not table.empty(lInfo) then
    self.ani:GetChild("imgL" .. tostring(index)):setVisible(true)
    self.ani:GetChild("imgLBg" .. tostring(index)):setVisible(true)
    local lSpr = Logic:Get("Armor"):getGoldPropertySpr(lInfo.propName)
    if lSpr then
      self.ani:GetChild("imgL" .. tostring(index)):setDisplayFrame(lSpr:displayFrame())
    end
    local str = math.ceil(lInfo.value) == lInfo.value and tostring(lInfo.value) or tostring(100 * lInfo.value) .. "%"
    self.ani:GetChild("staLNode" .. tostring(index)):create(0, "ARMOR_ANI_NUM")
    self.ani:GetChild("staLNode" .. tostring(index)):setValue(str)
  end
  if rInfo == nil or table.empty(rInfo) then
    return
  end
  local rSpr = Logic:Get("Armor"):getGoldPropertySpr(rInfo.propName)
  if rSpr then
    self.ani:GetChild("imgR" .. tostring(index)):setDisplayFrame(rSpr:displayFrame())
  end
  local str = math.ceil(rInfo.value) == rInfo.value and tostring(rInfo.value) or tostring(100 * rInfo.value) .. "%"
  self.ani:GetChild("staRNode" .. tostring(index)):create(0, "ARMOR_ANI_NUM")
  self.ani:GetChild("staRNode" .. tostring(index)):setValue(str)
  self.ani:GetChild("imgR" .. tostring(index)):setVisible(true)
  self.ani:GetChild("imgRBg" .. tostring(index)):setVisible(true)
  self.ani:GetChild("imgUp" .. tostring(index)):setVisible(true)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("ArmorRankSele", self.rootNode)
end
function prototype:onBtnRankBef(sender, event)
  Logic:Get("Armor"):setFromRank(true)
  SceneHelper:runWithScene("ArmorRankSele", self.rootNode)
end
function prototype:onBtnRankAft(sender, event)
  local info = Logic:Get("Armor"):getArmorInfoByBaseId(self.befArmor.baseId)
  if info and info.nextId and info.nextId > 0 then
    Logic:Get("Armor"):openArmorDetails(info.nextId)
  end
end
function prototype:onBtnRank(sender, event)
  local info = Logic:Get("Armor"):getArmorInfoByBaseId(self.befArmor.baseId)
  if info then
    local money = Logic:Get("PlayerInfo"):GetPlayerMoney().copper or 0
    if money < info.cost then
      Prompt:Fail(TwGetStr(111421))
      return
    end
  end
  Logic:Get("Armor"):PostUpgrade(self.befArmor.id)
end
