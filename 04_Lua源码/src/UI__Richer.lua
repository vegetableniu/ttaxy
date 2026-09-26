require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype.onEnter(A0_0)
  local L1_1, L2_2
  A0_0.curStep = 1
  L1_1 = "images/Richer/proBg.png"
  L2_2 = "images/Richer/proGreen.png"
  A0_0.proRings:createProgress(L1_1, L2_2)
  A0_0.ttfLeftAdvDice:setStyle(kCCLabelTTFStyleOutline)
  A0_0.ttfLeftDice:setStyle(kCCLabelTTFStyleOutline)
  A0_0.ttfCoin:setStyle(kCCLabelTTFStyleOutline)
  A0_0.ttfJade:setStyle(kCCLabelTTFStyleOutline)
  A0_0:scrollViewCreate()
  Logic:Get("Monopoly"):On(Logic.Monopoly.EVT.LOAD_MONOPOLY, A0_0:Event("onLoadMonopoly"))
  Logic:Get("Monopoly"):On(Logic.Monopoly.EVT.DICE, A0_0:Event("onDice"))
  Logic:Get("Monopoly"):On(Logic.Monopoly.EVT.DRAW_BOX_REWARD, A0_0:Event("createRingProgress"))
  Logic:Get("Monopoly"):On(Logic.Monopoly.EVT.PUSH_SCENE, A0_0:Event("onRewardEnd"))
  Logic:Get("Monopoly"):On(Logic.Monopoly.EVT.CURRENCY_CHANGED, A0_0:Event("refreshCurrency"))
  Logic:Get("Monopoly"):On(Logic.Monopoly.EVT.ACROSS_DATE, A0_0:Event("onBtnReturn"))
  Logic:Get("Monopoly"):PostLoadMonopoly()
end
function prototype.scrollViewCreate(A0_3)
  local L1_4, L2_5
  L1_4 = Tw
  L1_4 = L1_4.Controller
  L2_5 = L1_4
  L1_4 = L1_4.load
  L1_4 = L1_4(L2_5, "RicherPostItem", A0_3.rootNode)
  L2_5 = CCScrollViewEx
  L2_5 = L2_5.create
  L2_5 = L2_5(L2_5, CCSizeMake(430, 32))
  L2_5:setDirection(kCCScrollViewDirectionHorizontal)
  L2_5:setClippingToBounds(true)
  L2_5:setTouchEnabled(false)
  L2_5:setContainer(L1_4)
  L2_5:updateInset()
  A0_3.scrollTag = L2_5:getTag()
  A0_3.nodAdv:addChild(L2_5)
end
function prototype.onBtnBg(A0_6, A1_7, A2_8)
end
function prototype.onBtnCover(A0_9)
  local L1_10
end
function prototype.onBtnReturn(A0_11, A1_12, A2_13)
  SceneHelper:runWithScene("GiftActivityList", A0_11.rootNode)
end
function prototype.onBtnStrategy(A0_14, A1_15, A2_16)
  SceneHelper:pushScene("RicherStrategy", A0_14.rootNode, nil, nil, true)
end
function prototype.onBtnDice(A0_17, A1_18, A2_19)
  if Logic:Get("Monopoly"):GetMonoInfo().task ~= 0 and not Logic:Get("Monopoly"):GetMonoInfo().drewTaskReward then
    Prompt:Confirm(A0_17, "", TwGetStr(115083), A0_17.onBtnChest, Prompt.PROMPT_TYPE.COMFIRM)
    return
  end
  if 0 < Logic:Get("Monopoly"):GetMonoInfo().dice then
    Logic:Get("Monopoly"):PostDice()
    return
  end
  if Logic:Get("Monopoly"):GetMonoInfo().currDiceTimes + 1 > #(json.decode((KFDBGetRecord("ConfigValue", "MONOPOLY:STEP_COST_CURRENCY") or {}).content or "[]") or {}) then
  end
  A0_17.currCost = (json.decode((KFDBGetRecord("ConfigValue", "MONOPOLY:STEP_COST_CURRENCY") or {}).content or "[]") or {})[#(json.decode((KFDBGetRecord("ConfigValue", "MONOPOLY:STEP_COST_CURRENCY") or {}).content or "[]") or {}) or Logic:Get("Monopoly"):GetMonoInfo().currDiceTimes + 1] or 0
  Prompt:Confirm(A0_17, "", TwGetStr(115071, A0_17.currCost), A0_17.promptDice, Prompt.PROMPT_TYPE.SELECT)
end
function prototype.onBtnShow(A0_20, A1_21, A2_22)
  local L3_23, L4_24, L5_25, L6_26, L7_27, L8_28, L9_29
  L3_23 = {
    L4_24,
    L5_25,
    L6_26,
    L7_27
  }
  L4_24 = "SHOP"
  L5_25 = "TASK"
  L4_24 = 0
  L5_25 = 4
  for L9_29 = 1, L5_25 do
    if A1_21 == A0_20["btnShow" .. L9_29] then
      L4_24 = L9_29
      break
    end
  end
  L6_26(L7_27, L8_28)
  L9_29 = A0_20.rootNode
  L6_26(L7_27, L8_28, L9_29, nil, nil, true)
end
function prototype.promptDice(A0_30)
  if not Logic:Get("PlayerInfo"):IsMoneyEnough(A0_30.currCost) then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Logic:Get("Monopoly"):PostCostDice()
end
function prototype.onBtnAdvDice(A0_31, A1_32, A2_33)
  if Logic:Get("Monopoly"):GetMonoInfo().task ~= 0 and not Logic:Get("Monopoly"):GetMonoInfo().drewTaskReward then
    Prompt:Confirm(A0_31, "", TwGetStr(115083), A0_31.onBtnChest, Prompt.PROMPT_TYPE.COMFIRM)
    return
  end
  SceneHelper:pushPrompt("RicherAdvDice", A0_31.rootNode)
end
function prototype.onBtnBox(A0_34, A1_35, A2_36)
  local L3_37, L4_38, L5_39, L6_40, L7_41
  for L7_41 = 1, 4 do
    if A1_35 == A0_34["btnBox" .. L7_41] then
      L3_37 = L7_41
      break
    end
  end
  if L4_38 then
    return
  end
  L4_38(L5_39, L6_40)
  L7_41 = A0_34.rootNode
  L4_38(L5_39, L6_40, L7_41, nil, nil, true)
end
function prototype.onBtnChest(A0_42, A1_43, A2_44)
  if not table.empty(Logic:Get("Monopoly"):GetMonoInfo().shop or {}) then
    SceneHelper:pushScene("RicherShop", A0_42.rootNode, nil, nil, true)
    return
  end
  if not Logic:Get("Monopoly"):GetMonoInfo().drewTaskReward then
    if not Logic:Get("Monopoly"):GetMonoInfo().task or Logic:Get("Monopoly"):GetMonoInfo().task == 0 then
    elseif not table.empty(Logic:Get("Monopoly"):GetMonoInfo().tasks or {}) then
      if not A0_42.taskRefreshPending then
        A0_42.taskRefreshPending = true
        Logic:Get("Monopoly"):PostLoadMonopoly()
        return
      end
      A0_42.taskRefreshPending = false
      SceneHelper:pushPrompt("RicherTask", A0_42.rootNode)
      return
    end
  end
end
function prototype.onLoadMonopoly(A0_45)
  A0_45:refreshCurrency()
  A0_45:refreshChest()
  A0_45:createRingProgress()
  A0_45:createMapIcon()
  A0_45:refreshPost()
  if A0_45.taskRefreshPending then
    A0_45.taskRefreshPending = false
    SceneHelper:pushPrompt("RicherTask", A0_45.rootNode)
  else
    A0_45:onBtnChest()
  end
end
function prototype.refreshPost(A0_46)
  if not tolua.cast(A0_46.nodAdv:getChildByTag(A0_46.scrollTag), "CCScrollViewEx") then
    return
  end
  tolua.cast(A0_46.nodAdv:getChildByTag(A0_46.scrollTag), "CCScrollViewEx"):getContainer():initRewards(Logic:Get("Monopoly"):GetMonoInfo().records)
end
function prototype.refreshCurrency(A0_47)
  local L1_48
  L1_48 = Logic
  L1_48 = L1_48.Get
  L1_48 = L1_48(L1_48, "PlayerInfo")
  L1_48 = L1_48.GetPlayerAllJade
  L1_48 = L1_48(L1_48)
  A0_47.ttfJade:setString(L1_48)
  A0_47.ttfCoin:setString(Logic:Get("Monopoly"):GetMonoInfo().currency)
  A0_47.ttfLeftDice:setString(Logic:Get("Monopoly"):GetMonoInfo().dice)
  A0_47.ttfLeftAdvDice:setString(Logic:Get("Monopoly"):GetMonoInfo().specialDice)
end
function prototype.refreshChest(A0_49)
  local L1_50, L2_51, L3_52, L4_53, L5_54, L6_55, L7_56, L8_57, L9_58, L10_59
  L1_50 = Logic
  L2_51 = L1_50
  L1_50 = L1_50.Get
  L3_52 = "Monopoly"
  L1_50 = L1_50(L2_51, L3_52)
  L2_51 = L1_50
  L1_50 = L1_50.GetMonoInfo
  L1_50 = L1_50(L2_51)
  L2_51 = L1_50.position
  A0_49.curStep = L2_51
  L2_51 = "sprPoint"
  L3_52 = A0_49.curStep
  L2_51 = L2_51 .. L3_52
  L2_51 = A0_49[L2_51]
  L3_52 = L2_51
  L2_51 = L2_51.getPositionX
  L2_51 = L2_51(L3_52)
  L3_52 = "sprPoint"
  L4_53 = A0_49.curStep
  L3_52 = L3_52 .. L4_53
  L3_52 = A0_49[L3_52]
  L4_53 = L3_52
  L3_52 = L3_52.getPositionY
  L3_52 = L3_52(L4_53)
  L4_53 = A0_49.nodChest
  L5_54 = L4_53
  L4_53 = L4_53.setVisible
  L6_55 = true
  L4_53(L5_54, L6_55)
  L4_53 = A0_49.nodChest
  L5_54 = L4_53
  L4_53 = L4_53.setPosition
  L6_55 = ccp
  L7_56 = L2_51
  L8_57 = L3_52
  L10_59 = L6_55(L7_56, L8_57)
  L4_53(L5_54, L6_55, L7_56, L8_57, L9_58, L10_59, L6_55(L7_56, L8_57))
  L4_53 = Logic
  L5_54 = L4_53
  L4_53 = L4_53.Get
  L6_55 = "Hero"
  L4_53 = L4_53(L5_54, L6_55)
  L5_54 = L4_53
  L4_53 = L4_53.GetLeaderId
  L4_53 = L4_53(L5_54)
  L5_54 = Logic
  L6_55 = L5_54
  L5_54 = L5_54.Get
  L7_56 = "Hero"
  L5_54 = L5_54(L6_55, L7_56)
  L6_55 = L5_54
  L5_54 = L5_54.GetHeroInfoById
  L7_56 = L4_53
  L5_54 = L5_54(L6_55, L7_56)
  L6_55 = Logic
  L7_56 = L6_55
  L6_55 = L6_55.Get
  L8_57 = "Hero"
  L6_55 = L6_55(L7_56, L8_57)
  L7_56 = L6_55
  L6_55 = L6_55.GetHeroImage
  L8_57 = L5_54.baseId
  L6_55 = L6_55(L7_56, L8_57)
  L7_56 = Logic
  L8_57 = L7_56
  L7_56 = L7_56.Get
  L9_58 = "Hero"
  L7_56 = L7_56(L8_57, L9_58)
  L8_57 = L7_56
  L7_56 = L7_56.GetHeroBgImage
  L9_58 = L5_54.baseId
  L7_56 = L7_56(L8_57, L9_58)
  L8_57 = CCSprite
  L9_58 = L8_57
  L8_57 = L8_57.create
  L10_59 = L7_56
  L8_57 = L8_57(L9_58, L10_59)
  if L8_57 then
    L9_58 = A0_49.sprBg
    L10_59 = L9_58
    L9_58 = L9_58.setDisplayFrame
    L9_58(L10_59, L8_57:displayFrame())
  end
  L9_58 = CCSprite
  L10_59 = L9_58
  L9_58 = L9_58.create
  L9_58 = L9_58(L10_59, L6_55)
  L8_57 = L9_58
  if L8_57 then
    L9_58 = A0_49.sprHero
    L10_59 = L9_58
    L9_58 = L9_58.setDisplayFrame
    L9_58(L10_59, L8_57:displayFrame())
  end
  L9_58 = A0_49.sprBg
  L10_59 = L9_58
  L9_58 = L9_58.getContentSize
  L9_58 = L9_58(L10_59)
  L9_58 = L9_58.width
  L9_58 = L9_58 / 2
  L10_59 = A0_49.sprBg
  L10_59 = L10_59.getContentSize
  L10_59 = L10_59(L10_59)
  L10_59 = L10_59.height
  L10_59 = L10_59 / 2
  L10_59 = L10_59 - 15
  Logic:Get("AniMgr"):NewCCB("UI/uitouziTX", A0_49.sprBg, ccp(L9_58, L10_59), 0, nil, 1):RunAni()
end
function prototype.createMapIcon(A0_60, A1_61)
  local L2_62, L3_63, L4_64, L5_65, L6_66, L7_67, L8_68, L9_69, L10_70, L11_71, L12_72, L13_73
  L2_62 = Logic
  L3_63 = L2_62
  L2_62 = L2_62.Get
  L4_64 = "Monopoly"
  L2_62 = L2_62(L3_63, L4_64)
  L3_63 = L2_62
  L2_62 = L2_62.GetMonoInfo
  L2_62 = L2_62(L3_63)
  function L3_63(A0_74)
    return table.invert(_UPVALUE0_.gonePositions)[A0_74] and true or false
  end
  L4_64 = table
  L4_64 = L4_64.invert
  L5_65 = {
    L6_66,
    L7_67,
    L8_68,
    L9_69,
    L10_70,
    L11_71
  }
  L9_69 = "SHOP"
  L10_70 = "SILVER_BOX"
  L11_71 = "GOLD_BOX"
  L4_64 = L4_64(L5_65)
  function L5_65(A0_75, A1_76)
    local L2_77, L3_78
    L2_77 = _UPVALUE0_
    L2_77 = L2_77[A0_75]
    L3_78 = _UPVALUE0_
    L3_78 = L3_78[A1_76]
    L2_77 = L2_77 > L3_78
    return L2_77
  end
  A0_60.map = L6_66
  for L9_69 = 1, L7_67(L8_68) do
    L10_70 = KFDBGetRecordByIdx
    L11_71 = "PositionValueType"
    L12_72 = L9_69
    L10_70 = L10_70(L11_71, L12_72)
    L11_71 = "sprIcon"
    L12_72 = L9_69
    L11_71 = L11_71 .. L12_72
    L12_72 = A0_60[L11_71]
    if L12_72 and L10_70 then
      L12_72 = L10_70.positionTypes
      if L12_72 ~= "" then
        L12_72 = json
        L12_72 = L12_72.decode
        L13_73 = L10_70.positionTypes
        L12_72 = L12_72(L13_73)
        L13_73 = L2_62.goldBoxPosition
        if L13_73 == L10_70.id then
          L13_73 = table
          L13_73 = L13_73.insert
          L13_73(L12_72, "GOLD_BOX")
        end
        L13_73 = table
        L13_73 = L13_73.sort
        L13_73(L12_72, L5_65)
        L13_73 = table
        L13_73 = L13_73.insert
        L13_73(A0_60.map, L12_72)
        L13_73 = L3_63
        L13_73 = L13_73(L10_70.id)
        if L13_73 then
          L13_73 = #L12_72
          L13_73 = L12_72[L13_73]
        else
          L13_73 = L13_73 or L12_72[1]
        end
        L13_73 = A1_61 and L12_72[1] or L13_73
        A0_60:createNodeImg(A0_60[L11_71], L13_73)
      end
    end
  end
end
function prototype.createNodeImg(A0_79, A1_80, A2_81)
  local L3_82, L4_83, L5_84, L6_85
  L3_82 = {}
  L3_82.TASK = "images/Richer/taskIcon.png"
  L3_82.SHOP = "images/Richer/shopIcon.png"
  L3_82.SILVER_BOX = "images/Richer/greenBox.png"
  L3_82.GOLD_BOX = "images/Richer/goldBoxOpen.png"
  L4_83 = 2
  L6_85 = A1_80
  L5_84 = A1_80.setScale
  L5_84(L6_85, 1)
  L6_85 = A1_80
  L5_84 = A1_80.getParent
  L5_84 = L5_84(L6_85)
  L6_85 = L5_84
  L5_84 = L5_84.getChildByTag
  L5_84 = L5_84(L6_85, L4_83)
  if L5_84 then
    L6_85 = A1_80.getParent
    L6_85 = L6_85(A1_80)
    L6_85 = L6_85.removeChildByTag
    L6_85(L6_85, L4_83, true)
  end
  L6_85 = L3_82[A2_81]
  if L6_85 then
    L6_85 = CCSprite
    L6_85 = L6_85.create
    L6_85 = L6_85(L6_85, L3_82[A2_81])
    if L6_85 then
      A1_80:setDisplayFrame(L6_85:displayFrame())
    end
    return
  end
  if A2_81 == "DICE" then
    L6_85 = {}
    L6_85.path = "images/Richer/dice.png"
    L6_85.diceOnePath = "images/Richer/dice1.png"
    L6_85.tag = L4_83
    L6_85.nodeScale = 0.7
    L6_85.diceScale = 1
    L6_85.sprNode = A1_80
    A0_79:createMapDice(L6_85)
    return
  end
  if A2_81 == "SPECIAL_DICE" then
    L6_85 = {}
    L6_85.path = "images/Richer/advDice.png"
    L6_85.diceOnePath = "images/Richer/advDice1.png"
    L6_85.tag = L4_83
    L6_85.nodeScale = 1
    L6_85.diceScale = 0.65
    L6_85.sprNode = A1_80
    A0_79:createMapDice(L6_85)
    return
  end
end
function prototype.createMapDice(A0_86, A1_87)
  local L2_88, L3_89
  L2_88 = CCSprite
  L3_89 = L2_88
  L2_88 = L2_88.create
  L2_88 = L2_88(L3_89, A1_87.path)
  L3_89 = CCSprite
  L3_89 = L3_89.create
  L3_89 = L3_89(L3_89, A1_87.diceOnePath)
  L3_89:setAnchorPoint(ccp(0.5, 0.5))
  L3_89:setPosition(A1_87.sprNode:getPosition())
  L3_89:setScale(A1_87.diceScale)
  if L2_88 then
    A1_87.sprNode:setDisplayFrame(L2_88:displayFrame())
    A1_87.sprNode:setScale(A1_87.nodeScale)
    A1_87.sprNode:getParent():addChild(L3_89, 0, A1_87.tag)
  end
end
function prototype.createRingProgress(A0_90, A1_91)
  local L2_92, L3_93, L4_94, L5_95, L6_96, L7_97, L8_98, L9_99, L10_100, L11_101, L12_102, L13_103, L14_104, L15_105, L16_106, L17_107, L18_108
  L2_92 = A1_91 or false
  L3_93 = 4
  L5_95 = A0_90
  L4_94 = A0_90.createRingsData
  L4_94(L5_95)
  L4_94 = Logic
  L5_95 = L4_94
  L4_94 = L4_94.Get
  L6_96 = "Monopoly"
  L4_94 = L4_94(L5_95, L6_96)
  L5_95 = L4_94
  L4_94 = L4_94.GetMonoInfo
  L4_94 = L4_94(L5_95)
  L5_95 = {
    L6_96,
    L7_97,
    L8_98,
    L9_99
  }
  L6_96 = "images/Richer/greenBoxOpen.png"
  L7_97 = "images/Richer/blueBoxOpen.png"
  L6_96 = {
    L7_97,
    L8_98,
    L9_99,
    L10_100
  }
  L7_97 = "images/Richer/greenBoxEmpty.png"
  L7_97 = A0_90.ringsRec
  L7_97 = L7_97[L8_98]
  L7_97 = L7_97.rings
  for L11_101 = 1, L3_93 do
    L12_102 = "sprBox"
    L13_103 = L11_101
    L12_102 = L12_102 .. L13_103
    L13_103 = "ttfBox"
    L14_104 = L11_101
    L13_103 = L13_103 .. L14_104
    L14_104 = "nodBox"
    L15_105 = L11_101
    L14_104 = L14_104 .. L15_105
    L16_106 = A0_90
    L15_105 = A0_90.IsDrawBox
    L17_107 = L11_101
    L15_105 = L15_105(L16_106, L17_107)
    if not L15_105 then
      L15_105 = L4_94.rings
      L16_106 = A0_90.ringsRec
      L16_106 = L16_106[L11_101]
      L16_106 = L16_106.rings
      L15_105 = L15_105 >= L16_106
    end
    L16_106 = A0_90[L12_102]
    if L16_106 and L15_105 then
      L17_107 = A0_90
      L16_106 = A0_90.IsDrawBox
      L18_108 = L11_101
      L16_106 = L16_106(L17_107, L18_108)
      if L16_106 then
        L16_106 = L6_96[L11_101]
      else
        L16_106 = L16_106 or L5_95[L11_101]
      end
      L17_107 = CCSprite
      L18_108 = L17_107
      L17_107 = L17_107.create
      L17_107 = L17_107(L18_108, L16_106)
      if L12_102 then
        L18_108 = A0_90[L12_102]
        L18_108 = L18_108.setDisplayFrame
        L18_108(L18_108, L17_107:displayFrame())
      end
    end
    L16_106 = A0_90[L13_103]
    if L16_106 then
      L16_106 = A0_90[L13_103]
      L17_107 = L16_106
      L16_106 = L16_106.setStyle
      L18_108 = kCCLabelTTFStyleOutline
      L16_106(L17_107, L18_108)
      L16_106 = A0_90[L13_103]
      L17_107 = L16_106
      L16_106 = L16_106.setString
      L18_108 = TwGetStr
      L18_108 = L18_108(115079, A0_90.ringsRec[L11_101].rings or 0)
      L16_106(L17_107, L18_108, L18_108(115079, A0_90.ringsRec[L11_101].rings or 0))
    end
    L16_106 = A0_90[L14_104]
    if L16_106 then
      L16_106 = A0_90[L14_104]
      L17_107 = L16_106
      L16_106 = L16_106.setVisible
      L18_108 = true
      L16_106(L17_107, L18_108)
      L16_106 = A0_90.ringsRec
      L16_106 = L16_106[L11_101]
      L16_106 = L16_106.rings
      L16_106 = L16_106 / L7_97
      if L16_106 == 100 then
      end
      L17_107 = A0_90.proRings
      L18_108 = L17_107
      L17_107 = L17_107.getContentSize
      L17_107 = L17_107(L18_108)
      L17_107 = L17_107.width
      L17_107 = L17_107 * L16_106
      L18_108 = A0_90.proRings
      L18_108 = L18_108.getPositionX
      L18_108 = L18_108(L18_108)
      L18_108 = L18_108 + L17_107
      A0_90[L14_104]:setPositionX(L18_108)
    end
  end
  if L2_92 then
    L11_101 = L4_94.rings
    L11_101 = L11_101 * 100
    L11_101 = L11_101 / L7_97
    L11_101 = false
    L12_102 = 0
    L13_103 = 2000
    L8_98(L9_99, L10_100, L11_101, L12_102, L13_103)
    return
  end
  L11_101 = L4_94.rings
  L11_101 = L11_101 * 100
  L11_101 = L11_101 / L7_97
  L18_108 = L10_100(L11_101)
  L8_98(L9_99, L10_100, L11_101, L12_102, L13_103, L14_104, L15_105, L16_106, L17_107, L18_108, L10_100(L11_101))
end
function prototype.createRingsData(A0_109)
  local L1_110, L2_111, L3_112, L4_113, L5_114
  A0_109.ringsRec = L1_110
  for L4_113 = 1, L2_111(L3_112) do
    L5_114 = KFDBGetRecordByIdx
    L5_114 = L5_114("RingBox", L4_113)
    table.insert(A0_109.ringsRec, L5_114)
  end
  L1_110(L2_111, L3_112)
end
function prototype.IsDrawBox(A0_115, A1_116)
  return table.invert(Logic:Get("Monopoly"):GetMonoInfo().drewBox)[A1_116] and true or false
end
function prototype.onRewardEnd(A0_117)
  A0_117:onBtnChest()
  A0_117.btnCover:setEnabled(false)
end
function prototype.onDice(A0_118, A1_119)
  local L2_120, L3_121, L4_122, L5_123
  L2_120 = Logic
  L3_121 = L2_120
  L2_120 = L2_120.Get
  L4_122 = "Monopoly"
  L2_120 = L2_120(L3_121, L4_122)
  L3_121 = L2_120
  L2_120 = L2_120.GetMonoInfo
  L2_120 = L2_120(L3_121)
  L3_121 = L2_120.position
  L4_122 = A0_118.curStep
  L3_121 = L3_121 - L4_122
  L4_122 = KFDBGetRecordAmt
  L5_123 = "PositionValueType"
  L4_122 = L4_122(L5_123)
  A0_118.maxLattice = L4_122
  if L3_121 < 0 then
    L4_122 = A0_118.maxLattice
    L4_122 = L3_121 + L4_122
    L3_121 = L4_122 or L3_121
  end
  if A1_119 then
    L4_122 = A0_118.advDiceTurnAni
  else
    L4_122 = L4_122 or A0_118.norDiceTurnAni
  end
  if A1_119 then
    L5_123 = A0_118.nodAni2
  else
    L5_123 = L5_123 or A0_118.nodAni1
  end
  L5_123:removeAllChildrenWithCleanup(true)
  if A1_119 then
    A0_118.nodAdvDice:setVisible(false)
  else
    A0_118.nodDice:setVisible(false)
  end
  A0_118.btnCover:setEnabled(true)
  A0_118:runAni(L4_122, L3_121, L5_123, A1_119)
end
function prototype.runAni(A0_124, A1_125, A2_126, A3_127, A4_128)
  local L5_129, L6_130, L7_131
  if A4_128 then
    L5_129 = "UI/uitouzi03"
  else
    L5_129 = L5_129 or "UI/uitouzi"
  end
  L6_130 = Logic
  L7_131 = L6_130
  L6_130 = L6_130.Get
  L6_130 = L6_130(L7_131, "AniMgr")
  L7_131 = L6_130
  L6_130 = L6_130.NewCCB
  L6_130 = L6_130(L7_131, L5_129, A3_127, ccp(0, 0), 0, nil, 1)
  A1_125 = L6_130
  if A4_128 then
    L6_130 = "images/Richer/advDice%d.png"
  else
    L6_130 = L6_130 or "images/Richer/dice%d.png"
  end
  L7_131 = string
  L7_131 = L7_131.format
  L7_131 = L7_131(L6_130, A2_126)
  if CCSprite:create(L7_131) then
    A1_125:GetChild("sprDice"):setDisplayFrame(CCSprite:create(L7_131):displayFrame())
  end
  A1_125:RunAni(nil, nil, bind(A0_124.aniEnd, A0_124, A2_126))
end
function prototype.aniEnd(A0_132, A1_133)
  A0_132:moveChest(A1_133)
end
function prototype.moveChest(A0_134, A1_135)
  local L2_136, L3_137, L4_138, L5_139, L6_140, L7_141, L8_142, L9_143, L10_144, L11_145, L12_146, L13_147
  L2_136 = CCArray
  L2_136 = L2_136.create
  L2_136 = L2_136(L3_137)
  for L6_140 = 1, A1_135 do
    L7_141 = A0_134.curStep
    L7_141 = L7_141 + 1
    L8_142 = A0_134.maxLattice
    if L7_141 > L8_142 then
      L8_142 = 1
      L7_141 = L8_142 or L7_141
    end
    L8_142 = "sprPoint"
    L9_143 = L7_141
    L8_142 = L8_142 .. L9_143
    L9_143 = A0_134[L8_142]
    if L9_143 then
      L9_143 = A0_134[L8_142]
      L10_144 = L9_143
      L9_143 = L9_143.getPositionX
      L9_143 = L9_143(L10_144)
      L10_144 = A0_134[L8_142]
      L11_145 = L10_144
      L10_144 = L10_144.getPositionY
      L10_144 = L10_144(L11_145)
      L11_145 = CCJumpTo
      L12_146 = L11_145
      L11_145 = L11_145.create
      L13_147 = 0.3
      L11_145 = L11_145(L12_146, L13_147, ccp(L9_143, L10_144), 20, 1)
      L12_146 = CCDelayTime
      L13_147 = L12_146
      L12_146 = L12_146.create
      L12_146 = L12_146(L13_147, 0.1)
      L13_147 = L2_136.addObject
      L13_147(L2_136, L11_145)
      L13_147 = L2_136.addObject
      L13_147(L2_136, L12_146)
      L13_147 = A0_134.curStep
      L13_147 = L13_147 + 1
      A0_134.curStep = L13_147
      L13_147 = A0_134.curStep
      if L13_147 > A0_134.maxLattice then
        L13_147 = 1
      else
        L13_147 = L13_147 or A0_134.curStep
      end
      A0_134.curStep = L13_147
      L13_147 = A0_134.curStep
      if L13_147 == 1 then
        L13_147 = CCCallFuncN
        L13_147 = L13_147.create
        L13_147 = L13_147(L13_147, function()
          Logic:Get("AniMgr"):NewCCB("UI/uiyh", _UPVALUE0_.rootNode, ccp(320, 480), 0, nil, 1):RunAni()
          _UPVALUE0_:createRingProgress(true)
          _UPVALUE0_:createMapIcon(true)
        end)
        L2_136:addObject(L13_147)
        L2_136:addObject(CCDelayTime:create(0.5))
      end
    end
  end
  L6_140 = L3_137
  L4_138(L5_139, L6_140)
  L6_140 = CCSequence
  L7_141 = L6_140
  L6_140 = L6_140.create
  L8_142 = L2_136
  L13_147 = L6_140(L7_141, L8_142)
  L4_138(L5_139, L6_140, L7_141, L8_142, L9_143, L10_144, L11_145, L12_146, L13_147, L6_140(L7_141, L8_142))
end
function prototype.showBoxAni(A0_148)
  if not ({SILVER_BOX = "UI/uikxz02", GOLD_BOX = "UI/uikxz"})[A0_148.map[A0_148.curStep][1]] then
    Logic:Get("Monopoly"):PromptReward()
    return
  end
  Logic:Get("AniMgr"):NewCCB(({SILVER_BOX = "UI/uikxz02", GOLD_BOX = "UI/uikxz"})[A0_148.map[A0_148.curStep][1]], A0_148.rootNode, ccp(320, 480), 0, nil, 1):RunAni(nil, nil, function()
    Logic:Get("Monopoly"):PromptReward()
  end)
end
