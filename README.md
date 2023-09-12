# Ez Saving
The Godot Plugin "EzSaving" official repository.

# Description
"EzSaving" is a versatile Godot engine plugin designed to streamline and simplify the management of save and load systems in your game. With its user-friendly features, it empowers developers to effortlessly implement multiple save files, allowing players to store and retrieve their progress independently. This plugin ensures a seamless and flexible approach to handling game saves, enhancing the overall player experience while providing the convenience of multiple save slots.

**Disclaimer**: While EzSaving streamlines the process of loading and saving in a game, it may seem a bit complex at first for newcomers. We recommend taking some time to explore the documentation and examples to fully grasp its capabilities and make the most of this powerful tool. Once you're familiar with it, you'll find that EzSaving significantly simplifies the management of game data and enhances the player experience

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

# Loading
Now that we've explored the key plugin settings, let's dive into using it, starting with a simple system for loading saved files. This will serve as a fundamental step in implementing saving and loading functionality into your game. Don't worry, we'll be covering Saving Systems later on.
