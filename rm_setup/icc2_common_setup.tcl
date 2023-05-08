puts "RM-info : Running script [info script]\n"

##########################################################################################
# Tool: IC Compiler II
# Script: icc2_common_setup.tcl
# Version: P-2019.03-SP4
# Copyright (C) 2014-2019 Synopsys, Inc. All rights reserved.
##########################################################################################

##########################################################################################
## Required variables
## These variables must be correctly filled in for the flow to run properly
##########################################################################################
# pk:
source "./rm_setup/panteaScripts/highlight_cells.tcl"
set sdc_file			"./frontend_output/picochip_dare.sdc"
set pad_type			"normal" ;# valid options:
				       ;# 	- slim: to use pads from tph... slim library
				       ;# 	- normal: to use pads from tpz... library
set core_vdd_pad ""
set core_vss_pad ""
set io_vdd_pad ""
set io_vss_pad ""
set io_analog_vdd_pad ""
set io_analog_vss_pad ""
set output_pad "PDO12CDG"
if {$pad_type == "slim"} {
	set pad_lib "tph018nv3_sl" 
	set io_ndm_dir "io_sl_cell"
	set core_vdd_pad "PVDD1CDG"
	set core_vss_pad "PVSS1CDG"
	set io_vdd_pin "VDDPST"
	set io_vss_pin "VSSPST"
	set io_vdd_pad "PVDD2CDG"
	set io_vss_pad "PVSS2CDG"
	set io_analog_vdd_pad "PVDD3A"
	set io_analog_vss_pad "PVSS3A"
} elseif {$pad_type == "normal"} {
	set pad_lib "tpz973gv" 
	set io_ndm_dir "io_cell"
	set core_vdd_pad "PVDD1DGZ"
	set core_vss_pad "PVSS1DGZ"
	set io_vdd_pin "VD33"
	set io_vss_pin "VSSPST"
	set io_vdd_pad "PVDD2DGZ"
	set io_vss_pad "PVSS2DGZ"
	set io_analog_vdd_pad "PVDD3A"
	set io_analog_vss_pad "PVSS3A"
}

# stdcell lib
set std_cell_gds_ref_lib_path "/opt/libraries/TSMCHOME/digital/Back_End/gds/tcb018gbwp7t_270a"
set std_cell_gds_ref_lib "$std_cell_gds_ref_lib_path/tcb018gbwp7t.gds"

# io and bonding lib
set std_cell_gds_ref_lib_path "/opt/libraries/TSMCHOME/digital/Back_End/gds/tcb018gbwp7t_270a"
set io_gds_ref_lib_path "/opt/libraries/TSMCHOME/digital/Back_End/gds/tpz973gv_280a/mt_2/6lm"
set io_gds_ref_lib "$io_gds_ref_lib_path/tpz973gv.gds"
set io_bonding_cup_gds_ref_lib_path "/opt/libraries/TSMCHOME/digital/Back_End/gds/tpb973gv_140a/cup/6lm"
set io_bonding_cup_gds_ref_lib "$io_bonding_cup_gds_ref_lib_path/tpb973gv.gds"
set io_bonding_cup2_gds_ref_lib_path "/opt/libraries/TSMCHOME/digital/Back_End/gds/tpb018v_180a/cup/6lm"
set io_bonding_cup2_gds_ref_lib "$io_bonding_cup2_gds_ref_lib_path/tpb018v.gds"
set io_bonding_wb_gds_ref_lib_path "/opt/libraries/TSMCHOME/digital/Back_End/gds/tpb973gv_140a/wb/6lm"
set io_bonding_wb_gds_ref_lib "$io_bonding_wb_gds_ref_lib_path/tpb973gv.gds"
set io_bonding_wb2_gds_ref_lib_path "/opt/libraries/TSMCHOME/digital/Back_End/gds/tpb018v_180a/wb/6lm"
set io_bonding_wb2_gds_ref_lib "$io_bonding_wb2_gds_ref_lib_path/tpb018v.gds"

# mem lib
#set mem_gds_ref_lib_path "/gulerlab/TAPEOUT2020/sram8kx8/compout/NDM/aspulsgfs1p8192x8cm16sw0/INPUT/"
set mem_gds_ref_lib_path "/home/dshanmugam/picochip-master/backend/picochip_library_dependencies/RAM_byte/sram8kx8/compout/NDM/aspulsgfs1p8192x8cm16sw0/INPUT/"
set mem_gds_ref_lib "$mem_gds_ref_lib_path/aspulsgfs1p8192x8cm16sw0.gds"

set stdcell_lib_gds "$std_cell_gds_ref_lib"
set io_lib_gds "$io_gds_ref_lib $io_bonding_cup_gds_ref_lib $io_bonding_cup2_gds_ref_lib $io_bonding_wb_gds_ref_lib $io_bonding_wb2_gds_ref_lib"
set mem_lib_gds "$mem_gds_ref_lib"
set gds_files "$stdcell_lib_gds $io_lib_gds $mem_lib_gds" 

set ndm_src_dir ""
#set ndm_src_dir "/home/pkiaei/picochip_library_dependencies/newtf-libpreps/ndm_newtf/"
set ndm_src_dir "/home/dshanmugam/picochip-master/backend/picochip_library_dependencies/newtf-libpreps/ndm_newtf/"
# set ndm_src_dir "/home/pantea/newtf-libpreps/ndm_newtf/"

set tsmclibdir "/opt/libraries/TSMCHOME/"
set back_end_path "$tsmclibdir/digital/Back_End/"
set technology_file_path "$back_end_path/milkyway/tcb018gbwp7t_270a/techfiles/"

#set PARASITIC_FILE "$technology_file_path/tluplus/t018lo_1p6m_typical.tluplus"
#set PARASITIC_FILE "/home/pkiaei/picochip_library_dependencies/018G_6lm4X1U_40KUTM_Syn/tluplus/extracted/typical/cm018g_1p6m_4x1u_mim5_40k_typical.tluplus"
set PARASITIC_FILE "/home/dshanmugam/picochip-master/backend/picochip_library_dependencies/018G_6lm4X1U_40KUTM_Syn/tluplus/extracted/typical/cm018g_1p6m_4x1u_mim5_40k_typical.tluplus"

# set PARASITIC_FILE "/home/pantea/018G_6lm4X1U_40KUTM_Syn/tluplus/extracted/typical/cm018g_1p6m_4x1u_mim5_40k_typical.tluplus"
set LAYERMAP_FILE "$technology_file_path/tluplus/star.map_6M"


set DESIGN_NAME 		"picochip" ;# Required; name of the design to be worked on; also used as the block name when scripts save or copy a block
set LIBRARY_SUFFIX		"tcb018gbwp7t_270a" ;# Suffix for the design library name ; default is unspecified   
set DESIGN_LIBRARY 		"${DESIGN_NAME}_${LIBRARY_SUFFIX}" ;# Name of the design library; default is ${DESIGN_NAME}${LIBRARY_SUFFIX}
#set REFERENCE_LIBRARY 		[list /home/pantea/icc2_cell_lib/riscv_tsmc180_frame.ndm]	;# Required; a list of reference libraries for the design library.
#set REFERENCE_LIBRARY 		[list /home/pantea/lib-prep2/ICC2_LIBPREP-RM_P-2019.03-SP2/icc2_cell_lib/tcb018gbwp7t.ndm/ /home/pantea/lib-prep2/ICC2_LIBPREP-RM_P-2019.03-SP2/icc2_cell_lib/std_cell_lib_frame.ndm/ /home/pantea/lib-prep2/ICC2_LIBPREP-RM_P-2019.03-SP2/icc2_cell_lib/std_cell_lib_physical_only.ndm/ /home/pantea/lib-prepare/ICC2_LIBPREP-RM_P-2019.03-SP2/icc2_cell_lib/picochip_tsmc180_lib_frame.ndm]	;# Required; a list of reference libraries for the design library.
#set REFERENCE_LIBRARY 		[list $ndm_src_dir/std_cell/tcb018gbwp7t.ndm $ndm_src_dir/std_cell/std_cell_lib_frame.ndm $ndm_src_dir/$io_ndm_dir/$pad_lib.ndm $ndm_src_dir/$io_ndm_dir/io_cell_lib_frame.ndm $ndm_src_dir/mem_cell/aspulsgfs1p8192x8cm16sw0_lib.ndm $ndm_src_dir/mem_cell/mem_cell_lib_frame.ndm /home/pkiaei/picochip_library_dependencies/ndm_libs/aio_cell/tpa018nv.ndm /home/pkiaei/picochip_library_dependencies/ndm_libs/aio_cell/aio_cell_lib_frame.ndm /home/pkiaei/picochip_library_dependencies/ndm_libs/trng_ro_cell/ro_cell_lib_frame.ndm]	;# Required; a list of reference libraries for the design library.
set REFERENCE_LIBRARY           [list $ndm_src_dir/std_cell/tcb018gbwp7t.ndm $ndm_src_dir/std_cell/std_cell_lib_frame.ndm $ndm_src_dir/$io_ndm_dir/$pad_lib.ndm $ndm_src_dir/$io_ndm_dir/io_cell_lib_frame.ndm $ndm_src_dir/mem_cell/aspulsgfs1p8192x8cm16sw0_lib.ndm $ndm_src_dir/mem_cell/mem_cell_lib_frame.ndm /home/dshanmugam/picochip-master/backend/picochip_library_dependencies/ndm_libs/aio_cell/tpa018nv.ndm /home/dshanmugam/picochip-master/backend/picochip_library_dependencies/ndm_libs/aio_cell/aio_cell_lib_frame.ndm]

#set REFERENCE_LIBRARY 		[list $ndm_src_dir/std_cell/tcb018gbwp7t.ndm $ndm_src_dir/std_cell/std_cell_lib_frame.ndm $ndm_src_dir/$io_ndm_dir/$pad_lib.ndm $ndm_src_dir/$io_ndm_dir/io_cell_lib_frame.ndm $ndm_src_dir/mem_cell/aspulsgfs1p8192x8cm16sw0_lib.ndm $ndm_src_dir/mem_cell/mem_cell_lib_frame.ndm /home/pkiaei/picochip_library_dependencies/ndm_libs/aio_cell/tpa018nv.ndm /home/pkiaei/picochip_library_dependencies/ndm_libs/aio_cell/aio_cell_lib_frame.ndm]	;# Required; a list of reference libraries for the design library.
					;#	for library configuration flow (LIBRARY_CONFIGURATION_FLOW set to true below): 
					;#		- specify the list of physical source files to be used for library configuration during create_lib
				       	;# 	for hierarchical designs using bottom-up flows: include subblock design libraries in the list;
					;# 	for hierarchical designs using ETMs: include the ETM library in the list.
					;# 		- If unpack_rm_dirs.pl is used to create dir structures for hierarchical designs, 
					;#		  in order to transition between hierarchical DP and hierarchical PNR flows properly, 
					;#		  absolute paths are a requirement.
set COMPRESS_LIBS               "false" ;# Save libs as compressed NDM; only used in DP.
set VERILOG_NETLIST_FILES	"./frontend_output/${DESIGN_NAME}_dare.v"	;# Verilog netlist files;
					;# 	for DP: required
					;# 	for PNR: required if INIT_DESIGN_INPUT is ASCII in icc2_pnr_setup.tcl; not required for DC_ASCII or DP_RM_NDM
set MV_AES			"false"	;# pk: true: separate pg network for AES
					;#     false: same pg network for the entire chip
#set UPF_FILE 			"./rm_setup/panteaScripts/upf_files/topblock.upf"	;# A UPF file
set UPF_FILE 			"./rm_setup/panteaScripts/upf_files/topdown.upf"	;# A UPF file
					;# 	for DP: required
					;# 	for PNR: required if INIT_DESIGN_INPUT is ASCII in icc2_pnr_setup.tcl; not required for DC_ASCII or DP_RM_NDM
                                        ;#          for hierarchical designs using ETMs, load the block upf file
                                        ;#          for each sub-block linked to ETM, include the following line in the UPF_FILE 
                			;#              load_upf block.upf -scope block_instance_name
set UPF_SUPPLEMENTAL_FILE	""      ;# The supplemental UPF file. Only needed if you are running golden UPF flow, in which case, you need both UPF_FILE and this.
					;# 	for DP: required
					;# 	for PNR: required if INIT_DESIGN_INPUT is ASCII in icc2_pnr_setup.tcl; not required for DC_ASCII or DP_RM_NDM
					;#	    If UPF_SUPPLEMENTAL_FILE is specified, scripts assume golden UPF flow. load_upf and save_upf commands will be different.	

set TCL_PARASITIC_SETUP_FILE	"./rm_setup/panteaScripts/parasitic_setup_file.tcl"	;# Specify a Tcl script to read in your TLU+ files by using the read_parasitic_tech command;
					;# refer to the example in templates/init_design.read_parasitic_tech_example.tcl 

set TCL_MCMM_SETUP_FILE		"./rm_setup/panteaScripts/readsdc.tcl"	;# Specify a Tcl script to create your corners, modes, scenarios and load respective constraints;
					;# two examples are provided in templates/: 
					;# init_design.mcmm_example.explicit.tcl: provide mode, corner, and scenario constraints; create modes, corners, 
					;# and scenarios; source mode, corner, and scenario constraints, respectively 
					;# init_design.mcmm_example.auto_expanded.tcl: provide constraints for the scenarios; create modes, corners, 
					;# and scenarios; source scenario constraints which are then expanded to associated modes and corners
					;# 	for DP: required
					;# 	for PNR: required if INIT_DESIGN_INPUT is ASCII in icc2_pnr_setup.tcl; not required for DC_ASCII or DP_RM_NDM

#set TECH_FILE 			"$technology_file_path/tsmc018_6lm.tf" 	;# A technology file; TECH_FILE and TECH_LIB are mutually exclusive ways to specify technology information; 
#set TECH_FILE 			"/home/pantea/tsmc018_6lm_modified.tf" 	;# A technology file; TECH_FILE and TECH_LIB are mutually exclusive ways to specify technology information; 
set TECH_FILE 			"/home/dshanmugam/picochip-master/backend/picochip_library_dependencies/018G_6lm4X1U_40KUTM_Syn/PR_tech/Synopsys/TechFile/tsmc018_6lm4x1u_modified.tf" ;

#set TECH_FILE 			"/home/pkiaei/picochip_library_dependencies/018G_6lm4X1U_40KUTM_Syn/PR_tech/Synopsys/TechFile/tsmc018_6lm4x1u_modified.tf" 	;# A technology file; TECH_FILE and TECH_LIB are mutually exclusive ways to specify technology information; 
# set TECH_FILE 			"/home/pantea/018G_6lm4X1U_40KUTM_Syn/PR_tech/Synopsys/TechFile/tsmc018_6lm4x1u_modified.tf" 	;# A technology file; TECH_FILE and TECH_LIB are mutually exclusive ways to specify technology information; 
					;# TECH_FILE is recommended, although TECH_LIB is also supported in ICC2 RM. 
set TECH_LIB			""	;# Specify the reference library to be used as a dedicated technology library;
                        		;# as a best practice, please list it as the first library in the REFERENCE_LIBRARY list 
set TECH_LIB_INCLUDES_TECH_SETUP_INFO true 
					;# Indicate whether TECH_LIB contains technology setup information such as routing layer direction, offset, 
					;# site default, and site symmetry, etc. TECH_LIB may contain this information if loaded during library prep.
					;# true|false; this variable is associated with TECH_LIB. 
set TCL_TECH_SETUP_FILE		"init_design.tech_setup.tcl"
					;# Specify a TCL script for setting routing layer direction, offset, site default, and site symmetry list, etc.
					;# init_design.tech_setup.tcl is the default. Use it as a template or provide your own script.
					;# This script will only get sourced if the following conditions are met: 
					;# (1) TECH_FILE is specified (2) TECH_LIB is specified && TECH_LIB_INCLUDES_TECH_SETUP_INFO is false 
set ROUTING_LAYER_DIRECTION_OFFSET_LIST "{METAL1 horizontal 0.280} {METAL2 vertical 0.280} {METAL3 horizontal 0.280} {METAL4 vertical 0.280} {METAL5 horizontal 0.280} {METAL6 vertical 0.280}" ;# pk: from lef file of the standard cell library
					;# Specify the routing layers as well as their direction and offset in a list of space delimited pairs;
					;# This variable should be defined for all metal routing layers in technology file;
					;# Syntax is "{metal_layer_1 direction offset} {metal_layer_2 direction offset} ...";
					;# It is required to at least specify metal layers and directions. Offsets are optional. 
					;# Example1 is with offsets specified: "{M1 vertical 0.2} {M2 horizontal 0.0} {M3 vertical 0.2}"
					;# Example2 is without offsets specified: "{M1 vertical} {M2 horizontal} {M3 vertical}"
##########################################################################################
## Optional variables
## Specify these variables if the corresponding functions are desired 
##########################################################################################
set DESIGN_LIBRARY_SCALE_FACTOR	""	;# Specify the length precision for the library. Length precision for the design
					;# library and its ref libraries must be identical. Tool default is 10000, which
					;# implies one unit is one Angstrom or 0.1nm.

set UPF_UPDATE_SUPPLY_SET_FILE	""	;# A UPF file to resolve UPF supply sets

set DEF_FLOORPLAN_FILES		""	;# DEF files which contain the floorplan information;
					;# 	for DP: not required
					;# 	for PNR: required if INIT_DESIGN_INPUT = ASCII in icc2_pnr_setup.tcl and neither TCL_FLOORPLAN_FILE or 
					;#		 initialize_floorplan is used; DEF_FLOORPLAN_FILES and TCL_FLOORPLAN_FILE are mutually exclusive;
					;# 	         not required if INIT_DESIGN_INPUT = DC_ASCII or DP_RM_NDM

set DEF_SCAN_FILE		""	;# A scan DEF file for scan chain information;
					;# 	for PNR: not required if INIT_DESIGN_INPUT = DC_ASCII or DP_RM_NDM, as SCANDEF is expected to be loaded already

set DEF_SITE_NAME_PAIRS		{}	;# A list of site name pairs for read_def -convert; 
					;# specify site name pairs with from_site first followed by to_site;
					;# Example: set DEF_SITE_NAME_PAIRS {{from_site_1 to_site_1} {from_site_2 to_site_2}} 	
set SITE_DEFAULT		""	;# Specify the default site name if there are multiple site defs in the technology file;
					;# this is to be used by initialize_floorplan command; example: set SITE_DEFAULT "unit";
					;# this is applied in the init_design.tech_setup.tcl script 
set SITE_SYMMETRY_LIST	""		;# Specify a list of site def and its symmetry value;
					;# this is to be used by read_def or initialize_floorplan command to control the site symmetry;
					;# example: set SITE_SYMMETRY_LIST "{unit Y} {unit1 Y}"; this is applied in the init_design.tech_setup.tcl script 

set MIN_ROUTING_LAYER		""	;# Min routing layer name; normally should be specified; otherwise tool can use all metal layers
set MAX_ROUTING_LAYER		""	;# Max routing layer name; normally should be specified; otherwise tool can use all metal layers
#pk:
set LIBRARY_CONFIGURATION_FLOW	false;# Set it to true enables library configuration flow which calls the library manager under the hood to generate .nlibs, 
					;# save them to disk, and automatically link them to the design.
					;# Requires LINK_LIBRARY to be specified with .db files and REFERENCE_LIBRARY to be specified with physical
					;# source files for the library configuration flow. Also search_path (in icc2_pnr_setup.tcl) should include paths 
					;# to these .db and physical source files.

#set front_end_path "$tsmclibdir/digital/Front_End/"
#set cell_lib_path "$front_end_path/timing_power_noise/NLDM/tcb018gbwp7t_270a/"
#set cell_lib "$cell_lib_path/*.db"
#set io_lib_path "$front_end_path/timing_power_noise/NLDM/tpz973gv_280a/"
#set io_lib "$io_lib_path/*.db"
#set memory_path "/home/pantea/RAM_byte/sram8kx8/compout/"
#set memory_lib_path "$memory_path/NDM/aspulsgfs1p8192x8cm16sw0/INPUT/Worst/"
#set memlib "$memory_path/NDM/aspulsgfs1p8192x8cm16sw0/INPUT/Best/aspulsgfs1p8192x8cm16sw0_Best.db $memory_path/NDM/aspulsgfs1p8192x8cm16sw0/INPUT/Typical/aspulsgfs1p8192x8cm16sw0_Typical.db $memory_path/NDM/aspulsgfs1p8192x8cm16sw0/INPUT/Worst/aspulsgfs1p8192x8cm16sw0_Worst.db"
#set db_files "$cell_lib $io_lib $memlib"
#
#set grtechlibpath ". $cell_lib_path $io_lib_path $memory_lib_path"
#set grtechtargetlib "tcb018gbwp7twc.db"
#set iolib "tpz973gvwc.db"
#
#set grtechlinklib "* $grtechtargetlib $iolib $memlib"
#
#
#lappend $search_path $grtechlibpath
#set target_library $grtechtargetlib
#set link_library   $grtechlinklib
#

set front_end_path "$tsmclibdir/digital/Front_End/"
set cell_lib_path "$front_end_path/timing_power_noise/NLDM/tcb018gbwp7t_270a/"
#set cell_lib "$cell_lib_path/*.db"
set cell_lib "tcb018gbwp7tbc.db tcb018gbwp7ttc.db tcb018gbwp7tml.db tcb018gbwp7twcl.db tcb018gbwp7tlt.db tcb018gbwp7twc.db"
set io_lib_path "$front_end_path/timing_power_noise/NLDM/tpz973gv_280a/"
#set io_lib "$io_lib_path/*.db"
set io_lib "tpz973gvbc.db tpz973gvlt.db tpz973gvtc.db tpz973gvwc.db"
set memory_path "/home/dshanmugam/picochip-master/backend/picochip_library_dependencies/RAM_byte/sram8kx8/compout/"
#set memory_path "/home/pkiaei/picochip_library_dependencies/RAM_byte/sram8kx8/compout/"
# set memory_path "/home/pantea/RAM_byte/sram8kx8/compout/"
#set memory_path "/home/pantea/RAM_byte/sram16kx8/compout/"
set memlib "$memory_path/NDM/aspulsgfs1p8192x8cm16sw0/INPUT/Best/aspulsgfs1p8192x8cm16sw0_Best.db $memory_path/NDM/aspulsgfs1p8192x8cm16sw0/INPUT/Typical/aspulsgfs1p8192x8cm16sw0_Typical.db $memory_path/NDM/aspulsgfs1p8192x8cm16sw0/INPUT/Worst/aspulsgfs1p8192x8cm16sw0_Worst.db"
#set memlib "$memory_path/NDM/aspulsgfs1p16384x8cm16sw0/INPUT/Best/aspulsgfs1p16384x8cm16sw0_Best.db $memory_path/NDM/aspulsgfs1p16384x8cm16sw0/INPUT/Typical/aspulsgfs1p16384x8cm16sw0_Typical.db $memory_path/NDM/aspulsgfs1p16384x8cm16sw0/INPUT/Worst/aspulsgfs1p16384x8cm16sw0_Worst.db"
set db_files "$cell_lib $io_lib $memlib"
#
#pk:
set LINK_LIBRARY		"$db_files"	;# Specify .db files;
					;# 	for running VC-LP (vc_lp.tcl) and Formality (fm.tcl): required
					;# 	for ICC-II without LIBRARY_CONFIGURATION_FLOW enabled: not required
					;#	for ICC-II with LIBRARY_CONFIGURATION_FLOW enabled: required; 
					;#      	- the .db files specified will be used for the library configuration under the hood during create_lib 

##########################################################################################
## Variables related to flow controls of flat PNR, hierarchical PNR and transition with DP
##########################################################################################
set DESIGN_STYLE		"flat"	;# Specify the design style; flat|hier; default is flat; 
					;# specify flat for a totally flat flow (flat PNR for short) and 
					;# specify hier for a hierarchical flow (hier PNR for short);
					;# 	for hier PNR: required and auto set if unpack_rm_dirs.pl is used; (see README.unpack_rm_dirs.txt for details)
					;# 	for flat PNR: this should set to flat (default)
					;#	for DP: not used 

set PHYSICAL_HIERARCHY_LEVEL	"" 	;# Specify the current level of hierarchy for the hierarchical PNR flow; top|intermediate|bottom;
					;# 	for hier PNR: required and auto set if unpack_rm_dirs.pl is used; (see README.unpack_rm_dirs.txt for details)
					;# 	for flat PNR and for DP: not used.
set RELEASE_DIR_DP		"dp_output" 	;# Specify the release directory of DP RM; 
					;# this is where init_design.tcl of PNR flow gets DP RM released libraries;
					;# 	for hier PNR: required and auto set if unpack_rm_dirs.pl is used; (see README.unpack_rm_dirs.txt for details)
					;# 	for flat PNR: required if INIT_DESIGN_INPUT = DP_RM_NDM, as init_design.tcl needs to know where DP RM libraries are
					;#	for DP: not used 
set RELEASE_LABEL_NAME_DP 	"for_pnr"	
					;# Specify the label name of the block in the DP RM released library;
					;# this is the label name which init_design.tcl of PNR flow will open. 
set RELEASE_DIR_PNR		"" 	;# Specify the release directory of PNR RM; 
					;# this is where the init_design.tcl of hierarchical PNR flow gets the sub-block libraries;	
					;# 	for hier PNR: required and auto set if unpack_rm_dirs.pl is used; (see README.unpack_rm_dirs.txt for details)
					;# 	for flat PNR and for DP: not used.
##########################################################################################
## Variables related to REDHAWK ANALYSIS FUSION
##########################################################################################
set REDHAWK_SEARCH_PATH		"" 	;# Required. Search path to the NDM, reference libraries, and etc.

puts "RM-info : Completed script [info script]\n"

