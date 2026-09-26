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
L0_0 = "images/Rename/fntShopRename.png"
function prototype.onEnter(A0_1)
  local L1_2
  L1_2 = A0_1.nodInput
  L1_2 = L1_2.setPlaceHolder
  L1_2(L1_2, "")
  L1_2 = A0_1.nodInput
  L1_2 = L1_2.setFontSize
  L1_2(L1_2, 24)
  L1_2 = A0_1.nodInput
  L1_2 = L1_2.setMaxLens
  L1_2(L1_2, 12)
  L1_2 = A0_1.nodInput
  L1_2 = L1_2.setTouchPriority
  L1_2(L1_2, -255)
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Sect")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Sect.EVT.RENAME_SUCCESSED, A0_1:Event("onRenameSuccessed"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Sect")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Sect.EVT.RENAME_ERROR, A0_1:Event("onError"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "PlayerInfo")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.PlayerInfo.EVT.DATA_CHANGE, A0_1:Event("onDataChange"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "PlayerInfo")
  L1_2 = L1_2.SetResetNameType
  L1_2(L1_2, Logic.PlayerInfo.CHANGE_NAME.PLAYER_NAME)
  L1_2 = Logic
  L1_2 = L1_2.PlayerInfo
  L1_2 = L1_2.CHANGE_NAME
  L1_2 = L1_2.PLAYER_NAME
  A0_1.changeType = L1_2
  L1_2 = CCSprite
  L1_2 = L1_2.create
  L1_2 = L1_2(L1_2, _UPVALUE0_)
  if L1_2 then
    A0_1.sprTitle:setDisplayFrame(L1_2:displayFrame())
  end
  A0_1.sprTitle:setVisible(true)
  L1_2 = CCSprite:create("images/Rename/fntPlayerNameExist.png")
  if L1_2 then
    A0_1.sprError:setDisplayFrame(L1_2:displayFrame())
  end
  A0_1.ttfDesr:setStyle(kCCLabelTTFStyleOutline)
  A0_1.ttfDesr:setString("7\229\164\169\229\143\175\230\148\185\228\184\128\230\172\161")
  A0_1:addShopReturn()
end
function prototype.addShopReturn(A0_3)
  local L1_4, L2_5, L3_6
  L1_4 = A0_3.sprTitle
  if L1_4 then
    L1_4 = A0_3.sprTitle
    L2_5 = L1_4
    L1_4 = L1_4.getParent
    L1_4 = L1_4(L2_5)
  end
  L2_5 = CCSprite
  L3_6 = L2_5
  L2_5 = L2_5.create
  L2_5 = L2_5(L3_6, _UPVALUE0_)
  if L1_4 == nil or L2_5 == nil then
    return
  end
  L3_6 = L2_5.setAnchorPoint
  L3_6(L2_5, ccp(0.5, 0.5))
  L3_6 = L2_5.setPosition
  L3_6(L2_5, ccp(A0_3.sprTitle:getPositionX() + 210, A0_3.sprTitle:getPositionY()))
  L3_6 = L1_4.addChild
  L3_6(L1_4, L2_5, 40)
  A0_3.shopReturnSpr = L2_5
  L3_6 = CCLayer
  L3_6 = L3_6.create
  L3_6 = L3_6(L3_6)
  L3_6:setContentSize(CCSize(L2_5:getContentSize().width + 24, L2_5:getContentSize().height + 24))
  L3_6:setAnchorPoint(ccp(0.5, 0.5))
  L3_6:setPosition(ccp(L2_5:getPositionX(), L2_5:getPositionY()))
  L3_6:registerScriptTouchHandler(bind(A0_3.onShopReturnTouch, A0_3), false, -260, true)
  L3_6:setTouchEnabled(true)
  L1_4:addChild(L3_6, 41)
  A0_3.shopReturnHit = L3_6
end
function prototype.touchInNode(A0_7, A1_8, A2_9, A3_10)
  if not A1_8 then
    return false
  end
  if not A1_8:getParent() then
    return false
  end
  if A1_8:isIgnoreAnchorPointForPosition() then
    A1_8:getAnchorPoint().x = 0
    A1_8:getAnchorPoint().y = 0
  end
  return A1_8:getPositionLua().x - A1_8:getContentSize().width * A1_8:getAnchorPoint().x <= A1_8:getParent():convertToNodeSpace(ccp(A2_9, A3_10)).x and A1_8:getParent():convertToNodeSpace(ccp(A2_9, A3_10)).x <= A1_8:getPositionLua().x - A1_8:getContentSize().width * A1_8:getAnchorPoint().x + A1_8:getContentSize().width and A1_8:getPositionLua().y - A1_8:getContentSize().height * A1_8:getAnchorPoint().y <= A1_8:getParent():convertToNodeSpace(ccp(A2_9, A3_10)).y and A1_8:getParent():convertToNodeSpace(ccp(A2_9, A3_10)).y <= A1_8:getPositionLua().y - A1_8:getContentSize().height * A1_8:getAnchorPoint().y + A1_8:getContentSize().height
end
function prototype.onShopReturnTouch(A0_11, A1_12, A2_13, A3_14)
  if A1_12 ~= CCTOUCHBEGAN then
    return false
  end
  if not A0_11:touchInNode(A0_11.shopReturnHit, A2_13, A3_14) and not A0_11:touchInNode(A0_11.shopReturnSpr, A2_13, A3_14) then
    return false
  end
  A0_11:closeShopRename()
  return true
end
function prototype.closeShopRename(A0_15)
  Logic:Get("PlayerInfo"):SetShopRename(false)
  SceneHelper:removePrompt(A0_15.rootNode)
end
function prototype.onExit(A0_16)
  local L1_17
end
function prototype.onMenuClose(A0_18)
  A0_18:closeShopRename()
end
function prototype.onBtnEnter(A0_19)
  local L1_20
  L1_20 = A0_19.nodInput
  L1_20 = L1_20.getString
  L1_20 = L1_20(L1_20)
  if not L1_20 or "" == L1_20 then
    Prompt:Fail(TwGetStr(10054))
    return
  end
  if not Logic:Get("CreateHero"):checkName(L1_20) then
    return
  end
  Logic:Get("PlayerInfo"):PostResetName(L1_20)
end
function prototype.onBtnRandom(A0_21)
  A0_21.nodInput:setString(Logic:Get("CreateHero"):GetRename() or "")
end
function prototype.onDataChange(A0_22)
  if Logic:Get("PlayerInfo"):IsShopRename() then
    return
  end
  SceneHelper:removePrompt(A0_22.rootNode)
end
function prototype.onRenameSuccessed(A0_23)
  SceneHelper:removePrompt(A0_23.rootNode)
end
function prototype.onError(A0_24)
  A0_24.sprError:setVisible(true)
end
