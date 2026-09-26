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
L0_0 = {}
L0_0.GET_BTN = {
  normal = "images/public/get_phy_nor.png",
  select = "images/public/get_phy_click.png",
  disable = "images/public/get_phy_nor.png"
}
L0_0.GIVE_BTN = {
  normal = "images/public/give_phy_nor.png",
  select = "images/public/give_phy_click.png",
  disable = "images/public/give_phy_nor.png"
}
function prototype.onEnter(A0_1)
  A0_1.curNum = 0
  A0_1.maxNum = Logic:Get("Friend"):GetFriendMax() or 1
  if Logic:Get("Friend"):GetAllFriendId() == nil then
    A0_1.curNum = 0
  else
    A0_1.curNum = #Logic:Get("Friend"):GetAllFriendId()
  end
end
function prototype.onBtnHeroInfo(A0_2, A1_3, A2_4)
  if A0_2.friendType == Logic.Friend.FRIEND_ITEM_TYPE.OTHER then
    Logic:Get("Hero"):SetHelperInfo(A0_2.heroInfo)
    Logic:Get("Battle"):FireEvent(Logic.Battle.EVT.CLICK_BATTLE_COPY_FRIEND_ITEM, A0_2.heroInfo and A0_2.heroInfo.id or nil)
    A0_2.m_pCHeroIcon.btnHeroIcon:setEnabled(true)
    Logic:Get("Guide"):done("Partner", "Select")
  else
    Logic:Get("Friend"):SetCheckedFriendId(A0_2.heroInfo.id)
    SceneHelper:pushPrompt("FriendMutual", A0_2.rootNode)
  end
end
function prototype.onBtnAgree(A0_5, A1_6, A2_7)
  if A0_5.heroInfo ~= nil and next(A0_5.heroInfo) ~= nil then
    if A0_5.curNum < A0_5.maxNum then
      Logic:Get("Friend"):SendMsgHandleAskInfo(true, A0_5.heroInfo.id)
      Logic:Get("Friend"):SetHandleAsk(A0_5.heroInfo)
    else
      Prompt:Fail(101052)
    end
  end
end
function prototype.onBtnReject(A0_8, A1_9, A2_10)
  if A0_8.heroInfo ~= nil and next(A0_8.heroInfo) ~= nil then
    Logic:Get("Friend"):SendMsgHandleAskInfo(false, A0_8.heroInfo.id)
    Logic:Get("Friend"):SetHandleAsk(A0_8.heroInfo)
  end
end
function prototype.ReFrashHeroInfo(A0_11, A1_12, A2_13, A3_14)
  local L4_15, L5_16, L6_17, L7_18, L8_19, L9_20, L10_21, L11_22, L12_23
  L4_15 = A0_11.btnItem
  L5_16 = L4_15
  L4_15 = L4_15.setVisible
  L6_17 = false
  L4_15(L5_16, L6_17)
  L4_15 = A0_11.btnItemTwo
  L5_16 = L4_15
  L4_15 = L4_15.setVisible
  L6_17 = false
  L4_15(L5_16, L6_17)
  A0_11.idx = A3_14
  if A1_12 ~= nil then
    L4_15 = next
    L5_16 = A1_12
    L4_15 = L4_15(L5_16)
  elseif L4_15 == nil then
    return
  end
  A0_11.heroInfo = A1_12
  A0_11.friendType = A2_13
  L4_15 = {}
  L5_16 = A1_12.baseId
  L4_15.baseId = L5_16
  L5_16 = A1_12.heroLevel
  L4_15.level = L5_16
  L5_16 = A1_12.powerSkill
  L4_15.powerSkill = L5_16
  L5_16 = A1_12.talisman
  L4_15.talisman = L5_16
  L5_16 = A1_12.equips
  L4_15.equips = L5_16
  L5_16 = A1_12.userBuffs
  L4_15.userBuffs = L5_16
  L5_16 = A1_12.artifactLevel
  L4_15.artifactLevel = L5_16
  L4_15.otherPlayer = true
  L5_16 = A1_12.cultivateVo
  L4_15.cultivateVo = L5_16
  L5_16 = A0_11.m_pCHeroIcon
  L6_17 = L5_16
  L5_16 = L5_16.ReFrashHeroInfo
  L7_18 = A1_12.baseId
  L8_19 = true
  L9_20 = "HERO"
  L10_21 = A1_12.heroLevel
  L10_21 = L10_21 or 0
  L11_22 = L4_15
  L5_16(L6_17, L7_18, L8_19, L9_20, L10_21, L11_22)
  L5_16 = Logic
  L6_17 = L5_16
  L5_16 = L5_16.Get
  L7_18 = "HeroCardInfo"
  L5_16 = L5_16(L6_17, L7_18)
  L6_17 = L5_16
  L5_16 = L5_16.GetHeroPhyleStr
  L7_18 = A1_12.baseId
  L8_19 = Logic
  L8_19 = L8_19.HeroCardInfo
  L8_19 = L8_19.HERO_RACE
  L8_19 = L8_19.BIG
  L5_16 = L5_16(L6_17, L7_18, L8_19)
  L6_17 = CCSprite
  L7_18 = L6_17
  L6_17 = L6_17.create
  L8_19 = L5_16
  L6_17 = L6_17(L7_18, L8_19)
  if L6_17 then
  end
  L7_18 = A0_11.staHeroName
  L8_19 = L7_18
  L7_18 = L7_18.setString
  L9_20 = A1_12.name
  L9_20 = L9_20 or ""
  L7_18(L8_19, L9_20)
  L7_18 = A0_11.btnItem
  L8_19 = L7_18
  L7_18 = L7_18.setVisible
  L9_20 = false
  L7_18(L8_19, L9_20)
  L7_18 = A0_11.btnItemTwo
  L8_19 = L7_18
  L7_18 = L7_18.setVisible
  L9_20 = false
  L7_18(L8_19, L9_20)
  L7_18 = A0_11.staIsFriend
  L8_19 = L7_18
  L7_18 = L7_18.setVisible
  L9_20 = false
  L7_18(L8_19, L9_20)
  L7_18 = A0_11.staIsFriend2
  L8_19 = L7_18
  L7_18 = L7_18.setVisible
  L9_20 = false
  L7_18(L8_19, L9_20)
  L7_18 = A0_11.staHasGive
  L8_19 = L7_18
  L7_18 = L7_18.setVisible
  L9_20 = false
  L7_18(L8_19, L9_20)
  L7_18 = A0_11.staOnLine
  L8_19 = L7_18
  L7_18 = L7_18.setVisible
  L9_20 = false
  L7_18(L8_19, L9_20)
  L7_18 = A0_11.btnAgree
  L8_19 = L7_18
  L7_18 = L7_18.setVisible
  L9_20 = false
  L7_18(L8_19, L9_20)
  L7_18 = A0_11.btnReject
  L8_19 = L7_18
  L7_18 = L7_18.setVisible
  L9_20 = false
  L7_18(L8_19, L9_20)
  L7_18 = A0_11.btnHeroInfo
  L8_19 = L7_18
  L7_18 = L7_18.setEnabled
  L9_20 = true
  L7_18(L8_19, L9_20)
  L7_18 = A0_11.imgVip2
  L8_19 = L7_18
  L7_18 = L7_18.setVisible
  L9_20 = false
  L7_18(L8_19, L9_20)
  L7_18 = A0_11.imgStar2
  L8_19 = L7_18
  L7_18 = L7_18.setVisible
  L9_20 = false
  L7_18(L8_19, L9_20)
  L7_18 = A0_11.imgVip
  L8_19 = L7_18
  L7_18 = L7_18.setVisible
  L9_20 = false
  L7_18(L8_19, L9_20)
  L7_18 = A0_11.imgStar
  L8_19 = L7_18
  L7_18 = L7_18.setVisible
  L9_20 = false
  L7_18(L8_19, L9_20)
  L7_18 = A0_11.staIsFriend
  L8_19 = L7_18
  L7_18 = L7_18.setStyle
  L9_20 = kCCLabelTTFStyleOutline
  L7_18(L8_19, L9_20)
  L7_18 = A0_11.staIsFriend2
  L8_19 = L7_18
  L7_18 = L7_18.setStyle
  L9_20 = kCCLabelTTFStyleOutline
  L7_18(L8_19, L9_20)
  L7_18 = A0_11.staOnLine
  L8_19 = L7_18
  L7_18 = L7_18.setStyle
  L9_20 = kCCLabelTTFStyleOutline
  L7_18(L8_19, L9_20)
  L7_18 = Logic
  L7_18 = L7_18.Friend
  L7_18 = L7_18.FRIEND_ITEM_TYPE
  L7_18 = L7_18.OTHER
  if A2_13 == L7_18 then
    L7_18 = A0_11.staIsFriend2
    L8_19 = L7_18
    L7_18 = L7_18.setVisible
    L9_20 = true
    L7_18(L8_19, L9_20)
    L7_18 = A0_11.imgStar2
    L8_19 = L7_18
    L7_18 = L7_18.setVisible
    L9_20 = true
    L7_18(L8_19, L9_20)
    L7_18 = A1_12.friend
    if L7_18 == true then
      L7_18 = A0_11.staIsFriend2
      L8_19 = L7_18
      L7_18 = L7_18.setString
      L9_20 = TwGetStr
      L10_21 = 101018
      L12_23 = L9_20(L10_21)
      L7_18(L8_19, L9_20, L10_21, L11_22, L12_23, L9_20(L10_21))
      L7_18 = A0_11.staIsFriend2
      L8_19 = L7_18
      L7_18 = L7_18.setColor
      L9_20 = ccc3
      L10_21 = 255
      L11_22 = 255
      L12_23 = 0
      L12_23 = L9_20(L10_21, L11_22, L12_23)
      L7_18(L8_19, L9_20, L10_21, L11_22, L12_23, L9_20(L10_21, L11_22, L12_23))
      L7_18 = KFDBGetRecord
      L8_19 = "ConfigValue"
      L9_20 = "BATTLE:PARTNER_FRIENDSHIP"
      L7_18 = L7_18(L8_19, L9_20)
      L8_19 = A1_12.used
      if not L8_19 then
        L8_19 = A0_11.staOnLine
        L9_20 = L8_19
        L8_19 = L8_19.setVisible
        L10_21 = true
        L8_19(L9_20, L10_21)
        L8_19 = A0_11.staOnLine
        L9_20 = L8_19
        L8_19 = L8_19.setString
        L10_21 = TwGetStr
        L11_22 = 101020
        L12_23 = tonumber
        L12_23 = L12_23(L7_18.content)
        L12_23 = L12_23 or 0
        L12_23 = L10_21(L11_22, L12_23)
        L8_19(L9_20, L10_21, L11_22, L12_23, L10_21(L11_22, L12_23))
      end
    else
      L7_18 = A0_11.staIsFriend2
      L8_19 = L7_18
      L7_18 = L7_18.setString
      L9_20 = TwGetStr
      L10_21 = 101019
      L12_23 = L9_20(L10_21)
      L7_18(L8_19, L9_20, L10_21, L11_22, L12_23, L9_20(L10_21))
      L7_18 = A0_11.staIsFriend2
      L8_19 = L7_18
      L7_18 = L7_18.setColor
      L9_20 = ccc3
      L10_21 = 0
      L11_22 = 255
      L12_23 = 0
      L12_23 = L9_20(L10_21, L11_22, L12_23)
      L7_18(L8_19, L9_20, L10_21, L11_22, L12_23, L9_20(L10_21, L11_22, L12_23))
      L7_18 = KFDBGetRecord
      L8_19 = "ConfigValue"
      L9_20 = "BATTLE:STRANGER_FRIENDSHIP"
      L7_18 = L7_18(L8_19, L9_20)
      L8_19 = A1_12.used
      if not L8_19 then
        L8_19 = A0_11.staOnLine
        L9_20 = L8_19
        L8_19 = L8_19.setVisible
        L10_21 = true
        L8_19(L9_20, L10_21)
        L8_19 = A0_11.staOnLine
        L9_20 = L8_19
        L8_19 = L8_19.setString
        L10_21 = TwGetStr
        L11_22 = 101020
        L12_23 = tonumber
        L12_23 = L12_23(L7_18.content)
        L12_23 = L12_23 or 0
        L12_23 = L10_21(L11_22, L12_23)
        L8_19(L9_20, L10_21, L11_22, L12_23, L10_21(L11_22, L12_23))
      end
    end
    L7_18 = Logic
    L8_19 = L7_18
    L7_18 = L7_18.Get
    L9_20 = "Hero"
    L7_18 = L7_18(L8_19, L9_20)
    L8_19 = L7_18
    L7_18 = L7_18.GetHeroBgImage
    L9_20 = A1_12.baseId
    L10_21 = Logic
    L10_21 = L10_21.Hero
    L10_21 = L10_21.HEROIMG_SIZE
    L10_21 = L10_21.MIDDLE
    L8_19 = L7_18(L8_19, L9_20, L10_21)
    if L8_19 ~= nil then
      L9_20 = CCSprite
      L10_21 = L9_20
      L9_20 = L9_20.create
      L11_22 = L8_19
      L9_20 = L9_20(L10_21, L11_22)
      if L9_20 then
        L10_21 = A0_11.imgStar2
        L11_22 = L10_21
        L10_21 = L10_21.setDisplayFrame
        L12_23 = L9_20.displayFrame
        L12_23 = L12_23(L9_20)
        L10_21(L11_22, L12_23, L12_23(L9_20))
      end
    else
      L9_20 = A1_12.baseId
      if L9_20 ~= nil then
        L9_20 = log4misc
        L10_21 = L9_20
        L9_20 = L9_20.warn
        L11_22 = "starImg:Hero.baseId:"
        L12_23 = A1_12.baseId
        L11_22 = L11_22 .. L12_23
        L9_20(L10_21, L11_22)
      else
        L9_20 = log4misc
        L10_21 = L9_20
        L9_20 = L9_20.warn
        L11_22 = nil
        L9_20(L10_21, L11_22)
      end
    end
  else
    L7_18 = A0_11.imgStar2
    L8_19 = L7_18
    L7_18 = L7_18.setVisible
    L9_20 = true
    L7_18(L8_19, L9_20)
    L7_18 = A1_12.online
    if L7_18 == true then
      L7_18 = A0_11.btnItem
      L8_19 = L7_18
      L7_18 = L7_18.setVisible
      L9_20 = true
      L7_18(L8_19, L9_20)
      L7_18 = A0_11.btnItemTwo
      L8_19 = L7_18
      L7_18 = L7_18.setVisible
      L9_20 = true
      L7_18(L8_19, L9_20)
      L7_18 = A0_11.staOnLine
      L8_19 = L7_18
      L7_18 = L7_18.setVisible
      L9_20 = true
      L7_18(L8_19, L9_20)
      L7_18 = Logic
      L8_19 = L7_18
      L7_18 = L7_18.Get
      L9_20 = "System"
      L7_18 = L7_18(L8_19, L9_20)
      L8_19 = L7_18
      L7_18 = L7_18.DiffTime
      L9_20 = Logic
      L10_21 = L9_20
      L9_20 = L9_20.Get
      L11_22 = "System"
      L9_20 = L9_20(L10_21, L11_22)
      L10_21 = L9_20
      L9_20 = L9_20.GetTime
      L9_20 = L9_20(L10_21)
      L10_21 = A1_12.loginOn
      L10_21 = L10_21 / 1000
      L7_18 = L7_18(L8_19, L9_20, L10_21)
      L8_19 = TwGetStr
      L9_20 = 101007
      L8_19 = L8_19(L9_20)
      L9_20 = Logic
      L10_21 = L9_20
      L9_20 = L9_20.Get
      L11_22 = "System"
      L9_20 = L9_20(L10_21, L11_22)
      L10_21 = L9_20
      L9_20 = L9_20.SecToDay
      L11_22 = L7_18
      L9_20 = L9_20(L10_21, L11_22)
      L7_18 = L9_20
      L9_20 = 0
      L10_21 = 101001
      if L7_18 then
        L11_22 = L7_18.hour
        if L11_22 > 0 then
          L11_22 = TwGetStr
          L12_23 = 101006
          L11_22 = L11_22(L12_23)
          L8_19 = L11_22
          L9_20 = L7_18.hour
          L10_21 = 101002
        end
      else
        L11_22 = L7_18.min
        if L11_22 then
          L11_22 = L7_18.sec
          if L11_22 then
            L11_22 = L7_18.sec
            if L11_22 ~= 0 then
              L11_22 = L7_18.min
              L9_20 = L11_22 + 1
            end
          else
            L9_20 = L7_18.min
          end
          L10_21 = 101001
        end
      end
      L11_22 = A0_11.staOnLine
      L12_23 = L11_22
      L11_22 = L11_22.setString
      L11_22(L12_23, TwGetStr(L10_21, L9_20))
      L11_22 = A0_11.staOnLine
      L12_23 = L11_22
      L11_22 = L11_22.setColor
      L11_22(L12_23, ccc3(0, 255, 0))
      L11_22 = Logic
      L12_23 = L11_22
      L11_22 = L11_22.Get
      L11_22 = L11_22(L12_23, "Hero")
      L12_23 = L11_22
      L11_22 = L11_22.GetHeroBgImage
      L12_23 = L11_22(L12_23, A1_12.baseId, Logic.Hero.HEROIMG_SIZE.MIDDLE)
      if CCSprite:create(L12_23) then
        A0_11.imgStar:setDisplayFrame(CCSprite:create(L12_23):displayFrame())
        A0_11.imgStar2:setDisplayFrame(CCSprite:create(L12_23):displayFrame())
      end
      A0_11:refreshBtnSta()
    else
      L7_18 = Logic
      L8_19 = L7_18
      L7_18 = L7_18.Get
      L9_20 = "Hero"
      L7_18 = L7_18(L8_19, L9_20)
      L8_19 = L7_18
      L7_18 = L7_18.GetHeroBgImage
      L9_20 = A1_12.baseId
      L10_21 = Logic
      L10_21 = L10_21.Hero
      L10_21 = L10_21.HEROIMG_SIZE
      L10_21 = L10_21.MIDDLE
      L8_19 = L7_18(L8_19, L9_20, L10_21)
      L9_20 = CCSprite
      L10_21 = L9_20
      L9_20 = L9_20.create
      L11_22 = L8_19
      L9_20 = L9_20(L10_21, L11_22)
      if L9_20 then
        L10_21 = A0_11.imgStar
        L11_22 = L10_21
        L10_21 = L10_21.setDisplayFrame
        L12_23 = L9_20.displayFrame
        L12_23 = L12_23(L9_20)
        L10_21(L11_22, L12_23, L12_23(L9_20))
        L10_21 = A0_11.imgStar2
        L11_22 = L10_21
        L10_21 = L10_21.setDisplayFrame
        L12_23 = L9_20.displayFrame
        L12_23 = L12_23(L9_20)
        L10_21(L11_22, L12_23, L12_23(L9_20))
      end
      L10_21 = ""
      L11_22 = A0_11.staOnLine
      L12_23 = L11_22
      L11_22 = L11_22.setVisible
      L11_22(L12_23, true)
      L11_22 = Logic
      L12_23 = L11_22
      L11_22 = L11_22.Get
      L11_22 = L11_22(L12_23, "System")
      L12_23 = L11_22
      L11_22 = L11_22.DiffTime
      L11_22 = L11_22(L12_23, Logic:Get("System"):GetTime(), A1_12.loginOn / 1000)
      L12_23 = Logic
      L12_23 = L12_23.Get
      L12_23 = L12_23(L12_23, "System")
      L12_23 = L12_23.SecToDay
      L12_23 = L12_23(L12_23, L11_22)
      L11_22 = L12_23
      L12_23 = L11_22.day
      if L12_23 < 1 then
        L12_23 = TwGetStr
        L12_23 = L12_23(103089)
        L10_21 = L12_23
      else
        L12_23 = L11_22.day
        if L12_23 >= 7 then
          L12_23 = TwGetStr
          L12_23 = L12_23(103091)
          L10_21 = L12_23
        else
          L12_23 = TwGetStr
          L12_23 = L12_23(103090, L11_22.day)
          L10_21 = L12_23
        end
      end
      L12_23 = A0_11.staOnLine
      L12_23 = L12_23.setString
      L12_23(L12_23, L10_21)
      L12_23 = A0_11.staOnLine
      L12_23 = L12_23.setColor
      L12_23(L12_23, ccc3(128, 128, 128))
      L12_23 = A0_11.refreshBtnSta
      L12_23(A0_11)
    end
    L7_18 = A1_12.vip
    if L7_18 == true then
      L7_18 = A0_11.imgVip2
      L8_19 = L7_18
      L7_18 = L7_18.setVisible
      L9_20 = true
      L7_18(L8_19, L9_20)
    else
      L7_18 = A0_11.imgVip2
      L8_19 = L7_18
      L7_18 = L7_18.setVisible
      L9_20 = false
      L7_18(L8_19, L9_20)
    end
    L7_18 = Logic
    L7_18 = L7_18.Friend
    L7_18 = L7_18.FRIEND_ITEM_TYPE
    L7_18 = L7_18.FRIENDADD
    if A2_13 == L7_18 then
      L7_18 = A0_11.btnHeroInfo
      L8_19 = L7_18
      L7_18 = L7_18.setEnabled
      L9_20 = false
      L7_18(L8_19, L9_20)
      L7_18 = A0_11.btnItem
      L8_19 = L7_18
      L7_18 = L7_18.setVisible
      L9_20 = false
      L7_18(L8_19, L9_20)
      L7_18 = A0_11.btnItemTwo
      L8_19 = L7_18
      L7_18 = L7_18.setVisible
      L9_20 = false
      L7_18(L8_19, L9_20)
      L7_18 = A0_11.btnAgree
      L8_19 = L7_18
      L7_18 = L7_18.setVisible
      L9_20 = true
      L7_18(L8_19, L9_20)
      L7_18 = A0_11.btnReject
      L8_19 = L7_18
      L7_18 = L7_18.setVisible
      L9_20 = true
      L7_18(L8_19, L9_20)
      L7_18 = A0_11.titlleName
      L8_19 = L7_18
      L7_18 = L7_18.setVisible
      L9_20 = false
      L7_18(L8_19, L9_20)
      L7_18 = A0_11.titleSpr
      L8_19 = L7_18
      L7_18 = L7_18.setVisible
      L9_20 = false
      L7_18(L8_19, L9_20)
      L7_18 = A0_11.imgStar
      L8_19 = L7_18
      L7_18 = L7_18.setVisible
      L9_20 = true
      L7_18(L8_19, L9_20)
      L7_18 = A0_11.imgStar2
      L8_19 = L7_18
      L7_18 = L7_18.setVisible
      L9_20 = false
      L7_18(L8_19, L9_20)
      L7_18 = A0_11.imgVip2
      L8_19 = L7_18
      L7_18 = L7_18.setVisible
      L9_20 = false
      L7_18(L8_19, L9_20)
      L7_18 = A0_11.imgVip
      L8_19 = L7_18
      L7_18 = L7_18.setVisible
      L9_20 = false
      L7_18(L8_19, L9_20)
      L7_18 = A1_12.vip
      if L7_18 == true then
        L7_18 = A0_11.imgVip
        L8_19 = L7_18
        L7_18 = L7_18.setVisible
        L9_20 = true
        L7_18(L8_19, L9_20)
      else
        L7_18 = A0_11.imgVip
        L8_19 = L7_18
        L7_18 = L7_18.setVisible
        L9_20 = false
        L7_18(L8_19, L9_20)
      end
    else
      L8_19 = A0_11
      L7_18 = A0_11.ChangeInfo
      L7_18(L8_19)
      L7_18 = A0_11.titlleName
      L8_19 = L7_18
      L7_18 = L7_18.setVisible
      L9_20 = true
      L7_18(L8_19, L9_20)
      L7_18 = A0_11.titleSpr
      L8_19 = L7_18
      L7_18 = L7_18.setVisible
      L9_20 = true
      L7_18(L8_19, L9_20)
    end
  end
  L7_18 = Logic
  L8_19 = L7_18
  L7_18 = L7_18.Get
  L9_20 = "Friend"
  L7_18 = L7_18(L8_19, L9_20)
  L8_19 = L7_18
  L7_18 = L7_18.GetTitleByFight
  L9_20 = A1_12.pvpDesId
  L7_18 = L7_18(L8_19, L9_20)
  L8_19 = A0_11.titlleName
  L9_20 = L8_19
  L8_19 = L8_19.setDisplayFrame
  L11_22 = L7_18
  L10_21 = L7_18.displayFrame
  L12_23 = L10_21(L11_22)
  L8_19(L9_20, L10_21, L11_22, L12_23, L10_21(L11_22))
  L8_19 = Logic
  L9_20 = L8_19
  L8_19 = L8_19.Get
  L10_21 = "Friend"
  L8_19 = L8_19(L9_20, L10_21)
  L9_20 = L8_19
  L8_19 = L8_19.GetTitleByFightLogo
  L10_21 = A1_12.pvpDesId
  L8_19 = L8_19(L9_20, L10_21)
  L9_20 = A0_11.titleSpr
  L10_21 = L9_20
  L9_20 = L9_20.setDisplayFrame
  L12_23 = L8_19
  L11_22 = L8_19.displayFrame
  L12_23 = L11_22(L12_23)
  L9_20(L10_21, L11_22, L12_23, L11_22(L12_23))
end
function prototype.bindAnimationMgr(A0_24)
  local L1_25
  L1_25 = true
  return L1_25
end
function prototype.ChangeInfo(A0_26)
  if not Logic:Get("Friend"):IsRecvPhysicalById(A0_26.heroInfo.id) or not Logic:Get("Friend"):IsRecved(A0_26.heroInfo.id) then
  end
end
function prototype.updateGuide(A0_27)
  if Logic:Get("Guide"):isActive("Partner", "Select") then
    A0_27.m_pCHeroIcon.btnHeroIcon:setEnabled(false)
    Logic:Get("Guide"):lockTouch(A0_27.btnHeroInfo)
  end
end
function prototype.refreshBtnSta(A0_28)
  A0_28.btnItem:setVisible(false)
  A0_28.btnItemTwo:setVisible(false)
  if Logic:Get("Friend"):IsRecvPhysicalById(A0_28.heroInfo.id) then
    A0_28.btnItem:setVisible(true)
    A0_28.btnItemTwo:setVisible(true)
    A0_28.btnType = "GET_BTN"
    if Logic:Get("Friend"):IsRecved(A0_28.heroInfo.id) then
      A0_28.btnItem:setVisible(true)
      A0_28.btnItemTwo:setVisible(true)
      A0_28.btnType = "GIVE_BTN"
      if Logic:Get("Friend"):IsPresend(A0_28.heroInfo.id) then
        A0_28.btnItem:setVisible(false)
        A0_28.btnItemTwo:setVisible(false)
      end
    end
  elseif Logic:Get("Friend"):IsRecved(A0_28.heroInfo.id) then
    A0_28.btnItem:setVisible(true)
    A0_28.btnItemTwo:setVisible(true)
    A0_28.btnType = "GIVE_BTN"
    if Logic:Get("Friend"):IsPresend(A0_28.heroInfo.id) then
      A0_28.btnItem:setVisible(false)
      A0_28.btnItemTwo:setVisible(false)
    end
  elseif Logic:Get("Friend"):IsPresend(A0_28.heroInfo.id) then
    A0_28.btnItem:setVisible(false)
    A0_28.btnItemTwo:setVisible(false)
  else
    A0_28.btnItem:setVisible(true)
    A0_28.btnItemTwo:setVisible(true)
    A0_28.btnType = "GIVE_BTN"
  end
  A0_28:refreshImgBg()
end
function prototype.refreshImgBg(A0_29)
  local L1_30
  L1_30 = _UPVALUE0_
  L1_30 = L1_30.GET_BTN
  if A0_29.btnType then
    L1_30 = _UPVALUE0_[A0_29.btnType]
  end
  A0_29.btnItem:setBackgroundSpriteForState(CCScale9Sprite:create(L1_30.normal), CCControlStateNormal)
  A0_29.btnItem:setBackgroundSpriteForState(CCScale9Sprite:create(L1_30.select), CCControlStateHighlighted)
  A0_29.btnItem:setBackgroundSpriteForState(CCScale9Sprite:create(L1_30.disable), CCControlStateDisabled)
end
function prototype.onbtnItem(A0_31)
  local L1_32
end
function prototype.onBtnItemTwo(A0_33)
  if A0_33.btnType == "GET_BTN" then
    Logic:Get("BGSound"):PlayEffect("audio/getpower.mp3")
    if Logic:Get("PlayerInfo"):IsPhysicalPointFull() then
      Prompt:Fail(115154)
      return
    end
    Logic:Get("Friend"):MsgRecvPhysical(A0_33.heroInfo.id)
  elseif A0_33.btnType == "GIVE_BTN" then
    Logic:Get("Friend"):SendMsgPhysical(A0_33.heroInfo.id)
  end
end
