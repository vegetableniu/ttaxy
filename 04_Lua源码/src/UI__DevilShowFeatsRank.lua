module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local ITEM_HEIGHT = 112
local VIEW_HEIGHT = 460
function prototype:initialize(...)
  super.initialize(self, ...)
  self.subScene = {}
end
function prototype:onEnter()
  Logic:Get("Devil"):On(Logic.Devil.EVT.PRAISE_CHANGE, self:Event("RefrashFeatsRank"))
  if not self.eventTracer:Exist("onShowHeroGroupInfo") then
    Logic:Get("Devil"):On(Logic.Devil.EVT.SHOW_GROUP_INFO, self:Event("onShowHeroGroupInfo"))
  end
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pRankList, 1)
  self.tableViewControl:RequireUpdateWithoutAnimat(1)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.m_pRankList:addChild(self.tableViewControl.tableView)
  self:RefrashFeatsRank()
end
function prototype:RefrashFeatsRank()
  self.featsRankInfo = Logic:Get("Devil"):GetFeatsRankTop()
  if self.featsRankInfo == nil or next(self.featsRankInfo) == nil then
    return
  end
  local featsRank = Logic:Get("Devil"):getMyFeatsRank()
  if featsRank > 0 then
    self.staFeatsRank:create(0, "YELLOW_E_NUM")
    self.staFeatsRank:setAlign("LEFT", "CENTER")
    self.staFeatsRank:setValue(featsRank)
  else
    self.ttfFeatsRank:setString("-")
  end
  local damageRank = Logic:Get("Devil"):getMyDamageRank()
  if damageRank > 0 then
    self.staDamageRank:create(0, "YELLOW_E_NUM")
    self.staDamageRank:setAlign("LEFT", "CENTER")
    self.staDamageRank:setValue(damageRank)
  else
    self.ttfDamageRank:setString("-")
  end
  self.tableViewControl:RequireUpdateWithoutAnimat(1, true)
end
function prototype:onBtnReturn()
  if Logic:Get("Draw"):getHasDraw() then
    local curLevel = Logic:Get("PlayerInfo"):GetPlayerLevel()
    local nextDrawLevel = Logic:Get("Draw"):getNextDrawLevel()
    if curLevel >= nextDrawLevel then
      SceneHelper:pushScene("DrawEntry", nil, self.mainScene)
      SceneHelper:removeScene("DevilShowFeatsRank")
      return
    end
  end
  Logic:Get("Guide"):check()
  if not Logic:Get("Guide"):isGuiding() then
    local divilData = Logic:Get("Devil"):GetHasDemog()
    if divilData then
      MsgDemog:Post("REFRESH_DEMOG")
      Logic:Get("Devil"):SetHasDemog(false)
    end
  end
  SceneHelper:removeScene("DevilShowFeatsRank")
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 112)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("DevilShowFeatsRankItem", self.rootNode)
    subScene.pFeatsRankItem:RefrashRankInfo(self.featsRankInfo[index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2).pFeatsRankItem:RefrashRankInfo(self.featsRankInfo[index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.featsRankInfo == nil or table.empty(self.featsRankInfo) then
    return 0
  end
  return #self.featsRankInfo
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:onShowHeroGroupInfo()
  SceneHelper:pushScene("DevilHeroGroupView", self.rootNode)
end
