local L0_0
L0_0 = require
L0_0("MsgAccount")
L0_0 = require
L0_0("MsgActivity")
L0_0 = require
L0_0("MsgActivitycharge")
L0_0 = require
L0_0("MsgArena")
L0_0 = require
L0_0("MsgArtifact")
L0_0 = require
L0_0("MsgBattle")
L0_0 = require
L0_0("MsgBlessing")
L0_0 = require
L0_0("MsgBox")
L0_0 = require
L0_0("MsgChargerank")
L0_0 = require
L0_0("MsgChargereturn")
L0_0 = require
L0_0("MsgChat")
L0_0 = require
L0_0("MsgCheapbuy")
L0_0 = require
L0_0("MsgCom")
L0_0 = require
L0_0("MsgCommon")
L0_0 = require
L0_0("MsgConsumerank")
L0_0 = require
L0_0("MsgCost")
L0_0 = require
L0_0("MsgCultivate")
L0_0 = require
L0_0("MsgCultivateshop")
L0_0 = require
L0_0("MsgCurrency")
L0_0 = require
L0_0("MsgDemog")
L0_0 = require
L0_0("MsgDeposit")
L0_0 = require
L0_0("MsgDumpling")
L0_0 = require
L0_0("MsgEgg")
L0_0 = require
L0_0("MsgElite")
L0_0 = require
L0_0("MsgEmail")
L0_0 = require
L0_0("MsgEmblem")
L0_0 = require
L0_0("MsgEquip")
L0_0 = require
L0_0("MsgEquipgift")
L0_0 = require
L0_0("MsgExchange")
L0_0 = require
L0_0("MsgExchangeshop")
L0_0 = require
L0_0("MsgExplore")
L0_0 = require
L0_0("MsgFakegroupbuy")
L0_0 = require
L0_0("MsgFight")
L0_0 = require
L0_0("MsgFoolsday")
L0_0 = require
L0_0("MsgFootball")
L0_0 = require
L0_0("MsgGemroom")
L0_0 = require
L0_0("MsgGift")
L0_0 = require
L0_0("MsgGodreward")
L0_0 = require
L0_0("MsgGroupbuy")
L0_0 = require
L0_0("MsgHero")
L0_0 = require
L0_0("MsgInvite")
L0_0 = require
L0_0("MsgItem")
L0_0 = require
L0_0("MsgJuhuasuan")
L0_0 = require
L0_0("MsgKingsoft")
L0_0 = require
L0_0("MsgMenpai")
L0_0 = require
L0_0("MsgMonopoly")
L0_0 = require
L0_0("MsgMoon")
L0_0 = require
L0_0("MsgNewmonopoly")
L0_0 = require
L0_0("MsgPlatform")
L0_0 = require
L0_0("MsgPlayer")
L0_0 = require
L0_0("MsgPoint")
L0_0 = require
L0_0("MsgPreciousroom")
L0_0 = require
L0_0("MsgPvp")
L0_0 = require
L0_0("MsgQingming")
L0_0 = require
L0_0("MsgRaffle")
L0_0 = require
L0_0("MsgRebirth")
L0_0 = require
L0_0("MsgRecycle")
L0_0 = require
L0_0("MsgReward")
L0_0 = require
L0_0("MsgSecretshop")
L0_0 = require
L0_0("MsgSlot")
L0_0 = require
L0_0("MsgSms")
L0_0 = require
L0_0("MsgSociality")
L0_0 = require
L0_0("MsgSupergift")
L0_0 = require
L0_0("MsgSweethouse")
L0_0 = require
L0_0("MsgSystem")
L0_0 = require
L0_0("MsgTalisman")
L0_0 = require
L0_0("MsgTarget")
L0_0 = require
L0_0("MsgTask")
L0_0 = require
L0_0("MsgTencent")
L0_0 = require
L0_0("MsgTips")
L0_0 = require
L0_0("MsgTreasure")
L0_0 = require
L0_0("MsgTreasureroom")
L0_0 = require
L0_0("MsgTurkey")
L0_0 = require
L0_0("MsgVip")
L0_0 = require
L0_0("MsgWorldchat")
function L0_0(...)
  module(...)
  Singleton(NetMsg):Setup(...)
  mod = 89
  cmd = {
    MOON_INFO = {
      1,
      {},
      {
        code = int,
        content = "com.eyu.mt.module.moon.model.MoonVo"
      }
    },
    COMPOSE_MOON = {
      2,
      {count = int},
      {
        code = int,
        content = "com.eyu.mt.module.moon.model.MoonComposeVo"
      }
    },
    BUY_MOON = {
      3,
      {count = int, type = int},
      {
        code = int,
        content = "com.eyu.mt.module.moon.model.BuyMoonResultVo"
      }
    },
    EXHCNAGE = {
      4,
      {group = int},
      {
        code = int,
        content = "com.eyu.mt.module.moon.model.MoonExchangeVo"
      }
    }
  }
  types = {}
  Singleton(NetMsg):Import(...)
end
L0_0("MsgSpring")
