# Ez Saving
The Godot Plugin "EzSaving" official repository.

# Description
"EzSaving" is a versatile Godot engine plugin designed to streamline and simplify the management of save and load systems in your game. With its user-friendly features, it empowers developers to effortlessly implement multiple save files, allowing players to store and retrieve their progress independently. This plugin ensures a seamless and flexible approach to handling game saves, enhancing the overall player experience while providing the convenience of multiple save slots.

> [!NOTE]
> While EzSaving streamlines the process of loading and saving in a game, it may seem a bit complex at first for newcomers. We recommend taking some time to explore the documentation and examples to fully grasp its capabilities and make the most of this powerful tool. > Once you're familiar with it, you'll find that EzSaving significantly simplifies the management of game data and enhances the player experience

# Getting Started: New Tab
To get started with EzSaving, let's take a look at the tab it adds at the top of the engine, where you'll find the basic configuration settings for the plugin. This is your starting point for setting up and customizing the plugin to suit your game's saving and loading needs.

![NewTab](https://github.com/LucasBr003/ez-saving/assets/94023123/6f44cb34-3df8-426c-b901-08476ffc679b)

Now, let's dive into the basic plugin settings found within the newly added tab. These settings provide you with the foundation for configuring the plugin to meet your specific saving and loading requirements. Let's explore them in detail.

![PluginUI](https://github.com/LucasBr003/ez-saving/assets/94023123/bd089e5f-dbbb-4eb8-9e60-8b7e4ca8b9ae)

### Save File Path:
The `Save File Path` option determines the directory where player's saved files will be stored. It's crucial to use `user://` instead of `res://` to ensure that files are saved on the player's computer rather than within the game's files. Additionally, there's no need to specify the file extension, as the plugin handles this automatically.

### Selected Save Slot:
The `Selected Save Slot` option governs which file will be used for upcoming save operations. One remarkable feature of EzSaving is its support for an unlimited number of save files, allowing players to create numerous unique save points. This approach empowers players to manage their progress as they see fit, much like in games where players can choose the slot to save their game, giving players the flexibility to tailor their game-saving experience according to their preferences."

### Enable Automatic Saving & Automatically Save Every ... Minutes
The options `Enable Automatic Saving` and `Automatically Save Every ... minutes` are interconnected. The second option becomes relevant only when the first one is enabled. If you activate the `Enable Automatic Saving` option, the plugin will automatically save the game at regular intervals, as defined by the `Automatically Save Every ... minutes` setting. The plugin will use the `Selected Save Slot` option to determine where the file should be saved, ensuring a hassle-free automatic saving experience for players."

### Enable Debug Prints
The `Enable Debug Prints` option, when activated, instructs the plugin to send debugging messages to the Engine's output, simplifying the debugging process. Please note that these messages are generated only when this option is enabled.

### Reset Save on Start
The `Reset Save on Start` option, when activated, resets the player's saved file each time the game or project begins. This feature is particularly useful for debugging, as it ensures that the game isn't affected by the saved file, effectively restarting it upon launch when this option is enabled.

# Custom Nodes
The plugin introduces several new nodes, and we will now take a closer look at each of these nodes added by the plugin. This will help you understand how to effectively utilize these nodes to enhance your game's saving and loading capabilities.

![CustomNodes](https://github.com/LucasBr003/ez-saving/assets/94023123/a60294d9-609a-4a4f-b2e2-4332ce499b55)

## Save ![SaveCategoryIcon16](https://github.com/LucasBr003/ez-saving/assets/94023123/06922a97-77a0-4f08-a36b-3707c0951619)
The `Save` node serves a purely organizational purpose and does not execute any specific actions within your game logic. Its primary function is to add a new category within the `Add Node` tab in the Godot scene editor, helping you keep your project neatly organized.

## SaveDataHolder ![SaveResourceIcon16](https://github.com/LucasBr003/ez-saving/assets/94023123/ccb0ce3d-fba6-4514-84a5-789f4b057d1d)
As a developer, you'll find the `SaveDataHolder` node to be an essential component in your game's loading process. This node serves as the bridge between your saved files and your game's logic, dictating how these files should be loaded and which data to incorporate into your game. Let's delve into its properties:

+ Save File Type: This property is instrumental in determining whether the `SaveDataHolder` node will load a global file or a normal file. Understanding the distinction between these file types is crucial:

  - Global File Type: These files store data that remains consistent across all game saves. For example, global settings, configurations, or unlocked content. If you set `Save File Type` to `Global`, the node will load these universally applicable data points.

  - Normal File Type: These files represent individual game saves, capturing the unique progress and choices made by players. When you select `Save File Type` as `Normal`, the node is configured to load data specific to a particular game save.

+ Data: The `Data` property serves as a container, holding game-related information in the form of a dictionary. This dictionary structure provides a flexible way to organize and manage your game's saved data. When a saved file is loaded, the node refers to this `Data` property to determine which variables and values should be populated. Here's how it works:

  - Matching Data: If the saved file contains data that corresponds precisely to the keys and structure defined within the `Data` dictionary, those values will be loaded into your game as is.

  - Missing Data: If the saved file lacks specific data or variables defined in `Data`, the `SaveDataHolder` node handles this situation gracefully. It uses the default values you've established within 'Data' to fill in the gaps. This ensures that your game continues to function even if some data is missing from a save file.
 
![SaveDataHolderInspector](https://github.com/LucasBr003/ez-saving/assets/94023123/6ad2181b-cdfb-4560-8619-e1b5ece882fb)

> [!IMPORTANT]
> As the name of this node says, the `SaveDataHolder` node is a critical component in the loading process, but it requires the collaboration of another node, which we will explain in more detail later, to actually facilitate the loading of saved files.
> Together, these nodes enable you to seamlessly integrate saved data into your game.

## SaveLoader ![SaveLoaderIcon16](https://github.com/LucasBr003/ez-saving/assets/94023123/577a9a93-caf5-434c-94e2-ae288684dc30)

The `SaveLoader` node is responsible for the crucial task of loading saved files. However, it doesn't operate in isolation. It requires the presence of two `SaveDataHolder`s nodes as its children, with one configured as `Global` and the other as `Normal`. This configuration ensures the seamless integration of global and specific save data.

This node offers two editable properties in the inspector: `Load on Start` and `Save Slot`.

+ Load on Start: When enabled, this option automates the loading of saved files using the two `SaveDataHolder` nodes as its children. However, it's essential to understand that this convenience may limit the full potential of the `SaveLoader`. It results in the automatic loading of the game, potentially restricting opportunities for more dynamic and engaging game-loading experiences that we'll explore later.

+ Save Slot: The `Save Slot` property functions similarly to the equivalent setting in the plugin's basic configuration. If the property here conflicts with the configuration in the plugin, the `SaveLoader` node will temporarily override the plugin's settings. This dynamic adjustment allows for flexibility during gameplay but doesn't permanently alter the plugin's setup. It's important to note that these changes revert to the original plugin configuration when the game window is closed.

> [!IMPORTANT]
> The `SaveLoader` node's true power emerges when paired with another node we will introduce shortly. Together, they unlock more robust and customizable loading capabilities, enabling you to create diverse and engaging gameplay experiences for your players.

> [!WARNING]
> It's crucial to adhere to the setup of child nodes within a `SaveLoader` node meticulously to ensure smooth and error-free operation. Any deviations from the prescribed configuration may lead to unexpected issues in the functionality of the node. Pay close attention to the specifications outlined in the node's documentation to ensure its seamless integration into your game.

## SaveSignalListener
The `SaveSignalListener` node possesses a unique capability—it can listen to signals emitted by its parent node, responding to these signals by performing specific actions related to saved files. Let's explore its key properties and functionality:

+ Signal Property: The `Signal` property plays a pivotal role in defining the behavior of the `SaveSignalListener`. You should populate this property with the name of a signal that the parent node can emit. When the parent node emits a signal matching the name specified in the `Signal` property, the `SaveSignalListener` will initiate an action associated with saved files based on the `Action` property.

+ Action Property: The `Action` property determines the specific action the `SaveSignalListener` should execute when the designated signal is emitted. Depending on the value assigned to this property, the node can trigger actions such as saving or loading game data. This dynamic behavior allows for versatile interactions within your game.

> [!IMPORTANT] 
> It's important to note that if you configure the 'SaveSignalListener' to load a saved file, you must specify a `SaveLoader` node from the scene in the `Save Loader` property. Additionally, you have the flexibility to override the `Save Slot` property of the selected `SaveLoader` node by using the `Save Slot Override` property of the `SaveSignalListener`. This level of control enables you to fine-tune the loading process as needed for your game.

> [!NOTE]
> Here are some scenarios where `SaveSignalListener` can be effectively employed:

+ Checkpoint Systems: You can use `SaveSignalListener` to create checkpoint systems where specific events, like when an `Area2D` or a `CharacterBody` enters another `Area2D`, you can set an `Area2D` to be the `SaveSignalListener`'s parent and use the signal `area_entered` or `body_entered`, for example.

+ Quest Completion: Implement `SaveSignalListener` to manage the saving and loading of quest progress. For instance, when a quest is completed, emit a signal that prompts the `SaveSignalListener` to save the updated quest data.

+ Inventory Management: Use this node to handle inventory updates. Emit a signal when an item is added or removed from the player's inventory, and let the `SaveSignalListener` manage the corresponding save operations.

By harnessing the power of `SaveSignalListener`, you can add dynamic and responsive saving and loading functionality to your game, enhancing the player experience while maintaining granular control over data management.

# Loading
Now that we've explored the key plugin settings, let's dive into using it, starting with a simple system for loading saved files. This will serve as a fundamental step in implementing saving and loading functionality into your game. Don't worry, we'll be covering Saving Systems later on.
