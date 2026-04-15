{
  flake.modules.homeManager.ente-desktop = {pkgs, ...}: {
    home.packages = with pkgs; [
      ente-desktop
    ];
  };
}
