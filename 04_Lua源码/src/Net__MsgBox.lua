local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 54
cmd = {
  OPEN_BOX_BY_KEY = {
    1,
    {boxId = int},
    {
      code = int,
      content = "com.eyu.mt.module.box.model.OpenBoxByKeyVo"
    }
  },
  OPEN_BOX_BY_CURRENCY = {
    2,
    {boxId = int},
    {
      code = int,
      content = "com.eyu.mt.module.box.model.OpenBoxByCostVo"
    }
  },
  LOAD_BOX_INFO = {
    3,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.box.model.BoxVo"
    }
  }
}
types = {
  ["facade.BoxResult"] = const({
    COST_OPEN_TIMES_LIMIT = -6,
    NOT_ENOUGH_CURRENCY = -5,
    NOT_ENOUGH_KEY = -4,
    BOX_NOT_EXIST = -3,
    ACTIVITY_NOT_OPEN = -2
  }),
  ["model.BoxVo"] = {
    coinNum = int,
    costOpenTimes = map(int, int),
    keys = map(int, int)
  },
  ["model.KeyType"] = enum({
    [0] = "GREEN_KEY",
    [1] = "BLUE_KEY",
    [2] = "PURPLE_KEY"
  }),
  ["model.OpenBoxByCostVo"] = {
    costOpenTimes = map(int, int),
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.OpenBoxByKeyVo"] = {
    keys = map(int, int),
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  }
}
NetMsg:Import(...)
