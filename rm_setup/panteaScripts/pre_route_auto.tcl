# effort level to optimize wire length and via count
set_app_options -name route.detail.optimize_wire_via_effort_level -value medium ;# pk: default low

# enable automatic via insertion after each detail routing step
set_app_options -name route.common.post_detail_route_redundant_via_insertion -value medium ;# pk: default off

# effor level applied to the automatic repairing of shorts over macros
set_app_options -name route.detail.repair_shorts_over_macros_effort_level -value high ;# pk: default off

# enable diode insertion to fix antenna violations:
set_app_options -name route.detail.insert_diodes_during_routing -value true;# pk: default false
set_app_options -name route.detail.diode_libcell_names -value "ANTENNABWP7T"

# enable analysis and optimization of antennas on power and ground nets:
set_app_options -name route.detail.check_antenna_on_pg -value true;# pk: default false

# effort level to use before early termination of detail routing when drc does not converge
set_app_options -name route.detail.drc_convergence_effort_level -value high ;# pk: default medium 
