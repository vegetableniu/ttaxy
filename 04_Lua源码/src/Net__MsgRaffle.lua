local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 58
cmd = {
  LOAD_RAFFLE = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.raffle.model.RaffleVo"
    }
  },
  REFRESH = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.raffle.model.ResetVo"
    }
  },
  RAFFLE = {
    3,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.raffle.model.RaffleRewardVo"
    }
  }
}
types = {
  ["facade.RaffleResult"] = const({
    IS_EXPIRE = -6,
    REWARD_ID_IS_NULL = -5,
    HAD_RAFFLE_ALL = -4,
    RESET_TIMES_LIMIT = -3,
    CURRENCY_IS_NOT_ENOUGH = -2,
    ACTIVITY_NOT_OPEN = -1
  }),
  ["model.RaffleRewardVo"] = {
    awards = array(string),
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    resetTime = date,
    reward = string,
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.RaffleVo"] = {
    awards = array(string),
    count = int,
    raffleCount = int,
    resetTime = date
  },
  ["model.ResetVo"] = {
    awards = array(string),
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    count = int,
    resetTime = date
  }
}
NetMsg:Import(...)
