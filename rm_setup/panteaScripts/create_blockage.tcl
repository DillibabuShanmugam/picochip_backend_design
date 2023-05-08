#new set prcut1_coord [get_attribute [get_cell prcut_bottom_left] bbox]
#new set prcut2_coord [get_attribute [get_cell prcut_bottom_right] bbox]

set digital_pad_bbox [get_attribute [get_lib_cell $pad_lib/$core_vdd_pad] bbox]
set digital_pad_height [expr [lindex $digital_pad_bbox 1 1] - [lindex $digital_pad_bbox 0 1]]

#new set anlg_pad_blockage_llx [lindex $prcut1_coord 0 0]
#new set anlg_pad_blockage_lly [lindex $prcut1_coord 1 1]
#new set anlg_pad_blockage_urx [lindex $prcut2_coord 1 0]
#new set anlg_pad_blockage_ury $digital_pad_height

# blockage close to analog pads:
#new create_placement_blockage -boundary [list [list $anlg_pad_blockage_llx $anlg_pad_blockage_lly] [list $anlg_pad_blockage_urx $anlg_pad_blockage_ury]] -type hard

#set ram_leftMaxX [lindex [get_attribute [get_cell -hier *RAM_blk01] bbox] 1 0]
#set ram_rightMinX [lindex [get_attribute [get_cell -hier *RAM_blk02] bbox] 0 0]
set blockage_margin 20
set chip_width 3000
set chip_height 5000
set seal_ring 30
set bond_pad_height 84 
set core_height [expr $chip_height - 2*$seal_ring - 2*$bond_pad_height] 
set core_width [expr $chip_width - $seal_ring - 2*$bond_pad_height]

# blockage close to digital pads:
# bottom:
#create_placement_blockage -boundary [list [list $ram_leftMaxX $digital_pad_height] [list $ram_rightMinX [expr $digital_pad_height + $blockage_margin]]] -type hard
# top:
#create_placement_blockage -boundary [list [list $ram_leftMaxX [expr $core_height - $digital_pad_height - $blockage_margin]] [list $ram_rightMinX [expr $digital_pad_height + $blockage_margin]]] -type hard
# left:
#create_placement_blockage -boundary [list [list $ram_leftMaxX $digital_pad_height] [list $ram_rightMinX [expr $digital_pad_height + $blockage_margin]]] -type hard
# bottom:
create_placement_blockage -boundary [list [list $digital_pad_height $digital_pad_height] [list [expr $core_width - $digital_pad_height] [expr $digital_pad_height + $blockage_margin]]] -type hard
# left:
create_placement_blockage -boundary [list [list $digital_pad_height $digital_pad_height] [list [expr $digital_pad_height + $blockage_margin] [expr $core_height - $digital_pad_height]]] -type hard
# top:
create_placement_blockage -boundary [list [list $digital_pad_height [expr $core_height - $digital_pad_height - $blockage_margin]] [list [expr $core_width - $digital_pad_height] [expr $core_height - $digital_pad_height]]] -type hard
# right:
create_placement_blockage -boundary [list [list [expr $core_width - $digital_pad_height - $blockage_margin] $digital_pad_height] [list [expr $core_width - $digital_pad_height] [expr $core_height - $digital_pad_height]]] -type hard
