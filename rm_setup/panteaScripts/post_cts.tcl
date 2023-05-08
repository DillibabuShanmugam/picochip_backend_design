if {[info exists timestamp]} {
        puts "INFO: timestamp already set to $timestamp"
} else {
        set timestamp [clock format [clock seconds] -format {%b%d_%H%M%S}]
        puts "INFO: Setting timestamp to $timestamp"
}



# setup violations:
report_constraints -all_violators -max_delay -nosplit > $REPORTS_DIR/setup_viol_$timestamp.rpt

# hold violations:
report_constraints -all_violators -min_delay -nosplit > $REPORTS_DIR/hold_viol_$timestamp.rpt

# max cap violations:
report_constraints -all_violators -max_capacitance -nosplit > $REPORTS_DIR/maxcap_viol_$timestamp.rpt
