module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCount:setStyle(kCCLabelTTFStyleOutline)
  self.ttfDesc:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:refresh(data)
  if not data or table.empty(data) then
    return
  end
  local baseId = data[1]
  self.baseId = baseId
  local path = Logic:Get("Armor"):getArmorImgBg(baseId)
  local sprBg = CCSprite:create(path)
  if sprBg then
    self.sprBg:setDisplayFrame(sprBg:displayFrame())
  end
  path = Logic:Get("Armor"):getArmorImg(baseId)
  local sprIcon = CCSprite:create(path)
  if sprIcon then
    self.sprIcon:setDisplayFrame(sprIcon:displayFrame())
  end
  local sprFrag = Logic:Get("Compose"):GetJigsawImg()
  if sprFrag then
    self.sprFrag:setDisplayFrame(sprFrag:displayFrame())
  end
  local rec = Logic:Get("Armor"):getArmorInfoByBaseId(baseId) or {}
  local color = Logic:Get("Armor"):getColorByBaseId(baseId)
  self.ttfName:setColor(color)
  self.ttfName:setString(rec.name or "")
  self.ttfCount:setString(TwGetStr(111125, data[2]))
  local needCount = 0
  self.canCompose, needCount = Logic:Get("Armor"):CheckCanCompose(baseId)
  self.ttfDesc:setString(TwGetStr(111126, needCount, rec.name or ""))
  self.sprCompose:setVisible(self.canCompose)
  self.sprNotyet:setVisible(not self.canCompose)
  self.btnItem:setEnabled(self.canCompose)
end
function prototype:onBtnIcon(sender, event)
  Logic:Get("Armor"):openArmorDetails(self.baseId, true)
end
function prototype:onBtnItem(sender, event)
  Logic:Get("Armor"):PostCompose(self.baseId)
end
