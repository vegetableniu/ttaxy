local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 50
cmd = {
  COOK_COOLTIME = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.dumpling.model.CookCoolTimeVo"
    }
  },
  DUMPLING_STATE = {
    2,
    {},
    {}
  },
  COOK = {
    3,
    {dumpling = long},
    {
      code = int,
      content = "com.eyu.mt.module.dumpling.model.CookVo"
    }
  },
  GET_COOK_REWARD = {
    4,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  },
  CLEAR_COOL_TIME = {
    5,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.cost.model.CostResult")
    }
  }
}
types = {
  ["facade.DumplingResult"] = const({
    CARD_CAN_NOT_DELETE = -7,
    CARD_TYPE_ERROR = -6,
    RIPED = -5,
    NOT_RIPE = -4,
    NOT_COOKING = -3,
    NOT_ENOUGH = -2,
    COOKING = -1
  }),
  ["model.CookCoolTimeVo"] = {baseId = int, coolTime = date},
  ["model.CookVo"] = {
    coolTime = date,
    costs = array("com.eyu.mt.module.cost.model.CostResult"),
    type = int
  }
}
NetMsg:Import(...)
