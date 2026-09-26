module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype.ReFrashHeroInfo(A0_0, A1_1)
  if A1_1 == nil or next(A1_1) == nil then
    return
  end
  A0_0.titleInfoArr = A1_1
  A0_0.strategynodetitle1:setString(TwGetStr(A1_1[1].title1) or "")
  A0_0.strategynodetitle1:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  if not table.empty(A1_1[2]) then
    A0_0.strategynodetitle2:setString(TwGetStr(A1_1[2].title1) or "")
    A0_0.strategynodetitle2:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  else
    A0_0.strategynodetitle2:setVisible(false)
    A0_0.btnstragenode:setVisible(false)
  end
end
function prototype.contactSupport(A0_2)
  Prompt:Tip("QQ\239\188\1543020518718")
end
function prototype.onBtnSelect(A0_3, A1_4)
  local L2_5, L3_6, L4_7, L5_8
  L2_5 = table
  L2_5 = L2_5.empty
  L3_6 = A1_4
  L2_5 = L2_5(L3_6)
  if L2_5 then
    return
  end
  A0_3.titleInfo = A1_4
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 10158 then
    L2_5 = Logic
    L3_6 = L2_5
    L2_5 = L2_5.Get
    L4_7 = "EnvLogic"
    L2_5 = L2_5(L3_6, L4_7)
    L3_6 = L2_5
    L2_5 = L2_5.EnterPlatform
    L4_7 = "webSite"
    L2_5(L3_6, L4_7)
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 106005 then
    L2_5 = Prompt
    L3_6 = L2_5
    L2_5 = L2_5.Tip
    L4_7 = "\230\176\170\233\135\145"
    L2_5(L3_6, L4_7)
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 106001 then
    L2_5 = Logic
    L3_6 = L2_5
    L2_5 = L2_5.Get
    L4_7 = "EnvLogic"
    L2_5 = L2_5(L3_6, L4_7)
    L2_5.isOpenCallBoard = false
    L2_5 = Logic
    L3_6 = L2_5
    L2_5 = L2_5.Get
    L4_7 = "Login"
    L2_5 = L2_5(L3_6, L4_7)
    L3_6 = L2_5
    L2_5 = L2_5.setCallBoardImg
    L4_7 = true
    L2_5(L3_6, L4_7)
    L2_5 = Logic
    L3_6 = L2_5
    L2_5 = L2_5.Get
    L4_7 = "Login"
    L2_5 = L2_5(L3_6, L4_7)
    L3_6 = L2_5
    L2_5 = L2_5.openCallboard
    L2_5(L3_6)
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 106004 then
    L2_5 = Logic
    L3_6 = L2_5
    L2_5 = L2_5.Get
    L4_7 = "System"
    L2_5 = L2_5(L3_6, L4_7)
    L3_6 = L2_5
    L2_5 = L2_5.IsChannel
    L4_7 = "taiwsq"
    L2_5 = L2_5(L3_6, L4_7)
    if L2_5 then
      L2_5 = 50
      L3_6 = 0
      L4_7 = CCDirector
      L5_8 = L4_7
      L4_7 = L4_7.sharedDirector
      L4_7 = L4_7(L5_8)
      L5_8 = L4_7
      L4_7 = L4_7.getWinSize
      L4_7 = L4_7(L5_8)
      L5_8 = Logic
      L5_8 = L5_8.Get
      L5_8 = L5_8(L5_8, "EnvLogic")
      L5_8 = L5_8.OpenUrlRectType
      L5_8(L5_8, Logic:Get("System"):GetMisc("forumAddress"), {
        L2_5,
        L3_6,
        L4_7.width - L2_5 * 2,
        L4_7.height - L3_6 * 2
      })
    else
      L2_5 = Logic
      L3_6 = L2_5
      L2_5 = L2_5.Get
      L4_7 = "EnvLogic"
      L2_5 = L2_5(L3_6, L4_7)
      L3_6 = L2_5
      L2_5 = L2_5.OpenUrl
      L4_7 = Logic
      L5_8 = L4_7
      L4_7 = L4_7.Get
      L4_7 = L4_7(L5_8, "System")
      L5_8 = L4_7
      L4_7 = L4_7.GetMisc
      L5_8 = L4_7(L5_8, "forumAddress")
      L2_5(L3_6, L4_7, L5_8, L4_7(L5_8, "forumAddress"))
    end
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 10163 then
    L2_5 = Logic
    L3_6 = L2_5
    L2_5 = L2_5.Get
    L4_7 = "EnvLogic"
    L2_5 = L2_5(L3_6, L4_7)
    L3_6 = L2_5
    L2_5 = L2_5.EnterPlatform
    L4_7 = "moreGames"
    L2_5(L3_6, L4_7)
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 10164 then
    L2_5 = Logic
    L3_6 = L2_5
    L2_5 = L2_5.Get
    L4_7 = "System"
    L2_5 = L2_5(L3_6, L4_7)
    L3_6 = L2_5
    L2_5 = L2_5.GetOperatorItemFromFile
    L4_7 = "sdkInfo"
    L5_8 = "config.dat"
    L2_5 = L2_5(L3_6, L4_7, L5_8)
    L3_6 = CVariableSystem
    L4_7 = L3_6
    L3_6 = L3_6.GetSingleton
    L3_6 = L3_6(L4_7)
    L4_7 = L3_6
    L3_6 = L3_6.GetSysVariable
    L5_8 = GV_VERSION
    L3_6 = L3_6(L4_7, L5_8)
    L4_7 = {
      L5_8,
      {
        TwGetStr(10167),
        L2_5.Company
      },
      {
        TwGetStr(10168),
        L2_5.phoneNum
      },
      {
        TwGetStr(10169) .. L2_5.statement,
        nil
      }
    }
    L5_8 = {
      TwGetStr(10165),
      L2_5.GameName,
      TwGetStr(10166),
      L2_5.GameType,
      TwGetStr(10170),
      L3_6
    }
    L5_8 = table
    L5_8 = L5_8.concat
    L5_8 = L5_8(list.map(function(A0_9)
      return "\n" .. table.concat(A0_9, " ")
    end, L4_7), " ")
    L5_8 = L5_8 .. " "
    Logic:Get("SureConfirm"):setFontSize(19)
    Prompt:Tip(L5_8)
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 106002 then
    L2_5 = SceneHelper
    L3_6 = L2_5
    L2_5 = L2_5.pushScene
    L4_7 = A0_3.titleInfo
    L4_7 = L4_7.subScene
    L5_8 = A0_3.rootNode
    L2_5(L3_6, L4_7, L5_8)
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 106003 then
    L2_5 = Logic
    L3_6 = L2_5
    L2_5 = L2_5.Get
    L4_7 = "System"
    L2_5 = L2_5(L3_6, L4_7)
    L3_6 = L2_5
    L2_5 = L2_5.IsCloseAutoLogin
    L2_5 = L2_5(L3_6)
    if L2_5 then
      L2_5 = Logic
      L3_6 = L2_5
      L2_5 = L2_5.Get
      L4_7 = "System"
      L2_5 = L2_5(L3_6, L4_7)
      L3_6 = L2_5
      L2_5 = L2_5.IsSelfAccLogin
      L2_5 = L2_5(L3_6)
      if not L2_5 then
        L2_5 = Logic
        L3_6 = L2_5
        L2_5 = L2_5.Get
        L4_7 = "EnvLogic"
        L2_5 = L2_5(L3_6, L4_7)
        L3_6 = L2_5
        L2_5 = L2_5.Logout
        L2_5(L3_6)
      end
    else
      L2_5 = Singleton
      L3_6 = GameStage
      L2_5 = L2_5(L3_6)
      L3_6 = L2_5
      L2_5 = L2_5.ChgStage
      L4_7 = "Logout"
      L5_8 = true
      L2_5(L3_6, L4_7, L5_8)
    end
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 10134 then
    L2_5 = Logic
    L3_6 = L2_5
    L2_5 = L2_5.Get
    L4_7 = "System"
    L2_5 = L2_5(L3_6, L4_7)
    L3_6 = L2_5
    L2_5 = L2_5.IsChannel
    L4_7 = "taiwsq"
    L2_5 = L2_5(L3_6, L4_7)
    if L2_5 then
      L2_5 = 50
      L3_6 = 0
      L4_7 = CCDirector
      L5_8 = L4_7
      L4_7 = L4_7.sharedDirector
      L4_7 = L4_7(L5_8)
      L5_8 = L4_7
      L4_7 = L4_7.getWinSize
      L4_7 = L4_7(L5_8)
      L5_8 = Logic
      L5_8 = L5_8.Get
      L5_8 = L5_8(L5_8, "EnvLogic")
      L5_8 = L5_8.OpenUrlRectType
      L5_8(L5_8, Logic:Get("System"):GetMisc("talkAddress"), {
        L2_5,
        L3_6,
        L4_7.width - L2_5 * 2,
        L4_7.height - L3_6 * 2
      })
    else
      L2_5 = Logic
      L3_6 = L2_5
      L2_5 = L2_5.Get
      L4_7 = "EnvLogic"
      L2_5 = L2_5(L3_6, L4_7)
      L3_6 = L2_5
      L2_5 = L2_5.OpenUrl
      L4_7 = Logic
      L5_8 = L4_7
      L4_7 = L4_7.Get
      L4_7 = L4_7(L5_8, "System")
      L5_8 = L4_7
      L4_7 = L4_7.GetMisc
      L5_8 = L4_7(L5_8, "talkAddress")
      L2_5(L3_6, L4_7, L5_8, L4_7(L5_8, "talkAddress"))
    end
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 102204 then
    L2_5 = Logic
    L3_6 = L2_5
    L2_5 = L2_5.Get
    L4_7 = "Main"
    L2_5 = L2_5(L3_6, L4_7)
    L3_6 = L2_5
    L2_5 = L2_5.GotoBindAccount
    L2_5(L3_6)
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 104200 then
    L2_5 = SceneHelper
    L3_6 = L2_5
    L2_5 = L2_5.pushScene
    L4_7 = "BattleTest"
    L5_8 = A0_3.rootNode
    L2_5(L3_6, L4_7, L5_8)
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 108005 then
    L2_5 = SceneHelper
    L3_6 = L2_5
    L2_5 = L2_5.pushScene
    L4_7 = A0_3.titleInfo
    L4_7 = L4_7.subScene
    L5_8 = A0_3.rootNode
    L2_5(L3_6, L4_7, L5_8)
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 10127 then
    L2_5 = Logic
    L3_6 = L2_5
    L2_5 = L2_5.Get
    L4_7 = "EnvLogic"
    L2_5 = L2_5(L3_6, L4_7)
    L3_6 = L2_5
    L2_5 = L2_5.EnterPlatform
    L4_7 = "userCenter"
    L2_5(L3_6, L4_7)
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 10146 then
    L2_5 = Logic
    L3_6 = L2_5
    L2_5 = L2_5.Get
    L4_7 = "EnvLogic"
    L2_5 = L2_5(L3_6, L4_7)
    L3_6 = L2_5
    L2_5 = L2_5.EnterPlatform
    L4_7 = "accuntManager"
    L2_5(L3_6, L4_7)
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 10129 then
    L3_6 = A0_3
    L2_5 = A0_3.contactSupport
    L2_5(L3_6)
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 10130 then
    L2_5 = Prompt
    L3_6 = L2_5
    L2_5 = L2_5.Select
    L4_7 = A0_3
    L5_8 = ""
    L2_5(L3_6, L4_7, L5_8, 10131, A0_3.onConfirmDelAccount)
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 10132 then
    L2_5 = Logic
    L3_6 = L2_5
    L2_5 = L2_5.Get
    L4_7 = "EnvLogic"
    L2_5 = L2_5(L3_6, L4_7)
    L3_6 = L2_5
    L2_5 = L2_5.EnterPlatform
    L4_7 = "homepage"
    L2_5(L3_6, L4_7)
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 10133 then
    L2_5 = Logic
    L3_6 = L2_5
    L2_5 = L2_5.Get
    L4_7 = "System"
    L2_5 = L2_5(L3_6, L4_7)
    L3_6 = L2_5
    L2_5 = L2_5.IsOperator
    L4_7 = "ilovewebgame"
    L2_5 = L2_5(L3_6, L4_7)
    L3_6 = Logic
    L4_7 = L3_6
    L3_6 = L3_6.Get
    L5_8 = "Account"
    L3_6 = L3_6(L4_7, L5_8)
    L4_7 = L3_6
    L3_6 = L3_6.GetIsVisitorType
    L3_6 = L3_6(L4_7)
    if L2_5 and L3_6 then
      L4_7 = Prompt
      L5_8 = L4_7
      L4_7 = L4_7.Confirm
      L4_7(L5_8, Logic:Get("Main"), "", 102217, Logic:Get("Main").GotoBindAccount, Prompt.PROMPT_TYPE.SELECT)
      return
    end
    L4_7 = Logic
    L5_8 = L4_7
    L4_7 = L4_7.Get
    L4_7 = L4_7(L5_8, "EnvLogic")
    L5_8 = L4_7
    L4_7 = L4_7.EnterPlatform
    L4_7(L5_8, "event")
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 106008 then
    L2_5 = SceneHelper
    L3_6 = L2_5
    L2_5 = L2_5.pushScene
    L4_7 = A0_3.titleInfo
    L4_7 = L4_7.subScene
    L5_8 = A0_3.rootNode
    L2_5(L3_6, L4_7, L5_8)
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 10153 then
    L2_5 = Logic
    L3_6 = L2_5
    L2_5 = L2_5.Get
    L4_7 = "EnvLogic"
    L2_5 = L2_5(L3_6, L4_7)
    L3_6 = L2_5
    L2_5 = L2_5.EnterPlatform
    L4_7 = "perfectAccount"
    L2_5(L3_6, L4_7)
  end
  L2_5 = A0_3.titleInfo
  L2_5 = L2_5.title1
  if L2_5 == 10154 then
    L2_5 = Logic
    L3_6 = L2_5
    L2_5 = L2_5.Get
    L4_7 = "EnvLogic"
    L2_5 = L2_5(L3_6, L4_7)
    L3_6 = L2_5
    L2_5 = L2_5.EnterPlatform
    L4_7 = "feedbackProblem"
    L2_5(L3_6, L4_7)
  end
end
function prototype.onConfirmDelAccount(A0_10, A1_11)
  if A1_11 == Prompt.RET.OK then
    Logic:Get("EnvLogic"):DelAccount()
  end
end
function prototype.onBtnSelectLeft(A0_12)
  A0_12:onBtnSelect(A0_12.titleInfoArr[1])
end
function prototype.onBtnSelectRight(A0_13)
  if table.empty(A0_13.titleInfoArr[2]) then
    return
  end
  A0_13:onBtnSelect(A0_13.titleInfoArr[2])
end
