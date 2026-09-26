module((...), package.seeall)
MAP_OBJ_TYPE = Enum({
  "UNKNOWN",
  "ROLE",
  "ANIMATION"
})
ROLE_TYPE = {
  UNKNOW = bit.lshift(1, 0),
  HERO = bit.lshift(1, 1),
  PLAYER = bit.lshift(1, 2),
  NPC = bit.lshift(1, 3),
  MONSTER = bit.lshift(1, 4),
  DRAMAROLE = bit.lshift(1, 5),
  PICKBOX = bit.lshift(1, 6),
  BATTLEPOINT = bit.lshift(1, 7)
}
STAND_TYPE = Enum({"STAND", "FSTAND"})
MOVE_STYLE_TYPE = Enum({
  "X2Begin",
  "Y2Begin",
  "Line",
  "X2World",
  "Y2World",
  "AROUND_E"
})
MAP_CELL_TYPE = {
  CELL_TYPE_MASK = 1,
  CELL_TYPE_ROAD = 2,
  CELL_TYPE_ALPHA = 3
}
DFT_MAX_CLICK_DIS_TO_TARGET = 48
MAX_CLICK_DIS_IN_H_BMAP = 1440
