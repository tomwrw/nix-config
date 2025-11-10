{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    ./autostart.nix
    ./binds.nix
    ./outputs.nix
    ./settings.nix
    ./windowrules.nix

    # ../hypridle.nix
    # ../hyprlock.nix
    ../hyprpaper.nix
    # ../mako.nix
    # ../satty.nix
    ../wofi.nix
    ../waybar.nix
  ];

  # xdg.configFile."electron-flags.conf".text = ''
  #   --enable-features=UseOzonePlatform
  #   --ozone-platform=wayland
  # '';

  xdg.portal = {
    enable = true;
    config = {
      common = {
        #default = ["gtk" "gnome" "gnome-keyring"];
        default = ["gtk" "gnome"];
      };
      niri = {
        #default = ["gtk" "gnome" "gnome-keyring"];
        default = ["gtk" "gnome"];
      };
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      #gnome-keyring
    ];
    xdgOpenUsePortal = true;
  };

  home = {
    packages = with pkgs; [
      nemo
      # xwayland-satellite
      # pavucontrol
      # seatd
      # jaq
      impala
      iwd
      blueberry
      wiremix
      pamixer
      # nautilus
      # wl-clipboard
      # cliphist
      # xclip
      # gnome-keyring
      # seahorse
      # grim
      # slurp
    ];
  };
}
