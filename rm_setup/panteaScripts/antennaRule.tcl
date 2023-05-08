#;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#                     TSMC 018 Antenna Rule for Astro/ICC Router
#;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#
# DISCLAIMER
#
#       This script is for antenna ratio setting which can speed up antenna
# violation fixing. The information contained herein is provided by TSMC on
# an "AS IS" basis without any warranty, and TSMC has no obligation to support
# or otherwise maintain the information.  TSMC disclaims any representation
# that the information does not infringe any intellectual property rights or
# proprietary rights of any third parties.  There are no other warranties given
# by TSMC, whether express, implied or statutory, including, without limitation,
# implied warranties of merchantability and fitness for a particular purpose.
#
#--------------------------------------------------------------------------------
# DESIGN RULE DOCUMENT: T-018-LO-DR-001 V2.7
#
# Single-layer drawn ratio of a metal sidewall area to the active poly gate area
# M1~M6 : ratio=400 
# M1~M5 : ratio=diode_area*400+2200         if diode_area >=  0.203
# M6    : ratio=diode_area*8000+30000       if diode_area >=  0.203
# 
# Single-layer drawn ratio of a via area to the active poly gate area 
# VIA   : ratio=20 
# VIA   : ratio=diode_area*83.33+75         if diode_area >=  0.203
# 
#--------------------------------------------------------------------------------
# pk set_parameter -name doAntennaConx -value 4
# pk set lib [current_mw_lib];
set lib [current_lib] ; # pk 
# pk remove_antenna_rules $lib
remove_antenna_rules ; # pk

set topMetalLayer 6;

##### Single metal layer sidewall area rule #####
define_antenna_rule $lib \
  -mode 4 \
  -diode_mode 4 \
  -metal_ratio 400 \
  -cut_ratio 0

define_antenna_layer_rule $lib \
            -mode 4 \
            -layer "METAL$topMetalLayer" \
            -ratio 400 \
            -diode_ratio {0.203 0 8000 30000}

define_antenna_layer_rule $lib \
            -mode 4 \
            -layer "METAL5" \
            -ratio 400 \
            -diode_ratio {0.203 0 400 2200}

define_antenna_layer_rule $lib \
            -mode 4 \
            -layer "METAL4" \
            -ratio 400 \
            -diode_ratio {0.203 0 400 2200}

define_antenna_layer_rule $lib \
            -mode 4 \
            -layer "METAL3" \
            -ratio 400 \
            -diode_ratio {0.203 0 400 2200}

define_antenna_layer_rule $lib \
            -mode 4 \
            -layer "METAL2" \
            -ratio 400 \
            -diode_ratio {0.203 0 400 2200}

define_antenna_layer_rule $lib \
            -mode 4 \
            -layer "METAL1" \
            -ratio 400 \
            -diode_ratio {0.203 0 400 2200}

##### Single via layer area rule #####
define_antenna_rule $lib \
  -mode 1 \
  -diode_mode 4 \
  -metal_ratio 0 \
  -cut_ratio 20

define_antenna_layer_rule $lib \
            -mode 1 \
            -layer "VIA12" \
            -ratio 20 \
            -diode_ratio {0.203 0 83.33 75}

define_antenna_layer_rule $lib \
            -mode 1 \
            -layer "VIA23" \
            -ratio 20 \
            -diode_ratio {0.203 0 83.33 75}

define_antenna_layer_rule $lib \
            -mode 1 \
            -layer "VIA34" \
            -ratio 20 \
            -diode_ratio {0.203 0 83.33 75}

define_antenna_layer_rule $lib \
            -mode 1 \
            -layer "VIA45" \
            -ratio 20 \
            -diode_ratio {0.203 0 83.33 75}

define_antenna_layer_rule $lib \
            -mode 1 \
            -layer "VIA56" \
            -ratio 20 \
            -diode_ratio {0.203 0 83.33 75}

##### Routing Option Related to Antenna Fixing #####
# pk set_parameter -name doAntennaConx -value 4 -module droute

# pk report_antenna_rules -output antenna.rule


set_app_options -name route.detail.antenna -value true;# default true #pk
# enable diode insertion to fix antenna violations:
set_app_options -name route.detail.insert_diodes_during_routing -value true;# pk: default false
# enable analysis and optimization of antennas on power and ground nets:
set_app_options -name route.detail.check_antenna_on_pg -value true;# pk: default false
# specify how the ports are treated for antenna considerations:
set_app_options -name route.detail.port_antenna_mode -value jump;# pk: default float
set_app_options -name route.detail.macro_pin_antenna_mode -value jump;# pk: default normal

