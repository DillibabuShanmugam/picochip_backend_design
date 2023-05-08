proc highlight_aes_coprocessor { args } {

   gui_create_vm -name proc_aes_coprocessor_highlight -title "Highlight AES Coprocessor"

   set AES_COPRO  [get_cells "picosocInst_aes_coprocessor/*" -quiet]
   append_to_collection AES_COPRO [get_cells "picosocInst_aes_coprocessor/*/*" -quiet]
   append_to_collection AES_COPRO [get_cells "picosocInst_aes_coprocessor/*/*/*" -quiet]

    # Create VM Buckets
    gui_create_vmbucket -vmname proc_aes_coprocessor_highlight -name aes_coprocessor -title "AES Coprocessor" -color blue -collection $AES_COPRO

}
                                                     
define_proc_attributes highlight_aes_coprocessor \
    -info "Highlight the AES coprocessor on the layout." \
    -define_args {}


proc highlight_ascon_coprocessor { args } {

   gui_create_vm -name proc_ascon_coprocessor_highlight -title "Highlight ASCON Coprocessor"

   set ASCON_COPRO  [get_cells "picosocInst_ascon_coprocessor/*" -quiet]

    # Create VM Buckets
    gui_create_vmbucket -vmname proc_ascon_coprocessor_highlight -name ascon_coprocessor -title "ASCON Coprocessor" -color red -collection $ASCON_COPRO

}

define_proc_attributes highlight_ascon_coprocessor \
    -info "Highlight the ASCON coprocessor on the layout." \
    -define_args {}

proc highlight_coprocessors { args } {

   gui_create_vm -name proc_coprocessors_highlight -title "Highlight Coprocessors"

   set AES_COPRO  [get_cells "picosocInst_aes_coprocessor/*" -quiet]
   append_to_collection AES_COPRO [get_cells "picosocInst_aes_coprocessor/*/*" -quiet]
   append_to_collection AES_COPRO [get_cells "picosocInst_aes_coprocessor/*/*/*" -quiet]

   set ASCON_COPRO  [get_cells "picosocInst_ascon_coprocessor/*" -quiet]


    # Create VM Buckets
    gui_create_vmbucket -vmname proc_coprocessors_highlight -name aes_coprocessor -title "AES Coprocessor" -color blue -collection $AES_COPRO
    gui_create_vmbucket -vmname proc_coprocessors_highlight -name ascon_coprocessor -title "ASCON Coprocessor" -color red -collection $ASCON_COPRO

}

define_proc_attributes highlight_coprocessors \
    -info "Highlight the coprocessors on the layout." \
    -define_args {}


proc highlight_ro_sensors { args } {

   gui_create_vm -name proc_ro_sensors_highlight -title "Highlight RO Sensors"

   set SNSR0_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_0__myro*" -quiet]
   set SNSR1_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_1__myro*" -quiet]
   set SNSR2_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_2__myro*" -quiet]
   set SNSR3_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_3__myro*" -quiet]
   set SNSR4_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_4__myro*" -quiet]
   set SNSR5_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_5__myro*" -quiet]
   set SNSR6_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_6__myro*" -quiet]
   set SNSR7_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_7__myro*" -quiet]
   set SNSR8_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_8__myro*" -quiet]
   set SNSR9_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_9__myro*" -quiet]
   set SNSR10_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_10__myro*" -quiet]
   set SNSR11_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_11__myro*" -quiet]
   set SNSR12_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_12__myro*" -quiet]
   set SNSR13_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_13__myro*" -quiet]
   set SNSR14_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_14__myro*" -quiet]
   set SNSR15_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_15__myro*" -quiet]


    # Create VM Buckets
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro0_mux -title "RO0 with Mux" -color blue -collection $SNSR0_MUX
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro1_mux -title "RO1 with Mux" -color red -collection $SNSR1_MUX
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro2_mux -title "RO2 with Mux" -color purple -collection $SNSR2_MUX
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro3_mux -title "RO3 with Mux" -color yellow -collection $SNSR3_MUX
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro4_mux -title "RO4 with Mux" -color orange -collection $SNSR4_MUX
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro5_mux -title "RO5 with Mux" -color brown -collection $SNSR5_MUX
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro6_mux -title "RO6 with Mux" -color pink -collection $SNSR6_MUX
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro7_mux -title "RO7 with Mux" -color violet -collection $SNSR7_MUX
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro8_mux -title "RO8 with Mux" -color green -collection $SNSR8_MUX
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro9_mux -title "RO9 with Mux" -color cyan -collection $SNSR9_MUX
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro10_mux -title "RO10 with Mux" -color magenta -collection $SNSR10_MUX
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro11_mux -title "RO11 with Mux" -color gold -collection $SNSR11_MUX
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro12_mux -title "RO12 with Mux" -color #D0FF14 -collection $SNSR12_MUX
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro13_mux -title "RO13 with Mux" -color white -collection $SNSR13_MUX
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro14_mux -title "RO14 with Mux" -color beige -collection $SNSR14_MUX
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro15_mux -title "RO15 with Mux" -color grey -collection $SNSR15_MUX



   set SNSR0_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_0__myro*" -quiet]
   set SNSR1_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_1__myro*" -quiet]
   set SNSR2_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_2__myro*" -quiet]
   set SNSR3_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_3__myro*" -quiet]
   set SNSR4_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_4__myro*" -quiet]
   set SNSR5_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_5__myro*" -quiet]
   set SNSR6_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_6__myro*" -quiet]
   set SNSR7_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_7__myro*" -quiet]
   set SNSR8_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_8__myro*" -quiet]
   set SNSR9_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_9__myro*" -quiet]
   set SNSR10_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_10__myro*" -quiet]
   set SNSR11_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_11__myro*" -quiet]
   set SNSR12_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_12__myro*" -quiet]
   set SNSR13_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_13__myro*" -quiet]
   set SNSR14_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_14__myro*" -quiet]
   set SNSR15_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_15__myro*" -quiet]


    # Create VM Buckets
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro0_tri -title "RO0 with TriBuff" -color #9EFD38 -collection $SNSR0_TRI
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro1_tri -title "RO1 with TriBuff" -color #D473D4 -collection $SNSR1_TRI
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro2_tri -title "RO2 with TriBuff" -color #E48400 -collection $SNSR2_TRI
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro3_tri -title "RO3 with TriBuff" -color #0072BB -collection $SNSR3_TRI
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro4_tri -title "RO4 with TriBuff" -color #15F4EE -collection $SNSR4_TRI
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro5_tri -title "RO5 with TriBuff" -color #96C8A2 -collection $SNSR5_TRI
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro6_tri -title "RO6 with TriBuff" -color #C2B280 -collection $SNSR6_TRI
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro7_tri -title "RO7 with TriBuff" -color #1560BD -collection $SNSR7_TRI
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro8_tri -title "RO8 with TriBuff" -color #8FBC8F -collection $SNSR8_TRI
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro9_tri -title "RO9 with TriBuff" -color #F56FA1 -collection $SNSR9_TRI
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro10_tri -title "RO10 with TriBuff" -color #FF7F50 -collection $SNSR10_TRI
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro11_tri -title "RO11 with TriBuff" -color #B9D9EB -collection $SNSR11_TRI
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro12_tri -title "RO12 with TriBuff" -color #56A0D3 -collection $SNSR12_TRI
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro13_tri -title "RO13 with TriBuff" -color #915C83 -collection $SNSR13_TRI
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro14_tri -title "RO14 with TriBuff" -color #B0BF1A -collection $SNSR14_TRI
    gui_create_vmbucket -vmname proc_ro_sensors_highlight -name ro15_tri -title "RO15 with TriBuff" -color #8DB600 -collection $SNSR15_TRI
}

define_proc_attributes highlight_ro_sensors \
    -info "Highlight the RO sensors on the layout." \
    -define_args {}





proc highlight_coprocessors_ros { args } {

   gui_create_vm -name proc_coprocessors_ros_highlight -title "Highlight Coprocessors and RO Sensors"

   set AES_COPRO  [get_cells "picosocInst_aes_coprocessor/*" -quiet]
   append_to_collection AES_COPRO [get_cells "picosocInst_aes_coprocessor/*/*" -quiet]
   append_to_collection AES_COPRO [get_cells "picosocInst_aes_coprocessor/*/*/*" -quiet]

   set ASCON_COPRO  [get_cells "picosocInst_ascon_coprocessor/*" -quiet]

   set SNSR0_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_0__myro*" -quiet]
   set SNSR1_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_1__myro*" -quiet]
   set SNSR2_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_2__myro*" -quiet]
   set SNSR3_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_3__myro*" -quiet]
   set SNSR4_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_4__myro*" -quiet]
   set SNSR5_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_5__myro*" -quiet]
   set SNSR6_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_6__myro*" -quiet]
   set SNSR7_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_7__myro*" -quiet]
   set SNSR8_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_8__myro*" -quiet]
   set SNSR9_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_9__myro*" -quiet]
   set SNSR10_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_10__myro*" -quiet]
   set SNSR11_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_11__myro*" -quiet]
   set SNSR12_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_12__myro*" -quiet]
   set SNSR13_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_13__myro*" -quiet]
   set SNSR14_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_14__myro*" -quiet]
   set SNSR15_MUX  [get_cells "picosocInst_ro_countermeasure_mux_ro_multi_inst_mux_genblk1_15__myro*" -quiet]


   set SNSR0_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_0__myro*" -quiet]
   set SNSR1_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_1__myro*" -quiet]
   set SNSR2_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_2__myro*" -quiet]
   set SNSR3_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_3__myro*" -quiet]
   set SNSR4_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_4__myro*" -quiet]
   set SNSR5_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_5__myro*" -quiet]
   set SNSR6_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_6__myro*" -quiet]
   set SNSR7_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_7__myro*" -quiet]
   set SNSR8_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_8__myro*" -quiet]
   set SNSR9_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_9__myro*" -quiet]
   set SNSR10_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_10__myro*" -quiet]
   set SNSR11_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_11__myro*" -quiet]
   set SNSR12_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_12__myro*" -quiet]
   set SNSR13_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_13__myro*" -quiet]
   set SNSR14_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_14__myro*" -quiet]
   set SNSR15_TRI  [get_cells "picosocInst_ro_countermeasure_tri_ro_multi_inst_tri_genblk1_15__myro*" -quiet]



    # Create VM Buckets
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro0_mux -title "RO0 with Mux" -color pink -collection $SNSR0_MUX
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro1_mux -title "RO1 with Mux" -color pink -collection $SNSR1_MUX
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro2_mux -title "RO2 with Mux" -color pink -collection $SNSR2_MUX
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro3_mux -title "RO3 with Mux" -color pink -collection $SNSR3_MUX
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro4_mux -title "RO4 with Mux" -color pink -collection $SNSR4_MUX
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro5_mux -title "RO5 with Mux" -color pink -collection $SNSR5_MUX
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro6_mux -title "RO6 with Mux" -color pink -collection $SNSR6_MUX
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro7_mux -title "RO7 with Mux" -color pink -collection $SNSR7_MUX
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro8_mux -title "RO8 with Mux" -color pink -collection $SNSR8_MUX
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro9_mux -title "RO9 with Mux" -color pink -collection $SNSR9_MUX
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro10_mux -title "RO10 with Mux" -color pink -collection $SNSR10_MUX
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro11_mux -title "RO11 with Mux" -color pink -collection $SNSR11_MUX
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro12_mux -title "RO12 with Mux" -color pink -collection $SNSR12_MUX
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro13_mux -title "RO13 with Mux" -color pink -collection $SNSR13_MUX
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro14_mux -title "RO14 with Mux" -color pink -collection $SNSR14_MUX
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro15_mux -title "RO15 with Mux" -color pink -collection $SNSR15_MUX



    # Create VM Buckets
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro0_tri -title "RO0 with TriBuff" -color white -collection $SNSR0_TRI
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro1_tri -title "RO1 with TriBuff" -color white -collection $SNSR1_TRI
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro2_tri -title "RO2 with TriBuff" -color white -collection $SNSR2_TRI
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro3_tri -title "RO3 with TriBuff" -color white -collection $SNSR3_TRI
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro4_tri -title "RO4 with TriBuff" -color white -collection $SNSR4_TRI
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro5_tri -title "RO5 with TriBuff" -color white -collection $SNSR5_TRI
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro6_tri -title "RO6 with TriBuff" -color white -collection $SNSR6_TRI
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro7_tri -title "RO7 with TriBuff" -color white -collection $SNSR7_TRI
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro8_tri -title "RO8 with TriBuff" -color white -collection $SNSR8_TRI
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro9_tri -title "RO9 with TriBuff" -color white -collection $SNSR9_TRI
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro10_tri -title "RO10 with TriBuff" -color white -collection $SNSR10_TRI
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro11_tri -title "RO11 with TriBuff" -color white -collection $SNSR11_TRI
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro12_tri -title "RO12 with TriBuff" -color white -collection $SNSR12_TRI
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro13_tri -title "RO13 with TriBuff" -color white -collection $SNSR13_TRI
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro14_tri -title "RO14 with TriBuff" -color white -collection $SNSR14_TRI
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ro15_tri -title "RO15 with TriBuff" -color white -collection $SNSR15_TRI

    # Create VM Buckets
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name aes_coprocessor -title "AES Coprocessor" -color blue -collection $AES_COPRO
    gui_create_vmbucket -vmname proc_coprocessors_ros_highlight -name ascon_coprocessor -title "ASCON Coprocessor" -color red -collection $ASCON_COPRO

}

define_proc_attributes highlight_coprocessors_ros \
    -info "Highlight the coprocessors on the layout." \
    -define_args {}

