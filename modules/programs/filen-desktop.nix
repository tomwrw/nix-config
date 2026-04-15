{
  flake.modules.homeManager.filen-desktop = {pkgs, ...}: {
    home.packages = with pkgs; [
      filen-desktop
    ];
  };
}
