if {$MV_AES} {
    source rm_setup/panteaScripts/pad_cells_MV.tcl
} else {
    source rm_setup/panteaScripts/pad_cells.tcl
}

# extra spi master output pads for easier wire bonding
#source rm_setup/panteaScripts/extra_spimaster_pads.tcl

# power cut cells:
#create_cell prcut_bottom_left PRCUTA
#create_cell prcut_bottom_right PRCUTA

# analog io power:
#create_net -power TAVDD 
#create_net -ground AVSS

#create_cell a_vdd_bottom $io_analog_vdd_pad 
#connect_net TAVDD a_vdd_bottom/TAVDD

#create_cell a_vss_bottom $io_analog_vss_pad
#connect_net AVSS a_vss_bottom/AVSS

# analog pad fillers:
#create_cell a_filler_11 PFILLER20A
#create_cell a_filler_12 PFILLER20A
#create_cell a_filler_13 PFILLER20A
#create_cell a_filler_14 PFILLER20A
#create_cell a_filler_21 PFILLER20A
#create_cell a_filler_22 PFILLER20A
#create_cell a_filler_23 PFILLER20A
#create_cell a_filler_24 PFILLER20A
#create_cell a_filler_31 PFILLER20A
#create_cell a_filler_32 PFILLER20A
#create_cell a_filler_33 PFILLER20A
#create_cell a_filler_34 PFILLER20A
#create_cell a_filler_41 PFILLER20A
#create_cell a_filler_42 PFILLER20A
#create_cell a_filler_43 PFILLER20A
#create_cell a_filler_44 PFILLER20A
