local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 83
cmd = {
  LOAD_CHARGERETURN = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.chargereturn.model.ChargereturnVo"
    }
  },
  DRAW_REWARD = {
    2,
    {
      ids = array(string)
    },
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  }
}
types = {
  ["facade.ChargereturnResult"] = const({
    CHARGE_NOT_ENOUGH = -7,
    NEED_TO_BEEN_VIP = -6,
    NEED_TO_BEEN_WEEK = -5,
    HAD_BEEN_DRAWN = -4,
    PLEASE_SHOW_DATERETURN_ID = -3,
    DATE_RETURN_NOT_EXIST = -2,
    ACTIVITY_IS_NOT_OPEN = -1
  }),
  ["model.ChargereturnVo"] = {
    charge = int,
    day = string,
    drawRecord = array(string)
  }
}
NetMsg:Import(...)
