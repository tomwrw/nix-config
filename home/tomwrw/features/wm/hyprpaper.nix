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
      preload = [
        "${config.stylix.image}"
      ];

      wallpaper = [
        ",${config.stylix.image}"
      ];
    };
  };
}
