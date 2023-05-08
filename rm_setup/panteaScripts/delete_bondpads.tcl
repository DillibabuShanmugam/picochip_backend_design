#}###################################################################
#                                                                   #
# Description     : Tcl script to delete bond pad by refence name   #
# Completion Date : 14 Dec 2008                                     #
#                                                                   #
# Copyright © 2011 Synopsys, Inc.  All rights reserved.             #
#                                                                   #
# This script is proprietary and confidential information of        #
# Synopsys, Inc. and may be used and disclosed only as authorized   #
# per your agreement with Synopsys, Inc. controlling such use and   #
# disclosure.                                                       #
#                                                                   #
#####################################################################

#####################################################################
#                                                                   #
# To use this Tcl procedure in IC Compiler "icc_shell>"             #
# Usage:                                                            #
#   delete_bondpads # delete bonding pad by refence name            #
#     bond_pad_ref_name  : specify bonding pad reference name       #
# Example:                                                          #
#   delete_bondpads -bond_pad_ref_name PADIZ40 ;#inline bonding pad #
#                                                                   #
#####################################################################

proc delete_bondpads {args} {
  
  parse_proc_arguments -args $args pargs
  
  ## get inline bond pad ref_name
  if {[info exists pargs(-bond_pad_ref_name)]} {

      set bond_pad_ref_name $pargs(-bond_pad_ref_name)

   ## check specified inline bond pad cell
   if {[get_cells -hier -filter "ref_name==$bond_pad_ref_name"] == "" } {
 	echo "==== INFO: You specified inline bond pad cell $bond_pad_ref_name don't exist in physical library."
	return
      }

   } else {
        echo "==== INFO: Please specify the inline bond pad ref_name."
      return
   }

   ## remove current exist inline bonding pad cell
   set get_bond_pad_cells_cmd "get_cells -hierarchical -filter \"ref_name =="
   append get_bond_pad_cells_cmd $bond_pad_ref_name "\""
   
   set exist_bond_pad_list [eval $get_bond_pad_cells_cmd]
   
   if { $exist_bond_pad_list !=""} {
      echo "==== INFO: remove pre-exist bond pad cell"
      set size [sizeof_collection $exist_bond_pad_list]
      remove_cell [eval $get_bond_pad_cells_cmd]
      echo "==== INFO: Total deleted" $size "bond pad cell $bond_pad_ref_name."      
   } else {
      echo "==== INFO: current cell" [get_object_name [current_mw_cel]] "don't exist bond pad cell $bond_pad_ref_name."      
   }
}

define_proc_attributes delete_bondpads \
  -info "delete_bondpads # delete bond pad by ref_name" \
  -define_args {
	{-bond_pad_ref_name "deleted bond pad reference name" bond_pad_ref_name string required}
}

