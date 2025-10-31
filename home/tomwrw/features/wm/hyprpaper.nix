{
  config,
  lib,
  pkgs,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = false;
      # preload = [
      #   "${config.theme.wallpaper}"
      # ];

      # wallpaper = [
      #   ",${config.theme.wallpaper}"
      # ];
    };
  };
}
