local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 23
cmd = {
  COMMOND_GET_ACHIEVE_LIST = {
    1,
    {},
    {
      code = int,
      content = array(int)
    }
  },
  COMMOND_DRAW_CHAPTER = {
    2,
    {id = int},
    {
      code = int,
      content = "com.eyu.mt.module.emblem.model.AchieveRewardVO"
    }
  },
  COMMOND_DRAW = {
    3,
    {chapterId = int, id = int},
    {
      code = int,
      content = "com.eyu.mt.module.emblem.model.AchieveRewardVO"
    }
  }
}
types = {
  ["facade.EmblemResult"] = const({
    SPACE_NOT_ENOUGH = -10,
    ACHIEVE_CANNOT_DRAW = -3,
    ACHIEVE_NOT_EXIST = -2,
    CHAPTER_NOT_EXIST = -1
  }),
  ["model.AchieveRewardVO"] = {
    rewardResult = array("com.eyu.mt.module.reward.model.RewardResult"),
    status = int
  }
}
NetMsg:Import(...)
