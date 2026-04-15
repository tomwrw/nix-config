{
  flake.modules.homeManager.ente-auth = {pkgs, ...}: {
    home.packages = with pkgs; [
      ente-auth
    ];
  };
}
