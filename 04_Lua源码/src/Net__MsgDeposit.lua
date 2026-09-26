local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 31
cmd = {
  GET_DEPOSIT_INFO = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.deposit.model.DepositVO"
    }
  },
  DEPOSIT = {
    2,
    {id = int},
    {
      code = int,
      content = "com.eyu.mt.module.deposit.model.DepositResultVO"
    }
  },
  WITHDRAW = {
    3,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.deposit.model.WithdrawVO"
    }
  }
}
types = {
  ["facade.DepositResult"] = const({
    ACTIVE_DRAW_NOT_OPEN = -10,
    ACTIVE_START_NOT_OPEN = -9,
    WITHDRAW_TIME_LIMIT = -8,
    DEPOSIT_AMOUNT_NOT_ENOUGH = -7,
    ACTIVE_CONSUME_LIMIT = -6,
    ACTIVE_CHARGE_LIMIT = -5,
    HAS_DEPOSITED = -4,
    DEPOSIT_TIME_END = -3,
    ACTIVE_NOT_OPEN = -2,
    ARGUMENT_ILLEGA = -1
  }),
  ["model.DepositResultVO"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    depositVO = "com.eyu.mt.module.deposit.model.DepositVO"
  },
  ["model.DepositVO"] = {
    activeCharge = int,
    activeConsume = int,
    amount = int,
    depositDay = int,
    depositEndSeconds = int
  },
  ["model.WithdrawVO"] = {
    baseMoney = int,
    depositVO = "com.eyu.mt.module.deposit.model.DepositVO",
    income = int,
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  }
}
NetMsg:Import(...)
