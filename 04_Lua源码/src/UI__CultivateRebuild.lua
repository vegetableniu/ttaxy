module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onEnter()
  super.onEnter(self)
  self.ttfCost:setStyle(kCCLabelTTFStyleOutline)
  self.ttfRealm:setStyle(kCCLabelTTFStyleOutline)
  self.state = 1
  self.isFree = false
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.SELECT_HERO, self:Event("onSelectHero"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.RE_CULTIVATE_SUCCESS, self:Event("onRecultivate"))
  Logic:Get("Cultivate"):setSelectHero(nil)
  local rec = KFDBGetRecord("ConfigValue", "CULTIVATE:RE_CULTIVATE_STATE_LIMIT")
  local limitRealm = rec and tonumber(rec.content) or 1
  rec = KFDBGetRecord("CultivateState", limitRealm) or {}
  self.ttfRealm:setString(rec.name or "")
end
function prototype:onExit(...)
  Logic:Get("Cultivate"):setFromRecultivateFlage(false)
  Logic:Get("Cultivate"):setSelectHero(nil)
end
function prototype:onSelectHero()
  self.selectHero = Logic:Get("Cultivate"):getSelectHero()
  local objNode = self.btnHeroSelect:getChildByTag(0)
  if objNode then
    self.btnHeroSelect:removeChild(objNode, true)
  end
  self.imgAdd:setVisible(true)
  if table.empty(self.selectHero or {}) then
    return
  end
  local node = Logic:Get("HeroCardInfo"):createHeroCard(self.selectHero.baseId, 200)
  node:setAnchorPoint(CCPoint(0.5, 0.5))
  self.btnHeroSelect:addChild(node, 0, 0)
  local btnCz = self.btnHeroSelect:getContentSize()
  local nodeCz = self.btnHeroSelect:getContentSize()
  node:setPosition(ccp(btnCz.width / 2, btnCz.height / 2))
  self.imgAdd:setVisible(false)
  self:rebuildCost()
end
function prototype:rebuildCost()
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(self.selectHero.baseId)
  self.state = Logic:Get("Cultivate"):getCutivateStateById(self.selectHero.id)
  self.cultivateInfo = Logic:Get("Cultivate"):getCutivateInfo(self.state, info.type)
  self.ttfCost:setString(self.cultivateInfo.reCultivateCost or 0)
end
function prototype:onBtnHeroSelectBig(...)
  Logic:Get("Cultivate"):setFromRecultivateFlage(true)
  SceneHelper:pushScene("CultivateSelectHero", self.rootNode)
end
function prototype:onBtnReturn(...)
  Logic:Get("Cultivate"):setFromRecultivateFlage(false)
  Logic:Get("Cultivate"):setSelectHero(nil)
  Logic:Get("Cultivate"):FireEvent(Logic.Cultivate.EVT.SELECT_HERO)
  SceneHelper:removeScene("CultivateRebuild")
end
function prototype:onBtnRebuildCost(...)
  if table.empty(self.selectHero or {}) then
    Prompt:Fail(108688)
    return
  end
  Prompt:Select(self, "", TwGetStr(108686, self.cultivateInfo.reCultivateCost or 0), self.onSureComfirmCost, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onSureComfirmCost(ret)
  if ret ~= Logic.SureConfirm.RET.OK then
    return
  end
  if self:checkMoney() then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  self.isFree = false
  Logic:Get("Cultivate"):PostReCultivate(true, self.selectHero.id)
end
function prototype:onBtnRebuildFree(...)
  if table.empty(self.selectHero or {}) then
    Prompt:Fail(108688)
    return
  end
  Prompt:Select(self, "", TwGetStr(108691), self.onSureComfirmFree, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onSureComfirmFree(ret)
  if ret ~= Logic.SureConfirm.RET.OK then
    return
  end
  self.isFree = true
  Logic:Get("Cultivate"):PostReCultivate(false, self.selectHero.id)
end
function prototype:checkMoney()
  local money = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  local cost = self.cultivateInfo.rebuildCost or 0
  if cost and money and money < cost then
    return true
  end
  return false
end
function prototype:onRecultivate()
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(self.selectHero.baseId)
  local rec = KFDBGetRecord("CultivateState", self.state) or {}
  self.ttfRealm:setString(rec.name or "")
  local str = ""
  if self.isFree then
    str = TwGetStr(108692, info.name or "", rec.name or "", rec.name or "")
  else
    str = TwGetStr(108690, info.name or "", rec.name or "", rec.name or "")
  end
  Prompt:Tip(str)
  Logic:Get("Cultivate"):setSelectHero(nil)
  self:onSelectHero()
end
