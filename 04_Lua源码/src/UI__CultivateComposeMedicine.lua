module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local POSITION = {
  {20},
  {180, 480},
  {
    180,
    331,
    480
  },
  {
    131,
    260,
    401,
    530
  }
}
local IMG = {
  "images/public/clarity05.png",
  "images/public/clarity05.png",
  "images/public/clarity05.png",
  "images/public/clarity05.png"
}
function prototype:onEnter(node, loader)
  super.onEnter(self)
  self.ttfMedicineCount:setStyle(kCCLabelTTFStyleOutline)
  self.ttfMedicineName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCost:setStyle(kCCLabelTTFStyleOutline)
  self.isEnoughMaterial = true
  self.medicine = {}
  self.material = {}
  self:freshMedicine()
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.SWALLOW_ELIXIR, self:Event("onSwallowElixir"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.COM_ELIXIR, self:Event("onComElixir"))
  Logic:Get("BattleShow"):On(Logic.BattleShow.EVT.END, self:Event("OnEndBattle"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.STUFF_CHANGE, self:Event("OnStuffChange"))
end
function prototype:onExit(...)
  Logic:Get("Cultivate"):SetCheckedPillId(nil)
end
function prototype:onSwallowElixir()
  self:onBtnCancel()
end
function prototype:OnEndBattle(...)
  self:setMaterialImg()
end
function prototype:onComElixir()
  self:setMedicineCount()
  self:setMaterialImg()
  self:setBtnPosition()
  self:RunAni()
end
function prototype:freshMedicine()
  self.medicine = Logic:Get("Cultivate"):getMedicine()
  local medicineInfo = {}
  medicineInfo.showId = self.medicine.baseId
  medicineInfo.showType = "CULTIVATE_ELIXIR"
  self.ccbIcon1:ReFreshByGift(medicineInfo)
  self.ccbIcon2:ReFreshByGift(medicineInfo)
  local rec = Logic:Get("Cultivate"):GetPillInfoByBaseId(self.medicine.baseId)
  local sprite = Logic:Get("Cultivate"):GetTypeImage(rec.type)
  if sprite then
    self.sprType1:setDisplayFrame(sprite:displayFrame())
  end
  if sprite then
    self.sprType2:setDisplayFrame(sprite:displayFrame())
  end
  local jobPath = string.format("images/Cultivate/job%d.png", rec.type)
  sprite = CCSprite:create(jobPath or "images/public/clarity05.png")
  if sprite then
    self.sprJob:setDisplayFrame(sprite:displayFrame())
  end
  Logic:Get("Cultivate"):SetCheckedPillId(self.medicine.baseId)
  self.info = Logic:Get("Cultivate"):GetPillInfoByBaseId(self.medicine.baseId)
  self.ttfMedicineName:setString(self.info.name)
  self:setMedicineCount()
  self:setAttributeImg()
  self:setMaterialImg()
  self:setBtnPosition()
end
function prototype:setMedicineCount()
  local medicineAmount = Logic:Get("Cultivate"):GetPillByBaseId(self.info.id)
  self.ttfMedicineCount:setString(medicineAmount or 0)
  self.ttfCost:setString(self.info.costStr)
end
function prototype:setAttributeImg()
  local typeInfo = json.decode(self.info.alters)
  local attributeType
  local index = 1
  for k, v in pairs(typeInfo or {}) do
    local sprAttribute = string.format("sprAttribute%d", index)
    local ttfAttributeAdd = string.format("ttfAttributeAdd%d", index)
    local sprite = Logic:Get("Cultivate"):getPropertySpr(k)
    if sprite and self[sprAttribute] then
      self[sprAttribute]:setDisplayFrame(sprite:displayFrame())
    end
    local strAtr = ""
    if v < 10 then
      strAtr = "+" .. v * 100 .. "%"
    else
      strAtr = "+" .. v
    end
    if self[ttfAttributeAdd] then
      self[ttfAttributeAdd]:setString(strAtr)
    end
    index = index + 1
  end
  self.nodAttr1:setVisible(true)
  self.nodAttr2:setVisible(false)
  if index > 2 then
    self.nodAttr2:setVisible(true)
    self.nodAttr1:setPosition(ccp(225, 528))
    self.nodAttr2:setPosition(ccp(430, 528))
    return
  end
  self.nodAttr1:setPosition(ccp(330, 528))
end
function prototype:clearMaterialImg()
  for i = 1, 4 do
    local nodeMaterial = string.format("nodeMaterial%d", i)
    self[nodeMaterial]:setVisible(false)
  end
end
function prototype:setMaterialImg()
  self:clearMaterialImg()
  local material = json.decode(self.info.materials or {})
  local index = 0
  local materialCount = 0
  self.isEnoughMaterial = true
  for k, v in pairs(material) do
    materialCount = materialCount + 1
  end
  local node = string.format("nodeLight%d", materialCount)
  if self[node] then
    self[node]:setVisible(true)
  end
  local isLight = false
  self.material = {}
  for k, v in pairs(material) do
    index = index + 1
    local nodeMaterial = string.format("nodeMaterial%d", index)
    local ccbMaterial = string.format("ccbMaterial%d", index)
    local progressL = string.format("ttfProgressL%d", index)
    local progressR = string.format("ttfProgressR%d", index)
    local sprLight = string.format("sprLight%d_%d", materialCount, index)
    local materialInfo = Logic:Get("Cultivate"):GetStuffInfoByBaseId(k)
    local info = {}
    info.showType = "CULTIVATE_MATERIAL"
    info.showId = materialInfo.id
    self[ccbMaterial]:ReFreshByGift(info)
    self[nodeMaterial]:setVisible(true)
    self[sprLight]:setVisible(true)
    local materialAmount = 0
    materialAmount = Logic:Get("Cultivate"):GetStuffByBaseId(materialInfo.id) or 0
    self[progressL]:setString(materialAmount)
    self[progressL]:setStyle(kCCLabelTTFStyleOutline)
    if v > materialAmount then
      self[progressL]:setColor(ccc3(255, 0, 0))
    else
      self[progressL]:setColor(ccc3(255, 255, 255))
    end
    self[progressR]:setString("/" .. v)
    self[progressR]:setStyle(kCCLabelTTFStyleOutline)
    if v > materialAmount then
      self[sprLight]:setVisible(false)
      self.isEnoughMaterial = false
    else
      isLight = true
    end
    local tmp = {}
    tmp.baseId = k
    table.insert(self.material, tmp)
  end
  local str = string.format("sprLight%d_%d", materialCount, materialCount + 1)
  if isLight then
    if self[str] then
      self[str]:setVisible(true)
    end
  elseif self[str] then
    self[str]:setVisible(false)
  end
  self:setMedicinePosition(POSITION[index])
end
function prototype:setMedicinePosition(position)
  for k, v in pairs(position) do
    local nodeMaterial = string.format("nodeMaterial%d", k)
    self[nodeMaterial]:setPositionX(v)
  end
end
function prototype:setBtnPosition()
  local swallowMedicine = Logic:Get("Cultivate"):getHeroSwallowElixir(self.medicine.position, self.medicine.heroId)
  local hasMedicine = Logic:Get("Cultivate"):GetPillByBaseId(self.medicine.baseId) or 0
  local positionX = self.nodeBtn2:getPositionX()
  if self.aniButton then
    self.aniButton:RemoveAnimation()
    self.aniButton = nil
  end
  if swallowMedicine then
    self.nodeCompose:setVisible(false)
    self.nodeBtn1:setVisible(false)
    self.nodeBtn2:setVisible(false)
    self.nodeBtn3:setPositionX(positionX)
    return
  end
  if hasMedicine == 0 then
    self.nodeCompose:setVisible(true)
    self.nodeBtn2:setVisible(false)
    self.nodeBtn1:setPositionX(positionX)
    self.nodeBtn3:setVisible(false)
  else
    self.nodeBtn2:setVisible(true)
    self.nodeBtn1:setVisible(false)
    self.nodeBtn3:setVisible(false)
    self.aniButton = Logic:Get("AniMgr"):NewCCB("UI/UIcz02", self.btnSwallow, ccp(75, 30), 0, nil, nil)
  end
end
function prototype:checkMoney()
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  local cost = self.info.cost or 0
  if cost and wallet and cost > wallet.copper then
    return false
  end
  return true
end
function prototype:onBtnClose()
  SceneHelper:removeScene("CultivateComposeMedicine")
end
function prototype:onBtnRefine()
  if not self.isEnoughMaterial then
    Prompt:Fail(TwGetStr(108683))
    return
  end
  if self:checkMoney() then
    local str = TwGetStr(108684, self.info.cost, self.info.name)
    Prompt:Select(self, "", str, self.onRefineMedicine, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  Prompt:ConfirmLeft(self, 106014, 104156)
end
function prototype:onRefineMedicine(ret)
  if ret ~= Logic.SureConfirm.RET.OK then
    return
  end
  Logic:Get("Cultivate"):PostComPoundElixir(self.medicine.baseId)
end
function prototype:onBtnSwallow()
  local medicine = Logic:Get("Cultivate"):GetPillByBaseId(self.medicine.baseId)
  if medicine == nil or medicine == 0 then
    Prompt:Fail(TwGetStr(108682))
    return
  end
  self:onConfirmSwallow()
end
function prototype:onConfirmSwallow()
  Logic:Get("Cultivate"):PostSwallowElixir(self.medicine.baseId, self.medicine.heroId, tonumber(self.medicine.position))
end
function prototype:onBtnCancel()
  SceneHelper:removeScene("CultivateComposeMedicine")
end
function prototype:RunAni()
  local runningScene = SceneHelper:getRootLayer()
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/uiyxxx", runningScene, nil, 1)
  self:AniSetVisible(false)
  local texture, textureRect = Logic:Get("Cultivate"):GetElixirTexture(self.medicine.baseId)
  self.ani:GetChild("imgOut"):setTexture(texture)
  self.ani:GetChild("imgOut"):setTextureRect(textureRect)
  for i = 1, 6 do
    local strImgView = string.format("imgHero%d", i)
    if self.material[i] then
      self.ani:GetChild(strImgView):setVisible(true)
      local texture, textureRect = Logic:Get("Cultivate"):GetMaterialTexture(self.material[i].baseId)
      self.ani:GetChild(strImgView):setTexture(texture)
      self.ani:GetChild(strImgView):setTextureRect(textureRect)
    else
      self.ani:GetChild(strImgView):setVisible(false)
    end
  end
  self.ani:SetCloseCallback(self, self.onBtnCloseAni)
  self.ani:GetChild("btnClose"):setEnabled(false)
  self.ani:SetWaitSignByDefaultAniName(function()
    self.ani:GetChild("btnClose"):setEnabled(false)
    Logic:Get("BGSound"):PlayEffect("audio/heroupgrade.mp3")
    self:AniSetVisible(true)
    self.ani:GetChild("imgGai"):setVisible(false)
    self.ani:GetChild("imgBody"):setVisible(false)
    self:aniFrontEnd()
    self:setAttr()
  end, 5000)
  self.ani:RunAnimationWithoutWait()
end
function prototype:AniSetVisible(bVisible)
  self.ani:GetChild("imgAttr1"):setVisible(bVisible)
  self.ani:GetChild("labAttr1"):setVisible(bVisible)
  self.ani:GetChild("imgBg1"):setVisible(bVisible)
  self.ani:GetChild("node"):setVisible(bVisible)
end
function prototype:onBtnCloseAni()
  self.ani:RemoveAnimation()
  Logic:Get("BGSound"):stopAllEffect()
  Logic:Get("BGSound"):PlayBGMusic()
end
function prototype:setAttr()
  local typeInfo = json.decode(self.info.alters)
  local attributeType
  local addAttribute = 0
  local index = 1
  for k, v in pairs(typeInfo or {}) do
    local imgAttr = string.format("imgAttr%d", index)
    local labAttr = string.format("labAttr%d", index)
    local sprite = Logic:Get("Cultivate"):getPropertySpr(k)
    if sprite then
      self.ani:GetChild(imgAttr):setDisplayFrame(sprite:displayFrame())
    end
    local strAttr = ""
    if v < 10 then
      strAttr = "+" .. v * 100 .. "%"
    else
      strAttr = "+" .. v
    end
    self.ani:GetChild(labAttr):create(0, "ATTR_NUM")
    self.ani:GetChild(labAttr):setValue(strAttr)
    index = index + 1
  end
  if index > 2 then
    self.ani:GetChild("node"):setVisible(true)
  else
    self.ani:GetChild("node"):setVisible(false)
  end
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
function prototype:OnStuffChange()
  self:setMaterialImg()
end
