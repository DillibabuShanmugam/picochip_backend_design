# {left bottom right top}
create_keepout_margin -type hard -outer {20 20 20 20} [get_cells -filter is_hard_macro==true]
set_placement_status fixed [get_cells -filter is_hard_macro==true]

# fix the RO TRNG cells:
#set_placement_status fixed [get_cell picosocInst_ro_trng/rocell_1]
#set_placement_status fixed [get_cell picosocInst_ro_trng/rocell_2]
#set_placement_status fixed [get_cell picosocInst_ro_trng/rocell_3]

# placement blockage near digital and analog pads:
source rm_setup/panteaScripts/create_blockage.tcl
