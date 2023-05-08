#========================================#
# Script : create_pad_cells.tcl
#========================================#
#create nets
create_net -power VDDPST
create_net -ground VSSPST
#****************************************VSS for CORE***************************#
create_cell vss1left $core_vss_pad 
connect_net VSS vss1left/VSS

create_cell vss1right $core_vss_pad 
connect_net VSS vss1right/VSS

create_cell vss1top $core_vss_pad 
connect_net VSS vss1top/VSS

create_cell vss1bottom $core_vss_pad 
connect_net VSS vss1bottom/VSS

create_cell vss2left $core_vss_pad 
connect_net VSS vss2left/VSS

create_cell vss2right $core_vss_pad 
connect_net VSS vss2right/VSS

create_cell vss2top $core_vss_pad 
connect_net VSS vss2top/VSS

create_cell vss2bottom $core_vss_pad 
connect_net VSS vss2bottom/VSS

#*****************************************VDD for CORE************************#
create_cell vdd1left $core_vdd_pad 
connect_net VDD vdd1left/VDD

create_cell vdd1right $core_vdd_pad 
connect_net VDD vdd1right/VDD

create_cell vdd1top $core_vdd_pad 
connect_net VDD vdd1top/VDD

create_cell vdd1bottom $core_vdd_pad 
connect_net VDD vdd1bottom/VDD

create_cell vdd2bottom $core_vdd_pad 
connect_net VDD vdd2bottom/VDD

create_cell vdd2top $core_vdd_pad 
connect_net VDD vdd2top/VDD

create_cell vdd2left $core_vdd_pad 
connect_net VDD vdd2left/VDD

create_cell vdd2right $core_vdd_pad 
connect_net VDD vdd2right/VDD
#*******************************************I/O VDD ************************************#
create_cell vdd3left $io_vdd_pad 
connect_net VDDPST vdd3left/$io_vdd_pin

create_cell vdd3right $io_vdd_pad 
connect_net VDDPST vdd3right/$io_vdd_pin

create_cell vdd3top $io_vdd_pad 
connect_net VDDPST vdd3top/$io_vdd_pin

create_cell vdd3bottom $io_vdd_pad 
connect_net VDDPST vdd3bottom/$io_vdd_pin

#*********************************************I/O VSS***********************************#
create_cell vss3left $io_vss_pad 
connect_net VSSPST vss3left/$io_vss_pin

create_cell vss3right $io_vss_pad 
connect_net VSSPST vss3right/$io_vss_pin

create_cell vss3top $io_vss_pad 
connect_net VSSPST vss3top/$io_vss_pin

create_cell vss3bottom $io_vss_pad 
connect_net VSSPST vss3bottom/$io_vss_pin

#*********************************************I/O POC***********************************#
create_cell vddpoc PVDD2POC

#*********************************************CORNER PADS***********************************#
create_cell {cornerll cornerlr cornerul cornerur} PCORNER

