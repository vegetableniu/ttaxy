local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 48
cmd = {
  OPEN = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.task.model.OpenVo"
    }
  },
  FREE_REFRESH_ACTIVITY = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.task.model.RefreshActivityVo"
    }
  },
  REFRESH_ACTIVITY = {
    3,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.task.model.RefreshActivityVo"
    }
  },
  BUY_TASK = {
    4,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.task.model.BuyTaskVo"
    }
  },
  IMMEDIATELY_COMPLETE_TASK = {
    5,
    {taskId = int},
    {
      code = int,
      content = "com.eyu.mt.module.task.model.CompleteTaskVo"
    }
  },
  GET_REWARD = {
    6,
    {taskId = int},
    {
      code = int,
      content = "com.eyu.mt.module.task.model.GetRewardVo"
    }
  },
  ADVANCED_REFRESH_ACTIVITY = {
    7,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.task.model.RefreshActivityVo"
    }
  },
  PICK_UP_TASK = {
    8,
    {taskId = int},
    {
      code = int,
      content = "com.eyu.mt.module.task.model.PickUpTaskVo"
    }
  },
  GIVE_UP = {
    9,
    {taskId = int},
    {
      code = int,
      content = "com.eyu.mt.module.task.model.GiveUpVo"
    }
  },
  CLEAR_COOL_TIME = {
    10,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.cost.model.CostResult")
    }
  }
}
types = {
  ["facade.ChristmasResult"] = const({
    NOT_IN_COOL_TIME = -20,
    ACTIVITY_IS_NOT_OPEN = -19,
    IS_IN_COOL_TIME = -18,
    NO_ENOUGH_TASK_DATA_TO_REFRESH = -17,
    THE_TASK_HAS_NOT_BEEN_PICK_UP = -16,
    PICK_UP_COUNT_HAS_BEEN_MAX = -15,
    HAD_PICK_UP_TASK = -14,
    THE_TASH_HAD_BEEN_COMPLETE = -13,
    NO_ENOUGH_DATE_TO_DECREASE = -12,
    HAVE_REACH_COMPLETE_CONDITION = -11,
    COMPLETE_TIMES_IS_USE_UP = -10,
    NOT_REACH_COMPLETE_CONDITION = -9,
    THIS_TASK_IS_COMPLETE = -8,
    NO_RELATIVE_TASK = -7,
    BUY_COMPLETE_TIMES_IS_MAX = -6,
    CURRENCY_IS_NOT_ENOUGH = -5,
    FREE_REFRESH_TIMES_IS_USE_UP = -4,
    IS_GREATER_THAN_MAX_BUY_COMPLETE_TIME = -3,
    NO_ENOUGH_COMPLETE_COUNT = -2,
    NO_RELATIVE_TARGETTYPE_DATA_DECREASE = -1
  }),
  ["model.BuyTaskVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    todayBuyCompleteCount = int,
    totalCompleteCount = int
  },
  ["model.CompleteTaskVo"] = {
    completeTasks = array(int),
    costResults = array("com.eyu.mt.module.cost.model.CostResult")
  },
  ["model.GetRewardVo"] = {
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult"),
    targetValues = map(string, double),
    tasks = array(int)
  },
  ["model.GiveUpVo"] = {
    pickUpTasks = array(int),
    targetValues = map(string, double),
    tasks = array(int)
  },
  ["model.OpenVo"] = {
    completeCount = int,
    completeTasks = array(int),
    coolState = bool,
    coolTime = date,
    gottask = array(int),
    pickUpTasks = array(int),
    refreshCount = int,
    targetValues = map(string, double),
    tasks = array(int),
    todayBuyCompleteCount = int,
    totalCompleteCount = int
  },
  ["model.PickUpTaskVo"] = {
    pickUpTasks = array(int),
    totalCompleteCount = int
  },
  ["model.RefreshActivityVo"] = {
    coolState = bool,
    coolTime = date,
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    tasks = array(int)
  }
}
NetMsg:Import(...)
