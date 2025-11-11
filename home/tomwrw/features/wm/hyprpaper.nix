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
    };
  };
}
