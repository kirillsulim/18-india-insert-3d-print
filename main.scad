include <vendor/boardgame_insert_toolkit_lib.2.scad>;

rad = 12;

walls = 1.2;
/*
cmp_x = 5;
cmp_y = 4;

box_x = 180;
box_y = 120;
box_z = 22;

data = [[
  "tokens",
  [
    [ BOX_SIZE_XYZ, [box_x, box_y, box_z] ],
    [ BOX_STACKABLE_B, true ],
    [ BOX_COMPONENT,
      [
        [ CMP_SHAPE, FILLET],     
        [ CMP_NUM_COMPARTMENTS_XY, [cmp_x, cmp_y] ],
        [ CMP_COMPARTMENT_SIZE_XYZ, [ 
          (box_x - walls * (cmp_x + 1)) / cmp_x, 
          (box_y - walls * (cmp_y + 1)) / cmp_y, 
          (box_z - walls),
        ]],
      ]
    ],
    [BOX_LID, [
      [LID_PATTERN_RADIUS, rad],
      [ LID_PATTERN_N1, 6 ],
      [ LID_PATTERN_N2, 3 ],
      [ LID_PATTERN_ANGLE, 60],
      [ LID_PATTERN_ROW_OFFSET, 10],
      [ LID_PATTERN_COL_OFFSET, 150],
      [ LID_PATTERN_THICKNESS, 1],
      [ LID_INSET_B, true],
      [ LID_NOTCHES_B, true],
    ]]
  ]
]];*/

cmp_x = 1;
cmp_y = 1;

box_x = 112;
box_y = 45;
box_z = 21 - 4;

data = [[
  "what",
  [
    [ BOX_SIZE_XYZ, [box_x, box_y, box_z] ],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET],
        [ CMP_COMPARTMENT_SIZE_XYZ, [ 
          55, 
          (box_y - walls * 2), 
          (box_z - walls),
        ]],
        [POSITION_XY, [walls, CENTER]],
      ],
    ],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET],     
        [ CMP_COMPARTMENT_SIZE_XYZ, [ 
          25, 
          (box_y - walls * 2), 
          (box_z - walls),
        ]],
        [POSITION_XY, [walls * 2 + 55, CENTER]],
      ], 
    ],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET],     
        [ CMP_COMPARTMENT_SIZE_XYZ, [ 
          box_x - (walls * 3 + 55 + 25) - walls * 3, 
          (box_y - walls * 2), 
          (box_z - walls),
        ]],
        [POSITION_XY, [walls * 3 + 55 + 25, CENTER]],
      ], 
    ],
    [BOX_LID, [
      [LID_PATTERN_RADIUS, rad],
      [ LID_PATTERN_N1, 6 ],
      [ LID_PATTERN_N2, 3 ],
      [ LID_PATTERN_ANGLE, 60],
      [ LID_PATTERN_ROW_OFFSET, 10],
      [ LID_PATTERN_COL_OFFSET, 150],
      [ LID_PATTERN_THICKNESS, 1],
      [ LID_INSET_B, true],
      [ LID_NOTCHES_B, true],
    ]]
  ]
]];

MakeAll(); 