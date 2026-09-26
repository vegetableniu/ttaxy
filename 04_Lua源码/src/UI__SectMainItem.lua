module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:refreshInfo(info)
  if not info then
    return
  end
  for i = 1, 8 do
    if info[i] then
      local nodeName = "Node" .. tostring(i)
      local nodeProxy = Tw.Controller:load("SectMainItemNode", self.rootNode)
      local nodeInfo = Logic:Get("SectMain"):getBtnInfo(info[i])
      nodeProxy:refreshInfo(nodeInfo)
      Logic:Get("SectMain"):checkBtn(info[i], nodeProxy)
      self[nodeName]:addChild(nodeProxy)
    end
  end
end
