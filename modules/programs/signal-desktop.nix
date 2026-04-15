{
  flake.modules.homeManager.signal-desktop = {pkgs, ...}: {
    home.packages = with pkgs; [
      signal-desktop
    ];
  };
}
