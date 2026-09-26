local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 75
cmd = {
  LOAD_MONOPOLY = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.monopoly.model.MonopolyVo"
    }
  },
  DICE = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.monopoly.model.DiceVo"
    }
  },
  ADVANCE_DICE = {
    3,
    {step = int},
    {
      code = int,
      content = "com.eyu.mt.module.monopoly.model.DiceVo"
    }
  },
  DRAW_TASK_REWARD = {
    4,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  },
  GIVEUP_TASK = {
    5,
    {},
    {code = int, content = bool}
  },
  BUY_GOODS = {
    6,
    {id = int, useCurrency = bool},
    {
      code = int,
      content = "com.eyu.mt.module.monopoly.model.BuyGoodsResult"
    }
  },
  DRAW_BOX_REWARD = {
    7,
    {id = int},
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  },
  COST_DICE = {
    8,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.monopoly.model.DiceVo"
    }
  },
  COST_ADVANCE_DICE = {
    9,
    {step = int},
    {
      code = int,
      content = "com.eyu.mt.module.monopoly.model.DiceVo"
    }
  },
  PICKUP_TASK = {
    10,
    {id = int},
    {code = int, content = bool}
  },
  COMPLET_TASK = {
    11,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.cost.model.CostResult")
    }
  }
}
types = {
  ["facade.MonopolyResult"] = const({
    ACROSS_DATE = -22,
    CAN_DRAW_TASK_RRWARD = -21,
    TASK_ALREADY_COMPLET = -20,
    TASK_PROGRESS_IS_NOT_ENOUGH = -19,
    HAD_DREW_TASK_REWARD = -18,
    CAN_DRAW_BOX = -17,
    HAD_DREW_BOX = -16,
    RING_BOX_IS_NOT_EXISIT = -15,
    TASK_PROGRESS_IS_ENOUGH = -14,
    TOKEN_NOT_ENOUGH = -13,
    IS_BOUGHT = -12,
    GOODS_NOT_EXISIT = -11,
    TASK_NOT_EXISIT = -10,
    HAD_PICK_UP_TASK = -9,
    HAD_NOT_PICK_UP_TASK = -8,
    MUST_GIVE_UP_TASK = -7,
    ADVANCE_DICE_STEP_NOT_AVAILABLE = -6,
    DICE_IS_NOT_ENOUGH = -5,
    SPECIAL_DICE_IS_NOT_ENOUGH = -4,
    CURRENCY_IS_NOT_ENOUGH = -3,
    ADVANCE_DICE_STEP_MUST_GREATER_ZERO = -2,
    ACTIVITY_IS_NOT_OPEN = -1
  }),
  ["model.BuyGoodsResult"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    currency = int,
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.DiceVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    monopolyVo = "com.eyu.mt.module.monopoly.model.MonopolyVo",
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.MonopolyRewardRecord"] = {
    content = string,
    name = string,
    rewardResults = array("com.eyu.mt.module.monopoly.model.MonopolyRewardResult")
  },
  ["model.MonopolyRewardResult"] = {},
  ["model.MonopolyVo"] = {
    boughts = array(int),
    completTask = bool,
    currDiceTimes = int,
    currSpecialDiceTimes = int,
    currency = int,
    dice = int,
    drewBox = array(int),
    drewTaskReward = bool,
    goldBoxPosition = int,
    gonePositions = array(int),
    position = int,
    records = array("com.eyu.mt.module.monopoly.model.MonopolyRewardRecord"),
    rings = int,
    shop = array(int),
    specialDice = int,
    task = int,
    taskProgress = long,
    tasks = array(int)
  },
  ["model.PositionType"] = enum({
    [0] = "TASK",
    [1] = "SILVER_BOX",
    [2] = "SHOP",
    [3] = "DICE",
    [4] = "SPECIAL_DICE"
  })
}
NetMsg:Import(...)
