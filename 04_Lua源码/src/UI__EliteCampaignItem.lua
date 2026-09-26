module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self.ttfState:setStyle(kCCLabelTTFStyleOutline)
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfActionPoint:setStyle(kCCLabelTTFStyleOutline)
  self.ttfNotice:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLevelOpen:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:onExit()
end
function prototype:refresh(data)
  self:clear()
  if nil == data or table.empty(data) or data.id == nil then
    return
  end
  self.data = data
  self.ttfName:setString(data.name or "")
  local bFinish = Logic:Get("Elite"):IsClearCampaign(data.id)
  if not bFinish or not TwGetStr(100002) then
  end
  self.ttfState:setString((TwGetStr(100001)))
  self.ttfLevelOpen:setString(TwGetStr(105311, data.level))
  local level = Logic:Get("PlayerInfo"):GetPlayerLevel()
  if level < self.data.level then
    self.ttfLevelOpen:setString(TwGetStr(100054, data.level))
    self.ttfLevelOpen:setColor(ccc3(255, 0, 0))
  end
end
function prototype:clear()
  self.ttfState:setString("")
  self.ttfName:setString("")
  self.ttfActionPoint:setString("")
  self.ttfNotice:setString("")
  self.ttfLevelOpen:setString("")
  self.ttfLevelOpen:setColor(ccc3(0, 255, 108))
end
function prototype:onItemClicked(sender, event)
  Logic:Get("Guide"):done("EquipElite", "SelectCampaign")
  local level = Logic:Get("PlayerInfo"):GetPlayerLevel()
  if level < self.data.level then
    Prompt:ConfirmBtnText(100061)
    Prompt:Select(self, nil, TwGetStr(100060, self.data.level), self.onConfirmUpLevel, nil, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  Logic:Get("Elite"):SetCampaignId(self.data.id)
  SceneHelper:runWithScene("EliteBattle", self.rootNode)
end
function prototype:updateGuide()
  if Logic:Get("Guide"):isActive("EquipElite", "SelectCampaign") then
    Logic:Get("Elite"):setEliteBattle(true)
    Logic:Get("Guide"):lockTouch(self.btnItem)
  end
end
function prototype:onConfirmUpLevel(confType)
  if confType == SureConfirm.RET.CANCEL then
    return
  end
  local campInfo = Logic:Get("Battle"):GetCampaignInfoById(self.data.id)
  if nil == campInfo then
    return
  end
  if "" == campInfo.prevId then
    return
  end
  local prevIdLst = json.decode(campInfo.prevId)
  if #prevIdLst == 0 then
    return
  end
  local prevId = prevIdLst[1]
  Logic:Get("Elite"):SetCampaignId(prevId)
  SceneHelper:runWithScene("EliteBattle", self.rootNode)
end
