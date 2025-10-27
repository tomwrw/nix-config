{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  #nix-colors,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    # Import my global Home Manager configs. These are configs
    # I apply to all my Home Manager users and all sit within
    # the cli subfolder..
    ./global
    # Import my features for the user on this host. This can
    # either be the folder itself (all contents imported via
    # the included default.nix) or individual nix files wihin
    # each feature subfolder if I want to be selective.
    ./features/comms
    ./features/development/vscodium.nix
    ./features/productivity
    # Import my desktop/window manager/compositor.
    ./features/wm/niri
  ];

  colorScheme = inputs.nix-colors.colorSchemes.tokyo-night-dark;

  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-dark.yaml";
    image = ../../assets/wallpaper/lakeside.png;
    polarity = "dark";
    targets = {
      alacritty.enable = true;
    };
  };

  theme = {
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
