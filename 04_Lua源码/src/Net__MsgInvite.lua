local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 25
cmd = {
  CHAECK_INVITE_CODE = {
    1,
    {invite = string},
    {code = int, content = bool}
  },
  REWARD_LIST = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.invite.model.InviteVO"
    }
  },
  ADD_INVITE_CODE = {
    3,
    {invite = string},
    {code = int, content = int}
  }
}
types = {
  ["facade.InviteResult"] = const({
    INVALID_INVITE_CODE = -3,
    IVITE_CODE_ADDED = -2,
    INVITE_CODE_SELF = -1
  }),
  ["model.InviteVO"] = {
    inviteCode = string,
    inviteNum = int,
    isAddCode = bool,
    rewardList = array(int)
  }
}
NetMsg:Import(...)
