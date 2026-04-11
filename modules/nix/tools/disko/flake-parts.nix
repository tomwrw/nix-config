{inputs, ...}: {
  flake-file.inputs = {
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  imports = [inputs.disko.flakeModules.disko];
}
