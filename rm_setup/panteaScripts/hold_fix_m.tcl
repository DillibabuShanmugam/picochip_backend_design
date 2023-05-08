####################################################################
#                                                                  #
# Author             :  Synopsys Inc.
# Description        :  Script to fix Hold Violations including    #
#                       no margin paths                            #
# Version            :  1.1                                        #
# Completion Date    :  26 Mar 2008                                #
# Modified date      :  29 Mar 2008                                #
####################################################################



proc hold_fix_m {args} {


 parse_proc_arguments -args $args pargs

  set lib_cell $pargs(-lib_cell)
 
  if {[info exists pargs(-report_constraints_file)]} {
    set file_name $pargs(-report_constraints_file)
  } else {
    echo "No report_constraints file provided, Generating report for hold fixing using: report_constraints -all -min_delay"
    sh rm -Rf report_constraints_m.tcl1978
    report_constraints -all -min_delay > report_constraints_m.tcl1978
    set file_name report_constraints_m.tcl1978
  }

  if {[info exists pargs(-prefix)]} {
    set prefix $pargs(-prefix)
  } else {
    echo "Warning: Setting default prefix for newly added cells as holdFix"
    set prefix holdFix
  }

 if {[info exists pargs(-factor)]} {
    set factor $pargs(-factor)
  } else {
    set factor 1
  } 
  
  if {[info exists pargs(-stage)]} {
    set stage $pargs(-stage)
  } else {
    set stage 1
  } 
if {[info exists pargs(-debug_mode)]} {
    set debug_mode_m $pargs(-debug_mode)
  } else {
    set debug_mode_m 0
  } 

sh rm -Rf insert_buffer.tcl parse_m.tcl1978 no_margin_m.tcl1978 half_margin_fix_m.tcl1978
sh touch insert_buffer.tcl parse_m.tcl1978 no_margin_m.tcl1978 half_margin_fix_m.tcl1978

###################### Parse report_constraints file
set count 0
set end_point_flag 0
set infile [open $file_name r]
 while { [gets $infile line] >= 0} {
  if { [ regexp {min_delay/hold} $line]} {
  set count 1 }
  incr count
  if { $count == 6 } {
	
        set count 5
        
 
  if { [llength $line] == 1 } {
  set end_point_flag 1
  set end_point [lindex $line 0]
  }
  
  if { $end_point_flag == 1 && [llength $line] == 5} {
  set end_point_flag 0
  set end_point_slack [lindex $line 3]
  echo "$end_point $end_point_slack" >> parse_m.tcl1978
  }
  
  if { [llength $line] == 6 } {
  set end_point [lindex $line 0]
  set end_point_slack [lindex $line 4]
  echo "$end_point $end_point_slack" >> parse_m.tcl1978
  }
  
        }}

######################## end parsing report_constraints file


################initial loop start

set file_name parse_m.tcl1978
set parsefile [open $file_name r]

while {[gets $parsefile line] >=0} {
set end_point [lindex $line 0]
set min_path [get_timing_paths -delay_type min -to $end_point]
#pk set pre_setup [get_attribute $end_point worst_slack]
set pre_setup [get_attribute $end_point worst_max_slack] ;# pk
set setup_slack [expr $pre_setup / $factor]
set hold_slack [lindex $line 1]


 
    if {$setup_slack < 0.0} {
      
      echo "$end_point $hold_slack" >> no_margin_m.tcl1978
      
    } else {
      
    set hold_setup_th [expr $setup_slack + $hold_slack]
    
    if { $hold_setup_th < 0 } {
   set iteration_setup_slack $setup_slack
  if { $debug_mode_m == 1} {
      echo "#######CHECK POINT: HALF MARGIN, END POINT:  $end_point, PRE SETUP $pre_setup SETUP SLACK $setup_slack , HOLD SLACK $hold_slack " >> insert_buffer.tcl
      }
 
  	for {set x 1} {$x <[llength $lib_cell]} { incr x 2 } {
   
   	set num_buf [lindex [split [expr $iteration_setup_slack / [lindex $lib_cell $x]] {.}] 0]
	set iteration_setup_slack [expr $iteration_setup_slack - [expr $num_buf * [lindex $lib_cell $x]]]
 
	 if { $debug_mode_m == 1} {
     	echo "#######num_buf $num_buf iteration_hold $iteration_hold_pos lib number [lindex $lib_cell $x]" >> insert_buffer.tcl
      	}
	
         if { $num_buf >  0 } {
      echo "insert_buffer $end_point [lindex $lib_cell [expr $x - 1]] -no_of_cells $num_buf -new_cell_names $prefix" >> insert_buffer.tcl
      }
      }
      echo "$end_point $hold_slack" >> half_margin_fix_m.tcl1978
      
      } else {
      
      set hold_pos [expr 0 - $hold_slack]
      set iteration_hold_pos $hold_pos
      if { $debug_mode_m == 1} {
      echo "######CHECK POINT: FULL MARGIN, END POINT $end_point , PRE SETUP $pre_setup SETUP SLACK $setup_slack , HOLD_SLACK $hold_slack " >> insert_buffer.tcl
      }
      set compensate 0
      for { set x 1 } {$x < [llength $lib_cell]} { incr x 2} {
      set num_buf [lindex [split [expr $iteration_hold_pos / [lindex $lib_cell $x]] {.}] 0]
      set iteration_hold_pos [expr $iteration_hold_pos - [expr $num_buf * [lindex $lib_cell $x]]]
      
      set compensate [expr $compensate + [expr $num_buf * [lindex $lib_cell $x]]]
			
      if { $x == [expr [llength $lib_cell] - 1]} {
      set compensate [expr $compensate + [lindex $lib_cell $x]]
      if { $compensate <= $setup_slack } {	
      incr num_buf
      } else {
      echo "$end_point $hold_slack" >> half_margin_fix_m.tcl1978
      }
      }
      
      if { $debug_mode_m == 1 } {
      echo "#######num_buf $num_buf iteration_hold $iteration_hold_pos lib number [lindex $lib_cell $x]" >> insert_buffer.tcl
      }
      
      
      if { $num_buf > 0 } {
      echo "insert_buffer $end_point [lindex $lib_cell [expr $x -1 ]] -no_of_cells $num_buf -new_cell_names $prefix" >> insert_buffer.tcl
      }
      }
      }
    }
    
    }

###########################initial loop ends

if { $stage == 2 } {

#################### No margin loop starts

set file_name no_margin_m.tcl1978
set parsefile [open $file_name r]

while {[gets $parsefile line] >=0} {
set end_point [lindex $line 0]
set min_path [get_timing_paths -delay_type min -to $end_point]
#pk set pre_setup [get_attribute $end_point worst_slack]
set pre_setup [get_attribute $end_point worst_max_slack] ;# pk
set setup_slack [expr $pre_setup / $factor]
set hold_slack [lindex $line 1]

   
 		set list_of_pins [get_attribute $min_path points]
 		set flag 1
 		foreach_in_collection pin_iteration $list_of_pins {
		 set type_of_object [get_attribute $pin_iteration object]
 		 set pin_name [get_object_name $type_of_object]
 		 #pk set pre_pin_slack [get_attribute $pin_name worst_slack]
 		 set pre_pin_slack [get_attribute $pin_name worst_max_slack] ;# pk
		 set pin_slack [expr $pre_pin_slack / $factor] 
		 
		 set threshold [lindex $lib_cell [expr [llength $lib_cell] - 1]]
		 set num_buf_tmp [lindex [split [expr $pin_slack / $threshold] {.}] 0]
		 set hold_pos_slack [expr 0 - $hold_slack ]
		 set num_buf [lindex [split [expr $hold_pos_slack / $threshold] {.}] 0]
		 set num_buf [expr $num_buf + 1]
		 
		 if { $num_buf > $num_buf_tmp } {
		 set num_buf $num_buf_tmp
		 }
		 
		 if   { [llength [get_pins $type_of_object -filter direction==out]] == 1 && $flag == 1 && $num_buf > 0} {
		 
		 if { $debug_mode_m == 1 } {
		 echo "#####CHECK POINT: NO MARGIN, END POINT  $end_point , PRE SETUP $pre_setup SETUP SLACK $setup_slack , HOLD SLACK $hold_slack" >> insert_buffer.tcl
		 echo "#####INTERMEDIATE PINS:  [get_object_name [get_pins $pin_name ] ], PRE_PIN_SLACK $pre_pin_slack SETUP SLACK ON THIS PIN $pin_slack" >> insert_buffer.tcl
		 }
		 set flag 0
		 
		 if { $hold_pos_slack > $pin_slack } {
		 set iteration_slack $pin_slack
		 } else {
		 set iteration_slack $hold_pos_slack
		 }
		 set compensate 0
		 for {set x 1} {$x <[llength $lib_cell]} { incr x 2 } {
   			set num_buf [lindex [split [expr $iteration_slack / [lindex $lib_cell $x]] {.}] 0]
			set iteration_slack [expr $iteration_slack - [expr $num_buf * [lindex $lib_cell $x]]]
 			set compensate [expr $compensate + [expr $num_buf * [lindex $lib_cell $x]]]
			
	 		if { $debug_mode_m == 1} {
     			echo "#######num_buf $num_buf lib number [lindex $lib_cell $x]" >> insert_buffer.tcl
      			}
			
			if { $x == [expr [llength $lib_cell] - 1]} {
			set compensate [expr $compensate + [lindex $lib_cell $x]]
			if { $compensate <= $pin_slack } {
      			incr num_buf
      			}
			}
			
         		if { $num_buf >  0 } {
      			echo "insert_buffer [get_object_name [get_pins $pin_name]] [lindex $lib_cell [expr $x - 1]] -no_of_cells $num_buf -new_cell_names $prefix" >> insert_buffer.tcl
      				}
      			}
		 
 			}
			}
 
 }
############################# No margin loop ends


############################# Half margin fix loop starts

set file_name half_margin_fix_m.tcl1978
set parsefile [open $file_name r]

while {[gets $parsefile line] >=0} {
set end_point [lindex $line 0]
set min_path [get_timing_paths -delay_type min -to $end_point]
#pk set pre_setup [get_attribute $end_point worst_slack]
set pre_setup [get_attribute $end_point worst_max_slack] ;# pk
set setup_slack [expr $pre_setup / $factor]
set hold_slack [lindex $line 1]

 		set list_of_pins [get_attribute $min_path points]
 		set flag 1
		set num_buf 1
 		foreach_in_collection pin_iteration $list_of_pins {
		 set type_of_object [get_attribute $pin_iteration object]
 		 set pin_name [get_object_name $type_of_object]
                 #pk set pre_pin_slack [get_attribute $pin_name worst_slack]
                 set pre_pin_slack [get_attribute $pin_name worst_max_slack] ;# pk
                 set pin_slack [expr $pre_pin_slack / $factor]
                 
                set getting_length [llength $lib_cell]
		set gettting_length [expr $getting_length -1]
		set getting_lib_index [llength $lib_cell]
		set getting_lib_index [expr $getting_lib_index - 2]
		 if   { $pin_slack > [lindex $lib_cell $getting_length] && [llength [get_pins $type_of_object -filter direction==out]] ==1 && $flag == 1} {
		 
		 if { $debug_mode_m == 1 } {
		 echo "#####CHECK POINT: HALF MARGIN 2 FIX LOOP,  END POINT $end_point , PRE SETUP $pre_setup SETUP SLACK $setup_slack  ,HOLD SLACK $hold_slack" >> insert_buffer.tcl
		 echo "##### INTERMEDIATE PINS:  [get_object_name [get_pins $pin_name ]] ,PRE_PIN_SLACK $pre_pin_slack SETUP SLACK ON THIS PIN $pin_slack" >> insert_buffer.tcl
		 }
		 
		 echo "insert_buffer [get_object_name [get_pins $pin_name]] [lindex $lib_cell $getting_lib_index] -no_of_cells $num_buf -new_cell_names $prefix" >> insert_buffer.tcl
		 set flag 0
 			}
			}
 
 }
 
############################### Half margin fix loop ends
} 
##### Intermediate_pin fixing ends

############# Removing redundant files
if { $debug_mode_m == 0} {
sh rm -Rf parse_m.tcl1978 no_margin_m.tcl1978 half_margin_fix_m.tcl1978
}
 
}

 define_proc_attributes hold_fix_m -info "Fixes Hold Violations by inserting the specified buffers" \
  -define_args \
  {
    {-lib_cell "specify the library cell to be used for Hold Optimization" string string required} 
    {-report_constraints_file "timing report generated by report_constraints -all -min_delay. Default: report_constraints.tcl1978" string string optional}
    {-prefix "specify the name prefix used for newly added cells. Default: holdFix" string string optional}
    {-factor " The factor by which setup and hold delay will vary. Default: 1" string string optional}
    {-stage "The stage should be either 1-> end_point_fixing or 2->include_intermediate_pin_fixing" string string optional}
    {-debug_mode "Set this to 1 to get more information" string string optional}
  }


