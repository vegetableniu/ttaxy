require("Events")
module((...), package.seeall)
prototype = objectlua.Object:extend()
prototype:include(Events.Tracer)
function prototype:initialize(...)
  super.initialize(self, ...)
  Events.Tracer.initialize(self)
end
function prototype:dispose(...)
  Events.Tracer.dispose(self)
  super.dispose(self)
end
function prototype:onEnter()
end
function prototype:onEnterTransitionDidFinish()
end
function prototype:onExitTransitionDidStart()
end
function prototype:onExit()
end
function prototype:cleanup()
  self:dispose()
  if self.animationMgr ~= nil then
    self.animationMgr:release()
    self.animationMgr = nil
  end
end
function prototype:onResolveCCBCCMenuItemSelector(slot, name)
  if self[name] == nil then
    return false
  end
  self.menuItemSelectors = self.menuItemSelectors or {}
  assert(#self.menuItemSelectors == slot)
  table.insert(self.menuItemSelectors, name)
  return true
end
function prototype:onResolveCCBCCControlSelector(slot, name)
  if self[name] == nil then
    return false
  end
  self.controlSelectors = self.controlSelectors or {}
  assert(#self.controlSelectors == slot)
  table.insert(self.controlSelectors, name)
  return true
end
function prototype:onAssignCCBMemberVariable(target, name, node)
  self[name] = node
  return true
end
function prototype:onMenuItem(slot, sender)
  Logic:Get("BGSound"):PlayEffect("audio/clicked.mp3")
  local name = self.menuItemSelectors[slot + 1]
  assert(name ~= nil)
  local func = self[name]
  assert(func ~= nil)
  func(self, sender)
end
function prototype:onControl(slot, sender, event)
  if event == CCControlEventTouchUpInside and tolua.type(sender) == "CCControlButton" then
    Logic:Get("BGSound"):PlayEffect("audio/clicked.mp3")
  end
  local name = self.controlSelectors[slot + 1]
  assert(name ~= nil)
  local func = self[name]
  assert(func ~= nil)
  func(self, sender, event)
end
function prototype:bindAnimationMgr()
  return false
end
function prototype:completedAnimationSequenceNamed(name)
end
local call = function(proxy, name, ...)
  if proxy[name] == nil then
    return nil
  end
  return proxy[name](proxy, ...)
end
local mt_weak = {__mode = "v"}
local function bindWeak(func, ...)
  local args = {
    ...
  }
  local argc = #args
  local refs = setmetatable({}, mt_weak)
  for i, v in ipairs(args) do
    refs[i] = v
  end
  return function(...)
    assert(#refs == argc)
    return func(unpack(refs), ...)
  end
end
local function loaderHook(ccb, layer, reader)
  if layer == nil then
    return
  end
  local prototype = require(ccb).prototype
  local proxy = prototype:new()
  if proxy:bindAnimationMgr() then
    assert(proxy.animationMgr == nil)
    proxy.animationMgr = reader:getAnimationManager()
    proxy.animationMgr:retain()
    local delegate = CCBAnimationManagerDelegateProxy()
    delegate:hook(bindWeak(call, proxy))
    proxy.animationMgr:setDelegate(delegate)
    proxy.__private__ = proxy.__private__ or {}
    proxy.__private__.animationManagerDelegate = delegate
  end
  proxy.rootNode = layer
  tolua.setpeer(layer, proxy)
  layer:hook(bind(call, proxy))
  layer:registerScriptHandler(bind(call, proxy))
end
local function libraryHook(library, ccb)
  local loader = CCBLayerLoaderProxy:loader()
  loader:hook(bind(loaderHook, ccb))
  library:registerCCNodeLoader(ccb, loader)
end
local function getReader()
  local library = CCNodeLoaderLibraryProxy:newDefaultCCNodeLoaderLibrary()
  library:hook(libraryHook)
  local reader = CCBReader:new(library)
  reader:autorelease()
  return reader
end
function load(self, ccb, owner)
  local file = string.format("ccb/%s.ccbi", ccb)
  return getReader():readNodeGraphFromFile(file, owner)
end
function loadAsScene(self, ccb, owner)
  local layer = self:load(ccb, owner)
  if layer == nil then
    return nil
  end
  local cover = self:load("Cover")
  local eglView = CCDirector:sharedDirector():getOpenGLView()
  local designSize = eglView:getDesignResolutionSize()
  local frameSize = eglView:getFrameSize()
  local scaleWidth = designSize.width / frameSize.width
  local scaleHeight = designSize.height / frameSize.height
  local scaleMax = math.max(scaleWidth, scaleHeight)
  local scaleMin = math.min(scaleWidth, scaleHeight)
  local rootLayer = CCLayer:create()
  rootLayer:setScale(scaleMin / scaleMax)
  rootLayer:addChild(layer, 0, 999)
  rootLayer:addChild(cover, Logic:Get("GameSetting"):GetLayerPriority("cover"))
  local scene = CCScene:create()
  scene:addChild(rootLayer, 0, 999)
  return scene
end
