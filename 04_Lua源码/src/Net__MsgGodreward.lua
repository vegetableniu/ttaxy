local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 73
cmd = {
  GET_INFO = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.godreward.model.GodRewardVo"
    }
  },
  REFRESH_TASK = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.godreward.model.RefreshTaskVo"
    }
  },
  BUY_REFRESH_TASK = {
    3,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.godreward.model.RefreshTaskVo"
    }
  },
  ACCEPT_TASK = {
    4,
    {int},
    {
      code = int,
      content = map(int, double)
    }
  },
  GIVE_UP_TASK = {
    5,
    {int},
    {
      code = int,
      content = "com.eyu.mt.module.godreward.model.GiveUpTaskVo"
    }
  },
  GET_TASK_REWARD = {
    6,
    {int},
    {
      code = int,
      content = "com.eyu.mt.module.godreward.model.GetTaskRewardVo"
    }
  },
  GET_FEAT_REWARD = {
    7,
    {int},
    {
      code = int,
      content = "com.eyu.mt.module.godreward.model.GetFeatRewardVo"
    }
  }
}
types = {
  ["facade.GodRewardResult"] = const({
    FEAT_HAS_GOT_REWARD = -13,
    FEAT_NOT_ENOUGH = -12,
    TASK_HAS_GOT_REWARDED = -11,
    TASK_NOT_COMPLETED = -10,
    TASK_NOT_ACCEPTED = -9,
    TASK_HAS_ACCEPTED = -8,
    TASK_ACCEPT_AMOUNT_LIMIT = -7,
    TASK_NOT_FOUND = -6,
    CURRENCY_IS_NOT_ENOUGH = -5,
    TASK_HAS_REWARD = -4,
    TASK_DATA_NOT_ENOGHT = -3,
    TASK_FREE_REFRESH_NO_ENOUGH = -2,
    ACTIVITY_NOT_OPEN = -1
  }),
  ["model.GetFeatRewardVo"] = {
    rewardFeats = array(int),
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.GetTaskRewardVo"] = {
    freeTimes = int,
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult"),
    tasks = array(int)
  },
  ["model.GiveUpTaskVo"] = {
    freeTimes = int,
    progress = map(int, double),
    tasks = array(int)
  },
  ["model.GodRewardVo"] = {
    buyTimes = int,
    feats = int,
    freeTimes = int,
    progress = map(int, double),
    rewardFeats = array(int),
    rewardTasks = array(int),
    tasks = array(int)
  },
  ["model.RefreshTaskVo"] = {
    buyTimes = int,
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    freeTimes = int,
    tasks = array(int)
  }
}
NetMsg:Import(...)
