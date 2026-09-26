module(...)
Singleton(NetMsg):Setup(...)
mod = 92
cmd = {
  GET_LIST = {
    1,
    {afterId = int},
    {
      code = int,
      content = array("com.eyu.mt.module.worldchat.model.WorldChatMessageVo")
    }
  },
  SEND = {
    2,
    {content = string},
    {
      code = int,
      content = "com.eyu.mt.module.worldchat.model.WorldChatMessageVo"
    }
  }
}
types = {
  ["facade.WorldChatResult"] = const({
    INVALID_CONTENT = -12,
    BLOCK_BY_LEVEL = -11,
    FAILED_BY_AUTH = -8,
    INVALID_MESSAGE = -3,
    BLOCK_COOLDOWN_TIME = -2
  }),
  ["model.WorldChatMessageVo"] = {
    id = long,
    playerId = long,
    name = string,
    baseId = int,
    level = int,
    skill = int,
    message = string,
    date = date
  }
}
Singleton(NetMsg):Import(...)
