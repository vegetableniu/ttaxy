module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
end
function prototype:ReFrashReward(giftInfo, index)
  self.btnGain:setEnabled(false)
  if giftInfo == nil then
    return
  end
  Logic:Get("HeroCardInfo"):ClearShanCardSmall(self.goodsImg)
  self.giftInfo = giftInfo
  self:createImg(giftInfo)
  self.ttfGain:setStyle(kCCLabelTTFStyleOutline)
  self.ttfGiftInfo:setString(giftInfo.name or "")
  self.ttfGain:setString(giftInfo.desc or "")
  local loadReward = Logic:Get("Groupbuy"):GetLoadRewardInfoVo()
  local count = giftInfo.count or 0
  self:setBtnStage(giftInfo)
  self:createProgress(giftInfo)
  local chargeCount = loadReward.chargeCount or 0
  local monthPlayers = loadReward.monthPlayers or 0
  local weekPlayers = loadReward.weekPlayers or 0
  local countAmount = {
    CHARGE = chargeCount,
    MONTH = monthPlayers,
    WEEK = weekPlayers
  }
  local str = TwGetStr(103016)
  str = str .. countAmount[giftInfo.type] .. "/" .. count
  self.ttfProgress:setStyle(kCCLabelTTFStyleOutline)
  self.ttfProgress:setString(str)
end
function prototype:createImg(giftInfo)
  giftInfo.description = {
    showType = giftInfo.showtype,
    showId = giftInfo.showid
  }
  local spr = Logic:Get("Gift"):createImg(giftInfo.description)
  if spr ~= nil then
    self.sprHeroHead:setDisplayFrame(spr:displayFrame())
    local strGoods, retBaseId, bIsFragment = Logic:Get("Gift"):createGoodsImg(giftInfo.description)
    if strGoods ~= nil then
      self.goodsImg:setDisplayFrame(strGoods:displayFrame())
      Logic:Get("HeroCardInfo"):AddShanCardSmall(self.goodsImg, retBaseId, nil, bIsFragment)
    end
    local sprFra = CCSprite:create("images/public/clarity80.png")
    self.sprCompose:setDisplayFrame(sprFra:displayFrame())
    if bIsFragment then
      local sprFra = Logic:Get("Compose"):GetJigsawImg()
      self.sprCompose:setDisplayFrame(sprFra:displayFrame())
    end
  end
end
function prototype:createProgress(giftInfo)
  local spr = Logic:Get("Gift"):createProgress(giftInfo)
  self.sprFinish:setDisplayFrame(spr:displayFrame())
  self.sprFinish:setAnchorPoint(CCPoint(0.5, 0.5))
end
function prototype:setBtnStage(giftInfo)
  local str = ""
  self.btnGain:setEnabled(giftInfo.canDraw)
  if giftInfo.canDraw then
    str = "images/public/btn_com_nor.png"
  else
    str = "images/public/btn_com_dis.png"
  end
  self.btnGain:setBackgroundSpriteForState(CCScale9Sprite:create(str), CCControlStateDisabled)
end
function prototype:onBtnGain()
  Logic:Get("Groupbuy"):PostGetReward(self.giftInfo.id, 1)
end
function prototype:onBtnInfo()
  if self.giftInfo.showtype == "HERO" then
    local fdb_baseHero = Logic:Get("HeroCardInfo"):kdbBaseHero(self.giftInfo.showid)
    if fdb_baseHero ~= nil then
      if fdb_baseHero.card == "HERO" then
        local heroInfo = {
          exp = 0,
          id = 68719480211,
          level = 1,
          baseId = self.giftInfo.showid or 1,
          powerSkill = 0
        }
        Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(heroInfo)
      else
        Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.giftInfo.showid)
      end
    end
  elseif self.giftInfo.showtype == "FRAGMENT" then
    local fraConfig = Logic:Get("Compose"):kdbItemConfig(self.giftInfo.showid)
    if fraConfig ~= nil then
      Logic:Get("HeroCardInfo"):OpenHeroInfoById(fraConfig.baseId, true, fraConfig.name)
    end
  end
end
