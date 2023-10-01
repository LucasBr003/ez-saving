@tool
extends Node

###############################################################################################################################################
###############################################################################################################################################
###############################################################################################################################################

func create_data() -> Dictionary:
	# The save file data. 
	# Customize it here :) 
	# Don't touch anything else >:(
	# Feel free to create new variables inside this function.
	return {
		# Add your data here.
		"TestInteger": 1,
		"TestFloat": 1.5,
		"TestString": "Hello world!",
		"TestParagraph": "Blablalbalbalballb\ndsaasiosa",
		"TestBoolean": true
	}

###############################################################################################################################################
###############################################################################################################################################
###############################################################################################################################################

# Signals:
signal file_loaded
signal file_saved

# Plugin Variables:
static var __save_file_path: String
static var __selected_save_slot: int
static var __autosave_interval: int
static var __automatic_saving: bool
static var __debug_prints: bool
static var __encrypt_save: bool 
static var __autoload: bool

var PLUGIN_SETTINGS: Dictionary = {
	"SaveFilePath": "user://save",
	"SelectedSaveSlot": 0,
	"AutosaveInterval": 1.0,
	"AutomaticSaving": false,
	"DebugPrints": true,
	"EncryptSave": true,
	"AutoloadSave": false,
}

var DATA: Dictionary = {}
var tick: float = 0.0

func _ready() -> void:
	# Loading the plugin's settings.
	if (!Engine.is_editor_hint()): # Only running this code in real time.
		# Actually loading the settings.
		load_plugin_settings()
		
		# Printing a success message.
		if (__debug_prints): # Checking if the plugin can send debug prints.
			print("Successfully loaded the plugin's settings.\n%s" % str(PLUGIN_SETTINGS)) # Printing a success message.
			
		# Automatically loading the save file.
		if (__autoload): # Checking if the save file should be loaded automatically as soon as possible.
			load_file() # Loading the save file if so.
			
			# Printing a success message.
			if (__debug_prints): # Checking if the plugin can send debug prints.
				print("Automatically loading the save file...") # Printing a success message
			
func _process(delta: float) -> void:
	# Checking if automatic saving is enabled.
	if (!__automatic_saving || Engine.is_editor_hint()):
		return # Stopping the code right here.
	
	# Automatic Saving.
	tick += delta # Increasing the tick variable.
	
	if (tick > get_autosave_interval() * 60.0): # Checking if it has been enough time to autosave.
		# Resetting the tick variable.
		tick = 0
		
		# Saving.
		save_file()
		
		# Printing a success message.
		if (__debug_prints): # Checking if the plugin can send debug prints.
			print("Successfully autosaved.") # Printing a success message.
	
func save_file() -> void:
	# Checking if the save path is valid.
	if (!__save_file_path.begins_with("user://") || "." in __save_file_path || !DirAccess.dir_exists_absolute((__save_file_path + ".dat").get_base_dir())):
		# Printing an error if not.
			if (__debug_prints): # Checking if the plugin can send debug prints.
				printerr("Could not save game data. The save file path (\"%s\") is invalid!" % __save_file_path)
				return # Stopping the code right here.
	
	# Saving *DATA* as a file.
	var file = FileAccess.open(get_save_file_path(), FileAccess.WRITE) # Openning the Save File.
	file.store_var(DATA) # Saving the File.
	
	# Printing a success message.
	if (__debug_prints): # Checking if the plugin can send debug prints.
		print("Successfully saved game data at \"%s\".\n%s" % [get_save_file_path(), str(DATA)]) # Printing a success message.
		
	# Closing the file since it's not useful anymore.
	file.close()

	# Emitting a signal.
	emit_signal("file_saved")
	
func load_file() -> void:
	# Loading the File.
	if (FileAccess.file_exists(get_save_file_path())): # Checking if the file exists.
		# Getting ready to read the file.
		var file = FileAccess.open(get_save_file_path(), FileAccess.READ)
		
		# Loading the existing file.
		#DATA = file.get_var()
		var temp_data: Dictionary = file.get_var()
		
		# Making sure that all data is handled.
		for key in create_data().keys(): # Looping trough every key in the default data.
			if (temp_data.has(key)): # Checking if the saved file has the current key.
				DATA[key] = temp_data[key] # Using the file's data to set the current data if so.
			else:
				DATA[key] = create_data()[key] # Using the default data's data to set the current data if not.
		
		# Closing the file since it's not useful anymore.
		file.close()
		
		if (__debug_prints): # Checking if the plugin can send debug prints.
			print("Successfully loaded an existing save file at \"%s\".\n%s" % [get_save_file_path(), str(DATA)]) # Printing a message if so.
			
		# Emitting a signal.
		emit_signal("file_loaded")
	else:
		DATA = create_data() # Loading a new file.
		
		if (__debug_prints): # Checking if the plugin can send debug prints.
			print("Could not find an existing save file at \"%s\". Using the default data instead.\n%s" % [get_save_file_path(), str(DATA)]) # Printing a message if so.
			
func get_data(key: String) -> Variant:
	# Trying to get the requested data.
	if (DATA.has(key)): # Checking if the DATA dictionary has the given key.
		return DATA[key] # Returning it if so.
	
	# Printing an error message.
	if (__debug_prints): # Checking if the plugin can send debug prints.
		printerr("Could not get the save value \"%s\" since it does not exist!" % key) # Printing an error if so.
		
	# Returning null.
	return null
	
func set_data(key: String, value: Variant) -> void:
	# Trying to get the requested data.
	if (DATA.has(key)): # Checking if the DATA dictionary has the given key.
		DATA[key] = value # Updating it if so.
	
	# Printing an error message.
	elif (__debug_prints): # Checking if the plugin can send debug prints.
		printerr("Could not set the save value \"%s\" since it does not exist!" % key) # Printing an error if so.
	
func set_file_path(new_path: String) -> void:
	# Checking if the new path is correct.
	if (!new_path.begins_with("user://")): # Checking if the new path begins with "user://".
		# Printing an error if not.
		if (__debug_prints): # Checking if the plugin can send debug prints.
			printerr("Could not update the save file path from \"%s\" to \"%s\" because the directory must begin with \"user://\"!" % [__save_file_path, new_path]) # Printing an error.
			return # Stopping the code right here.
			
	elif ("." in new_path): # Checking if the new path has a file extension in it.
		# Printing an error if so.
		if (__debug_prints): # Checking if the plugin can send debug prints.
			printerr("Could not update the save file path from \"%s\" to \"%s\" because the directory has a file extension!" % [__save_file_path, new_path]) # Printing an error.
			return # Stopping the code right here.
			
	elif (!DirAccess.dir_exists_absolute((new_path + ".dat").get_base_dir())): # Checking if the new path exists.
		# Printing an error if not.
		if (__debug_prints): # Checking if the plugin can send debug prints.
			printerr("Could not update the save file path from \"%s\" to \"%s\" because the directory doesn't exist!" % [__save_file_path, new_path]) # Printing an error.
			return # Stopping the code right here.
			
	# Printing a success message.
	if (__debug_prints): # Checking if the plugin can send debug prints.
		print("Successfully updated the save file path from \"%s\" to \"%s\"." % [__save_file_path, new_path]) # Printing a success message.
	
	# Updating the save file path.
	__save_file_path = new_path
	
	# Updating the plugin's settings.
	PLUGIN_SETTINGS["SaveFilePath"] = __save_file_path # Updating the variable.
	save_plugin_settings() # Saving the pluggin's settings.
	
func set_save_slot(new_slot: int) -> void:
	# Checking if the new slot is a valid number.
	if (new_slot < 0): # Checking if the new slot is smaller than 0.
		# Printing an error if so.
		if (__debug_prints): # Checking if the plugin can send debug prints.
			printerr("Could not update the selected save slot from \"%s\" to \"%s\" because the new slot ID should be a positive integer!" % [__selected_save_slot, new_slot]) # Printing an error.
			return # Stopping the code right here.
	
	# Printing a success message.
	if (__debug_prints): # Checking if the plugin can send debug prints.
		print("Successfully updated the selected save slot from \"%s\" to \"%s\"." % [__selected_save_slot, new_slot]) # Printing a success message.
	
	# Updating the selected save slot.
	__selected_save_slot = new_slot
	
	# Updating the plugin's settings.
	PLUGIN_SETTINGS["SelectedSaveSlot"] = __selected_save_slot # Updating the variable.
	save_plugin_settings() # Saving the pluggin's settings.
	
func set_autosave_interval(new_interval: int) -> void:
	# Checking if the new slot is a valid number.
	if (new_interval < 1): # Checking if the new slot is smaller than 0.
		# Printing an error if so.
		if (__debug_prints): # Checking if the plugin can send debug prints.
			printerr("Could not update the automatic save interval from \"%s\" to \"%s\" because the new interval should be a positive integer greater than 1!" % [__autosave_interval, new_interval]) # Printing an error.
			return # Stopping the code right here.
	
	# Printing a success message.
	if (__debug_prints): # Checking if the plugin can send debug prints.
		print("Successfully updated the autosave interval from \"%s\" to \"%s\"." % [__autosave_interval, new_interval]) # Printing a success message.
	
	# Updating the autosave interval.
	__autosave_interval = new_interval
	
	# Updating the plugin's settings.
	PLUGIN_SETTINGS["AutosaveInterval"] = __autosave_interval # Updating the variable.
	save_plugin_settings() # Saving the pluggin's settings.
	
func toggle_automatic_saving(enabled: bool) -> void:
	# Updating the automatic saving.
	var message: Dictionary = { # Creating a new dictionary to easily print the correct message.
		true: "[color=green]enabled",
		false: "[color=red]disabled"
	}
	
	# Printing a success message.
	if (__debug_prints): # Checking if the plugin can send debug prints.
		print_rich("Automatic Saving is now %s[/color]." % message[enabled]) # Printing a success message.
	
	# Updating the automatic saving.
	__automatic_saving = enabled
	
	# Updating the plugin's settings.
	PLUGIN_SETTINGS["AutomaticSaving"] = __automatic_saving # Updating the variable.
	save_plugin_settings() # Saving the pluggin's settings.
	
func toggle_encryption(enabled: bool) -> void:
	# Updating the automatic saving.
	var message: Dictionary = { # Creating a new dictionary to easily print the correct message.
		true: "[color=green]enabled",
		false: "[color=red]disabled"
	}
	
	# Printing a success message.
	if (__debug_prints): # Checking if the plugin can send debug prints.
		print_rich("Save Encryption is now %s[/color]." % message[enabled]) # Printing a success message.
	
	# Updating the save encryption.
	__encrypt_save = enabled
	
	# Updating the plugin's settings.
	PLUGIN_SETTINGS["EncryptSave"] = __encrypt_save # Updating the variable.
	save_plugin_settings() # Saving the pluggin's settings.
	
func toggle_autoload(enabled: bool) -> void:
	# Updating the automatically loading.
	var message: Dictionary = { # Creating a new dictionary to easily print the correct message.
		true: "[color=green]enabled",
		false: "[color=red]disabled"
	}
	
	# Printing a success message.
	if (__debug_prints): # Checking if the plugin can send debug prints.
		print_rich("Automatic Loading on Start is now %s[/color]." % message[enabled]) # Printing a success message.
	
	# Updating the automatic loading.
	__autoload = enabled
	
	# Updating the plugin's settings.
	PLUGIN_SETTINGS["AutomaticLoad"] = __autoload # Updating the variable.
	save_plugin_settings() # Saving the pluggin's settings.
	
func toggle_debug_prints(enabled: bool) -> void:
	# Updating the automatic saving.
	var message: Dictionary = { # Creating a new dictionary to easily print the correct message.
		true: "[color=green]enabled",
		false: "[color=red]disabled"
	}
	
	# Printing a success message.
	print_rich("Debug Prints are now %s[/color]." % message[enabled])
	
	# Updating the selected save slot.
	__debug_prints = enabled
	
	# Updating the plugin's settings.
	PLUGIN_SETTINGS["DebugPrints"] = __debug_prints # Updating the variable.
	save_plugin_settings() # Saving the pluggin's settings.
	
func save_plugin_settings() -> void:
	# Saving the plugin's settings as a file.
	var file = FileAccess.open("res://addons/ez_saving/plugin_data.dat", FileAccess.WRITE) # Openning the Save File.
	file.store_var(PLUGIN_SETTINGS) # Saving the File.
	
	# Closing the file since it's not useful anymore.
	file.close()
	
func load_plugin_settings() -> void:
	# Getting ready to read the file.
	var file = FileAccess.open("res://addons/ez_saving/plugin_data.dat", FileAccess.READ)
	
	# Loading the File.
	if (FileAccess.file_exists("res://addons/ez_saving/plugin_data.dat")): # Checking if the file exists.
		PLUGIN_SETTINGS = file.get_var() # Loading the existing file.
	else:
		PLUGIN_SETTINGS = PLUGIN_SETTINGS # Loading a new file.
		
	# Updating the variables.
	__automatic_saving = PLUGIN_SETTINGS["AutomaticSaving"]
	__autosave_interval = PLUGIN_SETTINGS["AutosaveInterval"]
	__debug_prints = PLUGIN_SETTINGS["DebugPrints"]
	__encrypt_save = PLUGIN_SETTINGS["EncryptSave"]
	__save_file_path = PLUGIN_SETTINGS["SaveFilePath"]
	__selected_save_slot = PLUGIN_SETTINGS["SelectedSaveSlot"]
	__autoload = PLUGIN_SETTINGS["AutomaticLoad"]
	
	# Closing the file since it's not useful anymore.
	file.close()
	
func get_save_file_path() -> String:
	# Returns the full save file path.
	return __save_file_path + str(__selected_save_slot) + ".dat"
	
func get_save_slot() -> int:
	# Returns the selected save slot.
	return __selected_save_slot
	
func get_autosave_interval() -> float:
	# Returns the autosave interval.
	return __autosave_interval
