module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
ARRIVE_TIP = {
  "arriveTip1",
  "arriveTip2",
  "arriveTip3",
  "arriveTip4"
}
POP_TIP = {
  "popTip1",
  "popTip2",
  "popTip3",
  "popTip4"
}
ARROW = {
  "arrow1",
  "arrow2",
  "arrow3"
}
TTF_MONEY = {
  "ttfMoney1",
  "ttfMoney2",
  "ttfMoney3",
  "ttfMoney4"
}
TTF_NPCNAME = {
  "ttfNpcName1",
  "ttfNpcName2",
  "ttfNpcName3",
  "ttfNpcName4"
}
function prototype:onEnter()
  super.onEnter(self)
  local btn = {
    "btnNpc1",
    "btnNpc2",
    "btnNpc3",
    "btnNpc4"
  }
  self.numTrea = 0
  self.layer:reorderChild(self.main_dg, -2)
  for i = 1, #ARRIVE_TIP do
    self[TTF_MONEY[i]]:setStyle(kCCLabelTTFStyleOutline)
    self[TTF_NPCNAME[i]]:setStyle(kCCLabelTTFStyleOutline)
    self[POP_TIP[i]]:setVisible(false)
    self[TTF_NPCNAME[i]]:setColor(ccColor3B(255, 255, 255))
    self[TTF_MONEY[i]]:setColor(ccColor3B(255, 255, 255))
    local npc = KFDBGetRecord("RankConfig", i)
    if npc ~= nil then
      self[TTF_NPCNAME[i]]:setString(npc.npcname)
      self[TTF_MONEY[i]]:setString(npc.costs)
    end
  end
  for i = 2, #btn do
    self[btn[i]]:setEnabled(false)
    self[TTF_NPCNAME[i]]:setColor(ccColor3B(255, 255, 255))
    self[TTF_MONEY[i]]:setColor(ccColor3B(255, 255, 255))
  end
  local boolVip = Logic:Get("PlayerInfo"):IsOpenFunc()
  self:setBtnGetVip(boolVip)
  self.treaLst = {}
  Logic:Get("Treasure"):On(Logic.Treasure.EVT.REFRESH_INFO, self:Event("RefreshTreaEnter"))
  Logic:Get("Treasure"):On(Logic.Treasure.EVT.REFRESH_LOOKFOR, self:Event("RefreshTreaLookFor"))
  Logic:Get("Treasure"):On(Logic.Treasure.EVT.REFRESH_AUTO_LOOKFOR, self:Event("RefreshTreaAutoLookFor"))
  Logic:Get("Guide"):On(Logic.Guide.EVT.STEP, self:Event("updateGuide"))
end
function prototype:bindAnimationMgr()
  return true
end
function prototype:completedAnimationSequenceNamed(name)
  if name ~= "Default Timeline" then
    return
  end
  Logic:Get("Treasure"):PostInfo()
  self:updateGuide()
end
function prototype:setBtnGetVip(bool)
  local ITEM_BG_IMG = {}
  ITEM_BG_IMG.NORMAL = {
    normal = "images/public/btnCommonNormal.png",
    select = "images/public/btnCommonSelect.png",
    disable = "images/public/btnCommonDisable.png"
  }
  ITEM_BG_IMG.DISABLE = {
    normal = "images/public/btnCommonDisable.png",
    select = "images/public/btnCommonDisable.png",
    disable = "images/public/btnCommonDisable.png"
  }
  local imgs = ITEM_BG_IMG.DISABLE
  if bool then
    imgs = ITEM_BG_IMG.NORMAL
  end
  self.btnGetvip:setBackgroundSpriteForState(CCScale9Sprite:create(imgs.normal), CCControlStateNormal)
  self.btnGetvip:setBackgroundSpriteForState(CCScale9Sprite:create(imgs.select), CCControlStateHighlighted)
  self.btnGetvip:setBackgroundSpriteForState(CCScale9Sprite:create(imgs.disable), CCControlStateDisabled)
end
function prototype:RefreshTreaEnter()
  local treaPacVo = Logic:Get("Treasure"):GetTreasurePackVo()
  self:VisibleNpc(treaPacVo.rank)
  self.treaLst = treaPacVo.treasures
  self:VisibleTrea(self.treaLst)
end
function prototype:RefreshTreaAutoLookFor()
  local lookForResultArr = Logic:Get("Treasure"):GetLookForResultArr()
  self.btnDeal:setEnabled(false)
  self.btnGetNor:setEnabled(false)
  self.btnGetvip:setEnabled(false)
  self.btnUpSkill:setEnabled(false)
  self.num = 1
  Singleton(Timer):Repeat(200, self:Event("RefreshTreaArr"))
end
function prototype:RefreshTreaArr()
  local lookForResultArr = Logic:Get("Treasure"):GetLookForResultArr()
  local lookForResult = lookForResultArr[self.num]
  if lookForResult == nil then
    self.btnDeal:setEnabled(true)
    self.btnGetNor:setEnabled(true)
    self.btnGetvip:setEnabled(true)
    self.btnUpSkill:setEnabled(true)
    self:EventTracer():Cancel("RefreshTreaArr")
    return
  end
  self:VisibleNpc(lookForResult.rank)
  for i = 1, #lookForResult.treasures do
    table.insert(self.treaLst, lookForResult.treasures[i])
  end
  self:VisibleTrea(self.treaLst)
  if #self.treaLst >= 8 then
    self.btnDeal:setEnabled(true)
    self.btnGetNor:setEnabled(true)
    self.btnGetvip:setEnabled(true)
    self.btnUpSkill:setEnabled(true)
    self:EventTracer():Cancel("RefreshTreaArr")
  end
  self.num = self.num + 1
end
function prototype:RefreshTreaLookFor()
  local logicTreasure = Logic:Get("Treasure")
  if logicTreasure:isHunting() then
    Singleton(Timer):After(0, self:Event("TimerGuide", function()
      logicTreasure:setHunting(false)
      Logic:Get("Guide"):check()
    end))
  end
  local lookForResult = Logic:Get("Treasure"):GetLookForResult()
  self:VisibleNpc(lookForResult.rank)
  for i = 1, #lookForResult.treasures do
    table.insert(self.treaLst, lookForResult.treasures[i])
  end
  self:VisibleTrea(self.treaLst)
end
function prototype:VisibleNpc(rank)
  if rank ~= nil then
    self.rank = rank
  end
  local btn = {
    "btnNpc1",
    "btnNpc2",
    "btnNpc3",
    "btnNpc4"
  }
  for i = 1, #ARRIVE_TIP do
    self[POP_TIP[i]]:setVisible(false)
    if self.ani ~= nil then
      self.ani:RemoveAnimation()
    end
    self[btn[i]]:setEnabled(false)
    self[TTF_NPCNAME[i]]:setColor(ccColor3B(255, 255, 255))
    self[TTF_MONEY[i]]:setColor(ccColor3B(255, 255, 255))
  end
  local x = self[btn[tonumber(rank)]]:getPositionX()
  local y = self[btn[tonumber(rank)]]:getPositionY()
  self.ani = Logic:Get("AniMgr"):RunCCBAni("UI/uijnsjtx", self, ccp(x, y), 0.8)
  self[btn[tonumber(rank)]]:setEnabled(true)
  self[TTF_NPCNAME[tonumber(rank)]]:setColor(ccColor3B(0, 255, 0))
  self[TTF_MONEY[tonumber(rank)]]:setColor(ccColor3B(0, 255, 0))
  local seq1 = Logic:Get("Gift"):scaleImg()
end
function prototype:VisibleTrea(treaPac)
  local bagNum = {
    "bag_a",
    "bag_b",
    "bag_c",
    "bag_d",
    "bag_e",
    "bag_f",
    "bag_g",
    "bag_h"
  }
  for i = 1, #bagNum do
    local trea = self.layer:getChildByTag(i)
    if trea ~= nil then
      self.layer:removeChildByTag(i, true)
    end
  end
  if #treaPac > 8 then
    return
  end
  self.numTrea = #treaPac
  for i = 1, #treaPac do
    local sprTrea = Logic:Get("Treasure"):GetSprTrea(treaPac[i])
    self.layer:addChild(sprTrea, 0, i)
    sprTrea:setAnchorPoint(CCPoint(0.5, 0.5))
    sprTrea:setPosition(self[bagNum[i]]:getPosition())
  end
end
function prototype:onBtnNpc()
  if self.numTrea >= 8 then
    Prompt:Tip(103042)
    return
  end
  Logic:Get("Treasure"):PostLookFor()
end
function prototype:callBackFunc()
  SceneHelper:pushScene("HeroUpSkill", self.rootNode)
end
function prototype:onBtnGetVip(sender, event)
  local boolVip = Logic:Get("PlayerInfo"):IsOpenFunc()
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  self.rank = self.rank or 1
  local npc = KFDBGetRecord("RankConfig", self.rank)
  if not boolVip then
    if event == CCControlEventTouchDown then
      Prompt:PopTip(103047)
    end
    if event == CCControlEventTouchUpOutside or event == CCControlEventTouchUpInside or event == CCControlEventTouchCancel then
      Logic:Get("SureConfirm"):FireEvent(Logic.SureConfirm.EVT.CLOSE_POPTIP)
    end
  elseif event == CCControlEventTouchUpInside then
    if self.numTrea >= 8 then
      Prompt:Tip(103042)
      return
    elseif npc.costs and tonumber(wallet.copper) < tonumber(npc.costs) then
      Prompt:Fail(TwGetStr(10035))
      return
    else
      Logic:Get("Treasure"):PostAutoLookFor()
    end
  end
end
function prototype:onBtnGetNor()
  Logic:Get("Guide"):done("Treasure", "Hunt")
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  self.rank = self.rank or 1
  local npc = KFDBGetRecord("RankConfig", self.rank)
  if self.numTrea >= 8 then
    Prompt:Tip(103042)
    return
  end
  if npc.costs and tonumber(wallet.copper) < tonumber(npc.costs) then
    Prompt:Fail(TwGetStr(10035))
    return
  end
  Logic:Get("Treasure"):PostLookFor()
end
function prototype:onBtnDeal()
  Logic:Get("Guide"):done("TreasureDraw", "Draw")
  if self.numTrea <= 0 then
    Prompt:Tip(103043)
    return
  end
  local bool = Logic:Get("Hero"):IsBagEnough()
  if bool then
    local btnText = {}
    btnText.ok = TwGetStr(103068)
    Logic:Get("SureConfirm"):SetBtnText(btnText)
    Logic:Get("SureConfirm"):SetAni(true)
    Prompt:Confirm(self, 103066, 103067, self.callBackFunc, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  Logic:Get("Treasure"):PostReceive()
end
function prototype:UpSkill()
  Logic:Get("Guide"):done("SkillUpgrade", "SelectUpgrade")
  SceneHelper:pushScene("HeroUpSkill", self.rootNode)
end
function prototype:onBtnClose()
  SceneHelper:runWithScene("Home", self.rootNode)
end
function prototype:onBtnInfo1()
  if self.treaLst[1] ~= nil then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.treaLst[1])
  end
end
function prototype:onBtnInfo2()
  if self.treaLst[2] ~= nil then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.treaLst[2])
  end
end
function prototype:onBtnInfo3()
  if self.treaLst[3] ~= nil then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.treaLst[3])
  end
end
function prototype:onBtnInfo4()
  if self.treaLst[4] ~= nil then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.treaLst[4])
  end
end
function prototype:onBtnInfo5()
  if self.treaLst[5] ~= nil then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.treaLst[5])
  end
end
function prototype:onBtnInfo6()
  if self.treaLst[6] ~= nil then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.treaLst[6])
  end
end
function prototype:onBtnInfo7()
  if self.treaLst[7] ~= nil then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.treaLst[7])
  end
end
function prototype:onBtnInfo8()
  if self.treaLst[8] ~= nil then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.treaLst[8])
  end
end
function prototype:updateGuide()
  local logicGuide = Logic:Get("Guide")
  if logicGuide:isActive("Treasure", "Hunt") then
    Logic:Get("Treasure"):setHunting(true)
    logicGuide:lockTouch(self.btnGetNor)
  end
  if logicGuide:isActive("TreasureDraw", "Start") then
    logicGuide:done("TreasureDraw", "Start")
  end
  if logicGuide:isActive("TreasureDraw", "Draw") then
    Logic:Get("Treasure"):setDrawing(true)
    logicGuide:lockTouch(self.btnDeal)
  end
  if logicGuide:isActive("SkillUpgrade", "Start") then
    logicGuide:done("SkillUpgrade", "Start")
  end
  if logicGuide:isActive("SkillUpgrade", "SelectUpgrade") then
    logicGuide:lockTouch(self.btnUpSkill)
  end
end
