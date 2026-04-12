{inputs, ...}: let
  hostname = "spectre";
in {
  flake.modules.nixos."${hostname}" = {
    system.stateVersion = "25.11";

    networking.hostName = hostname;
    networking.domain = "home.arpa";
    imports = with inputs.self.modules.nixos; [
      system-desktop
      impermanence
      kernel-cachyos
      gnome
      # Users.
      tomwrw
    ];
  };
}
