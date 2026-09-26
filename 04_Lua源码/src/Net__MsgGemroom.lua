local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 70
cmd = {
  LOAD_GEM_ROOM = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.gemroom.model.GemroomVo"
    }
  },
  REFRESH = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.gemroom.model.RefreshVo"
    }
  },
  EXCHANGE = {
    3,
    {position = int},
    {
      code = int,
      content = "com.eyu.mt.module.gemroom.model.ExchangeVo"
    }
  },
  CLEAR_COOL_TIME = {
    4,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.cost.model.CostResult")
    }
  }
}
types = {
  ["facade.GemroomResult"] = const({
    NOT_IN_COOL_TIME = -7,
    IS_IN_COOL_TIME = -6,
    ACTIVITY_IS_NOT_OPEN = -5,
    COST_REFRESH_TIMES_LIMIT = -4,
    POSITION_TREASURE_HAD_BEEN_GOT = -3,
    NO_RELATIVE_POSITION_TREASURE = -2,
    CURRENCY_IS_NOT_ENOUGH = -1
  }),
  ["model.ExchangeVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    gotTreasures = array(int),
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult"),
    treasures = map(int, int)
  },
  ["model.GemroomVo"] = {
    coolState = bool,
    coolTime = date,
    gotTreasures = array(int),
    refreshTimes = int,
    treasures = map(int, int)
  },
  ["model.RefreshVo"] = {
    coolState = bool,
    coolTime = date,
    times = int,
    treasures = map(int, int)
  }
}
NetMsg:Import(...)
