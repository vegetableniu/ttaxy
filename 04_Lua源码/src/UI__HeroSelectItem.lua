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
L0_0 = 5
function prototype.RefreshHeros(A0_1, A1_2, A2_3)
  local L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11, L11_12, L12_13
  if not A2_3 then
    return
  end
  A0_1.type = A1_2
  A0_1.hero = A2_3
  L4_5 = A0_1
  L3_4 = A0_1.HeroInfo
  L5_6 = A2_3
  L3_4(L4_5, L5_6)
  L3_4 = Logic
  L3_4 = L3_4.Hero
  L3_4 = L3_4.EVT
  L3_4 = L3_4.LEADER_CHANGE
  if A1_2 == L3_4 then
    L3_4 = Logic
    L4_5 = L3_4
    L3_4 = L3_4.Get
    L5_6 = "Hero"
    L3_4 = L3_4(L4_5, L5_6)
    L4_5 = L3_4
    L3_4 = L3_4.GetAllHeroInfo
    L3_4 = L3_4(L4_5)
    L4_5 = Logic
    L5_6 = L4_5
    L4_5 = L4_5.Get
    L6_7 = "Hero"
    L4_5 = L4_5(L5_6, L6_7)
    L5_6 = L4_5
    L4_5 = L4_5.GetLeaderId
    L4_5 = L4_5(L5_6)
    if not L3_4 and L4_5 then
      L5_6 = A2_3.id
      if L5_6 then
        return
      end
    end
    L5_6 = A0_1.imgCanSelect
    L6_7 = L5_6
    L5_6 = L5_6.setVisible
    L7_8 = true
    L5_6(L6_7, L7_8)
    L5_6 = A0_1.staBattle
    L6_7 = L5_6
    L5_6 = L5_6.setVisible
    L7_8 = false
    L5_6(L6_7, L7_8)
    L5_6 = A0_1.staSkillName
    L6_7 = L5_6
    L5_6 = L5_6.setVisible
    L7_8 = false
    L5_6(L6_7, L7_8)
    L5_6 = A0_1.staCanSelect
    L6_7 = L5_6
    L5_6 = L5_6.setVisible
    L7_8 = false
    L5_6(L6_7, L7_8)
    L5_6 = Logic
    L6_7 = L5_6
    L5_6 = L5_6.Get
    L7_8 = "Hero"
    L5_6 = L5_6(L6_7, L7_8)
    L6_7 = L5_6
    L5_6 = L5_6.GetSkillInfoById
    L7_8 = A2_3.baseId
    L5_6 = L5_6(L6_7, L7_8)
    if not L5_6 then
      L6_7 = A0_1.staSkillName
      L7_8 = L6_7
      L6_7 = L6_7.setString
      L8_9 = ""
      L6_7(L7_8, L8_9)
    else
      L6_7 = A0_1.staSkillName
      L7_8 = L6_7
      L6_7 = L6_7.setString
      L8_9 = L5_6.skillname
      L8_9 = L8_9 or ""
      L6_7(L7_8, L8_9)
    end
    L6_7 = A0_1.staSkillName
    L7_8 = L6_7
    L6_7 = L6_7.setColor
    L8_9 = ccColor3B
    L8_9 = L8_9(L9_10, L10_11, L11_12)
    L6_7(L7_8, L8_9, L9_10, L10_11, L11_12, L12_13, L8_9(L9_10, L10_11, L11_12))
    L6_7 = A0_1.btnSelect
    L7_8 = L6_7
    L6_7 = L6_7.setBackgroundSpriteForState
    L8_9 = CCScale9Sprite
    L8_9 = L8_9.create
    L8_9 = L8_9(L9_10, L10_11)
    L6_7(L7_8, L8_9, L9_10)
    L6_7 = A0_1.btnSelect
    L7_8 = L6_7
    L6_7 = L6_7.setBackgroundSpriteForState
    L8_9 = CCScale9Sprite
    L8_9 = L8_9.create
    L8_9 = L8_9(L9_10, L10_11)
    L6_7(L7_8, L8_9, L9_10)
    L6_7 = A0_1.btnSelect
    L7_8 = L6_7
    L6_7 = L6_7.setBackgroundSpriteForState
    L8_9 = CCScale9Sprite
    L8_9 = L8_9.create
    L8_9 = L8_9(L9_10, L10_11)
    L6_7(L7_8, L8_9, L9_10)
    L6_7 = A0_1.btnSelect
    L7_8 = L6_7
    L6_7 = L6_7.setEnabled
    L8_9 = true
    L6_7(L7_8, L8_9)
    L6_7 = A2_3.id
    if L6_7 == L4_5 then
      L6_7 = A0_1.btnSelect
      L7_8 = L6_7
      L6_7 = L6_7.setEnabled
      L8_9 = false
      L6_7(L7_8, L8_9)
      L6_7 = A0_1.btnSelect
      L7_8 = L6_7
      L6_7 = L6_7.setBackgroundSpriteForState
      L8_9 = CCScale9Sprite
      L8_9 = L8_9.create
      L8_9 = L8_9(L9_10, L10_11)
      L6_7(L7_8, L8_9, L9_10)
      L6_7 = A0_1.btnSelect
      L7_8 = L6_7
      L6_7 = L6_7.setBackgroundSpriteForState
      L8_9 = CCScale9Sprite
      L8_9 = L8_9.create
      L8_9 = L8_9(L9_10, L10_11)
      L6_7(L7_8, L8_9, L9_10)
      L6_7 = A0_1.btnSelect
      L7_8 = L6_7
      L6_7 = L6_7.setBackgroundSpriteForState
      L8_9 = CCScale9Sprite
      L8_9 = L8_9.create
      L8_9 = L8_9(L9_10, L10_11)
      L6_7(L7_8, L8_9, L9_10)
      L6_7 = CCSprite
      L7_8 = L6_7
      L6_7 = L6_7.create
      L8_9 = "images/public/selcet2.png"
      L6_7 = L6_7(L7_8, L8_9)
      if L6_7 then
        L7_8 = A0_1.imgCanSelect
        L8_9 = L7_8
        L7_8 = L7_8.setDisplayFrame
        L7_8(L8_9, L9_10, L10_11, L11_12, L12_13, L9_10(L10_11))
      end
      return
    end
    L6_7 = CCSprite
    L7_8 = L6_7
    L6_7 = L6_7.create
    L8_9 = "images/public/selcet1.png"
    L6_7 = L6_7(L7_8, L8_9)
    if L6_7 then
      L7_8 = A0_1.imgCanSelect
      L8_9 = L7_8
      L7_8 = L7_8.setDisplayFrame
      L7_8(L8_9, L9_10, L10_11, L11_12, L12_13, L9_10(L10_11))
    end
    L7_8 = Logic
    L8_9 = L7_8
    L7_8 = L7_8.Get
    L7_8 = L7_8(L8_9, L9_10)
    L8_9 = L7_8
    L7_8 = L7_8.CheckHeroState
    L7_8 = L7_8(L8_9, L9_10)
    if L7_8 then
      L8_9 = A0_1.btnSelect
      L8_9 = L8_9.setEnabled
      L8_9(L9_10, L10_11)
      L8_9 = A0_1.staSkillName
      L8_9 = L8_9.setVisible
      L8_9(L9_10, L10_11)
    else
      L8_9 = Logic
      L8_9 = L8_9.Get
      L8_9 = L8_9(L9_10, L10_11)
      L8_9 = L8_9.GetLeadership
      L8_9 = L8_9(L9_10)
      if L10_11 then
      elseif not L11_12 then
        return
      end
      if not L11_12 then
        return
      end
      if not L12_13 then
        return
      end
      if not Logic:Get("Hero"):GetHeroInfoByBaseId(A2_3.baseId) then
        return
      end
      if Logic:Get("Hero"):GetHeroInfoByBaseId(A2_3.baseId).leadership > L8_9 - L9_10 + L12_13 then
        A0_1.btnSelect:setEnabled(false)
        A0_1.staSkillName:setVisible(true)
        A0_1.staSkillName:setString(TwGetStr(104170))
        A0_1.staSkillName:setColor(ccColor3B(255, 0, 0))
      end
      if Logic:Get("Hero"):checkCurrGroupMutex(A2_3.baseId, true) then
        A0_1:LuckyHeroDesc()
        return
      end
    end
  else
    L3_4 = Logic
    L3_4 = L3_4.Hero
    L3_4 = L3_4.EVT
    L3_4 = L3_4.HERO_CURRENT
    if A1_2 == L3_4 then
      L3_4 = Logic
      L4_5 = L3_4
      L3_4 = L3_4.Get
      L5_6 = "Hero"
      L3_4 = L3_4(L4_5, L5_6)
      L4_5 = L3_4
      L3_4 = L3_4.GetLeaderId
      L3_4 = L3_4(L4_5)
      L4_5 = Logic
      L5_6 = L4_5
      L4_5 = L4_5.Get
      L6_7 = "Hero"
      L4_5 = L4_5(L5_6, L6_7)
      L5_6 = L4_5
      L4_5 = L4_5.GetBattlingHero
      L4_5 = L4_5(L5_6)
      if not L4_5 then
        return
      end
      L5_6 = A0_1.staSkillName
      L6_7 = L5_6
      L5_6 = L5_6.setVisible
      L7_8 = true
      L5_6(L6_7, L7_8)
      L5_6 = A0_1.staCanSelect
      L6_7 = L5_6
      L5_6 = L5_6.setVisible
      L7_8 = false
      L5_6(L6_7, L7_8)
      L5_6 = A0_1.staBattle
      L6_7 = L5_6
      L5_6 = L5_6.setVisible
      L7_8 = Logic
      L8_9 = L7_8
      L7_8 = L7_8.Get
      L7_8 = L7_8(L8_9, L9_10)
      L8_9 = L7_8
      L7_8 = L7_8.CheckHeroState
      L8_9 = L7_8(L8_9, L9_10)
      L5_6(L6_7, L7_8, L8_9, L9_10, L10_11, L11_12, L12_13, L7_8(L8_9, L9_10))
      L5_6 = A0_1.staBattle
      L6_7 = L5_6
      L5_6 = L5_6.setStyle
      L7_8 = kCCLabelTTFStyleOutline
      L5_6(L6_7, L7_8)
      L5_6 = A0_1.staBattle
      L6_7 = L5_6
      L5_6 = L5_6.setString
      L7_8 = TwGetStr
      L8_9 = 104171
      L8_9 = L7_8(L8_9)
      L5_6(L6_7, L7_8, L8_9, L9_10, L10_11, L11_12, L12_13, L7_8(L8_9))
      L5_6 = A0_1.btnSelect
      L6_7 = L5_6
      L5_6 = L5_6.setBackgroundSpriteForState
      L7_8 = CCScale9Sprite
      L8_9 = L7_8
      L7_8 = L7_8.create
      L7_8 = L7_8(L8_9, L9_10)
      L8_9 = CCControlStateNormal
      L5_6(L6_7, L7_8, L8_9)
      L5_6 = A0_1.btnSelect
      L6_7 = L5_6
      L5_6 = L5_6.setBackgroundSpriteForState
      L7_8 = CCScale9Sprite
      L8_9 = L7_8
      L7_8 = L7_8.create
      L7_8 = L7_8(L8_9, L9_10)
      L8_9 = CCControlStateHighlighted
      L5_6(L6_7, L7_8, L8_9)
      L5_6 = A0_1.btnSelect
      L6_7 = L5_6
      L5_6 = L5_6.setBackgroundSpriteForState
      L7_8 = CCScale9Sprite
      L8_9 = L7_8
      L7_8 = L7_8.create
      L7_8 = L7_8(L8_9, L9_10)
      L8_9 = CCControlStateDisabled
      L5_6(L6_7, L7_8, L8_9)
      L5_6 = Logic
      L6_7 = L5_6
      L5_6 = L5_6.Get
      L7_8 = "Hero"
      L5_6 = L5_6(L6_7, L7_8)
      L6_7 = L5_6
      L5_6 = L5_6.GetAllHeroInfo
      L5_6 = L5_6(L6_7)
      L6_7 = A0_1.hero
      L6_7 = L6_7.id
      if L6_7 == L3_4 then
        L6_7 = A0_1.staSkillName
        L7_8 = L6_7
        L6_7 = L6_7.setVisible
        L8_9 = false
        L6_7(L7_8, L8_9)
        L6_7 = A0_1.btnSelect
        L7_8 = L6_7
        L6_7 = L6_7.setEnabled
        L8_9 = false
        L6_7(L7_8, L8_9)
        L6_7 = CCSprite
        L7_8 = L6_7
        L6_7 = L6_7.create
        L8_9 = "images/public/selcet3.png"
        L6_7 = L6_7(L7_8, L8_9)
        if L6_7 then
          L7_8 = A0_1.imgCanSelect
          L8_9 = L7_8
          L7_8 = L7_8.setDisplayFrame
          L7_8(L8_9, L9_10, L10_11, L11_12, L12_13, L9_10(L10_11))
        end
        L7_8 = A0_1.btnSelect
        L8_9 = L7_8
        L7_8 = L7_8.setBackgroundSpriteForState
        L7_8(L8_9, L9_10, L10_11)
        L7_8 = A0_1.btnSelect
        L8_9 = L7_8
        L7_8 = L7_8.setBackgroundSpriteForState
        L7_8(L8_9, L9_10, L10_11)
        L7_8 = A0_1.btnSelect
        L8_9 = L7_8
        L7_8 = L7_8.setBackgroundSpriteForState
        L7_8(L8_9, L9_10, L10_11)
        return
      end
      L6_7 = Logic
      L7_8 = L6_7
      L6_7 = L6_7.Get
      L8_9 = "Hero"
      L6_7 = L6_7(L7_8, L8_9)
      L7_8 = L6_7
      L6_7 = L6_7.GetTeamerHero
      L6_7 = L6_7(L7_8)
      L7_8 = A2_3.id
      L7_8 = L6_7[L7_8]
      if L7_8 then
        A0_1.bTeamer = true
        L7_8 = A0_1.btnSelect
        L8_9 = L7_8
        L7_8 = L7_8.setEnabled
        L7_8(L8_9, L9_10)
        L7_8 = CCSprite
        L8_9 = L7_8
        L7_8 = L7_8.create
        L7_8 = L7_8(L8_9, L9_10)
        if L7_8 then
          L8_9 = A0_1.imgCanSelect
          L8_9 = L8_9.setDisplayFrame
          L8_9(L9_10, L10_11, L11_12, L12_13, L10_11(L11_12))
        end
        L8_9 = A0_1.staSkillName
        L8_9 = L8_9.setVisible
        L8_9(L9_10, L10_11)
        return
      end
      A0_1.bTeamer = false
      L7_8 = Logic
      L8_9 = L7_8
      L7_8 = L7_8.Get
      L7_8 = L7_8(L8_9, L9_10)
      L8_9 = L7_8
      L7_8 = L7_8.GetLeadership
      L7_8 = L7_8(L8_9)
      L8_9 = 0
      for L12_13, _FORV_13_ in L9_10(L10_11) do
        if Logic:Get("Hero"):GetHeroInfoById(L12_13) and Logic:Get("Hero"):GetHeroInfoByBaseId(Logic:Get("Hero"):GetHeroInfoById(L12_13).baseId) then
          L8_9 = L8_9 + Logic:Get("Hero"):GetHeroInfoByBaseId(Logic:Get("Hero"):GetHeroInfoById(L12_13).baseId).leadership
        end
      end
      if L9_10 then
        if L10_11 then
          if L10_11 > L11_12 then
            L11_12(L12_13, false)
            L11_12(L12_13, true)
            L11_12(L12_13, TwGetStr(104170))
            L11_12(L12_13, ccColor3B(255, 0, 0))
            L11_12(L12_13, false)
            if L11_12 then
              L12_13(L12_13, L11_12:displayFrame())
            end
            return
          end
        end
      end
      if L10_11 then
        L10_11(L11_12)
        return
      end
      L10_11(L11_12, L12_13)
      if not L10_11 then
        return
      end
      for _FORV_15_, _FORV_16_ in L12_13(L10_11) do
      end
      A0_1.fourthStatus = L12_13
      A0_1.fifthStatus = L12_13
      if L12_13 then
        _UPVALUE0_ = L12_13
      elseif L12_13 then
        _UPVALUE0_ = L12_13
      else
        _UPVALUE0_ = L12_13
      end
      if L11_12 < L12_13 then
        L12_13(L12_13, true)
        if L12_13 then
          A0_1.imgCanSelect:setDisplayFrame(L12_13:displayFrame())
        end
      else
        L12_13(L12_13, false)
        if L12_13 then
          A0_1.imgCanSelect:setDisplayFrame(L12_13:displayFrame())
        end
      end
    end
  end
end
function prototype.LuckyHeroDesc(A0_14)
  A0_14.btnSelect:setEnabled(false)
  A0_14.staSkillName:setStyle(kCCLabelTTFStyleOutline)
  A0_14.staSkillName:setVisible(true)
  A0_14.staSkillName:setString(TwGetStr(105571))
  A0_14.staSkillName:setColor(ccColor3B(255, 0, 0))
  A0_14.staBattle:setVisible(false)
  if CCSprite:create("images/public/selcet3.png") then
    A0_14.imgCanSelect:setDisplayFrame(CCSprite:create("images/public/selcet3.png"):displayFrame())
  end
end
function prototype.HeroInfo(A0_15, A1_16)
  local L2_17, L3_18, L4_19, L5_20, L6_21, L7_22, L8_23, L9_24, L10_25
  L2_17 = A0_15.staLeaderTip
  L3_18 = L2_17
  L2_17 = L2_17.setString
  L4_19 = TwGetStr
  L5_20 = 104268
  L10_25 = L4_19(L5_20)
  L2_17(L3_18, L4_19, L5_20, L6_21, L7_22, L8_23, L9_24, L10_25, L4_19(L5_20))
  L2_17 = A0_15.staCanSelect
  L3_18 = L2_17
  L2_17 = L2_17.setString
  L4_19 = TwGetStr
  L5_20 = 104269
  L10_25 = L4_19(L5_20)
  L2_17(L3_18, L4_19, L5_20, L6_21, L7_22, L8_23, L9_24, L10_25, L4_19(L5_20))
  L2_17 = Logic
  L3_18 = L2_17
  L2_17 = L2_17.Get
  L4_19 = "Hero"
  L2_17 = L2_17(L3_18, L4_19)
  L3_18 = L2_17
  L2_17 = L2_17.GetLeaderId
  L2_17 = L2_17(L3_18)
  L3_18 = Logic
  L4_19 = L3_18
  L3_18 = L3_18.Get
  L5_20 = "Hero"
  L3_18 = L3_18(L4_19, L5_20)
  L4_19 = L3_18
  L3_18 = L3_18.GetHeroImage
  L5_20 = A1_16.baseId
  L3_18 = L3_18(L4_19, L5_20)
  if L3_18 then
    L4_19 = A0_15.btnHero
    L5_20 = L4_19
    L4_19 = L4_19.setBackgroundSpriteForState
    L6_21 = CCScale9Sprite
    L7_22 = L6_21
    L6_21 = L6_21.create
    L8_23 = L3_18
    L6_21 = L6_21(L7_22, L8_23)
    L7_22 = CCControlStateNormal
    L4_19(L5_20, L6_21, L7_22)
    L4_19 = A0_15.btnHero
    L5_20 = L4_19
    L4_19 = L4_19.setBackgroundSpriteForState
    L6_21 = CCScale9Sprite
    L7_22 = L6_21
    L6_21 = L6_21.create
    L8_23 = L3_18
    L6_21 = L6_21(L7_22, L8_23)
    L7_22 = CCControlStateHighlighted
    L4_19(L5_20, L6_21, L7_22)
    L4_19 = A0_15.btnHero
    L5_20 = L4_19
    L4_19 = L4_19.setBackgroundSpriteForState
    L6_21 = CCScale9Sprite
    L7_22 = L6_21
    L6_21 = L6_21.create
    L8_23 = L3_18
    L6_21 = L6_21(L7_22, L8_23)
    L7_22 = CCControlStateDisabled
    L4_19(L5_20, L6_21, L7_22)
  end
  L4_19 = Logic
  L5_20 = L4_19
  L4_19 = L4_19.Get
  L6_21 = "Hero"
  L4_19 = L4_19(L5_20, L6_21)
  L5_20 = L4_19
  L4_19 = L4_19.GetHeroBgImage
  L6_21 = A1_16.baseId
  L4_19 = L4_19(L5_20, L6_21)
  if L4_19 then
    L5_20 = A0_15.btnBg
    L6_21 = L5_20
    L5_20 = L5_20.setBackgroundSpriteForState
    L7_22 = CCScale9Sprite
    L8_23 = L7_22
    L7_22 = L7_22.create
    L9_24 = L4_19
    L7_22 = L7_22(L8_23, L9_24)
    L8_23 = CCControlStateNormal
    L5_20(L6_21, L7_22, L8_23)
    L5_20 = A0_15.btnBg
    L6_21 = L5_20
    L5_20 = L5_20.setBackgroundSpriteForState
    L7_22 = CCScale9Sprite
    L8_23 = L7_22
    L7_22 = L7_22.create
    L9_24 = L4_19
    L7_22 = L7_22(L8_23, L9_24)
    L8_23 = CCControlStateHighlighted
    L5_20(L6_21, L7_22, L8_23)
    L5_20 = A0_15.btnBg
    L6_21 = L5_20
    L5_20 = L5_20.setBackgroundSpriteForState
    L7_22 = CCScale9Sprite
    L8_23 = L7_22
    L7_22 = L7_22.create
    L9_24 = L4_19
    L7_22 = L7_22(L8_23, L9_24)
    L8_23 = CCControlStateDisabled
    L5_20(L6_21, L7_22, L8_23)
  end
  L5_20 = Logic
  L6_21 = L5_20
  L5_20 = L5_20.Get
  L7_22 = "HeroCardInfo"
  L5_20 = L5_20(L6_21, L7_22)
  L6_21 = L5_20
  L5_20 = L5_20.AddShanCardSmall
  L7_22 = A0_15.btnHero
  L8_23 = A1_16.baseId
  L5_20(L6_21, L7_22, L8_23)
  L5_20 = Logic
  L6_21 = L5_20
  L5_20 = L5_20.Get
  L7_22 = "HeroCardInfo"
  L5_20 = L5_20(L6_21, L7_22)
  L6_21 = L5_20
  L5_20 = L5_20.GetRaceBg
  L7_22 = A1_16.baseId
  L8_23 = true
  L5_20 = L5_20(L6_21, L7_22, L8_23)
  if L5_20 then
    L6_21 = CCSprite
    L7_22 = L6_21
    L6_21 = L6_21.create
    L8_23 = L5_20
    L6_21 = L6_21(L7_22, L8_23)
    if L6_21 then
      L7_22 = A0_15.imgTypeBg
      L8_23 = L7_22
      L7_22 = L7_22.setDisplayFrame
      L10_25 = L6_21
      L9_24 = L6_21.displayFrame
      L10_25 = L9_24(L10_25)
      L7_22(L8_23, L9_24, L10_25, L9_24(L10_25))
    end
  end
  L6_21 = Logic
  L7_22 = L6_21
  L6_21 = L6_21.Get
  L8_23 = "HeroCardInfo"
  L6_21 = L6_21(L7_22, L8_23)
  L7_22 = L6_21
  L6_21 = L6_21.GetHeroPhyleStr
  L8_23 = A1_16.baseId
  L9_24 = Logic
  L9_24 = L9_24.HeroCardInfo
  L9_24 = L9_24.HERO_RACE
  L9_24 = L9_24.BIG
  L6_21 = L6_21(L7_22, L8_23, L9_24)
  if L6_21 then
    L7_22 = CCSprite
    L8_23 = L7_22
    L7_22 = L7_22.create
    L9_24 = L6_21
    L7_22 = L7_22(L8_23, L9_24)
    if L7_22 then
      L8_23 = A0_15.imgType
      L9_24 = L8_23
      L8_23 = L8_23.setDisplayFrame
      L10_25 = L7_22.displayFrame
      L10_25 = L10_25(L7_22)
      L8_23(L9_24, L10_25, L10_25(L7_22))
    end
  end
  L7_22 = A1_16.level
  if L7_22 then
    L7_22 = A0_15.staLevel
    L8_23 = L7_22
    L7_22 = L7_22.create
    L9_24 = 0
    L10_25 = "YELLOW_E_NUM"
    L7_22(L8_23, L9_24, L10_25)
    L7_22 = A0_15.staLevel
    L8_23 = L7_22
    L7_22 = L7_22.setAlign
    L9_24 = "CENTER"
    L10_25 = "CENTER"
    L7_22(L8_23, L9_24, L10_25)
    L7_22 = A0_15.staLevel
    L8_23 = L7_22
    L7_22 = L7_22.setValue
    L9_24 = A1_16.level
    L7_22(L8_23, L9_24)
  end
  L7_22 = Logic
  L8_23 = L7_22
  L7_22 = L7_22.Get
  L9_24 = "Hero"
  L7_22 = L7_22(L8_23, L9_24)
  L8_23 = L7_22
  L7_22 = L7_22.GetHeroInfoByBaseId
  L9_24 = A1_16.baseId
  L7_22 = L7_22(L8_23, L9_24)
  if L7_22 then
    L8_23 = A0_15.staName
    L9_24 = L8_23
    L8_23 = L8_23.setString
    L10_25 = L7_22.name
    L10_25 = L10_25 or ""
    L8_23(L9_24, L10_25)
    L8_23 = A0_15.staNeedPoint
    L9_24 = L8_23
    L8_23 = L8_23.setStyle
    L10_25 = kCCLabelTTFStyleOutline
    L8_23(L9_24, L10_25)
    L8_23 = A0_15.staNeedPoint
    L9_24 = L8_23
    L8_23 = L8_23.setString
    L10_25 = L7_22.leadership
    L10_25 = L10_25 or 0
    L8_23(L9_24, L10_25)
  end
  L8_23 = Logic
  L9_24 = L8_23
  L8_23 = L8_23.Get
  L10_25 = "Hero"
  L8_23 = L8_23(L9_24, L10_25)
  L9_24 = L8_23
  L8_23 = L8_23.GetAllHeroInfo
  L8_23 = L8_23(L9_24)
  L9_24 = A1_16.id
  if L9_24 ~= L2_17 then
    L9_24 = A0_15.staLife
    L10_25 = L9_24
    L9_24 = L9_24.setColor
    L9_24(L10_25, ccColor3B(255, 255, 255))
    L9_24 = A0_15.staAttack
    L10_25 = L9_24
    L9_24 = L9_24.setColor
    L9_24(L10_25, ccColor3B(255, 255, 255))
    L9_24 = Logic
    L10_25 = L9_24
    L9_24 = L9_24.Get
    L9_24 = L9_24(L10_25, "Hero")
    L10_25 = L9_24
    L9_24 = L9_24.GetHeroLifeAndAttack
    L10_25 = L9_24(L10_25, A1_16.baseId, A1_16.level)
    if L9_24 and L10_25 then
      A0_15.staLife:setStyle(kCCLabelTTFStyleOutline)
      A0_15.staAttack:setStyle(kCCLabelTTFStyleOutline)
      A0_15.staLife:setString(tostring(L9_24))
      A0_15.staAttack:setString(tostring(L10_25))
    end
  else
    L9_24 = A0_15.staLife
    L10_25 = L9_24
    L9_24 = L9_24.setColor
    L9_24(L10_25, ccColor3B(66, 255, 0))
    L9_24 = A0_15.staAttack
    L10_25 = L9_24
    L9_24 = L9_24.setColor
    L9_24(L10_25, ccColor3B(66, 255, 0))
    L9_24 = Logic
    L10_25 = L9_24
    L9_24 = L9_24.Get
    L9_24 = L9_24(L10_25, "Hero")
    L10_25 = L9_24
    L9_24 = L9_24.GetHeroLifeAndAttack
    L10_25 = L9_24(L10_25, A1_16.baseId, A1_16.level)
    if L9_24 and L10_25 then
      L9_24 = math.modf(L9_24 + L9_24 * 0.1)
      L10_25 = math.modf(L10_25 + L10_25 * 0.1)
      A0_15.staLife:setStyle(kCCLabelTTFStyleOutline)
      A0_15.staAttack:setStyle(kCCLabelTTFStyleOutline)
      A0_15.staLife:setString(tostring(L9_24))
      A0_15.staAttack:setString(tostring(L10_25))
    end
  end
  L9_24 = A0_15.staLeaderTip
  L10_25 = L9_24
  L9_24 = L9_24.setStyle
  L9_24(L10_25, kCCLabelTTFStyleOutline)
end
function prototype.onHeroImage(A0_26)
  Logic:Get("HeroCardInfo"):OpenHeroInfo(A0_26.hero)
end
function prototype.onBtnSelect(A0_27)
  local L1_28, L2_29
  L1_28 = A0_27.btnHero
  L2_29 = L1_28
  L1_28 = L1_28.setEnabled
  L1_28(L2_29, true)
  L1_28 = Logic
  L2_29 = L1_28
  L1_28 = L1_28.Get
  L1_28 = L1_28(L2_29, "Guide")
  L2_29 = L1_28
  L1_28 = L1_28.done
  L1_28(L2_29, "Team", "SelectHero")
  L1_28 = A0_27.type
  L2_29 = Logic
  L2_29 = L2_29.Hero
  L2_29 = L2_29.EVT
  L2_29 = L2_29.LEADER_CHANGE
  if L1_28 == L2_29 then
    L1_28 = A0_27.hero
    L1_28 = L1_28.id
    if L1_28 then
      L1_28 = Logic
      L2_29 = L1_28
      L1_28 = L1_28.Get
      L1_28 = L1_28(L2_29, "Hero")
      L2_29 = L1_28
      L1_28 = L1_28.GetTag
      L1_28 = L1_28(L2_29)
      if L1_28 then
        L2_29 = Logic
        L2_29 = L2_29.Get
        L2_29 = L2_29(L2_29, "Hero")
        L2_29 = L2_29.PostChangeLeader
        L2_29(L2_29, 1, A0_27.hero.id)
      else
        L2_29 = Logic
        L2_29 = L2_29.Get
        L2_29 = L2_29(L2_29, "Hero")
        L2_29 = L2_29.GetSelectIndex
        L2_29 = L2_29(L2_29)
        if L2_29 then
          Logic:Get("Hero"):PostChangeLeader(L2_29, A0_27.hero.id)
        end
      end
    end
  else
    L1_28 = A0_27.type
    L2_29 = Logic
    L2_29 = L2_29.Hero
    L2_29 = L2_29.EVT
    L2_29 = L2_29.HERO_CURRENT
    if L1_28 == L2_29 then
      L1_28 = A0_27.bTeamer
      if L1_28 then
        L1_28 = CCSprite
        L2_29 = L1_28
        L1_28 = L1_28.create
        L1_28 = L1_28(L2_29, "images/public/selcet1.png")
        if L1_28 then
          L2_29 = A0_27.imgCanSelect
          L2_29 = L2_29.setDisplayFrame
          L2_29(L2_29, L1_28:displayFrame())
        end
        A0_27.bTeamer = false
        L2_29 = Logic
        L2_29 = L2_29.Get
        L2_29 = L2_29(L2_29, "Hero")
        L2_29 = L2_29.RemoveHeroFromCopy
        L2_29(L2_29, A0_27.hero.id)
        L2_29 = Logic
        L2_29 = L2_29.Get
        L2_29 = L2_29(L2_29, "Hero")
        L2_29 = L2_29.RemoveTeamerHero
        L2_29(L2_29, A0_27.hero.id)
      else
        L1_28 = CCSprite
        L2_29 = L1_28
        L1_28 = L1_28.create
        L1_28 = L1_28(L2_29, "images/public/selcet2.png")
        if L1_28 then
          L2_29 = A0_27.imgCanSelect
          L2_29 = L2_29.setDisplayFrame
          L2_29(L2_29, L1_28:displayFrame())
        end
        A0_27.bTeamer = true
        L2_29 = Logic
        L2_29 = L2_29.Get
        L2_29 = L2_29(L2_29, "Hero")
        L2_29 = L2_29.AddHeroToCopy
        L2_29(L2_29, A0_27.hero.id)
        L2_29 = Logic
        L2_29 = L2_29.Get
        L2_29 = L2_29(L2_29, "Hero")
        L2_29 = L2_29.AddTeamerHero
        L2_29(L2_29, A0_27.hero.id)
      end
    end
  end
end
function prototype.updateGuide(A0_30)
  if Logic:Get("Guide"):isActive("Team", "SelectHero") then
    A0_30.btnHero:setEnabled(false)
    Logic:Get("Guide"):lockTouch(A0_30.btnSelect)
  end
end
