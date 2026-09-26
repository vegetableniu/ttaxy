module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onQuitBottent()
  SceneHelper:runWithScene("Compose", self.rootNode)
end
function prototype:onExplainBottent()
end
function prototype:onEnter()
  super.onEnter(self)
  self.cards = Logic:Get("Compose"):GetSplitCards()
  self.page = math.ceil(#self.cards / Logic.Compose.MAX_LIST)
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pCList, self.page)
  self.tableViewControl.tableView:runUIAnimat()
  if self.page == 1 then
    self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  end
  self.m_pCList:addChild(self.tableViewControl.tableView)
  Logic:Get("Compose"):On(Logic.Compose.EVT.SPLIT, self:Event("onSplit"))
end
function prototype:onSplit()
  self.cards = Logic:Get("Compose"):GetSplitCards()
  self.page = math.ceil(#self.cards / Logic.Compose.MAX_LIST)
  self.tableViewControl:RequireUpdate(self.page)
  self:RunSplitAni()
end
function prototype:RunSplitAni()
  local runningScene = SceneHelper:getRootLayer()
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/uihl02", runningScene, nil, 1)
  self.ani:GetChild("btnClose"):setEnabled(false)
  self.ani:SetCloseCallback(self, self.onBtnCloseAni)
  Logic:Get("BGSound"):SwitchMusic("audio/up.mp3", false)
  self.ani:SetWaitSignByDefaultAniName(function()
    self:aniFrontEnd()
  end, 5000)
  local selectCard = Logic:Get("Compose"):GetSplitCard()
  self:setAniCardItem(selectCard.baseId, "imgIn", true)
  local rewardCards = Logic:Get("Compose"):GetRewardCards()
  for i = 1, 10 do
    local str = string.format("imgHero%d", i)
    local node = self.ani:GetChild(str)
    if node then
      if rewardCards[i] then
        self:setAniCardItem(rewardCards[i].baseId, str, false)
      else
        node:setVisible(false)
      end
    end
  end
  self.ani:RunAnimationWithoutWait()
end
function prototype:setAniCardItem(baseId, aniItem, IsBig)
  local cardNode = Logic:Get("HeroCardInfo"):createHeroCardForByFight(baseId)
  local texture, textureRect = 0, 0
  if IsBig then
    texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(cardNode, cardNode:getContentSize())
  else
    texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(cardNode, self.ani:GetChild(aniItem):getContentSize())
  end
  self.ani:GetChild(aniItem):setTexture(texture)
  self.ani:GetChild(aniItem):setTextureRect(textureRect)
end
function prototype:onBtnCloseAni()
  self.ani:RemoveAnimation()
  Logic:Get("BGSound"):stopAllEffect()
  Logic:Get("BGSound"):PlayBGMusic()
  Logic:Get("Compose"):PromptRewards()
end
function prototype:aniFrontEnd()
  self.ani:GetChild("btnClose"):setEnabled(true)
  local ccSprite = CCSprite:create("images/font/click_go_on.png")
  if ccSprite ~= nil then
    self.ani:GetLayer():addChild(ccSprite, 0, 10)
    local seq1 = Logic:Get("Gift"):fadetoSpr()
    ccSprite:runAction(CCRepeatForever:create(seq1))
    ccSprite:setPosition(self.ani:GetChild("ttfGoOn"):getPosition())
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(588, 164)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local idx = index + 1
  local lstIdx = idx + (curPage - 1) * Logic.Compose.MAX_LIST
  local info = self.cards[lstIdx]
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("HeroSplitItem", self.rootNode)
    subScene:ReFrashReward(info)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):ReFrashReward(info)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.page == 0 then
    self.page = 1
  end
  self.ttfPage:setString(curPage .. "/" .. self.page)
  if #self.cards == 0 then
    return 0
  end
  if self.page == curPage then
    local num = #self.cards - (self.page - 1) * Logic.Hero.MAX_HEROS_PER_PAGE
    return num
  else
    return Logic.Compose.MAX_LIST
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:onBtnLeft()
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onBtnRight()
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(1)
  end
end
