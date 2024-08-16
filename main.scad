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

// Card box
cb_box = [78, 182, 59];
cb_box_angle = 30;
cb_box_cmp_z = cb_box.z - walls;
cb_box_cmp = [
    70,
    cb_box.y - 2 * walls - cb_box_cmp_z * tan(cb_box_angle),
    cb_box_cmp_z,
];
cb = ["cards",[
    [ BOX_SIZE_XYZ, cb_box],
    [ BOX_NO_LID_B, true],
    [ BOX_COMPONENT, [
        [CMP_COMPARTMENT_SIZE_XYZ, cb_box_cmp],
        [CMP_SHEAR, [0, cb_box_angle]],
        [CMP_CUTOUT_SIDES_4B, [true, true, false, false]],
        [CMP_CUTOUT_DEPTH_PCT, 20],
        [CMP_CUTOUT_WIDTH_PCT, 50],
        [CMP_CUTOUT_TYPE, BOTH],
        [CMP_CUTOUT_HEIGHT_PCT, 100],                    
        //[POSITION_XY, [CENTER, - cb_box_cmp.z * tan(cb_box_angle)]],
        //[CMP_MARGIN_FBLR,               [0,0,0,0]],
        
        //[CMP_CUTOUT_SIDES_4B,           [tff,f]],
        //[CMP_CUTOUT_DEPTH_PCT,          30],
        //[CMP_CUTOUT_WIDTH_PCT,          50],
        //
     ]], 
     [ BOX_COMPONENT, [
        [CMP_COMPARTMENT_SIZE_XYZ, [cb_box_cmp.x, 50, cb_box_cmp.z]],
        [POSITION_XY, [CENTER, -10]],
        [CMP_CUTOUT_SIDES_4B, [true, false, false, false]],
     ]], 
     [ BOX_COMPONENT, [
        [CMP_COMPARTMENT_SIZE_XYZ, [cb_box_cmp.x + 4, 2, cb_box_cmp.z]],
        [CMP_SHEAR, [0, cb_box_angle]],
        [CMP_NUM_COMPARTMENTS_XY, [ 1, 45]],
        [POSITION_XY, [CENTER, cb_box_cmp_z * tan(cb_box_angle) / 2]],
     ]], 
]];
// Card box dividers
cbd_text = [
    "Players",
    "Guaranty",
    "Bonds",
    "Regions",
    "Trains",
    "Dir. Shares",
    "Shares",
];
cbd_size = [cb_box_cmp.x + 3.5, 48];
cbd = ["Card box dividers", [
    [ TYPE, DIVIDERS ],
    [ DIV_TAB_TEXT, cbd_text],
    [ DIV_TAB_CYCLE, len(cbd_text)],
    [ DIV_FRAME_NUM_COLUMNS, 2],
    [ DIV_FRAME_SIZE_XY, cbd_size],
    [ DIV_THICKNESS, 0.8 ],
    //[ DIV_TAB_TEXT_SIZE, 5],
    [ DIV_TAB_TEXT_FONT, "Black Ops One:style=Regular"],
    //[ DIV_TAB_SIZE_XY, [cbd_size.x / 3, 8]],
    //[ DIV_TAB_RADIUS, 2],
]];

// Player & company mats
pcm_box = [218 , 112, 14];
pcm = ["Player & company mats", [
    [ BOX_NO_LID_B, true],
    [ BOX_SIZE_XYZ, [pcm_box.x, pcm_box.y, pcm_box.z]],
    [ BOX_COMPONENT, [
        [ CMP_COMPARTMENT_SIZE_XYZ, [ 
            (pcm_box.x - walls * 2), 
            (pcm_box.y - walls * 2), 
            (pcm_box.z - walls),
        ]],
    ]],
    [ BOX_COMPONENT, [
        [ CMP_COMPARTMENT_SIZE_XYZ, [ 
            14, 
            14, 
            pcm_box.z + 100,
        ]],
        [CMP_SHAPE, SQUARE],
        [CMP_NUM_COMPARTMENTS_XY, [12, 6]],
        [CMP_SHAPE_ROTATED_B, true],
        [CMP_PADDING_XY, [3, 3]],
        [CMP_CUTOUT_BOTTOM_B, true],
        
    ]],
]];

// Money tray (2 pc.)
mt_box = [180 /* add 2*/, 120, 17];
   
mt = [ "Money tray", [
    [ BOX_NO_LID_B, true],
    [ BOX_SIZE_XYZ, [mt_box.x, mt_box.y, mt_box.z] ],
    [ BOX_STACKABLE_B, true ],
    [ LID_CUTOUT_SIDES_4B, [false, false, false, false] ],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET ],
        [ CMP_FILLET_RADIUS, 5 ],
        [ CMP_SHAPE_ROTATED_B, true],
        [ CMP_NUM_COMPARTMENTS_XY, [3, 1] ],
        [ CMP_COMPARTMENT_SIZE_XYZ, [55, 112, mt_box.z]],
        [ CMP_PADDING_XY, [4, 7]],
        [ CMP_CUTOUT_SIDES_4B, [ true, true, false, false ] ],
        [ CMP_CUTOUT_DEPTH_PCT, 20],
    ]],
]];

// Utility box
ub_box = [182, 59, 20 - lid_down_space];
ub = [ "Utility box", [
    [ BOX_SIZE_XYZ, [ub_box.x, ub_box.y, ub_box.z] ],
    [ BOX_STACKABLE_B, true ],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET],     
        [ CMP_COMPARTMENT_SIZE_XYZ, [ 
            (ub_box.x - walls * 4), 
            (ub_box.y - walls * 4), 
            (ub_box.z - walls),
        ]],
    ]],
    default_lid,
]];


data = [
    //ctb,
    //pmr,
    //tb4,
    //tb2,
    //cb,
    //cbd,
    //pcm,
    //mt,
    ub,
];

MakeAll();
