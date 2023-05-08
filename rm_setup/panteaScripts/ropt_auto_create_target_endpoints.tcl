proc ropt_auto_create_target_endpoints { args } {
   set curr_scen [current_scenario]
   sh rm -f ./top_violators*.rpt
   sh rm -f ./ropt_end_point_list.rpt
   parse_proc_arguments -args $args results
   if {![info exists results(-scenarios)] } {
      set results(-scenarios) [get_object_name [get_scenarios -filter "active==true"]]
      puts "Using by default all active scenarios for the block: $results(-scenarios)"
   }
   if {![info exists results(-path_groups)] } {
      set results(-path_groups) [get_object_name [get_path_groups]]
      puts "Using by default all path groups in the design : $results(-path_groups)"
   }
   if {![info exists results(-max_endpoints)] } {
      set results(-max_endpoints) 100
      puts "Using default value for max_endpoints as : $results(-max_endpoints)"
   }
   set scenarios $results(-scenarios)
   set path_groups $results(-path_groups)
   set max_end_pts $results(-max_endpoints)

   update_timing -full
   foreach ss $scenarios {
      current_scenario $ss
      foreach pp $path_groups {
         ## You can customize the report_timing command, if needed
         report_timing -max_paths $max_end_pts -path_type end -nosplit -slack_lesser_than 0.000 \
            -groups [get_object_name $pp] >> top_violators_$ss.rpt
         #puts "********************* [get_object_name [get_scenarios $ss]]*****  [get_object_name [get_path_groups $pp]]*****"
      }
      sh grep -v "Warning:.*$ss*" top_violators_$ss.rpt > top_violators_$ss.rpt_temp
      exec sed -n "/$ss/p" top_violators_$ss.rpt_temp | awk {{print $1}} >> ropt_end_point_list.rpt
   }
   current_scenario $curr_scen
   sh rm -f ./top_violators*.rpt_temp
}

define_proc_attributes ropt_auto_create_target_endpoints \
   -info "Procedure to automate the endpoint file creation for route_opt target endpoints" \
   -define_args {
      {-scenarios  "active scenario list" scenariolist list optional}
      {-path_groups    "valid path group list" pathgrouplist list optional}
      {-max_endpoints "max number of violating endpoints" maxendpt int optional}
   }
