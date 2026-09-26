module((...), package.seeall)
local Define = require("BattleShow.BattleDefine")
local FONT = Define.FONT
local OUTPUT_IMG = Define.OUTPUT_IMG
class = require("BattleShow.OutPut.Base").class:subclass()
function class:initialize(num, target, status)
  super.initialize(self)
  num = num or 0
  local bCrit = status:IsStatus("CRIT")
  local bRestrain = status:IsStatus("RESTRAIN")
  local bDodge = status:IsStatus("DODGE")
  local bFail = status:IsStatus("FAIL")
  local bBig = status:IsStatus("BIG")
  if num == 0 and not bDodge and not bFail then
    return
  end
  if bDodge and bCrit then
    bCrit = num ~= 0
    bDodge = num == 0
  end
  local fontTb = num and num > 0 and FONT.HEAL or FONT.HURT
  local imgPath
  if bDodge or bFail then
    num = 0
    imgPath = OUTPUT_IMG.DODGE
  elseif bRestrain then
    num = num or 0
    imgPath = OUTPUT_IMG.RESTRAIN
  end
  local outLb = self:Create(num, imgPath, fontTb)
  if bCrit and num ~= 0 then
    local critSp = CCSprite:create(OUTPUT_IMG.CRIT)
    critSp:setOpacity(200)
    critSp:setScale(0.5)
    critSp:setAnchorPoint(ccp(0.5, 0.5))
    outLb:addChild(critSp)
  end
  local scaleMulti = bCrit and 1.3 * self.baseScale or self.baseScale
  self:Out(outLb, target, scaleMulti, bBig)
end
