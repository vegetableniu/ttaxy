module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local imgNormalPath = "images/public/selcet1.png"
local imgCheckPath = "images/public/selcet2.png"
local imgLockPath = "images/public/selcet3.png"
function prototype:onEnter()
  self.bCheck = false
  self.btnSelect:setEnabled(true)
  self.ttfEvolution:setStyle(kCCLabelTTFStyleOutline)
  self.ttfEvolution:setString("")
  self:refresh(self.info)
end
function prototype:refresh(info, isCheck)
  if info and not table.empty(info) then
    self.info = info
    local cardPath = Logic:Get("Hero"):GetHeroImage(info.baseId)
    self.imgHero:setDisplayFrame(CCSprite:create(cardPath):displayFrame())
    local borderPath = Logic:Get("Hero"):GetHeroBgImage(info.baseId)
    self.imgBg:setDisplayFrame(CCSprite:create(borderPath):displayFrame())
    local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(info.baseId)
    self.ttfName:setString(heroInfo.name)
    if 0 == Logic:Get("Sect"):checkCardEvolution(info.baseId) then
      self.ttfEvolution:setColor(ccColor3B(0, 255, 0))
      self.ttfEvolution:setString(TwGetStr(110113))
    elseif -1 == Logic:Get("Sect"):checkCardEvolution(info.baseId) then
      self.btnSelect:setEnabled(false)
    elseif -2 == Logic:Get("Sect"):checkCardEvolution(info.baseId) then
      self.ttfEvolution:setColor(ccColor3B(255, 0, 0))
      self.ttfEvolution:setString(TwGetStr(106013))
    end
    self.alsLevel:create(0, "YELLOW_E_NUM")
    self.alsLevel:setAlign("LEFT", "CENTER")
    self.alsLevel:setValue(info.level)
    local imgCheck = CCSprite:create(imgNormalPath)
    if info.lock then
      imgCheck = CCSprite:create(imgLockPath)
      self.btnSelect:setEnabled(false)
    elseif isCheck then
      imgCheck = CCSprite:create(imgCheckPath)
    end
    self.chickTitle:setDisplayFrame(imgCheck:displayFrame())
  end
end
function prototype:onBtnSelect(sender, event)
  local checkedId = Logic:Get("Sect"):GetCheckedId()
  if not checkedId or checkedId ~= self.info.id then
    Logic:Get("Sect"):SetCheckedId(self.info.id, self.info.baseId)
    SceneHelper:runWithScene("SectDemogCardMix", self.rootNode)
  end
  Logic:Get("Sect"):PostRefreshCardList()
end
function prototype:onBtnCard(sender, event)
  Logic:Get("HeroCardInfo"):OpenHeroInfo(self.info)
end
