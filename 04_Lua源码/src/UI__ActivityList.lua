module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local HEIGHT = 25
local ACTIVITY_DAY = 7
local FONT_SIZE = 26
local WEEK_BG = "images/public/chapter.png"
local ACTIVITY_BG = "images/Activity/bg.png"
local WEEK_DAY = {
  Monday = 106030,
  Tuesday = 106031,
  Wednesday = 106032,
  Thursday = 106033,
  Friday = 106034,
  Saturday = 106035,
  Sunday = 106036
}
local TRANSFORM_DAY = {
  "Sunday",
  "Saturday",
  "Friday",
  "Thursday",
  "Wednesday",
  "Tuesday",
  "Monday"
}
function prototype:initialize()
  super.initialize(self)
  local spr = self:addSprite(WEEK_BG)
  self.TITLE_POS = {
    week = {
      x = spr:getContentSize().width / 2 - 60,
      y = spr:getContentSize().height / 2 - 30,
      anchorPosX = 0,
      anchorPosY = 0,
      fontSize = 44,
      color = {
        255,
        255,
        255
      }
    },
    actName = {
      x = 20,
      y = 60,
      anchorPosX = 0,
      anchorPosY = 0,
      fontSize = 35,
      color = {
        255,
        255,
        0
      }
    },
    actTime = {
      x = 20,
      y = 25,
      anchorPosX = 0,
      anchorPosY = 0,
      fontSize = 24,
      color = {
        30,
        255,
        30
      }
    },
    actDrop = {
      x = 415,
      y = 60,
      anchorPosX = 0.5,
      anchorPosY = 0.5,
      fontSize = 27,
      color = {
        255,
        255,
        255
      }
    }
  }
end
function prototype:onEnter()
  super.onEnter(self)
  local scroll = CCScrollViewEx:create(CCSizeMake(590, 540))
  scroll:setDirection(kCCScrollViewDirectionVertical)
  scroll:setClippingToBounds(true)
  scroll:setPositionY(187)
  scroll:setPositionX(26)
  local activityList = self:getAllActivityListInfo()
  local container = CCSprite:create()
  local posY = 0
  for i, v in ipairs(TRANSFORM_DAY) do
    if nil ~= activityList[TRANSFORM_DAY[i]] then
      for _, v1 in pairs(activityList[TRANSFORM_DAY[i]]) do
        local cnode = self:createActivityItem(ACTIVITY_BG, v1)
        container:addChild(cnode)
        cnode:setPosition(CCPointMake(0, posY))
        cnode:setAnchorPoint(CCPointMake(0, 0))
        posY = posY + cnode:getContentSize().height - 10
      end
      local dayNode = self:createActivityItem(WEEK_BG, self:getWeekInfo(v))
      container:addChild(dayNode)
      dayNode:setPosition(CCPointMake(0, posY + 4))
      dayNode:setAnchorPoint(CCPointMake(0, 0))
      posY = posY + dayNode:getContentSize().height + HEIGHT
    end
  end
  local conHeight = posY - 20
  local conWidth = 578
  container:setContentSize(CCSizeMake(conWidth, conHeight))
  scroll:setContainer(container)
  scroll:updateInset()
  scroll:setContentOffset(CCPointMake(0, -(posY - 560)), false)
  self.rootNode:addChild(scroll)
  local bar = CCScale9Sprite:create("images/public/imgSlider.png")
  local barBg = CCScale9Sprite:create("images/public/imgSliderBg.png")
  scroll:setScrollBar(bar, barBg)
end
function prototype:createActivityItem(bgPath, itemInfo)
  local ccnode = CCNode:create()
  local spr = self:addSprite(bgPath)
  ccnode:addChild(spr)
  for k, v in pairs(itemInfo) do
    local avtivityNameTitle = self:addTitle(v, self.TITLE_POS[k].x, self.TITLE_POS[k].y, self.TITLE_POS[k].fontSize, self.TITLE_POS[k].color, self.TITLE_POS[k].anchorPosX, self.TITLE_POS[k].anchorPosY)
    ccnode:addChild(avtivityNameTitle)
  end
  ccnode:setContentSize(CCSizeMake(578, spr:getContentSize().height))
  return ccnode
end
function prototype:addSprite(bgPath)
  local spr = CCScale9Sprite:create(bgPath)
  spr:setPosition(CCPointMake(0, 0))
  spr:setAnchorPoint(CCPointMake(0, 0))
  spr:setContentSize(CCSizeMake(578, spr:getContentSize().height))
  return spr
end
function prototype:addTitle(strInfo, posX, posY, fontSize, color, anchorPosX, anchorPosY)
  local avtivityNameTitle = CCLabelTTF:create()
  avtivityNameTitle:setPosition(CCPointMake(posX, posY))
  avtivityNameTitle:setAnchorPoint(CCPointMake(anchorPosX, anchorPosY))
  avtivityNameTitle:setFontSize(fontSize)
  avtivityNameTitle:setColor(ccc3(color[1], color[2], color[3]))
  avtivityNameTitle:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  avtivityNameTitle:setDimensions(CCSize(320, 0))
  avtivityNameTitle:setString(strInfo)
  return avtivityNameTitle
end
function prototype:getWeekInfo(weekInfo)
  local result = {}
  result.week = TwGetStr(WEEK_DAY[weekInfo])
  return result
end
function prototype:getAllActivityListInfo()
  local result = {}
  for i = 1, KFDBGetRecordAmt("ActivityList") do
    local info = KFDBGetRecordByIdx("ActivityList", i)
    local week = info.id
    local eachDayActive = result[week]
    if nil == eachDayActive then
      result[week] = {}
    end
    table.insert(result[week], {
      actName = info.ActivityName,
      actTime = info.ActivityTime,
      actDrop = info.ItemDrop
    })
  end
  return result
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:popScene()
end
