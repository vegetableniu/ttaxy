require("utf8")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local EDIT_MAX_FONT = 8
local EDIT_SIZE = 25
function prototype:initialize()
  super.initialize(self)
  Logic:Get("Sect"):On(Logic.Sect.EVT.BIDRANK_FINISHED, self:Event("eventCallBack"))
end
function prototype:onEnter()
  local minBidCount = KFDBGetRecord("ConfigValue", "MENPAI:MENPAI_MIN_BID_COUNT")
  minBidCount = minBidCount and tonumber(minBidCount.content) or 10
  self.staOut:setString(TwGetStr(110116))
  self.staShow:setDimensions(CCSize(480, 0))
  self.staShow:setString(TwGetStr(110117))
  self.money = Logic:Get("Sect"):getSectInfo().money or 0
  self.ttfMoney:setString(TwGetStr(110091, self.money))
  self.edtNum:setMaxLens(EDIT_MAX_FONT)
  self.edtNum:setFontSize(EDIT_SIZE)
end
function prototype:onExit()
  Logic:Get("Sect"):ExitSectBid()
end
function prototype:onBtnBid(sender, event)
  local bid = self.edtNum:getString()
  if bid:find("%.") then
    Prompt:Fail(TwGetStr(110128))
    return
  end
  bid = tonumber(bid)
  if not bid or bid == 0 then
    Prompt:Fail(TwGetStr(110127))
    return
  end
  if bid > self.money then
    Prompt:Confirm(self, "", 110092)
    return
  end
  self.bid = bid
  Prompt:Confirm(self, "", TwGetStr(110118, self.bid), self.SendBidRank, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onBtnCancel(sender, event)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:SendBidRank()
  if self.bid then
    Logic:Get("Sect"):PostBidRank(self.bid)
    self.bid = nil
  end
end
function prototype:eventCallBack()
  SceneHelper:removePrompt(self.rootNode)
  Logic:Get("Sect"):PostGetMenpaiList(nil, 1)
end
