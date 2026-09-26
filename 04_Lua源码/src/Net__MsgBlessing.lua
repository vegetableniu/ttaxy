local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 69
cmd = {
  INFO = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.blessing.model.BlessingVo"
    }
  },
  LOTTERY = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.blessing.model.LotteryVo"
    }
  }
}
types = {
  ["facade.BlessingResult"] = const({
    CURRENCY_IS_NOT_ENOUGH = -4,
    TIMES_LIMIT = -3,
    CHARGE_NOT_ENOUGH = -2,
    ACTIVITY_IS_NOT_OPEN = -1
  }),
  ["model.BlessingVo"] = {
    charge = int,
    rank = int,
    times = int,
    totalTimes = int
  },
  ["model.LotteryVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    rank = int,
    rewardResults = array(array("com.eyu.mt.module.reward.model.RewardResult"))
  }
}
NetMsg:Import(...)
