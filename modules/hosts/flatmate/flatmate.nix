{
  config,
  inputs,
  ...
}: {
  flake.modules.nixos.flatmate = {
    system.stateVersion = "25.11";
    networking.hostName = "flatmate";
    networking.domain = "home.arpa";

    imports = with inputs.self.modules.nixos; [
      # NixOS modules to import.
      desktop
      boot
      gnome
      impermanence
      kernel-cachyos
      # User modules to import.
      tomwrw
    ];
  };

  flake.nixosConfigurations = config.flake.lib.mkNixos "x86_64-linux" "flatmate";
}
