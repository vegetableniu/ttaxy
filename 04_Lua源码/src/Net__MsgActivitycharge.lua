local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 90
cmd = {
  LOAD_INFO = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.activitycharge.model.ActivitychargeVo"
    }
  },
  DRAW = {
    2,
    {id = int},
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  }
}
types = {
  ["facade.ActivitychargeResult"] = const({
    ALREADY_DRAW = -4,
    CHARGE_REWARD_NOT_EXIST = -3,
    CHARGE_NOT_ENOUGH = -2,
    ACTIVITY_IS_NOT_OPEN = -1
  }),
  ["model.ActivitychargeVo"] = {
    charge = int,
    draw = array(int)
  }
}
NetMsg:Import(...)
