local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 17
cmd = {
  GET_MAILBOX = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.email.model.MailBoxVo"
    }
  },
  SEND_USERMAIL = {
    2,
    {
      content = string,
      target = string,
      title = string
    },
    {code = int, content = bool}
  },
  SEND_GROUPMAIL = {
    3,
    {},
    {}
  },
  DRAW_USER = {
    4,
    {
      mailId = int,
      target = "com.eyu.mt.module.email.model.GroupTarget"
    },
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  },
  DRAW_SYSTEM = {
    5,
    {},
    {}
  },
  READ_MAIL = {
    6,
    {
      mailId = int,
      target = "com.eyu.mt.module.email.model.GroupTarget"
    },
    {code = int, content = bool}
  },
  REMOVE_MAIL = {
    7,
    {
      targets = map(int, "com.eyu.mt.module.email.model.GroupTarget")
    },
    {code = int, content = bool}
  },
  HAS_NEW = {
    8,
    {},
    {code = int, content = bool}
  },
  REMOVE_ALL_MAIL = {
    9,
    {
      targets = map(int, "com.eyu.mt.module.email.model.GroupTarget")
    },
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  }
}
types = {
  ["facade.EmailResult"] = const({
    SPACE_NOT_ENOUGH = -22,
    SEND_AUTHZ_LACK = -21,
    EMAIL_REMOVED = -20,
    EMAIL_REMOVE = -19,
    CURRENCY_NOT_ENOUGH = -18,
    ALLOW_BUY_ATTACHMENT = -17,
    EMAIL_STATE_ERROR = -16,
    EMAIL_NOT_FOUND = -15,
    EMAIL_DELETED = -14,
    INVALID_TARGET = -13,
    ATTACHMENT_DRAW = -12,
    SENDED_BACK = -11,
    SENDBACK_NOT_FOUND = -10,
    PLAYER_NOT_FOUND = -9,
    INVALID_ATTACHMENT = -8,
    OUT_OF_LIMIT = -7,
    INVALID_CHARGE = -6,
    INVALID_CONTENT = -5,
    INVALID_TITLE = -4,
    CANNOT_SENT_OWN = -3,
    RECEIVER_NOT_FOUND = -2,
    SENDER_NOT_FOUND = -1
  }),
  ["model.Attachment"] = {
    charge = int,
    chargeTypes = array("com.eyu.mt.module.currency.model.CurrencyType"),
    rewards = array("com.eyu.mt.module.email.model.AttachmentReward")
  },
  ["model.AttachmentReward"] = {},
  ["model.GroupTarget"] = {
    id = string,
    type = "com.eyu.mt.module.email.model.TargetType"
  },
  ["model.MailBoxVo"] = {
    lastSentTime = date,
    receives = array("com.eyu.mt.module.email.model.MailVo"),
    sends = array("com.eyu.mt.module.email.model.MailVo"),
    sentSize = int
  },
  ["model.MailState"] = const({
    READED = 1,
    RECEIVER_DELETED = 2,
    SENDER_DELETED = 4,
    RECEIVER_DREW = 8,
    SENDER_DREW = 16
  }),
  ["model.MailType"] = enum({
    [0] = "SENDED",
    [1] = "RECEIVED",
    [2] = "SAVED"
  }),
  ["model.MailVo"] = {
    attachment = "com.eyu.mt.module.email.model.Attachment",
    baseId = int,
    content = string,
    createTime = date,
    destoryTime = date,
    drawed = bool,
    groupTarget = "com.eyu.mt.module.email.model.GroupTarget",
    id = int,
    mailState = int,
    mailType = "com.eyu.mt.module.email.model.MailType",
    readed = bool,
    receiver = string,
    sender = string,
    senderId = long,
    system = bool,
    template = int,
    title = string
  },
  ["model.TargetType"] = enum({
    [0] = "USER",
    [1] = "ALL"
  })
}
NetMsg:Import(...)
