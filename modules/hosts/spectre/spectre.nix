{
  config,
  inputs,
  ...
}: {
  flake.modules.nixos.spectre = {
    system.stateVersion = "26.05";
    networking.hostName = "spectre";
    networking.domain = "home.arpa";

    imports = with inputs.self.modules.nixos; [
      # NixOS modules to import.
      desktop
      gaming
      gnome
      impermanence
      kernel-cachyos
      lanzaboote
      virt-manager
      # User modules to import.
      tomwrw
    ];
  };

  flake.nixosConfigurations = config.flake.lib.mkNixos "x86_64-linux" "spectre";
}
