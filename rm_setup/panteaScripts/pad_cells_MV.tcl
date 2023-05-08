#========================================#
# Script : create_pad_cells.tcl
#========================================#
#create nets
create_net -power VD33
create_net -ground VSSPST
#****************************************VSS for CORE***************************#
create_cell vss1left $core_vss_pad 
connect_net GN1 vss1left/VSS

create_cell vss1right $core_vss_pad 
connect_net GN1 vss1right/VSS

create_cell vss1top $core_vss_pad 
connect_net GN1 vss1top/VSS

create_cell vss1bottom $core_vss_pad 
connect_net GN1 vss1bottom/VSS

create_cell vss2left $core_vss_pad 
connect_net GN2 vss2left/VSS

create_cell vss2right $core_vss_pad 
connect_net GN1 vss2right/VSS

create_cell vss2top $core_vss_pad 
connect_net GN1 vss2top/VSS

create_cell vss2bottom $core_vss_pad 
connect_net GN1 vss2bottom/VSS

#*****************************************VDD for CORE************************#
create_cell vdd1left $core_vdd_pad 
connect_net VN1 vdd1left/VDD

create_cell vdd1right $core_vdd_pad 
connect_net VN1 vdd1right/VDD

create_cell vdd1top $core_vdd_pad 
connect_net VN1 vdd1top/VDD

create_cell vdd1bottom $core_vdd_pad 
connect_net VN1 vdd1bottom/VDD

create_cell vdd2bottom $core_vdd_pad 
connect_net VN1 vdd2bottom/VDD

create_cell vdd2top $core_vdd_pad 
connect_net VN1 vdd2top/VDD

create_cell vdd2left $core_vdd_pad 
connect_net VN2 vdd2left/VDD

create_cell vdd2right $core_vdd_pad 
connect_net VN1 vdd2right/VDD
#*******************************************I/O VDD ************************************#
create_cell vdd3left $io_vdd_pad 
connect_net VD33 vdd3left/VD33

create_cell vdd3right $io_vdd_pad 
connect_net VD33 vdd3right/VD33

create_cell vdd3top $io_vdd_pad 
connect_net VD33 vdd3top/VD33

create_cell vdd3bottom $io_vdd_pad 
connect_net VD33 vdd3bottom/VD33

#*********************************************I/O VSS***********************************#
create_cell vss3left $io_vss_pad 
connect_net VSSPST vss3left/VSSPST

create_cell vss3right $io_vss_pad 
connect_net VSSPST vss3right/VSSPST

create_cell vss3top $io_vss_pad 
connect_net VSSPST vss3top/VSSPST

create_cell vss3bottom $io_vss_pad 
connect_net VSSPST vss3bottom/VSSPST

create_cell {cornerll cornerlr cornerul cornerur} PCORNER

##### update the power domain :
create_power_domain PD_AES -elements {picosocInst_aes_coprocessor vdd2left vss2left} -update

