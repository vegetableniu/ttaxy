module(...)
Singleton(NetMsg):Setup(...)
mod = 16
cmd = {
  ALL_GIFTS = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.gift.model.ValidGiftVo"
    }
  },
  DRAW_GLOBAL = {
    2,
    {giftId = string},
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  },
  DRAW_SERIAL = {
    3,
    {serial = string, signal = string},
    {
      code = int,
      content = "com.eyu.mt.module.gift.model.SerialResultVo"
    }
  },
  DRAW_USER = {
    4,
    {giftId = long},
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  },
  HAS_REWARD = {
    5,
    {},
    {code = int, content = bool}
  },
  SP_RECORD = {
    6,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.gift.manager.SpRecord"
    }
  },
  DRAW_SP_REGISTER = {
    7,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.gift.manager.SpRecord"
    }
  },
  DRAW_SP_COMMENT = {
    8,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.gift.manager.SpRecord"
    }
  },
  GET_ACTIVITYS = {
    9,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.activity.model.ValidActivityVo"
    }
  },
  DRAW_ACTIVITY = {
    10,
    {activity = string, giftId = string},
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  },
  PROGRESS_REWARDS = {
    11,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.gift.model.ProgressRewardVo"
    }
  },
  CLAIM_PROGRESS = {
    12,
    {category = string, threshold = int},
    {
      code = int,
      content = "com.eyu.mt.module.gift.model.ProgressClaimVo"
    }
  }
}
types = {
  ["facade.GiftResult"] = const({
    SERIAL_COMMUNICATION_ERROR = -19,
    OPERATION_REJECTED = -18,
    SERIAL_IS_LOCKER = -14,
    SERIAL_IS_DRAWED = -13,
    SERIAL_NOT_FOUND = -12,
    INVALID_GIFT = -11,
    GIFT_ALREADY_EXISTS = -10,
    INVALID_REWARD = -9,
    GIFT_HAS_BEEN_RECEIVED = -5,
    GIFT_CANNOT_DRAW = -4,
    GIFT_NOT_ATTACHMENT = -3,
    GIFT_NOT_NAME = -2,
    GIFT_NOT_FOUND = -1
  }),
  ["facade.SequenceConstant"] = const({
    INVALID_MD = -9999,
    SERIAL_LIMITED = -1001,
    ALREADY_LOCK = -11,
    INVALID_USER_NAME = -10,
    HAVE_NOT_LOCK_YET = -9,
    INVALID_SEQUENCE_STATUS = -8,
    BATCH_QUEUE_FULL = -7,
    ALREADY_TAKEN = -6,
    INVALID_OPCODE = -5,
    INVALID_SEQUENCE_ACTION = -4,
    INVALID_SEQUENCE_NO = -3,
    INVALID_COUNT = -2,
    INVALID_GIFT_NO = -1,
    SUCCESS = 0
  }),
  ["manager.GiftReward"] = {
    content = string,
    type = "com.eyu.mt.module.gift.model.GiftRewardType"
  },
  ["manager.GlobalDescription"] = {
    conditions = string,
    info = string,
    name = string,
    onlineTimes = int,
    onlineType = "com.eyu.mt.module.gift.model.OnlineType",
    prev = string,
    showId = string,
    showType = string,
    sort = int
  },
  ["manager.UserDescription"] = {
    info = string,
    name = string,
    showId = string,
    showType = string,
    sort = int
  },
  ["model.ClientState"] = {
    draws = array(string),
    shows = array(string)
  },
  ["model.GiftOperation"] = enum({
    [0] = "LOCK",
    [1] = "CONFIRM",
    [2] = "UNLOCK"
  }),
  ["model.GiftRewardType"] = enum({
    [0] = "CONFIG",
    [1] = "CONTENT"
  }),
  ["model.GlobalDrawVo"] = {
    logs = map(string, date),
    owner = long
  },
  ["model.GlobalGiftType"] = enum({
    [0] = "NORMAL",
    [1] = "ONLINE",
    [2] = "SERIAL",
    [3] = "ACTIVITY"
  }),
  ["model.GlobalGiftVo"] = {
    ["actitityId"] = string,
    ["canDraw"] = bool,
    ["canShow"] = bool,
    ["description"] = "com.eyu.mt.module.gift.manager.GlobalDescription",
    ["drawTime"] = date,
    ["endTime"] = date,
    ["id"] = string,
    ["leftDays"] = int,
    ["repeat"] = bool,
    ["reward"] = "com.eyu.mt.module.gift.manager.GiftReward",
    ["startTime"] = date,
    ["type"] = "com.eyu.mt.module.gift.model.GlobalGiftType"
  },
  ["model.OnlineType"] = enum({
    [0] = "CURRENT_SESSION",
    [1] = "INTERVAL",
    [2] = "INTERVAL_SESSION",
    [3] = "CURRENT_DAY",
    [4] = "TOTAL_DAYS"
  }),
  ["model.SerialResultVo"] = {
    check = bool,
    giftId = string,
    giftName = string,
    reward = array("com.eyu.mt.module.reward.model.RewardResult"),
    url = string
  },
  ["model.SpRecordVo"] = {comment = int, register = int},
  ["model.ProgressRewardTierVo"] = {
    amount = int,
    category = string,
    claimed = bool,
    code = int,
    reached = bool,
    rewardName = string,
    rewardType = string,
    threshold = int
  },
  ["model.ProgressRewardVo"] = {
    level = int,
    levelTiers = array("com.eyu.mt.module.gift.model.ProgressRewardTierVo"),
    loginDays = int,
    loginTiers = array("com.eyu.mt.module.gift.model.ProgressRewardTierVo"),
    powerTiers = array("com.eyu.mt.module.gift.model.ProgressRewardTierVo"),
    teamPower = int
  },
  ["model.ProgressClaimVo"] = {
    rewards = array("com.eyu.mt.module.reward.model.RewardResult"),
    state = "com.eyu.mt.module.gift.model.ProgressRewardVo"
  },
  ["model.UserGiftVo"] = {
    description = "com.eyu.mt.module.gift.manager.UserDescription",
    id = long,
    reward = "com.eyu.mt.module.gift.manager.GiftReward"
  },
  ["model.ValidGiftVo"] = {
    drawVo = "com.eyu.mt.module.gift.model.GlobalDrawVo",
    globals = array("com.eyu.mt.module.gift.model.GlobalGiftVo"),
    spRecord = "com.eyu.mt.module.gift.model.SpRecordVo",
    users = array("com.eyu.mt.module.gift.model.UserGiftVo")
  }
}
Singleton(NetMsg):Import(...)
