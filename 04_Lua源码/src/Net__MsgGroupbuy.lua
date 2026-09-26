local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 46
cmd = {
  GET_REWARD = {
    1,
    {baseId = int},
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  },
  LOAD_REWARD_INFO = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.groupbuy.model.LoadRewardInfoVo"
    }
  }
}
types = {
  ["facade.GroupbuyResult"] = const({
    NO_MATCH_CONDITION = -5,
    HAVE_GOT_THE_REWARD = -4,
    WEEK_COUNT_IS_NOT_ENOUGH = -3,
    MONTH_COUNT_IS_NOT_ENOUGH = -2,
    CHARGE_IS_NOT_ENOUGH = -1
  }),
  ["model.GetRewardType"] = enum({
    [0] = "ALL",
    [1] = "WEEK",
    [2] = "MONTH"
  }),
  ["model.LoadRewardInfoVo"] = {
    baseRewardIds = array(int),
    chargeCount = int,
    monthPlayers = int,
    weekPlayers = int
  }
}
NetMsg:Import(...)
