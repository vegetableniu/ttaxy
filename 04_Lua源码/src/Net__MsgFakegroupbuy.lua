local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 51
cmd = {
  PLAYER_BUY_INFO = {
    1,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.fakegroupbuy.module.GoodsBuyInfoVo")
    }
  },
  BUY_GOODS = {
    2,
    {id = int},
    {
      code = int,
      content = "com.eyu.mt.module.fakegroupbuy.module.BuyGoodsVo"
    }
  },
  DRAW_REWARD = {
    3,
    {
      id = int,
      types = array(int)
    },
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  }
}
types = {
  ["facade.GroupActivityResult"] = const({
    PARAM_ERROR = -8,
    REWARD_SEG_DRAWED = -7,
    REWARD_SEG_NOT_FOUND = -6,
    GOODS_NOT_BUY = -5,
    GOODS_HAS_BUY = -4,
    GOODS_NOT_VALID = -3,
    GOODS_NOT_FOUND = -2,
    ACTIVITY_NOT_INPROCESS = -1
  }),
  ["module.BuyGoodsVo"] = {
    costs = array("com.eyu.mt.module.cost.model.CostResult"),
    id = int,
    rewards = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["module.GoodsBuyInfoVo"] = {
    drawed = array(int),
    id = int
  }
}
NetMsg:Import(...)
