{inputs, ...}: {
  flake-file.inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  flake.modules.nixos.system-base = {
    imports = with inputs.self.modules.nixos; [
      system-nix
    ];
  };

  flake.modules.darwin.system-base = {
    imports = with inputs.self.modules.darwin; [
      system-nix
    ];
  };

  flake.modules.homeManager.system-base = {
    imports = with inputs.self.modules.homeManager; [
      system-nix
    ];
  };
}
