module((...), package.seeall)
require("GameStage")
require("Logic.Sdk")
class = GameStage.class:subclass()
function class:OnStageActive()
  Logic:Reset()
  Singleton(NetMgr):Disconnect()
  if nil ~= rawget(CEnvRoot, "GetKeychainItem") and nil ~= rawget(CEnvRoot, "SetKeychainItem") then
    self:GDTSubmit()
  end
  SceneHelper:replaceScene("GameLoading")
  if Logic:Get("System"):GetExeVer() < Logic.System.EXE_VERSION.INIT_SDK then
    Logic:Get("Sdk"):OnInit()
  end
  Logic:Get("Login"):SetLoadingStage(Logic.Login.LOAD_STAGE.AUTOPATCH)
end
function class:GDTSubmit()
  local firstActive = CEnvRoot:GetSingleton():GetKeychainItem("isFirstActive")
  if firstActive == "true" then
    return
  else
    CEnvRoot:GetSingleton():SetKeychainItem(json.encode({isFirstActive = "true"}))
  end
  local GDTUrl = Logic:Get("System"):GetOperatorItemFromFile("GDTUrl", "config.dat")
  if not Logic:Get("System"):IsOperator("appstore") or type(GDTUrl) ~= "table" or table.empty(GDTUrl) then
    return
  end
  local imei = ""
  local idfa = ""
  local muid
  local ptName = "android"
  local platform = CTwUtil:GetPlatform()
  if CTwUtil.E_TP_MAC == platform then
    ptName = "ios"
    idfa = Logic:Get("System"):GetIdfa()
    muid = CMd5(idfa:upper()):GetResult()
  elseif CTwUtil.E_TP_ANDROID == platform then
    ptName = "android"
    imei = Logic:Get("System"):GetUniqueId()
    muid = CMd5(imei:lower()):GetResult()
  end
  GDTUrl.act = string.format(GDTUrl.act, muid:lower(), GDTUrl.appid, ptName, imei, idfa)
  local httpReq = ITwHttp.Request()
  httpReq.strHost = GDTUrl.host
  httpReq.port = GDTUrl.port
  httpReq.strMethod = "GET"
  httpReq.strAction = GDTUrl.act
  Singleton(NetHttp):Send(httpReq, false)
end
function class:OnStageClose()
end
