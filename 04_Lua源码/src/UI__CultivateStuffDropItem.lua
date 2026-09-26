module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local path_dis = "images/Cultivate/xq_drop_bgdis.png"
function prototype:onEnter(...)
  self.ttfDrop:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:refresh(id, bFirst)
  if not id then
    return
  end
  self.id = id
  self:refreshDrop(id)
  self:refreshLock(id)
  self:checkFirstOpen(bFirst)
end
function prototype:refreshDrop(id)
  local rec = Logic:Get("Battle"):GetBattleInfoById(id) or {}
  self.ttfDrop:setString(rec.name or "")
end
function prototype:refreshLock(id)
  local bClearPrev = Logic:Get("Elite"):isClearPrevBattle(id, "PILL")
  local bClear = Logic:Get("Elite"):IsClearBattle(id)
  local bOpen = bClearPrev or bClear
  self.bOpen = bOpen
  self.sprLock:setVisible(not bOpen)
  self.sprUnLock:setVisible(bOpen)
  self.btnItem:setEnabled(bOpen)
  if not bOpen then
    local spr = CCSprite:create(path_dis)
    if spr then
      self.sprBg:setDisplayFrame(spr:displayFrame())
    end
    self.ttfDrop:setColor(ccc3(170, 170, 170))
  end
end
function prototype:checkFirstOpen(bFirst)
  if not self.bOpen then
    return
  end
  local bFirstOpen = Logic:Get("System"):GetSysVariableMisc("FirstOpenStuff")
  if bFirstOpen == 0 or bFirstOpen == "" or bFirstOpen == nil then
    Logic:Get("System"):SetSysVariableMisc("FirstOpenStuff", 1)
    self.ani1 = Logic:Get("AniMgr"):NewCCB("UI/UIcz02", self.btnItem, ccp(37, 22))
    if self.ani1 then
      self.ani1:RunAni()
    end
    local function runAnia()
      if self.ani2 then
        self.ani2:RemoveAnimation()
      end
      self.ani2 = Logic:Get("AniMgr"):NewCCB("UI/uixsyd02", self.sprAni, ccp(0, -6))
      if self.ani2 then
        self.ani2:RunAni()
      end
    end
    local arr = CCArray:create()
    arr:addObject(CCCallFuncN:create(runAnia))
    arr:addObject(CCDelayTime:create(1.5))
    self.sprAni:runAction(CCRepeatForever:create(CCSequence:create(arr)))
  end
end
function prototype:onBtnItem(...)
  if not self.id then
    return
  end
  if self.ani1 then
    self.ani1:RemoveAnimation()
  end
  self.sprAni:stopAllActions()
  if self.ani2 then
    self.ani2:RemoveAnimation()
  end
  local campId = Logic:Get("Battle"):GetBattleCampaignId(self.id)
  if not campId then
    return
  end
  Logic:Get("Cultivate"):GenerateCheckedStuffInfo()
  Logic:Get("Elite"):SetCampaignId(campId)
  Logic:Get("Cultivate"):SetFromCultivateStuff(true)
  SceneHelper:removeScene("CultivateBattle")
  Logic:Get("Cultivate"):SetCheckedBattleId(self.id)
  SceneHelper:pushScene("CultivateBattle")
  Logic:Get("Cultivate"):SetBtlBtnVisible(false)
end
