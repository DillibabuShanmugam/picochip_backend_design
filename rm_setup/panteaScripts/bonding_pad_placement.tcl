##### bond pads:
source rm_setup/panteaScripts/createNplace_bondpads.tcl
source rm_setup/panteaScripts/delete_bondpads.tcl

#set BONDING_PAD_REF PAD70NU
#createNplace_bondpads -inline_pad_ref_name $BONDING_PAD_REF
set BONDING_PAD_REF_DIG1 PAD70N
set BONDING_PAD_REF_DIG2 PAD70G
#set BONDING_PAD_REF_ANALOG PAD50LAR_OBV
#new set BONDING_PAD_REF_ANALOG PAD50LAR_TRL
#new set BONDING_PAD_REF_ANALOG_POWER PAD50LA

#createNplace_bondpads_digital -inline_pad_ref_name $BONDING_PAD_REF_DIG1 -stagger true -stagger_pad_ref_name $BONDING_PAD_REF_DIG2
createNplace_bondpads -inline_pad_ref_name $BONDING_PAD_REF_DIG1
#new createNplace_bondpads_digital -inline_pad_ref_name $BONDING_PAD_REF_DIG1
#new createNplace_bondpads_analog -inline_pad_ref_name $BONDING_PAD_REF_ANALOG 
#new createNplace_bondpads_analog_power -inline_pad_ref_name $BONDING_PAD_REF_ANALOG_POWER

#remove_cells [get_cells -hier -filter ref_name==$BONDING_PAD_REF]
#delete_bondpads -bond_pad_ref_name PAD50LA

##### fix bonding pads:
#set bonding_pad_cells [get_cells -hier -filter ref_name==$BONDING_PAD_REF]
#new set bonding_pad_cells [get_cells -hier -filter "ref_name==$BONDING_PAD_REF_DIG1 || ref_name==$BONDING_PAD_REF_DIG2 || ref_name==$BONDING_PAD_REF_ANALOG || ref_name==$BONDING_PAD_REF_ANALOG_POWER"]
set bonding_pad_cells [get_cells -hier -filter "ref_name==$BONDING_PAD_REF_DIG1 || ref_name==$BONDING_PAD_REF_DIG2"]
set_placement_status fixed $bonding_pad_cells
