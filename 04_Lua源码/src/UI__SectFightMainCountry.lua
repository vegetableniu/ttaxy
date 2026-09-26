local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = Tw
L0_0 = L0_0.Controller
L0_0 = L0_0.prototype
L0_0 = L0_0.extend
L0_0 = L0_0(L0_0)
prototype = L0_0
L0_0 = {
  "images/Corps/baoming.png",
  "images/Corps/canzhan.png",
  "images/Corps/guanzhan.png"
}
function prototype.initialize(A0_1, ...)
  local L3_3, L4_4
  L3_3 = super
  L3_3 = L3_3.initialize
  L4_4 = A0_1
  L3_3(L4_4, ...)
end
function prototype.onEnter(A0_5)
  A0_5.ttfOneName:setStyle(kCCLabelTTFStyleOutline)
  A0_5.ttfName1:setStyle(kCCLabelTTFStyleOutline)
  A0_5.ttfName2:setStyle(kCCLabelTTFStyleOutline)
  A0_5.ttfBossName:setStyle(kCCLabelTTFStyleOutline)
  A0_5.ttfJoinName1:setStyle(kCCLabelTTFStyleOutline)
  A0_5.ttfJoinName2:setStyle(kCCLabelTTFStyleOutline)
  A0_5.ttfName:setStyle(kCCLabelTTFStyleOutline)
  A0_5.ttfRewardTip:setStyle(kCCLabelTTFStyleOutline)
  A0_5.ttfTip:setStyle(kCCLabelTTFStyleOutline)
end
function prototype.refresh(A0_6, A1_7)
  A0_6:init()
  if A1_7 == nil then
    return
  end
  A0_6.fightInfo = A1_7
  A0_6.ownData = Logic:Get("Sect"):ownCountryInfo()
  A0_6:setCityImg()
  A0_6.fightTime = Logic:Get("Sect"):countryFightTimer()
  if ({
    [TypeDef("com.eyu.mt.module.menpai.model.CountryState").BIDDING] = {
      func = bind(A0_6.countryFightBid, A0_6)
    },
    [TypeDef("com.eyu.mt.module.menpai.model.CountryState").WIN_BID] = {
      func = bind(A0_6.countryFightJoin, A0_6)
    },
    [TypeDef("com.eyu.mt.module.menpai.model.CountryState").JOIN_FIGHT] = {
      func = bind(A0_6.countryFightJoin, A0_6)
    },
    [TypeDef("com.eyu.mt.module.menpai.model.CountryState").REPORT] = {
      func = bind(A0_6.countryFightJoin, A0_6)
    },
    [TypeDef("com.eyu.mt.module.menpai.model.CountryState").HOLD] = {
      func = bind(A0_6.countryFightEnd, A0_6)
    }
  })[A1_7.state] then
    ({
      [TypeDef("com.eyu.mt.module.menpai.model.CountryState").BIDDING] = {
        func = bind(A0_6.countryFightBid, A0_6)
      },
      [TypeDef("com.eyu.mt.module.menpai.model.CountryState").WIN_BID] = {
        func = bind(A0_6.countryFightJoin, A0_6)
      },
      [TypeDef("com.eyu.mt.module.menpai.model.CountryState").JOIN_FIGHT] = {
        func = bind(A0_6.countryFightJoin, A0_6)
      },
      [TypeDef("com.eyu.mt.module.menpai.model.CountryState").REPORT] = {
        func = bind(A0_6.countryFightJoin, A0_6)
      },
      [TypeDef("com.eyu.mt.module.menpai.model.CountryState").HOLD] = {
        func = bind(A0_6.countryFightEnd, A0_6)
      }
    })[A1_7.state]:func()
  end
end
function prototype.setCityImg(A0_8)
  if not A0_8.fightInfo.data.id then
    return
  end
  A0_8.country = KFDBGetRecord("CountrySetting", A0_8.fightInfo.data.id)
  if table.empty(A0_8.country or {}) then
    return
  end
  if CCSprite:create(A0_8.country.imgCity) then
    A0_8.imgCity:setDisplayFrame(CCSprite:create(A0_8.country.imgCity):displayFrame())
  end
  if CCSprite:create(A0_8.country.imgCityName) then
    A0_8.sprCityName:setDisplayFrame(CCSprite:create(A0_8.country.imgCityName):displayFrame())
  end
end
function prototype.countryFightEnd(A0_9)
  local L1_10
  L1_10 = A0_9.nodeBtn
  L1_10 = L1_10.setVisible
  L1_10(L1_10, false)
  L1_10 = A0_9.nodeJoin
  L1_10 = L1_10.setVisible
  L1_10(L1_10, false)
  L1_10 = A0_9.nodeEnd
  L1_10 = L1_10.setVisible
  L1_10(L1_10, true)
  L1_10 = A0_9.nodeSmall
  L1_10 = L1_10.setVisible
  L1_10(L1_10, true)
  L1_10 = A0_9.fightInfo
  L1_10 = L1_10.data
  L1_10 = L1_10.menpaiInfo
  if L1_10 then
    L1_10 = A0_9.fightInfo
    L1_10 = L1_10.data
    L1_10 = L1_10.menpaiInfo
    L1_10 = L1_10.name
    if L1_10 then
      L1_10 = A0_9.ttfBossName
      L1_10 = L1_10.setString
      L1_10(L1_10, A0_9.fightInfo.data.menpaiInfo.name)
      L1_10 = A0_9.ttfRewardTip
      L1_10 = L1_10.setString
      L1_10(L1_10, A0_9.country.holdReward)
    end
  else
    L1_10 = A0_9.ttfBossName
    L1_10 = L1_10.setString
    L1_10(L1_10, TwGetStr(103006))
    L1_10 = A0_9.ttfRewardTip
    L1_10 = L1_10.setString
    L1_10(L1_10, A0_9.country.holdReward)
  end
  L1_10 = Logic
  L1_10 = L1_10.Get
  L1_10 = L1_10(L1_10, "System")
  L1_10 = L1_10.DiffTime
  L1_10 = L1_10(L1_10, A0_9.fightInfo.data.nextBidDate / 1000)
  if Logic:Get("System"):SecToDay(L1_10).day >= 1 then
    A0_9.ttfTip:setString(TwGetStr(108159))
  else
    A0_9.ttfTip:setString(TwGetStr(108158))
  end
end
function prototype.countryFightBid(A0_11)
  A0_11.nodeJoin:setVisible(false)
  A0_11.nodeEnd:setVisible(false)
  A0_11.isHold = Logic:Get("Sect"):isHoldCountry()
  if A0_11.isHold or Logic:Get("Sect"):isHoldThisCountry(A0_11.fightInfo.data.id) then
    A0_11.nodeBtn:setVisible(false)
    if Logic:Get("Sect"):isHoldThisCountry(A0_11.fightInfo.data.id) then
      A0_11.imgHasSignup:setVisible(true)
    end
    if CCSprite:create(_UPVALUE0_[1]) then
      A0_11.imgBtnState:setDisplayFrame(CCSprite:create(_UPVALUE0_[1]):displayFrame())
    end
    if CCSprite:create(_UPVALUE1_[1]) then
      A0_11.imgHasSignup:setDisplayFrame(CCSprite:create(_UPVALUE1_[1]):displayFrame())
    end
    return
  end
  if A0_11.ownData.country ~= -1 then
    A0_11.nodeBtn:setVisible(false)
  elseif A0_11:checkAuth() then
    A0_11.nodeBtn:setVisible(true)
  end
  if CCSprite:create(_UPVALUE0_[1]) then
    A0_11.imgBtnState:setDisplayFrame(CCSprite:create(_UPVALUE0_[1]):displayFrame())
  end
  if A0_11.ownData.country == A0_11.fightInfo.data.id then
    A0_11.imgHasSignup:setVisible(true)
  end
  if CCSprite:create(_UPVALUE1_[1]) then
    A0_11.imgHasSignup:setDisplayFrame(CCSprite:create(_UPVALUE1_[1]):displayFrame())
  end
end
function prototype.countryFightJoin(A0_12)
  local L1_13, L2_14, L3_15
  A0_12.hasJoined = false
  A0_12.isEnter = false
  L1_13 = A0_12.nodeJoin
  L2_14 = L1_13
  L1_13 = L1_13.setVisible
  L3_15 = true
  L1_13(L2_14, L3_15)
  L1_13 = A0_12.nodeEnd
  L2_14 = L1_13
  L1_13 = L1_13.setVisible
  L3_15 = false
  L1_13(L2_14, L3_15)
  L1_13 = A0_12.fightInfo
  L1_13 = L1_13.state
  if L1_13 == 2 then
    L1_13 = nil
    L2_14 = Logic
    L3_15 = L2_14
    L2_14 = L2_14.Get
    L2_14 = L2_14(L3_15, "Sect")
    L3_15 = L2_14.getSectId
    L3_15 = L3_15(L2_14)
    if L2_14:isSameMenpai(L3_15, A0_12.fightInfo.data.firstMenpai) or L2_14:isSameMenpai(L3_15, A0_12.fightInfo.data.secMenpai) then
      A0_12.isEnter = true
      L1_13 = CCSprite:create(_UPVALUE0_[2])
    else
      A0_12.isEnter = false
      L1_13 = CCSprite:create(_UPVALUE0_[3])
    end
    if L1_13 then
      A0_12.imgBtnState:setDisplayFrame(L1_13:displayFrame())
    end
    A0_12:setNodeVisible(false, true, true)
  else
    L2_14 = A0_12
    L1_13 = A0_12.setNodeVisible
    L3_15 = false
    L1_13(L2_14, L3_15, true, false)
  end
  L1_13 = A0_12.fightInfo
  L1_13 = L1_13.data
  L1_13 = L1_13.ownJoined
  if L1_13 ~= nil then
    L1_13 = A0_12.fightInfo
    L1_13 = L1_13.data
    L1_13 = L1_13.ownJoined
    A0_12.hasJoined = L1_13
  else
    L1_13 = A0_12.ownData
    L1_13 = L1_13.hasJoin
    A0_12.hasJoined = L1_13
  end
  L1_13 = CCSprite
  L2_14 = L1_13
  L1_13 = L1_13.create
  L3_15 = _UPVALUE1_
  L3_15 = L3_15[2]
  L1_13 = L1_13(L2_14, L3_15)
  if L1_13 then
    L2_14 = A0_12.sprVs
    L3_15 = L2_14
    L2_14 = L2_14.setDisplayFrame
    L2_14(L3_15, L1_13:displayFrame())
  end
  L2_14 = ""
  L3_15 = A0_12.fightInfo
  L3_15 = L3_15.data
  L3_15 = L3_15.firstMenpaiNames
  if L3_15 then
    L3_15 = tostring
    L3_15 = L3_15(A0_12.fightInfo.data.firstMenpaiNames)
    L2_14 = L3_15
  end
  L3_15 = ""
  if A0_12.fightInfo.data.secMenpaiNames then
    L3_15 = tostring(A0_12.fightInfo.data.secMenpaiNames)
  end
  if L2_14 == "" and L3_15 == "" and (A0_12.fightInfo.state ~= 2 or (tonumber(A0_12.fightInfo.data.firstMenpai) or 0) == 0 and (tonumber(A0_12.fightInfo.data.secMenpai) or 0) == 0) then
    A0_12.isOpenTip = false
    A0_12:setNodeVisible(false, true, false)
    A0_12.sprVs:setVisible(false)
    return
  end
  if L2_14 == "" and L3_15 == "" then
    A0_12.isOpenTip = true
    A0_12:setNodeVisible(false, true, true)
    A0_12.sprVs:setVisible(false)
    return
  end
  A0_12.isOpenTip = true
  if L2_14 == "" then
    A0_12.ttfJoinName1:setString(L3_15)
    A0_12.ttfOneName:setString(L3_15)
    A0_12.sprVs:setVisible(false)
    return
  end
  if L3_15 == "" then
    A0_12.ttfJoinName1:setString(L2_14)
    A0_12.ttfOneName:setString(L2_14)
    A0_12.sprVs:setVisible(false)
    return
  end
  A0_12.ttfJoinName1:setString(L2_14)
  A0_12.ttfJoinName2:setString(L3_15)
  A0_12.ttfName1:setString(L2_14)
  A0_12.ttfName2:setString(L3_15)
  A0_12.sprVs:setVisible(true)
end
function prototype.onBtnSignUp(A0_16, A1_17, A2_18)
  if A0_16.fightInfo.state == 0 and A0_16.ownData.country == -1 then
    if A0_16:checkAuth() then
      A0_16:openSectFightBid()
    else
      Prompt:Fail(TwGetStr(108133))
    end
    return
  end
  if A0_16.fightInfo.state == 2 then
    A0_16:openSectFightEnter()
  end
end
function prototype.openSectFightEnter(A0_19)
  Logic:Get("Sect"):setCountryId(A0_19.fightInfo.data.id)
  if A0_19.isEnter then
    if A0_19.hasJoined then
      Logic:Get("Sect"):PostCountryFightJoined(false, A0_19.fightInfo.data.id)
    else
      SceneHelper:removeScene("SectFightMain")
      SceneHelper:pushScene("SectFightEnter", A0_19.rootNode)
    end
  else
    Logic:Get("Sect"):PostCountryFightJoined(false, A0_19.fightInfo.data.id)
  end
end
function prototype.onBtnCountry(A0_20)
  if A0_20.notOpenCountryId then
    Prompt:Fail(TwGetStr(108145))
    return
  end
  if A0_20.fightInfo.state == 0 then
    A0_20:bidTip()
    return
  end
  if A0_20.fightInfo.state == 1 or A0_20.fightInfo.state == 2 then
    A0_20:joinTip()
    return
  end
  if A0_20.fightInfo.state == 4 then
    A0_20:endTip()
  end
end
function prototype.bidTip(A0_21)
  if Logic:Get("Sect"):isHoldThisCountry(A0_21.fightInfo.data.id) then
    Prompt:Fail(TwGetStr(108157))
    return
  end
  if A0_21.isHold then
    Prompt:Fail(TwGetStr(108152))
    return
  end
  if A0_21:checkAuth() then
    if A0_21.ownData.country == A0_21.fightInfo.data.id then
      Prompt:Fail(TwGetStr(108142))
      return
    end
    if A0_21.ownData.country ~= -1 then
      Prompt:Fail(TwGetStr(108141))
    else
      A0_21:openSectFightBid()
    end
  else
    if A0_21.ownData.country == A0_21.fightInfo.data.id then
      Prompt:Fail(TwGetStr(108142))
      return
    end
    if A0_21.ownData.country ~= -1 then
      Prompt:Fail(TwGetStr(108141))
      return
    end
    Prompt:Fail(TwGetStr(108143))
  end
end
function prototype.joinTip(A0_22)
  if A0_22.isOpenTip then
    if A0_22.fightTime == 2 then
      A0_22:openSectFightEnter()
      return
    end
    if A0_22.fightTime == 3 then
      return
    end
    A0_22.fightInfo.countryInfo = A0_22.country
    Logic:Get("Sect"):setCountryInfoAboutBid(A0_22.fightInfo)
    SceneHelper:pushPrompt("SectFightJoinTip", A0_22.rootNode)
  end
end
function prototype.endTip(A0_23)
  local L1_24, L2_25, L3_26, L4_27, L5_28
  L1_24 = Logic
  L2_25 = L1_24
  L1_24 = L1_24.Get
  L3_26 = "Sect"
  L1_24 = L1_24(L2_25, L3_26)
  L2_25 = L1_24
  L1_24 = L1_24.GetJoinBidDate
  L1_24 = L1_24(L2_25)
  L2_25 = TwGetStr
  L3_26 = 108126
  L2_25 = L2_25(L3_26)
  L3_26 = Logic
  L4_27 = L3_26
  L3_26 = L3_26.Get
  L5_28 = "System"
  L3_26 = L3_26(L4_27, L5_28)
  L4_27 = L3_26
  L3_26 = L3_26.GetTimeStr
  L5_28 = L2_25
  L3_26 = L3_26(L4_27, L5_28, L1_24[1] / 1000)
  L4_27 = Logic
  L5_28 = L4_27
  L4_27 = L4_27.Get
  L4_27 = L4_27(L5_28, "System")
  L5_28 = L4_27
  L4_27 = L4_27.GetTimeStr
  L4_27 = L4_27(L5_28, L2_25, L1_24[2] / 1000)
  L5_28 = Logic
  L5_28 = L5_28.Get
  L5_28 = L5_28(L5_28, "System")
  L5_28 = L5_28.DiffTime
  L5_28 = L5_28(L5_28, A0_23.fightInfo.data.nextBidDate / 1000)
  if 1 <= Logic:Get("System"):SecToDay(L5_28).day then
    Prompt:Fail(TwGetStr(108144, TwGetStr(108155), L3_26, L4_27))
    return
  end
  if 1 > Logic:Get("System"):SecToDay(L5_28).day then
    Prompt:Fail(TwGetStr(108144, TwGetStr(108154), L3_26, L4_27))
    return
  end
end
function prototype.openSectFightBid(A0_29)
  Logic:Get("Sect"):setCountryId(A0_29.fightInfo.data.id)
  SceneHelper:pushPrompt("SectFightBid", A0_29.rootNode)
  Logic:Get("Sect"):FireEvent(Logic.Sect.EVT.SET_TABLEVIEW_TOUCH, false)
end
function prototype.checkAuth(A0_30)
  local L1_31
  L1_31 = Logic
  L1_31 = L1_31.Get
  L1_31 = L1_31(L1_31, "Sect")
  L1_31 = L1_31.GetJob
  L1_31 = L1_31(L1_31)
  return Logic:Get("Sect"):checkAuth(L1_31, "FIGHT_BID")
end
function prototype.setNodeVisible(A0_32, A1_33, A2_34, A3_35)
  A0_32.nodeJoin1:setVisible(A1_33)
  A0_32.nodeJoin2:setVisible(A2_34)
  A0_32.nodeBtn:setVisible(A3_35)
end
function prototype.init(A0_36)
  if CCSprite:create(_UPVALUE0_) then
    A0_36.imgCity:setDisplayFrame(CCSprite:create(_UPVALUE0_):displayFrame())
  end
  A0_36.ttfJoinName1:setString("")
  A0_36.ttfJoinName2:setString("")
  A0_36.ttfName1:setString("")
  A0_36.ttfName2:setString("")
  A0_36.ttfBossName:setString("")
  A0_36.ttfOneName:setString("")
  A0_36.ttfRewardTip:setString("")
  A0_36.ttfTip:setString("")
  A0_36.imgHasSignup:setVisible(false)
  A0_36.sprVs:setVisible(false)
  A0_36.nodeBtn:setVisible(false)
  A0_36.nodeEnd:setVisible(false)
end
function prototype.refreshNotOpenCountry(A0_37, A1_38)
  A0_37:init()
  A0_37.notOpenCountryId = A1_38
  A0_37:setNotOpenCountryImg(A1_38)
end
function prototype.setNotOpenCountryImg(A0_39, A1_40)
  A0_39.country = KFDBGetRecord("CountrySetting", A1_40)
  if table.empty(A0_39.country or {}) then
    return
  end
  if CCSprite:create(A0_39.country.imgDisCity) then
    A0_39.imgCity:setDisplayFrame(CCSprite:create(A0_39.country.imgDisCity):displayFrame())
  end
  if CCSprite:create(A0_39.country.imgCityName) then
    A0_39.sprCityName:setDisplayFrame(CCSprite:create(A0_39.country.imgCityName):displayFrame())
  end
  A0_39.imgHasSignup:setVisible(true)
  if CCSprite:create(_UPVALUE0_[2]) then
    A0_39.imgHasSignup:setDisplayFrame(CCSprite:create(_UPVALUE0_[2]):displayFrame())
  end
end
