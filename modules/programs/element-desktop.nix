{
  flake.modules.homeManager.element-desktop = {pkgs, ...}: {
    home.packages = with pkgs; [
      element-desktop
    ];
  };
}
