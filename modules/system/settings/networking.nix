{
  flake.modules.nixos.system-networking = {lib, ...}: {
    networking = {
      firewall = {
        enable = lib.mkForce true;
        allowedTCPPorts = [22000];
        allowedUDPPorts = [22000 21027];
      };
      networkmanager.enable = true;
    };
  };

  flake.modules.darwin.system-networking = {
    networking.dns = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };
}
