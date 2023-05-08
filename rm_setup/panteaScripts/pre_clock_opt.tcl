set timestamp [clock format [clock seconds] -format {%b%d_%H%M%S}]
# remove ideal network previously set on any net in the design
remove_ideal_network [all_fanout -flat -clock_tree]
