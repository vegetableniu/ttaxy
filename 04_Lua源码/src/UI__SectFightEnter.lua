module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype.initialize(A0_0, ...)
  local L3_2, L4_3
  L3_2 = super
  L3_2 = L3_2.initialize
  L4_3 = A0_0
  L3_2(L4_3, ...)
end
function prototype.onEnter(A0_4)
  Logic:Get("Sect"):On(Logic.Sect.EVT.COUNTRY_FIGTH_END, A0_4:Event("OnCountryFightEnd"))
  A0_4.countryFightMaxNum = KFDBGetRecord("ConfigValue", "MENPAI:COUNTRY_FIGHT_MAX_NUMBER")
  A0_4.countryFightMaxNum = A0_4.countryFightMaxNum and tonumber(A0_4.countryFightMaxNum.content) or 30
  A0_4.ttfMaxNumTip:setString(TwGetStr(108115, A0_4.countryFightMaxNum))
  if Logic:Get("Sect"):compareTime(Logic:Get("Sect"):GetReportDate()[1], Logic:Get("Sect"):GetReportDate()[2]) then
    A0_4.nodeEnter:setVisible(false)
    A0_4.nodeSpot:setVisible(true)
    A0_4.nodeSpot:setPositionX(A0_4.nodeEnter:getPositionX() - 100)
  end
  Logic:Get("Sect"):On(Logic.Sect.EVT.COUNTRY_FIGHT_JOIN, A0_4:Event("onEnterFight"))
  A0_4.fightInfo = Logic:Get("Sect"):getCountryInfo()
  if A0_4.fightInfo == nil then
    return
  end
  A0_4.countryId = Logic:Get("Sect"):getCountryId()
  if not A0_4.countryId or A0_4.countryId == 0 then
    A0_4.countryId = A0_4.fightInfo.ownData and A0_4.fightInfo.ownData.fightCountry
  end
  A0_4.joinFightNum = 0
  A0_4.ownJoined = false
  if A0_4.fightInfo.ownData then
    if A0_4.fightInfo.ownData.fightCountry == A0_4.countryId then
      A0_4.joinFightNum = A0_4.fightInfo.ownData.totalJoinedCount or 0
    end
    A0_4.ownJoined = A0_4.fightInfo.ownData.hasJoin
  end
  for _FORV_5_, _FORV_6_ in pairs(A0_4.fightInfo.countryDatas or {}) do
    if _FORV_6_.data and tonumber(_FORV_6_.data.id) == tonumber(A0_4.countryId) then
      if _FORV_6_.data.joinedCount ~= nil then
        A0_4.joinFightNum = tonumber(_FORV_6_.data.joinedCount) or 0
      end
      if _FORV_6_.data.ownJoined ~= nil then
        A0_4.ownJoined = _FORV_6_.data.ownJoined
      end
    end
  end
  A0_4.ttfHasEnterNum:setString(TwGetStr(108116, A0_4.joinFightNum, A0_4.countryFightMaxNum))
end
function prototype.onBtnEnter(A0_5, A1_6, A2_7)
  if A0_5.fightInfo == nil then
    return
  end
  if A0_5.ownJoined or A0_5.joinFightNum < A0_5.countryFightMaxNum then
    Logic:Get("Sect"):PostCountryFightJoined(true, A0_5.countryId)
  else
    Prompt:Fail(TwGetStr(108117, A0_5.countryFightMaxNum))
  end
end
function prototype.onBtnSpot(A0_8, A1_9, A2_10)
  Logic:Get("Sect"):PostCountryFightJoined(false, A0_8.countryId)
end
function prototype.onEnterFight(A0_11)
  SceneHelper:removeScene("SectFightEnter")
  SceneHelper:pushScene("SectFight", A0_11.rootNode)
end
function prototype.OnCountryFightEnd(A0_12)
  if SceneHelper:isExistPrompt("SectFightEnter") then
    SceneHelper:removeScene("SectFightEnter")
  end
end
function prototype.onBtnClose(A0_13, A1_14, A2_15)
  A0_13:OnCountryFightEnd()
  SceneHelper:pushScene("SectFightMain", A0_13.rootNode)
end
