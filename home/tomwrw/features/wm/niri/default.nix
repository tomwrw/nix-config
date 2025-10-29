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

    ../hyprlock.nix
    ../hyprpaper.nix
    ../walker.nix
    ../waybar.nix
  ];

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
    ];
  };
}
