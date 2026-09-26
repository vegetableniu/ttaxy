local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 44
cmd = {
  SEND = {
    1,
    {phone = string},
    {code = int, content = int}
  },
  VERIFY = {
    2,
    {content = string},
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  }
}
types = {
  ["manager.ShortMessage"] = {
    code = string,
    hasPass = bool,
    id = long,
    phone = string,
    sendAt = date
  }
}
NetMsg:Import(...)
