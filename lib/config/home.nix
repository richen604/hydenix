{ ... }:
{

  hydenix.hm = {
    enable = true;

    theme = {
      enable = true;
      active = "BlueSky";
      themes = [
        "Abyssal-Wave"
        "AbyssGreen"
        "AncientAliens"
        "Amethyst-Aura"
        "Bad Blood"
        "Cat Latte"
        "Catppuccin Latte"
        "Catppuccin Mocha"
        "Code Garden"
        "Crimson Blade"
        "Crimson-Blue"
        "Decay Green"
        "Dracula"
        "Edge Runner"
        "Electra"
        "Frosted Glass"
        "Graphite Mono"
        "Green Lush"
        "Greenify"
        "Gruvbox Retro"
        "Grukai"
        "Hack the Box"
        "Ice Age"
        "LimeFrenzy"
        "Mac OS"
        "Material Sakura"
        "Monokai"
        "Monterey Frost"
        "Nordic Blue"
        "Nightbrew"
        "Obsidian-Purple"
        "One Dark"
        "Oxo Carbon"
        "Paranoid Sweet"
        "Pixel Dream"
        "Peace Of Mind"
        "Rain Dark"
        "Red Stone"
        "Rosé Pine"
        "Scarlet Night"
        "Sci-fi"
        "Solarized Dark"
        "Synth Wave"
        "Tundra"
        "Tokyo Night"
        #FIXME: theme conflicts with material sakura that wont fix
        "Vanta Black"
        "Windows 11"

        "Another World"
        "BlueSky"
        "Cosmic Blue"
        "DoomBringers"
        "Eternal Arctic"
        "Ever Blushing"
        "Moonlight"

        # Testing that we can add a new string and it won't fail
        "Some Theme"
      ];
    };
  };
}
