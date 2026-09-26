module((...), package.seeall)
require("utf8")
prototype = Tw.Controller.prototype:extend()
local FRIENDNAMESIZE = 12
local FONT_SIZE = 30
function prototype:onEnter()
  self.edtSectName:setMaxLens(FRIENDNAMESIZE)
  self.edtSectName:setFontSize(FONT_SIZE)
  self.edtSectName:setPlaceHolder(TwGetStr(110136))
  self.labSectNameTips:setStyle(kCCLabelTTFStyleOutline)
  self.labCostTip:setString(TwGetStr(110114))
  self.labSectNameTips:setString(TwGetStr(110119))
  self.cost = KFDBGetRecord("ConfigValue", "MENPAI:CREATE_COST_XIANYU_COUNT")
  self.cost = self.cost and tonumber(self.cost.content) or 0
  local str = TwGetStr(110106, self.cost)
  str = string.format("<font color='#ffffff' SIZE='26'>%s</font>", str)
  self.staGold:setString(str)
  self.edtSectName.textField:setAnchorPoint(CCPoint(0.5, 0.5))
  local contentSize = self.edtSectName.textField:getContentSize()
  self.edtSectName.textField:setPosition(CCPoint(contentSize.width / 2, contentSize.height / 2))
end
function prototype:onBtnSure()
  if not Logic:Get("Sect"):checkGold() then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  if not Logic:Get("Sect"):checkLevel() then
    local level = KFDBGetRecord("ConfigValue", "MENPAI:CREATE_LEVEL_LIMIT")
    level = level and tonumber(level.content) or 30
    Prompt:Fail(TwGetStr(110157, level))
    return
  end
  local sectName = self.edtSectName:getString()
  if Logic:Get("Sect"):checkName(sectName) then
    Prompt:Confirm(self, "", TwGetStr(110107, self.cost), self.createSect, Prompt.PROMPT_TYPE.SELECT)
  end
end
function prototype:createSect()
  local sectName = self.edtSectName:getString()
  Logic:Get("Sect"):PostCreateMenpai(sectName)
end
function prototype:onLeftClicked()
  SceneHelper:runWithScene("SectListAdd", self.rootNode)
end
