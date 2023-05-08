set chip_width 3000
set chip_height 5000
set seal_ring 30
set bond_pad_height 84 

rotate_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk00] -orient S
move_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk00] -to {260 260}
#move_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk00] -to {210 210}
rotate_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk01] -orient S
move_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk01] -to {690 260} 
#move_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk01] -to {650 210} 
rotate_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk02] -orient S
move_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk02] -to [list [expr 1920 - $seal_ring - 2*$bond_pad_height] 260]
#move_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk02] -to {1910 260}
rotate_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk03] -orient S
move_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk03] -to [list [expr 2350 - $seal_ring - 2*$bond_pad_height] 260]
#move_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk03] -to {2350 260}
rotate_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk10] -orient N
move_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk10] -to [list 260 [expr 3020 - 2*$seal_ring - 2*$bond_pad_height]]
#move_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk10] -to {260 3020}
rotate_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk11] -orient N
move_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk11] -to [list 690 [expr 3020 - 2*$seal_ring - 2*$bond_pad_height]]
#move_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk11] -to {700 3020}
rotate_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk12] -orient N
move_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk12] -to [list [expr 1920 - $seal_ring - 2*$bond_pad_height] [expr 3020 - 2*$seal_ring - 2*$bond_pad_height]]
#move_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk12] -to {1910 3020}
rotate_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk13] -orient N
move_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk13] -to [list [expr 2350 - $seal_ring - 2*$bond_pad_height] [expr 3020 - 2*$seal_ring - 2*$bond_pad_height]]
#move_objects [get_cell picosocInst_genblk1_ocram_controller_RAM_blk13] -to {2350 3020}

# fixing voltage areas:
#remove_voltage_area_shapes VOLTAGE_AREA_SHAPE_1
#create_voltage_area -power_domains PD_AES -region {{240 2200} {1300 2800}} -guard_band {{1 1}}
#create_voltage_area_shape -voltage_area PD_AES -region {{240 2200} {1300 2800}} -guard_band {1 1}


# fixing TRNG RO placement:
#move_objects [get_cell picosocInst_ro_trng/rocell_1] -to [list [expr 1530 - $seal_ring/2 - $bond_pad_height] 230]
#move_objects [get_cell picosocInst_ro_trng/rocell_2] -to [list 230 [expr 2525 - $seal_ring - $bond_pad_height]]
#move_objects [get_cell picosocInst_ro_trng/rocell_3] -to [list [expr 1530 - $seal_ring/2 - $bond_pad_height] [expr 4755 - 2*$seal_ring - 2*$bond_pad_height]]

# set ro sensor place:
source rm_setup/panteaScripts/ro_sensor_placement.tcl
