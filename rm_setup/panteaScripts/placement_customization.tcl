# ignoring scandef
set_app_options -name place.coarse.continue_on_missing_scandef -value true

# dont touch RO sensors
set_dont_touch [get_cells -hier *delay_cell*] true
set_dont_touch [get_nets -hier *delay_chain*] true
set_dont_touch [get_cells -of_objects [get_nets -hier *delay_chain*]]

# prevent placing cells under pg mesh
set_app_options -name place.common.pnet_aware_layers -value {METAL5 METAL6}
set_app_options -name place.common.pnet_aware_density -value 0.1
set_app_options -name place.common.pnet_aware_min_width -value 0
