source rm_setup/panteaScripts/ropt_auto_create_target_endpoints.tcl

set setup_cnt 0
set setup_max 10

report_qor > qor_before
exec touch $setup_cnt
while {$setup_cnt < $setup_max} {
        ropt_auto_create_target_endpoints
        set_route_opt_target_endpoints -setup_endpoints ./ropt_end_point_list.rpt
        route_opt
	save_block
        incr setup_cnt
        exec touch $setup_cnt
        exec rm -f [expr $setup_cnt-1]
}
report_qor > qor_after

