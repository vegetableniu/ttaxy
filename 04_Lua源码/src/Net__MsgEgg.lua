local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 52
cmd = {
  LOAD_EGG_INFO = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.egg.model.EggVo"
    }
  },
  SMASH = {
    2,
    {smashId = int},
    {
      code = int,
      content = "com.eyu.mt.module.egg.model.SmashVo"
    }
  }
}
types = {
  ["facade.EggResult"] = const({
    ACTIVITY_IS_NOT_OPEN = -5,
    NOT_FOUNT_PLAYER_LEVEL_SECTION = -4,
    NO_ENOUGH_HAMMERS_TO_DEC = -3,
    CURRENCY_IS_NOT_ENOUGH = -2,
    TODAY_SMASH_TIMES_IS_MAX = -1
  }),
  ["model.EachSmashVo"] = {
    rewardId = string,
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult"),
    smashType = "com.eyu.mt.module.egg.model.SmashType"
  },
  ["model.EggRewardVo"] = {
    id = long,
    name = string,
    reward = string,
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult"),
    time = date,
    tmp = string
  },
  ["model.EggVo"] = {
    costSmashCount = int,
    eggRewardVos = array("com.eyu.mt.module.egg.model.EggRewardVo"),
    freeSmashCount = int,
    hammer = int,
    hammerSmashCount = int,
    todaySmash = int,
    topRewardVo = "com.eyu.mt.module.egg.model.TopRewardVo",
    totalCurrency = int
  },
  ["model.SmashType"] = enum({
    [0] = "HAMMER",
    [1] = "COST",
    [2] = "FREE"
  }),
  ["model.SmashVo"] = {
    costResult = array("com.eyu.mt.module.cost.model.CostResult"),
    costSmashCount = int,
    eachSmashVOs = map(int, "com.eyu.mt.module.egg.model.EachSmashVo"),
    eggRewardVos = array("com.eyu.mt.module.egg.model.EggRewardVo"),
    freeSmashCount = int,
    hammer = int,
    hammerSmashCount = int,
    todaySmash = int,
    topRewardVo = "com.eyu.mt.module.egg.model.TopRewardVo",
    totalCurrency = int
  },
  ["model.TopRewardVo"] = {
    id = long,
    name = string,
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult"),
    tmp = string
  }
}
NetMsg:Import(...)
