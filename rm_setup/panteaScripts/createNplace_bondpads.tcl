#####################################################################
#                                                                   #
# Description     : Tcl script to create and place bond pad         #
#                   (inline or stagger style)                       #
# Update Date     : 13 Mar 2011                                     #
#                   correct for support hierarchical I/O PAD cell.  #
# Update Date     : 07 Feb 2011                                     #
#                   compatible with 2010.03, 2010.12 version.       #
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


##########################################################################
#                                                                        #
# To use this Tcl procedure in IC Compiler "icc_shell>"                  #
# Usage:                                                                 #
#   createNplace_bondpads # create and place bonding pad                 #
#                           (inline or staggered style)                  #
#     inline_pad_ref_name  : specify inline bonding pad reference name   #
#     stagger              : inline or staggered style bonding pad       #
#     stagger_pad_ref_name : specify staggered bonding pad reference name#
# Example:                                                               #
#   createNplace_bondpads -inline_pad_ref_name PADIZ40 ;#inline          #
#   createNplace_bondpads -inline_pad_ref_name PADIZ40 \                 #
#                         -stagger true \                                #
#                         -stagger_pad_ref_name PADOZ40                  #
#                                                                        #
##########################################################################

proc createNplace_bondpads {args} {
  source rm_setup/icc2_common_setup.tcl ;# pk
  
  parse_proc_arguments -args $args pargs
  
  ## get bond pad style 
  if {[info exists pargs(-stagger)]} {
     set stagger $pargs(-stagger)
  } else {
     set stagger false
  }
  
  ## get inline bond pad ref_name
  if {[info exists pargs(-inline_pad_ref_name)]} {

      set bond_pad_ref_name $pargs(-inline_pad_ref_name)
      ## check specified inline bond pad cell
      if {[get_lib_cells $bond_pad_ref_name] == "" } {
            echo "==== INFO: You specified inline bond pad cell $bond_pad_ref_name don't exist in physical library."
            return
      }

   } else {
        echo "==== INFO: Please specify the inline bond pad ref_name."
      return
   }

   ## get stagger bond pad ref_name
   if { $stagger == "true" } {
       if {[info exists pargs(-stagger_pad_ref_name)]} {
           set stagger_bond_pad_ref_name $pargs(-stagger_pad_ref_name)
           ## check specified inline bond pad cell
           if {[get_lib_cells $stagger_bond_pad_ref_name] == "" } {
                 echo "==== INFO: You specified stagger bond pad cell $stagger_bond_pad_ref_name don't exist in physical library."
                 return
           }
     } else {
	   echo "==== INFO: Please specify the stagger bond pad ref_name." 
	   return
      }
   }
   
   set oldSnapState [set_snap_setting -enabled false]
   suppress_message {HDU-104 HDUEDIT-104}
   
   ## get bond pad height & width
   set bond_pad_bbox [get_attribute [get_lib_cells $bond_pad_ref_name] bbox]
   set pad_width     [expr [lindex $bond_pad_bbox 1 0] - [lindex $bond_pad_bbox 0 0]]
   set pad_height    [expr [lindex $bond_pad_bbox 1 1] - [lindex $bond_pad_bbox 0 1]]
  
   if {$stagger == "true" } {

      ## get stagger bond pad height & width
      set stagger_bond_pad_bbox [get_attribute [get_lib_cells $stagger_bond_pad_ref_name] bbox]
      set stagger_pad_width     [expr [lindex $stagger_bond_pad_bbox 1 0] - [lindex $stagger_bond_pad_bbox 0 0]]
      set stagger_pad_height    [expr [lindex $stagger_bond_pad_bbox 1 1] - [lindex $stagger_bond_pad_bbox 0 1]]
   }
   
   ## get all left io_pad list and sort tis list by coordinate
   set all_left_io_cell_sort_list ""
   set all_left_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true &&io_guide==[get_io_guides *left]"]]
#   set all_left_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true && orientation==R270"]]
   foreach left_io_cell $all_left_io_cell_list {
   	set io_sort_index [lindex [get_attribute [get_cells $left_io_cell] origin] 1]
   	lappend all_left_io_cell_sort_list [list $left_io_cell $io_sort_index]
   }
   set all_left_io_cell_sort_list [lsort -real -index 1 $all_left_io_cell_sort_list]

   ## get all top io_pad list and sort tis list by coordinate
   set all_top_io_cell_sort_list ""
   set all_top_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true &&io_guide==[get_io_guides *top]"]]
#   set all_top_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true && orientation==R180"]]
   foreach top_io_cell $all_top_io_cell_list {
   	set io_sort_index [lindex [get_attribute [get_cells $top_io_cell] origin] 0]
   	lappend all_top_io_cell_sort_list [list $top_io_cell $io_sort_index]	
   }
   set all_top_io_cell_sort_list [lsort -real -index 1 $all_top_io_cell_sort_list]
   	
   ## get all right io_pad list and sort tis list by coordinate
   set all_right_io_cell_sort_list ""
   set all_right_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true &&io_guide==[get_io_guides *right]"]]
#   set all_right_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true && orientation==R90"]]
   foreach right_io_cell $all_right_io_cell_list {
   	set io_sort_index [lindex [get_attribute [get_cells $right_io_cell] origin] 1]
   	lappend all_right_io_cell_sort_list [list $right_io_cell $io_sort_index]
   }
   set all_right_io_cell_sort_list [lsort -real -index 1 $all_right_io_cell_sort_list]
   	
   ## get all bottom inline io_pad list and sort tis list by coordinate
   set all_bottom_io_cell_sort_list ""
#poc   set all_bottom_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true &&io_guide==[get_io_guides *bottom]"]]
   set all_bottom_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true &&io_guide==[get_io_guides *bottom]&&ref_name!=PVDD2POC"]] ; # pk: exclude the poc cell
   foreach bottom_io_cell $all_bottom_io_cell_list {
   	set io_sort_index [lindex [get_attribute [get_cells $bottom_io_cell] origin] 0]
   	lappend all_bottom_io_cell_sort_list [list $bottom_io_cell $io_sort_index]
   }
   set all_bottom_io_cell_sort_list [lsort -real -index 1 $all_bottom_io_cell_sort_list]

   set all_io_cell_list [concat $all_left_io_cell_sort_list $all_top_io_cell_sort_list $all_right_io_cell_sort_list $all_bottom_io_cell_sort_list]
   
   ## remove current exist inline bonding pad cell
   set get_bond_pad_cells_cmd "get_cells -quiet -hier -f \"ref_name =="
   append get_bond_pad_cells_cmd $bond_pad_ref_name "\""
   
   set exist_bond_pad_list [eval $get_bond_pad_cells_cmd]
   
   if { $exist_bond_pad_list !=""} {
      echo "==== INFO: remove pre-exist inline bond pad cell $bond_pad_ref_name."
      remove_cell $exist_bond_pad_list
      } else {
      echo "==== INFO: current cell" [get_object_name [current_design]] "don't exist inline bond pad cell $bond_pad_ref_name."      
      }

   ## remove current exist stagger bonding pad cell
   if {$stagger == "true"}  {
     set get_stagger_bond_pad_cells_cmd "get_cells -quiet -hier -f \"ref_name =="
     append get_stagger_bond_pad_cells_cmd $stagger_bond_pad_ref_name "\""
     
     set exist_stagger_bond_pad_list [eval $get_stagger_bond_pad_cells_cmd]
     
     if { $exist_stagger_bond_pad_list !=""} {
        echo "==== INFO: remove pre-exist stagger bond pad cell $stagger_bond_pad_ref_name."
        remove_cell $exist_stagger_bond_pad_list
        } else {
        echo "==== INFO: current cell" [get_object_name [current_design]] "don't exist stagger bond pad cell $stagger_bond_pad_ref_name."      
	}
   }

   ## stagger pad counter
   set left_i   1
   set top_i    1
   set right_i  1
   set bottom_i 1

   # Modification made to ensure required offset
   set BOND_PAD_OFFSET 0.0
   
   foreach io_cell $all_io_cell_list {
   
      set io_cell_bbox   [get_attribute [get_cells [lindex $io_cell 0]] bbox]
      set io_cell_orient [get_attribute [get_cells [lindex $io_cell 0]] orientation]
      set io_cell_LL_X [lindex $io_cell_bbox 0 0]
      set io_cell_LL_Y [lindex $io_cell_bbox 0 1]
      set io_cell_UR_X [lindex $io_cell_bbox 1 0]
      set io_cell_UR_Y [lindex $io_cell_bbox 1 1]
   
      set bond_pad_name ""
#      append bond_pad_name [get_attribute [get_cells [lindex $io_cell 0]] name] "_PAD"
      append bond_pad_name [get_object_name [lindex $io_cell 0]] "_BONDPAD"
   
      ## left side io cell
      if { $io_cell_orient == "R270" } {

	 if {$stagger == "true" && ![expr $left_i % 2]} {

	     create_cell $bond_pad_name $stagger_bond_pad_ref_name
             set bond_pad_LL_X [expr $io_cell_LL_X - $stagger_pad_height + $BOND_PAD_OFFSET]
#             set bond_pad_LL_X [expr $io_cell_LL_X - $stagger_pad_height]
             set bond_pad_LL_Y [expr $io_cell_LL_Y]
         } else {

	    create_cell $bond_pad_name $bond_pad_ref_name
	    set bond_pad_LL_X [expr $io_cell_LL_X - $pad_height + $BOND_PAD_OFFSET]
#            set bond_pad_LL_Y [expr $io_cell_LL_Y + $BOND_PAD_OFFSET]
            set bond_pad_LL_Y [expr $io_cell_LL_Y]
	    set bond_pad_orient "R270"
	   }
	 
	 set left_i [expr $left_i + 1]
      }

      ## top side io cell
      if { $io_cell_orient == "R180" } {
	 
	 if {$stagger == "true" && ![expr $top_i % 2]} {

	     create_cell $bond_pad_name $stagger_bond_pad_ref_name
	     set bond_pad_LL_X $io_cell_LL_X
             set bond_pad_LL_Y [expr $io_cell_UR_Y - $BOND_PAD_OFFSET]
#             set bond_pad_LL_Y $io_cell_UR_Y

	 } else {
	 
	     create_cell $bond_pad_name $bond_pad_ref_name
#             set bond_pad_LL_X [expr $io_cell_LL_X + $BOND_PAD_OFFSET]
             set bond_pad_LL_X [expr $io_cell_LL_X]
             set bond_pad_LL_Y [expr $io_cell_UR_Y - $BOND_PAD_OFFSET]
	     set bond_pad_orient "R180"
         }
        
        set top_i [expr $top_i + 1]
      }
   
      ## right side io cell
      if { $io_cell_orient == "R90" } {
	 
	 if {$stagger == "true" && ![expr $right_i % 2]} {

	     create_cell $bond_pad_name $stagger_bond_pad_ref_name
#	     set bond_pad_LL_X $io_cell_UR_X
	     set bond_pad_LL_X [expr $io_cell_UR_X - $BOND_PAD_OFFSET]
             set bond_pad_LL_Y $io_cell_LL_Y

	 } else {

	    create_cell $bond_pad_name $bond_pad_ref_name
	    set bond_pad_LL_X [expr $io_cell_UR_X - $BOND_PAD_OFFSET]
#            set bond_pad_LL_Y [expr $io_cell_LL_Y + $BOND_PAD_OFFSET]
            set bond_pad_LL_Y [expr $io_cell_LL_Y]
	    set bond_pad_orient "R90"

	 }
	
	set right_i [expr $right_i + 1]

       }
   
      ## bottom side io cell
      if { $io_cell_orient == "R0" } {

	 if {$stagger == "true" && ![expr $bottom_i % 2]} {

	     create_cell $bond_pad_name $stagger_bond_pad_ref_name
             set bond_pad_LL_X $io_cell_LL_X
#             set bond_pad_LL_Y [expr $io_cell_LL_Y - $stagger_pad_height]
             set bond_pad_LL_Y [expr $io_cell_LL_Y - $stagger_pad_height + $BOND_PAD_OFFSET]

	 } else {
	
	     create_cell $bond_pad_name $bond_pad_ref_name
#	     set bond_pad_LL_X [expr $io_cell_LL_X + $BOND_PAD_OFFSET]
	     set bond_pad_LL_X [expr $io_cell_LL_X]
             set bond_pad_LL_Y [expr $io_cell_LL_Y - $pad_height + $BOND_PAD_OFFSET]
	     set bond_pad_orient "R0"

          }

	  set bottom_i [expr $bottom_i + 1]

         }
    
#    set_attribute -quiet $bond_pad_name orientation $io_cell_orient
    set_attribute -quiet $bond_pad_name orientation $bond_pad_orient
    move_objects -to [list $bond_pad_LL_X $bond_pad_LL_Y] [get_cells $bond_pad_name]
   
   }
   
   ## get current inline bonding pad cell
   set get_bond_pad_cells_cmd "get_cells -hier -f \"ref_name =="
   append get_bond_pad_cells_cmd $bond_pad_ref_name "\""
   
   echo "==== INFO: Total add" [sizeof_collection [eval $get_bond_pad_cells_cmd]] "inline bond pad cell $bond_pad_ref_name."
   
   ## get all stagger io_pad list
   if {$stagger == "true"}  {
     set get_stagger_bond_pad_cells_cmd "get_cells -hier -f \"ref_name =="
     append get_stagger_bond_pad_cells_cmd $stagger_bond_pad_ref_name "\""
     echo "==== INFO: Total add" [sizeof_collection [eval $get_stagger_bond_pad_cells_cmd]] "stagger bond pad cell $stagger_bond_pad_ref_name."
   }

   unsuppress_message {HDU-104 HDUEDIT-104}
#   set_object_snap_type -enabled $oldSnapState
   set_snap_setting -enabled false
   
}

define_proc_attributes createNplace_bondpads \
  -info "createNplace_bondpads # create and place bond pad" \
  -define_args {
	{-inline_pad_ref_name "inline bond pad reference name" inline_pad_ref_name string required}
	{-stagger "inline or stagger style bond pad <true | false(default)>" stagger string optional}
	{-stagger_pad_ref_name "stagger bond pad reference name" stagger_pad_ref_name string optional}
}

proc createNplace_bondpads_digital {args} {
  source rm_setup/icc2_common_setup.tcl ;# pk
  
  parse_proc_arguments -args $args pargs
  
  ## get bond pad style 
  if {[info exists pargs(-stagger)]} {
     set stagger $pargs(-stagger)
  } else {
     set stagger false
  }
  
  ## get inline bond pad ref_name
  if {[info exists pargs(-inline_pad_ref_name)]} {

      set bond_pad_ref_name $pargs(-inline_pad_ref_name)
      ## check specified inline bond pad cell
      if {[get_lib_cells $bond_pad_ref_name] == "" } {
            echo "==== INFO: You specified inline bond pad cell $bond_pad_ref_name don't exist in physical library."
            return
      }

   } else {
        echo "==== INFO: Please specify the inline bond pad ref_name."
      return
   }

   ## get stagger bond pad ref_name
   if { $stagger == "true" } {
       if {[info exists pargs(-stagger_pad_ref_name)]} {
           set stagger_bond_pad_ref_name $pargs(-stagger_pad_ref_name)
           ## check specified inline bond pad cell
           if {[get_lib_cells $stagger_bond_pad_ref_name] == "" } {
                 echo "==== INFO: You specified stagger bond pad cell $stagger_bond_pad_ref_name don't exist in physical library."
                 return
           }
     } else {
	   echo "==== INFO: Please specify the stagger bond pad ref_name." 
	   return
      }
   }
   
   set oldSnapState [set_snap_setting -enabled false]
   suppress_message {HDU-104 HDUEDIT-104}
   
   ## get bond pad height & width
   set bond_pad_bbox [get_attribute [get_lib_cells $bond_pad_ref_name] bbox]
   set pad_width     [expr [lindex $bond_pad_bbox 1 0] - [lindex $bond_pad_bbox 0 0]]
   set pad_height    [expr [lindex $bond_pad_bbox 1 1] - [lindex $bond_pad_bbox 0 1]]
  
   if {$stagger == "true" } {

      ## get stagger bond pad height & width
      set stagger_bond_pad_bbox [get_attribute [get_lib_cells $stagger_bond_pad_ref_name] bbox]
      set stagger_pad_width     [expr [lindex $stagger_bond_pad_bbox 1 0] - [lindex $stagger_bond_pad_bbox 0 0]]
      set stagger_pad_height    [expr [lindex $stagger_bond_pad_bbox 1 1] - [lindex $stagger_bond_pad_bbox 0 1]]
   }
   
   ## get all left io_pad list and sort tis list by coordinate
   set all_left_io_cell_sort_list ""
   set all_left_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true &&io_guide==[get_io_guides *left]"]]
#   set all_left_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true && orientation==R270"]]
   foreach left_io_cell $all_left_io_cell_list {
   	set io_sort_index [lindex [get_attribute [get_cells $left_io_cell] origin] 1]
   	lappend all_left_io_cell_sort_list [list $left_io_cell $io_sort_index]
   }
   set all_left_io_cell_sort_list [lsort -real -index 1 $all_left_io_cell_sort_list]

   ## get all top io_pad list and sort tis list by coordinate
   set all_top_io_cell_sort_list ""
   set all_top_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true &&io_guide==[get_io_guides *top]"]]
#   set all_top_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true && orientation==R180"]]
   foreach top_io_cell $all_top_io_cell_list {
   	set io_sort_index [lindex [get_attribute [get_cells $top_io_cell] origin] 0]
   	lappend all_top_io_cell_sort_list [list $top_io_cell $io_sort_index]	
   }
   set all_top_io_cell_sort_list [lsort -real -index 1 $all_top_io_cell_sort_list]
   	
   ## get all right io_pad list and sort tis list by coordinate
   set all_right_io_cell_sort_list ""
   set all_right_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true &&io_guide==[get_io_guides *right]"]]
#   set all_right_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true && orientation==R90"]]
   foreach right_io_cell $all_right_io_cell_list {
   	set io_sort_index [lindex [get_attribute [get_cells $right_io_cell] origin] 1]
   	lappend all_right_io_cell_sort_list [list $right_io_cell $io_sort_index]
   }
   set all_right_io_cell_sort_list [lsort -real -index 1 $all_right_io_cell_sort_list]
   	
   ## get all bottom inline io_pad list and sort tis list by coordinate
   set all_bottom_io_cell_sort_list ""
   #set all_bottom_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true &&io_guide==[get_io_guides *bottom]"]]
   set all_bottom_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true &&io_guide==[get_io_guides *bottom]&&ref_name!=PRCUTA&&ref_name!=$io_analog_vss_pad&&ref_name!=$io_analog_vdd_pad&&ref_name!=PDB1A"]] ; # pk: exclude the power-cut cells
#   set all_bottom_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true && orientation==R0"]]
   foreach bottom_io_cell $all_bottom_io_cell_list {
   	set io_sort_index [lindex [get_attribute [get_cells $bottom_io_cell] origin] 0]
   	lappend all_bottom_io_cell_sort_list [list $bottom_io_cell $io_sort_index]
   }
   set all_bottom_io_cell_sort_list [lsort -real -index 1 $all_bottom_io_cell_sort_list]

   set all_io_cell_list [concat $all_left_io_cell_sort_list $all_top_io_cell_sort_list $all_right_io_cell_sort_list $all_bottom_io_cell_sort_list]
   
   ## remove current exist inline bonding pad cell
   set get_bond_pad_cells_cmd "get_cells -quiet -hier -f \"ref_name =="
   append get_bond_pad_cells_cmd $bond_pad_ref_name "\""
   
   set exist_bond_pad_list [eval $get_bond_pad_cells_cmd]
   
   if { $exist_bond_pad_list !=""} {
      echo "==== INFO: remove pre-exist inline bond pad cell $bond_pad_ref_name."
      remove_cell $exist_bond_pad_list
      } else {
      echo "==== INFO: current cell" [get_object_name [current_design]] "don't exist inline bond pad cell $bond_pad_ref_name."      
      }

   ## remove current exist stagger bonding pad cell
   if {$stagger == "true"}  {
     set get_stagger_bond_pad_cells_cmd "get_cells -quiet -hier -f \"ref_name =="
     append get_stagger_bond_pad_cells_cmd $stagger_bond_pad_ref_name "\""
     
     set exist_stagger_bond_pad_list [eval $get_stagger_bond_pad_cells_cmd]
     
     if { $exist_stagger_bond_pad_list !=""} {
        echo "==== INFO: remove pre-exist stagger bond pad cell $stagger_bond_pad_ref_name."
        remove_cell $exist_stagger_bond_pad_list
        } else {
        echo "==== INFO: current cell" [get_object_name [current_design]] "don't exist stagger bond pad cell $stagger_bond_pad_ref_name."      
	}
   }

   ## stagger pad counter
   set left_i   1
   set top_i    1
   set right_i  1
   set bottom_i 1

   # Modification made to ensure required offset
   set BOND_PAD_OFFSET 0.0
   
   foreach io_cell $all_io_cell_list {
   
      set io_cell_bbox   [get_attribute [get_cells [lindex $io_cell 0]] bbox]
      set io_cell_orient [get_attribute [get_cells [lindex $io_cell 0]] orientation]
      set io_cell_LL_X [lindex $io_cell_bbox 0 0]
      set io_cell_LL_Y [lindex $io_cell_bbox 0 1]
      set io_cell_UR_X [lindex $io_cell_bbox 1 0]
      set io_cell_UR_Y [lindex $io_cell_bbox 1 1]
   
      set bond_pad_name ""
#      append bond_pad_name [get_attribute [get_cells [lindex $io_cell 0]] name] "_PAD"
      append bond_pad_name [get_object_name [lindex $io_cell 0]] "_BONDPAD"
   
      ## left side io cell
      if { $io_cell_orient == "R270" } {

	 if {$stagger == "true" && ![expr $left_i % 2]} {

	     create_cell $bond_pad_name $stagger_bond_pad_ref_name
             set bond_pad_LL_X [expr $io_cell_LL_X - $stagger_pad_height + $BOND_PAD_OFFSET]
#             set bond_pad_LL_X [expr $io_cell_LL_X - $stagger_pad_height]
             set bond_pad_LL_Y [expr $io_cell_LL_Y]
         } else {

	    create_cell $bond_pad_name $bond_pad_ref_name
	    set bond_pad_LL_X [expr $io_cell_LL_X - $pad_height + $BOND_PAD_OFFSET]
#            set bond_pad_LL_Y [expr $io_cell_LL_Y + $BOND_PAD_OFFSET]
            set bond_pad_LL_Y [expr $io_cell_LL_Y]
	    set bond_pad_orient "R270"
	   }
	 
	 set left_i [expr $left_i + 1]
      }

      ## top side io cell
      if { $io_cell_orient == "R180" } {
	 
	 if {$stagger == "true" && ![expr $top_i % 2]} {

	     create_cell $bond_pad_name $stagger_bond_pad_ref_name
	     set bond_pad_LL_X $io_cell_LL_X
             set bond_pad_LL_Y [expr $io_cell_UR_Y - $BOND_PAD_OFFSET]
#             set bond_pad_LL_Y $io_cell_UR_Y

	 } else {
	 
	     create_cell $bond_pad_name $bond_pad_ref_name
#             set bond_pad_LL_X [expr $io_cell_LL_X + $BOND_PAD_OFFSET]
             set bond_pad_LL_X [expr $io_cell_LL_X]
             set bond_pad_LL_Y [expr $io_cell_UR_Y - $BOND_PAD_OFFSET]
	     set bond_pad_orient "R180"
         }
        
        set top_i [expr $top_i + 1]
      }
   
      ## right side io cell
      if { $io_cell_orient == "R90" } {
	 
	 if {$stagger == "true" && ![expr $right_i % 2]} {

	     create_cell $bond_pad_name $stagger_bond_pad_ref_name
#	     set bond_pad_LL_X $io_cell_UR_X
	     set bond_pad_LL_X [expr $io_cell_UR_X - $BOND_PAD_OFFSET]
             set bond_pad_LL_Y $io_cell_LL_Y

	 } else {

	    create_cell $bond_pad_name $bond_pad_ref_name
	    set bond_pad_LL_X [expr $io_cell_UR_X - $BOND_PAD_OFFSET]
#            set bond_pad_LL_Y [expr $io_cell_LL_Y + $BOND_PAD_OFFSET]
            set bond_pad_LL_Y [expr $io_cell_LL_Y]
	    set bond_pad_orient "R90"

	 }
	
	set right_i [expr $right_i + 1]

       }
   
      ## bottom side io cell
      if { $io_cell_orient == "R0" } {

	 if {$stagger == "true" && ![expr $bottom_i % 2]} {

	     create_cell $bond_pad_name $stagger_bond_pad_ref_name
             set bond_pad_LL_X $io_cell_LL_X
#             set bond_pad_LL_Y [expr $io_cell_LL_Y - $stagger_pad_height]
             set bond_pad_LL_Y [expr $io_cell_LL_Y - $stagger_pad_height + $BOND_PAD_OFFSET]

	 } else {
	
	     create_cell $bond_pad_name $bond_pad_ref_name
#	     set bond_pad_LL_X [expr $io_cell_LL_X + $BOND_PAD_OFFSET]
	     set bond_pad_LL_X [expr $io_cell_LL_X]
             set bond_pad_LL_Y [expr $io_cell_LL_Y - $pad_height + $BOND_PAD_OFFSET]
	     set bond_pad_orient "R0"

          }

	  set bottom_i [expr $bottom_i + 1]

         }
    
#    set_attribute -quiet $bond_pad_name orientation $io_cell_orient
    set_attribute -quiet $bond_pad_name orientation $bond_pad_orient
    move_objects -to [list $bond_pad_LL_X $bond_pad_LL_Y] [get_cells $bond_pad_name]
   
   }
   
   ## get current inline bonding pad cell
   set get_bond_pad_cells_cmd "get_cells -hier -f \"ref_name =="
   append get_bond_pad_cells_cmd $bond_pad_ref_name "\""
   
   echo "==== INFO: Total add" [sizeof_collection [eval $get_bond_pad_cells_cmd]] "inline bond pad cell $bond_pad_ref_name."
   
   ## get all stagger io_pad list
   if {$stagger == "true"}  {
     set get_stagger_bond_pad_cells_cmd "get_cells -hier -f \"ref_name =="
     append get_stagger_bond_pad_cells_cmd $stagger_bond_pad_ref_name "\""
     echo "==== INFO: Total add" [sizeof_collection [eval $get_stagger_bond_pad_cells_cmd]] "stagger bond pad cell $stagger_bond_pad_ref_name."
   }

   unsuppress_message {HDU-104 HDUEDIT-104}
#   set_object_snap_type -enabled $oldSnapState
   set_snap_setting -enabled false
   
}

define_proc_attributes createNplace_bondpads_digital \
  -info "createNplace_bondpads_digital # create and place bond pad" \
  -define_args {
	{-inline_pad_ref_name "inline bond pad reference name" inline_pad_ref_name string required}
	{-stagger "inline or stagger style bond pad <true | false(default)>" stagger string optional}
	{-stagger_pad_ref_name "stagger bond pad reference name" stagger_pad_ref_name string optional}
}

proc createNplace_bondpads_analog_power {args} {
  source rm_setup/icc2_common_setup.tcl ;# pk
  
  parse_proc_arguments -args $args pargs
  
  ## get bond pad style 
  if {[info exists pargs(-stagger)]} {
     set stagger $pargs(-stagger)
  } else {
     set stagger false
  }
  
  ## get inline bond pad ref_name
  if {[info exists pargs(-inline_pad_ref_name)]} {

      set bond_pad_ref_name $pargs(-inline_pad_ref_name)
      ## check specified inline bond pad cell
      if {[get_lib_cells $bond_pad_ref_name] == "" } {
            echo "==== INFO: You specified inline bond pad cell $bond_pad_ref_name don't exist in physical library."
            return
      }

   } else {
        echo "==== INFO: Please specify the inline bond pad ref_name."
      return
   }

   ## get stagger bond pad ref_name
   if { $stagger == "true" } {
       if {[info exists pargs(-stagger_pad_ref_name)]} {
           set stagger_bond_pad_ref_name $pargs(-stagger_pad_ref_name)
           ## check specified inline bond pad cell
           if {[get_lib_cells $stagger_bond_pad_ref_name] == "" } {
                 echo "==== INFO: You specified stagger bond pad cell $stagger_bond_pad_ref_name don't exist in physical library."
                 return
           }
     } else {
	   echo "==== INFO: Please specify the stagger bond pad ref_name." 
	   return
      }
   }
   
   set oldSnapState [set_snap_setting -enabled false]
   suppress_message {HDU-104 HDUEDIT-104}
   
   ## get bond pad height & width
   set bond_pad_bbox [get_attribute [get_lib_cells $bond_pad_ref_name] bbox]
   set pad_width     [expr [lindex $bond_pad_bbox 1 0] - [lindex $bond_pad_bbox 0 0]]
   set pad_height    [expr [lindex $bond_pad_bbox 1 1] - [lindex $bond_pad_bbox 0 1]]
  
   if {$stagger == "true" } {

      ## get stagger bond pad height & width
      set stagger_bond_pad_bbox [get_attribute [get_lib_cells $stagger_bond_pad_ref_name] bbox]
      set stagger_pad_width     [expr [lindex $stagger_bond_pad_bbox 1 0] - [lindex $stagger_bond_pad_bbox 0 0]]
      set stagger_pad_height    [expr [lindex $stagger_bond_pad_bbox 1 1] - [lindex $stagger_bond_pad_bbox 0 1]]
   }
   	
   ## get all bottom inline io_pad list and sort tis list by coordinate
   set all_bottom_io_cell_sort_list ""
   #set all_bottom_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true &&io_guide==[get_io_guides *bottom]"]]
   set all_bottom_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true &&io_guide==[get_io_guides *bottom] && ref_name!=PRCUTA && (ref_name==$io_analog_vss_pad || ref_name==$io_analog_vdd_pad)"]] ; # pk: exclude the power-cut cells
#   set all_bottom_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true && orientation==R0"]]
   foreach bottom_io_cell $all_bottom_io_cell_list {
   	set io_sort_index [lindex [get_attribute [get_cells $bottom_io_cell] origin] 0]
   	lappend all_bottom_io_cell_sort_list [list $bottom_io_cell $io_sort_index]
   }
   set all_bottom_io_cell_sort_list [lsort -real -index 1 $all_bottom_io_cell_sort_list]

#   set all_io_cell_list [concat $all_left_io_cell_sort_list $all_top_io_cell_sort_list $all_right_io_cell_sort_list $all_bottom_io_cell_sort_list]
   set all_io_cell_list [concat $all_bottom_io_cell_sort_list]
   
   ## remove current exist inline bonding pad cell
   set get_bond_pad_cells_cmd "get_cells -quiet -hier -f \"ref_name =="
   append get_bond_pad_cells_cmd $bond_pad_ref_name "\""
   
   set exist_bond_pad_list [eval $get_bond_pad_cells_cmd]
   
   if { $exist_bond_pad_list !=""} {
      echo "==== INFO: remove pre-exist inline bond pad cell $bond_pad_ref_name."
      remove_cell $exist_bond_pad_list
      } else {
      echo "==== INFO: current cell" [get_object_name [current_design]] "don't exist inline bond pad cell $bond_pad_ref_name."      
      }

   ## remove current exist stagger bonding pad cell
   if {$stagger == "true"}  {
     set get_stagger_bond_pad_cells_cmd "get_cells -quiet -hier -f \"ref_name =="
     append get_stagger_bond_pad_cells_cmd $stagger_bond_pad_ref_name "\""
     
     set exist_stagger_bond_pad_list [eval $get_stagger_bond_pad_cells_cmd]
     
     if { $exist_stagger_bond_pad_list !=""} {
        echo "==== INFO: remove pre-exist stagger bond pad cell $stagger_bond_pad_ref_name."
        remove_cell $exist_stagger_bond_pad_list
        } else {
        echo "==== INFO: current cell" [get_object_name [current_design]] "don't exist stagger bond pad cell $stagger_bond_pad_ref_name."      
	}
   }

   ## stagger pad counter
   set bottom_i 1

   # Modification made to ensure required offset
   set BOND_PAD_OFFSET 0.0
   
   foreach io_cell $all_io_cell_list {
   
      set io_cell_bbox   [get_attribute [get_cells [lindex $io_cell 0]] bbox]
      set io_cell_orient [get_attribute [get_cells [lindex $io_cell 0]] orientation]
      set io_cell_LL_X [lindex $io_cell_bbox 0 0]
      set io_cell_LL_Y [lindex $io_cell_bbox 0 1]
      set io_cell_UR_X [lindex $io_cell_bbox 1 0]
      set io_cell_UR_Y [lindex $io_cell_bbox 1 1]
   
      set bond_pad_name ""
#      append bond_pad_name [get_attribute [get_cells [lindex $io_cell 0]] name] "_PAD"
      append bond_pad_name [get_object_name [lindex $io_cell 0]] "_BONDPAD"
	 
      ## bottom side io cell
      if { $io_cell_orient == "R0" } {

	 if {$stagger == "true" && ![expr $bottom_i % 2]} {

	     create_cell $bond_pad_name $stagger_bond_pad_ref_name
             set bond_pad_LL_X $io_cell_LL_X
#             set bond_pad_LL_Y [expr $io_cell_LL_Y - $stagger_pad_height]
             set bond_pad_LL_Y [expr $io_cell_LL_Y - $stagger_pad_height + $BOND_PAD_OFFSET]

	 } else {
	
	     create_cell $bond_pad_name $bond_pad_ref_name
#	     set bond_pad_LL_X [expr $io_cell_LL_X + $BOND_PAD_OFFSET]
	     set bond_pad_LL_X [expr $io_cell_LL_X]
             set bond_pad_LL_Y [expr $io_cell_LL_Y - $pad_height + $BOND_PAD_OFFSET]
	     set bond_pad_orient "R0"

          }

	  set bottom_i [expr $bottom_i + 1]

         }
    
#    set_attribute -quiet $bond_pad_name orientation $io_cell_orient
    set_attribute -quiet $bond_pad_name orientation $bond_pad_orient
    move_objects -to [list $bond_pad_LL_X $bond_pad_LL_Y] [get_cells $bond_pad_name]
   }
   
   ## get current inline bonding pad cell
   set get_bond_pad_cells_cmd "get_cells -hier -f \"ref_name =="
   append get_bond_pad_cells_cmd $bond_pad_ref_name "\""
   
   echo "==== INFO: Total add" [sizeof_collection [eval $get_bond_pad_cells_cmd]] "inline bond pad cell $bond_pad_ref_name."
   
   ## get all stagger io_pad list
   if {$stagger == "true"}  {
     set get_stagger_bond_pad_cells_cmd "get_cells -hier -f \"ref_name =="
     append get_stagger_bond_pad_cells_cmd $stagger_bond_pad_ref_name "\""
     echo "==== INFO: Total add" [sizeof_collection [eval $get_stagger_bond_pad_cells_cmd]] "stagger bond pad cell $stagger_bond_pad_ref_name."
   }

   unsuppress_message {HDU-104 HDUEDIT-104}
#   set_object_snap_type -enabled $oldSnapState
   set_snap_setting -enabled false
   
}

define_proc_attributes createNplace_bondpads_analog_power \
  -info "createNplace_bondpads_analog_power # create and place bond pad" \
  -define_args {
	{-inline_pad_ref_name "inline bond pad reference name" inline_pad_ref_name string required}
	{-stagger "inline or stagger style bond pad <true | false(default)>" stagger string optional}
	{-stagger_pad_ref_name "stagger bond pad reference name" stagger_pad_ref_name string optional}
}

proc createNplace_bondpads_analog {args} {
  source rm_setup/icc2_common_setup.tcl ;# pk
  
  parse_proc_arguments -args $args pargs
  
  ## get bond pad style 
  if {[info exists pargs(-stagger)]} {
     set stagger $pargs(-stagger)
  } else {
     set stagger false
  }
  
  ## get inline bond pad ref_name
  if {[info exists pargs(-inline_pad_ref_name)]} {

      set bond_pad_ref_name $pargs(-inline_pad_ref_name)
      ## check specified inline bond pad cell
      if {[get_lib_cells $bond_pad_ref_name] == "" } {
            echo "==== INFO: You specified inline bond pad cell $bond_pad_ref_name don't exist in physical library."
            return
      }

   } else {
        echo "==== INFO: Please specify the inline bond pad ref_name."
      return
   }

   ## get stagger bond pad ref_name
   if { $stagger == "true" } {
       if {[info exists pargs(-stagger_pad_ref_name)]} {
           set stagger_bond_pad_ref_name $pargs(-stagger_pad_ref_name)
           ## check specified inline bond pad cell
           if {[get_lib_cells $stagger_bond_pad_ref_name] == "" } {
                 echo "==== INFO: You specified stagger bond pad cell $stagger_bond_pad_ref_name don't exist in physical library."
                 return
           }
     } else {
	   echo "==== INFO: Please specify the stagger bond pad ref_name." 
	   return
      }
   }
   
   set oldSnapState [set_snap_setting -enabled false]
   suppress_message {HDU-104 HDUEDIT-104}
   
   ## get bond pad height & width
   set bond_pad_bbox [get_attribute [get_lib_cells $bond_pad_ref_name] bbox]
   set pad_width     [expr [lindex $bond_pad_bbox 1 0] - [lindex $bond_pad_bbox 0 0]]
   set pad_height    [expr [lindex $bond_pad_bbox 1 1] - [lindex $bond_pad_bbox 0 1]]
  
   if {$stagger == "true" } {

      ## get stagger bond pad height & width
      set stagger_bond_pad_bbox [get_attribute [get_lib_cells $stagger_bond_pad_ref_name] bbox]
      set stagger_pad_width     [expr [lindex $stagger_bond_pad_bbox 1 0] - [lindex $stagger_bond_pad_bbox 0 0]]
      set stagger_pad_height    [expr [lindex $stagger_bond_pad_bbox 1 1] - [lindex $stagger_bond_pad_bbox 0 1]]
   }
   	
   ## get all bottom inline io_pad list and sort tis list by coordinate
   set all_bottom_io_cell_sort_list ""
   #set all_bottom_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true &&io_guide==[get_io_guides *bottom]"]]
   set all_bottom_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true &&io_guide==[get_io_guides *bottom] && ref_name!=PRCUTA && (ref_name==PDB1A )"]] ; # pk: exclude the power-cut cells
#   set all_bottom_io_cell_list [collection_to_list -name_only -no_braces [get_cells -hier -f " is_io==true && orientation==R0"]]
   foreach bottom_io_cell $all_bottom_io_cell_list {
   	set io_sort_index [lindex [get_attribute [get_cells $bottom_io_cell] origin] 0]
   	lappend all_bottom_io_cell_sort_list [list $bottom_io_cell $io_sort_index]
   }
   set all_bottom_io_cell_sort_list [lsort -real -index 1 $all_bottom_io_cell_sort_list]

 #  set all_io_cell_list [concat $all_left_io_cell_sort_list $all_top_io_cell_sort_list $all_right_io_cell_sort_list $all_bottom_io_cell_sort_list]
   set all_io_cell_list [concat $all_bottom_io_cell_sort_list]
   
   ## remove current exist inline bonding pad cell
   set get_bond_pad_cells_cmd "get_cells -quiet -hier -f \"ref_name =="
   append get_bond_pad_cells_cmd $bond_pad_ref_name "\""
   
   set exist_bond_pad_list [eval $get_bond_pad_cells_cmd]
   
   if { $exist_bond_pad_list !=""} {
      echo "==== INFO: remove pre-exist inline bond pad cell $bond_pad_ref_name."
      remove_cell $exist_bond_pad_list
      } else {
      echo "==== INFO: current cell" [get_object_name [current_design]] "don't exist inline bond pad cell $bond_pad_ref_name."      
      }

   ## remove current exist stagger bonding pad cell
   if {$stagger == "true"}  {
     set get_stagger_bond_pad_cells_cmd "get_cells -quiet -hier -f \"ref_name =="
     append get_stagger_bond_pad_cells_cmd $stagger_bond_pad_ref_name "\""
     
     set exist_stagger_bond_pad_list [eval $get_stagger_bond_pad_cells_cmd]
     
     if { $exist_stagger_bond_pad_list !=""} {
        echo "==== INFO: remove pre-exist stagger bond pad cell $stagger_bond_pad_ref_name."
        remove_cell $exist_stagger_bond_pad_list
        } else {
        echo "==== INFO: current cell" [get_object_name [current_design]] "don't exist stagger bond pad cell $stagger_bond_pad_ref_name."      
	}
   }

   ## stagger pad counter
   set bottom_i 1

   # Modification made to ensure required offset
   set BOND_PAD_OFFSET 0.0
   
   foreach io_cell $all_io_cell_list {
   
      set io_cell_bbox   [get_attribute [get_cells [lindex $io_cell 0]] bbox]
      set io_cell_orient [get_attribute [get_cells [lindex $io_cell 0]] orientation]
      set io_cell_LL_X [lindex $io_cell_bbox 0 0]
      set io_cell_LL_Y [lindex $io_cell_bbox 0 1]
      set io_cell_UR_X [lindex $io_cell_bbox 1 0]
      set io_cell_UR_Y [lindex $io_cell_bbox 1 1]
   
      set bond_pad_name ""
#      append bond_pad_name [get_attribute [get_cells [lindex $io_cell 0]] name] "_PAD"
      append bond_pad_name [get_object_name [lindex $io_cell 0]] "_BONDPAD"
   
      ## bottom side io cell
      if { $io_cell_orient == "R0" } {

	 if {$stagger == "true" && ![expr $bottom_i % 2]} {

	     create_cell $bond_pad_name $stagger_bond_pad_ref_name
             set bond_pad_LL_X $io_cell_LL_X
#             set bond_pad_LL_Y [expr $io_cell_LL_Y - $stagger_pad_height]
             set bond_pad_LL_Y [expr $io_cell_LL_Y - $stagger_pad_height + $BOND_PAD_OFFSET]

	 } else {
	
	     create_cell $bond_pad_name $bond_pad_ref_name
#	     set bond_pad_LL_X [expr $io_cell_LL_X + $BOND_PAD_OFFSET]
	     set bond_pad_LL_X [expr $io_cell_LL_X]
             set bond_pad_LL_Y [expr $io_cell_LL_Y - $pad_height + $BOND_PAD_OFFSET]
	     set bond_pad_orient "R0"

          }

	  set bottom_i [expr $bottom_i + 1]

         }
    
#    set_attribute -quiet $bond_pad_name orientation $io_cell_orient
    set_attribute -quiet $bond_pad_name orientation $bond_pad_orient
    move_objects -to [list $bond_pad_LL_X $bond_pad_LL_Y] [get_cells $bond_pad_name]
   
   }
   
   ## get current inline bonding pad cell
   set get_bond_pad_cells_cmd "get_cells -hier -f \"ref_name =="
   append get_bond_pad_cells_cmd $bond_pad_ref_name "\""
   
   echo "==== INFO: Total add" [sizeof_collection [eval $get_bond_pad_cells_cmd]] "inline bond pad cell $bond_pad_ref_name."
   
   ## get all stagger io_pad list
   if {$stagger == "true"}  {
     set get_stagger_bond_pad_cells_cmd "get_cells -hier -f \"ref_name =="
     append get_stagger_bond_pad_cells_cmd $stagger_bond_pad_ref_name "\""
     echo "==== INFO: Total add" [sizeof_collection [eval $get_stagger_bond_pad_cells_cmd]] "stagger bond pad cell $stagger_bond_pad_ref_name."
   }

   unsuppress_message {HDU-104 HDUEDIT-104}
#   set_object_snap_type -enabled $oldSnapState
   set_snap_setting -enabled false
   
}

define_proc_attributes createNplace_bondpads_analog \
  -info "createNplace_bondpads_analog # create and place bond pad" \
  -define_args {
	{-inline_pad_ref_name "inline bond pad reference name" inline_pad_ref_name string required}
	{-stagger "inline or stagger style bond pad <true | false(default)>" stagger string optional}
	{-stagger_pad_ref_name "stagger bond pad reference name" stagger_pad_ref_name string optional}
}
