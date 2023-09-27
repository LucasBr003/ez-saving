@tool
@icon("res://addons/ez_saving/images/node_icons/save_link_icon.svg")
extends Save
class_name SaveLink

## A node capable of synchronizing a save value and a node property.

# Customizable Variables:
@export_enum("Property = Save Value", "Save Value = Property") var LINK_MODE: int = 0 ## How this node should synchronize stuff.
@export var PARENT_PROPERTY: String ## The name of the parent node's property that is going to be synchronized or used to synchronize the save value.
@export var SAVE_VALUE: String ## The name of the save value key that is going to be synchronized or used to synchronize the parent node's property.
@export var PARENT_SIGNAL: String ## The name of the signal that this node is going to listen to synchronize stuff.

# Nodes:
@onready var PARENT = get_parent()

func _ready() -> void:
	# Connections.
	PARENT.connect(PARENT_SIGNAL, sync_property_to_save if (LINK_MODE == 0) else sync_save_to_property)
	EzSaving.connect("file_loaded", sync_property_to_save)
	
func sync_property_to_save(_arg1: Variant = null, _arg2: Variant = null, _arg3: Variant = null, _arg4: Variant = null, _arg5: Variant = null) -> void:
	# Setting the parent's property.
	PARENT.set(PARENT_PROPERTY, EzSaving.get_data(SAVE_VALUE))
	
func sync_save_to_property(_arg1: Variant = null, _arg2: Variant = null, _arg3: Variant = null, _arg4: Variant = null, _arg5: Variant = null) -> void:
	# Setting the save value.
	EzSaving.set_data(SAVE_VALUE, PARENT.get(PARENT_PROPERTY))
