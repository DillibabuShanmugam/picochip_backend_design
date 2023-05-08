set_app_options -name plan.pgroute.max_undo_steps -value 15

if {$MV_AES} {
    set_voltage 1.62 -min 1.98 -object_list {VN1 VN2}
    set VNAME VN1
    set GNAME GN1
} else {
    set_voltage 1.62 -min 1.98 -object_list {VDD}
    set VNAME VDD
    set GNAME VSS
}

set digital_pad_height [expr [lindex [get_attribute [get_lib_cell $pad_lib/$core_vdd_pad] bbox] 1 1] - [lindex [get_attribute [get_lib_cell $pad_lib/$core_vdd_pad] bbox] 0 1]]

set analog_pad_height [expr [lindex [get_attribute [get_lib_cell tpa018nv/PDB1A] bbox] 1 1] - [lindex [get_attribute [get_lib_cell tpa018nv/PDB1A] bbox] 0 1]]

set diff_pad_height [expr $digital_pad_height - $analog_pad_height]

set offset_x [expr 0 - $diff_pad_height]
set offset_y [expr 0 - $diff_pad_height]

set digital_pad_bbox [get_attribute [get_lib_cell $pad_lib/$core_vdd_pad] bbox]
set digital_pad_height [expr [lindex $digital_pad_bbox 1 1] - [lindex $digital_pad_bbox 0 1]]
set chip_width 3000
set chip_height 5000
set seal_ring 30
set bond_pad_height 84 
set core_height [expr $chip_height - 2*$seal_ring - 2*$bond_pad_height]
set core_width [expr $chip_width - $seal_ring - 2*$bond_pad_height]
################################################################################
#-------------------------------------------------------------------------------
# P G   R I N G   C R E A T I O N
#-------------------------------------------------------------------------------
################################################################################
# Create the power and ground ring pattern

#create_pg_ring_pattern ring_pattern -horizontal_layer @hlayer \
 -horizontal_width {@hwidth} -horizontal_spacing {@hspace} \
 -vertical_layer @vlayer -vertical_width {@vwidth} \
 -vertical_spacing {@vspace} -corner_bridge @cbridge \
 -parameters {hlayer hwidth hspace vlayer vwidth vspace cbridge}

create_pg_ring_pattern ring_pattern -horizontal_layer @hlayer \
 -horizontal_width {@hwidth} \
 -vertical_layer @vlayer -vertical_width {@vwidth} -vertical_spacing {@vspace} \
 -corner_bridge @cbridge \
 -parameters {hlayer hwidth vlayer vwidth vspace cbridge}

# Set the ring strategy to apply the ring_pattern
# pattern to the core area and set the width
# and spacing parameters

set_pg_strategy ring_strat -polygon [list [list [expr $digital_pad_height] [expr $digital_pad_height]] [list [expr $core_width - $digital_pad_height] [expr $core_height - $digital_pad_height]]] \
 -pattern {{name: ring_pattern} {offset: {-45 -43}} {nets: {$VNAME $GNAME}} {parameters: {METAL5 20 METAL6 20 4 true}}} \
 -extension {{stop: outermost_ring}}
#set_pg_strategy ring_strat \
 -pattern {{name: ring_pattern} {offset: {-70 -70}} {nets: {$VNAME $GNAME}} {parameters: {METAL5 20 METAL6 20 true}}} \
 -extension {{stop: outermost_ring}} -voltage_areas "DEFAULT_VA"

# Create the ring in the design
 compile_pg -strategies ring_strat

# duplicate ring on lower rings (3 and 4):
#set_pg_strategy ring_strat_lower -polygon [list [list [expr $digital_pad_height] [expr $digital_pad_height]] [list [expr $core_width - $digital_pad_height] [expr $core_height - $digital_pad_height]]] \
 -pattern {{name: ring_pattern} {offset: {-45 -45}} {nets: {$VNAME $GNAME}} {parameters: {METAL3 20 METAL4 20 true}}} \
 -extension {{stop: outermost_ring}}
#compile_pg -strategies ring_strat_lower


# Create the separate ring for AES
if {$MV_AES} {
    set_pg_strategy ring_strat2 \
     -pattern {{name: ring_pattern} {nets: {VN2 GN2}} {parameters: {METAL5 15 METAL6 15 true}}} \
     -extension {{stop: outermost_ring}} -voltage_areas "PD_AES"
    # Create the ring in the design
    compile_pg -strategies ring_strat2
}

## mem. macro rings:
create_pg_ring_pattern macro_ring_pattern -horizontal_layer @hlayer \
 -horizontal_width {@hwidth} \
 -vertical_layer @vlayer -vertical_width {@vwidth} \
 -parameters {hlayer hwidth vlayer vwidth}

# Set the ring strategy to apply the macro_ring_pattern
# pattern to the core area and set the width
# and spacing parameters

set mem_macros [get_cells -hier *picosocInst_genblk1_ocram_controller_RAM_blk*]
set mem_macros_vdd [get_pins -all -of_objects $mem_macros -filter "name==VDD"]
set mem_macros_vss [get_pins -all -of_objects $mem_macros -filter "name==VSS"]


set_pg_strategy macro_ring_strat -macros $mem_macros \
 -pattern {{name: macro_ring_pattern} {offset: 2.5 2.5} {nets: {$VNAME $GNAME}} {parameters: {METAL3 8 METAL4 6}}} \
 -extension { {{nets: $VNAME} {stop: $mem_macros_vdd}} {{nets: $GNAME} {stop: $mem_macros_vss}} }

# Create the ring in the design
compile_pg -strategies macro_ring_strat


set_pg_strategy macro_ring_strat_higher -macros $mem_macros \
 -pattern {{name: macro_ring_pattern} {offset: 1 1} {nets: {$VNAME $GNAME}} {parameters: {METAL5 8 METAL6 6}}} \
 -extension { {{nets: $VNAME} {stop: $mem_macros_vdd}} {{nets: $GNAME} {stop: $mem_macros_vss}} }
#compile_pg -strategies macro_ring_strat_higher

## TRNG ROs' rings:
#set trng_ros [get_cells -hier -filter "ref_name==RO3_WITH_BUF_D0_REV1"]
#set trng_ros_vdd [get_pins -all -of_objects $trng_ros -filter "name==VDD_HIGH"]
#set trng_ros_vss [get_pins -all -of_objects $trng_ros -filter "name==VSS"]

#set_pg_strategy ro_trng_ring_strat -macros $trng_ros \
 -pattern {{name: macro_ring_pattern} {nets: {$VNAME $GNAME}} {parameters: {METAL3 8 METAL4 6}}} \
 -extension { {{nets: VDD_HIGH} {stop: $trng_ros_vdd}} {{nets: VSS} {stop: $trng_ros_vss}} }

# Create the ring in the design
# compile_pg -strategies trng_ring_strat


################################################################################
#-------------------------------------------------------------------------------
# P A D   T O   R I N G   P G   C O N N E C T I O N S
#-------------------------------------------------------------------------------
################################################################################

#create_pg_macro_conn_pattern hm_pattern -pin_conn_type scattered_pin -layer {M5 M6}
#create_pg_macro_conn_pattern pad_pattern -pin_conn_type scattered_pin -layers {METAL5 METAL6}
create_pg_macro_conn_pattern pad_pattern -pin_conn_type scattered_pin -layers {@hlayer @vlayer} -parameters {hlayer vlayer}

#set all_pg_pads [get_cells * -hier -filter "ref_name==VDD_NS || ref_name==VSS_NS"]
#set all_pg_pads [get_cells -hier -filter "ref_name==$core_vss_pad || ref_name==$core_vdd_pad"]
set all_vdd_pads [get_cells -hier -filter "ref_name==$core_vdd_pad"]
set all_vss_pads [get_cells -hier -filter "ref_name==$core_vss_pad"]
#set_pg_strategy s_pad -macros $all_pg_pads  -pattern {{name: pad_pattern} {nets: {VDD VDD_LOW VSS}}}
#set_pg_strategy strat_pad -macros $all_pg_pads  -pattern {{name: pad_pattern} {nets: {VDD VSS}}}
#set_pg_strategy hm_pattern -macros $all_pg_pads  -pattern {{name: pad_pattern} {nets: {VDD VDD_LOW VSS}}}

#compile_pg -strategies strat_pad
#create_pg_macro_conn_pattern pad_pattern -pin_conn_type scattered_pin -layer {METAL5 METAL4}
#set all_pg_pads [get_cells * -hier -filter "ref_name==$core_vdd_pad || ref_name==$core_vss_pad"]
set_pg_strategy s_pad_vdd -macros $all_vdd_pads  -pattern {{name: pad_pattern} {nets: {VDD}} {parameters: {METAL3 METAL4}}}
set_pg_strategy s_pad_vss -macros $all_vss_pads  -pattern {{name: pad_pattern} {nets: {VSS}} {parameters: {METAL3 METAL4}}}
#set_pg_strategy s_pad -macros {vdd1left vdd2left vss1left vss2left vdd1right vss1right vdd2right vss2right }  -pattern {{name: pad_pattern} {nets: {VDD VSS}} {parameters: {METAL5 METAL6}} }


compile_pg -strategies s_pad_vdd -ignore_drc
compile_pg -strategies s_pad_vss -ignore_drc



#create_pg_macro_conn_pattern mem_macro_pin_pattern -pin_conn_type ring_pin -number @num -layers {@hlayer @vlayer} -parameters {num hlayer vlayer}
create_pg_macro_conn_pattern mem_macro_pin_pattern -pin_conn_type scattered_pin -layers {@hlayer @vlayer} -parameters {hlayer vlayer}
create_pg_macro_conn_pattern mem_macro_pin_pattern_nolayer -pin_conn_type scattered_pin 

#set_pg_strategy s_mem_macro_vss_pins -macros $mem_macros  -pattern {{name: mem_macro_pin_pattern} {nets: {VSS}} {parameters: {20 METAL5 METAL6}}}
#set_pg_strategy s_mem_macro_vdd_pins -macros $mem_macros  -pattern {{name: mem_macro_pin_pattern} {nets: {VDD}} {parameters: {20 METAL5 METAL6}}}

set_pg_strategy s_mem_macro_vss_pins -macros $mem_macros  -pattern {{name: mem_macro_pin_pattern} {nets: {VSS}} {parameters: {METAL5 METAL4}}}
set_pg_strategy s_mem_macro_vdd_pins -macros $mem_macros  -pattern {{name: mem_macro_pin_pattern} {nets: {VDD}} {parameters: {METAL5 METAL4}}}
set_pg_strategy s_mem_macro_vss_pins_nolayer -macros $mem_macros  -pattern {{name: mem_macro_pin_pattern_nolayer} {nets: {VSS}}}
#set_pg_strategy s_mem_macro_vdd_pins -macros $mem_macros  -pattern {{name: mem_macro_pin_pattern_nolayer} {nets: {VDD}}}

#compile_pg -strategies s_mem_macro_vss_pins_nolayer -ignore_drc 
compile_pg -strategies s_mem_macro_vss_pins -ignore_drc 
compile_pg -strategies s_mem_macro_vdd_pins -ignore_drc 

#set added_vias_vss [gui_add_missing_vias [get_shapes -of_objects [get_nets VSS]] -min_layer METAL2 -max_layer METAL6]
#set added_vias_vdd [gui_add_missing_vias [get_shapes -of_objects [get_nets VDD]] -min_layer METAL2 -max_layer METAL6]
################################################################################
#-------------------------------------------------------------------------------
# P G   M E S H   C R E A T I O N
#-------------------------------------------------------------------------------
################################################################################

#create_pg_mesh_pattern pg_mesh1 \
   -parameters {w1 p1 w2 p2 f t} \
   -layers {{{vertical_layer: M8} {width: @w1} {spacing: interleaving} \
        {pitch: @p1} {offset: @f} {trim: @t}} \
 	     {{horizontal_layer: 9} {width: @w2} {spacing: interleaving} \
        {pitch: @p2} {offset: @f} {trim: @t}}}


#create_pg_mesh_pattern mesh_pattern -layers {{{horizontal_layer : METAL5} {width : minimum} {spacing : minimum} {trim : true}} {{vertical_layer : METAL6} {width : minimum} {spacing : minimum}  \
{trim : true}}}


#set_pg_strategy s_mesh1 \
   -pattern {{pattern: pg_mesh1} {nets: {VDD VSS VSS VDD}} \
{offset_start: 400 400} {parameters: 4 80 6 120 3.344 false}} \
   -blockage {{{nets: VDD} {block: u0_2 u0_3}}} \
   -core -extension {{stop: outermost_ring}}

#set_pg_strategy mesh_strat -core -pattern {{name : mesh_pattern}{nets : {VDD VSS}}}

set_pg_via_master_rule VIA56_3x3 -contact_code VIA56 -via_array_dimension {3 3} 

# Create the power and ground ring mesh pattern
#create_pg_mesh_pattern mesh_pattern -layers { \
# {{vertical_layer: METAL6} {width: 5} \
# {spacing: interleaving} {pitch: 32}} \
# {{vertical_layer: METAL4} {width: 2} \
# {spacing: interleaving} {pitch: 32}} \
# {{horizontal_layer: METAL5} {width: 5} \
# {spacing: interleaving} {pitch: 28.8}}} \
 -via_rule { \
# {{layers: METAL4} {layers: METAL5} {via_master: default}} \
# {{layers: METAL6} {layers: METAL5} {via_master: VIA56_3x3}}}
#create_pg_mesh_pattern mesh_pattern -layers { \
# {{vertical_layer: METAL6} {width: 10} {spacing: interleaving}} \
# {{horizontal_layer: METAL5} {width: 10} {spacing: interleaving} }} \
# -via_rule {{{layers: METAL6} {layers: METAL5} {via_master: VIA56_3x3}}}

#set spacingVer = {}
#set spacingHor = {}
#for {set i 0} {$i<100} {incr i} {
#  lappend spacingVer 100
#}
#for {set i 0} {$i<50} {incr i} {
#  lappend spacingHor 100
#}


 
create_pg_mesh_pattern mesh_pattern -layers { \
 {{vertical_layer: METAL4} {width: 20} {spacing: 4} {pitch: 100}} \
 {{horizontal_layer: METAL5} {width: 20} {spacing: minimum} {pitch: 100}} \
 {{vertical_layer: METAL6} {width: 20} {spacing: 4} {pitch: 100}}} \
 -via_rule { {layers: METAL4} {layers: METAL5} {via_master: default} }

#
# Set the mesh strategy to apply the mesh_pattern
# pattern to the core area. Extend the mesh
# to the outermost ring
#set_pg_strategy mesh_strat -core -pattern {{pattern: mesh_pattern}
#{nets: {VDD VSS}}} -extension {{stop: outermost_ring}}


set hard_macros [get_cells -hier -filter "is_hard_macro==true"]
if {$MV_AES} {
    set_pg_strategy mesh_strat \
      -pattern {{pattern: mesh_pattern} {nets: {$VNAME $GNAME}}} \
      -extension {{stop: outermost_ring}} \
      -blockage {{macros: $hard_macros} {voltage_areas: "PD_AES"}} \
      -voltage_areas "DEFAULT_VA"
} else {
    set_pg_strategy mesh_strat -polygon [list [list [expr $digital_pad_height] [expr $digital_pad_height]] [list [expr $core_width - $digital_pad_height] [expr $core_height - $digital_pad_height]]] \
      -pattern {{pattern: mesh_pattern} {nets: {VDD VSS}}} \
      -extension {{stop: outermost_ring}} \
      -blockage {{macros: $hard_macros}}
#    set_pg_strategy mesh_strat -polygon {{185 185} {2815 4815}} \
      -pattern {{pattern: mesh_pattern} {offset: {-700 -700}} {nets: {VDD VSS}}} \
      -extension {{stop: outermost_ring}} \
      -blockage {{macros: $hard_macros}}
#    set_pg_strategy mesh_strat -core \
      -pattern {{pattern: mesh_pattern} {offset: {-700 -700}} {nets: {VDD VSS}}} \
      -extension {{stop: outermost_ring}} \
      -blockage {{macros: $hard_macros}}
}

#
#
# Create the mesh in the design
compile_pg -strategies mesh_strat



# Create the mesh for AES
if {$MV_AES} {
    set_pg_strategy mesh_strat2 \
      -pattern {{pattern: mesh_pattern} {nets: {VN2 GN2}}} \
      -extension {{stop: outermost_ring}} \
      -voltage_areas "PD_AES"

   # Create the mesh in the design
   compile_pg -strategies mesh_strat2
}

################################################################################
#-------------------------------------------------------------------------------
# M A C R O   P G   C O N N E C T I O N S
#-------------------------------------------------------------------------------
################################################################################
#create_pg_macro_conn_pattern hard_macro_pattern -pin_conn_type ring_pin -nets {VDD VSS} -layers {METAL5 METAL6}

#set toplevel_hms [filter_collection [get_cells * -physical_context] "is_hard_macro == true"]
#set_pg_strategy hard_macro_strat -macros $toplevel_hms -pattern {{name: hard_macro_pattern} {nets: {VDD VSS}}}

# Create the connection pattern for macro
# power and ground pins
#create_pg_macro_conn_pattern macro_pattern \
 -pin_conn_type scattered_pin
# Set the macro connection strategy to
# apply the macro_pattern pattern to
# the core area
#set_pg_strategy macro_strat -core \
 -pattern {{pattern: macro_pattern} \
 {nets: {VDD VSS}}}
# Connect the power and ground macro pins
#compile_pg -strategies macro_strat

################################################################################
#-------------------------------------------------------------------------------
# S T A N D A R D    C E L L    R A I L    I N S E R T I O N
#-------------------------------------------------------------------------------
################################################################################
#create_pg_std_cell_conn_pattern \
    std_cell_rail  \
    -layers {M1} \
    -rail_width 0.06

#create_pg_std_cell_conn_pattern std_cell_rail_pattern -layers {METAL1} -check_std_cell_drc true -mark_as_follow_pin false

#set_pg_strategy rail_strat -core \
    -pattern {{name: std_cell_rail} {nets: VDD VSS} }

#set_pg_strategy std_cell_rail_strat -core -pattern {{name: std_cell_rail_pattern} {nets: VDD VSS}}



# Create a new 1x2 via
#set_pg_via_master_rule via14_1x2 -via_array_dimension {1 2}
# Create the power and ground rail pattern
create_pg_std_cell_conn_pattern rail_pattern -layers {METAL1}
# Set the power and ground rail strategy
# to apply the rail_pattern pattern to the
# core area

if {$MV_AES} {
    set_pg_strategy rail_strat \
     -pattern {{pattern: rail_pattern} {nets: $VNAME $GNAME}} \
     -blockage {voltage_areas: "PD_AES"} \
     -voltage_areas "DEFAULT_VA"
} else {
    set_pg_strategy rail_strat -polygon [list [list [expr $digital_pad_height] [expr $digital_pad_height]] [list [expr $core_width - $digital_pad_height] [expr $core_height - $digital_pad_height]]] \
     -pattern {{pattern: rail_pattern} {nets: VDD VSS}}
#    set_pg_strategy rail_strat -core \
     -pattern {{pattern: rail_pattern} {nets: VDD VSS}}
}

#

# Define a via strategy to insert via14_1x2 vias
# between existing straps and the new power rails
# specified by rail_strat strategy on the M6 layer
#set_pg_strategy_via_rule rail_rule -via_rule { \
 { {{existing: strap} {layers: METAL6}} \
 {strategies: rail_strat} {via_master: default}} } 
# {{intersection: undefined} {via_master: nil}}}
# Insert the new rails
#compile_pg -strategies rail_strat -via_rule rail_rule
compile_pg -strategies rail_strat


# Create the power and ground rail for AES
if {$MV_AES} {
    set_pg_strategy rail_strat2 \
     -pattern {{pattern: rail_pattern} {nets: VN2 GN2}} \
     -voltage_areas "PD_AES"

    compile_pg -strategies rail_strat2
}


