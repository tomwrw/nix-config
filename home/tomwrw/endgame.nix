{
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Import my global Home Manager configs. These are configs
    # I apply to all my Home Manager hosts for this user.
    ./global
    # Import my features for the user on this host.
    ./features/bitwarden.nix
    ./features/claude-code.nix
    ./features/code-cursor.nix
    ./features/cryptomator.nix
    ./features/digikam.nix
    ./features/element-desktop.nix
    ./features/ente.nix
    ./features/filen-desktop.nix
    ./features/firefox.nix
    ./features/gemini.nix
    ./features/hugo.nix
    ./features/joplin.nix
    ./features/obsidian.nix
    ./features/signal-desktop.nix
    ./features/spicetify.nix
    ./features/syncthing.nix
    ./features/terraform.nix
    ./features/vesktop.nix
    ./features/vscodium.nix
    ./features/whatsapp.nix
    # Import my desktop/window manager/compositor.
    ./features/wm/gnome/gnome.nix
  ];
  # Set up my Home Manager instance.
  home = {
    stateVersion = lib.mkDefault "25.11";
  };
  # Set up theming for this user on this host using stylix.
  # This is important as I refer to stylix lib and colors
  # throughout many modules within this configuration.
  stylix = {
    # Set up the initial stylix config.
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
    image = ../../assets/wallpaper/hanged-man-tree.png;
    polarity = "dark";
    # Set my cursor preferences.
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 20;
    };
    # Set my font preferences for the user on this host.
    fonts = {
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
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
}
