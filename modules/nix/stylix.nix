{inputs, ...}: {
  flake-file.inputs = {
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.homeManager.stylix = {
    imports = [inputs.stylix.homeModules.stylix];
  };
}
