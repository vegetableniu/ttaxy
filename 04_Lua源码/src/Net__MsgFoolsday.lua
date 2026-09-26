local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 60
cmd = {
  INFO = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.foolsday.model.InfoVo"
    }
  },
  FLOP = {
    2,
    {position = int},
    {
      code = int,
      content = "com.eyu.mt.module.foolsday.model.FlopVo"
    }
  },
  RESET = {
    3,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.foolsday.model.ResetVo"
    }
  }
}
types = {
  ["facade.FoolsDayResult"] = const({
    ACTIVITY_IS_NOT_OPEN = -5,
    NOT_FOUNT_PLAYER_LEVEL_SECTION = -4,
    CURRENCY_IS_NOT_ENOUGH = -3,
    FLOP_REPEAT = -2,
    TODAY_RESET_TIMES_IS_MAX = -1
  }),
  ["model.FlopVo"] = {
    card = int,
    costAndReward = "com.eyu.mt.module.cost.model.CostAndReward",
    levelSegment = int,
    resetTimes = int
  },
  ["model.InfoVo"] = {
    cards = map(int, int),
    levelSegment = int,
    resetTimes = int
  },
  ["model.ResetVo"] = {
    costs = array("com.eyu.mt.module.cost.model.CostResult"),
    levelSegment = int,
    resetTimes = int
  }
}
NetMsg:Import(...)
