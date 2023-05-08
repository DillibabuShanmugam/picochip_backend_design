if {$MV_AES} {
    connect_pg_net -net VN1 [get_pins -physical_context *VDD]
    connect_pg_net -net GN1 [get_pins -physical_context *VSS]
    connect_pg_net -net VN2 [get_pins -physical_context *aes_coprocessor*VDD]
    connect_pg_net -net GN2 [get_pins -physical_context *aes_coprocessor*VSS]
    connect_pg_net -net VN2 [get_pins -physical_context *vdd2left*VDD]
    connect_pg_net -net GN2 [get_pins -physical_context *vss2left*VSS]
} else {
    connect_pg_net -net VDD [get_pins -hier -physical_context *VDD]
#new    connect_pg_net -net VDD [get_pins -hier -physical_context *VDD_HIGH] ;# for the trng ros
    connect_pg_net -net VSS [get_pins -hier -physical_context *VSS]
}
