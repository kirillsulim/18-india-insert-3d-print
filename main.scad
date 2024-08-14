include <vendor/boardgame_insert_toolkit_lib.2.scad>;

lid_rad = 12;
walls = 1.2;

lid_down_space = 4;
lid_p_n1 = 6;
lid_p_n2 = 3;
lid_p_angle = 60;
lid_p_row_offset = 10;
lid_p_col_offset = 150;
lid_p_thick = 1;

default_lid = [BOX_LID, [
    [LID_PATTERN_RADIUS, lid_rad],
    [ LID_PATTERN_N1, lid_p_n1 ],
    [ LID_PATTERN_N2, lid_p_n2 ],
    [ LID_PATTERN_ANGLE, lid_p_angle],
    [ LID_PATTERN_ROW_OFFSET, lid_p_row_offset],
    [ LID_PATTERN_COL_OFFSET, lid_p_col_offset],
    [ LID_PATTERN_THICKNESS, lid_p_thick],
    [ LID_INSET_B, true],
    [ LID_NOTCHES_B, true],
]];


// Company token box
ctb_box = [182, 120, 26 - lid_down_space];
ctb_cmp = [5, 4];
   
ctb = [ "Company tokens box", [
    [ BOX_SIZE_XYZ, [ctb_box.x, ctb_box.y, ctb_box.z] ],
    [ BOX_STACKABLE_B, true ],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET],     
        [ CMP_NUM_COMPARTMENTS_XY, [ctb_cmp.x, ctb_cmp.y] ],
        [ CMP_COMPARTMENT_SIZE_XYZ, [ 
            (ctb_box.x - walls * (ctb_cmp.x + 1)) / ctb_cmp.x, 
            (ctb_box.y - walls * (ctb_cmp.y + 1)) / ctb_cmp.y, 
            (ctb_box.z - walls),
        ]],
    ]],
    default_lid,
]];

// Player markers and resource tokens box
pmr_box = [112, 45, 21 - lid_down_space];
pmr = ["Player markers and resource tokens box", [
    [ BOX_SIZE_XYZ, [pmr_box.x, pmr_box.y, pmr_box.z] ],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET],
        [ CMP_COMPARTMENT_SIZE_XYZ, [ 
          55, 
          (pmr_box.y - walls * 2), 
          (pmr_box.z - walls),
        ]],
        [POSITION_XY, [walls, CENTER]],
      ],
    ],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET],     
        [ CMP_COMPARTMENT_SIZE_XYZ, [ 
          25, 
          (pmr_box.y - walls * 2), 
          (pmr_box.z - walls),
        ]],
        [POSITION_XY, [walls * 2 + 55, CENTER]],
      ], 
    ],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET],     
        [ CMP_COMPARTMENT_SIZE_XYZ, [ 
          pmr_box.x - (walls * 3 + 55 + 25) - walls * 3, 
          (pmr_box.y - walls * 2), 
          (pmr_box.z - walls),
        ]],
        [POSITION_XY, [walls * 3 + 55 + 25, CENTER]],
      ], 
    ],
    default_lid,
  ]
];

/*
 * Tile box based on https://www.thingiverse.com/thing:4594612
 */
tb_rows = 4;
tb_cols = 6;
tb2_tile_depth = 2;
tb4_tile_depth = 4;
tb_pedestal = true;

//--------------
g_b_print_lid = t;
g_b_print_box = t; 
g_wall_thickness = 2;
g_tolerance = 0.15;
g_tolerance_detents_pos = 0.1;

hex_size_base = 32; // Measured
hex_size = [hex_size_base, ceil(hex_size_base * 0.8660254)-1];

function tile_box(tile_depth, add_lid) = [ "Tile box " + tile_depth, [
    [ BOX_SIZE_XYZ, [hex_size.y * tb_rows + 4, hex_size.x * tb_cols + 4, tile_depth * 2 + 2 + (tb_pedestal ? 2 : 0)] ],
    [ BOX_STACKABLE_B,   t ],
    [ BOX_NO_LID_B, !add_lid],
    [ BOX_LID, [               
        [ LID_PATTERN_RADIUS, 20],        
        [ LID_PATTERN_N1, lid_p_n1 ],
        [ LID_PATTERN_N2, lid_p_n2 ],
        [ LID_PATTERN_ANGLE, lid_p_angle],
        [ LID_PATTERN_ROW_OFFSET, lid_p_row_offset],
        [ LID_PATTERN_COL_OFFSET, lid_p_col_offset],
        [ LID_PATTERN_THICKNESS, lid_p_thick],

        [ LID_LABELS_BORDER_THICKNESS,  1.5 ],
        [ LID_LABELS_BG_THICKNESS,      5 ],
        [ LABEL, [
            [ LBL_TEXT,     "18 India"],
            [ LBL_SIZE,     AUTO ],
            [ LBL_FONT,     "URW Bookman:style=Demi Italic"],
            [ ROTATION,     -60],
            [ POSITION_XY, [0, 0]]
        ]],                                   
    ]],
    [ BOX_COMPONENT, [
        [CMP_NUM_COMPARTMENTS_XY, [ tb_rows, tb_cols ]],
        [CMP_COMPARTMENT_SIZE_XYZ, [ hex_size.y, hex_size.x, tile_depth * 2 ]],
        [CMP_SHAPE, HEX],
        [CMP_SHAPE_VERTICAL_B, t],    
        [CMP_PADDING_XY, [0,0]],
        [CMP_PEDESTAL_BASE_B, tb_pedestal],
        [CMP_CUTOUT_CORNERS_4B, [t,t,t,t]],
        [CMP_CUTOUT_TYPE, INTERIOR],
    ]],
]];

// Tile box for 4 tiles stack (2 pc.) included lid (1 pc.)
tb4 = tile_box(4, true);

// Tile box for 2 tiles stack (2 pc.) without lid
tb2 = tile_box(2, false);



data = [
    //ctb,
    //pmr,
    //tb4,
    //tb2,
];

MakeAll(); 