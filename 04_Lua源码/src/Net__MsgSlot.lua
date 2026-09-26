local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 78
cmd = {
  LOAD_INFO = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.slot.model.SlotVo"
    }
  },
  LOTTERY = {
    2,
    {currency = bool},
    {
      code = int,
      content = "com.eyu.mt.module.slot.model.LotteryVo"
    }
  }
}
types = {
  ["facade.SlotResult"] = const({
    PLEASE_LOAD_INFO_FIRST = -5,
    FREE_LOTTERY_TIMES_LIMIT = -4,
    COST_LOTTERY_TIMES_LIMIT = -3,
    ACTIVITY_IS_NOT_OPEN = -2,
    CROSS_DATE = -1
  }),
  ["model.LotteryVo"] = {
    appearPosition = int,
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    positionRewards = map(int, int),
    records = array("com.eyu.mt.module.slot.model.SlotRecordVo"),
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.SlotRecordVo"] = {
    id = long,
    name = string,
    rewardId = string,
    rewardResults = array("com.eyu.mt.module.slot.model.SlotRewardResult"),
    time = date
  },
  ["model.SlotRewardResult"] = {},
  ["model.SlotVo"] = {
    buyTimes = int,
    costtimes = int,
    freetimes = int,
    positionRewards = map(int, int),
    records = array("com.eyu.mt.module.slot.model.SlotRecordVo")
  }
}
NetMsg:Import(...)
