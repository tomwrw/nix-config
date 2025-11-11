{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    bitwarden-desktop
    bitwarden-cli
  ];

  home.persistence."/persist" = {
    directories = [
      ".config/Bitwarden"
    ];
    files = [
    ];
  };
}
