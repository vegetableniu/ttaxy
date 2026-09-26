module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype.onEnter(A0_0)
  A0_0.btnFabao:setZoomOnTouchDown(false)
  A0_0.btnBg:setZoomOnTouchDown(false)
end
function prototype.onBtnFabao(A0_1)
  local L1_2
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Talisman")
  L1_2 = L1_2.advanceMode
  if L1_2 == true then
    L1_2 = require
    L1_2 = L1_2("FabaoTranslate")
    if Logic:Get("Talisman"):GetUpgradeFabao() == nil then
      Prompt:Tip("\232\175\183\233\128\137\230\139\169\230\169\153\232\137\178\230\179\149\229\174\157")
      return
    end
    if (Logic:Get("Talisman"):GetUpgradeFabao().level or 0) < 10 then
      Prompt:Fail("10\231\186\167\230\179\149\229\174\157\230\137\141\232\131\189\229\144\158\229\153\172")
      return
    end
    L1_2.SetPickMode("advanceMaterial")
    SceneHelper:pushScene("FabaoTransSelect", A0_1.rootNode)
    return
  end
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Talisman")
  L1_2 = L1_2.GetUpgradeFabao
  L1_2 = L1_2(L1_2)
  if L1_2 == nil then
    Prompt:Fail(112042)
    return
  end
  if Logic:Get("Talisman"):IsInMaxLevel(L1_2) then
    Prompt:Fail(112039)
    return
  end
  if Logic:Get("Talisman"):canSwallFabao() == nil or #Logic:Get("Talisman"):canSwallFabao() == 0 then
    Prompt:Fail(TwGetStr(112041))
    return
  end
  SceneHelper:pushScene("FabaoSwallowSelect", A0_1.rootNode)
end
function prototype.Init(A0_3, A1_4)
  if A1_4 then
    A0_3.btnFabao:setBackgroundSpriteForState(CCScale9Sprite:create("images/Common/_blank.png"), CCControlStateNormal)
    A0_3.btnFabao:setBackgroundSpriteForState(CCScale9Sprite:create("images/Common/_blank.png"), CCControlStateHighlighted)
    A0_3.btnFabao:setBackgroundSpriteForState(CCScale9Sprite:create("images/Common/_blank.png"), CCControlStateDisabled)
    A0_3.btnBg:setBackgroundSpriteForState(CCScale9Sprite:create("images/Common/_blank.png"), CCControlStateNormal)
    A0_3.btnBg:setBackgroundSpriteForState(CCScale9Sprite:create("images/Common/_blank.png"), CCControlStateHighlighted)
    A0_3.btnBg:setBackgroundSpriteForState(CCScale9Sprite:create("images/Common/_blank.png"), CCControlStateDisabled)
  else
    A0_3.btnFabao:setBackgroundSpriteForState(CCScale9Sprite:create("images/Common/selcet3.png"), CCControlStateNormal)
    A0_3.btnFabao:setBackgroundSpriteForState(CCScale9Sprite:create("images/Common/selcet3.png"), CCControlStateHighlighted)
    A0_3.btnFabao:setBackgroundSpriteForState(CCScale9Sprite:create("images/Common/selcet3.png"), CCControlStateDisabled)
  end
end
