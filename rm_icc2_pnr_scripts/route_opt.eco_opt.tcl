puts "RM-info: Running script [info script]\n"

##########################################################################################
# Tool: IC Compiler II
# Script: route_opt.eco_opt.tcl to be sourced by route_opt.tcl
# Version: P-2019.03-SP4
# Copyright (C) 2014-2019 Synopsys, Inc. All rights reserved.
##########################################################################################

## ECO fusion ease of use 
## You can reuse existing standalone PT signoff scripts in ECO fusion with required modifications,
## including preparing your scenario setup scripts, making edits in the scripts for ECO fusion compatability, etc.
## The rest of the steps are the same as below.  
## For details, refer to ICC-II training materials on the ECO fusion Ease of Use feature.

## Use ECO_OPT_DB_PATH to specify search path to all db locations, if not already in your search_path.
#  PT needs to read db.
if {$ROUTE_OPT_ECO_OPT_DB_PATH != ""} { 
	lappend search_path $ROUTE_OPT_ECO_OPT_DB_PATH
}

################################################
## Set PT options
################################################
#  Use "set_pt_options -help" to check all the available options of set_pt_options
#  set_host_options example:
#	set_host_options -name eco_opt_host_option -submit_command "/lsf/bin/bsub -R \"rusage\[mem=$MEM\]"
#	set_pt_options -host_option eco_opt_host_option
set set_pt_options_cmd "set_pt_options -pt_exec $ROUTE_OPT_ECO_OPT_PT_PATH"

if {$ROUTE_OPT_ECO_OPT_WORK_DIR != ""} {
	if {file exists $ROUTE_OPT_ECO_OPT_WORK_DIR} {
		puts "RM-warning: The specified ROUTE_OPT_ECO_OPT_WORK_DIR exits. It will be ovewritten by eco_opt and check_pt_qor."
		puts "RM-info: Please specify a different directory for ROUTE_OPT_ECO_OPT_WORK_DIR or rename the pre-existing directory."
	}
	lappend set_pt_options_cmd -work_dir $ROUTE_OPT_ECO_OPT_WORK_DIR
}

if {[file exists [which $ROUTE_OPT_ECO_OPT_PRE_LINK_SCRIPT]]} {
	lappend set_pt_options_cmd -pre_link_script $ROUTE_OPT_ECO_OPT_PRE_LINK_SCRIPT
} elseif {$ROUTE_OPT_ECO_OPT_PRE_LINK_SCRIPT != ""} {
	puts "RM-error: ROUTE_OPT_ECO_OPT_PRE_LINK_SCRIPT($ROUTE_OPT_ECO_OPT_PRE_LINK_SCRIPT) is invalid. Please correct it."
}

if {[file exists [which $ROUTE_OPT_ECO_OPT_POST_LINK_SCRIPT]]} {
	lappend set_pt_options_cmd -post_link_script $ROUTE_OPT_ECO_OPT_POST_LINK_SCRIPT
} elseif {$ROUTE_OPT_ECO_OPT_POST_LINK_SCRIPT != ""} {
	puts "RM-error: ROUTE_OPT_ECO_OPT_POST_LINK_SCRIPT($ROUTE_OPT_ECO_OPT_POST_LINK_SCRIPT) is invalid. Please correct it."
}

puts "RM-info: Running $set_pt_options_cmd"
eval $set_pt_options_cmd
redirect -tee -file ${REPORTS_DIR}/${ROUTE_OPT_BLOCK_NAME}.report_pt_options {report_pt_options}

################################################
## Enable StarRC in-design extraction
################################################
## Config file is only neeeded for StarRC-in-design extraction
if {[file exists [which $ROUTE_OPT_ECO_OPT_STARRC_CONFIG_FILE]]} {
	set_starrc_options -config $ROUTE_OPT_ECO_OPT_STARRC_CONFIG_FILE ;# example: route_opt.starrc_config_example.txt
	redirect -tee -file ${REPORTS_DIR}/${ROUTE_OPT_BLOCK_NAME}.report_starrc_options.rpt {report_starrc_options} 
}

################################################
## Check if design is clean
################################################
## If design is not clean, eco_opt QoR will be impacted. Please check the reports and make sure the design is clean first.
redirect -tee -file ${REPORTS_DIR}/${ROUTE_OPT_BLOCK_NAME}.pre_check_legality.rpt {check_legality}
redirect -tee -file ${REPORTS_DIR}/${ROUTE_OPT_BLOCK_NAME}.pre_check_routes.rpt {check_routes}

################################################
## Enable PBA
################################################
if {$ROUTE_OPT_ECO_OPT_WITH_PBA} {
		## time.pba_optimization_mode enables path-based analysis during route_opt; tool default false;
		## you can also set it to exhaustive to apply an exhaustive path search algorithm to determine worst pba path to an endpoint;
		set_app_options -name time.pba_optimization_mode -value path 	
}

################################################
## Check and show PT QoR
################################################
## Use "check_pt_qor -help" to check all the available options of check_pt_qor
set check_pt_qor_cmd "check_pt_qor"
if {$ROUTE_OPT_ECO_OPT_WITH_PBA} {lappend check_pt_qor_cmd -pba_mode [get_app_option_value -name time.pba_optimization_mode]}
redirect -tee -file ${REPORTS_DIR}/${ROUTE_OPT_BLOCK_NAME}.check_pt_qor.pre.rpt "$check_pt_qor_cmd"
redirect -tee -file ${REPORTS_DIR}/${ROUTE_OPT_BLOCK_NAME}.check_pt_qor.pre.summary.rpt "$check_pt_qor_cmd -type summary"

################################################
## Perform PT-ECO
################################################
## Default types performed by eco_opt are : setup hold drc total_power buffer_removal
## Supported types are : global_timing, scenario_timing, summary, max_delay, min_delay, max_transition, max_capacitance, leakage_power & dynamic_power ... etc 
## Use "eco_opt -help" to check all the available options of eco_opt
set eco_opt_cmd "eco_opt"
if {$ROUTE_OPT_ECO_OPT_TYPE != ""} {lappend eco_opt_cmd -type $ROUTE_OPT_ECO_OPT_TYPE}
if {$ROUTE_OPT_ECO_OPT_WITH_PBA} {lappend eco_opt_cmd -pba_mode [get_app_option_value -name time.pba_optimization_mode]}
puts "RM-info: Running $eco_opt_cmd"
eval $eco_opt_cmd

################################################
## Check and show PT QoR
################################################
## Use "check_pt_qor -help" to check all the available options of check_pt_qor 
redirect -tee -file ${REPORTS_DIR}/${ROUTE_OPT_BLOCK_NAME}.check_pt_qor.post.rpt {check_pt_qor}
redirect -tee -file ${REPORTS_DIR}/${ROUTE_OPT_BLOCK_NAME}.check_pt_qor.post.summary.rpt {check_pt_qor -type summary}

## Reset extract.starrc_mode when StarRC extraction is enabled for eco_opt but StarRC-in-design for route_opt is not enabled.
## This is to avoid NEX-054 error message when this app option is left on after eco_opt but StarRC-in-design is not used.
if {[get_app_option_value -name extract.starrc_mode] && ![file exists [which $ROUTE_OPT_STARRC_CONFIG_FILE]]} {
	reset_app_options extract.starrc_mode
}

puts "RM-info: Completed script [info script]\n"
