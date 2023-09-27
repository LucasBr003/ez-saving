@tool
@icon("res://addons/ez_saving/images/node_icons/save_trigger_icon.svg")
extends Save
class_name SaveTrigger

## A node capable of saving or loading when the parent node emits a signal.

# Customizable Variables:
@export_enum("Save", "Load", "Reset") var TRIGGER_ACTION: int = 0 ## What this node should do when the desired signal is emitted.
@export var SAVE_SLOT_OVERRIDE: int = -1 ## If this value is smaller than 0, the selected save slot will be replaced by this value, and the action will occur in the new selected slot.
@export var PARENT_SIGNAL: String ## The name of the signal that this node is going to listen to be triggered.

func _ready() -> void:
	# Connections.
	get_parent().connect(PARENT_SIGNAL, trigger)
	
func trigger(_arg1: Variant = null, _arg2: Variant = null, _arg3: Variant = null, _arg4: Variant = null, _arg5: Variant = null) -> void:
	# Updating the selected save slot.
	EzSaving.set_save_slot(SAVE_SLOT_OVERRIDE if (SAVE_SLOT_OVERRIDE >= 0	) else EzSaving.get_save_slot())
	
	# Checking for what action should be taken.
	match TRIGGER_ACTION:
		0: EzSaving.save_file() # Saving.
		1: EzSaving.load_file() # Loading.
		2: EzSaving.DATA = EzSaving.create_data() # Resetting.
