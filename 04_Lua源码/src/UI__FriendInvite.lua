module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local MAC_LENGTH_MAX = 6
local CARD_SIZE_WIDTH = 122
function prototype:initialize(...)
  super.initialize(self, ...)
  self.showRewardInfo = {}
  self.twitterTxt = ""
  self.vsinsTxt = ""
  self.facebbookTxt = ""
  self.tipInfo = {}
  self.tableViewControl = ""
  self.invitId = ""
  self.heroBaseId = 1167
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  self.staFriendEnter:setString(TwGetStr(103125))
  self.twitter:setVisible(false)
  self.vsins:setVisible(false)
  self.facebook:setVisible(false)
  self.sprShare:setVisible(false)
  local sysBool = Logic:Get("System"):IsOpenFaceBook()
  if sysBool then
    self.sprShare:setVisible(true)
    self.facebook:setVisible(true)
  end
  self.inviteInput:setVisible(false)
  self.inputInviteMac:setVisible(false)
  self.ttfInviteStr:setVisible(false)
  self.inputInviteMac:setFontSize(27)
  self.inputInviteMac:setClear(true)
  self.inputInviteMac:setMaxLens(MAC_LENGTH_MAX)
  Logic:Get("FriendInvite"):PostGetRewardList()
  Logic:Get("FriendInvite"):On(Logic.FriendInvite.EVT.GET_REWARD_LIST_SUCCESSED, self:Event("onGetRewardList"))
  Logic:Get("FriendInvite"):On(Logic.FriendInvite.EVT.GET_REWARD_LIST_FAILED, self:Event("onGetFailed"))
  Logic:Get("FriendInvite"):On(Logic.FriendInvite.EVT.GET_INVITE_CODE_SUCCESSED, self:Event("onGetInviteCodeSuccessed"))
  Logic:Get("FriendInvite"):On(Logic.FriendInvite.EVT.GET_INVITE_CODE_FAILED, self:Event("onGetInviteCodeFailed"))
  Logic:Get("FriendInvite"):On(Logic.FriendInvite.EVT.ADD_INVITE_CODE_SUCCESSED, self:Event("onAddInviteCodeSuccessed"))
  Logic:Get("FriendInvite"):On(Logic.FriendInvite.EVT.ADD_INVITE_CODE_FAILED, self:Event("onAddInviteCodeFailed"))
  local loginInfo = Logic:Get("Login"):GetLoginInfo()
  self:createHeroCard(self.heroBaseId)
  for i = 1, KFDBGetRecordAmt("InviteRewardConfig") do
    local inviteRewardFdb = KFDBGetRecord("InviteRewardConfig", i)
    if inviteRewardFdb then
      table.insert(self.showRewardInfo, {
        rules = tostring(inviteRewardFdb.rewardInfo),
        completed = 0,
        id = i
      })
    end
  end
  self.data = {}
  self.tipInfo = {
    area = loginInfo.server or "",
    server = loginInfo.name or "",
    inviteMac = self.invitId or "",
    webSite = ""
  }
  self.tableViewControl = TableViewEx.prototype:createList(self, self.rewardInfo, 1)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.rewardInfo:addChild(self.tableViewControl.tableView)
end
function prototype:onTwitter(sender, event)
  local title = TwGetStr(101518)
  self.twitterTxt = TwGetStr(101516, self.tipInfo.area, self.tipInfo.server, self.invitId)
  Prompt:Confirm(self, title, self.twitterTxt, self.onSendTwitterShare, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onVsins(sender, event)
  local title = TwGetStr(101519)
  self.vsinsTxt = TwGetStr(101516, self.tipInfo.area, self.tipInfo.server, self.invitId)
  Prompt:Confirm(self, title, self.vsinsTxt, self.onSendVsinsShare, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onCertain(sender, event)
  local inviteMac = self.inputInviteMac:getString()
  if inviteMac then
    if "" == inviteMac then
      Prompt:Fail(TwGetStr(101525))
    elseif string.find(inviteMac, "[^%w]") then
      Prompt:Fail(101527)
      return false
    else
      inviteMac = string.upper(inviteMac)
      if self.invitId == inviteMac then
        Prompt:Fail(TwGetStr(101520))
      else
        Logic:Get("FriendInvite"):PostaddInviteCode(inviteMac)
      end
    end
  end
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("Friend", self.rootNode)
end
function prototype:onSendTwitterShare()
  Logic:Get("EnvLogic"):WeiboShare("sina", TwGetStr(101516, self.tipInfo.server, self.invitId))
end
function prototype:onSendVsinsShare()
  Logic:Get("EnvLogic"):WeiboShare("tecent", TwGetStr(101516, self.tipInfo.server, self.invitId))
end
function prototype:onGetRewardList()
  local temp = Logic:Get("FriendInvite"):GetRewardList()
  if temp then
    self.invitId = temp.inviteCode or ""
    self.invitId = string.upper(self.invitId)
    self.staFriendMac:setString(self.invitId)
    self.staFriendNum:setString(temp.inviteNum or "")
    if nil ~= temp.addCode and not temp.addCode then
      self.inputInviteMac:setVisible(true)
      self.inviteInput:setVisible(true)
    else
      self.ttfInviteStr:setVisible(true)
      self.ttfInviteStr:setString(TwGetStr(101529))
    end
    if temp.rewardList then
      for _, v in pairs(temp.rewardList) do
        self.showRewardInfo[v].completed = 1
      end
    end
    self.data = {
      self.showRewardInfo
    }
    self.tableViewControl:RequireUpdate()
  end
end
function prototype:onGetFailed(code)
  Prompt:Fail("ErrorCode:" .. code)
end
function prototype:onGetInviteCodeSuccessed(content)
  if not content then
    Prompt:Fail(TwGetStr(101524))
  else
    local inviteMac = self.inputInviteMac:getString()
    Logic:Get("FriendInvite"):PostaddInviteCode(inviteMac)
  end
end
function prototype:onGetInviteCodeFailed(code)
  Prompt:Fail("ErrorCode1:" .. code)
end
function prototype:onAddInviteCodeSuccessed(content)
  Prompt:Fail(TwGetStr(101526))
  self.inputInviteMac:setVisible(false)
  self.inviteInput:setVisible(false)
  self.ttfInviteStr:setVisible(true)
  self.ttfInviteStr:setString(TwGetStr(101529))
end
function prototype:onAddInviteCodeFailed(code)
  if -1 == code then
    Prompt:Fail(TwGetStr(101521))
  elseif -2 == code then
    Prompt:Fail(TwGetStr(101522))
  elseif -3 == code then
    Prompt:Fail(TwGetStr(101523))
  else
    Prompt:Fail(TwGetStr(101528) .. code)
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(300, 80)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("FriendInviteItem", self.rootNode)
    subScene:Refrash(self.data[curPage][index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):Refrash(self.data[curPage][index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.data and not table.empty(self.data) and self.data[curPage] and not table.empty(self.data[curPage]) then
    return #self.data[curPage]
  else
    return 0
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:createHeroCard(baseId)
  if baseId == nil then
    return
  end
  local node = Logic:Get("HeroCardInfo"):createHeroCard(baseId, CARD_SIZE_WIDTH)
  if node == nil then
    return
  end
  local cardSz = node:getContentSize()
  node:setScale(0.85 * (CARD_SIZE_WIDTH / cardSz.width))
  node:setAnchorPoint(CCPoint(0.5, 0.5))
  self.layer:addChild(node)
  node:setPosition(self.friendIcon:getPosition())
end
function prototype:onBtnHeroImage()
  Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.heroBaseId)
end
function prototype:onFacebook()
  self.facebbookTxt = TwGetStr(101516, self.tipInfo.server, self.invitId)
  Logic:Get("Facebook"):SetShareFriendContent(self.facebbookTxt)
  SceneHelper:pushPrompt("FacebookTip", nil)
end
function prototype:onSendFacebookShare()
  Logic:Get("System"):ShareFaceBook(self.facebbookTxt)
end
