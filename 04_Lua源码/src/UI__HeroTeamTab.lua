module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onEnter()
  super.onEnter(self)
  self.childNodes = {}
  local group = Logic:Get("Hero"):GetCurrentGroup()
  local groupIndex = Logic:Get("Hero"):GetGroupIndex()
  local scrollView = CCNode:create()
  scrollView:setContentSize(CCSizeMake(590, 540))
  scrollView:setPositionY(187)
  scrollView:setPositionX(26)
  local scroll = CCScrollViewEx:create(CCSizeMake(590, 540))
  scroll:setDirection(kCCScrollViewDirectionVertical)
  scroll:setClippingToBounds(true)
  scroll:setPositionY(0)
  scroll:setPositionX(0)
  local container = CCSprite:create()
  local tag = 100
  local posY = 0
  for i = 1, 2 do
    local layer = Tw.Controller:load("HeroTeamTabItem", self.rootNode)
    table.insert(self.childNodes, 1, layer)
    local sz = layer:getContentSize()
    layer:setPosition(CCPointMake(0, posY))
    layer:setAnchorPoint(CCPointMake(0, 0))
    layer:Clear()
    layer:RefreshHeros(group.groups[3 - i + 1], 3 - i + 1)
    container:addChild(layer, 0, tag)
    tag = tag - 1
    posY = posY + sz.height + 20
  end
  local layer = Tw.Controller:load("HeroTeamTabItemCur", self.rootNode)
  table.insert(self.childNodes, 1, layer)
  local sz = layer:getContentSize()
  layer:setPosition(CCPointMake(0, posY - 20))
  layer:Clear()
  if group and group.groups and group.curGroupId and group.groups[group.curGroupId] then
    layer:CurrentGroup(group.groups[group.curGroupId])
  end
  posY = posY + sz.height
  layer:setAnchorPoint(CCPointMake(0, 0))
  container:addChild(layer, 0, tag)
  local conHeight = posY - 20
  local conWidth = 578
  container:setContentSize(CCSizeMake(sz.width, conHeight))
  scroll:setContainer(container)
  scroll:updateInset()
  scroll:setContentOffset(CCPointMake(0, -(posY - 560)), false)
  scrollView:addChild(scroll)
  self.rootNode:addChild(scrollView)
  local bar = CCScale9Sprite:create("images/public/imgSlider.png")
  local barBg = CCScale9Sprite:create("images/public/imgSliderBg.png")
  scroll:setScrollBar(bar, barBg)
  Logic:Get("Hero"):On(Logic.Hero.EVT.SWITCH_HERO_GROUP, self:Event("OnSwitchGroup"))
  Logic:Get("Devil"):On(Logic.Devil.EVT.REFRESH_GROUP_DATA, self:Event("onRefreshGroupData"))
end
function prototype:OnSwitchGroup()
  if Logic:Get("Cultivate"):IsEmbattleFromCultivate() then
    SceneHelper:removeScene("HeroTeamTab")
    return
  end
  SceneHelper:runWithScene("Home", self.rootNode)
end
function prototype:onBtnReturn()
  if Logic:Get("Cultivate"):IsEmbattleFromCultivate() then
    SceneHelper:removeScene("HeroTeamTab")
    return
  end
  SceneHelper:runWithScene("Home", self.rootNode)
end
function prototype:onRefreshGroupData()
  local group = Logic:Get("Hero"):GetCurrentGroup()
  for i, v in ipairs(self.childNodes) do
    v:Clear()
    if i == 1 then
      v:CurrentGroup(group.groups[i])
    else
      v:RefreshHeros(group.groups[i], i)
    end
  end
end
