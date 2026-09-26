local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 66
cmd = {
  LOAD_PITCH = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.football.model.PitchInfo"
    }
  },
  SHOOT = {
    2,
    {position = int},
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  },
  SHOOT_BY_CURRENCY = {
    3,
    {position = int},
    {
      code = int,
      content = "com.eyu.mt.module.football.model.ShootVo"
    }
  }
}
types = {
  ["facade.FootballResult"] = const({
    NO_RELATIVE_POSITION = -4,
    CURRENCY_IS_NOT_ENOUGH = -3,
    FREE_BALL_IS_USED_UP = -2,
    ACTIVITY_IS_NOT_OPEN = -1
  }),
  ["model.PitchInfo"] = {
    buyBalls = int,
    level = int,
    point = int,
    resetTimes = int,
    shootData = map(int, "com.eyu.mt.module.football.model.ShootData"),
    usedFreeBalls = int
  },
  ["model.ShootData"] = {
    hits = int,
    rate = long,
    times = int
  },
  ["model.ShootVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  }
}
NetMsg:Import(...)
