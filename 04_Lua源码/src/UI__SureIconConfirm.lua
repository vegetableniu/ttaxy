module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
RET = Logic.SureConfirm.RET
local LAYOUT1 = {
  240,
  400,
  80,
  560
}
local LAYOUT2 = {
  320,
  440,
  200,
  560,
  80
}
function prototype:onEnter()
end
function prototype:onExit()
  Logic:Get("SureConfirm"):SetBtnText({
    ok = TwGetStr(103002),
    cancel = TwGetStr(103003)
  })
  Logic:Get("SureConfirm"):SetAni(false)
  if Logic:Get("Gift"):isDrawing() then
    Logic:Get("Gift"):setDrawing(false)
    Logic:Get("Guide"):check()
    return
  end
  Logic:Get("Facebook"):OpenFaceBook()
  Logic:Get("WeChat"):OpenWeChat()
end
function prototype:onNodeLoaded(node, loader)
  local params = Logic:Get("SureConfirm"):GetConfirm()
  local btnText = Logic:Get("SureConfirm"):GetBtnText()
  self.eType = 8
  self.ani = Logic:Get("SureConfirm"):GetAniBool()
  self:setConfirm(params)
  self:setBtnText(btnText)
  Logic:Get("SureConfirm"):SetConfirmNil()
end
function prototype:setConfirm(params)
  self.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTitle:setColor(ccColor3B(187, 255, 0))
  local str = ""
  str = not params.title or type(params.title) == "string" and params.title or TwGetStr(params.title)
  self.ttfTitle:setString(str)
  if not table.empty(params.content or {}) then
    local bStr = type(params.content.str) == "string"
    if not bStr or not params.content.str then
    end
    self.content:setString((TwGetStr(params.content)))
    if params.content.style then
      self.content:setStyle(params.content.style)
    end
    if params.content.color then
      self.content:setColor(params.content.color)
    end
  end
  if params.func then
    self.func = params.func
  end
  if params.titlePath then
    local spr = CCSprite:create(params.titlePath)
    if spr then
      self.sprTitle:setDisplayFrame(spr:displayFrame())
    end
  end
  for i = 1, 5 do
    local node = "nodCard" .. i
    if self[node] then
      self[node]:setVisible(false)
    end
  end
  for i = 1, 5 do
    if params.rewards and params.rewards[i] then
      local node = "nodCard" .. i
      local ccb = "ccbCard" .. i
      local richtext = "nodContent" .. i
      if self[node] then
        self[node]:setVisible(true)
        self[ccb]:ReFreshByReward(params.rewards[i])
      end
      if self[richtext] and params.richtexts and params.richtexts[i] then
        self[richtext]:setString(params.richtexts[i])
      end
    end
  end
  if params.rewards then
    local layout = #params.rewards % 2 == 0 and LAYOUT1 or LAYOUT2
    for i = 1, 5 do
      local node = "nodCard" .. i
      if self[node] and layout[i] then
        self[node]:setPositionX(layout[i])
      end
    end
  end
  if params.minisizeFlag then
    self.sprBg:setScaleY(0.6)
    self.menuArr:setPositionY(200)
    self.btnSureOne:setPositionY(self.btnSureOne:getPositionY() + 200)
    self.btnSureTwo:setPositionY(self.btnSureTwo:getPositionY() + 200)
    self.btnCancel:setPositionY(self.btnCancel:getPositionY() + 200)
  end
  if params.blessJade then
    self:showBless(params.blessJade)
  end
  local eType = params.eType ~= nil and params.eType or Prompt.PROMPT_TYPE.CONFIRM
  self.eType = eType
  self.btnSureOne:setVisible(Prompt.PROMPT_TYPE.SELECT == eType)
  self.btnCancel:setVisible(Prompt.PROMPT_TYPE.SELECT == eType)
  self.btnSureTwo:setVisible(Prompt.PROMPT_TYPE.CONFIRM == eType)
  self.btnSureOneMenu:setVisible(Prompt.PROMPT_TYPE.SELECT == eType)
  self.btnCancelMenu:setVisible(Prompt.PROMPT_TYPE.SELECT == eType)
  self.btnSureTwoMenu:setVisible(Prompt.PROMPT_TYPE.CONFIRM == eType)
end
function prototype:setBtnText(btnText)
  local strOk = nil ~= btnText.ok and btnText.ok or TwGetStr(103002)
  self.btnSureOne:setString(strOk)
  local strCancel = nil ~= btnText.cancel and btnText.cancel or TwGetStr(103003)
  self.btnCancel:setString(strCancel)
  local strYes = nil ~= btnText.ok and btnText.ok or TwGetStr(103002)
  self.btnSureTwo:setString(strYes)
end
function prototype:onBtnSure(node, loader)
  local actionScaleTo = CCScaleTo:create(0.1, 0.3)
  local arr1 = CCArray:create()
  if not self.ani then
    arr1:addObject(actionScaleTo)
  end
  arr1:addObject(CCCallFuncN:create(function()
    if self.func and self.params == nil then
      self.func()
    elseif self.func and self.params ~= nil then
      self.func(RET.OK)
    end
    Logic:Get("SureConfirm"):SetAni(false)
    SceneHelper:removePrompt(self.rootNode)
  end))
  self.layer:runAction(CCSequence:create(arr1))
end
function prototype:onBtnCancel(node, loader)
  if self.params ~= nil then
    self.func(RET.CANCEL)
    SceneHelper:removePrompt(self.rootNode)
  else
    SceneHelper:removePrompt(self.rootNode)
  end
end
function prototype:onMenuClose(node, loader)
  if self.eType == Prompt.PROMPT_TYPE.CONFIRM then
    self:onBtnSure()
  end
end
function prototype:mergeRewards(rewards)
  if rewards == nil or table.empty(rewards) then
    return
  end
  local resultReward = {}
  for _, v in ipairs(rewards) do
    local flagId = v.type .. v.code
    if resultReward[flagId] then
      resultReward[flagId].amount = resultReward[flagId].amount + v.amount
    else
      resultReward[flagId] = v
    end
  end
  return table.values(resultReward)
end
function prototype:showBless(jade)
  local getPath = "images/Bless/blessGet.png"
  local jadePath = "images/Bless/fntJade.png"
  local jadeBgPath = "images/Bless/promptBg.png"
  local spr = CCSprite:create(getPath)
  if spr then
    self.sprGet:setDisplayFrame(spr:displayFrame())
    self.sprGet:setPosition(ccp(161, 671))
  end
  spr = CCSprite:create(jadeBgPath)
  if spr then
    self.sprJadeBg:setDisplayFrame(spr:displayFrame())
  end
  spr = CCSprite:create(jadePath)
  if spr then
    self.sprJade:setDisplayFrame(spr:displayFrame())
  end
  self.nodJade:create(0, "PINK_NUM")
  self.nodJade:setAlign("RIGHT", "CENTER")
  self.nodJade:setValue(jade or 0)
  self.content:setPosition(ccp(50, 470))
  self.content:setAnchorPoint(ccp(0, 0.5))
  for i = 1, 5 do
    local node = "nodCard" .. i
    if self[node] then
      self[node]:setPositionY(self[node]:getPositionY() - 200)
    end
  end
end
