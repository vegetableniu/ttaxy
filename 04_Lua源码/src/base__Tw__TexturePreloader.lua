module((...), package.seeall)
local instance
function getInstance(self)
  return instance
end
class = objectlua.Object:subclass()
class:include(Events.Tracer)
function class:initialize(...)
  super.initialize(self, ...)
  Events.Tracer.initialize(self)
  self.files = {}
  self.loaded = CCArray:create()
  self.loaded:retain()
  instance = self
end
function class:dispose()
  instance = nil
  self.loaded:release()
  self.loaded = nil
  self.files = {}
  Events.Tracer.dispose(self)
  super.dispose(self)
end
function class:preload()
  if 0 < self.loaded:count() then
    return
  end
  self.files = self:loadAsync(self:getFiles("ini/PreloadTextures.ini"))
  Singleton(Timer):After(5000 * #self.files, self:Event("TimerGuard", function()
    if not table.empty(self.files) then
      self.files = {}
    end
  end))
  Singleton(Timer):Repeat(100, self:Event("TimerUpdate", "update"))
end
function class:isReady()
  return table.empty(self.files)
end
function class:loadAsync(files)
  files = self:getTextures(files)
  local textureCache = CCTextureCache:sharedTextureCache()
  for i, v in ipairs(files) do
    textureCache:addImageAsync(v)
  end
  return files
end
function class:getTextures(files)
  local cocos2dxDelegate = CCocos2dxDelegate:GetSingleton()
  local singles = list.map(function(e)
    if cocos2dxDelegate:isFileExist(e) then
      return e
    end
  end, files)
  local sheets = table.values(list.foldl(function(r, e)
    local e = cocos2dxDelegate:getSpriteMap(e)
    if e ~= string.bl and r[e] == nil then
      r[e] = cocos2dxDelegate:getTexturePath(e)
    end
    return r
  end, {}, table.indices(set.new(files) - set.new(singles))))
  return list.concat(singles, sheets)
end
function class:getFiles(file)
  local files = CTwFilePack.Open(file)
  files = string.gsub(files, "\r\n", "\n")
  files = string.gsub(files, "\n\r", "\n")
  files = string.gsub(files, "\r", "\n")
  files = string.gsub(files, [[

+]], "\n")
  files = string.chomp(files)
  files = string.split(files, string.nl)
  return files
end
function class:update()
  while not table.empty(self.files) do
    local file = self.files[1]
    local texture = CCTextureCache:sharedTextureCache():textureForKey(file)
    if not texture then
      break
    end
    table.remove(self.files, 1)
    self.loaded:addObject(texture)
  end
  if table.empty(self.files) then
    self:EventTracer():Cancel("TimerUpdate")
  end
end
