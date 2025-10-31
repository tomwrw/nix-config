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

  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-dark.yaml";
    image = ../../assets/wallpaper/diner.png;
    polarity = "dark";
    targets = {
      firefox = {
        firefoxGnomeTheme.enable = true;
        profileNames = ["default"];
      };
      mako.enable = false;
      waybar.enable = false;
    };
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

  theme = {
    borderWidth = 2.0;
    borderRadius = 0.0;
  };

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
