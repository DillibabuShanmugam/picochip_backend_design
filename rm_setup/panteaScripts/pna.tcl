if {$MV_AES} {
    set VNAME VN1
    set GNAME GN1
} else {
    set VNAME VDD
    set GNAME VSS
}

source ./rm_setup/panteaScripts/parasitic_setup_file.tcl
source ./rm_setup/panteaScripts/parasitic_constraints_file.tcl
resolve_pg_nets
connect_pg_net -automatic

#set_virtual_pad -net VDD -coordinate {1000 1000}
#set_virtual_pad -net VSS -coordinate {1000 1000}
#analyze_power_plan -nets {VDD VSS} -power_budget 1000 -voltage 1.8 -pad_references {VDD:$core_vdd_pad VSS:$core_vss_pad}
if {$MV_AES} {
    analyze_power_plan -nets {VN2 GN2} -power_budget 1000 -voltage 1.8 -pad_references {VDD:$core_vdd_pad VSS:$core_vss_pad}
    analyze_power_plan -nets {VN1 GN1} -power_budget 1000 -voltage 1.8 -pad_references {VDD:$core_vdd_pad VSS:$core_vss_pad}
} else {
    set vdd1l_coor [lindex [get_attribute [get_cells vdd1left] bbox] 0]
    set_virtual_pad -net VDD -coordinate $vdd1l_coor
    set vdd2l_coor [lindex [get_attribute [get_cells vdd2left] bbox] 0]
    set_virtual_pad -net VDD -coordinate $vdd2l_coor
    set vdd1t_coor [lindex [get_attribute [get_cells vdd1top] bbox] 0]
    set_virtual_pad -net VDD -coordinate $vdd1t_coor
    set vdd2t_coor [lindex [get_attribute [get_cells vdd2top] bbox] 0]
    set_virtual_pad -net VDD -coordinate $vdd2t_coor
    set vdd1r_coor [lindex [get_attribute [get_cells vdd1right] bbox] 0]
    set_virtual_pad -net VDD -coordinate $vdd1r_coor
    set vdd2r_coor [lindex [get_attribute [get_cells vdd2right] bbox] 0]
    set_virtual_pad -net VDD -coordinate $vdd2r_coor
    set vdd1b_coor [lindex [get_attribute [get_cells vdd1bottom] bbox] 0]
    set_virtual_pad -net VDD -coordinate $vdd1b_coor
    set vdd2b_coor [lindex [get_attribute [get_cells vdd2bottom] bbox] 0]
    set_virtual_pad -net VDD -coordinate $vdd2b_coor

    set vss1l_coor [lindex [get_attribute [get_cells vss1left] bbox] 0]
    set_virtual_pad -net VSS -coordinate $vss1l_coor
    set vss2l_coor [lindex [get_attribute [get_cells vss2left] bbox] 0]
    set_virtual_pad -net VSS -coordinate $vss2l_coor
    set vss1t_coor [lindex [get_attribute [get_cells vss1top] bbox] 0]
    set_virtual_pad -net VSS -coordinate $vss1t_coor
    set vss2t_coor [lindex [get_attribute [get_cells vss2top] bbox] 0]
    set_virtual_pad -net VSS -coordinate $vss2t_coor
    set vss1r_coor [lindex [get_attribute [get_cells vss1right] bbox] 0]
    set_virtual_pad -net VSS -coordinate $vss1r_coor
    set vss2r_coor [lindex [get_attribute [get_cells vss2right] bbox] 0]
    set_virtual_pad -net VSS -coordinate $vss2r_coor
    set vss1b_coor [lindex [get_attribute [get_cells vss1bottom] bbox] 0]
    set_virtual_pad -net VSS -coordinate $vss1b_coor
    set vss2b_coor [lindex [get_attribute [get_cells vss2bottom] bbox] 0]
    set_virtual_pad -net VSS -coordinate $vss2b_coor

    analyze_power_plan -nets {VDD VSS} -power_budget 1000 -voltage 1.8 -pad_references {VDD:$core_vdd_pad VSS:$core_vss_pad}
#    analyze_power_plan -nets {VDD VSS} -power_budget 1000 -voltage 1.8 -pad_references {VDD:[get_cells -filter "ref_name==$core_vdd_pad"] VSS:[get_cells -filter "ref_name==$core_vss_pad]}
}
