proc show_error {errorType} {
    gui_unload_error_cel
    gui_load_error_view -error_cel_type "Detail Route"
    gui_error_browser -show
    gui_set_error_browser_option -show_mode none
    gui_set_error_browser_option -view_mode off
    foreach error [list_drc_error_types] {
        if {$error == $errorType} {
            gui_set_current_errors -data_name "Detail Route" -group $errorType
            break
        }
    }
    gui_set_error_browser_option -show_mode all
}

