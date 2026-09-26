local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 91
cmd = {
  LOAD_SHOP = {
    1,
    {mallId = int},
    {
      code = int,
      content = "com.eyu.mt.module.preciousroom.model.PreciousroomVo"
    }
  },
  EXCHANGE = {
    2,
    {mallId = int, position = int},
    {
      code = int,
      content = "com.eyu.mt.module.preciousroom.model.ExchangeVo"
    }
  },
  REFRESH = {
    3,
    {mallId = int},
    {
      code = int,
      content = "com.eyu.mt.module.preciousroom.model.RefreshVo"
    }
  }
}
types = {
  ["facade.PreciousroomResult"] = const({
    CAN_REFRESH = -8,
    PLEASE_LOAD_ENTITY_FIRST = -7,
    GOOD_IS_EXPIRE = -6,
    COST_REFRESH_TIMES_LIMIT = -5,
    POSITION_TREASURE_HAD_BEEN_GOT = -4,
    NO_RELATIVE_POSITION_TREASURE = -3,
    ACTIVITY_NOT_OPEN = -2,
    CURRENCY_IS_NOT_ENOUGH = -1
  }),
  ["model.ExchangeVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    gotTreasures = array(int),
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult"),
    roomCurrency = int,
    treasures = map(int, int)
  },
  ["model.PreciousroomVo"] = {
    gotTreasures = array(int),
    refreshTimes = int,
    time = date,
    treasures = map(int, int)
  },
  ["model.RefreshVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    nextTime = date,
    times = int,
    treasures = map(int, int)
  }
}
NetMsg:Import(...)
