extends Control

# Customizable Variables:
@export var USE_NODES: bool = false

func _on_save_button_pressed() -> void:
	if (USE_NODES): EzSaving.save_file()
	
func _on_load_button_pressed() -> void:
	if (USE_NODES): EzSaving.load_file()
