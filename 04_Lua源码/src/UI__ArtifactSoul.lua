module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local path = "images/public/selcet2.png"
function prototype:onEnter()
  self.ttfSoul:setString(TwGetStr(105901))
  self.ttfAuto:setString(TwGetStr(105904))
  local isOpenActivity = Logic:Get("Gift"):IsOpenActivity("BANSHU_ARTIFACT_SOUL")
  local actBei = Logic:Get("Egg"):GetCongifValueByKey("BEEEFFGEE:BANSHU_CRIT_PROGRESS_MULTIPLE")
  local normalBei = Logic:Get("Egg"):GetCongifValueByKey("BEEEFFGEE:CRIT_PROGRESS_MULTIPLE")
  local str = isOpenActivity and TwGetStr(105928, actBei) or TwGetStr(105919, normalBei)
  self.ttfTip2:setString(str)
  self:setStoneDesr()
  local bAutoBuy = Logic:Get("Artifact"):IsAutoBuy()
  if bAutoBuy then
    self:AddClicked(self.sprTip)
  end
  Logic:Get("Artifact"):On(Logic.Artifact.EVT.INJECT_SOULSTONE, self:Event("onInject"))
end
function prototype:onMenuClose(sender, event)
end
function prototype:onBtnInject50(sender, event)
  self:inject(50)
end
function prototype:onBtnSure(sender, event)
  self:inject(1)
end
function prototype:inject(soulCnt)
  local rec = KFDBGetRecord("ConfigValue", "BEEEFFGEE:LEVEL_COUNT")
  local maxLv = rec and tonumber(rec.content) or 0
  local currLv = Logic:Get("Artifact"):GetArtLevel()
  if maxLv <= currLv then
    Prompt:Fail(TwGetStr(105971))
    return
  end
  local bAutoBuy = Logic:Get("Artifact"):IsAutoBuy()
  local num = Logic:Get("Artifact"):GetSoulNum()
  local currLvSoulStone = Logic:Get("Artifact"):GetCurrLvSoulStone()
  if bAutoBuy then
    local rec = KFDBGetRecord("ConfigValue", "BEEEFFGEE:SOUL_STONE_PRICE")
    local cost = rec and tonumber(rec.content) or 0
    local num = Logic:Get("Artifact"):GetSoulNum()
    local actBuySoul = soulCnt - num - currLvSoulStone
    if actBuySoul < 0 then
      actBuySoul = 0 or actBuySoul
    end
    local money = Logic:Get("PlayerInfo"):GetPlayerAllJade()
    if money < cost * actBuySoul then
      SceneHelper:removePrompt(self.rootNode)
      Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
      Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
      return
    end
    if soulCnt <= 1 then
      Logic:Get("Artifact"):PostInjectSoulOnce()
      return
    end
    Logic:Get("Artifact"):PostInjectSoulRepeatedly()
    return
  end
  if soulCnt > num + currLvSoulStone then
    Prompt:Confirm(self, "", TwGetStr(105905), self.onComfirmBuy, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  if soulCnt <= 1 then
    Logic:Get("Artifact"):PostInjectSoulOnce()
    return
  end
  Logic:Get("Artifact"):PostInjectSoulRepeatedly()
end
function prototype:onBtnBuyClicked(sender, event)
  SceneHelper:runWithScene("Mall", self.rootNode)
end
function prototype:onBtnCancelClicked(sender, event)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnTipClicked(sender, event)
  local bAutoBuy = Logic:Get("Artifact"):IsAutoBuy()
  if bAutoBuy then
    Logic:Get("Artifact"):SetAutoBuy(false)
    self:removeClicked(self.sprTip)
    return
  end
  local rec = KFDBGetRecord("ConfigValue", "BEEEFFGEE:SOUL_STONE_PRICE")
  local cost = rec and tonumber(rec.content) or 0
  Prompt:Confirm(self, "", TwGetStr(105906, cost), self.onInjectSoul, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:AddClicked(node)
  if node == nil then
    return
  end
  local lockChild = node:getChildByTag(100)
  if lockChild ~= nil then
    node:removeChildByTag(100, true)
  end
  local spr = CCSprite:create(path)
  if spr then
    spr:setAnchorPoint(CCPoint(0.5, 0.5))
    local x = node:getContentSize().width / 2
    local y = node:getContentSize().height / 2
    spr:setPosition(ccp(x, y))
    node:addChild(spr, 10, 100)
  end
end
function prototype:removeClicked(node)
  if node == nil then
    return
  end
  local lockChild = node:getChildByTag(100)
  if lockChild ~= nil then
    node:removeChildByTag(100, true)
  end
end
function prototype:onBuySuccess()
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onComfirmBuy()
  self:onBtnBuyClicked()
end
function prototype:onInjectSoul()
  Logic:Get("Artifact"):SetAutoBuy(true)
  self:AddClicked(self.sprTip)
end
function prototype:setStoneDesr()
  local num = Logic:Get("Artifact"):GetSoulNum()
  self.ttfSoulNum:setString(num)
  local level = Logic:Get("Artifact"):GetArtLevel()
  local rec = KFDBGetRecord("BeeEffGeeLevelSetting", level)
  if rec == nil then
    return
  end
  local path = "images/public/clarity05.png"
  if rec.stoneType ~= "NORMAL" then
    path = Logic:Get("Artifact"):GetIconByType(rec.stoneType)
  end
  local spr = CCSprite:create(path)
  if spr then
    self.sprSoulCoin:setDisplayFrame(spr:displayFrame())
  end
  local str = Logic:Get("Artifact"):GetCurrLvStoneTypeStr()
  if str == "" then
    self.ttfSoulCoin:setString("")
    self.ttfSoulCoinNum:setString("")
    self.ttfTip:setString(TwGetStr(105903, ""))
    self.nodTip:setString("")
    return
  end
  self.ttfTip:setString("")
  self.ttfSoulCoin:setString(str .. ":")
  local soulStoneSp = Logic:Get("Artifact"):GetCurrLvSoulStone()
  self.ttfSoulCoinNum:setString(soulStoneSp)
  local strRed = string.format(TwGetStr(104248) .. "%s" .. "</font>", TwGetStr(105918, str))
  local strBlack = "<font color='#000000' SIZE='24'>" .. TwGetStr(105903, strRed) .. "</font>"
  self.nodTip:setString(strBlack, kCCLabelTTFStyleSimple)
end
function prototype:onInject()
  self:setStoneDesr()
  local injectNum = Logic:Get("Artifact"):GetInjectNum()
  if injectNum ~= 1 then
    return
  end
  self.aniSuccussed = Logic:Get("AniMgr"):NewCCB("UI/UIsqsj05", self, ccp(130, 600), 0, nil, 1)
  if self.aniSuccussed then
    self.aniSuccussed:RunAni()
  end
  local critNum = Logic:Get("Artifact"):GetCritNum()
  if critNum > 0 then
    self.aniCrit = Logic:Get("AniMgr"):NewCCB("UI/UIsqsj04", self, ccp(130, 620), 0, nil, 1)
    if self.aniCrit then
      self.aniCrit:RunAni()
    end
  end
end
