local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 21
cmd = {
  BUY_SINGLE = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.cost.model.CostAndReward"
    }
  },
  CURRENT_POINT = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.point.model.ActionPointVo"
    }
  }
}
types = {
  ["facade.ActionPointResult"] = const({
    POINT_FULL_LIMIT = -403,
    BUY_LIMIT = -402,
    NOT_ENOUGHT = -401
  }),
  ["manager.PointValue"] = {
    exchangeCount = int,
    exchangeTime = date,
    extraTime = date,
    point = int,
    refreshTime = date
  },
  ["model.ActionPointVo"] = {
    points = map("com.eyu.mt.module.point.model.PointType", "com.eyu.mt.module.point.manager.PointValue")
  },
  ["model.PointInfo"] = {point = int, refreshTime = date},
  ["model.PointType"] = enum({
    [0] = "SINGLE",
    [1] = "DEMOG",
    [2] = "MENPAI"
  })
}
NetMsg:Import(...)
