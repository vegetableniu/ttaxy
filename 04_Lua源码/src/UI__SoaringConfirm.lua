module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  self.ttfRule:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTip:setStyle(kCCLabelTTFStyleOutline)
  self.ttfConfirm:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCancel:setStyle(kCCLabelTTFStyleOutline)
  self:SetBackGround()
  self.ttfTitle:setString(TwGetStr(115458))
  self.ttfTip:setString(TwGetStr(115459))
  self.ttfConfirm:setString(TwGetStr(115457))
  self.ttfCancel:setString(TwGetStr(103003))
  local rec = KFDBGetRecord("LanguageSetting", 1036 or 0) or {}
  local str = ReplaceStringTab(rec.content or "")
  self.ttfRule:setString(str)
end
function prototype:onBtnClose(sender, event)
end
function prototype:onBtnConfirm(sender, event)
  Logic:Get("Soaring"):PostCostRankUp()
  SceneHelper:removeScene("SoaringConfirm", self.rootNode)
end
function prototype:onBtnCancel(sender, event)
  SceneHelper:removeScene("SoaringConfirm", self.rootNode)
end
function prototype:SetBackGround()
  local bgSp = CCSprite:create("images/BattleShow/fightResult_bg.png")
  local bgTexture, bgTextureRect = Logic:Get("HeroCardInfo"):GetCardTexture(bgSp, nil, false, CCSize(640, 833))
  self.sprBg:setTexture(bgTexture)
  self.sprBg:setTextureRect(bgTextureRect)
end
