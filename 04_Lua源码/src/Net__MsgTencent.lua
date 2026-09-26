local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 68
cmd = {
  UPLOAD_API_ARGS = {
    1,
    {
      args = map(string, string)
    },
    {code = int, content = int}
  },
  QUERY_BALANCE = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.account.model.WalletVo"
    }
  }
}
types = {
  ["facade.TencentResult"] = const({ARGUMENT_ILLEGA = -1})
}
NetMsg:Import(...)
