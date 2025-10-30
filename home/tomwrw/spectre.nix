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

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;

  theme = {
    wallpaper = ../../assets/wallpaper/hanged-man-tree.png;
    borderWidth = 2.0;
    borderRadius = 0.0;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };
}
