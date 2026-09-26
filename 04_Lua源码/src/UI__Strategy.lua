module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype.initialize(A0_0)
  super.initialize(A0_0)
end
function prototype.onEnter(A0_1)
  local L1_2, L2_3, L3_4, L4_5
  L1_2 = super
  L1_2 = L1_2.onEnter
  L2_3 = A0_1
  L1_2(L2_3)
  L1_2 = A0_1.lstStrategy
  L2_3 = L1_2
  L1_2 = L1_2.getPosition
  L2_3 = L1_2(L2_3)
  L3_4 = A0_1.lstStrategy
  L4_5 = L3_4
  L3_4 = L3_4.getContentSize
  L3_4 = L3_4(L4_5)
  L4_5 = Logic
  L4_5 = L4_5.Get
  L4_5 = L4_5(L4_5, "System")
  L4_5 = L4_5.GetServerHTTPURL
  L4_5 = L4_5(L4_5, "/guide.html?page=demog")
  if L4_5 == nil then
    Prompt:Tip("\231\142\169\230\179\149\232\175\180\230\152\142\230\154\130\230\151\182\230\151\160\230\179\149\230\137\147\229\188\128")
    return
  end
  Logic:Get("EnvLogic"):OpenUrlInRect(L4_5, {
    L1_2,
    L2_3,
    L3_4.width,
    L3_4.height
  })
end
function prototype.onExit(A0_6)
  Logic:Get("EnvLogic"):CloseWebPage()
end
function prototype.onBtnReturn(A0_7)
  SceneHelper:popScene()
end
