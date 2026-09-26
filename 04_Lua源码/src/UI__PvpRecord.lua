module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  local list = Logic:Get("Pvp"):GetAttackedRecord()
  local strList = {}
  for i = #list, 1, -1 do
    local str = string.format("nodRecord%d", #list - i + 1)
    if self[str] then
      if list[i].win then
        local nameStr = TwGetStr(104253) .. list[i].name .. "</font>"
        local resultStr = TwGetStr(104252) .. TwGetStr(105807, nameStr) .. "</font>"
        table.insert(strList, TwGetStr(105807, list[i].name))
        self[str]:setString(resultStr)
      else
        local nameStr = TwGetStr(104253) .. list[i].name .. "</font>"
        local resultStr = TwGetStr(104252) .. TwGetStr(105808, nameStr) .. "</font>"
        local rankStr = ""
        local richRankStr = ""
        local rec = KFDBGetRecord("ConfigValue", "PVP:RANK_SIZE")
        local sizeRank = rec and tonumber(rec.content) or 0
        if -1 >= list[i].oldRank then
          richRankStr = TwGetStr(104253) .. sizeRank .. "</font>"
          richRankStr = "\n" .. TwGetStr(104252) .. TwGetStr(105811, richRankStr) .. "</font>"
          rankStr = "\n" .. TwGetStr(105811, sizeRank)
        end
        if -1 < list[i].oldRank then
          local oldStr = TwGetStr(104253) .. list[i].oldRank .. "</font>"
          oldStr = TwGetStr(105809, oldStr)
          local newStr = ""
          if -1 >= list[i].newRank then
            newStr = TwGetStr(104253) .. sizeRank .. "</font>"
            newStr = TwGetStr(105811, newStr)
            rankStr = "\n" .. TwGetStr(105809, list[i].oldRank) .. TwGetStr(105811, sizeRank)
            richRankStr = "\n" .. TwGetStr(104252) .. oldStr .. newStr .. "</font>"
          elseif list[i].oldRank == list[i].newRank then
            oldStr = ""
            newStr = TwGetStr(105812)
            rankStr = newStr
            richRankStr = TwGetStr(104252) .. oldStr .. newStr .. "</font>"
          else
            newStr = TwGetStr(104253) .. list[i].newRank .. "</font>"
            newStr = TwGetStr(105810, newStr)
            rankStr = "\n" .. TwGetStr(105809, list[i].oldRank) .. TwGetStr(105810, list[i].newRank)
            richRankStr = "\n" .. TwGetStr(104252) .. oldStr .. newStr .. "</font>"
          end
        end
        resultStr = resultStr .. richRankStr
        table.insert(strList, TwGetStr(105808, list[i].name) .. rankStr)
        self[str]:setString(resultStr)
      end
    end
  end
  for i = 2, #list do
    local str = string.format("nodRecord%d", i)
    local upLabelStr = string.format("nodRecord%d", i - 1)
    if self[str] and self[upLabelStr] then
      local x = self[upLabelStr]:getPositionX()
      local y = self[upLabelStr]:getPositionY() - self[upLabelStr]:getCharSize(strList[i - 1]).height - 20
      self[str]:setPosition(ccp(x, y))
    end
  end
end
function prototype:onExit()
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("PvpMain", self.rootNode)
end
