{
  config,
  inputs,
  ...
}: {
  flake.modules.nixos.spectre = {
    system.stateVersion = "25.11";
    networking.hostName = "spectre";
    networking.domain = "home.arpa";

    imports = with inputs.self.modules.nixos; [
      desktop
      gnome
      impermanence
      kernel-cachyos
      tomwrw
    ];
  };

  flake.nixosConfigurations = config.flake.lib.mkNixos "x86_64-linux" "spectre";
}
