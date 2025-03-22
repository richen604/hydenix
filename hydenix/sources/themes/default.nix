{ pkgs }:
let
  mkTheme = import ./utils/mkTheme.nix { inherit pkgs; };
  # Helper function to call each theme file with pkgs and mkTheme
  callTheme = file: import file { inherit pkgs mkTheme; };
in
{
  Abyssal-Wave = callTheme ./Abyssal-Wave.nix;
  AbyssGreen = callTheme ./AbyssGreen.nix;
  "Bad Blood" = callTheme ./Bad-Blood.nix;
  "Cat Latte" = callTheme ./Cat-Latte.nix;
  "Catppuccin Latte" = callTheme ./Catppuccin-Latte.nix;
  "Catppuccin Mocha" = callTheme ./Catppuccin-Mocha.nix;
  "Crimson Blade" = callTheme ./Crimson-Blade.nix;
  "Decay Green" = callTheme ./Decay-Green.nix;
  "Dracula" = callTheme ./Dracula.nix;
  "Edge Runner" = callTheme ./Edge-Runner.nix;
  "Frosted Glass" = callTheme ./Frosted-Glass.nix;
  "Graphite Mono" = callTheme ./Graphite-Mono.nix;
  "Green Lush" = callTheme ./Green-Lush.nix;
  "Greenify" = callTheme ./Greenify.nix;
  "Gruvbox Retro" = callTheme ./Gruvbox-Retro.nix;
  "Hack the Box" = callTheme ./Hack-the-Box.nix;
  "Ice Age" = callTheme ./Ice-Age.nix;
  "Mac OS" = callTheme ./Mac-OS.nix;
  "Material Sakura" = callTheme ./Material-Sakura.nix;
  "Monokai" = callTheme ./Monokai.nix;
  "Monterey Frost" = callTheme ./Monterey-Frost.nix;
  "Nordic Blue" = callTheme ./Nordic-Blue.nix;
  "One Dark" = callTheme ./One-Dark.nix;
  "Oxo Carbon" = callTheme ./Oxo-Carbon.nix;
  "Paranoid Sweet" = callTheme ./Paranoid-Sweet.nix;
  "Pixel Dream" = callTheme ./Pixel-Dream.nix;
  "Rain Dark" = callTheme ./Rain-Dark.nix;
  "Red Stone" = callTheme ./Red-Stone.nix;
  "Rosé Pine" = callTheme ./Rose-Pine.nix;
  "Scarlet Night" = callTheme ./Scarlet-Night.nix;
  "Sci-fi" = callTheme ./Sci-fi.nix;
  "Solarized Dark" = callTheme ./Solarized-Dark.nix;
  "Synth Wave" = callTheme ./Synth-Wave.nix;
  "Tokyo Night" = callTheme ./Tokyo-Night.nix;
  "Vanta Black" = callTheme ./Vanta-Black.nix;
  "Windows 11" = callTheme ./Windows-11.nix;
  "Another World" = callTheme ./Another-World.nix;
  "BlueSky" = callTheme ./BlueSky.nix;
  "Cosmic Blue" = callTheme ./Cosmic-Blue.nix;
  "DoomBringers" = callTheme ./DoomBringers.nix;
  "Eternal Artic" = callTheme ./Eternal-Artic.nix;
  "Ever Blushing" = callTheme ./Ever-Blushing.nix;
  "Moonlight" = callTheme ./Moonlight.nix;
}
