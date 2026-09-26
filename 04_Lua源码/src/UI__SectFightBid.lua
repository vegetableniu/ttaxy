require("utf8")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local EDIT_MAX_FONT = 8
local EDIT_SIZE = 25
function prototype:initialize()
  super.initialize(self)
  Logic:Get("Sect"):On(Logic.Sect.EVT.COUNTRY_BID_FINISH, self:Event("eventCallBack"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.COUNTRY_BID_END, self:Event("onCountryBidEnd"))
end
function prototype:onEnter()
  self.countryId = Logic:Get("Sect"):getCountryId()
  if self.countryId == nil then
    return
  end
  local countryInfo = KFDBGetRecord("CountrySetting", self.countryId)
  self.minBidCount = countryInfo.minBid or 1
  self.staOut:setString(TwGetStr(110116))
  self.money = Logic:Get("Sect"):getSectInfo().money or 0
  self.ttfMoney:setString(TwGetStr(110091, self.money))
  self.ttfLimit:setString(TwGetStr(108110, self.minBidCount))
  self.ttfContent:setString(TwGetStr(108111))
  self.edtNum:setMaxLens(EDIT_MAX_FONT)
  self.edtNum:setFontSize(EDIT_SIZE)
end
function prototype:onExit()
  Logic:Get("Sect"):FireEvent(Logic.Sect.EVT.SET_TABLEVIEW_TOUCH, true)
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
  if bid < self.minBidCount then
    Prompt:Confirm(self, "", TwGetStr(108114, self.minBidCount))
    return
  end
  if bid > self.money then
    Prompt:Confirm(self, "", 110092)
    return
  end
  self.bid = bid
  Prompt:Confirm(self, "", TwGetStr(108118, self.bid), self.SendBidRank, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onBtnCancel(sender, event)
  Logic:Get("Sect"):FireEvent(Logic.Sect.EVT.SET_TABLEVIEW_TOUCH, true)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:SendBidRank()
  if self.bid then
    Logic:Get("Sect"):postBidForCountry(self.bid, self.countryId)
    self.bid = nil
  end
end
function prototype:eventCallBack()
  SceneHelper:removePrompt(self.rootNode)
  MsgMenpai:Post("COUNTRY_DATA")
end
function prototype:onCountryBidEnd()
  SceneHelper:removePrompt(self.rootNode)
  SceneHelper:runWithScene("SectMain", self.rootNode)
end
