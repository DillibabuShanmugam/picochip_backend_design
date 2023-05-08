proc macroalign {} {
   set all_macros [get_flat_cells -filter "is_hard_macro"]
   set all_macros1 [get_flat_cells -filter "is_hard_macro"]
   set all ""
   set all1 ""
   foreach_in_collection macro [get_flat_cells -filter "is_hard_macro"] {
      set macro_origin [get_attribute [get_flat_cells $macro] origin]
      set macro_height [get_attribute [get_flat_cells $macro]   height]
      set x_macro [lindex $macro_origin 0]
      set y_macro [lindex $macro_origin 1]
      set status 1
      foreach_in_collection site_row [get_site_rows -at $macro_origin] {
         set coordinate [get_attribute $site_row origin]
         set hght [get_attribute $site_row site_height]
         set wdth [get_attribute $site_row site_width]
         set y_site_row [lindex $coordinate 1]
         set x_site_row [lindex $coordinate 0]
         if {$y_site_row == $y_macro} {
            set status 0
            set pc [expr $x_macro > $x_site_row]
            while {1} {
               if { $pc  } {
                  set  x_site_row [expr $x_site_row + $wdth]
                  set pc [expr $x_macro > $x_site_row]
               } else {
                  set pc1 [expr $x_macro == $x_site_row]
                  if { $pc1 } {
                     break
                  } else {
                     append_to_collection all $macro
                     break
                  }
               }
            } ;# while   
         }  ;# if  
      } ;# foreach         
      if {$status} {
         #puts "macro [get_object_name $macro] origin y coordinate  is not aligned"
         append_to_collection all1 $macro
         foreach_in_collection site_row [get_site_rows -at $macro_origin] {
            set coordinate [get_attribute $site_row origin]
            set hght [get_attribute $site_row site_height]
            set wdth [get_attribute $site_row site_width]
            set y_site_row [lindex $coordinate 1]
            set x_site_row [lindex $coordinate 0]
            set pc [expr $x_macro > $x_site_row]
            while {1} {
               if { $pc  } {
                  set  x_site_row [expr $x_site_row + $wdth]
                  set pc [expr $x_macro > $x_site_row]
               } else {
                  set pc1 [expr $x_macro == $x_site_row]
                  if { $pc1 } {
                     break
                  } else {
                     append_to_collection all $macro
                     break
                  }
               }
            }
         }  
      }
   }
   puts "Macros for which x is not aligned count is [sizeof_collection [get_flat_cells $all]]"
   puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
   puts "[get_object_name $all]"
   puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
   puts "Macros for which y is not aligned count is [sizeof_collection [get_flat_cells $all1]]"
   puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
   puts "[get_object_name $all1]"
   puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
