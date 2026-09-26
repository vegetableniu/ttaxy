module((...), package.seeall)
local Define = require("BattleShow.BattleDefine")
local FONT = Define.FONT
local OUTPUT_IMG = Define.OUTPUT_IMG
class = require("BattleShow.OutPut.Base").class:subclass()
local baseScale = 0.7
function class:initialize(num, target, status, count)
  super.initialize(self)
  num = num or 0
  local bCrit = status:IsStatus("CRIT")
  local bRestrain = status:IsStatus("RESTRAIN")
  local bDodge = status:IsStatus("DODGE")
  local bFail = status:IsStatus("FAIL")
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
  self:Out(outLb, target, scaleMulti, count)
end
function class:Out(lb, target, scaleMulti, count)
  target:getParent():addChild(lb, 99)
  local pos = self:GetOutPutPos(target)
  lb:setPosition(ccp(pos.x, pos.y))
  lb:setVisible(true)
  lb:setOpacity(255)
  lb:setScale(1)
  local actions = CCArray:create()
  local scaleTo = CCScaleTo:create(0.13999999999999999, 3 * scaleMulti)
  local scaleRev = CCScaleTo:create(0.13999999999999999, 1.5 * scaleMulti)
  local delay1 = CCDelayTime:create(0.7)
  local scaleOut = CCScaleTo:create(0.13999999999999999, 0)
  local hide = CCHide:create()
  actions:addObject(scaleTo)
  actions:addObject(scaleRev)
  actions:addObject(delay1)
  actions:addObject(scaleOut)
  actions:addObject(hide)
  actions:addObject(CCCallFuncN:create(function()
    target:getParent():removeChild(lb, true)
  end))
  lb:runAction(CCSequence:create(actions))
end
function class:GetOutPutPos(target, count)
  local posX, posY = target:getPosition()
  return {
    x = posX,
    y = posY + (count * 20 - 10)
  }
end
