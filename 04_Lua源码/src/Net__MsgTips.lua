local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 40
cmd = {
  PUSH_TIPS = {
    -1,
    {},
    {}
  },
  GET_OFFLINE = {
    1,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.tips.model.Tips")
    }
  }
}
types = {
  ["facade.TipsResult"] = const({
    REWARD_NOT_FOUND = -11,
    LAST_NOT_FOUND = -10,
    BLOCK_BY_COOLTIME = -9,
    OPPONENT_NOT_FOUND = -8,
    GROUP_NOT_EXIST = -7,
    GROUP_IS_EXIST = -6,
    MEMBER_NOT_ENOUGH = -5,
    TEAM_NOT_FOUND = -4,
    BLOCK_BY_LEVEL = -3,
    INVALID_OPERATE = -2,
    ARGUMENT_ILLEGAL = -1
  }),
  ["model.Tips"] = {
    content = map(string, object),
    created = date,
    id = int
  }
}
NetMsg:Import(...)
