local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = Tw
L0_0 = L0_0.Controller
L0_0 = L0_0.prototype
L0_0 = L0_0.extend
L0_0 = L0_0(L0_0)
prototype = L0_0
L0_0 = require
L0_0("SceneHelper")
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.moon.model.MoonType")
function prototype.onEnter(A0_1)
  A0_1.groupData = _UPVALUE0_():GetGroupData()
  A0_1:setTitle()
  A0_1.content:setStyle(kCCLabelTTFStyleOutline)
  A0_1.content:setString(A0_1.groupData.packDesr or "")
  A0_1.content:setDimensions(CCSize(460, 0))
  A0_1.moonInfo = _UPVALUE0_():GetMoonCount()
  A0_1.nodMoon:create(0, "GREEN_NUM")
  A0_1.nodMoon:setAlign("LEFT", "CENTER")
  A0_1.nodMoon:setValue(A0_1.moonInfo[_UPVALUE1_.MOON] or 0)
  if table.empty(json.decode(A0_1.groupData.costs or "[]") or {}) then
    A0_1.nodMoonCake:setVisible(false)
  end
  A0_1.ttfRank:setStyle(kCCLabelTTFStyleOutline)
  if A0_1.groupData.group == 4 then
    A0_1.ttfRank:setString(TwGetStr(115010))
  else
    A0_1.ttfRank:setString(TwGetStr(115016))
  end
end
function prototype.onExit(A0_2)
  local L1_3
end
function prototype.setTitle(A0_4)
  local L1_5
  L1_5 = {
    "fntBenYue.png",
    "fntChangE.png",
    "fntHouYi.png",
    "fntHuanLe.png"
  }
  if L1_5[A0_4.groupData.group] and CCSprite:create("images/Moon/" .. L1_5[A0_4.groupData.group]) then
    A0_4.sprTitle:setDisplayFrame(CCSprite:create("images/Moon/" .. L1_5[A0_4.groupData.group]):displayFrame())
  end
end
function prototype.onMenuClose(A0_6)
  SceneHelper:removePrompt(A0_6.rootNode)
end
function prototype.onBtnMake(A0_7)
  if table.empty(Logic:Get("Gift"):GetActivityByType("SPRING") or {}) then
    return
  end
  Logic:Get("Gift"):SetActivityGift(Logic:Get("Gift"):GetActivityByType("SPRING")[1])
  SceneHelper:runWithScene("Moon", A0_7.rootNode)
end
function prototype.onBtnExchange(A0_8)
  if table.empty(json.decode(A0_8.groupData.costs or "[]") or {}) then
    if Logic:Get("PlayerInfo"):GetPlayerAllJade() < A0_8.groupData.count then
      Logic:Get("Main"):PromptCharge()
      return
    end
    _UPVALUE0_():PostExchange(A0_8.groupData.group)
    SceneHelper:removePrompt(A0_8.rootNode)
    return
  end
  if (A0_8.moonInfo[_UPVALUE1_.MOON] or 0) < json.decode(A0_8.groupData.costs or "[]")[1].amount then
    Prompt:Confirm(A0_8, "", TwGetStr(115007), A0_8.onBtnMake)
    SceneHelper:removePrompt(A0_8.rootNode)
    return
  end
  _UPVALUE0_():PostExchange(A0_8.groupData.group)
  SceneHelper:removePrompt(A0_8.rootNode)
end
