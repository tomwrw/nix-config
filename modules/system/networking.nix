{
  flake.modules.nixos.networking = {lib, ...}: {
    networking = {
      firewall.enable = lib.mkForce true;
      networkmanager.enable = true;
    };
  };
}
