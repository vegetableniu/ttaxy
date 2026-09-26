module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:onEnter()
  local country = Logic:Get("Sect"):getCountryInfoAboutBid()
  if table.empty(country or {}) then
    return
  end
  local firstName = country.data.firstMenpaiNames or ""
  local secName = country.data.secMenpaiNames or ""
  self.ttfTime:setStyle(kCCLabelTTFStyleOutline)
  self.ttfBid1:setStyle(kCCLabelTTFStyleOutline)
  self.ttfBid2:setStyle(kCCLabelTTFStyleOutline)
  local joinFightDate = Logic:Get("Sect"):GetJoinFightDate()
  if joinFightDate then
    local strFormat = TwGetStr(108126)
    local startTime = Logic:Get("System"):GetTimeStr(strFormat, joinFightDate[2] / 1000)
    self.ttfTime:setString(TwGetStr(108139, startTime))
  end
  if firstName == "" and secName == "" then
    self.nodeVs:setVisible(false)
    return
  end
  if firstName == "" then
    self.ttfBid1:setString(TwGetStr(108136, secName, country.data.secBid))
    self.ttfBid2:setString(TwGetStr(103006))
    return
  end
  if secName == "" then
    self.ttfName1:setString(firstName)
    self.ttfBid1:setString(TwGetStr(108136, firstName, country.data.firstBid))
    self.ttfBid2:setString(TwGetStr(103006))
    return
  end
  self.ttfBid1:setString(TwGetStr(108136, firstName, country.data.firstBid))
  self.ttfBid2:setString(TwGetStr(108136, secName, country.data.secBid))
end
function prototype:onBtnOk(sender, event)
  SceneHelper:removePrompt(self.rootNode)
end
