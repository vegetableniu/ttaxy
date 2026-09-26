local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 0
cmd = {
  PUSH_SYSTEM_TIME = {
    -1,
    {},
    {}
  },
  REQUEST_DESCRIPTION = {
    1,
    {},
    {code = int, content = bytearray}
  },
  SYSTEM_TIME = {
    2,
    {},
    {code = int, content = date}
  },
  MD5_DESCRIPTION = {
    3,
    {},
    {code = int, content = string}
  }
}
types = {}
NetMsg:Import(...)
