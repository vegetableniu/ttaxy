module((...), package.seeall)
local Define = require("BattleShow.BattleDefine")
local FONT = Define.FONT
class = require("BattleShow.OutPut.Base").class:subclass()
local baseScale = 0.7
function class:initialize(num, target, imgPath, status)
  super.initialize(self)
  num = num or 0
  local bCrit = status:IsStatus("CRIT")
  local bRestrain = status:IsStatus("RESTRAIN")
  local bDodge = status:IsStatus("DODGE")
  local bFail = status:IsStatus("FAIL")
  local bBig = status:IsStatus("BIG")
  if bDodge and bCrit then
    bCrit = num ~= 0
    bDodge = num == 0
  end
  local fontTb = num and num > 0 and FONT.HEAL or FONT.HURT
  local outLb = self:Create(num, imgPath, fontTb)
  if bCrit and num ~= 0 then
    local critSp = CCSprite:create(OUTPUT_IMG.CRIT)
    critSp:setOpacity(200)
    critSp:setScale(0.5)
    critSp:setAnchorPoint(ccp(0.5, 0.5))
    outLb:addChild(critSp)
  end
  if outLb ~= nil then
    self:Out(outLb, target, baseScale, bBig)
  end
end
