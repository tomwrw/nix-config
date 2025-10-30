{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.niri.homeModules.niri
    ./settings.nix
    ./binds.nix
    ./rules.nix

    ../hypridle.nix
    ../hyprlock.nix
    ../hyprpaper.nix
    ../mako.nix
    ../satty.nix
    ../wofi.nix
    ../waybar.nix
  ];

  xdg.configFile."electron-flags.conf".text = ''
    --enable-features=UseOzonePlatform
    --ozone-platform=wayland
  '';

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = ["gtk" "gnome" "gnome-keyring"];
      };
      niri = {
        default = ["gtk" "gnome" "gnome-keyring"];
      };
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      gnome-keyring
    ];
    xdgOpenUsePortal = true;
  };

  home = {
    packages = with pkgs; [
      xwayland-satellite
      pavucontrol
      seatd
      jaq
      impala
      iwd
      blueberry
      wiremix
      pamixer
      nautilus
      wl-clipboard
      cliphist
      xclip
      gnome-keyring
      seahorse
      grim
      slurp
      #satty
    ];
  };
}
