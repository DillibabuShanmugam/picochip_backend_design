# place bonding pads
source rm_setup/panteaScripts/bonding_pad_placement.tcl

# place tapcells
create_tap_cells -lib_cell [get_lib_cell std_cell_lib_frame/TAPCELLBWP7T] -distance 55
