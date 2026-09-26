local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 80
cmd = {
  LOAD_INFO = {
    1,
    {activityId = string},
    {
      code = int,
      content = "com.eyu.mt.module.exchange.model.ExchangeInfo"
    }
  },
  LOAD_EXCHANGE = {
    2,
    {
      heros = array(long),
      id = int
    },
    {
      code = int,
      content = "com.eyu.mt.module.exchange.model.ExchangeVo"
    }
  }
}
types = {
  ["facade.ExchangeResult"] = const({
    HERO_CAN_NOT_DELETE = -15,
    LEVEL_LIMIT = -14,
    MATERIAL_ID_REPEAT = -13,
    ERROR_MATERIAL_ID = -12,
    ERROR_MATERIAL_TYPE = -11,
    MATERIALS_IS_NOT_SUITABLE = -10,
    HERO_LOCKED = -9,
    HERO_NOT_FOUND = -8,
    HERO_IN_GROUP = -7,
    NOT_NEED_OTHER_MATERIALS = -6,
    PLEASE_SELECT_OTHER_MATERIALS = -5,
    MATERIAL_IS_NOT_ENOUGH = -4,
    TIMES_LIMIT = -3,
    NO_RELATIVE_EXCHANGE_GOODS = -2,
    ACTIVITY_IS_NOT_OPEN = -1
  }),
  ["model.ExchangeInfo"] = {
    buyTimes = map(int, int),
    sweets = map(int, int)
  },
  ["model.ExchangeVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  }
}
NetMsg:Import(...)
