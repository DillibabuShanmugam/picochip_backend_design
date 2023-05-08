#========================================#
## Script : pad_constraints.tcl
##========================================#

####### VSS and VDD IO rings
#create_io_ring -name vss_ring -corner_height 300
#get_io_rings
#get_io_guides
#create_io_ring -name vdd_ring -inside vss_ring -offset 50
#create_io_ring -name inner_ring -inside outer_ring -offset 50
create_io_ring -name outer_pad_ring 

###### corner pads:
# of io guides matter for their orientation
create_io_corner_cell -cell cornerll {outer_pad_ring.bottom outer_pad_ring.left}
create_io_corner_cell -cell cornerul {outer_pad_ring.left outer_pad_ring.top}
create_io_corner_cell -cell cornerur {outer_pad_ring.top outer_pad_ring.right}
create_io_corner_cell -cell cornerlr {outer_pad_ring.right outer_pad_ring.bottom}

##### pg pads:
add_to_io_guide outer_pad_ring.right {vss1right vss2right vss3right vdd1right vdd2right vdd3right}
add_to_io_guide outer_pad_ring.left {vss1left vss2left vss3left vdd1left vdd2left vdd3left}
add_to_io_guide outer_pad_ring.top {vss1top vss2top vss3top vdd1top vdd2top vdd3top}
add_to_io_guide outer_pad_ring.bottom {vss1bottom vss2bottom vss3bottom vdd1bottom vdd2bottom vdd3bottom vddpoc}

##### pads on right:
# assign pads to a guide:
add_to_io_guide outer_pad_ring.right {{padsInst_spi_clk0_pad/genblk1_outpadTech} {padsInst_spi_miso0_pad/genblk1_inpadTech} {padsInst_spi_mosi0_pad/genblk1_outpadTech} {padsInst_spi_csn0_pad/genblk1_outpadTech} {padsInst_spi_clk1_pad/genblk1_outpadTech} {padsInst_spi_miso1_pad/genblk1_inpadTech} {padsInst_spi_mosi1_pad/genblk1_outpadTech} {padsInst_spi_csn1_pad/genblk1_outpadTech} {padsInst_spi_clk2_pad/genblk1_outpadTech} {padsInst_spi_miso2_pad/genblk1_inpadTech} {padsInst_spi_mosi2_pad/genblk1_outpadTech} {padsInst_spi_csn2_pad/genblk1_outpadTech} {padsInst_spi_clk3_pad/genblk1_outpadTech} {padsInst_spi_miso3_pad/genblk1_inpadTech} {padsInst_spi_mosi3_pad/genblk1_outpadTech} {padsInst_spi_csn3_pad/genblk1_outpadTech} {padsInst_ro_trng_ro_stream_pad/genblk1_inpadTech}}
# set the order of pads:
set_signal_io_constraints -io_guide_object outer_pad_ring.right -constraint {{vdd3right} {vss3right} {padsInst_ro_trng_ro_stream_pad/genblk1_inpadTech} {vdd2right} {vss2right} {padsInst_spi_clk0_pad/genblk1_outpadTech} {padsInst_spi_miso0_pad/genblk1_inpadTech} {padsInst_spi_mosi0_pad/genblk1_outpadTech} {padsInst_spi_csn0_pad/genblk1_outpadTech} {padsInst_spi_clk1_pad/genblk1_outpadTech} {padsInst_spi_miso1_pad/genblk1_inpadTech} {padsInst_spi_mosi1_pad/genblk1_outpadTech} {padsInst_spi_csn1_pad/genblk1_outpadTech} {padsInst_spi_clk2_pad/genblk1_outpadTech} {padsInst_spi_miso2_pad/genblk1_inpadTech} {padsInst_spi_mosi2_pad/genblk1_outpadTech} {padsInst_spi_csn2_pad/genblk1_outpadTech} {padsInst_spi_clk3_pad/genblk1_outpadTech} {padsInst_spi_miso3_pad/genblk1_inpadTech} {padsInst_spi_mosi3_pad/genblk1_outpadTech} {padsInst_spi_csn3_pad/genblk1_outpadTech} {vdd1right} {vss1right}}

##### pads on bottom:
# assign pads to a guide:
add_to_io_guide outer_pad_ring.bottom {{padsInst_ser_rx_pad/genblk1_inpadTech} {padsInst_ser_tx_pad/genblk1_outpadTech} {padsInst_ro_trng_trng_pad/genblk1_inpadTech}}
#new add_to_io_guide outer_pad_ring.bottom {{padsInst_ser_rx_pad/genblk1_inpadTech} {padsInst_ser_tx_pad/genblk1_outpadTech} {prcut_bottom_right} {a_vdd_bottom} {padsInst_ro_trng_vsh2_pad/genblk1_a_iopadTech} {padsInst_ro_trng_vsh1_pad/genblk1_a_iopadTech} {padsInst_ro_trng_ro_vdd_pad/genblk1_a_iopadTech} {a_vss_bottom} {prcut_bottom_left} {padsInst_ro_trng_trng_pad/genblk1_inpadTech}}
#add_to_io_guide outer_pad_ring.bottom {{padsInst_ro_countermeasure_mux_spi_clk_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_mux_spi_miso_pad/genblk1_outpadTech} {padsInst_ro_countermeasure_mux_spi_mosi_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_mux_spi_csn_pad/genblk1_inpadTech} {padsInst_ser_rx_pad/genblk1_inpadTech} {padsInst_ser_tx_pad/genblk1_outpadTech} {prcut_bottom_right} {a_vdd_bottom} {padsInst_ro_trng_vsh2_pad/genblk1_a_iopadTech} {padsInst_ro_trng_vsh1_pad/genblk1_a_iopadTech} {padsInst_ro_trng_ro_vdd_pad/genblk1_a_iopadTech} {a_vss_bottom} {prcut_bottom_left} {padsInst_ro_trng_trng_pad/genblk1_inpadTech}}
# set the order of pads: (analog pads abutted)
set_signal_io_constraints -io_guide_object outer_pad_ring.bottom -constraint {{vdd3bottom} {vss3bottom} {vddpoc} {vdd2bottom} {vss2bottom} {padsInst_ser_rx_pad/genblk1_inpadTech} {padsInst_ser_tx_pad/genblk1_outpadTech} {padsInst_ro_trng_trng_pad/genblk1_inpadTech} {vdd1bottom} {vss1bottom}}
#new set_signal_io_constraints -io_guide_object outer_pad_ring.bottom -constraint {{vdd3bottom} {vss3bottom} {vdd2bottom} {vss2bottom} {padsInst_ser_rx_pad/genblk1_inpadTech} {padsInst_ser_tx_pad/genblk1_outpadTech} {prcut_bottom_right a_vdd_bottom a_filler_11 a_filler_12 a_filler_13 a_filler_14 padsInst_ro_trng_vsh2_pad/genblk1_a_iopadTech a_filler_21 a_filler_22 a_filler_23 a_filler_24 padsInst_ro_trng_vsh1_pad/genblk1_a_iopadTech a_filler_31 a_filler_32 a_filler_33 a_filler_34 padsInst_ro_trng_ro_vdd_pad/genblk1_a_iopadTech a_filler_41 a_filler_42 a_filler_43 a_filler_44 a_vss_bottom prcut_bottom_left} {padsInst_ro_trng_trng_pad/genblk1_inpadTech} {vdd1bottom} {vss1bottom}}
#set_signal_io_constraints -io_guide_object outer_pad_ring.bottom -constraint {{vdd3bottom} {vss3bottom} {padsInst_ro_countermeasure_mux_spi_clk_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_mux_spi_miso_pad/genblk1_outpadTech} {padsInst_ro_countermeasure_mux_spi_mosi_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_mux_spi_csn_pad/genblk1_inpadTech} {vdd2bottom} {vss2bottom} {padsInst_ser_rx_pad/genblk1_inpadTech} {padsInst_ser_tx_pad/genblk1_outpadTech} {prcut_bottom_right a_vdd_bottom a_filler_11 a_filler_12 a_filler_13 a_filler_14 padsInst_ro_trng_vsh2_pad/genblk1_a_iopadTech a_filler_21 a_filler_22 a_filler_23 a_filler_24 padsInst_ro_trng_vsh1_pad/genblk1_a_iopadTech a_filler_31 a_filler_32 a_filler_33 a_filler_34 padsInst_ro_trng_ro_vdd_pad/genblk1_a_iopadTech a_filler_41 a_filler_42 a_filler_43 a_filler_44 a_vss_bottom prcut_bottom_left} {padsInst_ro_trng_trng_pad/genblk1_inpadTech} {vdd1bottom} {vss1bottom}}
#set_signal_io_constraints -io_guide_object outer_pad_ring.bottom -constraint {{vdd3bottom} {vss3bottom} {padsInst_ro_countermeasure_spi_clk_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_spi_miso_pad/genblk1_outpadTech} {padsInst_ro_countermeasure_spi_mosi_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_spi_csn_pad/genblk1_inpadTech} {vdd2bottom} {vss2bottom} {padsInst_ser_rx_pad/genblk1_inpadTech} {padsInst_ser_tx_pad/genblk1_outpadTech} {prcut_bottom_right a_vdd_bottom padsInst_ro_trng_vsh2_pad/genblk1_a_iopadTech padsInst_ro_trng_vsh1_pad/genblk1_a_iopadTech padsInst_ro_trng_ro_vdd_pad/genblk1_a_iopadTech a_vss_bottom prcut_bottom_left} {padsInst_ro_trng_trng_pad/genblk1_inpadTech} {vdd1bottom} {vss1bottom}}


##### pads on left:
# assign pads to a guide:
add_to_io_guide outer_pad_ring.left {{padsInst_ro_countermeasure_mux_spi_clk_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_mux_spi_miso_pad/genblk1_outpadTech} {padsInst_ro_countermeasure_mux_spi_mosi_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_mux_spi_csn_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_tri_spi_clk_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_tri_spi_miso_pad/genblk1_outpadTech} {padsInst_ro_countermeasure_tri_spi_mosi_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_tri_spi_csn_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_out_single_mux_pad/genblk1_outpadTech} {padsInst_ro_countermeasure_out_single_tri_pad/genblk1_outpadTech} {padsInst_clk_pad/genblk1_inpadTech} {padsInst_gpio_7_pad/genblk1_iopadTech} {padsInst_gpio_6_pad/genblk1_iopadTech} {padsInst_gpio_5_pad/genblk1_iopadTech} {padsInst_gpio_4_pad/genblk1_iopadTech} {padsInst_gpio_3_pad/genblk1_iopadTech} {padsInst_gpio_2_pad/genblk1_iopadTech} {padsInst_gpio_1_pad/genblk1_iopadTech} {padsInst_gpio_0_pad/genblk1_iopadTech}}
#add_to_io_guide outer_pad_ring.left {{padsInst_ro_countermeasure_tri_spi_clk_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_tri_spi_miso_pad/genblk1_outpadTech} {padsInst_ro_countermeasure_tri_spi_mosi_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_tri_spi_csn_pad/genblk1_inpadTech} {padsInst_gpio_15_pad/genblk1_iopadTech} {padsInst_gpio_14_pad/genblk1_iopadTech} {padsInst_gpio_13_pad/genblk1_iopadTech} {padsInst_gpio_12_pad/genblk1_iopadTech} {padsInst_gpio_11_pad/genblk1_iopadTech} {padsInst_gpio_10_pad/genblk1_iopadTech} {padsInst_gpio_9_pad/genblk1_iopadTech} {padsInst_gpio_8_pad/genblk1_iopadTech} {padsInst_ro_countermeasure_out_single_mux_pad/genblk1_outpadTech} {padsInst_ro_countermeasure_out_single_tri_pad/genblk1_outpadTech} {padsInst_gpio_7_pad/genblk1_iopadTech} {padsInst_gpio_6_pad/genblk1_iopadTech} {padsInst_gpio_5_pad/genblk1_iopadTech} {padsInst_gpio_4_pad/genblk1_iopadTech} {padsInst_gpio_3_pad/genblk1_iopadTech} {padsInst_gpio_2_pad/genblk1_iopadTech} {padsInst_gpio_1_pad/genblk1_iopadTech} {padsInst_gpio_0_pad/genblk1_iopadTech}}
# set the order of pads:
set_signal_io_constraints -io_guide_object outer_pad_ring.left -constraint {{vdd3left} {vss3left} {padsInst_ro_countermeasure_mux_spi_clk_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_mux_spi_miso_pad/genblk1_outpadTech} {padsInst_ro_countermeasure_mux_spi_mosi_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_mux_spi_csn_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_tri_spi_clk_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_tri_spi_miso_pad/genblk1_outpadTech} {padsInst_ro_countermeasure_tri_spi_mosi_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_tri_spi_csn_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_out_single_mux_pad/genblk1_outpadTech} {padsInst_ro_countermeasure_out_single_tri_pad/genblk1_outpadTech} {vdd2left} {padsInst_clk_pad/genblk1_inpadTech} {vss2left} {padsInst_gpio_7_pad/genblk1_iopadTech} {padsInst_gpio_6_pad/genblk1_iopadTech} {padsInst_gpio_5_pad/genblk1_iopadTech} {padsInst_gpio_4_pad/genblk1_iopadTech} {padsInst_gpio_3_pad/genblk1_iopadTech} {padsInst_gpio_2_pad/genblk1_iopadTech} {padsInst_gpio_1_pad/genblk1_iopadTech} {padsInst_gpio_0_pad/genblk1_iopadTech} {vdd1left} {vss1left}}
#set_signal_io_constraints -io_guide_object outer_pad_ring.left -constraint {{vdd3left} {vss3left} {padsInst_gpio_15_pad/genblk1_iopadTech} {padsInst_gpio_14_pad/genblk1_iopadTech} {padsInst_gpio_13_pad/genblk1_iopadTech} {padsInst_gpio_12_pad/genblk1_iopadTech} {padsInst_gpio_11_pad/genblk1_iopadTech} {padsInst_gpio_10_pad/genblk1_iopadTech} {padsInst_gpio_9_pad/genblk1_iopadTech} {padsInst_gpio_8_pad/genblk1_iopadTech} {padsInst_ro_countermeasure_tri_spi_clk_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_tri_spi_miso_pad/genblk1_outpadTech} {padsInst_ro_countermeasure_tri_spi_mosi_pad/genblk1_inpadTech} {padsInst_ro_countermeasure_tri_spi_csn_pad/genblk1_inpadTech} {vdd2left} {vss2left} {padsInst_ro_countermeasure_out_single_mux_pad/genblk1_outpadTech} {padsInst_ro_countermeasure_out_single_tri_pad/genblk1_outpadTech} {padsInst_gpio_7_pad/genblk1_iopadTech} {padsInst_gpio_6_pad/genblk1_iopadTech} {padsInst_gpio_5_pad/genblk1_iopadTech} {padsInst_gpio_4_pad/genblk1_iopadTech} {padsInst_gpio_3_pad/genblk1_iopadTech} {padsInst_gpio_2_pad/genblk1_iopadTech} {padsInst_gpio_1_pad/genblk1_iopadTech} {padsInst_gpio_0_pad/genblk1_iopadTech} {vdd1left} {vss1left}}

##### pads on top:
# assign pads to a guide:
add_to_io_guide outer_pad_ring.top {{padsInst_reset_pad/genblk1_inpadTech} {padsInst_flash_clk_pad/genblk1_outpadTech} {padsInst_flash_io0_pad/genblk1_iopadTech} {padsInst_flash_io1_pad/genblk1_iopadTech} {padsInst_flash_io2_pad/genblk1_iopadTech} {padsInst_flash_io3_pad/genblk1_iopadTech} {padsInst_flash_csb_pad/genblk1_outpadTech}}
# set the order of pads:
set_signal_io_constraints -io_guide_object outer_pad_ring.top -constraint {{vdd3top} {vss3top} {padsInst_reset_pad/genblk1_inpadTech} {vdd2top} {vss2top} {padsInst_flash_clk_pad/genblk1_outpadTech} {padsInst_flash_io0_pad/genblk1_iopadTech} {padsInst_flash_io1_pad/genblk1_iopadTech} {padsInst_flash_io2_pad/genblk1_iopadTech} {padsInst_flash_io3_pad/genblk1_iopadTech} {padsInst_flash_csb_pad/genblk1_outpadTech} {vdd1top} {vss1top}}

#set_signal_io_constraints -io_guide_object [get_io_guides "outer_pad_ring*right"] -constraint {[get_cell -hier "*spi_clk_pad"] [get_cell -hier "*spi_miso_pad"] [get_cell -hier *spi_mosi_pad] [get_cell -hier *spi_csn0_pad] [get_cell -hier *spi_csn1_pad] [get_cell -hier *spi_csn2_pad] [get_cell -hier *spi_csn3_pad]}

####### assign vdd and vss pads to their rings
#set_power_io_constraints -io_guide_object [get_io_guides "outer_pad_ring*left"] {{reference: $core_vdd_pad} {offset: 100}}
#set_power_io_constraints -io_guide_object [get_io_guides "outer_pad_ring*top"] {{reference: $core_vdd_pad} {offset: 100}}
#set_power_io_constraints -io_guide_object [get_io_guides "outer_pad_ring*right"] {{reference: $core_vdd_pad} {offset: 100}}
#set_power_io_constraints -io_guide_object [get_io_guides "outer_pad_ring*bottom"] {{reference: $core_vdd_pad} {offset: 100}}

#set_power_io_constraints -io_guide_object [get_io_guides "outer_pad_ring*"] {{reference: $core_vdd_pad} {offset: 100} {prefix: vdd1}}
#set_power_io_constraints -io_guide_object [get_io_guides "outer_pad_ring*"] {{reference: $core_vss_pad} {offset: 100} {prefix: vss1}}
#set_power_io_constraints -io_guide_object [get_io_guides "outer_pad_ring*"] {{reference: $io_vdd_pad} {offset: 100} {prefix: vdd2}}
#set_power_io_constraints -io_guide_object [get_io_guides "outer_pad_ring*"] {{reference: $io_vss_pad} {offset: 100} {prefix: vss2}}


#set_power_io_constraints -io_guide_object [get_io_guides "outer_pad_ring*"] {{reference: $core_vdd_pad} {ratio: 10} {prefix: vdd1}}
#set_power_io_constraints -io_guide_object [get_io_guides "outer_pad_ring*"] {{reference: $core_vss_pad} {ratio: 10} {prefix: vss1}}
#set_power_io_constraints -io_guide_object [get_io_guides "outer_pad_ring*"] {{reference: $io_vdd_pad} {ratio: 10} {prefix: vdd2}}
#set_power_io_constraints -io_guide_object [get_io_guides "outer_pad_ring*"] {{reference: $io_vss_pad} {ratio: 10} {prefix: vss2}}

#set_power_io_constraints -io_guide_object [get_io_guides "vss*left"] {{reference: $core_vdd_pad} {ratio: 10} {prefix: vddleft}}
#set_power_io_constraints -io_guide_object [get_io_guides "vss*right"] {{reference: $core_vdd_pad} {ratio: 10} {prefix: vddright}}
#set_power_io_constraints -io_guide_object [get_io_guides "vss*top"] {{reference: $core_vdd_pad} {ratio: 10} {prefix: vddtop}}
#set_power_io_constraints -io_guide_object [get_io_guides "vss*bottom"] {{reference: $core_vdd_pad} {ratio: 10} {prefix: vddbottom}}

#set_power_io_constraints -io_guide_object [get_io_guides "vss*left"] {{reference: $core_vss_pad} {ratio: 10} {prefix: vssleft}}
#set_power_io_constraints -io_guide_object [get_io_guides "vss*right"] {{reference: $core_vss_pad} {ratio: 10} {prefix: vssright}}
#set_power_io_constraints -io_guide_object [get_io_guides "vss*top"] {{reference: $core_vss_pad} {ratio: 10} {prefix: vsstop}}
#set_power_io_constraints -io_guide_object [get_io_guides "vss*bottom"] {{reference: $core_vss_pad} {ratio: 10} {prefix: vssbottom}}

place_io

###### filler pads:
create_io_filler_cells -prefix filler_ -reference_cells {{PFILLER0005 PFILLER05 PFILLER1 PFILLER5 PFILLER10 PFILLER20}}
#pk create_io_filler_cells -prefix filler_ -overlap_cells {{PFILLER0005 PFILLER05 PFILLER1 PFILLER5 PFILLER10 PFILLER20}}

##### check io placement:
check_io_placement

