module((...), package.seeall)
require("BtnPosition")
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:onEnter()
  super.onEnter(self)
  self.sectInfo = Logic:Get("Sect"):getSectInfo()
  self:checkGrabTight()
  local job = Logic:Get("Sect"):getSectInfo().job
  if not Logic:Get("Sect"):checkAuth(job, "DECLARATION") then
    self.btnDec:setEnabled(false)
  end
  if not Logic:Get("Sect"):checkAuth(job, "POST") then
    self.btnCall:setEnabled(false)
  end
  if not Logic:Get("Sect"):checkAuth(job, "LIST_APPLY") then
    self.btnApply:setEnabled(false)
  end
  if Logic:Get("Sect"):IsNewApplyState() and Logic:Get("Sect"):checkAuth(job, "LIST_APPLY") then
    self.imgApplyFlag:removeAllChildrenWithCleanup(true)
    Logic:Get("AniMgr"):RunCCBAni("UI/uinew", self.imgApplyFlag, nil, 1, nil, nil, nil, -1)
    self.imgApplyFlag:setVisible(true)
  end
  Logic:Get("Sect"):On(Logic.Sect.EVT.GRAB_TIGHT_OK, self:Event("hideGrabTightBtn"))
end
function prototype:checkGrabTight()
  self.sectInfo = Logic:Get("Sect"):getSectInfo()
  if not Logic:Get("Sect"):isGrabRight() or self.sectInfo.hasGrabed then
    self.ttfGrap:setVisible(false)
    self.btnGrap:setVisible(false)
    return
  end
  local job = self.sectInfo.job
  if job ~= Logic.Sect.JobType.BOSS then
    self.ttfGrap:setVisible(true)
    self.btnGrap:setVisible(true)
  else
    self.ttfGrap:setVisible(false)
    self.btnGrap:setVisible(false)
  end
end
function prototype:onBtnChangeDec(sender, event)
  if self.btnDec:isEnabled() then
    SceneHelper:pushPrompt("SectChangeDec", self.rootNode)
  else
    Prompt:Tip(TwGetStr(110151))
  end
end
function prototype:onBtnChangeCall(sender, event)
  if Logic:Get("Sect"):isGrabRight() then
    Prompt:Tip(TwGetStr(110148))
    return
  end
  if self.btnCall:isEnabled() then
    SceneHelper:pushPrompt("SectChangeCall", self.rootNode)
  else
    Prompt:Tip(TwGetStr(110151))
  end
end
function prototype:onBtnSectList(sender, event)
  SceneHelper:runWithScene("SectList", self.rootNode)
end
function prototype:onBtnMemberList(sender, event)
  SceneHelper:runWithScene("SectMember", self.rootNode)
end
function prototype:onBtnApply(sender, event)
  if self.btnApply:isEnabled() then
    SceneHelper:runWithScene("SectApplyList", self.rootNode)
  else
    Prompt:Tip(TwGetStr(110151))
  end
end
function prototype:onLeftClicked(sender, event)
  SceneHelper:runWithScene("SectMain", self.rootNode)
end
function prototype:onGrapClicked(sender, event)
  local job = Logic:Get("Sect"):getSectInfo().job
  if job == Logic.Sect.JobType.BOSS then
    Prompt:Tip(TwGetStr(110255))
    return
  end
  Logic:Get("Sect"):PostGrabTight()
end
function prototype:onBtnQuite(sender, event)
  Prompt:Confirm(self, "", TwGetStr(110152), self.sureQuiteSect, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:sureQuiteSect()
  Logic:Get("Sect"):PostQuitMenpai()
end
function prototype:hideGrabTightBtn()
  self.ttfGrap:setVisible(false)
  self.btnGrap:setVisible(false)
end
