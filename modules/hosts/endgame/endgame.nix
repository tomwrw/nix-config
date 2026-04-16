{
  config,
  inputs,
  ...
}: {
  flake.modules.nixos.endgame = {
    system.stateVersion = "25.11";
    networking.hostName = "endgame";
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

    home-manager.users.tomwrw.imports = with inputs.self.modules.homeManager; [spotify];
  };

  flake.nixosConfigurations = config.flake.lib.mkNixos "x86_64-linux" "endgame";
}
