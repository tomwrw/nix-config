{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports = [
    # Import my global Home Manager configs. These are configs
    # I apply to all my Home Manager users and all sit within
    # the cli subfolder..
    ./global
    # Import my features for the user on this host.
    ./features/comms/element-desktop.nix
    ./features/comms/signal-desktop.nix
    ./features/comms/vesktop.nix
    ./features/development/code-cursor.nix
    ./features/development/hugo.nix
    ./features/development/terraform.nix
    ./features/development/vscodium.nix
    ./features/media/digikam.nix
    ./features/media/spicetify.nix
    ./features/productivity/bitwarden.nix
    ./features/productivity/ente.nix
    ./features/productivity/firefox.nix
    ./features/productivity/obsidian.nix
    # Import my desktop/window manager/compositor.
    ./features/wm/niri/niri.nix
  ];

  # Set up theming for this user on this host using stylix.
  # This is important as I refer to stylix lib and colors
  # throughout many modules within this configuration.
  stylix = {
    # Set up the initial stylix config.
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-dark.yaml";
    image = ../../assets/wallpaper/diner.png;
    polarity = "dark";
    # Set up firefox target and disable any targets that
    # use custom coloring in the module itself.
    targets = {
      firefox = {
        firefoxGnomeTheme.enable = true;
        profileNames = ["default"];
      };
      mako.enable = false;
      waybar.enable = false;
    };
    # Set my theme preferences for the user on this host.
    fonts = {
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      monospace = {
        package = pkgs.nerd-fonts.dejavu-sans-mono;
        name = "CaskaydiaMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.source-han-sans;
        name = "Source Han Sans SC";
      };
      serif = {
        package = pkgs.source-han-serif;
        name = "Source Han Serif SC";
      };
    };
  };

  # Use my custom theme module to supply additional
  # theme options that are not currently covered
  # within stylix.
  theme = {
    borderWidth = 2.0;
    borderRadius = 0.0;
  };

  # Set up the monitos for this host.
  monitors = [
    {
      name = "Virtual-1";
      width = 1920;
      height = 1080;
      refreshRate = 60.0;
      scale = 1.0;
      workspace = "1";
      primary = true;
    }
  ];
}
