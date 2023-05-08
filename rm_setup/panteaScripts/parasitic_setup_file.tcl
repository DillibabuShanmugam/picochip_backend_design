#set PARASITIC_FILE1 "$technology_file_path/tluplus/t018lo_1p4m_typical.tluplus"
#set PARASITIC_FILE2 "$technology_file_path/tluplus/t018lo_1p5m_typical.tluplus"
#set PARASITIC_FILE3 "$technology_file_path/tluplus/t018lo_1p6m_typical.tluplus"
#set PARASITIC_FILE "$PARASITIC_FILE1 $PARASITIC_FILE2 $PARASITIC_FILE3"
#set PARASITIC_FILE "$technology_file_path/tluplus/t018lo_1p6m_typical.tluplus"
#set LAYERMAP_FILE "$technology_file_path/tluplus/star.map_6M"
read_parasitic_tech -tlup $PARASITIC_FILE -layermap $LAYERMAP_FILE
