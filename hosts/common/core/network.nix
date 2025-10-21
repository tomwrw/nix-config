{
  lib,
  pkgs,
  ...
}: {
  networking = {
    firewall.enable = lib.mkForce true;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };
  };

  environment.systemPackages = with pkgs; [
    iwd
  ];
}
