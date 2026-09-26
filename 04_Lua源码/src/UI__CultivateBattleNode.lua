module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local pathSmall = "data/battleMap/curSmallNode.png"
local pathBoss = "data/battleMap/curBossNode.png"
local pathOpen = "images/Cultivate/fb_battle_nor.png"
local pathNotOpen = "images/Cultivate/fb_battle_dis.png"
local pathBoss = "images/Effect/uixx/0022.png"
function prototype:onEnter(...)
end
function prototype:refresh(data, index)
  if not data then
    return
  end
  self.data = data
  local aniName = self.data.bossNode == 1 and "UI/uixx02" or "UI/uixx"
  if not self.ani then
    self.ani = Logic:Get("AniMgr"):NewCCB(aniName, self.btnNode, ccp(85, 100), 0, nil, 1)
  end
  if self.ani then
    self.ani:RunAni()
  end
  self:checkStatus(data.id)
  self:checkedNodeAni(data.id)
  self:adaptNode(index)
end
function prototype:checkStatus(battleId)
  local bOpen = Logic:Get("Elite"):isClearPrevBattle(battleId, "PILL")
  local path = bOpen and pathOpen or pathNotOpen
  local spr = CCSprite:create(path)
  if spr then
    self.sprBg:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:checkedNodeAni(battleId)
  if not battleId then
    return
  end
  local checkedBattleId = Logic:Get("Cultivate"):GetCheckedBattleId()
  if checkedBattleId == battleId then
    local array = CCArray:create()
    array:addObject(CCMoveBy:create(0.3, ccp(0, 20)))
    array:addObject(CCMoveBy:create(0.3, ccp(0, -20)))
    local seq = CCSequence:create(array)
    local repeatAct = CCRepeatForever:create(seq)
    self.sprArrow:setVisible(true)
    self.sprArrow:stopAllActions()
    self.sprArrow:setPositionY(160)
    self.sprArrow:runAction(repeatAct)
  end
end
function prototype:adaptNode(index)
  if not index then
    return
  end
  if index % 2 == 0 then
    self.sprBg:setFlipX(true)
    self.sprBg:setPositionX(258)
    self.btnNode:setPositionX(160)
    self.sprArrow:setPositionX(170)
  end
end
function prototype:onBtnNode(...)
  if not self.data then
    return
  end
  Logic:Get("Elite"):SetBattleId(self.data.id)
  Logic:Get("Cultivate"):SetBattleInfo(self.data)
  Logic:Get("Cultivate"):SetBtlScrollEnabled(false)
  SceneHelper:pushScene("CultivateBattleTip", self.rootNode, nil, nil, true)
end
