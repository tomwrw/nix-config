{
  lib,
  pkgs,
  ...
}: {
  # Enable the firewall and network manager. Firewall
  # rules are added in any module that requires
  # a specific exception.
  networking = {
    firewall.enable = lib.mkForce true;
    networkmanager = {
      enable = true;
    };
  };
}
