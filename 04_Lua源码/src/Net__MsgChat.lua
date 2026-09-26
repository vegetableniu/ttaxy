local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 15
cmd = {
  GET_POSTS = {
    1,
    {time = date},
    {
      code = int,
      content = array("com.eyu.mt.module.chat.model.PostVo")
    }
  }
}
types = {
  ["facade.ChatResult"] = const({
    INVALID_VOICE_CHANNEL = -13,
    INVALID_CONTENT = -12,
    BLOCK_BY_LEVEL = -11,
    ITEM_NOT_FOUND = -10,
    BLOCK_BY_ADMIN = -9,
    FAILED_BY_AUTH = -8,
    INVALID_SHOWITEM = -7,
    CHARGE_FAIL = -6,
    TARGET_OFFLINE = -5,
    INVALID_TARGET = -4,
    INVALID_MESSAGE = -3,
    BLOCK_COOLDOWN_TIME = -2,
    INVALID_CHANNEL = -1
  }),
  ["model.PostVo"] = {
    channel = int,
    content = map(string, object),
    id = int
  }
}
NetMsg:Import(...)
