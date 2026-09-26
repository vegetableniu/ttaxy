local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
types = {
  ["model.VipInfo"] = {
    lastChargeDate = date,
    monsth = bool,
    monsthTime = date,
    vip = bool,
    vipTime = date,
    week = bool,
    weekTime = date
  }
}
NetMsg:Import(...)
