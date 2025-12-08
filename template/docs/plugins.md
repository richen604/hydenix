<img align="right" width="75px" alt="NixOS" src="https://github.com/HyDE-Project/HyDE/blob/master/Source/assets/nixos.png?raw=true"/>

# Hyprland Plugins

hydenix supports using [Hyprland plugins](https://wiki.hyprland.org/Plugins/Using-Plugins/) to extend the functionality of your Hyprland desktop environment.

## Adding Plugins

To use Hyprland plugins in hydenix, you'll need to:

1. Add the plugin to your flake inputs
2. Configure the plugin in your hyprland module

### Example Configuration

Here's how to add plugins to your configuration:

```nix
# In your flake.nix
{
  inputs = {
    # ... other inputs
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };
}
```

Then in your hydenix configuration:

```nix
{
  hydenix.hm.hyprland = {
    enable = true;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
    ];
  };
}
```

This approach ensures that plugins are always built with the same version of Hyprland you're using, preventing version mismatch issues.

## Available Plugins

Commonly used plugins include:

- `hyprbars` - Adds title bars to windows
- `hyprexpo` - Provides a workspace overview
- `hyprwinwrap` - Displays a wallpaper on a specific window
- `hyprtrails` - Shows trails behind moving windows
- `hyprgrass` - Adds touchpad gestures
- `hyprscrolling` - Implements custom scrolling behavior

Check the [official hyprland-plugins repository](https://github.com/hyprwm/hyprland-plugins) for a complete list.

## Plugin Configuration

After adding a plugin, you can configure it in your Hyprland configuration files. For example, for hyprbars:

```
plugin {
  hyprbars {
    bar_height = 20
    col.active = rgba(505050ff)
    col.inactive = rgba(303030ff)
  }
}
```

You can add this configuration to `hydenix.hm.hyprland.extraConfig` or directly in your Hyprland config files.