module((...), package.seeall)
require("SceneHelper")
PROMPT_TYPE = Enum({
  "SUC",
  "FAILED",
  "MSG",
  "TIP",
  "CONFIRM",
  "SELECT",
  "NONE"
})
RET = Enum({"OK", "CANCEL"})
function Msg(A0_0, A1_1)
  if type(A1_1) ~= "string" or not A1_1 then
    A1_1 = TwGetStr(A1_1)
  end
  ConfirmDlg(nil, "", A1_1)
end
function Fail(A0_2, A1_3)
  if type(A1_3) ~= "string" or not A1_3 then
    A1_3 = TwGetStr(A1_3)
  end
  ConfirmDlg(nil, "", A1_3)
end
function Tip(A0_4, A1_5)
  if type(A1_5) ~= "string" or not A1_5 then
    A1_5 = TwGetStr(A1_5)
  end
  ConfirmDlg(nil, 0, A1_5)
end
function FadeMsg(A0_6, A1_7, A2_8)
  local L3_9
  L3_9 = type
  L3_9 = L3_9(A1_7)
  if L3_9 ~= "string" or not A1_7 then
    L3_9 = TwGetStr
    L3_9 = L3_9(A1_7)
    A1_7 = L3_9
  end
  A2_8 = A2_8 or 4279828286
  L3_9 = DlgTmpl
  L3_9 = L3_9.Get
  L3_9 = L3_9(L3_9, "FadePrompt")
  L3_9 = L3_9 or DlgTmpl:Open("FadePrompt")
  assert(L3_9 ~= nil)
  ConfirmDlg(nil, "", A1_7)
end
function Confirm(A0_10, A1_11, A2_12, A3_13, A4_14, A5_15, A6_16)
  ConfirmDlg(A1_11, A2_12, A3_13, A4_14, A5_15, A6_16)
end
function Select(A0_17, A1_18, A2_19, A3_20, A4_21, A5_22, A6_23)
  ConfirmDlg(A1_18, A2_19, A3_20, A4_21, Prompt.PROMPT_TYPE.SELECT, true)
end
function PromptDlg(A0_24, A1_25, A2_26)
  log4system:debug(A1_25)
  do return end
  if nil == A1_25 or 0 == #A1_25 then
    return
  end
  DlgTmpl:Close("Prompt")
  if nil == DlgTmpl:Open("Prompt") then
    return
  end
  DlgTmpl:Open("Prompt"):SetPrompt(A0_24, A1_25, A2_26)
end
function ConfirmDlg(A0_27, A1_28, A2_29, A3_30, A4_31, A5_32)
  local L6_33
  L6_33 = {}
  L6_33.title = A1_28
  L6_33.content = A2_29
  L6_33.param = A5_32
  if A3_30 ~= nil then
    L6_33.func = bind(A3_30, A0_27)
  end
  L6_33.eType = A4_31
  Logic:Get("SureConfirm"):SetConfirm(L6_33)
  SceneHelper:pushPrompt("SureConfirm", nil)
end
function ConfirmLeft(A0_34, A1_35, A2_36, A3_37, A4_38, A5_39, A6_40)
  local L7_41
  L7_41 = {}
  L7_41.title = A2_36
  L7_41.content = A3_37
  L7_41.param = A6_40
  L7_41.textType = "1"
  if A4_38 ~= nil then
    L7_41.func = bind(A4_38, A1_35)
  end
  L7_41.eType = A5_39
  Logic:Get("SureConfirm"):SetConfirm(L7_41)
  SceneHelper:pushPrompt("SureConfirm", nil)
end
function ConfirmBtnText(A0_42, A1_43, A2_44)
  local L3_45
  L3_45 = {}
  A1_43 = A1_43 or 103002
  L3_45.ok = type(A1_43) == "string" and A1_43 or TwGetStr(A1_43)
  A2_44 = A2_44 or 103003
  L3_45.cancel = type(A2_44) == "string" and A2_44 or TwGetStr(A2_44)
  Logic:Get("SureConfirm"):SetBtnText(L3_45)
end
function PopTip(A0_46, A1_47, A2_48)
  if type(A1_47) ~= "string" or not A1_47 then
    A1_47 = TwGetStr(A1_47)
  end
  A2_48 = A2_48 or ccColor3B(255, 0, 0)
  Logic:Get("SureConfirm"):SetPopTip(A1_47)
  Logic:Get("SureConfirm"):SetPopTipColor(A2_48)
  SceneHelper:pushPrompt("PopTip", nil)
end
function LockTip(A0_49, A1_50, A2_51)
  if type(A1_50) ~= "string" or not A1_50 then
    A1_50 = TwGetStr(A1_50)
  end
  Logic:Get("SureConfirm"):SetPopTip(A1_50)
  SceneHelper:pushPrompt("LockTip", nil)
end
function ConfirmRecord(A0_52, A1_53, A2_54, A3_55, A4_56, A5_57, A6_58, A7_59)
  local L8_60
  L8_60 = {}
  L8_60.title = A2_54
  L8_60.content = A3_55
  L8_60.param = A6_58
  if A4_56 ~= nil then
    L8_60.func = bind(A4_56, A1_53)
  end
  L8_60.eType = A5_57
  Logic:Get("SureConfirm"):SetConfirm(L8_60)
  Logic:Get("SureConfirm"):setCurFrame(A7_59)
  if Logic:Get("SureConfirm"):getCurFramePromptFlag() then
    if L8_60.func then
      L8_60.func()
    end
    Logic:Get("SureConfirm"):clear()
    return
  end
  SceneHelper:pushPrompt("SureRecordFrame", nil)
end
function BuyConfirm(A0_61, A1_62, A2_63)
  local L3_64
  L3_64 = {}
  L3_64.title = A2_63.title or ""
  L3_64.content = A2_63.content or ""
  L3_64.func = A2_63.func and bind(A2_63.func, A1_62) or A2_63.func
  L3_64.cost = A2_63.cost or 1
  L3_64.cost = L3_64.cost == 0 and 1 or L3_64.cost
  L3_64.amount = A2_63.amount or 1
  L3_64.max = A2_63.max
  L3_64.currencyName = A2_63.currencyName or TwGetStr(103009)
  L3_64.currencyPath = A2_63.currencyPath
  L3_64.currencyColor = A2_63.currencyColor
  Logic:Get("SureConfirm"):SetConfirm(L3_64)
  SceneHelper:pushPrompt("BuyConfirm", nil)
end
function TableViewConfirm(A0_65, A1_66, A2_67)
  local L3_68
  L3_68 = {}
  L3_68.func = A2_67.func and bind(A2_67.func, A1_66) or A2_67.func
  L3_68.list = A2_67.list or {}
  Logic:Get("SureConfirm"):SetConfirm(L3_68)
  SceneHelper:pushPrompt("TableViewConfirm", nil)
end
function IconConfirm(A0_69, A1_70, A2_71)
  local L3_72
  L3_72 = {}
  L3_72.func = A2_71.func and bind(A2_71.func, A1_70) or A2_71.func
  L3_72.content = A2_71.content or {}
  L3_72.content.str = L3_72.content.str and L3_72.content.str or ""
  L3_72.title = A2_71.title or ""
  L3_72.titlePath = A2_71.titlePath
  L3_72.eType = A2_71.eType
  L3_72.richtexts = A2_71.richtexts or {}
  L3_72.rewards = A2_71.rewards or {}
  L3_72.minisizeFlag = A2_71.minisizeFlag
  L3_72.blessJade = A2_71.blessJade
  Logic:Get("SureConfirm"):SetConfirm(L3_72)
  SceneHelper:pushPrompt("SureIconConfirm", nil)
end
