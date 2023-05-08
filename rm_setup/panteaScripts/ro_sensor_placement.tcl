set SQ_ROSENSOR_WIDTH [expr 100.6 - 32]
set SQ_ROSENSOR_HEIGHT [expr 100.6 - 32] 

set x_offset [expr 1.35 + 16]
set y_offset [expr 1.35 + 16]

## numbered from left to right and top to bottom
# top:
set ro_sensor_ll_coord(0) [list [expr 1145 + $x_offset] [expr 4345 + $y_offset]]
set ro_sensor_ll_coord(1) [list [expr 1545 + $x_offset] [expr 4345 + $y_offset]]
set ro_sensor_ll_coord(2) [list [expr 1145 + $x_offset] [expr 3945 + $y_offset]]
set ro_sensor_ll_coord(3) [list [expr 1545 + $x_offset] [expr 3945 + $y_offset]]
set ro_sensor_ll_coord(4) [list [expr 1145 + $x_offset] [expr 3645 + $y_offset]]
set ro_sensor_ll_coord(5) [list [expr 1545 + $x_offset] [expr 3645 + $y_offset]]
set ro_sensor_ll_coord(6) [list [expr 1145 + $x_offset] [expr 3245 + $y_offset]]
set ro_sensor_ll_coord(7) [list [expr 1545 + $x_offset] [expr 3245 + $y_offset]]
set ro_sensor_ll_coord(8) [list [expr 1145 + $x_offset] [expr 2845 + $y_offset]]
set ro_sensor_ll_coord(9) [list [expr 1545 + $x_offset] [expr 2845 + $y_offset]]

# middle:
set ro_sensor_ll_coord(10) [list [expr 345  + $x_offset] [expr 2545 + $y_offset]]
set ro_sensor_ll_coord(11) [list [expr 745  + $x_offset] [expr 2545 + $y_offset]]
set ro_sensor_ll_coord(12) [list [expr 1145 + $x_offset] [expr 2545 + $y_offset]]
set ro_sensor_ll_coord(13) [list [expr 1545 + $x_offset] [expr 2545 + $y_offset]]
set ro_sensor_ll_coord(14) [list [expr 1945 + $x_offset] [expr 2545 + $y_offset]]
set ro_sensor_ll_coord(15) [list [expr 2345 + $x_offset] [expr 2545 + $y_offset]]
set ro_sensor_ll_coord(16) [list [expr 345  + $x_offset] [expr 2145 + $y_offset]]
set ro_sensor_ll_coord(17) [list [expr 745  + $x_offset] [expr 2145 + $y_offset]]
set ro_sensor_ll_coord(18) [list [expr 1145 + $x_offset] [expr 2145 + $y_offset]]
set ro_sensor_ll_coord(19) [list [expr 1545 + $x_offset] [expr 2145 + $y_offset]]
set ro_sensor_ll_coord(20) [list [expr 1945 + $x_offset] [expr 2145 + $y_offset]]
set ro_sensor_ll_coord(21) [list [expr 2345 + $x_offset] [expr 2145 + $y_offset]]


# bottom:
set ro_sensor_ll_coord(22) [list [expr 1145 + $x_offset] [expr 1845 + $y_offset]]
set ro_sensor_ll_coord(23) [list [expr 1545 + $x_offset] [expr 1845 + $y_offset]]
set ro_sensor_ll_coord(24) [list [expr 1145 + $x_offset] [expr 1445 + $y_offset]]
set ro_sensor_ll_coord(25) [list [expr 1545 + $x_offset] [expr 1445 + $y_offset]]
set ro_sensor_ll_coord(26) [list [expr 1145 + $x_offset] [expr 1045 + $y_offset]]
set ro_sensor_ll_coord(27) [list [expr 1545 + $x_offset] [expr 1045 + $y_offset]]
set ro_sensor_ll_coord(28) [list [expr 1145 + $x_offset] [expr 745  + $y_offset]]
set ro_sensor_ll_coord(29) [list [expr 1545 + $x_offset] [expr 745  + $y_offset]]
set ro_sensor_ll_coord(30) [list [expr 1145 + $x_offset] [expr 345  + $y_offset]]
set ro_sensor_ll_coord(31) [list [expr 1545 + $x_offset] [expr 345  + $y_offset]]



set tri_ro_index_list "0  3  4  7  8 11 13 15 16 18 20 23 24 27 28 31" 
set mux_ro_index_list "1  2  5  6  9 10 12 14 17 19 21 22 25 26 29 30"

for {set i 0} {$i < 32} {incr i} {
    set ro_sensor_ur_coord($i) [list [expr {[lindex $ro_sensor_ll_coord($i) 0]+$SQ_ROSENSOR_WIDTH}] [expr {[lindex $ro_sensor_ll_coord($i) 1]+$SQ_ROSENSOR_HEIGHT}]]
}

set i 0
foreach tri_ro_index $tri_ro_index_list {
    set xll [lindex $ro_sensor_ll_coord(${tri_ro_index}) 0]
    set yll [lindex $ro_sensor_ll_coord(${tri_ro_index}) 1]
    set xur [lindex $ro_sensor_ur_coord(${tri_ro_index}) 0]
    set yur [lindex $ro_sensor_ur_coord(${tri_ro_index}) 1]
    set coord "{{$xll $yll} {$xur $yur}}"

    # Remove bound if it already exists
    if {[sizeof_collection [get_bounds bound_ro_sensor${tri_ro_index}]] != 0} {
        puts "Removing existing bound bound_ro_sensor${tri_ro_index}"
        remove_bounds [get_bounds bound_ro_sensor${tri_ro_index}]
    }
    create_bound -name bound_ro_sensor${tri_ro_index} -boundary $coord [get_cell picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_${i}__myro*]
    set i [expr $i+1]
}


set i 0
foreach mux_ro_index $mux_ro_index_list {
    set xll [lindex $ro_sensor_ll_coord(${mux_ro_index}) 0]
    set yll [lindex $ro_sensor_ll_coord(${mux_ro_index}) 1]
    set xur [lindex $ro_sensor_ur_coord(${mux_ro_index}) 0]
    set yur [lindex $ro_sensor_ur_coord(${mux_ro_index}) 1]
    set coord "{{$xll $yll} {$xur $yur}}"

    # Remove bound if it already exists
    if {[sizeof_collection [get_bounds bound_ro_sensor${mux_ro_index}]] != 0} {
        puts "Removing existing bound bound_ro_sensor${mux_ro_index}"
        remove_bounds [get_bounds bound_ro_sensor${mux_ro_index}]
    }
    create_bound -name bound_ro_sensor${mux_ro_index} -boundary $coord [get_cell picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_${i}__myro*]
    set i [expr $i+1]
}

