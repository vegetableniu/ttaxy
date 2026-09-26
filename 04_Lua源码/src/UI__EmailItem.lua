module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local CONTEN_MAX = 6
local QUALITY_MIN = 1
local moneyImg = {
  "images/Other/goldBig.png",
  "images/Other/xianyu.png",
  "images/Other/xianyu.png",
  "images/Other/xianyu.png",
  "images/Other/xianyu.png"
}
require("SceneHelper")
function prototype:onBtnCount(sender, event)
  Logic:Get("Email"):SetReadEmail(self.mail)
  if self.mail.client then
    Logic:Get("Email"):onMsgReadEmail(0)
    local usersVarEmail = Logic:Get("System"):GetUsrVariableMisc("UV_EMAIL")
    if usersVarEmail ~= nil then
      usersVarEmail = json.decode(usersVarEmail)
    end
    usersVarEmail.readed = true
    local str = json.encode(usersVarEmail)
    Logic:Get("System"):SetUsrVariableMisc("UV_EMAIL", str)
    SceneHelper:pushScene("ReadEmail", self.rootNode)
    return
  end
  SceneHelper:pushScene("ReadEmail", self.rootNode)
end
function prototype:onConfirm()
  if self.mail.attachment and not self.mail.drawed then
    if Logic:Get("Email"):CanNotDrawActionMail(self.mail) then
      Prompt:Fail(115152)
      return
    end
    Logic:Get("Email"):SendMsgGetReward(self.mail.id, self.mail.groupTarget)
  end
  Logic:Get("Email"):SetReadEmail(self.mail)
  local tab = {}
  tab[self.mail.id] = self.mail.groupTarget
  Logic:Get("Email"):SendEmailDelete(tab)
end
function prototype:onBtnDelete(sender, event)
  if self.mail.client then
    Prompt:Confirm(self, 103001, 101104, self.onDeleClientEmail, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  if self.mail == nil or next(self.mail) == nil then
    return
  end
  local promptInt = 101104
  if self.mail.attachment and not self.mail.drawed then
    promptInt = 101110
  end
  Prompt:Confirm(self, 103001, promptInt, self.onConfirm, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onDeleClientEmail()
  Logic:Get("Email"):SetReadEmail(self.mail)
  Logic:Get("Email"):OnMsgRemoveEmail(0)
  Logic:Get("Email"):SetClientEmail({})
  local str = json.encode({})
  Logic:Get("System"):SetUsrVariableMisc("UV_EMAIL", str)
end
function prototype:ReFrashEmailItem(mailInfo)
  local spr = CCSprite:create("images/public/systemEmail.png")
  self.imgSystem:setDisplayFrame(spr:displayFrame())
  self.imgGood:setVisible(false)
  self.imgFra:setVisible(false)
  self.imgSystem:setVisible(false)
  if mailInfo == nil or next(mailInfo) == nil then
    return
  end
  self.imgNew:setVisible(false)
  if mailInfo.readed == false then
    self.imgNew:setVisible(true)
  end
  self.m_pCHeroIcon:ReFrashHeroInfo(mailInfo.baseId, false, "HERO")
  local sender = mailInfo.sender or ""
  self.imgSystem:setVisible(false)
  if mailInfo.system then
    sender = TwGetStr(101107)
    self.imgSystem:setVisible(true)
  end
  self.staHeroName:setString(sender)
  local today = os.date("*t", mailInfo.createTime / 1000)
  local dataTime = Logic:Get("System"):GetTimeStr("%X", mailInfo.createTime / 1000)
  self.staRecvTime:setString(TwGetStr(101033, today.month or 0, today.day or 0, dataTime))
  local mailCount = ""
  local showStr = mailInfo.content or ""
  if mailInfo.template then
    local fdbInfo = KFDBGetRecord("MailTemplate", mailInfo.template)
    showStr = not fdbInfo or table.empty(fdbInfo) or fdbInfo.content or ""
    Logic:Get("Analysis"):SetNeedSwapStr(showStr)
    Logic:Get("Analysis"):FindDollar(showStr, "$")
    if Logic:Get("Analysis"):GetIsSwapString() then
      Logic:Get("Analysis"):SetSwapString(showStr, mailInfo.content)
    end
    showStr = Logic:Get("Analysis"):GetSwapFinishString()
  end
  if showStr and getStrShowWidth(showStr) > CONTEN_MAX then
    mailCount = getSubString(showStr, 0, CONTEN_MAX) .. "..."
  else
    mailCount = showStr
  end
  self.staMailCount:setString(mailCount)
  self.mail = mailInfo
  if mailInfo.system and mailInfo.attachment and not mailInfo.drawed then
    self:setEmailAttachment(mailInfo.attachment.rewards)
  end
end
function prototype:setEmailAttachment(rewards)
  local bg = Logic:Get("Reward"):GetBgByOneReward(rewards[1])
  if bg then
    self.imgSystem:setVisible(true)
    self.imgSystem:setDisplayFrame(bg:displayFrame())
  end
  local icon = Logic:Get("Reward"):GetImgByOneReward(rewards[1])
  if icon then
    local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(icon)
    self.imgGood:setVisible(true)
    self.imgGood:setTexture(texture)
    self.imgGood:setTextureRect(textureRect)
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.imgGood, rewards[1].code)
end
function prototype:setEmailIcon(heroBaseId, bClick, itemType, level, other)
  local heroImg = CCSprite:create("images/public/hero.png")
  local heroBgImg = CCSprite:create("images/public/herobg.png")
  local fra = CCSprite:create("images/public/clarity80.png")
  local rewardType = TypeDef("com.eyu.mt.module.reward.model.RewardType")
  if itemType == "HERO" or itemType == "TREASURE" or itemType == "SKILL_CARD" or itemType == "COIN_CARD" or itemType == "EXP_CARD" or itemType == rewardType.HERO or itemType == rewardType.TREASURE or itemType == rewardType.SKILL_CARD or itemType == rewardType.COIN_CARD or itemType == rewardType.EXP_CARD then
    local path = Logic:Get("Hero"):GetHeroImage(heroBaseId, Logic.Hero.HEROIMG_SIZE.MIDDLE)
    local bgPath = Logic:Get("Hero"):GetHeroBgImage(heroBaseId, Logic.Hero.HEROIMG_SIZE.MIDDLE)
    if path then
      heroImg = CCSprite:create(path)
    end
    if bgPath then
      heroBgImg = CCSprite:create(bgPath)
    end
  elseif itemType == "FRAGMENT" or itemType == rewardType.FRAGMENT then
    local itemInfo = KFDBGetRecord("ItemConfig", heroBaseId)
    heroBgImg = Logic:Get("Compose"):GetItemsFrame(tonumber(itemInfo.quality))
    heroImg = Logic:Get("Compose"):GetFraImg(heroBaseId)
    fra = Logic:Get("Compose"):GetJigsawImg()
  elseif itemType == "CURRENCY" or itemType == rewardType.CURRENCY then
    if heroBaseId + 1 < #moneyImg then
      heroImg = CCSprite:create(moneyImg[heroBaseId + 1])
    end
  elseif itemType == "EXP" or itemType == rewardType.EXP then
    heroImg = CCSprite:create("images/Other/action.png")
  elseif itemType == "DEMOG_FEAT" or itemType == rewardType.DEMOG_FEAT then
    heroImg = CCSprite:create("images/Other/gift.png")
    heroBgImg = Logic:Get("Compose"):GetItemsFrame(3)
  elseif itemType == "DEMOG_FRAGMENT" or itemType == rewardType.DEMOG_FRAGMENT then
    heroImg = CCSprite:create("images/Other/devilFrag.png")
    heroBgImg = Logic:Get("Compose"):GetItemsFrame(4)
  elseif itemType == "DEMOG_ENERGY" or itemType == rewardType.DEMOG_ENERGY then
    heroImg = CCSprite:create("images/Other/gift.png")
    heroBgImg = Logic:Get("Compose"):GetItemsFrame(4)
  elseif itemType == "SOUL_STONE" or itemType == rewardType.SOUL_STONE then
    local path = ""
    if heroBaseId == 0 then
      path = "images/Other/soul_stone.png"
    elseif heroBaseId > 0 then
      path = string.format("images/Other/soulStone%s.png", heroBaseId)
    end
    heroImg = CCSprite:create(path)
    heroBgImg = Logic:Get("Compose"):GetItemsFrame(4)
  else
    heroImg = CCSprite:create("images/Other/gift.png")
    heroBgImg = Logic:Get("Compose"):GetItemsFrame(4)
  end
  if heroImg then
    self.imgGood:setVisible(true)
    self.imgGood:setDisplayFrame(heroImg:displayFrame())
  end
  if heroBgImg then
    self.imgSystem:setVisible(true)
    self.imgSystem:setDisplayFrame(heroBgImg:displayFrame())
  end
  if fra then
    self.imgFra:setVisible(true)
    self.imgFra:setDisplayFrame(fra:displayFrame())
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.imgGood, heroBaseId, nil, itemType == "FRAGMENT" or itemType == rewardType.FRAGMENT)
end
