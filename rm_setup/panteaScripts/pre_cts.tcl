set_clock_tree_options -target_skew 0.1
set_clock_uncertainty 0.1 [all_clocks]

# for manual checks:
# report_clock_tree_options
# check_clock_trees
# report_disable_timing
# report_case_analysis
# report_clock_balance_points

# clock buffers and inverters in the std cell lib:
set cts_cells {CKBD0BWP7T CKBD10BWP7T CKBD12BWP7T CKBD1BWP7T CKBD2BWP7T CKBD3BWP7T CKBD4BWP7T CKBD6BWP7T CKBD8BWP7T CKND0BWP7T CKND10BWP7T CKND12BWP7T CKND1BWP7T CKND2BWP7T CKND3BWP7T CKND4BWP7T CKND6BWP7T CKND8BWP7T}
# to ensure that cts uses only the specified set of cells and that these cells are not used by any optimization step other than cts:
set_lib_cell_purpose -exclude cts [get_lib_cells]
set_lib_cell_purpose -include none [get_lib_cells $cts_cells]
set_lib_cell_purpose -include cts [get_lib_cells $cts_cells]

# get_attribute -objects CKBD0BWP7T -name included_purposes
# get_attribute -objects CKBD0BWP7T -name excluded_purposes
# report_clock_settings

# check design before starting cts:
check_design -checks pre_clock_tree_stage

# if voltage isn't set:
# set_voltage 1.62 -object_list {VN1 VN2}
                                                              
# disable hold fixing during clock_opt command:
set_scenario_status [get_scenarios] -hold true
set_app_options -list {clock_opt.hold.effort none}

# routing specs on METAL6
# Create the NDR
#create_routing_rule metal6routing -default_reference_rule -widths {METAL6 2.6} -spacings {METAL6 2.5}
# Set the routing rule for the net1 net
#set_routing_rule -max_routing_layer METAL6 -rule metal6routing [get_nets -hierarchical *]
#set_clock_routing_rules -max_routing_layer METAL5 -rule metal6routing -clocks clk
#set_clock_routing_rules -max_routing_layer METAL6 -rule metal6routing

