# Copyright © 2017 Synopsys, Inc.  All rights reserved.             # 
#                                                                   #
# This script is proprietary and confidential information of        #
# Synopsys, Inc. and may be used and disclosed only as authorized   #
# per your agreement with Synopsys, Inc. controlling such use and   #
# disclosure.                                                       #
#####################################################################
proc remove_short_drc_signal_net_shapes {args} {
    parse_proc_arguments -args $args arglist
    set zroute_db [open_drc_error_data -name zroute.err]
    set short_errors [get_drc_errors -error_data $zroute_db -of_objects {Short}]
    foreach short_nets [get_attribute $short_errors name] {
        set nets [filter_collection [get_attribute [get_drc_errors -error_data $zroute_db $short_nets] objects] "net_type == signal"]
        set net_layers [get_object_name [get_attribute [get_drc_errors -error_data $zroute_db $short_nets] layers]]
        if {$nets != ""} {
            puts "Starting to remove net shorts by [get_object_name $nets] of $net_layers "
            remove_routes -detail_route -nets $nets
        }
    }
}
define_proc_attributes remove_short_drc_signal_net_shapes -info "Script to remove all signal net shapes that has short drc violation"
