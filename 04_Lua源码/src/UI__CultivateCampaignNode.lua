module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local path_node = "images/Cultivate/fb_camp_node.png"
local path_nodedark = "images/Cultivate/fb_camp_nodedark.png"
local path_lian = "images/Cultivate/fb_camp_lian.png"
local path_liandark = "images/Cultivate/fb_camp_liandark.png"
function prototype:onEnter(...)
end
function prototype:refresh(data, state)
  if not data then
    return
  end
  self.id = data and data.id
  self.state = state
  local rec = Logic:Get("Battle"):GetCampaignInfoById(data.id) or {}
  self.rec = rec
  local bOpen = Logic:Get("Elite"):IsShowCampLst(rec, "PILL")
  local level = Logic:Get("PlayerInfo"):GetPlayerLevel()
  bOpen = bOpen and level >= rec.level
  local info = {}
  for i = 1, KFDBGetRecordAmt("BattleInfoConfig") do
    info = KFDBGetRecordByIdx("BattleInfoConfig", i) or {}
    if info.campaignId == rec.id and info.prevId == "" then
      break
    end
  end
  self.info = info
  local bState = Logic:Get("Cultivate"):CheckCulCondition(info.cultivateState)
  bOpen = bOpen and bState
  self.bOpen = bOpen
  local spr = Logic:Get("Cultivate"):GetStateImage(state, not bOpen)
  if spr then
    self.sprName:setDisplayFrame(spr:displayFrame())
  end
  local path = bOpen and path_node or path_nodedark
  spr = CCSprite:create(path)
  if spr then
    self.sprNode:setDisplayFrame(spr:displayFrame())
  end
  local path = bOpen and path_lian or path_liandark
  spr = CCSprite:create(path)
  if spr then
    self.sprLeft:setDisplayFrame(spr:displayFrame())
    self.sprRight:setDisplayFrame(spr:displayFrame())
  end
  local bFinalCamp = Logic:Get("Elite"):IsFinalCampaign(data.id)
  if bFinalCamp then
    self.sprLeft:setVisible(false)
    self.sprRight:setVisible(false)
  else
    local bLeft = state % 2 == 1
    self.sprLeft:setVisible(bLeft)
    self.sprRight:setVisible(not bLeft)
  end
end
function prototype:onBtnNode(...)
  if not self.id then
    return
  end
  local num = tonumber(string.match(self.id, "%d+"))
  if num >= 6 then
    Prompt:Fail(103392)
    return
  end
  if not self.bOpen then
    local strName = Logic:Get("Cultivate"):GetPrevStateName(self.state)
    local str = ""
    local tCondition = json.decode(self.info.cultivateState or "") or {}
    for k, v in pairs(tCondition) do
      local name = Logic:Get("Cultivate"):GetStateName(tonumber(k))
      str = str .. TwGetStr(114124, v, name)
    end
    str = TwGetStr(114109, self.info.level, strName, str)
    Prompt:Tip(str)
    return
  end
  Logic:Get("Elite"):SetCampaignId(self.id)
  SceneHelper:pushScene("CultivateBattle")
end
