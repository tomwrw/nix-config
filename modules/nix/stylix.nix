{inputs, ...}: {
  flake-file.inputs.stylix.url = "github:danth/stylix";

  flake.modules.homeManager.stylix = {
    imports = [inputs.stylix.homeModules.stylix];
  };
}
