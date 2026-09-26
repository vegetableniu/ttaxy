module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
end
function prototype:ReFrashReward(giftInfo)
  if giftInfo == nil then
    return
  end
  local fraConfig = KFDBGetRecord("BaseHero", giftInfo.baseId)
  self.giftInfo = giftInfo
  self:createImg(giftInfo, fraConfig)
  self.ttfGiftInfo:setString(fraConfig.name)
  self.ttfGain:setString(TwGetStr(103022) .. fraConfig.fragment)
end
function prototype:createImg(giftInfo, fraConfig)
  local str = Logic:Get("Hero"):GetHeroBgImage(giftInfo.baseId, Logic.Hero.HEROIMG_SIZE.MIDDLE)
  local spr = CCSprite:create(str)
  self.sprHeroHead:setDisplayFrame(spr:displayFrame())
  local strGoods = Logic:Get("Hero"):GetHeroImage(giftInfo.baseId, Logic.Hero.HEROIMG_SIZE.MIDDLE)
  local sprGoods = CCSprite:create(strGoods)
  self.goodsImg:setDisplayFrame(sprGoods:displayFrame())
  local str, boolean = Logic:Get("Compose"):GetStaHero(giftInfo)
  local sprGoodsSta = CCSprite:create(str)
  self.sprFinish:setDisplayFrame(sprGoodsSta:displayFrame())
  self:createProgress(boolean)
end
function prototype:createProgress(boolean)
  if boolean == nil then
    return
  end
  self.btnGain:setEnabled(boolean)
end
function prototype:setBtnStage(boolean)
end
function prototype:onBtnGain()
  local str = ""
  local baseHero = KFDBGetRecord("BaseHero", self.giftInfo.baseId)
  str = TwGetStr(103024, baseHero.name) .. "\n" .. TwGetStr(103025, baseHero.fragment)
  Prompt:Confirm(self, 103023, str, self.GainGoods, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:GainGoods()
  Logic:Get("BGSound"):PlayEffect("audio/resolve.mp3")
  Logic:Get("Hero"):PostCrushHero(self.giftInfo.id)
end
function prototype:onBtnInfo()
  Logic:Get("HeroCardInfo"):OpenHeroInfo(self.giftInfo)
end
