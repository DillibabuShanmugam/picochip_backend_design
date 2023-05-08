set chip_width 3000
set chip_height 5000
set seal_ring 30
set bond_pad_height 84 
initialize_floorplan -control_type die -side_length [list [expr $chip_width - $seal_ring - 2*$bond_pad_height] [expr $chip_height - 2*$seal_ring - 2*$bond_pad_height]]
