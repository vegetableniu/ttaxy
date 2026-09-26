module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  Logic:Get("Mall"):On(Logic.Mall.EVT.BUY_BAG, self:Event("BuyBag"))
  self.title:setStyle(kCCLabelTTFStyleOutline)
  self.title:setColor(ccColor3B(187, 255, 0))
  self.title:setString(TwGetStr(103104))
  self.ttfOne:setString(TwGetStr(103108))
  self.content:setString(TwGetStr(103105))
  local heroLv = Logic:Get("PlayerInfo"):GetPlayerLevel()
  local bShowSaleBtn = heroLv >= 30
  self.btnSureOne:setString(TwGetStr(103106))
  self.btnSureOne:setVisible(true)
  self.btnSwallow:setVisible(true)
  self.btnSureTwo:setString(TwGetStr(107031))
  self.btnSureTwo:setVisible(bShowSaleBtn)
  self.btnSale:setVisible(bShowSaleBtn)
  self.closeTTF:setString(TwGetStr(103107))
end
function prototype:onBtnSwallow(sender, event)
  SceneHelper:runWithScene("HeroUpgrade", self.rootNode)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnCancel(sender, event)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnSale(sender, event)
  SceneHelper:runWithScene("HeroSale", self.rootNode)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:BuyBag(cost, size)
  local text = TwGetStr(105204, size, cost)
  Prompt:Confirm(self, 105203, text, self.onConfirmBuy, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onConfirmBuy()
  Logic:Get("Mall"):PostBuyBag()
end
