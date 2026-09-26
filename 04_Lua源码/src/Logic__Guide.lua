require("Logic")
require("SceneHelper")
module((...), package.seeall)
EVT = Enum({
  "ACTIVE",
  "STEP",
  "DISMISS",
  "LOCK",
  "LOCK_TOUCH",
  "LOCK_DRAG",
  "LOCK_BATTLE"
})
class = Logic.class:subclass()
function class.initialize(A0_0)
  super.initialize(A0_0)
  A0_0:reload()
end
function class.dispose(A0_1)
  super.dispose(A0_1)
end
function class.setup(A0_2)
  A0_2:save(A0_2:getAllModules())
  A0_2:reload()
end
function class.check(A0_3)
  local L1_4
  while true do
    L1_4 = A0_3.isNeedCheck
    L1_4 = L1_4(A0_3)
    if L1_4 then
      L1_4 = A0_3.modules
      L1_4 = L1_4[1]
    elseif not A0_3:doCheck(L1_4, A0_3.triggers[L1_4]).done and not A0_3:doCheck(L1_4, A0_3.triggers[L1_4]).active then
      break
    end
    table.remove(A0_3.modules, 1)
    A0_3.triggers[L1_4] = nil
    if A0_3:doCheck(L1_4, A0_3.triggers[L1_4]).done then
      A0_3:save(A0_3.modules)
    end
    if A0_3:doCheck(L1_4, A0_3.triggers[L1_4]).active then
      A0_3.guides[L1_4] = {
        all = A0_3:doCheck(L1_4, A0_3.triggers[L1_4]).steps,
        left = list.depair(list.map(function(A0_5)
          local L1_6
          L1_6 = {A0_5, false}
          return L1_6
        end, table.values(A0_3:doCheck(L1_4, A0_3.triggers[L1_4]).steps)))
      }
      A0_3.guide = L1_4
      Logic:Get("DramaTalk"):OnGuideTrigger(A0_3:doCheck(L1_4, A0_3.triggers[L1_4]).dramaTalk, bind(A0_3.actived, A0_3), A0_3:doCheck(L1_4, A0_3.triggers[L1_4]).cover)
    end
  end
  return
end
function class.actived(A0_7)
  local L1_8
  L1_8 = log4guide
  L1_8 = L1_8.info
  L1_8(L1_8, "[%s] actived.", A0_7.guide)
  L1_8 = A0_7.FireEvent
  L1_8(A0_7, EVT.ACTIVE, A0_7.guide)
  L1_8 = A0_7.guides
  L1_8 = L1_8[A0_7.guide]
  L1_8 = L1_8.all
  L1_8 = L1_8[1]
  log4guide:info("[%s-%s] actived.", A0_7.guide, L1_8)
  A0_7.guides[A0_7.guide].left[L1_8] = true
  A0_7:lock()
  A0_7:FireEvent(EVT.STEP)
end
function class.isGuiding(A0_9)
  return not table.empty(A0_9.guides)
end
function class.isDone(A0_10, A1_11)
  local L2_12
  L2_12 = A0_10.triggers
  L2_12 = L2_12[A1_11]
  if L2_12 ~= nil then
    L2_12 = false
    return L2_12
  end
  L2_12 = A0_10.guides
  L2_12 = L2_12[A1_11]
  if L2_12 ~= nil then
    L2_12 = false
    return L2_12
  end
  L2_12 = true
  return L2_12
end
function class.isActive(A0_13, A1_14, A2_15)
  local L3_16
  L3_16 = A0_13.triggers
  L3_16 = L3_16[A1_14]
  if L3_16 ~= nil then
    L3_16 = false
    return L3_16
  end
  L3_16 = A0_13.guides
  L3_16 = L3_16[A1_14]
  if L3_16 == nil then
    L3_16 = false
    return L3_16
  end
  if A2_15 == nil then
    L3_16 = true
    return L3_16
  end
  L3_16 = A0_13.guides
  L3_16 = L3_16[A1_14]
  L3_16 = L3_16.left
  L3_16 = L3_16[A2_15]
  return L3_16
end
function class.done(A0_17, A1_18, A2_19)
  local L3_20
  L3_20 = A0_17.isActive
  L3_20 = L3_20(A0_17, A1_18, A2_19)
  if not L3_20 then
    return
  end
  L3_20 = log4guide
  L3_20 = L3_20.info
  L3_20(L3_20, "[%s-%s] done.", A1_18, A2_19)
  L3_20 = A0_17.guides
  L3_20 = L3_20[A1_18]
  L3_20 = L3_20.left
  L3_20[A2_19] = nil
  L3_20 = A0_17.nextStep
  L3_20 = L3_20(A0_17, A1_18, A2_19)
  if L3_20 ~= nil then
    log4guide:info("[%s-%s] actived.", A1_18, L3_20)
    A0_17.guides[A1_18].left[L3_20] = true
    A0_17:lock()
    A0_17:FireEvent(EVT.STEP)
    return
  end
  log4guide:info("[%s] done.", A1_18)
  A0_17.guides[A1_18] = nil
  A0_17:save()
  A0_17:FireEvent(EVT.DISMISS)
  A0_17:check()
end
function class.lock(A0_21)
  A0_21:EventTracer():Cancel("TimerGuard")
  A0_21:FireEvent(EVT.LOCK)
  Singleton(Timer):After(10000, A0_21:Event("TimerGuard", function()
    local L0_22, L1_23, L2_24, L3_25
    L0_22 = _UPVALUE0_
    L0_22 = L0_22.guides
    L1_23 = _UPVALUE0_
    L2_24 = {}
    L1_23.guides = L2_24
    L1_23 = _UPVALUE0_
    L2_24 = L1_23
    L1_23 = L1_23.save
    L1_23(L2_24)
    L1_23 = _UPVALUE0_
    L2_24 = L1_23
    L1_23 = L1_23.FireEvent
    L3_25 = EVT
    L3_25 = L3_25.DISMISS
    L1_23(L2_24, L3_25)
    L1_23 = _UPVALUE0_
    L1_23 = L1_23.guide
    L1_23 = L0_22[L1_23]
    L1_23 = L1_23.left
    L2_24 = _UPVALUE0_
    L2_24 = L2_24.guide
    L2_24 = L2_24 or "nil"
    L3_25 = table
    L3_25 = L3_25.invert
    L3_25 = L3_25(L1_23)
    L3_25 = L3_25[true]
    L3_25 = L3_25 or "nil"
    log4guide:warn("[%s-%s] fail", L2_24, L3_25)
  end))
end
function class.lockTouch(A0_26, A1_27, A2_28, A3_29)
  if A3_29 ~= nil then
    if not A0_26:isActive(A1_27, A2_28) then
      return
    end
  else
    A3_29 = A1_27
  end
  A0_26:EventTracer():Cancel("TimerGuard")
  A0_26:FireEvent(EVT.LOCK_TOUCH, A3_29)
end
function class.lockDrag(A0_30, A1_31, A2_32)
  A0_30:EventTracer():Cancel("TimerGuard")
  A0_30:FireEvent(EVT.LOCK_DRAG, A1_31, A2_32)
end
function class.getAllModules(A0_33)
  local L1_34
  L1_34 = {}
  return L1_34
end
function class.reload(A0_35)
  local L1_36
  L1_36 = {}
  A0_35.modules = L1_36
  L1_36 = CVariableSystem
  L1_36 = L1_36.GetSingleton
  L1_36 = L1_36(L1_36)
  L1_36 = L1_36.GetUsrVariable
  L1_36 = L1_36(L1_36, UV_NEWER)
  if #L1_36 > 0 then
    A0_35.modules = json.decode(L1_36)
  end
  A0_35.modules = list.filter(function(A0_37)
    local L1_38
    L1_38 = _UPVALUE0_
    L1_38 = L1_38[A0_37]
    L1_38 = L1_38 ~= nil
    return L1_38
  end, A0_35.modules)
  A0_35.triggers = list.depair(list.map(function(A0_39)
    local L1_40
    L1_40 = {
      A0_39,
      require("Guide." .. A0_39).trigger:new(A0_39)
    }
    return L1_40
  end, A0_35.modules))
  A0_35.guides = {}
end
function class.save(A0_41, A1_42)
  local L2_43, L3_44
  L2_43 = A1_42 or A0_41.modules
  L3_44 = json
  L3_44 = L3_44.encode
  L3_44 = L3_44(L2_43)
  CVariableSystem:GetSingleton():SetUsrVariable(UV_NEWER, L3_44)
  Logic:Get("System"):SaveUsrVariable()
end
function class.isNeedCheck(A0_45)
  if not table.empty(A0_45.guides) then
    return false
  end
  if table.empty(A0_45.modules) then
    return false
  end
  if SceneHelper:isExistScene("BattleShow") then
    return false
  end
  if SceneHelper:isExistScene("BattleShowResult") then
    return false
  end
  if SceneHelper:isExistScene("BattleFriendAdd") then
    return false
  end
  return true
end
function class.doCheck(A0_46, A1_47, A2_48)
  local L3_49
  L3_49 = {}
  L3_49.done = false
  L3_49.active = false
  L3_49.steps = {}
  L3_49.dramaTalk = nil
  L3_49.cover = false
  if A2_48 == nil then
    log4guide:warn("[%s] trigger is nil", A1_47)
    L3_49.done = true
    return L3_49
  end
  if A2_48:isDone() then
    log4guide:info("[%s] done.", A1_47)
    L3_49.done = true
    return L3_49
  end
  if not A2_48:check() then
    return L3_49
  end
  L3_49.steps = A2_48:steps()
  if table.empty(L3_49.steps) then
    log4guide:warn("[%s] has no step!", A1_47)
    L3_49.done = true
    return L3_49
  end
  L3_49.dramaTalk = A2_48:DramaTalk()
  L3_49.cover = A2_48:isCoverOrNot()
  L3_49.active = true
  return L3_49
end
function class.nextStep(A0_50, A1_51, A2_52)
  local L3_53
  L3_53 = A0_50.guides
  L3_53 = L3_53[A1_51]
  if L3_53 == nil then
    L3_53 = nil
    return L3_53
  end
  L3_53 = A0_50.guides
  L3_53 = L3_53[A1_51]
  L3_53 = L3_53.all
  if table.invert(L3_53)[A2_52] == nil then
    return nil
  end
  return L3_53[table.invert(L3_53)[A2_52] + 1]
end
function class.LockTouchForBattle(A0_54, A1_55)
  A0_54:FireEvent(EVT.LOCK_BATTLE, A1_55)
end
