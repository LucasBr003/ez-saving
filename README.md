# EzSaving
The Godot Plugin "EzSaving" official repository.

# Description
The "EzSaving" plugin for Godot is your streamlined solution for managing game save and load systems with ease. Designed for simplicity and efficiency, this plugin empowers developers to effortlessly incorporate save functionality into their projects. With a user-friendly interface and intuitive workflows, creating, managing, and loading saved game data has never been more straightforward.

***Key Features***:
+ **Simplified User Interface**: Enjoy an intuitive and clutter-free interface that simplifies the process of configuring and managing game saves.
+ **Effortless Setup**: Quickly set up save slots, load on start options, and automatic saving with just a few clicks.
+ **Intuitive Nodes**: Easily add and customize specialized nodes to control saved data within your game scenes.
+ **Real-Time Feedback**: Visual indicators and feedback mechanisms provide real-time information on save and load operations.
+ **Documentation & Examples**: Comprehensive documentation and practical examples guide you through the process, ensuring a smooth integration of save functionality.
+ **Performance Optimization**: The plugin is designed with performance in mind, ensuring efficient data handling during save and load operations.
  
Elevate your game development experience with "EzSaving" and simplify the complex task of managing saved game data. Start enhancing your players' experiences today!

# How to Install the "EzSaving" Plugin from the Godot Asset Library.

Installing the "EzSaving" plugin for Godot is a straightforward process using the Godot Asset Library. Follow these simple steps to get started:

1. **Open Your Godot Project**:
   + Launch the Godot Engine and open the project where you want to install the "EzSaving" plugin.

2. **Access the Asset Library**:
   + In the Godot editor, navigate to the top menu and click on "AssetLib."

3. **Search for "EzSaving"**:
   + In the Asset Library window, use the search bar and type "EzSaving" to find the plugin.

4. **Install the Plugin**:
   + Once you locate the "EzSaving" plugin, click on it to open its page. Here, you can view details about the plugin and its documentation.
To install the plugin, click the "Install" button on the right-hand side of the page.

5. **Configure the Plugin**:
   + After installation, return to your project. The "EzSaving" plugin should now be available in your project settings.
Configure the plugin according to your project's needs, following the provided documentation.

6. **Start Using "EzSaving"**:
   + With the plugin installed and configured, you're ready to start implementing powerful save and load systems in your game.

![Installation1](https://github.com/LucasBr003/ez-saving/assets/94023123/18ade31b-4900-4d37-97d7-55eb0e843f1d)

That's it! You've successfully installed the "EzSaving" plugin for Godot, and you can now take advantage of its features to enhance your game development experience.

# Configuring the "EzSaving" Plugin

Once the plugin is correctly installed, you should see a new tab labeled "EzSaving" next to the "AssetLib" tab. Click on it to access the plugin's interface, where you'll find several basic configuration options:

![Configuration1](https://github.com/LucasBr003/ez-saving/assets/94023123/293da957-7741-48ae-81f2-4e0dccfe856c)
![Configuration2](https://github.com/LucasBr003/ez-saving/assets/94023123/d1aa61e9-2886-4f9b-acdc-aae0d9a500ad)

1. ***Save File Path***:
+ This setting determines where the save files will be stored. By default, the files are saved in `user://save`. 

> [!NOTE]
> There is no file extension provided here because the plugin automatically handles it.

> [!IMPORTANT]
> Be aware that the `user://` prefix is used instead of `res://`. Using `res://` would save files within the game's assets, which is not what we want. We want the files to be saved on the player's computer.

> [!WARNING]
> Ensure that the directory where the files will be saved already exists. If you configure the files to be saved in a folder that doesn't exist, the plugin won't automatically create the folder, so be careful to prevent errors.

2. ***Selected Save Slot***:
   + This setting determines which file will be used to save the game, or which file will be loaded, allowing players to save at various points in a game or project and return to any of them without affecting other saves. There is no limit to the number of save slots available.

3. ***Enable Automatic Saving***:
   + When this option is enabled, the plugin will automatically save the game or project at regular intervals.

4. ***Automatically Save Every ... minutes***:
   + This setting is only relevant when `Enable Automatic Saving` is active. It defines the time interval between automatic saves.

5. ***Enable Debug Prints***:
   + If this option is enabled, the plugin will output debug messages in the Godot editor's output console.

6. ***Encrypt Save***:
   + When this option is enabled, the save files will be encrypted with a special password (unknown to the user, to you and to me) to prevent manual tampering by players. If you want to know the password, use `print(OS.get_unique_id)`.

> [!NOTE]
> It's highly recommended to disable this option during game or project development to facilitate easier manipulation of game progress. However, it should be enabled when releasing the game to prevent unwanted player interference.

By configuring these options in the "EzSaving" plugin interface, you can set up your save and load systems according to your project's needs.

# Defining Saved Information

To define the information that is going to be saved in your game or project, follow these steps:

1. Locate the `FileSystem` tab in Godot, which is typically situated in the bottom left corner of the Godot editor.

2. In the `FileSystem` tab, you can use the search bar at the top to quickly find the script you need. Enter the following path: `res://addons/ez_saving/objects/plugin_singleton/plugin_singleton_script.gd`. If everything is correct, a script file should be selected automatically.

3. Open the script file by double-clicking it. You will be directed to the script editor.

4. In this script file, you will find a function named `create_data` at the top. This function returns a dictionary that can be edited to specify what information should be saved. Refer to the comment above this function for guidance on how to customize this dictionary according to your game or project requirements. The function should look like this:

```
func create_data() -> Dictionary:
	# The save file data. 
	# Customize it here :) 
	# Don't touch anything else >:(
	# Feel free to create new variables inside this function.
	return {
		# Add your data here.
		
	}
```

> [!NOTE]
> You have the flexibility to create additional variables within the "create_data" function. This allows you to define and customize the information you want to save in a more efficient and tailored manner.

> [!WARNING]
> Please exercise caution when making changes to this script, as incorrect alterations may interfere with the functionality of the plugin. It's advisable to create new variables and modify the dictionary as needed while adhering to the provided structure.

![SavedData1](https://github.com/LucasBr003/ez-saving/assets/94023123/49c4344b-c500-4c6f-9b60-2841ef946895)
![SavedData2](https://github.com/LucasBr003/ez-saving/assets/94023123/17bd383e-a0ef-4b5d-b966-fcfe66a0cb2f)
![SavedData3](https://github.com/LucasBr003/ez-saving/assets/94023123/6245789c-6a77-499a-b1f9-da32a64c7d67)
![SavedData4](https://github.com/LucasBr003/ez-saving/assets/94023123/fc260ae7-6cde-4090-bc4a-be7ad239b867)

# Changing Plugin Settings in Real-time

All the plugin settings mentioned earlier can be altered in real-time during the execution of your game or project using GDScript. Some changes may be irrelevant, while others can be the key to create interesting save and load systems. To accomplish this, the plugin provides specific functions as listed below:

1. ***set_file_path(new_path: String) -> void***:
   + This function changes the directory where the file will be saved but only if the following conditions are met: the directory starts with "user://," the directory does not include the file extension, and the directory exists.

2. ***set_save_slot(new_slot: int) -> void***:
   + This function alters the "Selected File Slot," as seen previously, but only if new_slot is a positive integer.

3. ***set_autosave_interval(new_interval: int) -> void***:
   + This function changes the interval between automatic saves, but only if new_interval is a positive integer greater than 1.

4. ***toggle_automatic_saving(enabled: bool) -> void***:
   + This function enables or disables automatic saving.

5. ***toggle_encryption(enabled: bool) -> void***:
   + This function enables or disables saving with encryption.

6. ***toggle_debug_prints(enabled: bool) -> void***: 
   + This function toggles debug messages on or off.

> [!NOTE]
> Configurations changed in real-time are not reflected in the plugin's interface, meaning they will return to their original values upon restarting the game.

> [!NOTE]
> To access these functions, use the prefix "EzSaving." For example: "toggle_debug_prints(true)" becomes "EzSaving.toggle_debug_prints(true)."

> [!IMPORTANT]
> Don't use, for example, this: `EzSaving.__selected_save_slot = 6`.
> Use `EzSaving.set_save_slot(6)` instead!
> Using the provided functions to modify plugin settings is the recommended approach for several reasons:

> ***Error Handling***: These functions are designed to handle potential errors more effectively, providing built-in safeguards against unintended configuration changes.

> ***Consistency***: By using the functions, you ensure that any modifications adhere to the expected format and behavior, maintaining consistency in your project.

> ***Plugin Compatibility***: Utilizing the functions ensures compatibility with future updates or changes to the plugin's internal structure.

Overall, relying on the functions offered by the plugin for configuration modifications enhances stability and reduces the risk of unexpected issues during gameplay.

With these functions, you can dynamically adjust plugin settings during gameplay, allowing for greater flexibility and control over your save and load systems.

# Understanding EzSaving Nodes
In this section, we will take a closer look at the nodes introduced by the EzSaving plugin and understand how they function. These custom nodes are designed to streamline the process of saving and loading game data in your Godot games or projects. Let's dive into each of them to see how they can enhance your game development experience.

## Save Link ![SaveValueLinkIcon16](https://github.com/LucasBr003/ez-saving/assets/94023123/b9998162-3708-4ad5-a8d8-de0ba67c5483)
The `SaveLink` node is a powerful tool that enables the automatic synchronization of information between the saved file and a property of the parent node, or vice versa. To effectively utilize the `SaveLink`, you must configure the following four properties:

+ ***Link Mode***: This property can take one of two values: `Save Value = Property` or `Property = Save Value.`
  - When set to `Save Value = Property`, the information in the save file will have the same value as a property of the parent node.
  - Conversely, when set to `Property = Save Value`, a property of the parent node will adopt the value stored in the save file.

+ ***Parent Property***: This property defines which property of the parent node will be utilized by the `SaveLink` node.

+ ***Save Value***: This property specifies which piece of information from the saved file will be used by the `SaveLink`. It should be set to the name of a key within the dictionary stored in the saved file.

+ ***Parent Signal***: The synchronization process takes place when the parent node emits a signal with the same name as this property.

The `SaveLink` node provides a versatile way to manage data synchronization between the saved file and the parent node, allowing for dynamic updates and interactions in your game or project. It's a powerful tool for maintaining consistency and real-time connections between different aspects of your game logic.

## Save Trigger ![SaveEventListener16](https://github.com/LucasBr003/ez-saving/assets/94023123/02de639b-93ea-4f24-a6e8-3e975bd29bf3)
The `SaveTrigger` node is a versatile tool that allows you to trigger actions such as saving, loading, or resetting the saved file when the parent node emits a specific signal. To the `SaveTrigger` function effectively, you'll need to configure three essential properties:

+ ***Trigger Action***: This property determines the action to be performed by the `SaveTrigger` when activated. It can be set to one of the following values:
  - `Save`: This option instructs the `SaveTrigger` to save the current state of the game or project.
  - `Load`: Selecting this option causes the `SaveTrigger` to load the save file, restoring the game to a previous state.
  - `Reset`: Choosing this option directs the `SaveTrigger` to reset the save file to its default values.

+ ***Save Slot Override***: This property specifies which save slot will be used by the `SaveTrigger`. If the value is less than 0, the `SaveTrigger` will use the save slot selected in the plugin's settings. However, if the value is greater than or equal to 0, the `SaveTrigger` will utilize the save slot defined by this property, overriding any default selection.

+ ***Parent Signal***: The `SaveTrigger` is activated in response to the parent node emitting a signal with the same name as specified in this property. It allows for precise control and synchronization of save-related actions in your game or project.

The `SaveTrigger` node provides a seamless way to integrate saving, loading, and resetting functionality into your game logic, making it easy to manage the state of your project based on specific triggers and signals.
