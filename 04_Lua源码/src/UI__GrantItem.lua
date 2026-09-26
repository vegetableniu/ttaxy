module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
local MEMBER_TYPE = Enum(TypeDef("com.eyu.mt.module.menpai.model.JobType"))
local TTF_ELDER = "images/Corps/ttf_zl.png"
local TTF_MEMBER = "images/Corps/ttf_bz.png"
function prototype:onEnter()
  self.type = 0
  local playerdata = Logic:Get("Sect"):GetMemberData()
  if MEMBER_TYPE[playerdata.job] == MEMBER_TYPE[2] then
    self.type = 2
    local spr = CCSprite:create(TTF_ELDER)
    if spr then
      self.ttfSpr:setDisplayFrame(spr:displayFrame())
    end
  elseif MEMBER_TYPE[playerdata.job] == MEMBER_TYPE[1] then
    self.type = 1
    local spr = CCSprite:create(TTF_MEMBER)
    if spr then
      self.ttfSpr:setDisplayFrame(spr:displayFrame())
    end
  end
end
function prototype:changeGrant(memType)
  local playerdata = Logic:Get("Sect"):GetMemberData()
  Logic:Get("Sect"):PostSetMemberJob(memType, playerdata.playerId)
  SceneHelper:removePrompt(self.rootNode)
  SceneHelper:runWithScene("SectMember", self.rootNode)
end
function prototype:onBtnClicked(sender, event)
  if self.type == 0 then
    SceneHelper:removePrompt(self.rootNode)
    return
  end
  self.type = self.type == 1 and 2 or 1
  self:changeGrant(MEMBER_TYPE[self.type])
end
function prototype:onCancelBtn(sender, event)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnBg(sender, event)
end
