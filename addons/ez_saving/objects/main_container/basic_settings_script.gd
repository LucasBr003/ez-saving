@tool
extends Control

func _on_save_path_edit_text_submitted(new_text: String) -> void:
	# Updating the save file path.
	EzSaving.set_file_path(new_text)
	
func _on_time_spinbox_value_changed(value: float) -> void:
	# Updating the auto saving interval.
	EzSaving.set_autosave_interval(value)	
	
func _on_default_slot_spinbox_value_changed(value: float) -> void:
	# Updating the selected save slot.
	EzSaving.set_save_slot(value)
	
func _on_auto_save_checkbox_toggled(button_pressed: bool) -> void:
	# Updating the automatic saving function.
	EzSaving.toggle_automatic_saving(button_pressed)
	
func _on_debug_mode_checkbox_toggled(button_pressed: bool) -> void:
	# Updating the debug prints.
	EzSaving.toggle_debug_prints(button_pressed)
	
func _on_encrypt_save_checkbox_toggled(button_pressed: bool) -> void:
	# Updating the save encryption function.
	EzSaving.toggle_encryption(button_pressed)
	
func _on_autoload_checkbox_toggled(button_pressed: bool) -> void:
	# Updating the automatic loading.
	EzSaving.toggle_autoload(button_pressed)
