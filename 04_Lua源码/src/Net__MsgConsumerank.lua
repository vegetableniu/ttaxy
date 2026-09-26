local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 55
cmd = {
  GET_INFO = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.consumerank.model.UserConsumeVo"
    }
  },
  DRAW_SCORE_REWARD = {
    2,
    {int},
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  }
}
types = {
  ["facade.ConsumeRankResult"] = const({
    REWARD_ALREADY_DRAWED = -3,
    SCORE_NOT_ENOUGH = -2,
    ACTIVITY_CLOSED = -1
  }),
  ["model.OtherConsumeInfo"] = {
    id = long,
    leaderBaseId = int,
    name = string,
    playerLevel = int,
    rank = int,
    score = long
  },
  ["model.UserConsumeVo"] = {
    closeTime = date,
    drawedIds = array(int),
    nearList = array("com.eyu.mt.module.consumerank.model.OtherConsumeInfo"),
    rank = int,
    score = int,
    topList = array("com.eyu.mt.module.consumerank.model.OtherConsumeInfo"),
    topName = string,
    topScore = long
  }
}
NetMsg:Import(...)
