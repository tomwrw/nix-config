{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    fractal
  ];

  home.persistence."/persist" = {
    directories = [
      ".config/fractal"
      ".local/share/fractal/"
    ];
    files = [
    ];
  };
}
