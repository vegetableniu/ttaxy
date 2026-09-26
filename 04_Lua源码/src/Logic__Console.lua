require("Logic")
module((...), package.seeall)
class = Logic.class:subclass()
EVT = Enum({"CMD", "UPDATE"})
function class:initialize()
  super.initialize(self)
  self.cmdSet = Events.EventSet:new()
  self:BindCmd()
  self:Clear()
end
function class:dispose()
  self.cmdSet:dispose()
  super.dispose(self)
end
function class:Clear()
  self.content = {}
end
function class:OnCmd(cmd, event)
  self.cmdSet:bind(event, string.lower(cmd))
end
function class:SendMsg(cmdInput)
  local cmd = string.trim(cmdInput)
  local cmds = string.split(cmd, " ")
  local args = {}
  if #cmds == 0 then
    return
  elseif #cmds > 1 then
    cmd = cmds[1]
    args = cmds
    table.remove(args, 1)
  end
  self:Append(">" .. cmdInput)
  cmd = string.lower(cmd)
  if not self.cmdSet:fire(cmd, unpack(args)) then
    local ret = string.format("Command \"%s\" is not valid.", cmd)
    self:Append(ret)
  end
  self:FireEvent(EVT.UPDATE)
end
function class:GetContent()
  return self.content
end
function class:Append(text)
  table.insert(self.content, text)
end
function class:BindCmd()
  self:OnCmd("cls", self:Event("CMD_CLS", function()
    self:Clear()
  end))
  self:OnCmd("ef", self:Event("CMD_EF", function()
    local bEnable = CTwUIRoot:GetSingleton():GetDebugShowViewInfo()
    CTwUIRoot:GetSingleton():SetDebugShowViewInfo(not bEnable)
  end))
  self:OnCmd("open", self:Event("CMD_OPEN_DLG", function(dlgName, ...)
    DlgTmpl:Close(dlgName)
    DlgTmpl:Open(dlgName, {
      ...
    })
  end))
  self:OnCmd("close", self:Event("CMD_CLOSE_DLG", function(dlgName)
    DlgTmpl:Close(dlgName)
  end))
  self:OnCmd("dumpTex", self:Event("CMD_DUMPTEX", function()
    CTwUIRender:GetSingleton():DumpCachedTextureInfo()
  end))
  self:OnCmd("GetMem", self:Event("CMD_GETMEM", function()
    CTwUtil:GetSingleton():PrintCurrentMem()
  end))
  self:OnCmd("out", self:Event("CMD_SET_LOGOUT", function(time)
    Logic:Get("EnvLogic"):Logout()
  end))
end
