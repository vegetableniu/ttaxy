module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype.onEnter(A0_0)
  local L1_1, L2_2, L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L11_11, L12_12, L13_13, L14_14, L15_15, L16_16
  L1_1(L2_2)
  for L4_4 = 1, 3 do
    L8_8 = L4_4
    L8_8 = L7_7
    L7_7(L8_8, L9_9)
    L8_8 = L7_7
    L7_7(L8_8, L9_9)
  end
  A0_0.pos = L1_1
  for L4_4 = 1, 6 do
    if L6_6 then
      L6_6(L7_7)
      L8_8 = A0_0.pos
      L8_8[L4_4] = L9_9
      L8_8 = A0_0.pos
      L8_8 = L8_8[L4_4]
      L8_8.x = L6_6
      L8_8 = A0_0.pos
      L8_8 = L8_8[L4_4]
      L8_8.y = L7_7
    end
  end
  if L1_1 == L2_2 then
    L4_4 = "Battle"
    L4_4 = L3_3
    L4_4 = L3_3
    if not L3_3 then
      L4_4 = A0_0.btnCamBegin
      L4_4 = L4_4.setVisible
      L4_4(L5_5, L6_6)
      L4_4 = A0_0.btnJump
      L4_4 = L4_4.setVisible
      L4_4(L5_5, L6_6)
      L4_4 = A0_0.btnAreBegin
      L4_4 = L4_4.setVisible
      L4_4(L5_5, L6_6)
      L4_4 = A0_0.imgBegin
      L4_4 = L4_4.setVisible
      L4_4(L5_5, L6_6)
      L4_4 = A0_0.imgAreBegin
      L4_4 = L4_4.setVisible
      L4_4(L5_5, L6_6)
      L4_4 = A0_0.imgJump
      L4_4 = L4_4.setVisible
      L4_4(L5_5, L6_6)
    else
      L4_4 = A0_0.btnCamBegin
      L4_4 = L4_4.setVisible
      L4_4(L5_5, L6_6)
      L4_4 = A0_0.btnJump
      L4_4 = L4_4.setVisible
      L4_4(L5_5, L6_6)
      L4_4 = A0_0.btnAreBegin
      L4_4 = L4_4.setVisible
      L4_4(L5_5, L6_6)
      L4_4 = A0_0.imgBegin
      L4_4 = L4_4.setVisible
      L4_4(L5_5, L6_6)
      L4_4 = A0_0.imgAreBegin
      L4_4 = L4_4.setVisible
      L4_4(L5_5, L6_6)
      L4_4 = A0_0.imgJump
      L4_4 = L4_4.setVisible
      L4_4(L5_5, L6_6)
      L4_4 = Logic
      L4_4 = L4_4.Get
      L4_4 = L4_4(L5_5, L6_6)
      L4_4 = L4_4.IsOpenFunc
      L4_4 = L4_4(L5_5)
      if not L4_4 then
        L8_8 = A0_0.IsSatisfyLevel
        L8_8 = L8_8(L9_9)
      else
        if L8_8 then
          L8_8 = A0_0.btnJump
          L8_8 = L8_8.setBackgroundSpriteForState
          L12_12 = L5_5
          L8_8(L9_9, L10_10, L11_11)
          L8_8 = A0_0.btnJump
          L8_8 = L8_8.setBackgroundSpriteForState
          L12_12 = L6_6
          L8_8(L9_9, L10_10, L11_11)
          L8_8 = A0_0.btnJump
          L8_8 = L8_8.setBackgroundSpriteForState
          L12_12 = L7_7
          L8_8(L9_9, L10_10, L11_11)
          L8_8 = A0_0.SetButtonsStatus
          L8_8(L9_9)
      end
      else
        L8_8 = A0_0.btnJump
        L8_8 = L8_8.setBackgroundSpriteForState
        L12_12 = L7_7
        L8_8(L9_9, L10_10, L11_11)
        L8_8 = A0_0.btnJump
        L8_8 = L8_8.setBackgroundSpriteForState
        L12_12 = L7_7
        L8_8(L9_9, L10_10, L11_11)
        L8_8 = A0_0.btnJump
        L8_8 = L8_8.setBackgroundSpriteForState
        L12_12 = L7_7
        L8_8(L9_9, L10_10, L11_11)
      end
    end
  else
    L4_4 = false
    L2_2(L3_3, L4_4)
    L4_4 = true
    L2_2(L3_3, L4_4)
    L4_4 = false
    L2_2(L3_3, L4_4)
    L4_4 = false
    L2_2(L3_3, L4_4)
    L4_4 = true
    L2_2(L3_3, L4_4)
    L4_4 = false
    L2_2(L3_3, L4_4)
  end
  L4_4 = "Hero"
  L4_4 = L3_3
  L4_4 = L3_3
  L4_4 = Logic
  L4_4 = L4_4.Get
  L4_4 = L4_4(L5_5, L6_6)
  L4_4 = L4_4.GetHeroInfosByIds
  L4_4 = L4_4(L5_5, L6_6)
  for L8_8 = 1, #L2_2 do
    for L12_12 = 1, #L10_10 do
      L13_13 = L8_8 - 1
      L13_13 = L13_13 * 2
      L13_13 = L13_13 + L12_12
      L14_14 = string
      L14_14 = L14_14.format
      L15_15 = "ccbHero%d"
      L16_16 = L13_13
      L14_14 = L14_14(L15_15, L16_16)
      if not L14_14 then
        return
      end
      L15_15 = {
        L16_16,
        L12_12 - 1
      }
      L16_16 = L8_8 - 1
      L16_16 = A0_0[L14_14]
      L16_16 = L16_16.SetTagEmbattle
      L16_16(L16_16, L15_15)
      L16_16 = L2_2[L8_8]
      L16_16 = L16_16[L12_12]
      if L16_16 ~= ID[0] then
        L16_16 = L2_2[L8_8]
        L16_16 = L16_16[L12_12]
        if L16_16 ~= ID[-1] then
          L16_16 = Logic
          L16_16 = L16_16.Get
          L16_16 = L16_16(L16_16, "Hero")
          L16_16 = L16_16.GetHeroInfoById
          L16_16 = L16_16(L16_16, L2_2[L8_8][L12_12])
          if not L16_16 then
            return
          end
          A0_0[L14_14]:SetImage(L16_16)
          A0_0[L14_14]:SetHeroInfo(L16_16)
        end
      else
        L16_16 = L2_2[L8_8]
        L16_16 = L16_16[L12_12]
        if L16_16 == ID[-1] then
          L16_16 = Logic
          L16_16 = L16_16.Get
          L16_16 = L16_16(L16_16, "Hero")
          L16_16 = L16_16.GetHelperInfo
          L16_16 = L16_16(L16_16)
          if L16_16 then
            A0_0[L14_14]:SetHeroInfo(L16_16)
            A0_0[L14_14]:SetImage(L16_16)
            table.insert(L4_4, L16_16)
          end
        end
      end
    end
  end
  for L8_8 = 1, 3 do
    L12_12 = L8_8
    L12_12 = L11_11
    L13_13 = false
    L11_11(L12_12, L13_13)
    L12_12 = L11_11
    L13_13 = false
    L11_11(L12_12, L13_13)
  end
  L5_5(L6_6)
  L5_5(L6_6)
end
function prototype.IsSatisfyLevel(A0_17)
  return not Logic:Get("Lock"):checkStatusById("SKIP_LV")
end
function prototype.SetButtonsStatus(A0_18)
  local L1_19, L2_20, L3_21, L4_22, L5_23, L6_24, L7_25, L8_26, L9_27, L10_28
  L1_19 = Logic
  L2_20 = L1_19
  L1_19 = L1_19.Get
  L3_21 = "PlayerInfo"
  L1_19 = L1_19(L2_20, L3_21)
  L2_20 = L1_19
  L1_19 = L1_19.GetPlayerMoney
  L1_19 = L1_19(L2_20)
  if not L1_19 then
    L2_20 = 0
  elseif not L2_20 then
    L2_20 = L1_19.totalCharge
    L2_20 = L2_20 or 0
  end
  if L2_20 >= 10000 then
    L3_21 = A0_18.nodeBtnCamBegin
    L4_22 = L3_21
    L3_21 = L3_21.setVisible
    L5_23 = true
    L3_21(L4_22, L5_23)
    L3_21 = A0_18.nodeBtnAreBegin
    L4_22 = L3_21
    L3_21 = L3_21.setVisible
    L5_23 = false
    L3_21(L4_22, L5_23)
    L3_21 = A0_18.nodeBtnJump
    L4_22 = L3_21
    L3_21 = L3_21.setVisible
    L5_23 = true
    L3_21(L4_22, L5_23)
    L3_21 = A0_18.nodeBtnSkip8
    L4_22 = L3_21
    L3_21 = L3_21.setVisible
    L5_23 = true
    L3_21(L4_22, L5_23)
    L3_21 = A0_18.nodeBtnJump
    L4_22 = L3_21
    L3_21 = L3_21.getPositionLua
    L3_21 = L3_21(L4_22)
    L4_22 = A0_18.nodeBtnCamBegin
    L5_23 = L4_22
    L4_22 = L4_22.setPosition
    L10_28 = L6_24(L7_25, L8_26)
    L4_22(L5_23, L6_24, L7_25, L8_26, L9_27, L10_28, L6_24(L7_25, L8_26))
    L4_22 = A0_18.nodeBtnJump
    L5_23 = L4_22
    L4_22 = L4_22.setPosition
    L10_28 = L6_24(L7_25, L8_26)
    L4_22(L5_23, L6_24, L7_25, L8_26, L9_27, L10_28, L6_24(L7_25, L8_26))
    L4_22 = A0_18.nodeBtnSkip8
    L5_23 = L4_22
    L4_22 = L4_22.setPosition
    L10_28 = L6_24(L7_25, L8_26)
    L4_22(L5_23, L6_24, L7_25, L8_26, L9_27, L10_28, L6_24(L7_25, L8_26))
    L4_22 = L2_20 < 30000
    L5_23 = A0_18.skipAdvanceDecorations
    if L5_23 == nil then
      L5_23 = {}
      A0_18.skipAdvanceDecorations = L5_23
      L5_23 = A0_18.nodeBtnSkip8
      L5_23 = L5_23.getChildren
      L5_23 = L5_23(L6_24)
      if L5_23 then
        for L9_27 = 1, L7_25(L8_26) do
          L10_28 = L5_23.objectAtIndex
          L10_28 = L10_28(L5_23, L9_27 - 1)
          if L10_28 ~= A0_18.btnSkip8 then
            table.insert(A0_18.skipAdvanceDecorations, L10_28)
          end
        end
      end
    end
    L5_23 = A0_18.skipAdvanceSprite
    if L5_23 == nil then
      L5_23 = CCSprite
      L5_23 = L5_23.create
      L5_23 = L5_23(L6_24, L7_25)
      A0_18.skipAdvanceSprite = L5_23
      L5_23 = A0_18.skipAdvanceSprite
      if L5_23 then
        L5_23 = A0_18.skipAdvanceSprite
        L5_23 = L5_23.setPosition
        L9_27 = 0
        L10_28 = L7_25(L8_26, L9_27)
        L5_23(L6_24, L7_25, L8_26, L9_27, L10_28, L7_25(L8_26, L9_27))
        L5_23 = A0_18.nodeBtnSkip8
        L5_23 = L5_23.addChild
        L5_23(L6_24, L7_25, L8_26)
      end
    end
    L5_23 = A0_18.skipAdvanceSprite
    if L5_23 then
      L5_23 = A0_18.skipAdvanceSprite
      L5_23 = L5_23.setVisible
      L5_23(L6_24, L7_25)
    end
    L5_23 = L4_22 and L5_23 ~= nil
    for L9_27 = 1, #L7_25 do
      L10_28 = A0_18.skipAdvanceDecorations
      L10_28 = L10_28[L9_27]
      L10_28 = L10_28.setVisible
      L10_28(L10_28, not L5_23)
    end
  end
end
function prototype.Touch(A0_29)
  local L1_30, L2_31, L3_32, L4_33, L5_34, L6_35, L7_36, L8_37, L9_38
  function L3_32(A0_39, A1_40)
    return A0_39:getPosition() - A0_39:getContentSize().width / 2 < A1_40.x and A0_39:getPosition() - A0_39:getContentSize().height / 2 < A1_40.y and A1_40.x < A0_39:getPosition() - A0_39:getContentSize().width / 2 + A0_39:getContentSize().width and A1_40.y < A0_39:getPosition() - A0_39:getContentSize().height / 2 + A0_39:getContentSize().height
  end
  function L4_33(A0_41)
    local L1_42
    L1_42 = {
      "ccbHero1",
      "ccbHero2",
      "ccbHero3",
      "ccbHero4",
      "ccbHero5",
      "ccbHero6"
    }
    for _FORV_5_ = 1, #L1_42 do
      if _UPVALUE0_(_UPVALUE1_[L1_42[_FORV_5_]], A0_41) then
        return _UPVALUE1_[L1_42[_FORV_5_]]
      end
    end
  end
  function L5_34(A0_43, A1_44)
    _UPVALUE0_ = _UPVALUE1_({x = A0_43, y = A1_44})
    if _UPVALUE0_ == nil then
      _UPVALUE2_ = nil
      _UPVALUE0_ = nil
      return false
    end
    if _UPVALUE0_ then
      _UPVALUE2_ = {
        x = _UPVALUE0_:getPosition()
      }
      _UPVALUE3_.rootNode:reorderChild(_UPVALUE0_, 0)
    end
    return true
  end
  function L6_35(A0_45, A1_46)
    if _UPVALUE0_ and _UPVALUE1_ then
      _UPVALUE0_:setPosition(A0_45, A1_46)
    end
  end
  function L7_36(A0_47, A1_48)
    local L2_49, L3_50, L4_51, L5_52
    if not A0_47 or not A1_48 then
      return
    end
    L3_50 = A0_47
    L2_49 = A0_47.GetHeroInfo
    L2_49 = L2_49(L3_50)
    L4_51 = A1_48
    L3_50 = A1_48.GetHeroInfo
    L3_50 = L3_50(L4_51)
    if not L2_49 then
      return
    end
    L5_52 = A0_47
    L4_51 = A0_47.GetTagEmbattle
    L4_51 = L4_51(L5_52)
    L5_52 = A1_48.GetTagEmbattle
    L5_52 = L5_52(A1_48)
    if L4_51 and L5_52 then
      Logic:Get("Hero"):PostSetEmbattle(L4_51, L5_52)
    end
    if not L3_50 then
      A1_48:SetHeroInfo(L2_49)
      A1_48:SetImage(L2_49)
      A0_47:SetHeroInfo(nil)
      A0_47:SetImage(nil)
      return
    end
    A1_48:SetHeroInfo(L2_49)
    A0_47:SetHeroInfo(L3_50)
    A0_47:SetImage(L3_50)
    A1_48:SetImage(L2_49)
  end
  function L8_37(A0_53, A1_54)
    local L2_55, L3_56, L4_57, L5_58
    for L5_58 = 1, 6 do
      if _UPVALUE0_[string.format("ccbHero%d", L5_58)] then
        _UPVALUE0_[string.format("ccbHero%d", L5_58)]:setPosition(_UPVALUE0_.pos[L5_58].x, _UPVALUE0_.pos[L5_58].y)
      end
    end
    if L2_55 then
      if L2_55 then
        L5_58 = _UPVALUE2_
        L5_58 = L5_58.y
        L2_55(L3_56, L4_57, L5_58)
        L3_56.x = A0_53
        L3_56.y = A1_54
        if L2_55 then
          L5_58 = L2_55
          L3_56(L4_57, L5_58)
        end
      end
    end
    _UPVALUE1_ = L2_55
    _UPVALUE2_ = L2_55
  end
  function L9_38(A0_59, A1_60, A2_61)
    if A0_59 == CCTOUCHBEGAN then
      return _UPVALUE0_(A1_60, A2_61)
    elseif A0_59 == CCTOUCHMOVED then
      return _UPVALUE1_(A1_60, A2_61)
    else
      return _UPVALUE2_(A1_60, A2_61)
    end
  end
  A0_29.rootNode:registerScriptTouchHandler(L9_38)
  A0_29.rootNode:setTouchEnabled(true)
end
function prototype.onBtnReturn(A0_62)
  SceneHelper:popScene()
  Logic:Get("Battle"):FireEvent(Logic.Battle.EVT.EMBATTLE_SCENE_RETURN)
end
function prototype.onBegin(A0_63)
  local L1_64
  L1_64 = Logic
  L1_64 = L1_64.Get
  L1_64 = L1_64(L1_64, "Main")
  L1_64 = L1_64.CuMengMain
  L1_64(L1_64, "onBegin")
  L1_64 = Logic
  L1_64 = L1_64.Get
  L1_64 = L1_64(L1_64, "Main")
  L1_64 = L1_64.CuMengMainGuide
  L1_64(L1_64, "FirstBattle", "Fight")
  L1_64 = Logic
  L1_64 = L1_64.Get
  L1_64 = L1_64(L1_64, "Guide")
  L1_64 = L1_64.done
  L1_64(L1_64, "Partner", "Fight")
  L1_64 = Logic
  L1_64 = L1_64.Get
  L1_64 = L1_64(L1_64, "Guide")
  L1_64 = L1_64.done
  L1_64(L1_64, "FirstBattle", "Fight")
  L1_64 = Logic
  L1_64 = L1_64.Get
  L1_64 = L1_64(L1_64, "Guide")
  L1_64 = L1_64.done
  L1_64(L1_64, "LevelUpBattle", "Fight")
  L1_64 = Logic
  L1_64 = L1_64.Get
  L1_64 = L1_64(L1_64, "Guide")
  L1_64 = L1_64.done
  L1_64(L1_64, "FightPVP", "Fight")
  L1_64 = Logic
  L1_64 = L1_64.Get
  L1_64 = L1_64(L1_64, "Hero")
  L1_64 = L1_64.GetFriendInfo
  L1_64 = L1_64(L1_64)
  Logic:Get("Battle"):SetCurSelFriendId(L1_64)
  Logic:Get("Battle"):PostEnterMsg()
  A0_63.rootNode:unregisterScriptTouchHandler()
end
function prototype.onAreBegin(A0_65)
  local L1_66, L2_67
  L1_66 = Logic
  L2_67 = L1_66
  L1_66 = L1_66.Get
  L1_66 = L1_66(L2_67, "Main")
  L2_67 = L1_66
  L1_66 = L1_66.CuMengMain
  L1_66(L2_67, "onAreBegin")
  L1_66 = Logic
  L2_67 = L1_66
  L1_66 = L1_66.Get
  L1_66 = L1_66(L2_67, "Main")
  L2_67 = L1_66
  L1_66 = L1_66.CuMengMainGuide
  L1_66(L2_67, "FirstBattle", "Fight")
  L1_66 = Logic
  L2_67 = L1_66
  L1_66 = L1_66.Get
  L1_66 = L1_66(L2_67, "Guide")
  L2_67 = L1_66
  L1_66 = L1_66.done
  L1_66(L2_67, "FightPVP", "Fight")
  L1_66 = Logic
  L2_67 = L1_66
  L1_66 = L1_66.Get
  L1_66 = L1_66(L2_67, "Battle")
  L2_67 = L1_66
  L1_66 = L1_66.GetEmBattleType
  L1_66 = L1_66(L2_67)
  L2_67 = Logic
  L2_67 = L2_67.Battle
  L2_67 = L2_67.BATTLE_TYPE
  L2_67 = L2_67.CAMPAIGN
  if L1_66 == L2_67 then
    L2_67 = Logic
    L2_67 = L2_67.Get
    L2_67 = L2_67(L2_67, "System")
    L2_67 = L2_67.SaveUsrVariable
    L2_67(L2_67)
    L2_67 = Logic
    L2_67 = L2_67.Get
    L2_67 = L2_67(L2_67, "Guide")
    L2_67 = L2_67.done
    L2_67(L2_67, "Partner", "Fight")
    L2_67 = Logic
    L2_67 = L2_67.Get
    L2_67 = L2_67(L2_67, "Guide")
    L2_67 = L2_67.done
    L2_67(L2_67, "FirstBattle", "Fight")
    L2_67 = Logic
    L2_67 = L2_67.Get
    L2_67 = L2_67(L2_67, "Guide")
    L2_67 = L2_67.done
    L2_67(L2_67, "LevelUpBattle", "Fight")
    L2_67 = Logic
    L2_67 = L2_67.Get
    L2_67 = L2_67(L2_67, "Hero")
    L2_67 = L2_67.GetFriendInfo
    L2_67 = L2_67(L2_67)
    Logic:Get("Battle"):SetCurSelFriendId(L2_67)
    Logic:Get("Battle"):PostEnterMsg()
  else
    L2_67 = Logic
    L2_67 = L2_67.Battle
    L2_67 = L2_67.BATTLE_TYPE
    L2_67 = L2_67.ACTIVE
    if L1_66 == L2_67 then
      L2_67 = Logic
      L2_67 = L2_67.Get
      L2_67 = L2_67(L2_67, "Hero")
      L2_67 = L2_67.GetFriendInfo
      L2_67 = L2_67(L2_67)
      Logic:Get("Battle"):SetCurSelFriendId(L2_67)
      Logic:Get("Battle"):PostEnterMsg()
    else
      L2_67 = Logic
      L2_67 = L2_67.Battle
      L2_67 = L2_67.BATTLE_TYPE
      L2_67 = L2_67.ARENA
      if L1_66 == L2_67 then
        L2_67 = Logic
        L2_67 = L2_67.Get
        L2_67 = L2_67(L2_67, "Fight")
        L2_67 = L2_67.PostDefyMatch
        L2_67(L2_67)
      else
        L2_67 = Logic
        L2_67 = L2_67.Battle
        L2_67 = L2_67.BATTLE_TYPE
        L2_67 = L2_67.DEMOG
        if L1_66 == L2_67 then
          L2_67 = Logic
          L2_67 = L2_67.Get
          L2_67 = L2_67(L2_67, "Devil")
          L2_67 = L2_67.PostAttackDemog
          L2_67(L2_67)
        end
      end
    end
  end
  L2_67 = A0_65.rootNode
  L2_67 = L2_67.unregisterScriptTouchHandler
  L2_67(L2_67)
end
function prototype.onQuick(A0_68, A1_69, A2_70)
  local L3_71, L4_72
  L3_71 = Logic
  L4_72 = L3_71
  L3_71 = L3_71.Get
  L3_71 = L3_71(L4_72, "PlayerInfo")
  L4_72 = L3_71
  L3_71 = L3_71.IsOpenFunc
  L3_71 = L3_71(L4_72)
  if not L3_71 then
    L4_72 = A0_68.IsSatisfyLevel
    L4_72 = L4_72(A0_68)
  else
    if L4_72 then
      L4_72 = CCControlEventTouchUpInside
      if A2_70 == L4_72 then
        L4_72 = Logic
        L4_72 = L4_72.Get
        L4_72 = L4_72(L4_72, "Battle")
        L4_72 = L4_72.GetCurSelBattleId
        L4_72 = L4_72(L4_72)
        Logic:Get("Battle"):PostQuickBattle(L4_72, Logic:Get("Hero"):GetFriendInfo() or ID[-1])
      end
  end
  else
    L4_72 = CCControlEventTouchDown
    if A2_70 == L4_72 then
      L4_72 = Prompt
      L4_72 = L4_72.PopTip
      L4_72(L4_72, TwGetStr(107033))
    end
    L4_72 = CCControlEventTouchUpOutside
    if A2_70 ~= L4_72 then
      L4_72 = CCControlEventTouchUpInside
      if A2_70 ~= L4_72 then
        L4_72 = CCControlEventTouchCancel
      end
    elseif A2_70 == L4_72 then
      L4_72 = Logic
      L4_72 = L4_72.Get
      L4_72 = L4_72(L4_72, "SureConfirm")
      L4_72 = L4_72.FireEvent
      L4_72(L4_72, Logic.SureConfirm.EVT.CLOSE_POPTIP)
    end
  end
end
function prototype.onSkip8(A0_73, A1_74, A2_75)
  local L3_76
  L3_76 = Logic
  L3_76 = L3_76.Get
  L3_76 = L3_76(L3_76, "Battle")
  L3_76 = L3_76.GetCurSelBattleId
  L3_76 = L3_76(L3_76)
  if A0_73:IsSatisfySkip8(L3_76) then
    if A2_75 == CCControlEventTouchUpInside then
      Logic:Get("Battle"):PostQuickAdvance(L3_76, Logic:Get("Hero"):GetFriendInfo() or ID[-1])
    end
  else
    if A2_75 == CCControlEventTouchDown then
      Logic:Get("Mall"):BuyPoints()
    end
    if A2_75 == CCControlEventTouchUpOutside or A2_75 == CCControlEventTouchUpInside or A2_75 == CCControlEventTouchCancel then
      Logic:Get("SureConfirm"):FireEvent(Logic.SureConfirm.EVT.CLOSE_POPTIP)
    end
  end
end
function prototype.IsSatisfySkip8(A0_77, A1_78)
  if A1_78 == nil then
    return false
  end
  return Logic:Get("Battle"):GetBattleInfoById(A1_78) and (not Logic:Get("PlayerInfo"):GetPlayerMoney() and 0 or Logic:Get("PlayerInfo"):GetPlayerMoney().totalCharge or 0) >= 10000 and (not Logic:Get("Battle"):GetBattleInfoById(A1_78) and 0 or Logic:Get("Battle"):GetBattleInfoById(A1_78).cost) <= (not Logic:Get("PlayerInfo"):GetPlayerPhysical() and 0 or Logic:Get("PlayerInfo"):GetPlayerPhysical().point)
end
function prototype.updateGuide(A0_79)
  Logic:Get("Guide"):lockTouch("FirstBattle", "Fight", A0_79.btnAreBegin)
  Logic:Get("Guide"):lockTouch("LevelUpBattle", "Fight", A0_79.btnAreBegin)
  Logic:Get("Guide"):lockTouch("Partner", "Fight", A0_79.btnAreBegin)
  Logic:Get("Guide"):lockTouch("FightPVP", "Fight", A0_79.btnAreBegin)
end
