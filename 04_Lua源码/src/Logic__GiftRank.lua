module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({"GET_INFO"})
function class:initialize()
  super.initialize(self)
  self.langIds = {}
  self.congifKey = ""
  self.formName = ""
  self.rankData = {}
  self.actives = {
    QINGMING_RANK = {
      Init = bind(self.qingMingInit, self),
      activityType = "QINGMING",
      subScene = "GiftTombSweeping"
    }
  }
end
function class:dispose()
  super.dispose(self)
end
function class:SetRankData(data)
  self.rankData = data or {}
end
function class:GetRankData()
  return self.rankData
end
function class:GetCloseTime()
  if table.empty(self.rankData or {}) then
    return 0
  end
  return self.rankData.closeTime or 0
end
function class:GetCongifKey()
  return self.congifKey
end
function class:GetLanguageIds()
  return self.langIds
end
function class:GetFormName()
  return self.formName
end
function class:GetActivesInfo(activityType)
  if self.actives[activityType] then
    return self.actives[activityType]
  end
  return {}
end
function class:Init(activityType)
  if self.actives[activityType] then
    self.actives[activityType]:Init()
  end
end
function class:qingMingInit()
  self.congifKey = "QINGMING:RANK_REWARD"
  self.formName = "QingmingRank"
  self.langIds = {
    1031,
    1019,
    1022
  }
  Logic:Get("QingMing"):PostGetInfo()
end
