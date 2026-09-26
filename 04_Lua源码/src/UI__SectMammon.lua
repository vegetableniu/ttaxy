module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.ttfCostOne:setStyle(kCCLabelTTFStyleOutline)
  self.ttfGetOne:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCostTen:setStyle(kCCLabelTTFStyleOutline)
  self.ttfGetTen:setStyle(kCCLabelTTFStyleOutline)
  self.menuClose:setVisible(false)
  local godDesc = Logic:Get("Sect"):getGodRewardsDesc()
  self.godDesc = godDesc
  self.ani1 = Logic:Get("AniMgr"):NewCCB("UI/uigold01", self, ccp(308, 490), 0, nil, 1)
  local sectInfo = Logic:Get("Sect"):getSectInfo()
  self.sectInfo = sectInfo
  self:initCostAndReward()
  self.descLab:setString(TwGetStr(110082, sectInfo.canPrayTime) .. "\n" .. godDesc)
  self.canPrayTime = sectInfo.canPrayTime
  Logic:Get("Sect"):On(Logic.Sect.EVT.PRAY_OK, self:Event("OnPrayOk"))
end
function prototype:initCostAndReward()
  local sectInfo = Logic:Get("Sect"):getSectInfo()
  local cost, reward = Logic:Get("Sect"):GetPrayCostAndReward(sectInfo.prayTimes)
  if sectInfo.prayTimes < 1 then
    self.free = true
    self.ttfCostOne:setColor(ccc3(20, 250, 20))
    self.ttfCostOne:setString(TwGetStr(110094))
  else
    self.ttfCostOne:setColor(ccc3(240, 240, 240))
    self.ttfCostOne:setString(TwGetStr(110084, cost))
  end
  self.ttfGetOne:setString(TwGetStr(110085, reward))
  self.pray1 = cost
  self.reward1 = reward
  cost, reward = Logic:Get("Sect"):GetPrayCostAndReward(sectInfo.prayTimes, true)
  self.ttfCostTen:setString(TwGetStr(110084, cost))
  self.ttfGetTen:setString(TwGetStr(110085, reward))
  self.pray10 = cost
  self.reward10 = reward
end
function prototype:onMenuClose(sender, event)
end
function prototype:onBtnCancel(sender, event)
  SceneHelper:runWithScene("SectMain", self.rootNode)
end
function prototype:onBtnPrayOne(sender, event)
  self.reward = self.reward1
  if self.free then
    self:prayOne()
  else
    Prompt:ConfirmRecord(self, "", TwGetStr(110088, self.pray1), self.prayOne, Prompt.PROMPT_TYPE.SELECT, nil, Logic.SureConfirm.RECORD_TYPE.SECT_MAMMON)
  end
end
function prototype:onBtnPrayTen(sender, event)
  self.reward = self.reward10
  Prompt:ConfirmRecord(self, "", TwGetStr(110088, self.pray10), self.prayTen, Prompt.PROMPT_TYPE.SELECT, nil, Logic.SureConfirm.RECORD_TYPE.SECT_MAMMON)
end
function prototype:prayOne()
  if self.canPrayTime and self.canPrayTime > 0 then
    Logic:Get("Sect"):PostPray(1)
  else
    Logic:Get("SureConfirm"):SetBtnText({
      ok = TwGetStr(104003)
    })
    Prompt:Confirm(Logic:Get("Main"), "", 110093, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
  end
end
function prototype:prayTen()
  if self.canPrayTime and self.canPrayTime >= 10 then
    Logic:Get("Sect"):PostPray(10)
  else
    Logic:Get("SureConfirm"):SetBtnText({
      ok = TwGetStr(110087)
    })
    Prompt:Select(self, "", 110086, self.OnComfirmPray10)
  end
end
function prototype:onBtnGain(sender, event)
  Logic:Get("Sect"):PostPrayEnd()
end
function prototype:aniEnd()
  self.ani2 = Logic:Get("AniMgr"):NewCCB("UI/uigold02", self, ccp(320, 480), 0, nil, 1)
  self.ani2:RunAni(nil, nil, bind(self.showTip, self))
end
function prototype:showTip()
  self.ani2:RemoveAnimation()
  self.bAniRunning = false
end
function prototype:runRewardAni()
  local ani = Logic:Get("AniMgr"):NewCCB("UI/UIbpgod", self)
  if ani then
    ani:GetChild("ttfText"):setStyle(kCCLabelTTFStyleOutline)
    ani:GetChild("ttfText"):setString(TwGetStr(110096, self.reward or 0))
    ani:RunAni(nil, nil, bind(function()
      ani:RemoveAnimation()
    end, self))
  end
end
function prototype:OnPrayOk(prayVo)
  self.prayVo = prayVo
  self.free = false
  if not self.bAniRunning then
    self.ani1:RunAni(nil, nil, bind(self.aniEnd, self))
    self.bAniRunning = true
  end
  if self.prayVo then
    self.descLab:setString(TwGetStr(110082, self.prayVo.canPrayTime) .. "\n" .. self.godDesc)
    self.canPrayTime = self.prayVo.canPrayTime
  end
  self:initCostAndReward()
  self:runRewardAni()
end
function prototype:OnComfirmPray10(ret)
  if ret == Prompt.RET.OK then
    if self.canPrayTime > 0 then
      Logic:Get("Sect"):PostPray(1)
    else
      Logic:Get("SureConfirm"):SetBtnText({
        ok = TwGetStr(104003)
      })
      Prompt:Confirm(Logic:Get("Main"), "", 110093, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    end
  end
end
