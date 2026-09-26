local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 30
cmd = {
  DRAW_PRAISE_REWARD = {
    1,
    {},
    {code = int, content = int}
  },
  INITIATIVE_SHARE = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.platform.model.InitiativeShareVo"
    }
  },
  PASSIVE_SHARE = {
    3,
    {},
    {code = int, content = int}
  },
  GET_COMMON_INFO = {
    4,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.platform.model.WechatRouletteInfo"
    }
  },
  ROULETTE = {
    5,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.platform.model.WechatRouletteVO"
    }
  }
}
types = {
  ["facade.PlatformResult"] = const({
    ROULETTE_TIME_LIMIT = -7,
    ROULETTE_TIMES_LIMIT = -6,
    SHARE_TIME_LIMIT = -5,
    OPRATOR_LIMIT = -4,
    PASSIVE_SHARE_LIMIT = -3,
    INITIATIVE_SHARE_LIMIT = -2,
    TODAY_HAS_DRAW = -1
  }),
  ["model.InitiativeShareVo"] = {
    lotteryTimes = int,
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.PlatformInfo"] = {
    firstShare = bool,
    initiativeCount = int,
    passiveCount = int
  },
  ["model.WechatRouletteInfo"] = {
    common = array("com.eyu.mt.module.platform.model.WechatRouletteRecord"),
    fcode = array("com.eyu.mt.module.platform.model.WechatRouletteRecord"),
    lotteryTimes = int
  },
  ["model.WechatRouletteRecord"] = {configId = int, userName = string},
  ["model.WechatRouletteVO"] = {
    id = int,
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  }
}
NetMsg:Import(...)
