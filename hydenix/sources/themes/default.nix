{ pkgs }:
let
  mkTheme = import ./utils/mkTheme.nix { inherit pkgs; };
  # Helper function to call each theme file with pkgs and mkTheme
  callTheme = file: import file { inherit pkgs mkTheme; };
in
{

  "1-Bit" = callTheme ./1-Bit.nix;
  "Abyssal-Wave" = callTheme ./Abyssal-Wave.nix;
  "AbyssGreen" = callTheme ./AbyssGreen.nix;
  "Amethyst-Aura" = callTheme ./Amethyst-Aura.nix;
  "AncientAliens" = callTheme ./AncientAliens.nix;
  "Another World" = callTheme ./Another-World.nix;
  "Bad Blood" = callTheme ./Bad-Blood.nix;
  "BlueSky" = callTheme ./BlueSky.nix;
  "Breezy Autumn" = callTheme ./Breezy-Autumn.nix;
  "Cat Latte" = callTheme ./Cat-Latte.nix;
  "Catppuccin Latte" = callTheme ./Catppuccin-Latte.nix;
  "Catppuccin-Macchiato" = callTheme ./Catppuccin-Macchiato.nix;
  "Catppuccin Mocha" = callTheme ./Catppuccin-Mocha.nix;
  "Code Garden" = callTheme ./Code-Garden.nix;
  "Cosmic Blue" = callTheme ./Cosmic-Blue.nix;
  "Crimson Blade" = callTheme ./Crimson-Blade.nix;
  "Crimson-Blue" = callTheme ./Crimson-Blue.nix;
  "Decay Green" = callTheme ./Decay-Green.nix;
  "DoomBringers" = callTheme ./DoomBringers.nix;
  "Dracula" = callTheme ./Dracula.nix;
  "Edge Runner" = callTheme ./Edge-Runner.nix;
  "Electra" = callTheme ./Electra.nix;
  "Eternal Arctic" = callTheme ./Eternal-Arctic.nix;
  "Ever Blushing" = callTheme ./Ever-Blushing.nix;
  "Frosted Glass" = callTheme ./Frosted-Glass.nix;
  "Graphite Mono" = callTheme ./Graphite-Mono.nix;
  "Green Lush" = callTheme ./Green-Lush.nix;
  "Greenify" = callTheme ./Greenify.nix;
  "Grukai" = callTheme ./Grukai.nix;
  "Gruvbox Retro" = callTheme ./Gruvbox-Retro.nix;
  "Hack the Box" = callTheme ./Hack-the-Box.nix;
  "Ice Age" = callTheme ./Ice-Age.nix;
  "Joker" = callTheme ./Joker.nix;
  "LimeFrenzy" = callTheme ./LimeFrenzy.nix;
  "Mac OS" = callTheme ./Mac-OS.nix;
  "Material Sakura" = callTheme ./Material-Sakura.nix;
  "Monokai" = callTheme ./Monokai.nix;
  "Monterey Frost" = callTheme ./Monterey-Frost.nix;
  "Moonlight" = callTheme ./Moonlight.nix;
  "Nightbrew" = callTheme ./Nightbrew.nix;
  "Nordic Blue" = callTheme ./Nordic-Blue.nix;
  "Obsidian-Purple" = callTheme ./Obsidian-Purple.nix;
  "One Dark" = callTheme ./One-Dark.nix;
  "Oxo Carbon" = callTheme ./Oxo-Carbon.nix;
  "Paranoid Sweet" = callTheme ./Paranoid-Sweet.nix;
  "Peace Of Mind" = callTheme ./Peace-Of-Mind.nix;
  "Pixel Dream" = callTheme ./Pixel-Dream.nix;
  "Rain Dark" = callTheme ./Rain-Dark.nix;
  "Red Stone" = callTheme ./Red-Stone.nix;
  "Rosé Pine" = callTheme ./Rose-Pine.nix;
  "Scarlet Night" = callTheme ./Scarlet-Night.nix;
  "Sci-fi" = callTheme ./Sci-fi.nix;
  "Solarized Dark" = callTheme ./Solarized-Dark.nix;
  "Synth Wave" = callTheme ./Synth-Wave.nix;
  "Timeless Dream" = callTheme ./Timeless-Dream.nix;
  "Tokyo Night" = callTheme ./Tokyo-Night.nix;
  "Tundra" = callTheme ./Tundra.nix;
  "Vanta Black" = callTheme ./Vanta-Black.nix;
  "Windows 11" = callTheme ./Windows-11.nix;
}
