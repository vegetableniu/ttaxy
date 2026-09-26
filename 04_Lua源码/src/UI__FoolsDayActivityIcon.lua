module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local DEFAULT_PATH = "images/public/clarity80.png"
function prototype:onEnter()
  self:initRotateCardInfo()
end
function prototype:refreshInfo(index)
  self.index = index
  self.imgIcon:setVisible(false)
end
function prototype:setCardInfoByBaseId(baseId)
  if baseId then
    self.imgIcon:setVisible(true)
    self:setCardInfo(baseId, self.imgIcon)
    self.btnIcon:setEnabled(false)
    self.imgCover:setVisible(false)
    self.sprClick:setVisible(false)
  else
    self.imgIcon:setVisible(false)
    self.btnIcon:setEnabled(true)
    self.imgCover:setVisible(true)
    self.sprClick:setVisible(true)
    Logic:Get("HeroCardInfo"):ClearShanCard(self.imgIcon)
  end
end
function prototype:setCardInfo(baseId, controller)
  local cardNode = Logic:Get("HeroCardInfo"):GetSprCard(baseId, nil, true)
  if cardNode then
    local texture = Logic:Get("HeroCardInfo"):GetCardTexture(cardNode)
    if texture then
      controller:setTexture(texture)
      controller:setTextureRect(cardNode:getTextureRect())
    end
  end
end
function prototype:initRotateCardInfo()
  self.cardRotateAni = Logic:Get("AniMgr"):NewCCB("UI/UIfanpai", self, ccp(97, 117), 0, nil, nil)
  self.cardRotateAni:setVisible(false)
  self.cardRotateAni:GetChild("imgBottom"):setDisplayFrame(self.imgCover:displayFrame())
end
function prototype:aniEnd()
  self.cardRotateAni:setVisible(false)
  self.imgIcon:setVisible(true)
end
function prototype:onBtnIconClicked()
  if self.imgIcon:isVisible() then
    return
  end
  local jade = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  local flopCost = Logic:Get("FoolsDay"):getCurFlopCost()
  if flopCost == 0 then
    self:flop()
    return
  end
  if jade < flopCost then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Prompt:ConfirmRecord(self, "", TwGetStr(111302, flopCost), self.flop, Prompt.PROMPT_TYPE.SELECT, nil, Logic.SureConfirm.RECORD_TYPE.FLOP)
end
function prototype:flop()
  if not self.index then
    return
  end
  if Logic:Get("FoolsDay"):isNextDay() then
    Prompt:Confirm(self, "", TwGetStr(111358), self.updateInfo, Prompt.PROMPT_TYPE.CONFIRM)
    return
  end
  Logic:Get("FoolsDay"):PostFlop(self.index)
end
function prototype:updateInfo()
  Logic:Get("FoolsDay"):getCurTime()
  Logic:Get("FoolsDay"):PostGetInfo()
end
function prototype:setTouchEnabled(bEnabled)
  self.btnIcon:setEnabled(bEnabled)
end
function prototype:rotateCard(baseId)
  self:setCardInfo(baseId, self.cardRotateAni:GetChild("imgTop"))
  self:setCardInfo(baseId, self.imgIcon)
  self.sprClick:setVisible(false)
  self.imgCover:setVisible(false)
  self.btnIcon:setEnabled(false)
  self.cardRotateAni:setVisible(true)
  self.cardRotateAni:RunAni(nil, nil, bind(self.aniEnd, self))
end
function prototype:clearShanEffect()
  Logic:Get("HeroCardInfo"):ClearShanCard(self.imgIcon)
end
function prototype:showShanEffect(baseId)
  self:addShanEffect(self.imgIcon, baseId)
end
function prototype:addShanEffect(node, baseId)
  local ccSprite = Logic:Get("HeroCardInfo"):GetShanCard(node, baseId, nil, true):GetLayer()
  if ccSprite == nil then
    return
  end
  ccSprite:setAnchorPoint(ccp(0, 0))
  ccSprite:setPosition(ccp(0, 0))
  local cardSz = ccSprite:getContentSize()
  local width = node and node:getContentSize().width or cardSz.width
  ccSprite:setScale(1 * (width / cardSz.width))
end
