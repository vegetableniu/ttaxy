module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype.RefreshHeros(A0_0, A1_1)
  local L2_2, L3_3, L4_4, L5_5
  L2_2 = A0_0.ttfTitleExp
  L3_3 = L2_2
  L2_2 = L2_2.setString
  L4_4 = TwGetStr
  L5_5 = 103116
  L5_5 = L4_4(L5_5)
  L2_2(L3_3, L4_4, L5_5, L4_4(L5_5))
  A0_0.hero = A1_1
  L2_2 = Logic
  L3_3 = L2_2
  L2_2 = L2_2.Get
  L4_4 = "Hero"
  L2_2 = L2_2(L3_3, L4_4)
  L3_3 = L2_2
  L2_2 = L2_2.GetHeroImage
  L4_4 = A1_1.baseId
  L2_2 = L2_2(L3_3, L4_4)
  if L2_2 then
    L3_3 = CCSprite
    L4_4 = L3_3
    L3_3 = L3_3.create
    L5_5 = L2_2
    L3_3 = L3_3(L4_4, L5_5)
    L4_4 = A0_0.sprTreaImg
    L5_5 = L4_4
    L4_4 = L4_4.setDisplayFrame
    L4_4(L5_5, L3_3:displayFrame())
  end
  L3_3 = Logic
  L4_4 = L3_3
  L3_3 = L3_3.Get
  L5_5 = "Hero"
  L3_3 = L3_3(L4_4, L5_5)
  L4_4 = L3_3
  L3_3 = L3_3.GetHeroBgImage
  L5_5 = A1_1.baseId
  L3_3 = L3_3(L4_4, L5_5)
  if L3_3 then
    L4_4 = CCSprite
    L5_5 = L4_4
    L4_4 = L4_4.create
    L4_4 = L4_4(L5_5, L3_3)
    L5_5 = A0_0.sprTreaBg
    L5_5 = L5_5.setDisplayFrame
    L5_5(L5_5, L4_4:displayFrame())
  end
  L4_4 = Logic
  L5_5 = L4_4
  L4_4 = L4_4.Get
  L4_4 = L4_4(L5_5, "Hero")
  L5_5 = L4_4
  L4_4 = L4_4.GetHeroInfoByBaseId
  L4_4 = L4_4(L5_5, A1_1.baseId)
  if L4_4 then
    L5_5 = A0_0.ttfName
    L5_5 = L5_5.setStyle
    L5_5(L5_5, kCCLabelTTFStyleOutline)
    L5_5 = A0_0.ttfTreaDes
    L5_5 = L5_5.setStyle
    L5_5(L5_5, kCCLabelTTFStyleOutline)
    L5_5 = A0_0.ttfExp
    L5_5 = L5_5.setStyle
    L5_5(L5_5, kCCLabelTTFStyleOutline)
    L5_5 = A0_0.ttfTitleExp
    L5_5 = L5_5.setStyle
    L5_5(L5_5, kCCLabelTTFStyleOutline)
    L5_5 = A0_0.ttfName
    L5_5 = L5_5.setString
    L5_5(L5_5, L4_4.name)
    L5_5 = A0_0.ttfTreaDes
    L5_5 = L5_5.setString
    L5_5(L5_5, TwGetStr(103051))
    L5_5 = A0_0.ttfExp
    L5_5 = L5_5.setString
    L5_5(L5_5, L4_4.baseExp)
    L5_5 = A0_0.ttfTip1
    L5_5 = L5_5.setStyle
    L5_5(L5_5, kCCLabelTTFStyleOutline)
    L5_5 = A0_0.ttfTip1
    L5_5 = L5_5.setString
    L5_5(L5_5, "")
  end
  L5_5 = Logic
  L5_5 = L5_5.Get
  L5_5 = L5_5(L5_5, "Treasure")
  L5_5 = L5_5.GetSeleTrea
  L5_5 = L5_5(L5_5)
  if L5_5[A1_1.id] then
    A0_0.meunItem:selected()
  else
    A0_0.meunItem:unselected()
  end
  for _FORV_10_, _FORV_11_ in pairs(L5_5) do
  end
  if 0 + 1 >= 6 and not L5_5[A1_1.id] or A1_1.boolSkill == 1 or A1_1.locked then
    A0_0.btnSelect:setEnabled(false)
    A0_0.meunItem:setEnabled(false)
    A0_0.meunItem:setVisible(true)
    if A1_1.boolSkill == 1 then
      A0_0.meunItem:setVisible(false)
      A0_0.ttfTip1:setStyle(kCCLabelTTFStyleOutline)
      A0_0.ttfTip1:setString(TwGetStr(103052))
    end
  else
    A0_0.btnSelect:setEnabled(true)
    A0_0.meunItem:setVisible(true)
  end
end
function prototype.onBtnSelect(A0_6)
  if Logic:Get("Guide"):isActive("SkillUpgrade", "SelectTreasure") then
    A0_6.btnHero:setEnabled(true)
    A0_6.meunItem:setEnabled(true)
    Logic:Get("Guide"):done("SkillUpgrade", "SelectTreasure")
  end
  A0_6:onMeunItem()
end
function prototype.onHeroImage(A0_7)
  Logic:Get("HeroCardInfo"):OpenHeroInfo(A0_7.hero)
end
function prototype.onMeunItem(A0_8)
  if A0_8.hero.locked or A0_8.hero.boolSkill == 1 then
    Prompt:Fail(TwGetStr(106028))
    return
  end
  if Logic:Get("Treasure"):GetSeleTrea()[A0_8.hero.id] then
    A0_8.meunItem:unselected()
    Logic:Get("Treasure"):SetTreaSele(A0_8.hero.id, nil)
  else
    A0_8.meunItem:selected()
    Logic:Get("Treasure"):SetTreaSele(A0_8.hero.id, true)
  end
  Logic:Get("Treasure"):FireEnvenConfig()
end
function prototype.updateGuide(A0_9)
  if Logic:Get("Guide"):isActive("SkillUpgrade", "SelectTreasure") then
    A0_9.btnHero:setEnabled(false)
    A0_9.meunItem:setEnabled(false)
    Logic:Get("Guide"):lockTouch(A0_9.btnSelect)
  end
end
