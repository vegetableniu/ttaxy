local _G = _G
module(...)
_G.objectlua = {}
local function delegated(t, prototype)
  if nil == _G.rawget(prototype, "__index") then
    _G.rawset(prototype, "__index", prototype)
    _G.rawset(prototype, "__metatable", "private")
  end
  return _G.setmetatable(t, prototype)
end
local function addSuper(superclass, symbol, method)
  local fenv = _G.fenv.getfenv(method)
  return _G.fenv.setfenv(method, _G.setmetatable({
    super = superclass.__prototype__
  }, {__index = fenv, __newindex = fenv}))
end
local function redirectAssignmentToPrototype(t, k, v)
  local superclass = t.superclass
  if nil ~= superclass and "function" == _G.type(v) then
    v = addSuper(superclass, k, v)
  end
  local prototype = t.__prototype__
  _G.assert(nil ~= prototype)
  _G.rawset(prototype, k, v)
end
local function basicNew(self, instance)
  _G.assert(nil ~= self.__prototype__)
  instance = instance or {}
  delegated(instance, self.__prototype__)
  _G.rawset(instance, "class", self)
  return instance
end
local function setSuperclass(self, class)
  _G.assert(nil ~= class.__prototype__)
  _G.rawset(self, "superclass", class)
  _G.rawset(self, "__prototype__", delegated({}, class.__prototype__))
end
local function setAsMetaclass(self)
  _G.rawset(self.__prototype__, "__newindex", redirectAssignmentToPrototype)
end
local objectPrototype = {}
local Class = {
  __prototype__ = delegated({}, objectPrototype)
}
Class.__prototype__.basicNew = basicNew
Class.__prototype__.setSuperclass = setSuperclass
Class.__prototype__.setAsMetaclass = setAsMetaclass
local ObjectMetaclass = basicNew(Class)
ObjectMetaclass:setSuperclass(Class)
local Object = ObjectMetaclass:basicNew({__prototype__ = objectPrototype})
_G.rawset(Class, "superclass", Object)
local ClassMetaclass = basicNew(Class)
ClassMetaclass:setSuperclass(ObjectMetaclass)
ClassMetaclass.__prototype__.__index = ClassMetaclass.__prototype__
_G.setmetatable(Class, ClassMetaclass.__prototype__)
_G.rawset(Class, "class", ClassMetaclass)
Class:setAsMetaclass()
ObjectMetaclass:setAsMetaclass()
ClassMetaclass:setAsMetaclass()
_G.objectlua.Object = Object
_G.objectlua["Object Metaclass"] = ObjectMetaclass
_G.objectlua.Class = Class
_G.objectlua["Class Metaclass"] = ClassMetaclass
