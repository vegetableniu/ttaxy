module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = Tw.Controller.prototype:extend()
local WIN_WIDTH, WIN_HEIGHT = 580, 300
local LIFE_BG_PATH = "images/public/progress1.png"
local CURR_LIFE_PATH = "images/public/progress2.png"
function prototype:initialize(...)
  super.initialize(self, ...)
  self.btnList = {}
  Logic:Get("Sect"):On(Logic.Sect.EVT.REFRESH_GOON_WIDGET, self:Event("updateSectLvInfo"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.STOP_GRAB_TIGHT_OK, self:Event("refreshCall"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.SECT_MONEY_CHANGED, self:Event("OnMoneyChanged"))
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  self.sectInfo = Logic:Get("Sect"):getSectInfo()
  local rec = KFDBGetRecord("MenpaiLevelConfig", self.sectInfo.level)
  local maxMemberCounts = rec and rec.count or 0
  Logic:Get("Sect"):getJobSetting()
  self.staCallShow:setStyle(kCCLabelTTFStyleOutline)
  self.labExpTip:setStyle(kCCLabelTTFStyleOutline)
  self.labExp:setStyle(kCCLabelTTFStyleOutline)
  self.labMem:setStyle(kCCLabelTTFStyleOutline)
  self.ttfBossName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfSectMoney:setStyle(kCCLabelTTFStyleOutline)
  self.nodProgress:createProgress(LIFE_BG_PATH, CURR_LIFE_PATH)
  self.nodProgress:setVisible(true)
  self:updateSectLvInfo()
  self.ttfSectName:setString(self.sectInfo.name)
  self.staCallShow:setString(self.sectInfo.post)
  self.ttfBossName:setString(self.sectInfo.bossName)
  self.ttfSectMoney:setString(tostring(self.sectInfo.money or 0))
  self.btnList = Logic:Get("SectMain"):getBtnItem()
  self:initBtnList()
  self.labMem:setString(string.format("%d/%d", self.sectInfo.count, maxMemberCounts))
  Logic:Get("SectMain"):timer()
  if not Logic:Get("Sect"):isGrabRight() then
    return
  end
  local str = Logic:Get("Sect"):getCall()
  self.staCallShow:setString(str)
  if not Logic:Get("Sect"):isFromHome() then
    return
  end
  Logic:Get("Sect"):setIsFromHome(false)
  local job = self.sectInfo.job
  if Logic:Get("Sect"):checkAuth(job, "STOP_GRAB_RIGHT") then
    Logic:Get("SureConfirm"):SetBtnText({
      cancel = TwGetStr(110146),
      ok = TwGetStr(110145)
    })
    Prompt:Select(self, "", TwGetStr(110144), self.sendPower, Prompt.PROMPT_TYPE.SELECT)
  end
end
function prototype:onExit()
end
function prototype:sendPower(type)
  if type == Logic.SureConfirm.RET.CANCEL then
    Logic:Get("Sect"):PostStopGrabRight()
  end
end
function prototype:initBtnList()
  if not self.btnList then
    return
  end
  self.maxPage = #self.btnList
  self.maxPage = self.maxPage < 1 and 1 or self.maxPage
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pCList, self.maxPage, false)
  self.m_pCList:addChild(self.tableViewControl.tableView)
  self.tableViewControl:RequireUpdate()
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionHorizontal)
  if self.maxPage < 2 then
    self.tableViewControl.tableView:setTouchEnabled(false)
  else
    self.tableViewControl.tableView:setTouchEnabled(true)
  end
end
function prototype:onLeftClicked(sender, event)
  SceneHelper:runWithScene("Home", self.rootNode)
end
function prototype:cellSizeForTable()
  return CCSizeMake(WIN_WIDTH, WIN_HEIGHT)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("SectMainItem", self.rootNode)
    subScene:refreshInfo(self.btnList[curPage])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):refreshInfo(self.btnList[curPage])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  curPage = curPage or 1
  if not self.btnList then
    return 0
  end
  if self.btnList[curPage] then
    return 1
  else
    return 0
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:updateSectLvInfo()
  self.sectInfo = Logic:Get("Sect"):getSectInfo()
  local battleExpAdd = KFDBGetRecord("MenpaiLevelConfig", self.sectInfo.level)
  battleExpAdd = battleExpAdd and tonumber(battleExpAdd.expRate) or 0
  battleExpAdd = battleExpAdd * 100
  self.labExpTip:setString(TwGetStr(110076, battleExpAdd))
  local curLvExp = Logic:Get("Sect"):GetSectLevelExp(self.sectInfo.level)
  local nextLvExp = Logic:Get("Sect"):GetSectLevelExp(self.sectInfo.level + 1)
  if nextLvExp == -1 then
    self.labExp:setString(TwGetStr(110070))
  else
    self.labExp:setString(tostring(self.sectInfo.exp - curLvExp) .. "/" .. tostring(nextLvExp - curLvExp))
  end
  self.nodLevel:create(0, "YELLOW_E_NUM")
  self.nodLevel:setAlign("LEFT", "CENTER")
  self.nodLevel:setValue(self.sectInfo.level)
  local value = Logic:Get("Sect"):getExpPer()
  self.nodProgress:setValue(value)
  if self.tableViewControl and self.tableViewControl.tableView then
    self.btnList = Logic:Get("SectMain"):getBtnItem()
    self.tableViewControl.tableView:refreshData()
  end
end
function prototype:onBtnCallTip(sender, event)
  if event == CCControlEventTouchDown then
    SceneHelper:removePrompt(nil, "SectMainInfoPrompt")
    SceneHelper:pushPrompt("SectMainInfoPrompt")
    return
  end
  if event == CCControlEventTouchDragInside then
    return
  end
  SceneHelper:removePrompt(nil, "SectMainInfoPrompt")
end
function prototype:refreshCall()
  self.sectInfo = Logic:Get("Sect"):getSectInfo()
  self.staCallShow:setString(self.sectInfo.post)
end
function prototype:OnMoneyChanged(money)
  self.ttfSectMoney:setString(tostring(money or 0))
end
