module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  self.btnSure:setEnabled(false)
  Singleton(Timer):After(3000, self:Event("setGoOn"))
  if Logic:Get("Gift"):IsOpenActivity("OPEN_BETA_GOODS") then
    local path = "images/BigImg/openBeta.png"
    self:SetBg(path)
    return
  end
  if Logic:Get("Gift"):IsOpenActivity("CONSUME_RANK") then
    local path = "images/BigImg/costRank.png"
    self:SetBg(path)
    return
  end
  if Logic:Get("Gift"):IsOpenActivity("OLD_USER_CHARGE_TREBLE") then
    local path = "images/BigImg/adChargeTrible.png"
    self:SetBg(path)
    self.ttfTime:setStyle(kCCLabelTTFStyleOutline)
    local strTab = Logic:Get("Gift"):GetTimeStrByType("OLD_USER_CHARGE_TREBLE")
    if not table.empty(strTab or {}) then
      self.ttfTime:setString(TwGetStr(103362, strTab[1]))
    end
    return
  end
  local level = Logic:Get("PlayerInfo"):GetPlayerLevel()
  if level >= 60 and level <= 67 then
    local path = "images/BigImg/adFullBattle.png"
    self:SetBg(path)
    return
  end
  if level >= 68 and level < 70 then
    local path = "images/BigImg/adQianNv.png"
    self:SetBg(path)
    return
  end
  if level >= 70 and level <= 74 then
    local path = "images/BigImg/adDragonBattle.png"
    self:SetBg(path)
    return
  end
  if level >= 75 and level <= 89 then
    local path = "images/BigImg/adDragonBattle.png"
    self:SetBg(path)
    return
  end
  if level >= 90 then
    local rulaiPath = "images/BigImg/rulaiAd.png"
    local culaPath = "images/BigImg/cultivateAd.png"
    local ran = math.random(1, 2)
    local path = ran == 1 and rulaiPath or culaPath
    self:SetBg(path)
  end
end
function prototype:SetBg(path)
  local spr = CCSprite:create(path)
  if spr then
    self.imgBg:setDisplayFrame(spr:displayFrame())
    self.imgBg:setScale(1.25)
  end
end
function prototype:onBtnSure(node, loader)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onMenuClose(node, loader)
end
function prototype:onExit()
end
function prototype:setGoOn()
  if self.eventTracer:Exist("setGoOn") then
    self:EventTracer():Cancel("setGoOn")
  end
  self.btnSure:setEnabled(true)
  local ccSprite = CCSprite:create("images/font/click_go_on.png")
  if ccSprite ~= nil then
    self.rootNode:addChild(ccSprite, 0, 10)
    local seq1 = Logic:Get("Gift"):fadetoSpr()
    ccSprite:runAction(CCRepeatForever:create(seq1))
    ccSprite:setPosition(self.goOn:getPosition())
  end
end
