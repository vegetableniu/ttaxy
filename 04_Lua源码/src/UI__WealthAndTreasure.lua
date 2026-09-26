module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
SAVE_STATE = Enum({
  "HAVE_NOT_YET_SAVED",
  "HAS_SAVED"
})
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.title_ttf:setColor(ccc3(255, 183, 18))
  self.title_ttf:setString(giftInfo.name)
  self.title_ttf:setStyle(kCCLabelTTFStyleOutline)
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz", self.sprCharge, ccp(35, 19), 0, nil, nil)
  if self.ani then
    self.ani:RunAni()
  end
  Logic:Get("Deposit"):PostGetDepositInfo()
  Logic:Get("Deposit"):On(Logic.Deposit.EVT.GET_DEPOSIT_INFO_OK, self:Event("refresh"))
  Logic:Get("Deposit"):On(Logic.Deposit.EVT.SAVE_JADES_OK, self:Event("jumpToWealthRet"))
  Logic:Get("Deposit"):On(Logic.Deposit.EVT.GET_JADES_OK, self:Event("jumpToGiftActivityList"))
end
function prototype:onBtnReturnClicked(sender, event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnRechargeClicked(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
function prototype:refresh(depositInfo)
  if not depositInfo or table.empty(depositInfo) then
    return
  end
  if depositInfo.amount and depositInfo.amount > 0 then
    self:changeShowBySaveState(SAVE_STATE.HAS_SAVED)
  elseif depositInfo.amount and depositInfo.amount == 0 then
    self:changeShowBySaveState(SAVE_STATE.HAVE_NOT_YET_SAVED)
  end
end
function prototype:jumpToWealthRet()
  self:changeShowBySaveState(SAVE_STATE.HAS_SAVED)
end
function prototype:jumpToGiftActivityList()
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:changeShowBySaveState(state)
  local nodeShow
  if SAVE_STATE.HAVE_NOT_YET_SAVED == state then
    nodeShow = Tw.Controller:load("WealthAndTreasureSave", self.rootNode)
  elseif SAVE_STATE.HAS_SAVED == state then
    nodeShow = Tw.Controller:load("WealthAndTreasureRet", self.rootNode)
  end
  local prevNodeShow = self.pNode:getChildByTag(1)
  if prevNodeShow ~= nil then
    self.pNode:removeChildByTag(1, true)
  end
  if nodeShow ~= nil then
    self.pNode:addChild(nodeShow, 0, 1)
  end
end
