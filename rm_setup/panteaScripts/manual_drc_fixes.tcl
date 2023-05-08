set removenets false
#pk: manual:
## You can use route_detail to reduce routing DRC further


## remove floating tapcells: (moved to pre_cts.tcl)
# set_fixed_objects [filter_collection [get_attribute [get_drc_errors -quiet -error_data picochip_floatingPG.err] objects] -regexp {name=~ "tapfiller.*"}] -unfix
# remove_physical_objects [filter_collection [get_attribute [get_drc_errors -quiet -error_data picochip_floatingPG.err] objects] -regexp {name=~ "tapfiller.*"}] 

check_routes
save_block -as ${DESIGN_NAME}/${ROUTE_OPT_BLOCK_NAME}_drc
set max_run 100
set num_run 0
exec touch drc_ant
exec touch $num_run
route_detail -incremental true -initial_drc_from_input true
open_drc_error_data -file_name zroute.err
while { [sizeof_collection [get_drc_errors -quiet -error_data zroute.err -filter "type_name==Antenna"] ] > 0} {
	route_detail -incremental true -initial_drc_from_input true
	check_routes
        save_block -as ${DESIGN_NAME}/${ROUTE_OPT_BLOCK_NAME}_drc
	incr num_run
	exec touch $num_run
	exec rm -f [expr $num_run-1]
	if {$num_run > $max_run} { 
		break
	}
}	

check_routes
save_block -as ${DESIGN_NAME}/${ROUTE_OPT_BLOCK_NAME}_drc
set max_run 100
set num_run 0
exec touch drc_pba
exec touch $num_run
while { [sizeof_collection [get_drc_errors -quiet -error_data zroute.err -filter {type_name=="Pin-break Antenna"}] ] > 5} {
        route_detail -incremental true -initial_drc_from_input true
        check_routes
        save_block -as ${DESIGN_NAME}/${ROUTE_OPT_BLOCK_NAME}_drc
        incr num_run
        exec touch $num_run
        exec rm -f [expr $num_run-1]
        if {$num_run > $max_run} {
                break
        }
}


check_routes
save_block -as ${DESIGN_NAME}/${ROUTE_OPT_BLOCK_NAME}_drc
set max_run 100
set num_run 0
exec touch drc_dns
exec touch $num_run
while { [sizeof_collection [get_drc_errors -quiet -error_data zroute.err -filter {type_name=="Diff net spacing"}] ] > 5} {
	route_detail -incremental true -initial_drc_from_input true
	check_routes
        save_block -as ${DESIGN_NAME}/${ROUTE_OPT_BLOCK_NAME}_drc
	incr num_run
	exec touch $num_run
	exec rm -f [expr $num_run-1]
	if {$num_run > $max_run} { 
		break
	}
}	



if {$removenets} {

check_routes
while { [sizeof_collection [get_drc_errors -quiet -error_data zroute.err -filter "type_name==Antenna"] ] > 0} {
#        incr num_run
#        exec touch $num_run
#        exec rm -f [expr $num_run-1]
#        if {$num_run > $max_run} {
#                break
#        }
#	set remove_net ""
	set antenna_nets {}
	foreach_in_collection net [get_attribute [get_drc_errors -error_data zroute.err -filter "type_name==Antenna"] objects] {
		set net_type [get_attribute $net net_type]
		if {$net_type=="signal"} {append_to_collection antenna_nets $net}
	}
#	query_objects $antenna_nets
#OPT_HFSNET_1131
	remove_routes -detail_route -nets $antenna_nets
	route_eco
	check_routes
	save_block -as ${DESIGN_NAME}/${ROUTE_OPT_BLOCK_NAME}_drc
}

# source rm_setup/panteaScripts/remove_short_drc_signal_net_shapes.tcl
# remove_short_drc_signal_net_shapes
# route_eco

## Example to resolve short violated nets
## Note that remove and reroute nets could potentially degrade timing QoR.
set data [open_drc_error_data -name zroute.err]
open_drc_error_data -name zroute.err
check_routes
save_block -as ${DESIGN_NAME}/${ROUTE_OPT_BLOCK_NAME}_drc
set max_run 100
set num_run 0
exec touch drc_short
exec touch $num_run
while { [sizeof_collection [get_drc_errors -quiet -error_data zroute.err -filter "type_name==Short"] ] > 0} {
        incr num_run
        exec touch $num_run
        exec rm -f [expr $num_run-1]
        if {$num_run > $max_run} {
                break
        }
	set remove_net ""
	foreach_in_collection net [get_attribute [get_drc_errors -error_data zroute.err -filter "type_name==Short"] objects] {
		set net_type [get_attribute $net net_type]
		if {$net_type=="signal"} {append_to_collection remove_net $net}
	}
	remove_routes -detail_route -nets $remove_net
	route_eco
	check_routes
	save_block -as ${DESIGN_NAME}/${ROUTE_OPT_BLOCK_NAME}_drc
}

}

#check_routes
##save_block -as ${DESIGN_NAME}/${ROUTE_OPT_BLOCK_NAME}_drc
#set max_run 20
#set num_run 0
#exec touch $num_run
#while { $num_run < $max_run } {
#        route_detail -incremental true -initial_drc_from_input true
#        check_routes
#        #save_block -as ${DESIGN_NAME}/${ROUTE_OPT_BLOCK_NAME}_drc
#        incr num_run
#        exec touch $num_run
#        exec rm -f [expr $num_run-1]
#}




#	set err_nets {}
##        #foreach_in_collection net [get_attribute [get_drc_errors -error_data zroute.err -filter {type_name=="Diff net var rule spacing"}] objects] {
#        foreach_in_collection net [get_attribute [get_drc_errors -error_data zroute.err -filter {type_name=="Antenna"}] objects] {
#                set net_type [get_attribute $net net_type]
#                if {$net_type=="signal"} {append_to_collection err_nets $net}
#        }
##       query_objects $err_nets
#        remove_routes -detail_route -nets $err_nets
#        route_eco
#        check_routes



#open_drc_error_data -file_name zroute.err
#while { [sizeof_collection [get_drc_errors -quiet -error_data zroute.err -filter "type_name==Antenna"] ] > 0} {
#        route_detail -incremental true -initial_drc_from_input true
#        check_routes
#        save_block -as ${DESIGN_NAME}/${ROUTE_OPT_BLOCK_NAME}_drc
#        incr num_run
#        exec touch $num_run
#        exec rm -f [expr $num_run-1]
#        if {$num_run > $max_run} {
#                break
#        }
#}

#get_attribute [get_drc_errors -quiet -error_data DRC_report_by_check_pg_drc -filter {type_name=="Overlap of Via-Cuts"}] objects
