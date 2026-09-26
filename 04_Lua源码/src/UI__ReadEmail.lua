module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
local WIN_WIDTH, WIN_HEIGHT = 560, 130
local FONTSIZEW, FONTSIZEH = 500, 300
function prototype:onEnter()
  self.num = 1
  self.closeTTF:setString(TwGetStr(103130))
  self.onReply = true
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pCListEmailRewards, 1)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.m_pCListEmailRewards:addChild(self.tableViewControl.tableView)
  Logic:Get("Email"):On(Logic.Email.EVT.EMAIL_CHANGE, self:Event("RefrashReadEmail"))
  local curEmail = Logic:Get("Email"):GetReadEmail()
  if curEmail and not curEmail.readed then
    Logic:Get("Email"):SendMsgReadEmail(curEmail.id, curEmail.groupTarget)
  else
    self:RefrashReadEmail()
  end
end
function prototype:onBtnReply(sender, event)
  if self.onReply then
    Logic:Get("Email"):SetReply(self.readMail.sender)
    SceneHelper:removeScene("ReadEmail")
    SceneHelper:pushPrompt("SendEmail", self.rootNode)
    return
  end
  if Logic:Get("Email"):CanNotDrawActionMail(self.readMail) then
    Prompt:Fail(115151)
    return
  end
  Logic:Get("Email"):SendMsgGetReward(self.readMail.id, self.readMail.groupTarget)
end
function prototype:onBtnClose(sender, event)
  SceneHelper:removeScene("ReadEmail")
end
function prototype:RefrashReadEmail()
  self.readMail = Logic:Get("Email"):GetReadEmail()
  local sender = self.readMail.sender or ""
  if self.readMail.system then
    sender = TwGetStr(101107)
  end
  self.staSender:setString(sender)
  local str = self.readMail.content
  if self.readMail.template then
    local fdbInfo = KFDBGetRecord("MailTemplate", self.readMail.template)
    if fdbInfo and not table.empty(fdbInfo) then
      self.fdbStr = fdbInfo.content or ""
    end
    if self.fdbStr then
      Logic:Get("Analysis"):SetNeedSwapStr(self.fdbStr)
      Logic:Get("Analysis"):FindDollar(self.fdbStr, "$")
      if Logic:Get("Analysis"):GetIsSwapString() then
        Logic:Get("Analysis"):SetSwapString(self.fdbStr, self.readMail.content)
      end
      str = Logic:Get("Analysis"):GetSwapFinishString()
    end
  end
  str = ReplaceStringTab(str)
  self.staMailContent:setString(str or "")
  self.btnReply:setEnabled(true)
  self.staReply:setString(TwGetStr(101105))
  if self.readMail.attachment then
    self.onReply = false
    self.staReply:setString(TwGetStr(101106))
    if not self.readMail.drawed then
      self.data = {
        [1] = self.readMail.attachment.rewards
      }
    else
      self.data = {}
      self.btnReply:setEnabled(false)
    end
    self.tableViewControl:RequireUpdate(1)
  elseif self.readMail.system then
    self.btnReply:setEnabled(false)
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(WIN_WIDTH, WIN_HEIGHT)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene
    subScene = Tw.Controller:load("EamilReward", self.rootNode)
    subScene:ReFrashEmailRewards(self.data[curPage][index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):ReFrashEmailRewards(self.data[curPage][index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.data and self.data[curPage] and next(self.data[curPage]) ~= nil then
    return #self.data[curPage]
  else
    return 0
  end
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  return
end
