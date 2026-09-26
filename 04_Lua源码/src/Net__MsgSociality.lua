local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 19
cmd = {
  GET_SOCIALITY = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.sociality.model.SocialityVo"
    }
  },
  APPLY_FRIEND = {
    2,
    {name = string},
    {code = int, content = int}
  },
  REMOVE_FRIEND = {
    3,
    {friendId = long},
    {code = int, content = int}
  },
  APPLY_CONFIRM = {
    4,
    {allow = bool, friendId = long},
    {
      code = int,
      content = array("com.eyu.mt.module.sociality.model.FriendVo")
    }
  },
  COMMEND_FRIEND = {
    5,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.sociality.model.CommendVo")
    }
  },
  BUY_PACK = {
    6,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.hero.model.BuyPackVo"
    }
  },
  SEND_POINT = {
    7,
    {friendId = long},
    {code = int, content = int}
  },
  RECV_POINT = {
    8,
    {friendId = long},
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  },
  LIST_APPLYS = {
    9,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.sociality.model.FriendVo")
    }
  },
  LIST_GIFTS = {
    10,
    {},
    {
      code = int,
      content = array(long)
    }
  },
  ASK_FOR_POINT = {
    11,
    {},
    {code = int, content = long}
  },
  COMAND_ASK_FOR_LIST = {
    12,
    {},
    {
      code = int,
      content = array(long)
    }
  }
}
types = {
  ["facade.SocialityResult"] = const({
    ASKFOR_LIMIT = -29,
    BUY_LIMIT = -28,
    TODAY_SENDED = -27,
    GIFT_NOT_EXIST = -26,
    TODAY_SEND_LIMIT = -25,
    TODAY_RECV_LIMIT = -24,
    OTHER_LIMIT = -23,
    ADD_IS_REPEAT = -22,
    ADD_IS_MORE = -21,
    BLOCK_BY_LEVEL = -20,
    ITEM_AMOUNT_LACK = -19,
    ITEM_NOT_FOUND = -18,
    SYSTEM_GROUP_REMOVE = -17,
    GROUP_NAME_EXIST = -16,
    GROUP_NOT_FOUND = -15,
    BLACKLIST_LIMIT = -14,
    FRIEND_ONLINE = -13,
    MESSAGE_DATE = -12,
    MESSAGE_LIMIT = -11,
    FRIEND_BLACKLIST = -10,
    FRIEND_BYBLACKLIST = -9,
    GROUPNAME_ACHIEVE_LIMIT = -8,
    GROUP_ACHIEVE_LIMIT = -7,
    FRIEND_NOT_EXIST = -6,
    FRIEND_STATE_ERROR = -5,
    FRIEND_APPLY_ERROR = -4,
    FRIEND_LIMIT = -3,
    FRIEND_EXIST = -2,
    PLAYER_NOT_FOUND = -1
  }),
  ["model.CommendVo"] = {
    artifactLevel = int,
    baseId = int,
    cultivateVo = "com.eyu.mt.module.cultivate.model.HeroCultivateVo",
    equips = array("com.eyu.mt.module.equip.model.EquipVo"),
    friend = bool,
    heroLevel = int,
    id = long,
    level = int,
    name = string,
    powerSkill = int,
    pvpDesId = int,
    talisman = array("com.eyu.mt.module.talisman.model.TalismanVo"),
    used = bool,
    userBuffs = array(string)
  },
  ["model.FriendVo"] = {
    artifactLevel = int,
    baseId = int,
    cultivateVo = "com.eyu.mt.module.cultivate.model.HeroCultivateVo",
    equips = array("com.eyu.mt.module.equip.model.EquipVo"),
    heroLevel = int,
    id = long,
    level = int,
    loginOn = date,
    name = string,
    online = bool,
    powerSkill = int,
    pvpDesId = int,
    score = int,
    talisman = array("com.eyu.mt.module.talisman.model.TalismanVo"),
    userBuffs = array(string),
    vip = bool
  },
  ["model.SocialityVo"] = {
    applys = array("com.eyu.mt.module.sociality.model.FriendVo"),
    extendCount = int,
    extendLimit = int,
    friends = array("com.eyu.mt.module.sociality.model.FriendVo"),
    gifts = array(long),
    recvs = array(long),
    sends = array(long)
  }
}
NetMsg:Import(...)
