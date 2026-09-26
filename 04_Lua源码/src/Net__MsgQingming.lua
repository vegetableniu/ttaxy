module(...)
Singleton(NetMsg):Setup(...)
mod = 62
cmd = {
  GET_INFO = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.qingming.model.UserQingmingVo"
    }
  },
  JIBAI = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.qingming.model.JiBaiVo"
    }
  },
  GET_JIBAI_PAGE = {
    3,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.qingming.model.JiBaiPageVo"
    }
  }
}
types = {
  ["facade.QingmingResult"] = const({
    CURRENCY_NOT_ENOUGH = -3,
    JIPING_NOT_ENOUGH = -2,
    ACTIVITY_CLOSED = -1
  }),
  ["model.JiBaiPageVo"] = {
    jibaiCount = int,
    jiping = int,
    pondId = int,
    score = int
  },
  ["model.JiBaiVo"] = {
    pageVo = "com.eyu.mt.module.qingming.model.JiBaiPageVo",
    rewards = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.OtherQingmingInfo"] = {
    id = long,
    leaderBaseId = int,
    name = string,
    playerLevel = int,
    rank = int,
    score = long
  },
  ["model.UserQingmingVo"] = {
    closeTime = date,
    nearList = array("com.eyu.mt.module.qingming.model.OtherQingmingInfo"),
    rank = int,
    score = int,
    topList = array("com.eyu.mt.module.qingming.model.OtherQingmingInfo"),
    topName = string,
    topScore = long
  }
}
Singleton(NetMsg):Import(...)
