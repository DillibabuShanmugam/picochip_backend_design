##########################################################################################
# Tool: IC Compiler II
# Script: route_auto.atomic.tcl (template)
# Version: P-2019.03-SP4
# Copyright (C) 2014-2019 Synopsys, Inc. All rights reserved.
##########################################################################################

## To use atomic routing command for routing, replace route_auto with the following commands.
## Note 
## 1. route_auto has automatic handling for custom tracks, very wide NDR rules,
##    via ladders, and maintains same timing scenario for the purpose of timing-driven.  
##    These are not part of the atomic commands and may require additional setup.
## 2. If you are running via ladder flow, with atomic routing commands, please run the following
##    before route_global:
#	refresh_performance_via_ladder_constraints
#	refresh_via_ladders

##########################################################################
## Routing (atomic): global route
##########################################################################
puts "RM-info: Running route_global"
route_global
#save_block -as ${DESIGN_NAME}/${ROUTE_AUTO_BLOCK_NAME}_global_route

##########################################################################
## Routing (atomic): track assign
##########################################################################
puts "RM-info: Running route_track"
route_track
#save_block -as ${DESIGN_NAME}/${ROUTE_AUTO_BLOCK_NAME}_track_assignment

##########################################################################
## Routing (atomic): detail route
##########################################################################
puts "RM-info: Running route_detail"
route_detail
#save_block -as ${DESIGN_NAME}/${ROUTE_AUTO_BLOCK_NAME}_detail_route

